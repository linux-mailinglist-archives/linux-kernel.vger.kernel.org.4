Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2659072E2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242386AbjFMMUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242465AbjFMMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:19:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A4A1738;
        Tue, 13 Jun 2023 05:19:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f122ff663eso6604443e87.2;
        Tue, 13 Jun 2023 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686658777; x=1689250777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzJgGG/CDYOhD2YNQTv2CpS/TSd4Qcu56zqodO6IyB4=;
        b=Qbe/SL0po5bwWWWFREV7MhlgjuwUoGjUD82KbJ/MQ2qc0C8XQmnPG3w2pzBDWaBxjq
         pHbZWbhF0e9FOhM1kxt3TbkRYjMuGDGI7W2r0DPVbQxlZgu+EgBeKAr/FARcUpP+88ds
         uS3SMi98EB6c502dbpLPxEkzoFpKcsxGPDkhXY3xCcvXZxCC+RJH7l3zfMmTUD/G7rbI
         NSz3t9a7S6sE6U0tHECE02oadhCvLOxmR5J+jF/ZLEMj+WczhTB6Jin8yS46gIvx2Q/D
         2sYvlkQd2kYY2lvTMLf6cXTS0xuS9fnWaWKZoVFwDQiSglQ2pgErQ9jZqmEvXtrno1OC
         dNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658777; x=1689250777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzJgGG/CDYOhD2YNQTv2CpS/TSd4Qcu56zqodO6IyB4=;
        b=VjcHUBmsLtF8bdJLWlcTvJqEMhNPUpG6JcgvNamVUOtHSpeUoIhU/DJ6HzQABaqB96
         QmI8EdqHzhim5vN/LuG9nK7BtWQsTCHjxc97qt4J1wsAoes4ZcVQ7ZEHqbfMWu6bZH2c
         5/yb9Yo5QvE9sMSSu4zCSAUxwKHoRof9JJWV5dN0AsRRz3HlIh+nDMB5Xiri7W8U/GAG
         HQRCGR4CIfnbHJu46yRZkWn6YJpFixidyxXJ7mD8fqmbwQ7ERhtWI7qERuGisLHzCOqE
         SJcj9npRHSoHZMxYW4y3Yn1hxd7NzDihr0f6OBsKlGkMVp63MIMWjYXWjlG4AEK9FbbC
         OydA==
X-Gm-Message-State: AC+VfDwP/HPOTo3eojSqcLVkDz5hN1Gie/WYkiI8w/n7dGeDOtG7qiGC
        fVTg5ox3XbTcnQuYmH1FOQU=
X-Google-Smtp-Source: ACHHUZ73NS69UjggKVhkFEj2G1DBNP2JULH1k7n4O+6a0aEVHacXcSMiSNDEOlOremukbrwfskSwHw==
X-Received: by 2002:a19:5f0d:0:b0:4f6:26de:502e with SMTP id t13-20020a195f0d000000b004f626de502emr5281226lfb.43.1686658777047;
        Tue, 13 Jun 2023 05:19:37 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id x19-20020a1c7c13000000b003f7aad8c160sm14252269wmc.11.2023.06.13.05.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:19:36 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:19:34 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/91] 5.15.117-rc1 review
Message-ID: <ZIhe1sDoz1bNjjcS@debian>
References: <20230612101702.085813286@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
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

On Mon, Jun 12, 2023 at 12:25:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.117 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.2.1 20230511):
mips: 62 configs -> no failure
arm: 99 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/3932
[2]. https://openqa.qa.codethink.co.uk/tests/3919
[3]. https://openqa.qa.codethink.co.uk/tests/3918

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
