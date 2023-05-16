Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4F7048F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjEPJTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjEPJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:18:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64165264;
        Tue, 16 May 2023 02:18:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so3221081f8f.2;
        Tue, 16 May 2023 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684228682; x=1686820682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7C9HShPKwn8h1fUg0l7Pz8YXH+XNLX9Yv4wxCqkHcAc=;
        b=Png6P3fgMfxfssVCej+KqOaJ1EANCqSziEoKlHUZpz7WG3OiRvQSJrn2iOW2Pao/Vw
         vKypo5Ybk/aTbUN23TEfT7qSpVchi0McYwxu6cIirZSkxb7BE4h6cNriHaOy/nhc33Xr
         559/6kQMGduAkgnhOOncbg9WlK1evK675Qjt9IqWbtDh/Ew4VgFvnO+E5+1YU56gk8oq
         RuM4raoxPhm9+OtjTnR6SxZFpBjBFL415k5JJz6Mk9pfS25ylXk1M7ePH/eolVtYz3g7
         pMfMlWBl0poA60rbrHKaXkRlJR0nS4wadQ1n4zWA/xA63iapr0diNaLrjisEARvYaUjS
         0d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228682; x=1686820682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C9HShPKwn8h1fUg0l7Pz8YXH+XNLX9Yv4wxCqkHcAc=;
        b=jNBqX9tEFOJlgpDD6A7yzU6EQIae4+651wXA1YGP4M0zALil2EpZZeMymDa3QlxyS/
         ftg3oJHqEr6ln4LIzyWfTBftxW5/ZBNBqvyehA00gsPMYhRC+kR3rz4WGLnKVInTscr3
         DcHQLdyNMhRADDN/kGdPzxnMcR2cT3ZOGDRtSRxCoQVcTRYZuwG1CUVCGqcF0x51XKYa
         C/NiX6KP6OMu2bXzNUe+4U/VhWbh5Vlg5EamO1erZZVKFRw3ZUOCFNUBscAhgxR9GRft
         Rvem+MQTCdiaVCn9Yc4BlnMNMd5RA0DNunOnNvZftTL2/K+sebudK5i/2WhnXJn7kCrf
         8fEQ==
X-Gm-Message-State: AC+VfDyC7mhHgv5Cho4EDbXtye1iZ8F5gcBx6X75wnkUE9OHbr3QWRXP
        Osf3SWHfUv9drBzhCb8XnxY=
X-Google-Smtp-Source: ACHHUZ5XxE7qkMmTY2Ehr4lBCAHIRMo7+Pum83kyN9HK6pUBwpPFdqnjef/S9r0pjX2Zm5CLJgxu1g==
X-Received: by 2002:adf:e948:0:b0:306:2aac:4b84 with SMTP id m8-20020adfe948000000b003062aac4b84mr27823524wrn.30.1684228682000;
        Tue, 16 May 2023 02:18:02 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id q12-20020adfea0c000000b003078354f774sm1901829wrm.36.2023.05.16.02.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:18:01 -0700 (PDT)
Date:   Tue, 16 May 2023 10:17:59 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/239] 6.1.29-rc1 review
Message-ID: <ZGNKRxgT8wj/CO1e@debian>
References: <20230515161721.545370111@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:24:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.29 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.2.1 20230511):
mips: 52 configs -> no failure
arm: 100 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]

[1]. https://openqa.qa.codethink.co.uk/tests/3535
[2]. https://openqa.qa.codethink.co.uk/tests/3536

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
