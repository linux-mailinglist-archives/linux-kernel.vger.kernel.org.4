Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36F46FCEEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjEIT7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjEIT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:59:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAED4ED6;
        Tue,  9 May 2023 12:59:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so2611975b3a.3;
        Tue, 09 May 2023 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683662346; x=1686254346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qFLfy/RaoHobJwJIwlBPxnMu6peJ2rAXISdMhNVcn8=;
        b=bwJ4F5Mi7rgxj74IL2eWTgEHDb5ITjsRwmhmoIsr5y3/PaHdtyBOo2aJM+7LelOLMG
         Si1SlqfuZrzdkpRSCia/ir2gcwAcwBUeA1KB2alc3KS6LFnxgegAPeD1jV9ppAjzZRYy
         zbDVcEq/tnltqCyAH3QTyqVKxAF0ztfOtpoeQEJhacQzjfD6AQfUEEtRQGsxcfbbJmXS
         zwqg7kPhwsbrLEeq8lV3Rr/xHFPDgkWQh3JcVuuy925539uKYhN01XXgXIVaFIX2wjsI
         +PqCt8gxbyKzj4PrlRSmbj8GhTz1HUv7rgTUimRIzurTuTGAFfyOygg9TQYwrTYat3ro
         8k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683662346; x=1686254346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qFLfy/RaoHobJwJIwlBPxnMu6peJ2rAXISdMhNVcn8=;
        b=hybuunWV/MEtWQr5HlGoN6wjcERuv4R+qO1HrR8iHzjaE84jG7rTVttczGu5sj41yk
         UJeCIDmQ3TNKHAGhFRZLlB0Ogno0uIA8u6TKxdwB3AkxPNOkai2cz6nLqOr2N4qzotQ3
         wA8eqT+DNnifKkWjBs4g3UEO0ZbVmro7xR8Y3sV2xmmQSAVNqKRNjI213RK5G5JtG7p4
         GzgtTz0Q1r+9blJQVNvegR+VLz5pwV+HPzoNepPb6gLDAinH+Da1147EChet2RBS4K/K
         RWwmmm19w0IuBOAg3UV6Hl2Qtnj253ffOr8FR3X354Oijfih/bWdE0dJZtXeUrUKmNwR
         UqIQ==
X-Gm-Message-State: AC+VfDxwHffISidb5FkSth0sTRwtDm36Y+fnGEh/Zx0kmliYmph3uo+I
        d7IqC/vIulMfUlwmJpRs9T0=
X-Google-Smtp-Source: ACHHUZ6ud33kVJrJ3TG6+Sx5LPatnQ9P/Hv9S8gNX1O1rpCqT1BJCT/wbMzfMfyviwl8IMuYhNQiSQ==
X-Received: by 2002:a05:6a20:72a0:b0:101:8ff9:58c5 with SMTP id o32-20020a056a2072a000b001018ff958c5mr2536706pzk.27.1683662346204;
        Tue, 09 May 2023 12:59:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12-20020a62fb0c000000b0063f172b1c47sm2164563pfm.35.2023.05.09.12.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:59:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 May 2023 12:59:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/662] 6.2.15-rc2 review
Message-ID: <4adbfa4a-33fc-4caf-a58a-a27a8e296f13@roeck-us.net>
References: <20230509030701.507375024@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509030701.507375024@linuxfoundation.org>
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

On Tue, May 09, 2023 at 05:27:04AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.15 release.
> There are 662 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
