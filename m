Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E305E716086
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjE3Mvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjE3Mvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:51:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52496A1;
        Tue, 30 May 2023 05:51:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so4777997e87.2;
        Tue, 30 May 2023 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451063; x=1688043063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gal9XjgCsS2UDUaYyweRJgD8pL7uFqcBLW5/YTWPodM=;
        b=hOxtt9iOuVVmIO+k/mOsv0DE529D5ZqZfPFubolRq5Qt0pzRZAjajiLHRFbwjpwiv7
         XUcVtEjV8LgXPys7mpSFtU6w1gvx6zv13XP7IybXvS0gcuDoWplueVIQdZMM0GOWqG09
         tj0ky/eJVdoudEf1pDAjvBKBzWODz6djPGqg1Gh3zy3UTDUNJ1knJ7bcxRoCGon7as8L
         Z5CjaCneU5N2hb4nDYcOL1hLiSnDB3+9s7kjHxkY2m1MkRW3KrA4jiH+AiX/LjBMA5Fc
         uu5O04VlSPaZ/Tt/Z2hgRNGM6FTX0LN/l0L2nI5QwLO2z+l3hFgaUlxaUphsoHFeZToD
         Va+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451063; x=1688043063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gal9XjgCsS2UDUaYyweRJgD8pL7uFqcBLW5/YTWPodM=;
        b=kyW3xu9PuF3n8gqACoUWhii2+dFB5BBCqfvwllWDR/BPbCmEuM2deThhdZTdggPjEQ
         uuFBC5VZ7EtznqelMXQNGfZ9p82itGz1VTlC+Y7UdqlW+GCAhGi66bLZJk312WFIvvXN
         pBXblILoaa3Fp3hwSqY68EzOKjatW/5DXRxYJzs4Mpw8mRdEmmpTlLWZX686MZYVMjHO
         GKt5XaoKe88mM533Z9ipcHJYU1GoAO7t+qkirPkqxIEp13m6VDhOghHXqnKoGu3i1p8E
         Dyx7HUWNBPovrzXxs70yPOqYIMZ+7yUJAP1G+MxrmvW38zBo4+JEnIxFwyYlNz/n5Zlp
         hOxQ==
X-Gm-Message-State: AC+VfDxtwx8sPKkx4QwqSt28HGUIwbjUVyb6+YAVyiKhr4ikohxl2kSR
        PLdcdFC/QL+2lrGulnwkqqQ=
X-Google-Smtp-Source: ACHHUZ5iTQf3pMnSMzAz1V1jS3WQKztyQ0Zo5d8VZ5HJrCm/W3RISSpWjZoJNdQmAb7nJ4+hcqkNEg==
X-Received: by 2002:ac2:53a7:0:b0:4f3:aa29:b663 with SMTP id j7-20020ac253a7000000b004f3aa29b663mr764401lfh.35.1685451062781;
        Tue, 30 May 2023 05:51:02 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id u11-20020ac243cb000000b004efedad4604sm337636lfl.18.2023.05.30.05.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:51:02 -0700 (PDT)
Date:   Tue, 30 May 2023 15:51:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and M5150
Message-ID: <20230530125100.bd626syvkbfv7zhv@mobilestation>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
 <684C1A48-C743-4045-AF12-B0846FCE8EBE@flygoat.com>
 <alpine.DEB.2.21.2305301152080.42601@angie.orcam.me.uk>
 <BCECE3BF-7A4D-43BF-8AA8-2232D974CD71@flygoat.com>
 <alpine.DEB.2.21.2305301315120.42601@angie.orcam.me.uk>
 <20230530124127.z5rr5vauw43rafrt@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230530124127.z5rr5vauw43rafrt@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:41:30PM +0300, Serge Semin wrote:
> On Tue, May 30, 2023 at 01:16:32PM +0100, Maciej W. Rozycki wrote:
> > On Tue, 30 May 2023, Jiaxun Yang wrote:
> > 
> > > > Sure, but this change is not needed for it.  You just need to declare 
> > > > which ISA revisions your platform supports and leave `__get_cpu_type' 
> > > > alone.  It has worked like that for a decade now.
> > > 
> > > I’m afraid it won’t work as you expected.
> > > 
> > > Actually I ran into a problem that `case CPU_P5600` in c-r4k.c is optimised out
> > > by compiler, because the codepath is marked as unreachable.
> > 
> >  Maybe there's a bug elsewhere then.  Send me your .config and I'll try to 
> > reproduce it.
> 
> I may have misunderstood something, but it seems like there is no such
> problem on my P5600 system:
> 
> [fancer@mobilestation] kernel $ grep -r P5600 -B2 -A2 arch/mips/mm/c-r4k.c 
>         case CPU_1004K:
>         case CPU_INTERAPTIV:
>         case CPU_P5600:
>         case CPU_PROAPTIV:
>         case CPU_M5150:
> --
>         case CPU_P6600:
>         case CPU_M6250:
>                 pr_info("MIPS P5600 is here\n");
>                 if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
>                     (c->icache.waysize > PAGE_SIZE))
> 
> Log:
> [    0.000000] Linux version 6.4.0-rc1-bt1-00235-gf9efd6b74b12-dirty (fancer@mobilestation) (mipsel-baikal-linux-gcc (GCC) 7.3.0, GNU ld (GNU Binutils) 2.30.0.20180208) #1
> 275 SMP PREEMPT Tue May 30 15:30:48 MSK 2023
> [    0.000000] CPU0 revision is: 0001a830 (MIPS P5600)
> [    0.000000] FPU revision is: 30f30320
> [    0.000000] MSA revision is: 00000320
> ...
> [    0.000000] VPE topology {1,1} total 2
> [    0.000000] MIPS P5600 is here
> ...

Here is the CPU-related kernel configs:
root@msbt2:~# cat /proc/config.gz | gunzip | grep CPU_MIPS
# CONFIG_CPU_MIPS32_R2 is not set
# CONFIG_CPU_MIPS32_R5 is not set
# CONFIG_CPU_MIPS32_3_5_FEATURES is not set
CONFIG_CPU_MIPS32_R5_FEATURES=y
CONFIG_CPU_MIPS32_R5_XPA=y
CONFIG_SYS_HAS_CPU_MIPS32_R2=y
CONFIG_SYS_HAS_CPU_MIPS32_R3_5=y
CONFIG_SYS_HAS_CPU_MIPS32_R5=y
CONFIG_CPU_MIPS32=y
CONFIG_CPU_MIPSR5=y
CONFIG_CPU_MIPSR2_IRQ_VI=y
CONFIG_CPU_MIPSR2_IRQ_EI=y

-Serge(y)

> 
> -Serge(y)
> 
> > 
> >   Maciej
