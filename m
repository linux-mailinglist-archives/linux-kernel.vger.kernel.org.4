Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99C47369C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjFTKqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjFTKqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:46:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF7A197;
        Tue, 20 Jun 2023 03:46:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so2636447f8f.3;
        Tue, 20 Jun 2023 03:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687257991; x=1689849991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3Pe3mydueWhf/EywBBfkVfhRK27666VDF44tjUu2/Q=;
        b=SdaMIDLqdPJh8Vec5iSw5088pyHl35AsClNybTdZWBxVa2jdc5Y4/cR+190TLISoUe
         Lu0X92/tMfZowY2Xf8/BvrESQuAjT7S17R1hJ+vFBFTO8H6YHcUPKpvHTns3r98jWnj/
         EtGEglTa0WyzxUPDMAWKrIZs3QJM8Mtl5IG2JdyvA0kOKMd9RzIkxYv53fojeIlT6YMW
         WHpDSo8HWuklNb63H6REpawGdNJTELHljMkT9XHK+BeIhzYw2ZNR3BgmJxyWtk9xowG3
         AW6/mLCEgS5U/XCHRL7TjUPPWwXaYitbiupxO4tKtlvCgM5FxSaaZy8X+Gl0CuFzExBW
         m48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687257991; x=1689849991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3Pe3mydueWhf/EywBBfkVfhRK27666VDF44tjUu2/Q=;
        b=cJL7hb55nnL2UObXeFNNWNwMMd/AlBdKE02tIuCr75HNVAOVamtvfdxJqI9Eu5mK/p
         vyTNe6bluuNEwW3gKXaA1IGlxhACAuwwEWJin/O3Ba6HsC7gz7WXoqNDsfmOD/YfhWog
         VgAJPDplGVuScujVROdq84n4F8O4ke1fdio4MQIT6s0s9y0bo+BgTGCyTheOSo/LbZBa
         aomCRuGjq9ybEH7kndCmGFdpfyA37tFta52HF5ln3dtkjsjOhB/DpdCHzmhkBbaAoxN6
         dmJx0O91xKNgIUjT9sZM2U3dYWJxrKd/8yKk7pXq+G6tFzs3fJKt/VRliftq9EPFvR6K
         LZFQ==
X-Gm-Message-State: AC+VfDx4t/hYsXa4EUQNVB+LPA4MQZdgQP5h3hpzVHGKaGu0PTHA6OC7
        n47ac45mlcAVqLPjRClRTgY=
X-Google-Smtp-Source: ACHHUZ6J8aXfN+SopC1GpwsGgSPJ9huSWBkuml1Tpr+XaxNE+yHkG03hLO0SuFduqh4BLvgCys8+eQ==
X-Received: by 2002:adf:f392:0:b0:312:74a9:8262 with SMTP id m18-20020adff392000000b0031274a98262mr2880447wro.62.1687257991079;
        Tue, 20 Jun 2023 03:46:31 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b003113ccbf388sm1744620wrt.13.2023.06.20.03.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 03:46:30 -0700 (PDT)
Date:   Tue, 20 Jun 2023 11:46:29 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 4.19 00/49] 4.19.287-rc1 review
Message-ID: <ZJGDhS1ZR6Zgw5tD@debian>
References: <20230619102129.856988902@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jun 19, 2023 at 12:29:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.287 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 63 configs -> 3  failures
arm: 115 configs -> no failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Note:

mips db1xxx_defconfig, gpr_defconfig and mtx1_defconfig failed to build with:

arch/mips/alchemy/common/dbdma.c:33:10: fatal error: linux/dma-map-ops.h: No such file or directory
   33 | #include <linux/dma-map-ops.h> /* for dma_default_coherent */
      |          ^~~~~~~~~~~~~~~~~~~~~


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/4064


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
