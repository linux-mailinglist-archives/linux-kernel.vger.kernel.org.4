Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE46FD9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbjEJIom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEJIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:44:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41261E76;
        Wed, 10 May 2023 01:44:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30786c6082dso2987242f8f.2;
        Wed, 10 May 2023 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683708278; x=1686300278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLxz5DSWRRHerei3SoKL6mN5PRxkZvTh0Eu/+rq5yS8=;
        b=PZW3n26F+OUtxtGmsFx8VXNjQ+7l1GjGnGte6235H0O5CHFUK6p5w899Ch1oN6yvU3
         1wuir4l+K8fMumpU6BL/2aIHlj2mMR1S6CiAC3f5nF5t+yV9c0Cpnqy+d/iTnk1IoMOW
         ZaoSmkw39MJkEH12HANN1QSnh3Yp1e/ctadSuLC7kvmKxVfdOLhXaYav1yDLANKY5+dg
         3IXsoQWmtIPfTDmuz6D5d8x6Qj4FSofH5ac4Ugr2mpGmPx5+XbkvpBS+7Sx7oojMEmsH
         AdxkfrQvRt7zUR4aVOvb849a9heZbJRajILyl9vYmUr3G6e0AlWW5q+IUnZdYl6IOdej
         eDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708278; x=1686300278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLxz5DSWRRHerei3SoKL6mN5PRxkZvTh0Eu/+rq5yS8=;
        b=hm4dKfKXxAXuC1MTmpAp2W1u3ZWco73HeTb4X8c//OHxiKNd+mJTTnQCdwOAmWiBYx
         pj8DHKW4nw9rWEqSLtayA8+fkrNRQkU2OKI0ygqa83RscwYqLq+4Jb1Sc8Zh8bTKsaCZ
         KyMq1Qe6JtEzBT9dzkqer84Jo9w1LOzQyCWTlYhUu353s3Aeyb2PcIwfRRStkyfg+u0A
         9cm/OUM1YFNY0G4/I+DC8kXCxUPMvWX+wIj9TANPArRLNgrqbZPqL8HRvzHbJd2IvGVT
         R7IkCfNQ0+O7/w0iGy/Tp4ZFkPRyLt7L9GqxXIDB5iAuIbAkYw7XSv/LMi2i/OFc8AqO
         Ca5Q==
X-Gm-Message-State: AC+VfDz3i1sP4tZ1rR8Dol5YruoqFkb7/QVfEuq6B1/QkA4Lf8uEMpmD
        sbfeC97Ve3MzxN8CoL5fssi5uWDWwNM=
X-Google-Smtp-Source: ACHHUZ4q8vpCgrOqMElGtyhKewZlK52jUjwZq8EwMRh/PA/qJVyW5kp6PXsHUvRUZ/v0DvFMjjk4Lw==
X-Received: by 2002:a5d:6ac5:0:b0:306:3429:1833 with SMTP id u5-20020a5d6ac5000000b0030634291833mr11399556wrw.46.1683708277580;
        Wed, 10 May 2023 01:44:37 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k25-20020a05600c0b5900b003f4272c2d10sm7293517wmr.1.2023.05.10.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:44:37 -0700 (PDT)
Date:   Wed, 10 May 2023 09:44:35 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Message-ID: <ZFtZcwRcoTO3A6I0@debian>
References: <20230509030705.399628514@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509030705.399628514@linuxfoundation.org>
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

On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.2.1 20230501):
mips: 52 configs -> no failure
arm: 71 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/3494
[2]. https://openqa.qa.codethink.co.uk/tests/3495

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
