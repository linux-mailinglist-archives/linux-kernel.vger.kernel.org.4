Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527A268D45A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjBGKd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjBGKdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:33:41 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C693018D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:33:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6589E42458;
        Tue,  7 Feb 2023 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1675765990;
        bh=hAMlWeDJ4c/zMHDvd5uFXNWbzM/FlEFJhQdmya+1U7E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Tj8QR0jq995v24jo/ri2KPjXagTxIHEwYohVVXKwH6LlT43N86YeG3PgFRgE9+xPX
         9W3bSaHJhPnSz2HdvF5TgyXkYm6LyM58+NugJGbAV6gQpFyFMDQB4TX26OO3pTIoIL
         W7CEQ+lXhMtEs2OMlysnXembeLZ9ZLxHM/QI6/2ytpm5Y/dpZqKwGVTmMXEbmMg0t2
         tqOWxjWWqYVe3Mo8/JOQ25+AD2QfGg2pDIBeCwqMVn7b/TUPYU/GQDA5Qw/g6r34oU
         WGkK91NnfoIjsNYUas0CeNzs4m4vt14tk5cVD+goYGL/U2RJixqYD3ugLWvPhjIUly
         lBcxi9YrjwpVw==
Message-ID: <d3331cf8-02df-bf15-586b-af9d10830758@asahilina.net>
Date:   Tue, 7 Feb 2023 19:33:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20230205125124.2260-1-lina@asahilina.net>
 <a1cd8c74-98f4-bff0-0344-cbece787c6e8@redhat.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <a1cd8c74-98f4-bff0-0344-cbece787c6e8@redhat.com>
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

On 07/02/2023 03.47, Javier Martinez Canillas wrote:
> Hello Lina,
> 
> On 2/5/23 13:51, Asahi Lina wrote:
>> Other functions touching shmem->sgt take the pages lock, so do that here
>> too. drm_gem_shmem_get_pages() & co take the same lock, so move to the
>> _locked() variants to avoid recursive locking.
>>
>> Discovered while auditing locking to write the Rust abstractions.
>>
>> Fixes: 2194a63a818d ("drm: Add library for shmem backed GEM objects")
>> Fixes: 4fa3d66f132b ("drm/shmem: Do dma_unmap_sg before purging pages")
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
> 
> Good catch. The patch looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> What about drm_gem_shmem_free() BTW, I believe that the helper should also
> grab the lock before unmap / free the sgtable?

That's called from driver free callbacks, so it should only be called
when there are no other users left and the refcount is zero, right? If
there's anyone else racing it I think we have bigger problems than the
pages lock at that point, since the last thing it does is `kfree(shmem);` ^^

(In Rust terms this is equivalent to the Drop trait, which takes a
mutable/exclusive reference, which means no other reference to the
object can exist at that point, so no races are possible. And in fact in
my Rust abstraction I trigger a drop of the Rust object embedded in the
shmem object before calling drm_gem_shmem_free(), so if this invariant
doesn't hold that code would be wrong too!)

~~ Lina
