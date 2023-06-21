Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38467737853
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFUAip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjFUAim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:38:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95561981;
        Tue, 20 Jun 2023 17:38:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-543c692db30so4303926a12.3;
        Tue, 20 Jun 2023 17:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687307919; x=1689899919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6jTOFm5SC0/E1v8Dy/9a0PYzsnVfaB7TCXxz4lclcQ=;
        b=CAAFdeIAhI0kCKKXG96LFa2nxhHSC51CFixnF8x4/0r7xcJYP0zI0ghpeSJwD3w4DG
         V5whw/eDAeK/vvrG1OUDJcyjqzSMD6vblO1zSsC1JHlO2/jCnP3mCPJ+Pu9J3wb6zTFg
         ZIvoNkt1HjLrsX72axV08f70m6z8na04J42Z15fmCiEG2qeAQDSB8vyBNieiyiaBBQZ0
         k0VbfgFGHqXKs0o7l0RcGwbNdmzGzq1uaSqb34Vv/Zg9cAL0JZj3bSgvB9OPBRcM9vqn
         uHNntgpJxLUnrSGY0W/ZgmyykQSGwgbHlX5QJ4fU2LRrleauow9Oqr8QkYKeI/10+YOW
         oXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687307919; x=1689899919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6jTOFm5SC0/E1v8Dy/9a0PYzsnVfaB7TCXxz4lclcQ=;
        b=c5BWhJccX+9czBicxit79rmU++40Rqy5a8IZBgQgh1ZNex4GOjKMS3uutbGEl3M8FQ
         AaCNY4cjQ8rzOG9/UuFy5G3dSS+vodenvXw6oYB8kXMGCGzJuT0GpAbaI5O2ePSCNtp1
         nJjxKumjPXImGOu8vnhttiW9fLsksrfA6YO/Mr0WRjbZKsbL7fS+lmQiIR/mJ8X3gzJ8
         vWnD/sBy8QxTqS+8yrqX09d//V5mhXjyI+Prj2u7OS4eCdPD2YZ0qFYJUzdf4yD1sLLZ
         CPFSFF3C4CCsZ8nW4scwcYRHwz133WZR+8IvqVClirsJ7eBPUk0Ehf7KE53HPEWNciXH
         PWkA==
X-Gm-Message-State: AC+VfDzWzVKciZrJrngvam0G/6JdbmqSas6MnEbEbZy2K/+HQAs2V7TQ
        qnQ7/b3NDNpAmN5PHU/ij7M=
X-Google-Smtp-Source: ACHHUZ6v7mFwBN6L93oYixMwrZP6/CH/ftr15ZYYgBXwF94zmmQmtviieW/04cnjRq44q+VAQ9aHnA==
X-Received: by 2002:a05:6a20:548c:b0:123:100e:c8ae with SMTP id i12-20020a056a20548c00b00123100ec8aemr1277622pzk.52.1687307919096;
        Tue, 20 Jun 2023 17:38:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jn9-20020a170903050900b001b679ec20f2sm2164377plb.31.2023.06.20.17.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 17:38:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Jun 2023 17:38:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 00/89] 5.10.185-rc1 review
Message-ID: <889335de-3b21-414c-8395-cbb92e58a950@roeck-us.net>
References: <20230619102138.279161276@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
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

On Mon, Jun 19, 2023 at 12:29:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.185 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 485 pass: 485 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
