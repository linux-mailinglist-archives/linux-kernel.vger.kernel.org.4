Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED2A728C61
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbjFIA0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjFIA0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:26:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3B72D7C;
        Thu,  8 Jun 2023 17:26:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75d509d425eso121107085a.1;
        Thu, 08 Jun 2023 17:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686270403; x=1688862403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSvF1kXjBVqORXWJl1VpFJ19jMtWDkAEwUrdeGrCGho=;
        b=oPworUcizTNCZLkeD6AE1X2GgLcgTHNCCglRnabdiC1JEGAwwMgh79DF3lRfuuYLSG
         myyAqGZ36ZlEv48olY3uF8Z6F8622R63lbJiAOFXCNNUpYw4phOip9JvkhNxWBnL+ucB
         qHvrgxQP8HOCobXfhb//7ao61G8m6ho9xfYLNqP6b6E3m6M75zzzpEs2EN1mHUoOhsLx
         med046uB56EfM5awrGEZh6+yjW8WZIvjJC6XOVcdJkflh7ixpjb1z3rmqKTv9hr5BiNP
         z1G05v34vlUesIdDQXK6/TuWXQq9c51Ki8KdfftYDANx/f9uuaHeKdRa9i41MgDiHNpH
         jGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686270403; x=1688862403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSvF1kXjBVqORXWJl1VpFJ19jMtWDkAEwUrdeGrCGho=;
        b=Qth0Uuet2zOBVTGHIdB3Rw6cyqT/Jxuo6PxXQ43JEVi+2cNHpnE8S3p76WCeGlBFqC
         Ad5ovNjlrmzF8lkpR5dFsCAzWeqR+VvcD99DhEBZO1MmvQTUmlGYVVfmDmHSrYAG/dQ9
         mM5uiSyMp7SHoWSLwkzg0kybfQ5MzWzgmj0ic6f2GdJIDWJwP0PmGRi1IUjDhlZvNqnX
         3Us+n8nvAUV82bujdCS5mtsaXk3FuQwln1K67rrZBNKAf4dcnk2mrpaXr0TyaM9oMJWY
         54x2/HyYh0rWqeMOE8/T/C2jDpPSLcBJ7novNE/ForrFUxfyGeGdC8mlsSop4hEuSOMt
         Rz+g==
X-Gm-Message-State: AC+VfDyzhFskwrjeiJM5x7/oYEPWDL2opxc+RN8TSpAX6jjGN7iL0SFo
        s5nTR6URPvquXNc+kDZI+M4=
X-Google-Smtp-Source: ACHHUZ6P5gN19nyrCAbbXKebZIGih4YPKE/q4d35wzHys8hbCAw/pNlW9xliu/aGknBGts2UBFap9g==
X-Received: by 2002:a05:620a:1b8c:b0:75b:23a1:469 with SMTP id dv12-20020a05620a1b8c00b0075b23a10469mr7109768qkb.47.1686270403571;
        Thu, 08 Jun 2023 17:26:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a001e00b0025043a8185dsm1884185pja.23.2023.06.08.17.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 17:26:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Jun 2023 17:26:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.19 00/88] 4.19.285-rc1 review
Message-ID: <a85cbe67-3e19-4bda-b6b1-b5ea08a5dfb4@roeck-us.net>
References: <20230607200854.030202132@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
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

On Wed, Jun 07, 2023 at 10:15:17PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.285 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 431 pass: 431 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
