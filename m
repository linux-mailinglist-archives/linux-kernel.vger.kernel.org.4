Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370E2691520
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjBJAJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBJAJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:09:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA45A90E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675987722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSw5daY010qcHCZuSVoAgV58dbuNqE0exBdvxUMk52M=;
        b=HDE0rLv7PaKa9k+BCNUOkYm1dyzK1TdKJnvBXeg33z2jS6RrcA0a33ZDkGdCA3lXVnRaly
        fPq4IwBm2HeMhJJuPABSGAMRMQuEjbHzNF3W3/r9MLteNrmYdeaPiVq8OU34puPcgZzwDt
        +76FQ1kQ9NAMb3pyNDm4QoZ5MdK9FLM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-rvKJ2d6GMuqtZY7VablZFg-1; Thu, 09 Feb 2023 19:08:41 -0500
X-MC-Unique: rvKJ2d6GMuqtZY7VablZFg-1
Received: by mail-qk1-f198.google.com with SMTP id a6-20020a05620a102600b00729952b4c73so2285678qkk.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:08:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSw5daY010qcHCZuSVoAgV58dbuNqE0exBdvxUMk52M=;
        b=Yx4okWO5hxN9LfC22HvsQBu5HMoQpZMN78cwPQ5OAYubz9CaELYTbK6VH8D0SkJSEf
         aZpAj8y/LMng+fo9k+ICn5suaZLHHfbEPAY2v3r2lIjmGzokDf/u9cAXFn+yVb5uUQHu
         xvGD23XfF+fBbLNy1zul79Ywe5pEsHWs0hq8NLBfndAkI5TUXKge3i4Ubkgj/dwNtwaZ
         Sp29FW8XDQHgN54NsKNb9HfbIbtIye89zg/amBgxrKoJKKtAXDmbDD/qD24QpUGYQFo/
         45VsC6kKjJkSosUX0SXdbPFJbaickOI/+ebe7PjvEO0Ut9O/tOOT6NJN3OFxlLBYsLhl
         VIUQ==
X-Gm-Message-State: AO0yUKVFr2EjTKD5qRCJ6RJ1ODFjPdluPeBOrL1jX+O0FDN3c69GXJ1e
        +Fjy2RO1s0Qul00vfY6KnTbSWPEtkAlhExyeYyTJIDNOFyaOHaEMXYXPUROs62Y1tkNxbo7ydSP
        tSAFrmP2miOYD00CenB6tTnVigfoewLhAWMUgGrvR
X-Received: by 2002:ac8:5dc6:0:b0:3ba:8c0:8f89 with SMTP id e6-20020ac85dc6000000b003ba08c08f89mr2003778qtx.89.1675987721135;
        Thu, 09 Feb 2023 16:08:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/5wZzJKpTlmro2WCCkMZCDMF0ZKN/0KTX+DGUF/pDMJLqFMcVYxsSLUcdNimpD7Zma28DTdnHBiJyhmcXCLF8=
X-Received: by 2002:ac8:5dc6:0:b0:3ba:8c0:8f89 with SMTP id
 e6-20020ac85dc6000000b003ba08c08f89mr2003771qtx.89.1675987720917; Thu, 09 Feb
 2023 16:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20230210104720.365557d8@canb.auug.org.au>
In-Reply-To: <20230210104720.365557d8@canb.auug.org.au>
From:   David Airlie <airlied@redhat.com>
Date:   Fri, 10 Feb 2023 10:08:29 +1000
Message-ID: <CAMwc25r3EQG7hHkC7SU9omHWFGqto7RuUY9uVNkC6vXUF_hVtg@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the drm-misc-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 9:47 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> The following commit is also in the drm-fixes tree as a different commit
> (but the same patch):
>
>   94d8b6572a1f ("nvidiafb: detect the hardware support before removing console.")
>
> This is commit
>
>   04119ab1a49f ("nvidiafb: detect the hardware support before removing console.")
>
> in the drm-fixes tree.

Just FYI misc team, I've force pushed drm-misc-fixes to drop this
patch, please make sure any local misc fixes don't bring it back in if
we can avoid it.

Dave.

