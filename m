Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB5E716022
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjE3MmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE3Mlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:41:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7012116;
        Tue, 30 May 2023 05:41:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4f757d575so3272871e87.0;
        Tue, 30 May 2023 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685450490; x=1688042490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AXaBIyVkac3rpUtYwBflOv6zoeF3mDER/Xuhtgf0HxI=;
        b=JDDM0WvC217/SS1BoFRzZ3KDw+XWOI03wOCwV/mGeCYgPrL9rJtWgt/fXaNQTnRGnF
         sdVU1IhJsZksQ0ovu75OBR4qE11W6cy4ROj7smbnyhG94bkEA27C73vVVnxFVTcgfsw8
         ez95ROtkfdNG6jBrLrZzfyZrFAK4LKqi/IcDax7bDxLi/lNcRutEliXXQC7kP/vU7ALv
         FsZ32HBg9dS5iu3LsR2ngyXPwSQLyXnDaj1q1YjzytWWjEe+frN9oI3697fPuC6xNj+y
         aJ5uH9lAlr/f06RYqCp3c+Sjd6I4zvToutEDNElOppPJ8f7Mx5WJWQJ3FeKMDi2LkgQZ
         P4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685450490; x=1688042490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXaBIyVkac3rpUtYwBflOv6zoeF3mDER/Xuhtgf0HxI=;
        b=f0kFItLXVsnmmBoklcvMifgGqkqZpkO0qhENqyjk4PrdTmfLg9cRfcbf+SCx0XSLwE
         iXlgHUQH2Dnt8ZcpuVOs02VRrD31h+MwuVt4eZtfN869DnzmoMyTF1gNidQsfPTE7xd2
         VLJkQDVAjoIsH/HBktrm/pX/bxOZcTB9bR1jfDJDELxQlb0mpXoCo+IcsLYJMvDH4RaD
         4rul6jnrcUhxWU/G/VtsYR38ZUqfGFm1qKPzpzLKBLpo26taPx3G5ocEc4qSpaQYIKzE
         9Ghi/wbii3C+ROf6j6WZvNnuEtl0jYo+pB+l3/1l5JcW8zLnZ0Zxum3dZLEwUND5q5Wd
         Fq2A==
X-Gm-Message-State: AC+VfDxTJt9gDxQE7qS/E9YwYUGUVh0+3MvtfViE01KZMJJqDqPDCkWK
        Lo0bBPVhDQdy3v1RhPJB35bY4BwkyBI=
X-Google-Smtp-Source: ACHHUZ42xZ3SWl/k60L/ACqzSFzTYi56GXGjH1R23w2LlPlQ4o740RMIVAdcGqaUXimVaSd0i0FJkA==
X-Received: by 2002:ac2:5296:0:b0:4ed:d5ce:7dea with SMTP id q22-20020ac25296000000b004edd5ce7deamr755848lfm.27.1685450490326;
        Tue, 30 May 2023 05:41:30 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id f6-20020ac25326000000b004f2529c71c1sm330070lfh.260.2023.05.30.05.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:41:29 -0700 (PDT)
Date:   Tue, 30 May 2023 15:41:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and M5150
Message-ID: <20230530124127.z5rr5vauw43rafrt@mobilestation>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
 <684C1A48-C743-4045-AF12-B0846FCE8EBE@flygoat.com>
 <alpine.DEB.2.21.2305301152080.42601@angie.orcam.me.uk>
 <BCECE3BF-7A4D-43BF-8AA8-2232D974CD71@flygoat.com>
 <alpine.DEB.2.21.2305301315120.42601@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2305301315120.42601@angie.orcam.me.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 01:16:32PM +0100, Maciej W. Rozycki wrote:
> On Tue, 30 May 2023, Jiaxun Yang wrote:
> 
> > > Sure, but this change is not needed for it.  You just need to declare 
> > > which ISA revisions your platform supports and leave `__get_cpu_type' 
> > > alone.  It has worked like that for a decade now.
> > 
> > I’m afraid it won’t work as you expected.
> > 
> > Actually I ran into a problem that `case CPU_P5600` in c-r4k.c is optimised out
> > by compiler, because the codepath is marked as unreachable.
> 
>  Maybe there's a bug elsewhere then.  Send me your .config and I'll try to 
> reproduce it.

I may have misunderstood something, but it seems like there is no such
problem on my P5600 system:

[fancer@mobilestation] kernel $ grep -r P5600 -B2 -A2 arch/mips/mm/c-r4k.c 
        case CPU_1004K:
        case CPU_INTERAPTIV:
        case CPU_P5600:
        case CPU_PROAPTIV:
        case CPU_M5150:
--
        case CPU_P6600:
        case CPU_M6250:
                pr_info("MIPS P5600 is here\n");
                if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
                    (c->icache.waysize > PAGE_SIZE))

Log:
[    0.000000] Linux version 6.4.0-rc1-bt1-00235-gf9efd6b74b12-dirty (fancer@mobilestation) (mipsel-baikal-linux-gcc (GCC) 7.3.0, GNU ld (GNU Binutils) 2.30.0.20180208) #1
275 SMP PREEMPT Tue May 30 15:30:48 MSK 2023
[    0.000000] CPU0 revision is: 0001a830 (MIPS P5600)
[    0.000000] FPU revision is: 30f30320
[    0.000000] MSA revision is: 00000320
...
[    0.000000] VPE topology {1,1} total 2
[    0.000000] MIPS P5600 is here
...

-Serge(y)

> 
>   Maciej
