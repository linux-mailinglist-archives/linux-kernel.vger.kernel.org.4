Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8866A3BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjB0H4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0H4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:56:02 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47CDEF9C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:56:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C841C42404;
        Mon, 27 Feb 2023 07:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677484558;
        bh=KkBGVkl+T1va9CwpeEL7yMJF1010hMN2AAYA+6Rnmls=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AfIi3pqjK0IIm7vQQsxK1WlQIUfSOUGyPBSnZr8lbFyHEBcC0WtxP5enpbjIhZZfv
         PnWrwrGkPoYkBPepsIvBSUFC66Lb6854pSxQXjfKp/gAnA4AP6ICp8CXeU5vmKG7BF
         ZrbdBy4jFSCc/d1ub2QoTCbr1JQMIzTbRWKYoRxU+7zZEMYRV2BR2rWGfZQXt8AMey
         JSg3jGnrLqDIzQPiLPbcb7qHObgv96N5oUL2eV+4WYFSKybpodqPdIlGGmirKSqeX/
         Q2yk4GVLAo2TaKTrE7oYAq8t+wcWjsygVVFRwCl8K/vaqMpjCgdSj2hgMZXowPwwT9
         kvcVMrAUdKoSQ==
Message-ID: <e49127fb-abb9-16fc-42bd-2f380d1bd29d@asahilina.net>
Date:   Mon, 27 Feb 2023 16:55:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        asahi@lists.linux.dev
References: <20230205125124.2260-1-lina@asahilina.net>
 <eddfa36c-4553-d392-0047-313002c613d4@collabora.com>
 <cc1c34c6-18d1-a8c5-bf70-078e7b7205f8@suse.de>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <cc1c34c6-18d1-a8c5-bf70-078e7b7205f8@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 16.45, Thomas Zimmermann wrote:
> Hi
> 
> Am 25.02.23 um 22:51 schrieb Dmitry Osipenko:
>> On 2/5/23 15:51, Asahi Lina wrote:
>>> -EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages_sgt);
>>> +EXPORT_SYMBOL(drm_gem_shmem_get_pages_sgt);
>>
>> Note it was a GPL symbol. I expect that all drm-shmem exports should be GPL.
> 
> Right. I didn't notice that change, but it's probably not allowed. This 
> needs to be reverted to a GPL export

I'm sorry, this was not intentional! I think I removed and re-added the
export as part of making the wrapper and didn't notice it used to be _GPL...

Do you want me to send a patch to add it back?

~~ Lina
