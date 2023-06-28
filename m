Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52C0740E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjF1KRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjF1KG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:06:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB121FFC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:01:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso7708087e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687946474; x=1690538474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ejpdHA8WxWWd1l59d/A+1U8uDQbHe+EInXg0gY9zi4g=;
        b=dZvJgVIXVWCBDL5aXGFxsJ5WPmhQgOeJAlYzfhXYBqZRMXc8ZosqV491wGpV9rwfXT
         ifQDH5Dakn53A1zYa+hu0PCVcBjx85Y6/pGFtusbYPL6Rx2lxZ7z40Jviu/V12KAEt5f
         OovlwEonF5PUNsLQ0j7raIByy/CI1zrBCRzn32YSr0JPrfVua6nV41dIHmybPwVqnmBj
         B+ktWhEcsO/3lBnj12kWtMd4xPB06qGyWjI6kb5tkRQKl4WmcxysASNTmy2N4ZEk+8FL
         bb3OkWJYNL01pKA9Pn8+CPMsW/OIkaS7zHKMejCnj+peNKHRUKoTX9LrDkXU58vze9Lb
         vx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687946474; x=1690538474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejpdHA8WxWWd1l59d/A+1U8uDQbHe+EInXg0gY9zi4g=;
        b=TYU3q7EiFdCYB3uFxySa4c03vWfK2+cB2XJBK9+GQyLnonAcldJv4KEVVA4jNyUuEC
         31KS7Hc2BG+vjWTL/5v5q/jfX85GHgaXtALFBILwFHxhCzEEAt/S0M6eZCo1EkfP4Ciw
         /77bDcOABRe10Jl0BWnvpH2mdyxrM2dnw3eHjWTbNaM3KaRJcaD7ufOfByHev2PnbRWv
         up2HbsY2tq2dad3Q+OgnYYQsnFtMVO4upGdhyG0zbZvex/SShYYbsigd5KQULsikuJes
         Crb62E0OUrN/qSs6i66PUlp2gukraLG7N40j/8xRJBiwXQpgkgdLNMieCNnsIyfh+uRe
         TM9Q==
X-Gm-Message-State: AC+VfDxZ68gguc025zbvjhRV68cFO92LpZ5t9gdniyJZzmaFkSXV4swl
        VsIycaFzn5jg0L7kCGE0hlgXYA==
X-Google-Smtp-Source: ACHHUZ71Yv4hqMaxWIDwAYtnT7SHbWlkB9oKL4/KN0ocWZiXmvCj0cgNqI0Fj7mNTg6Mq0VXQQD+sA==
X-Received: by 2002:a05:6512:3b82:b0:4fb:7be5:4870 with SMTP id g2-20020a0565123b8200b004fb7be54870mr5901035lfv.46.1687946473669;
        Wed, 28 Jun 2023 03:01:13 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f9cb3c8958sm16399566wmg.3.2023.06.28.03.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:01:13 -0700 (PDT)
Date:   Wed, 28 Jun 2023 12:01:11 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Evan Green <evan@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <ZJwE5wRVkoND3Z6P@vermeer>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-2-sameo@rivosinc.com>
 <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
 <20230627-debating-twelve-da2c1ed60948@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627-debating-twelve-da2c1ed60948@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 07:48:15PM +0100, Conor Dooley wrote:
> On Tue, Jun 27, 2023 at 11:14:30AM -0700, Evan Green wrote:
> > On Tue, Jun 27, 2023 at 7:38 AM Samuel Ortiz <sameo@rivosinc.com> wrote:
> > >
> > > From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> > >
> > > This patch parses Zb/Zk related string from DT and
> 
> %s/This patch//
> 
> > > output them in cpuinfo
> > >
> > > One thing worth noting is that if DT provides zk,
> > > all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> 
> Please explain why this is okay.
> 
> > > Note that zk is a valid extension name and the current
> > > DT binding spec allows this.
> > >
> > > This patch also changes the logical id of
> > > existing multi-letter extensions and adds a statement
> > > that instead of logical id compatibility, the order
> > > is needed.
> 
> Does it?
> 
> > > There currently lacks a mechanism to merge them when
> > > producing cpuinfo. Namely if you provide a riscv,isa
> > > "rv64imafdc_zk_zks", the cpuinfo output would be
> > > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> > > _zksh_zkt"
> 
> I think this is fine.
> 
> Please re-wrap this all to 72 characters.
> 
> > >
> > > Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> > > Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> 
> This is missing your SoB Samuel.
> 
> > > ---
> > >  arch/riscv/include/asm/hwcap.h | 11 +++++++++++
> > >  arch/riscv/kernel/cpu.c        | 11 +++++++++++
> > >  arch/riscv/kernel/cpufeature.c | 30 ++++++++++++++++++++++++++++++
> > >  3 files changed, 52 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > index f041bfa7f6a0..b80ca6e77088 100644
> > > --- a/arch/riscv/include/asm/hwcap.h
> > > +++ b/arch/riscv/include/asm/hwcap.h
> > > @@ -53,6 +53,17 @@
> > >  #define RISCV_ISA_EXT_ZICSR            40
> > >  #define RISCV_ISA_EXT_ZIFENCEI         41
> > >  #define RISCV_ISA_EXT_ZIHPM            42
> > > +#define RISCV_ISA_EXT_ZBC              43
> > > +#define RISCV_ISA_EXT_ZBKB             44
> > > +#define RISCV_ISA_EXT_ZBKC             45
> > > +#define RISCV_ISA_EXT_ZBKX             46
> > > +#define RISCV_ISA_EXT_ZKND             47
> > > +#define RISCV_ISA_EXT_ZKNE             48
> > > +#define RISCV_ISA_EXT_ZKNH             49
> > > +#define RISCV_ISA_EXT_ZKR              50
> > > +#define RISCV_ISA_EXT_ZKSED            51
> > > +#define RISCV_ISA_EXT_ZKSH             52
> > > +#define RISCV_ISA_EXT_ZKT              53
> > >
> > >  #define RISCV_ISA_EXT_MAX              64
> > >  #define RISCV_ISA_EXT_NAME_LEN_MAX     32
> > > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > > index a2fc952318e9..10524322a4c0 100644
> > > --- a/arch/riscv/kernel/cpu.c
> > > +++ b/arch/riscv/kernel/cpu.c
> > > @@ -215,7 +215,18 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
> > >         __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> > >         __RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> > >         __RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> > > +       __RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> > > +       __RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
> > > +       __RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
> > > +       __RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
> > >         __RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> > > +       __RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> > > +       __RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> > > +       __RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> > > +       __RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> > > +       __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> > > +       __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> > > +       __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> > >         __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> > >         __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> > >         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > index bdcf460ea53d..447f853a5a4c 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -309,10 +309,40 @@ void __init riscv_fill_hwcap(void)
> > >                                 SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> > >                                 SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
> > >                                 SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
> > > +                               SET_ISA_EXT_MAP("zbc", RISCV_ISA_EXT_ZBC);
> > >                                 SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS);
> > > +                               SET_ISA_EXT_MAP("zbkb", RISCV_ISA_EXT_ZBKB);
> 
> This order does not look correct, please add them in alphanumerical
> order as the comment these SET_ISA_EXT_MAP()s requests. Ditto below.
> 
> > > +                               SET_ISA_EXT_MAP("zbkc", RISCV_ISA_EXT_ZBKC);
> > > +                               SET_ISA_EXT_MAP("zbks", RISCV_ISA_EXT_ZBKX);
> > 
> > Should "zbks" be "zbkx"?
> > 
> > >                                 SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
> > >                                 SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
> > >                                 SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> > > +                               SET_ISA_EXT_MAP("zksed", RISCV_ISA_EXT_ZKSED);
> > > +                               SET_ISA_EXT_MAP("zksh", RISCV_ISA_EXT_ZKSH);
> > > +                               SET_ISA_EXT_MAP("zkr", RISCV_ISA_EXT_ZKR);
> > > +                               SET_ISA_EXT_MAP("zkt", RISCV_ISA_EXT_ZKT);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKB);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKC);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKX);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKND);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNE);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNH);
> > > +                               SET_ISA_EXT_MAP("zknd", RISCV_ISA_EXT_ZKND);
> > > +                               SET_ISA_EXT_MAP("zkne", RISCV_ISA_EXT_ZKNE);
> > > +                               SET_ISA_EXT_MAP("zknh", RISCV_ISA_EXT_ZKNH);
> > > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKB);
> > > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKC);
> > > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKX);
> > > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSED);
> > > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSH);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKB);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKC);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKX);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKND);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNE);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNH);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKR);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKT);
> > 
> > It would be nice to consolidate the ones together that search for a
> > single string and set multiple bits, though I don't have any super
> > elegant ideas for how off the top of my head.
> 
> I've got a refactor of this code in progress, dropping all of these
> copy-paste in place of a loop. It certainly looks more elegant than
> this, but it will fall over a bit for these "one string matches many
> extensions" cases. See here:
> https://patchwork.kernel.org/project/linux-riscv/patch/20230626-thieving-jockstrap-d35d20b535c5@wendy/
> My immediate thought is to add another element to riscv_isa_ext_data,
> that contains "parent" extensions to check for. Should be fairly doable,
> I'll whip something up on top of that...

Nice, and thanks for the review.
Should I wait for your refactor to be merged before pushing this one?

Cheers,
Samuel.

