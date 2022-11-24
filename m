Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A07637E14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKXRMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKXRMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:12:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6D49095
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:12:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id cl5so3321000wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/WsFYZRX1AeNR+4gh8Ss2sIErXOewqR12PDDkr/27w=;
        b=vacYD0NQanWjuA3GOSjTYVZDBMGvfmF6Vd904OJHK9xcny70dfoX+cUOp7d6mejteg
         YO9NR4cjc28uDp/GqopCEMys2azE+iluRicx11RgU4nLC/RuWcAOK/yZIrJYHYkFXgSk
         7+Ig+KgaSF0c9G+v77P1qUvuk74Qwmq3CfMOXlVVOp8pXXnpnsZnM2cjDyyNiVC/aeug
         yE4ZycTnCAJ1QWBWeyI63GW1BggJOXMNZG0/vb3Yn9SbI4kcj3ffT4B1rwJNWUpmmInP
         d8E3XF9mS3Pn7qPQn+TadLMYt6w+QjQCx1Zr+S41tOU0RohrnaPpNllIqrshfs6gTZrC
         1lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/WsFYZRX1AeNR+4gh8Ss2sIErXOewqR12PDDkr/27w=;
        b=xAPSAc7UbIMnrGQCQsz1tu+2pxOFUyL9E6YzhUPutMYZSgkhbP140ZgDqYDmY1OmCA
         ZBN5EYLxZ040VwK8n7SB0HX0VkvtMaBd6bGqaj/dgMV/Nc0oXcphg1eP2hT3PmiRHOzB
         kOXQeF9zqD4FEX8V8tvdfW3b5LYoEPpZnIh9ljSXbjVKK90cp41//HvFKezk1+yre1sU
         CNGr+U4H0Rj1LgcypwKvyV5sqXYsl7/IhlsH9cr0tpGTIq8/neDHKAMt7XDRf6LRZ6ps
         cfLByj5iKdefhbYzj28MeFuEzyU1RtVk4j4pDPgB+idOnnoyX10qUBe4mipIm3Tj6Pbp
         FxZA==
X-Gm-Message-State: ANoB5pknXnOIkz6UAPlrtvUdbbzaR1ZTX32FYX1rjXfd+P/ICu3jFr5l
        WmmKO+6xI2atc8AOa4qyvTPBqQ==
X-Google-Smtp-Source: AA0mqf4EkcQPK/TpqP3c+qIXAMQp7K3u644h34Pd4fKfm/kHZIk0PLwVnfI5L6Hmb2D87tZnsQYcxQ==
X-Received: by 2002:a05:6000:156e:b0:241:cbe9:78a9 with SMTP id 14-20020a056000156e00b00241cbe978a9mr14665805wrz.529.1669309960015;
        Thu, 24 Nov 2022 09:12:40 -0800 (PST)
Received: from vermeer ([145.224.92.100])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4849000000b00228692033dcsm1750909wrs.91.2022.11.24.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:12:39 -0800 (PST)
Date:   Thu, 24 Nov 2022 18:12:36 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
Message-ID: <Y3+mBAV8oxphjHcJ@vermeer>
References: <YqYz+xDsXr/tNaNu@Sun>
 <YqY0i22SdbHjB/MX@Sun>
 <Y385rS/5zDaDJ3Os@vermeer>
 <Y39AXYPFzSiBngwI@wendy>
 <Y39Lwp4rQc3Qkl0i@vermeer>
 <Y39blUaC/jHiOYCk@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y39blUaC/jHiOYCk@wendy>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 11:55:01AM +0000, Conor Dooley wrote:
> On Thu, Nov 24, 2022 at 11:47:30AM +0100, Samuel Ortiz wrote:
> 
> > Patch #1 is definitely needed regardless of which interface we pick for
> > exposing the ISA strings to userspace.
> 
> I took another look at #1, and I feel more confused about what
> constitutes canonical order than I did before! If you know better than
> I, and you probably do since you're interested in these 6 month old
> patches, some insight would be appreciated!

Assuming we don't go with hwcap, I dont think the order of the
riscv_isa_ext_id enum matters that much?

iiuc we're building the cpuinfo string from the riscv_isa_ext_data
array, and I think the current code is incorrect:

static struct riscv_isa_ext_data isa_ext_arr[] = {
    __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
    __RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
    __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
    __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
    __RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
    __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
    __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
};

zicbom and zihintpause should come before supervisor level extensions.
I'm going to send a patch for that.

And the Zb/Zk ones should come after the Zi ones, and before the
supervisor level ones (The I category comes before the B or the K one).
So we should check that when patch #1 is rebased.

Cheers,
Samuel.

