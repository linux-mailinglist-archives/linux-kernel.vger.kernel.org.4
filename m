Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3229744652
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGADaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjGAD3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:29:22 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62B449F9;
        Fri, 30 Jun 2023 20:03:11 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a0457d6b77so2010310b6e.0;
        Fri, 30 Jun 2023 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688180591; x=1690772591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLPVDuMNu8QoPIrCuHyB3Va+xnlEJ/NgNsqkyyDjCyc=;
        b=JYvFoyIjhWkfWAIYCUgRczQwekYjM7kDmR53b5j57qXAAKYFhHcffIx5qGlXpWpSDK
         jiXvdf2V15TuxemgIXWSOzmAfRSN1ALvitlP3eBfLkQL342iYqvxKJuXdQIr6jzFGi7k
         byEu+T6I3bJInXqnXb+7fiB8HWKpREtkRQFT6HqUwKBYYgOvTgVNSYWY2K6V8ZRRIabs
         /7RE7/nNwAyRBnqPijiuK0m9mZD5SlMu9Gx6ujB5+PWfYroOwPtkWegP9avQBdOk1O6Y
         Qvz78ackb/p7ICnHxfV0oxDj60sZnD8kHPv514tvkArEucLadp16MTKg9zipsNH3jN6X
         uMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688180591; x=1690772591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLPVDuMNu8QoPIrCuHyB3Va+xnlEJ/NgNsqkyyDjCyc=;
        b=EArUb90vibnLiaN0brvtnGT/GPlJgOLH5/YrLBp9NEfRz9/OTkLGLYjzwVWuh/UXyF
         sQpt44bYWnYSpr63wWrnOt0LE42Cr6Bu0o+5gtbZaEZA223EzTDQQ5YZWZ6S0kiFTfJq
         RVSZKPM+D6uf3K8gTWuv/tOCyJ7YF8nscu5hpmLWW2sZ5v27go9uIHdORWjtVoSraTyf
         W/YPSAKHcfG+iApa5r0JJzZ1FCAx6+lgAji36CATE5hGNclHfC5sVU+EbzwrKE+fEtyo
         4Kdgxh4rUmilbPoAemp8UULWpNdWjS7TCV5u/XjLpKr/RCCsjPBPWdt3do4nPe8mnyPD
         AGBw==
X-Gm-Message-State: AC+VfDxt42BAtTy45ztinDg01jJsDinyDk/jJ4jmEQmosSqFZ8alnZi7
        Y37IhI7aJImD8+/uU1tcpyAWvXO5HJg=
X-Google-Smtp-Source: ACHHUZ75LvssH6Yx3LyBVIJFhCpmgOUIxglC/nRzy7Wt7L6yiDHPk9/ZNXK0ChdrTCt1PV+N59S6mA==
X-Received: by 2002:a05:6830:1288:b0:6b7:1e57:aa96 with SMTP id z8-20020a056830128800b006b71e57aa96mr4668578otp.6.1688179900746;
        Fri, 30 Jun 2023 19:51:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ne11-20020a17090b374b00b00259b729eea9sm11408080pjb.8.2023.06.30.19.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 19:51:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Jun 2023 19:51:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/33] 6.1.37-rc3 review
Message-ID: <7dc94d48-4e2e-4bb2-8a53-3555295b5a3e@roeck-us.net>
References: <20230630072124.944461414@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630072124.944461414@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:32:49AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.37 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Jul 2023 07:21:12 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 519 pass: 518 fail: 1
Failed tests:
	xtensa:de212:kc705-nommu:nommu_kc705_defconfig

The mmu code again. Patch from Linus incoming.

Guenter
