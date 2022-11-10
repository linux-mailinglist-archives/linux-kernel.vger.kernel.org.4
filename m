Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5FB624541
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKJPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKJPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C22727CF5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668093031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1aWxEK1TdYDii2f1EVjSrDIOIljR4IPqsIREqMrNiKk=;
        b=hnMYgTVTSchbzJ4KoS/HYkhqJb/60Gc2+h4WOIgU7DTkZYkx3H5aD9yacuk6LKM0Tq3foR
        082iOsyJqHlsYjpF4q+RHCsXxyUXke86HAQ38d/4mwr/l1Ww0gZ+6rpnnaPRi3bxazkPKe
        tHgLWO7ot0jDIMvo0b/Bd9ucr5bV2mM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-572-1mNEiMYoMOWHlrxz4LELEA-1; Thu, 10 Nov 2022 10:10:29 -0500
X-MC-Unique: 1mNEiMYoMOWHlrxz4LELEA-1
Received: by mail-ej1-f69.google.com with SMTP id hp16-20020a1709073e1000b007adf5a83df7so1404061ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aWxEK1TdYDii2f1EVjSrDIOIljR4IPqsIREqMrNiKk=;
        b=WaaXjbXwIDV4d3fB1XvrcUztzw++WTCFUbyu+tdofL+bPYd4i85lB3MPrLBlK0cypY
         9tg79a3qDFTacJHIOoPiUqgzq/uNgr1+khq7dGTO5cKO0UUSuM9yijE/077QAVQXGovF
         qZvvxhi5zR7T6pYdl4WXpljr6naqL6z2EPxhnIiEDG5QAUfQFBJUcb8U0AJA/ctaK8cA
         3FhGExCikTve4gGaBHkQbCq0Re8AXZjX9yHfD4gtoYBpdzkrXK1F067TGHaiLF9enOna
         Lzy8iz0XskGdaKBAZF9AG4ha+aHpDYSbb4yOcbI61G9fhnUMfozzJ3GDTZaIOHgp3gmb
         a6jQ==
X-Gm-Message-State: ACrzQf1rqos6ZneTUd+OAlxC54IZgvzGLgVW/ePVHfIdKuFYM8Z6dyPq
        w0s/goKilIEJ6ipbb9d8CO3rCG1QIrIz8kqANX0iKK30CBCb9g5VOTQUxyEnFwjd1qymoKpSoZq
        PXhYVzZlopiBzaiyNRggzYnE4D4Lz3MDawtp1MK41
X-Received: by 2002:a17:906:81c6:b0:7ae:7b1:df60 with SMTP id e6-20020a17090681c600b007ae07b1df60mr38174215ejx.87.1668093028292;
        Thu, 10 Nov 2022 07:10:28 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4XIaD23sHXbkgMz7JfNrC7DMaIxwyr/fbLQzR3FHOgbk5q60dF3e5AlG4GQ109n4AGNYSFAdCCMjjp17Z2dmE=
X-Received: by 2002:a17:906:81c6:b0:7ae:7b1:df60 with SMTP id
 e6-20020a17090681c600b007ae07b1df60mr38174207ejx.87.1668093028133; Thu, 10
 Nov 2022 07:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20221011145413.8025-1-aahringo@redhat.com> <931c87d8-5856-e393-7108-66275ee4099a@suse.cz>
 <CAK-6q+ho0+mDP08yXvg7vupC-+GdUUY4zUHdfwU_7Q=B2VbQ-Q@mail.gmail.com> <8e4080f8-7021-1c02-56cf-a105a5141abd@suse.cz>
In-Reply-To: <8e4080f8-7021-1c02-56cf-a105a5141abd@suse.cz>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 10 Nov 2022 10:10:16 -0500
Message-ID: <CAK-6q+jLQakekjTEQrzbmjKa6QnQDTziHjAg749qw=0ufmrFdQ@mail.gmail.com>
Subject: Re: [PATCHv2] mm: slab: comment __GFP_ZERO case for kmem_cache_alloc
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
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

Hi,

On Thu, Nov 10, 2022 at 3:37 AM Vlastimil Babka <vbabka@suse.cz> wrote:
...
>
> So, I did the following, which IMHO resolves the misleading parts and also
> mentions __GFP_ZERO. Sounds OK?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.2/cleanups&id=d6a3a7c3f65dfebcbc4872d5912d3465c8e8b051
>

perfect, thanks!

- Alex

