Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758E26F22D0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 06:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjD2EJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 00:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjD2EJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:09:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E42D4A;
        Fri, 28 Apr 2023 21:09:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a6ebc66ca4so4949875ad.3;
        Fri, 28 Apr 2023 21:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682741376; x=1685333376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0Con/Jz4tEvXZScEVRW69KuDDaq5x6EC4u6W1T1IEY=;
        b=WyzCGY7X/28Ot6DYMF4UB5zL2i1s09pWqHdlc1FCcA2SMUPR/viRshhCdP5xFbA6f0
         4bT2lqE6gfa4uwDA53VNyTEmuCpvT3+pbRkPk6KkJ5JydYBxP7stwsj0td3rmMWbSBhU
         30hNAk+Bp6smAiE2YA4Zjh2LjXgSGZ6j718LzAssch17/fvA3XDLwyFvp1d38wSrA4kK
         ZFISB+1k2XKzVs56XeF8mBc1sgh2Irm2l5M3wJZV4MVUMsXcnflu6HEEH9v2NeGMvlAU
         IKguyXWI2eM52qQaN1CI5uc7uDlremOAOqyjuEy8nZSOclLaoo+8LD1nWjWeqc9Y6Ilu
         UMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682741376; x=1685333376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0Con/Jz4tEvXZScEVRW69KuDDaq5x6EC4u6W1T1IEY=;
        b=at2YCmakSb8XANe9hTYEBxmr4BB0Ov4KuNLJLBACgHTOCJN+67hogLK+pz6FghclGz
         xDW/tVfsMMSQHqCVMB0OH4Cbdb6AnVRayyp/MMLpR9mAGmWpWYvvSR7NQv2cQjtNmxkO
         uxTn2KLE0bUlY8WaPeLOosMDTr7mfuAwLTimY1qu0D0QuUe6XARv2v6+naqcJuxwph3t
         CjMkxXsCXvQtmPGRiKw3N3hROEvD9tF+qweS0vA6veIhTAUVRHVAnNRnDi3Os0a3RsBC
         9EVfO6zDNZwK0OEs1MiiPfRFOfdBDQoNFZh1T7AtCDMZTiAxnUgRm3qyL5JUrAvKaCuf
         L8fQ==
X-Gm-Message-State: AC+VfDxcNBuYR/Re8MAUZyzrPYXAG+5KEScvi+ZdVnl9INMD4DL7wuKH
        KzfmfZq1NCkQ3P071kflnzA=
X-Google-Smtp-Source: ACHHUZ724HPW0hI44McbZGG01VFq9tlTf7PzQIJa+01j4EnH4FItTAYi8Vg/L3EcoaVHPrfFvW1xSg==
X-Received: by 2002:a17:902:d505:b0:1a9:9c5d:9fac with SMTP id b5-20020a170902d50500b001a99c5d9facmr9322324plg.33.1682741376375;
        Fri, 28 Apr 2023 21:09:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p19-20020a170902a41300b001a95928e9a5sm11058023plq.121.2023.04.28.21.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 21:09:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 28 Apr 2023 21:09:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/13] 5.15.110-rc1 review
Message-ID: <3c5a4b87-14eb-4d39-8f00-fe2793de3216@roeck-us.net>
References: <20230428112039.133978540@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:28:04PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.110 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
