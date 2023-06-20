Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0538B736A39
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFTLET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjFTLER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:04:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C416ADB;
        Tue, 20 Jun 2023 04:04:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f9b1a117caso17479775e9.0;
        Tue, 20 Jun 2023 04:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687259054; x=1689851054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1k3rGnyXvdKjWguVkT115FPYubbJOTIhBUBMhUo48I=;
        b=SS9wwZh3bfCPL3dB/ihqCc9IQwTSy1m2MKfJvQ/FVGvqki9SijHFbLiSzOTk5rOHlP
         r83R653DnOrRjDQ4PH2MHR5u4Ft3DzJqcxHIxgnqRRaQovugfR+2eml1HhK/NpqTaCyN
         6CjvL6OY8I2bUEsNbrsClGT8tZ5kB4Dta5Q+sfAaP8dKy3NlrFHCRGHPklZOnf0dxauT
         xSldxZXdTAUL58QOS2h3xyTPXjr8EKaoR8ZBnVOLyamtl/iGXLRVQZuv5iJEfdQ7In4v
         oe6ti7ftxRTK1F1NNSuhxYPI7FqO6FjmtdsSviX7KaTjuhWTIDYiuyxMdy8cjA0cTZTY
         X45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259054; x=1689851054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1k3rGnyXvdKjWguVkT115FPYubbJOTIhBUBMhUo48I=;
        b=kyUFApSjqP8+ZUfExj2xNeB5JTLRlETLF5L6yY9gIqohJh4Fr2pHuZWU32e217fBH6
         ryR3a4Z/Zv8rwE7FtKzm4eSqKjWj+zYqnclB+RO7PiwfR97Fed05Zvb+jP51PCSprH5J
         a8MLP58euvOm9d3kNfwpMsZLXWPFf04rLX4u18z2EQAmWaSw4m0opbzsYTYJ9LI+W1HU
         4yCgfsb0reoEcuXaII6tdAxyUT1sAjS9OGBtgtH+bfn3qZOsQ5Nr3KsZP7fi0fLU1h2t
         JTAGMWGADdtQPTbPRuZdDOw/svXGG2WKmjpvK/AhLFd+rruGnkxDXi4dVEkZmOrWwgmh
         uY/w==
X-Gm-Message-State: AC+VfDzQF+cm5bLcKy2RrQIBLJF/Uj6ZmCG0PY26b6n1mJ5WnCXYMxgu
        qTRaFy1pXcbhjcMgKIVdMRjotLZdylc=
X-Google-Smtp-Source: ACHHUZ5tmzX7Gky4FoWcYqK/XgAiBZmxx4GZwfY7Maprf5PGAjVNZO2ffi7wJPr4zJq4mCocezaMUw==
X-Received: by 2002:a05:600c:3797:b0:3f8:f749:efae with SMTP id o23-20020a05600c379700b003f8f749efaemr7880771wmr.33.1687259054028;
        Tue, 20 Jun 2023 04:04:14 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003f908ee3091sm8459764wmi.3.2023.06.20.04.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:04:13 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:04:12 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.10 00/89] 5.10.185-rc1 review
Message-ID: <ZJGHrHSvmNQHr2me@debian>
References: <20230619102138.279161276@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
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

On Mon, Jun 19, 2023 at 12:29:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.185 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 63 configs -> 3 failures
arm: 104 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Note:
mips db1xxx_defconfig, gpr_defconfig and mtx1_defconfig fails with:

arch/mips/alchemy/common/dbdma.c: In function 'au1xxx_dbdma_put_source':
arch/mips/alchemy/common/dbdma.c:632:14: error: 'dma_default_coherent' undeclared (first use in this function); did you mean 'dma_free_coherent'?
  632 |         if (!dma_default_coherent)
      |              ^~~~~~~~~~~~~~~~~~~~
      |              dma_free_coherent


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]

[1]. https://openqa.qa.codethink.co.uk/tests/4067
[2]. https://openqa.qa.codethink.co.uk/tests/4068


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
