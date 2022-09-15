Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208F05B957B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIOHfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIOHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06A792DE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663227338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=soVYuMAxayh+2brnGzLjNkGMPYifBwRHy6hrOc9fKJ8=;
        b=OyPlY/1tpSkuNIuHGkNy3q3T709HeKFVaGyFkAZ/MG+FxFjU1t5zdpibDN/MOu0ymX9v9B
        T9wUieo+qIcOczD4RB3igJJLWm4DgJetZhGQdmvU0IOGYwm/Ut5Zt1GtlxzlU6BykYWFQu
        J+jWu6BVH4o3O2u0QzDLjnLBIdD4ih8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-3M8He257MuC5r_TBGjOmLA-1; Thu, 15 Sep 2022 03:35:37 -0400
X-MC-Unique: 3M8He257MuC5r_TBGjOmLA-1
Received: by mail-pl1-f197.google.com with SMTP id i1-20020a170902cf0100b001730caeec78so11997231plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=soVYuMAxayh+2brnGzLjNkGMPYifBwRHy6hrOc9fKJ8=;
        b=LLt+E1ggmmHLBhuFZrXD1vDWnhneAzkif6OGu1OEJH/WRU4Dh1l/PHc6xt6vCSmqE6
         yneYvDbF80yoJWQmDPervTaWs80/eQhlC+gldabbR06eABQEgXdwkWFE9lv/Hc66Equu
         GJwpOMVfslxGfSaMSIJTdxn2zhwCj/x0Rq2rhFG87IrEbsyvD5wo0l3UxZPA7TIIYoLW
         ac62rXjGS5NH+6ivXzpdfEqUasgyit4fGw/cGjnNj7UPiGet0LWRTQ/q9aeyiKt5FjXp
         lrBuK76rHGwzeQGEkKpOlynijt1FAxn6TbvM3c0iG+BsfEKTRB+CmWmLxQ8pZ/yJpEC7
         Effw==
X-Gm-Message-State: ACrzQf3JuimOUXkGap8B9KaKzkMs+wD9zpx4gWyj+SB0er8/WkTujJ3a
        dKdvFl/WU3UvCYDN+5IbSnR7b40ptUl8TQ8E14nacsUcxn2eHr04tzBcgxdqjr+5jhTiAczRvx2
        MgH/1m7I/M6uXfhQMw8FZs6EuMVIBKi9BoLFd0MHC
X-Received: by 2002:a17:903:3014:b0:176:e498:2340 with SMTP id o20-20020a170903301400b00176e4982340mr3078636pla.119.1663227336198;
        Thu, 15 Sep 2022 00:35:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM66EOQRG+uyyFv9IE6MmpghdMEhIjmEVFEbL27fE57qiUN+hTdC4XHDd0YfNOVJy61ajzo/dhfEWZYTZs15d48=
X-Received: by 2002:a17:903:3014:b0:176:e498:2340 with SMTP id
 o20-20020a170903301400b00176e4982340mr3078616pla.119.1663227335929; Thu, 15
 Sep 2022 00:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
 <YwTvrNuulKx0SB6H@gmail.com> <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
 <YwcbVJswrL1Doi4s@gmail.com> <CAO-hwJJ86oAuaFD+uX7Rwv7cASO=4mchRJ1UBTxz9gYs6M1rUg@mail.gmail.com>
 <YyLVblZkIPCvNd/2@gmail.com>
In-Reply-To: <YyLVblZkIPCvNd/2@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 15 Sep 2022 08:35:25 +0100
Message-ID: <CAO-hwJJ5dRrgxrae-RasYXuu7C9xjw6RmPaPfmO=YU3StMaQ3A@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 8:28 AM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Hi Benjamin,
>
> On Tue, Aug 30, 2022 at 02:45:11PM +0200, Benjamin Tissoires wrote:
> > On Thu, Aug 25, 2022 at 8:44 AM Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:
> > >
>
>
> [...]
> > >
> > >
> > > Is the fact that more than one button share the same
> > > byte hard to describe in the report?
> >
> > No, this is actually easy to describe. You say that there is one usage
> > of "something" which has a report size of 1 bit, and then you have
> > another usage of "something else" with the same report size.
> >
> > But usually you have to add padding after to make up to 8 bits (so 6
> > bits in that case).
> >
> > I was referring to the case  where you are parsing the same bit on the
> > wire, and give a different usage based if you have received an odd or
> > an even number of reports. In that case, we probably need to use move
> > this bit to a const field in the original report descriptor and say
> > that the data is now not const:
> >
> > - initial report (completely random example):
> >   X (2 bytes) | Y (2 bytes) | button this_or_that (1 bit, depending of
> > odd or even received reports) | 7 bits of padding
> > - we can declare it as:
> >   X (2 bytes) | Y (2 bytes) | button this (1 bit) | button that (1
> > bit) | 6 bits of padding
>
> How about if there is no unused bytes?
>
> The XTRG2FMS has 8 10-bit channels and use every byte in the report.
> Should I specify 8 8-bit channels instead and fix that in raw_event?
> If so, should I only use 8bit values then?

If I am not wrong, you should be able to add another byte in the
report descriptor, as long as your raw_event function always adds it.
Though now that I am typing it, I am actually wondering if this will
work. You can always try, there is a chance it'll work, but I can't
remember if it'll result in a timeout on the USB front because it'll
expect one more byte that will never arrive.

>
> (Are you at the ELCE conference btw?)

I was at Plumbers this week, but got an extra day today. But yeah, I'm
in Dublin today.

Cheers,
Benjamin

>
> Best regards
> Marcus Folkesson

