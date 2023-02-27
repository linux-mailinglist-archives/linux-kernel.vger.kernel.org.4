Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667D26A3E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjB0JPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjB0JOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:14:45 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0247823119
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:07:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9042E3FA55;
        Mon, 27 Feb 2023 09:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677488863;
        bh=Hu1UiUDZneAOWvyF5UlmcAk7mfpmmxARWq2Li7lV4JM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=luigA52L7N8RNgk0yjpn7ADs9Goq2bWRnQo9vRIc/HWGJV/3PO+KKSvHIUQBJvj9j
         NQOcD8JqUqLH0aqAk6BdJwtTUDudJoP84wwc5Fgk82sxjGG5gUoXhmu4PxEOYnacl6
         ZEaR4Ctd561uBlyDC9nmKgSMIHRpTHNm8i83ZEQMuqjnkaHcAR2sKt10qiaVx50Dws
         czeVVv5XEYruxL7QdktFvDFDZJSIWGg9RWpMCgF9gTCZiTd6MGcfbNIRdHMwxcopLd
         KRi6/28D9Krk1VQeH+V+427UfcSiJTFi7fNUWwPq/P2Ie6wz3ZEI/aQ6ovdMuSiNr1
         eCLYaEtN7rKTg==
Message-ID: <ad89998c-0ede-72da-b8e6-fe1de0f009f1@asahilina.net>
Date:   Mon, 27 Feb 2023 18:07:38 +0900
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
 <e49127fb-abb9-16fc-42bd-2f380d1bd29d@asahilina.net>
 <3d94a119-dc83-aede-fd39-df7a3ee7cdc0@suse.de>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <3d94a119-dc83-aede-fd39-df7a3ee7cdc0@suse.de>
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

On 27/02/2023 17.04, Thomas Zimmermann wrote:
> Hi
> 
> Am 27.02.23 um 08:55 schrieb Asahi Lina:
>> On 27/02/2023 16.45, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 25.02.23 um 22:51 schrieb Dmitry Osipenko:
>>>> On 2/5/23 15:51, Asahi Lina wrote:
>>>>> -EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages_sgt);
>>>>> +EXPORT_SYMBOL(drm_gem_shmem_get_pages_sgt);
>>>>
>>>> Note it was a GPL symbol. I expect that all drm-shmem exports should be GPL.
>>>
>>> Right. I didn't notice that change, but it's probably not allowed. This
>>> needs to be reverted to a GPL export
>>
>> I'm sorry, this was not intentional! I think I removed and re-added the
>> export as part of making the wrapper and didn't notice it used to be _GPL...
>>
>> Do you want me to send a patch to add it back?
> 
> Yes, please do. The Fixes tag is
> 
>    Fixes: ddddedaa0db9 ("drm/shmem-helper: Fix locking for 
> drm_gem_shmem_get_pages_sgt()")
> 
> This commit is in drm-misc-next-fixes. But the branch is closed already 
> as we're in the middle of the merge window. I think it's best to merge 
> the fix through drm-misc-fixes after the -rc1 hs been tagged.

Sent! I also noticed that there are quite a few other non-GPL exports in
the file, with no real logic that I can see... I'm guessing most of
those weren't intentional either?

~~ Lina
