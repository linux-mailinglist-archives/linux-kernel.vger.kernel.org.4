Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15CC5F6B3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJFQKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiJFQKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:10:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E90AC3BF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:10:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1223424wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xjt0SMWShN0p36N92cYaAd33vU82ZeIhktK3vx+Fq8o=;
        b=Qq3wiJE5cx3pYeRKUhp8JNeRQZtYpGGMuEE8co2n0n9LEe2UflcdPiP+G5dWGXETke
         IUDRutkr5ryYoYakptG6wijYnvolcZat5o6sGZxOojMKdh0Lm4n9wDngceeX2mdaaYFD
         qYhlTaZDexa6DfOWBx7GFrH68gFc3TgAPqOfX3/kJUmNsWYKDq93XV+ABqlh65IeqpOb
         mfIs5pKVqI+cOzhGQGi5w8LBLo0Me6DSZTa772aKWYXO6X4qH7a+cd9H1qxnf4miOfP5
         nyU0xBDF/mnareXlBtyoT0NktRNmhS1Qrph31aqWcAXCp5X4JcV/LuC1boOj/AJGC3lE
         LXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xjt0SMWShN0p36N92cYaAd33vU82ZeIhktK3vx+Fq8o=;
        b=QuhRag0pDNC/lCIKc8wWNUhS4gh3srHCaKMbVX2EyewgYUmfT0lYPKE0Dr/oCN25oL
         JRCSjNKDqUgUKTXHZauOOnElEELMFp1N7eYc7QU3OSww7JNL7AocBlo2IKpY6MEPo3M2
         uCiu+0heJPvHk6jklT7s53fESz9fm+15PUBs/3bMZLePzZctWVSeUPVYxM1VWhO+PXca
         kJ2/tjVykUhaX8cWAZ4zIBQRiasOIZSzot2Gt704iAf0tU1cWbUOBeFrgldwFmzCwYdO
         o3wY/pwDm6fcrbW1tccNujH/4kPjuU3Z531AwjeDy2hGSHaMO6gz/KvjmCcR0uJsGzew
         hucQ==
X-Gm-Message-State: ACrzQf0o1kJGdI1bXNH+oUbXeIocmtgokoSogjiHMr/o9/Qza7vNqdjD
        u2o8DFsLYjggv9cA0fyQlCOO1w==
X-Google-Smtp-Source: AMsMyM757hT0GLpVIT0mFBeyt2yGIWf7MwkGZ1iOb2TeR7Wvt70BJA0k+odBfGOrypk3Og7Ybvr2TA==
X-Received: by 2002:a05:600c:20b:b0:3b4:86ff:cd with SMTP id 11-20020a05600c020b00b003b486ff00cdmr7504099wmi.35.1665072638940;
        Thu, 06 Oct 2022 09:10:38 -0700 (PDT)
Received: from smtpclient.apple (global-5-142.n-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c3b0700b003a1980d55c4sm6172412wms.47.2022.10.06.09.10.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2022 09:10:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] riscv: fix multi-letter extension compare
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20221006070257.11632-1-nikita.shubin@maquefel.me>
Date:   Thu, 6 Oct 2022 17:10:37 +0100
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yury Norov <yury.norov@gmail.com>,
        Nikita Shubin <n.shubin@yadro.com>,
        Anup Patel <anup@brainfault.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux <linux@yadro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E75B9DE8-8943-4F40-8374-2E74C50D7A00@jrtc27.com>
References: <20221006070257.11632-1-nikita.shubin@maquefel.me>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Oct 2022, at 08:02, Nikita Shubin <nikita.shubin@maquefel.me> =
wrote:
>=20
> From: Nikita Shubin <n.shubin@yadro.com>
>=20
> Increment ext pointer to match letters after 'z' character, so it =
points
> to actual extension name.
>=20
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
> Hello Atish,
>=20
> Sorry to blame you, but i double checked this and i don't see a way=20
> how extensions from device tree could be successfully matched with=20
> encoded ones without incrementing the ext pointer or prepending=20
> the encoded extensions with 'z' letter.
>=20
> I have no idea how this could slip through review - am i missing =
something ?
> ---
> arch/riscv/kernel/cpufeature.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/kernel/cpufeature.c =
b/arch/riscv/kernel/cpufeature.c
> index 3b5583db9d80..031546052dc0 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -199,6 +199,7 @@ void __init riscv_fill_hwcap(void)
> 				this_hwcap |=3D isa2hwcap[(unsigned =
char)(*ext)];
> 				set_bit(*ext - 'a', this_isa);
> 			} else {
> +				ext++;
> 				SET_ISA_EXT_MAP("sscofpmf", =
RISCV_ISA_EXT_SSCOFPMF);
> 				SET_ISA_EXT_MAP("svpbmt", =
RISCV_ISA_EXT_SVPBMT);
> 				SET_ISA_EXT_MAP("zicbom", =
RISCV_ISA_EXT_ZICBOM);

This makes no sense. The single-letter prefix that=E2=80=99s part of the =
actual
extension name is already in the string there, whether s or z. Your
code means (a) you=E2=80=99d have to double up the prefix in the device =
tree
(which is obviously wrong) (b) you could use s or z interchangeably as
the first character (e.g. you=E2=80=99d make zzicbom and szicbom parsed =
as
zicbom).

Are you actually seeing a bug? Did you test this at all? This looks
like you misunderstood code and wrote an untested patch for a bug you
thought you saw.

Jess

> --=20
> 2.35.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

