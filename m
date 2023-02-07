Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFD68E47B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBGXem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBGXek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:34:40 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B55B29145
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:34:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B96E5420CF;
        Tue,  7 Feb 2023 23:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1675812876;
        bh=Xy3vMOIfFYc5nq14WL4mTN1YL0ebGR5OtV9XaHb9X74=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=P85+mHCFgZZkUVYvaKaulsowpsBFnJkG1b3TdYBVW+NZEGeZp4ul/f+mv5fcHJA/4
         4ejJ5qlgmK3pMS0k5K22tG6Yi6knLeqyET3LrsFgPobBZO84SeyHYOykHDgpSwwVN5
         5q2PWjFrHP194nqXTABYIBTQGxfu1JK7dOwCOXpCAKBz0Jd2moei6UyBkuG3F8Dps3
         ornKGGCtakFbut0SKW6dwSlhb3r90auZsVn9C4nBp8hu1Xaa88a2Srud16lQm8uZYF
         5Y3nW/c+QWkqBDI7yoHwukXI0z+NDeuXErefMrfa35h5kTOGc0Avivq7T2koEAKEr+
         L3BpzuNOCISbQ==
Message-ID: <149ac5cb-e17f-0c37-b65d-5cfa0a4d8163@asahilina.net>
Date:   Wed, 8 Feb 2023 08:34:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20230205125124.2260-1-lina@asahilina.net>
 <77be28c1-52ff-87c8-b7f7-f99273d48267@suse.de>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <77be28c1-52ff-87c8-b7f7-f99273d48267@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I accidentally sent this reply offlist! Resending, my apologies...

On 07/02/2023 20.29, Thomas Zimmermann wrote:
> Hi
> 
> Am 05.02.23 um 13:51 schrieb Asahi Lina:
>> Other functions touching shmem->sgt take the pages lock, so do that here
> 
> Really? I was just locking at the Lima driver and it apparently access 
> sgt without locking in [1]. Not that I disagree with the patch in general.

It looks like that lima code is reimplementing a lot of helper
functionality. I imagine it was written before the helpers...? I think
most of that function could be replaced with a call to
drm_gem_shmem_get_pages_sgt().

I don't know exactly how the lima driver works, but if there is a
possibility of multiple calls to lima_heap_alloc() on the same BO
without a higher-level mutex protecting it, I would say that code is racy.

For the Rust abstraction (and really for a well-designed API in general)
you want a coherent story on locking, so I think it makes sense to take
the pages lock to manipulate the sgt, since
drm_gem_shmem_get_pages_sgt() was already taking the pages lock for
inner things anyway. Otherwise it's impossible to make safe without
adding another discrete layer of locking around everything (I can't just
take the pages lock in the wrapper since drm_gem_shmem_get_pages_sgt()
would try to recursively lock it).

> Best regards
> Thomas
> 
> [1] 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/lima/lima_gem.c#L21

~~ Lina
