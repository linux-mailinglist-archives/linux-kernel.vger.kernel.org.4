Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874CB704905
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjEPJV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjEPJVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:21:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5E11997;
        Tue, 16 May 2023 02:20:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so17627175e9.1;
        Tue, 16 May 2023 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684228833; x=1686820833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bf8niA9dFNqb8/6zqk0cfY1upregS7xh6PWdNGORQhM=;
        b=mUot4xoBX4iGmqkstjP8aDJ3zBNwYhA2G4z426kWrguLoC0BitUwFzUzMQnxxEIgHA
         FtbopgdIm35fJX5ntP5FINCK308Gd6qTfq/m+efAJUTNYfLeflcddgt016YnNIE4VnOM
         YI5ocNCinhb7Sf9b2UDZFacTlcZsSt48XAz48AtqZnvfgrGRpJbYtTR1gKvxMLpCBAcu
         oQ0ZVyQQWStLf8S430aUj42YpUpaFWHaMQGWuYJUSw22k0qpkfAuT5LPwvUYSIhix61o
         lfoHB3/7Gobohxx4bSogCvdsogiyVX1VbtH4RHigNT3CsH3gPHHfXbJJZaXv/zUw/K5r
         dfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228833; x=1686820833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bf8niA9dFNqb8/6zqk0cfY1upregS7xh6PWdNGORQhM=;
        b=Y/DrMUY8TitrLqXMxLlxQ25QtcsdaQ+Rmf+zvJhVmWMtcny8/vjX2K+NTcRiey51i4
         yctr9GtjlUA8vhizu9ckBOxp3tyh9JCP40y0ioHbA2WvHaV3NHbjEYrBYSkB2aVJEr//
         TlRfWJzj8aj153U9vAMimPPE+I3KWmDJVhr1QxDH17cz8APH7lnOih/X6Jvv33xzM3Yr
         GaoMpbU6JtL52CidPmUQmyaPRrOBF5+2/FtwMJKIckS9jpPsyeeM3bYdYPhRxqC8Sk9k
         7TgumqT/xid5JeXMP7FDKObjzWZsF++iqvCVmTGCyzavyiEhbDIq/g6G46uLs1TN3AZj
         3wzA==
X-Gm-Message-State: AC+VfDzhXNLXLwQIf+QL38nt3iJvopqJEIZiHSfuPaeFxX3UG2Mje9Nc
        OBdENQHdJiD1hxcZq6zvrw4=
X-Google-Smtp-Source: ACHHUZ5eDj7Yehs023857OsvA5mGGLmTFEZC+rtL63WQL5IwzfcHatKOCLG6ZMbny3CyAgPXBC80PA==
X-Received: by 2002:adf:f2ca:0:b0:307:8b6f:dcf1 with SMTP id d10-20020adff2ca000000b003078b6fdcf1mr24326445wrp.25.1684228833127;
        Tue, 16 May 2023 02:20:33 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id r14-20020a5d494e000000b003063a92bbf5sm1904018wrs.70.2023.05.16.02.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:20:32 -0700 (PDT)
Date:   Tue, 16 May 2023 10:20:30 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/246] 6.3.3-rc1 review
Message-ID: <ZGNK3vxOsQXf3d9K@debian>
References: <20230515161722.610123835@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:23:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.3 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.2.1 20230511):
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

[1]. https://openqa.qa.codethink.co.uk/tests/3539
[2]. https://openqa.qa.codethink.co.uk/tests/3540

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
