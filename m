Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5648D73CA82
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 13:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjFXK7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 06:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjFXK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 06:59:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C1F1FCC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 03:59:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98df69cacd1so21739866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687604383; x=1690196383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pnhb5E9gx1rgoSmnUX9zo1/G7QfayE+d3qTYxYfxz3k=;
        b=O6xneCpCK/MO2lYg5yqQGCYU6udA+4Z/lEP/qpi0HL5arSlctbESRE35qh35JCxBVx
         6gKl/+yDm2ipvTlVx4LlOz1uufewOVAzRJYUFqHEj4HgYxpk15mzSt1W0t9PwhkT5tfZ
         U21wQaR/0JzawOdoeFCnx/REdIz33qh+u739EMwDsxd47cs+ePxxYBeOcyNjanI/pemV
         CUItyCuytexALKokrF/zwRcKFbO3p8p6+VZBnvDMpF9UN5vEjmNVjB/BKXosl/jrtE0c
         KMZxPx1DLzeogr1D6isrhiaM2ZS2KB4Q6e+1roTaRu45QQ2O6DNJxMNZafpbKc17cnDL
         Zukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687604383; x=1690196383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pnhb5E9gx1rgoSmnUX9zo1/G7QfayE+d3qTYxYfxz3k=;
        b=QCIu8TwmXLKfY6VtaL5ihjS+inNoShWqiqnaXKxgS89dX8qqr8B5OHUkxHHjBacbFx
         eILOfRqXyWSb2RqTnCQgTnP6CCq9vALflcNhE0T/vT/eNsoaVCBm3/PZ9WJ0Iprbh5Te
         v82FW7E1jWG17p9N3nsQbWXt+xjzWCMOGCD7WiOQFcK1mUxgogvsSBCDGmIFwcYGhjZQ
         1yik5PkRBX/UE4XLDThOPGNla4ElZbIqSXUSGtmtbQHwiQBE1amY6PC8eCgiNcxkpGCi
         C6GsXwoKHeEz1z/GUMMh6A+vUc1iIDdNoBK9vYy3JWTlai45nsnVAL7eDJIJiy1QvCmg
         ra+g==
X-Gm-Message-State: AC+VfDxfgqbT4z3XjK/v7ho8NaEvUQhAdVTf3u4KxRnehhLkvpsy2sRY
        OtX7s/A0UFoLqkGCses/YiWAvw==
X-Google-Smtp-Source: ACHHUZ7j/wQdbOXoAly2yzV0RB2hgI+s4QGOQglWcWAJ27nlZv0Uo0/jXkwDaDVOT/+CBOVHhtohFA==
X-Received: by 2002:a17:907:9305:b0:96f:8666:5fc4 with SMTP id bu5-20020a170907930500b0096f86665fc4mr21756260ejc.50.1687604382670;
        Sat, 24 Jun 2023 03:59:42 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id jz3-20020a170906bb0300b009829d2e892csm775425ejb.15.2023.06.24.03.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 03:59:42 -0700 (PDT)
Date:   Sat, 24 Jun 2023 12:59:41 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Stefan O'Rear <sorear@fastmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] RISC-V: add T-Head vector errata handling
Message-ID: <20230624-844c5c4701e8acf9bcf150aa@orel>
References: <20230622231305.631331-1-heiko@sntech.de>
 <20230622231305.631331-4-heiko@sntech.de>
 <20230623-excluding-sprint-aea9cca0cb02@wendy>
 <1908808.taCxCBeP46@diego>
 <0904a831-82c5-47a0-be55-f1a59d0115c2@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0904a831-82c5-47a0-be55-f1a59d0115c2@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 01:18:26AM -0400, Stefan O'Rear wrote:
> On Fri, Jun 23, 2023, at 6:40 AM, Heiko Stübner wrote:
...
> >> > +
> >> > +/*
> >> > + * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an older
> >> > + * encoding for vsetvli (ta, ma vs. d1), so provide an instruction for
> >> > + * vsetvli	t4, x0, e8, m8, d1
> >> > + */
> >> > +#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"
> >> > +
> >> > +/*
> >> > + * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the same
> >> > + * encoding as the standard vse8.v and vle8.v, compilers seem to optimize
> >> > + * the call resulting in a different encoding and then using a value for
> >> > + * the "mop" field that is not part of vector-0.7.1
> >> > + * So encode specific variants for vstate_save and _restore.
> >> > + */
> >> > +#define THEAD_VSB_V_V0T0		".long	0x02028027\n\t"
> >> > +#define THEAD_VSB_V_V8T0		".long	0x02028427\n\t"
> >> > +#define THEAD_VSB_V_V16T0		".long	0x02028827\n\t"
> >> > +#define THEAD_VSB_V_V24T0		".long	0x02028c27\n\t"
> >> > +#define THEAD_VLB_V_V0T0		".long	0x012028007\n\t"
> >> > +#define THEAD_VLB_V_V8T0		".long	0x012028407\n\t"
> >> > +#define THEAD_VLB_V_V16T0		".long	0x012028807\n\t"
> >> > +#define THEAD_VLB_V_V24T0		".long	0x012028c07\n\t"
> 
> .insn isn't supported by the kernel's minimum binutils version, but it _is_
> supported by the oldest version of binutils that can assemble rvv 1.0
> instructions.  OP_V requires 2.39 so I use a literal 0x57 instead.
> 
> very untested, and I leave it to your judgement whether it actually improves
> readability:
> 
> #define THEAD_VSETVLI_T4X0E8M8D1  ".insn i 0x57, 7, t4, x0, 3\n\t"
> #define THEAD_VSB_V_V0T0		".insn r STORE_FP, 0, 1, x0,  t0, x0\n\t"
> #define THEAD_VSB_V_V8T0		".insn r STORE_FP, 0, 1, x8,  t0, x0\n\t"
> #define THEAD_VSB_V_V16T0		".insn r STORE_FP, 0, 1, x16, t0, x0\n\t"
> #define THEAD_VSB_V_V24T0		".insn r STORE_FP, 0, 1, x24, t0, x0\n\t"
> #define THEAD_VSB_V_V0T0		".insn r LOAD_FP,  0, 9, x0,  t0, x0\n\t"
> #define THEAD_VSB_V_V8T0		".insn r LOAD_FP,  0, 9, x8,  t0, x0\n\t"
> #define THEAD_VSB_V_V16T0		".insn r LOAD_FP,  0, 9, x16, t0, x0\n\t"
> #define THEAD_VSB_V_V24T0		".insn r LOAD_FP,  0, 9, x24, t0, x0\n\t"
>

We have the INSN_R() macro in arch/riscv/include/asm/insn-def.h for stuff
like this.

Thanks,
drew
