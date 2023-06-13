Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5878472E29D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbjFMMPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbjFMMPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:15:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470F0CE;
        Tue, 13 Jun 2023 05:15:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f624daccd1so6333875e87.0;
        Tue, 13 Jun 2023 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686658520; x=1689250520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCn0G1jAnb2l8Q0t3TTQQkzbNPgWAe0+4F+PNu0+i5U=;
        b=JvBdOhW6oGIW/DglOocdvFBfzz7v/c/7iafIda4MlyDs6RqoB+Vn8mTDKqxKH8H8QU
         yNKLgzXcEg61X+wdUvh7jho+5P0gXvtGdUikaXBCDPqfDBMgvlyCU5FTWZ1C4gWMnwlA
         XGAR8SnFCw4RhWHvwoKM7Uc4B8m8QqgPZmEDyzrsvgFmjEEPcn3YO4qV9XxEx3T15kNH
         zg+1cFJK4CuKniOmcXiNaqz02UYo52k36jVJj+OKLSKJuE4f0+f7aMQIK4yljav6snv+
         h+kGY27R5CbXoRcDTAC7q3eBOJ0pqJUJSL3d5jfUMNJYWl/AhHVqgk3eMasB7R2Kxj6A
         iRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658520; x=1689250520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCn0G1jAnb2l8Q0t3TTQQkzbNPgWAe0+4F+PNu0+i5U=;
        b=EiAifbS5MjihRtOsKWIJnQaintgDx7jc7ly1/LoMjPcNmy+sJ+vB7eFksmVLknAgEx
         pC8yaNkQLsKtHl4k1zI7expvabsUNqnh93g/ld0EC19wFZQwHn2HRwVwtQYWJzklBWcX
         PeJXNyJO2vDxPfEIkavV+Bifec3taLsfqWL4wMM5kjwnNDllSeKlBX49ymO7XnQ2yk3m
         BMLVhiRjJSS7ZLA/yShgz/Jz7wW6mZ9eq0B7FRu3rAIyS9RtLAOPA7muRqvIt+JnoQyf
         U3scw69jzIdZffvNnH370Z21327NWvmxc/UWX5W2tPBEtd0VeLJdEcKH7KAYCnZfKKd5
         JA4g==
X-Gm-Message-State: AC+VfDx6X8bXF6ddRyuPU/KXYJTbreciejMelZO6iWJqBEXdwYorUrUa
        mdO3mwy57N99iAV5Tp7pJPI=
X-Google-Smtp-Source: ACHHUZ5lYQq79DmjmQHtNhpGflnqbhW6uPcONxEUF8x8NFBH76Yyf5RnHUpKPfBAWteZVOYieJWk3g==
X-Received: by 2002:a05:6512:465:b0:4eb:18d:91de with SMTP id x5-20020a056512046500b004eb018d91demr5624773lfd.43.1686658520220;
        Tue, 13 Jun 2023 05:15:20 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f819dfa0ddsm7061913wmd.28.2023.06.13.05.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:15:19 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:15:17 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/132] 6.1.34-rc1 review
Message-ID: <ZIhd1WKf3SpKaVx2@debian>
References: <20230612101710.279705932@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
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

On Mon, Jun 12, 2023 at 12:25:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.34 release.
> There are 132 patches in this series, all will be posted as a response
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
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/3920
[2]. https://openqa.qa.codethink.co.uk/tests/3922
[3]. https://openqa.qa.codethink.co.uk/tests/3921

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
