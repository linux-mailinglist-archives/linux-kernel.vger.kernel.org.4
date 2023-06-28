Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EFB740E46
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjF1KIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjF1KE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:04:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25E35B1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:59:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso30283995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687946386; x=1690538386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JtKFdqVLaSwnYyY9I8QOzCILW202QthGc5gJj1llyKw=;
        b=o4iDWEs+61QW05slbiKCk13Lv8rf7lTHCQQV46/s3ATenQeXbm8EM4S1OLUvOWrGV9
         9w7cItdCiIhRbgI6LgTqTiRTUG/cgOyAso6iccw8WYZiops+TNzcegGI2ijb9lLqabcn
         XE26qdQ1ZF/lh5EahJVSo8xW0uyNqKhDqVNVZYrhHmV/XM8w6Hqwm5YfzJEQFTOzyzxM
         yGfb9ru59Jfo85ur/iW4HyGdMGLRrcbg0byB8NNKj7jhWQhZx8t2nF0bHZ2jkQ7XhGUS
         i+0Z1wqCOnaKTsLX6unC/IDZNHY9BLqUnxDiJdI+o9bD3SnEuru2kl9ZhW0cSYYMLgXF
         4wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687946386; x=1690538386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtKFdqVLaSwnYyY9I8QOzCILW202QthGc5gJj1llyKw=;
        b=JnxHPhHgt4TxsZJMpKqsAs2joMe1pz/ZuywBbnJIwu+vkThEsLu4TDnPTJHPhIxA7e
         kdYptX1m7PafmgBHSEzJPVOZ/Z0Lp1knihw3gqGj3lyf/un5MoTMzs/UzgWVu8VhTRH/
         MyCb2rbD2bl3aSPxRFkp6MFhq5Vl/JThj0hmKxc/+iYFXn6+tCKIw0+0519ywOV2sJN2
         pyvQhnmbXeXwCcqH2owanKZwef5q40YFczY5BqUAIixBdXlGfUQv9V8gZWVlSrp2PSIA
         YSZDC5M6Pyc8g194SDM20T0adCQ2exEkyhQdZoz8sM/kiEFIty+DNk2WYA77sQ+38FOU
         tL5w==
X-Gm-Message-State: AC+VfDxvl4nRGuBh7yUKo53aSP2x3WATzP4hxwJkGBTeQ+k3xBzFFryr
        +8qVEIWmOyZKB5st4rU5f5FUBw==
X-Google-Smtp-Source: ACHHUZ4KPwDuPEzHggGf2J1dNOkOMwM93c3sV7GQHED5yGaUZQXVpC30d6ZPz0rbrzEYvrN9TWcevw==
X-Received: by 2002:adf:f44f:0:b0:314:37d:9899 with SMTP id f15-20020adff44f000000b00314037d9899mr4149402wrp.42.1687946385846;
        Wed, 28 Jun 2023 02:59:45 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id a10-20020adfdd0a000000b0030af15d7e41sm13081542wrm.4.2023.06.28.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:59:45 -0700 (PDT)
Date:   Wed, 28 Jun 2023 11:59:43 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     "Hongren (Zenithal) Zheng" <i@zenithal.me>
Cc:     Conor Dooley <conor@kernel.org>, Evan Green <evan@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <ZJwEj710jhXoKHfm@vermeer>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-2-sameo@rivosinc.com>
 <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
 <20230627-debating-twelve-da2c1ed60948@spud>
 <ZJsyntnQ/FDXgNPk@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJsyntnQ/FDXgNPk@Sun>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 03:03:58AM +0800, Hongren (Zenithal) Zheng wrote:
> On Tue, Jun 27, 2023 at 07:48:15PM +0100, Conor Dooley wrote:
> > On Tue, Jun 27, 2023 at 11:14:30AM -0700, Evan Green wrote:
> > > On Tue, Jun 27, 2023 at 7:38 AM Samuel Ortiz <sameo@rivosinc.com> wrote:
> > > >
> > > > From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> > > >
> > > > This patch parses Zb/Zk related string from DT and
> > 
> > %s/This patch//
> > 
> > > > output them in cpuinfo
> > > >
> > > > One thing worth noting is that if DT provides zk,
> > > > all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> > 
> > Please explain why this is okay.
> 
> From riscv scalar crypto spec, zk is a shorthand
> for zkn, zkr and zkt and zkn also includes zbkb, zbkc
> and zbkx.
> 
> > 
> > > > Note that zk is a valid extension name and the current
> > > > DT binding spec allows this.
> > > >
> > > > This patch also changes the logical id of
> > > > existing multi-letter extensions and adds a statement
> > > > that instead of logical id compatibility, the order
> > > > is needed.
> > 
> > Does it?
> 
> That is in the old version of this patch,
> should be removed now
> see https://lore.kernel.org/linux-riscv/YqY0aSngjI0Hc5d4@Sun/
> 
> > 
> > > > There currently lacks a mechanism to merge them when
> > > > producing cpuinfo. Namely if you provide a riscv,isa
> > > > "rv64imafdc_zk_zks", the cpuinfo output would be
> > > > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> > > > _zksh_zkt"
> > 
> > I think this is fine.
> > 
> > Please re-wrap this all to 72 characters.
> > 
> > > >
> > > > Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> > > > Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> > 
> > This is missing your SoB Samuel.
> > 
> > > > ---
> > > >  arch/riscv/include/asm/hwcap.h | 11 +++++++++++
> > > >  arch/riscv/kernel/cpu.c        | 11 +++++++++++
> > > >  arch/riscv/kernel/cpufeature.c | 30 ++++++++++++++++++++++++++++++
> > > >  3 files changed, 52 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > > index f041bfa7f6a0..b80ca6e77088 100644
> > > > --- a/arch/riscv/include/asm/hwcap.h
> > > > +++ b/arch/riscv/include/asm/hwcap.h
> > > > @@ -53,6 +53,17 @@
> > > >  #define RISCV_ISA_EXT_ZICSR            40
> > > >  #define RISCV_ISA_EXT_ZIFENCEI         41
> > > >  #define RISCV_ISA_EXT_ZIHPM            42
> > > > +#define RISCV_ISA_EXT_ZBC              43
> > > > +#define RISCV_ISA_EXT_ZBKB             44
> > > > +#define RISCV_ISA_EXT_ZBKC             45
> > > > +#define RISCV_ISA_EXT_ZBKX             46
> > > > +#define RISCV_ISA_EXT_ZKND             47
> > > > +#define RISCV_ISA_EXT_ZKNE             48
> > > > +#define RISCV_ISA_EXT_ZKNH             49
> > > > +#define RISCV_ISA_EXT_ZKR              50
> > > > +#define RISCV_ISA_EXT_ZKSED            51
> > > > +#define RISCV_ISA_EXT_ZKSH             52
> > > > +#define RISCV_ISA_EXT_ZKT              53
> > > >
> > > >  #define RISCV_ISA_EXT_MAX              64
> > > >  #define RISCV_ISA_EXT_NAME_LEN_MAX     32
> > > > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > > > index a2fc952318e9..10524322a4c0 100644
> > > > --- a/arch/riscv/kernel/cpu.c
> > > > +++ b/arch/riscv/kernel/cpu.c
> > > > @@ -215,7 +215,18 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
> > > >         __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> > > >         __RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> > > >         __RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> > > > +       __RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> > > > +       __RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
> > > > +       __RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
> > > > +       __RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
> > > >         __RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> > > > +       __RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> > > > +       __RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> > > > +       __RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> > > > +       __RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> > > > +       __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> > > > +       __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> > > > +       __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> > > >         __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> > > >         __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> > > >         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > > index bdcf460ea53d..447f853a5a4c 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -309,10 +309,40 @@ void __init riscv_fill_hwcap(void)
> > > >                                 SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> > > >                                 SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
> > > >                                 SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
> > > > +                               SET_ISA_EXT_MAP("zbc", RISCV_ISA_EXT_ZBC);
> > > >                                 SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS);
> > > > +                               SET_ISA_EXT_MAP("zbkb", RISCV_ISA_EXT_ZBKB);
> > 
> > This order does not look correct, please add them in alphanumerical
> > order as the comment these SET_ISA_EXT_MAP()s requests. Ditto below.
> 
> Agreed. Seems that I did not worked carefully for this part.

Or it could be me when rebasing that patch. In any case, it will be
fixed with v2 of the patch.

Cheers,
Samuel.
