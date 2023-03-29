Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84256CED20
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjC2Pjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjC2Pjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1CB13E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680104337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNc56yZE3f0/ZsxafHFx8d8Um4Kx4OUbmVJ42ZTNjo8=;
        b=O/fWhsMbQi/EoHt08rMR8X0U1RsubYHwht9UauRIVYDA5Cq2iTUfifJcE2Rym72iUQaYn1
        qxOK161nbpBHNP5qN98Gy+edR/73QwUb3cy1oasEwW+Tat85Cms7K/419Bk1c9eRbvPHHw
        b6RB93of+oPQpYlOD6+EAXfzMVk5NE0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-piNWFRlDM6C_Ycd7zrLKTA-1; Wed, 29 Mar 2023 11:38:54 -0400
X-MC-Unique: piNWFRlDM6C_Ycd7zrLKTA-1
Received: by mail-qk1-f197.google.com with SMTP id o63-20020a374142000000b007467ef381beso7504742qka.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNc56yZE3f0/ZsxafHFx8d8Um4Kx4OUbmVJ42ZTNjo8=;
        b=bRevTBuq7e6n/lV/0P0DGNAeu7+p18P6sUZrGlRyNeFjN5VVygAkE9VFxhPzIWcPhw
         KhgMtrFyvK4crVw3aOc8BZbwmyyRn4RLqOmm+ynwnC2A7p8KHYZNJo52E+PxFKeBmZB3
         hGKAQG5pac2NTcgFhuqydW2gILWw5pkf1J2gXdz2anpwGPMx8drsksudfM6FUzwMOURe
         HfkJRix0kcdYqZbBUy0RMngMg38Y4ev9YC6LlgPjuapYwFQoNx0ZisZulUSxdymrDmhT
         KCZra1dprYPdkr5Bc9GrleUyYAy+UzxSbn6511pDcc/BJAmSImX1qONm2p65A8JioGys
         VFKQ==
X-Gm-Message-State: AO0yUKV1HDP06BI0MUN/Cecjln5sPLv0YQdBg/lKY1as63gslTL7tbVH
        bfWBg1/gz6x29kbggcHyQ4kqRtjWq7fZS3u+uRoyzb4Y4VQ+9LL54v6dZPz0FKAituyz1ZYd9Y3
        N5EW8YHFpjXOkP848ci5+BsUA
X-Received: by 2002:a05:622a:11cc:b0:3dc:ce21:6f87 with SMTP id n12-20020a05622a11cc00b003dcce216f87mr32315931qtk.11.1680104333980;
        Wed, 29 Mar 2023 08:38:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set8BQYRlPEhXzf93lrSn8foMmX/OnCLu3jZm4AZeY/wbrQvddGOo944faH5Z9J6Py0hDAeGQQw==
X-Received: by 2002:a05:622a:11cc:b0:3dc:ce21:6f87 with SMTP id n12-20020a05622a11cc00b003dcce216f87mr32315897qtk.11.1680104333742;
        Wed, 29 Mar 2023 08:38:53 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id 123-20020a370381000000b00746a7945d87sm9494746qkd.52.2023.03.29.08.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:38:53 -0700 (PDT)
Date:   Wed, 29 Mar 2023 08:38:51 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Desnes Nunes <desnesn@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        noreply@ellerman.id.au
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
Message-ID: <hw7djtdwttjwqhnpwidl2g3k7zxoepy7g54ehwatbchjjxahhc@al2t2da3pylo>
References: <20230329071405.1568021-1-geert+renesas@glider.be>
 <2w7rzdbzbii4ewliym6qw4svf2mzptsccz23yms5lsdioflcti@w63kwgzkra6r>
 <CAMuHMdVRqbe4Af72H0uqYrRJHJweiMYawUn4vK-9Xt7b7FLDfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVRqbe4Af72H0uqYrRJHJweiMYawUn4vK-9Xt7b7FLDfQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 05:34:23PM +0200, Geert Uytterhoeven wrote:
> Hi Jerry,
> 
> On Wed, Mar 29, 2023 at 5:03 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> > On Wed, Mar 29, 2023 at 09:14:05AM +0200, Geert Uytterhoeven wrote:
> > > On 32-bit without LPAE:
> > >
> > >     kernel/dma/debug.c: In function ‘debug_dma_dump_mappings’:
> > >     kernel/dma/debug.c:537:7: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 9 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
> > >     kernel/dma/debug.c: In function ‘dump_show’:
> > >     kernel/dma/debug.c:568:59: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 11 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
> > >
> > > Fixes: bd89d69a529fbef3 ("dma-debug: add cacheline to user/kernel space dump messages")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Link: https://lore.kernel.org/r/202303160548.ReyuTsGD-lkp@intel.com
> > > Reported-by: noreply@ellerman.id.au
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> =
> > > --- a/kernel/dma/debug.c
> > > +++ b/kernel/dma/debug.c
> > > @@ -534,11 +534,11 @@ void debug_dma_dump_mappings(struct device *dev)
> > >                       if (!dev || dev == entry->dev) {
> > >                               cln = to_cacheline_number(entry);
> > >                               dev_info(entry->dev,
> > > -                                      "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
> > > +                                      "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
> > >                                        type2name[entry->type], idx,
> > >                                        phys_addr(entry), entry->pfn,
> > >                                        entry->dev_addr, entry->size,
> > > -                                      cln, dir2name[entry->direction],
> > > +                                      &cln, dir2name[entry->direction],
> >
> > Won't this just print out the address of cln declared at the beginning of debug_dma_dump_mappings() each time, instead of the value
> > returned from to_cacheline_entry() ?
> 
> The physical address is passed by reference, cfr.
> https://elixir.bootlin.com/linux/latest/source/Documentation/core-api/printk-formats.rst#L231
> 
> Gr{oetje,eeting}s,
> 
>                         Geert

Got it. Thanks Geert

snits

> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

