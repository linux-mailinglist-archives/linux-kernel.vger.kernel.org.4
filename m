Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B2731283
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245144AbjFOInp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240777AbjFOInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:43:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DA32977
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b521cc07c8so87115ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1686818597; x=1689410597;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djE35uiKoDJkBELybDAy6zrBT/KEuH7lg20w5HL8OIY=;
        b=QqPI8xpLPmGC1VUHhEZqF9m8pfEZc5F7rQ9HwV11V5rYv34qGXIBI5I8zcxtY8w4gW
         ahQIJV2jGimkpyg+fazOPuRZvSaTOAvZ7UbsnVuDoBAbWMiNSbU8RP91ZC7fmmXhQqWC
         BfjU5mq2wNzzszH6v1+ERjlBsf/6pRvaPCSMwllaZ2uVN+5sKWGk9xtJpq/5+popzsQp
         tcOcc20Tz7ct27XOioTCJbFIAv+8zF9jjg+lMU9bESZUe/XPyCjp+f90jSYxC5UUiT2I
         afUxlQFi5JS6sZGqTsxaGo+LjopI/sBPoQ/dSej0xytTuVcCLxxInM1kMcJmhSAHK7Uz
         OMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818597; x=1689410597;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djE35uiKoDJkBELybDAy6zrBT/KEuH7lg20w5HL8OIY=;
        b=a+/2QI2W2tHryDC1I6A1vQS1Bnyhxge2Z95fBnMKoFeyCup24ZnQR+KLwY+jTAcE6+
         KIDbg9GEu/9h0X39jquvjZRbrML4g2wPPcPASqJQBoVDJednRwBPFAKRuzz/3SVWC5HE
         OHxCb8cU2fY1uYgAr5j3cleE7xGALWaA8SNeSA4Hy7H12xZIFSNZniSEH884lKPSKp7z
         ZVZPCR7YDIZVKAiYwT1jX86X1ZhdHNqXl5tdEaiatsv8qJuiF0+Nygng+NQOq9L0dPhs
         OZBantDye4e/kOnFhLoSVVt9Qtp1lEvcUmPNO+aiSqanWWgTnKKgx1dzjZJR6u+ujiRY
         T2Bg==
X-Gm-Message-State: AC+VfDx9Ga5onsXCMS6dElA2MEQlT9SlI03i8Zx1sL9JNr8SOvCz1CC7
        XNg6bDWmwhBHuLz/my9b4O9NFw==
X-Google-Smtp-Source: ACHHUZ7TP5umPAvpA0pHF7cTsbl4emR6Y7C0VriWXSS/QRksuYjbYBE+NxzIR4v6A/rc1ydUyNW/HA==
X-Received: by 2002:a17:902:d507:b0:1ac:4a41:d38d with SMTP id b7-20020a170902d50700b001ac4a41d38dmr17069378plg.51.1686818596657;
        Thu, 15 Jun 2023 01:43:16 -0700 (PDT)
Received: from hsinchu15 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b001ac84f5559csm8370111pll.126.2023.06.15.01.43.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Jun 2023 01:43:16 -0700 (PDT)
Date:   Thu, 15 Jun 2023 16:43:11 +0800
From:   Nylon Chen <nylon.chen@sifive.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     schwab@suse.de, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, jszhang@kernel.org,
        ajones@ventanamicro.com, aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, greentime.hu@sifive.com,
        zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH v2] RISC-V: Support 32_PCREL relocation type in kernel
 module
Message-ID: <20230615084310.GA780@hsinchu15>
References: <20230615072302.25638-1-nylon.chen@sifive.com>
 <20230615-unvisited-deceit-9beab8ce987a@wendy>
 <CAHh=Yk_=oZJ6eY3jJzLavub5rGsvY=MKv4tGXeiqkz+rgJHwDQ@mail.gmail.com>
 <20230615-luxurious-rewire-84ff9d639fea@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230615-luxurious-rewire-84ff9d639fea@wendy>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 09:11:33AM +0100, Conor Dooley wrote:
Hi Conor,
> Hey Nylon,
> 
> Firstly, no html emails please :/
Sorry, my Gmail settings got messed up. I will be more careful in the future.
> 
> On Thu, Jun 15, 2023 at 03:52:27PM +0800, Nylon Chen wrote:
> > Conor Dooley <conor.dooley@microchip.com<mailto:conor.dooley@microchip.com>> 於 2023年6月15日 週四 下午3:38寫道：
> > > On Thu, Jun 15, 2023 at 03:23:02PM +0800, Nylon Chen wrote:
> > > > Fix the 'unsupported relocation type' error caused by
> > > > enabling the -fasynchronous-unwind-tables flag,
> > > > which generates relocation types that are not supported.
> > >
> > > What commit adds the -fasynchronous-unwind-tables flag?
> > sorry my description is not correct, please allow me to add
> > 
> > I mean, when we use the flag "-fasynchronous-unwind-tables," it generates
> > the relocation type R_RISCV_32_PCCREL. However, this type is currently not
> > supported, so an error will occur.
> 
> (snip)
> 
> > > Should there be a Fixes: tag for that commit?
> 
> > yes, I will do it.
> 
> What mainline commit actually enables this flag?
Because LLVM currently has it enabled by default(https://reviews.llvm.org/D145164), it will generate this
relocation type.

From what I know, GCC will also enable it in the future.

> 
> Cheers,
> Conor.


