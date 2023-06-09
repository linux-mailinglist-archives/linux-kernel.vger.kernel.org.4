Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B8A7297CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjFILHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbjFILHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:07:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126302113;
        Fri,  9 Jun 2023 04:07:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2565b864f9aso491130a91.1;
        Fri, 09 Jun 2023 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686308820; x=1688900820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9Kp49qcxB2W/Gx/r6msDIk3UxITI3+DTECoDc55ia0=;
        b=XH0RYKJglDJSo+LUgfbk7Lirkr5mNmGpbJX1n0pLDknKqm0t5b873l5/KlTaoaDD5y
         d7QYPMTJvEZN9IoD0Nj7b+mIw3Ag29u0gelrFQVdzqRAc9tykFS0an2cmFc8X4PkH+CU
         uiNTqcwQ2clV+eatSPfSSNwZLIKXa8kvG9HhGITNWD2mmC08LhPpLtXhguktlHsMyHbo
         u8od/c5kD8b4nsnDQDmuzCoaP6tjPLBY553qCG04qlb4g5W9SxKw+sfbsArLu+UIi8Id
         X8COKAxOl4IhNPZngfbh/mNH4JZ5UYrX6v2VmNH73jfCkjXJeTGqUrbHCUPxYFP6hI95
         0IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686308820; x=1688900820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9Kp49qcxB2W/Gx/r6msDIk3UxITI3+DTECoDc55ia0=;
        b=YrCIdxw6uNTGQB7/IJgGB6NOkdhfNwktrBQsFvw9h+4lvued4p0nGX9KiDd7W3itse
         qmabe3b1DbK5prPBl/QnjFP4qHpOQLl/kyBOCExy6D8ctNIi1a2RsAhQABX2TXqYZuES
         t/M7KIzqeT1v6cKYDOsKR7idN9sj+wWOD+F82YDSmLCo0m2GvcRTA1ibYkCiH0Ey67Gj
         M5GhxsWTGBA1CbiwjJxZcYVlZLa3yLQHZdXZEF5wBgmpuxpWea1qsdD276eJ6mYwmqi0
         EUCq7Js1coHmpMF8Ra/eqoiU+ItGCd4hkCy54Ptm/+q+aQyAMwpnnVaob32Sfoy7tH3K
         LXLg==
X-Gm-Message-State: AC+VfDwJ3FHXIJIs1EpoAdtOms48W7uxmj3vejOdIfNCVe2ItBBvt6fU
        TcQNXAJ5GOdAPtGYkP2EPx4=
X-Google-Smtp-Source: ACHHUZ69iuycrMPAsL6r820Mk8A8KabO+WlKUAKOfAWMN+/OE9BN5aN5Lh0/htRWag2WEwxd0cl8UQ==
X-Received: by 2002:a17:90a:1908:b0:256:9b75:84cf with SMTP id 8-20020a17090a190800b002569b7584cfmr703254pjg.6.1686308820385;
        Fri, 09 Jun 2023 04:07:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a194300b00253305f36c4sm4785820pjh.18.2023.06.09.04.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 04:06:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 9 Jun 2023 04:06:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
Message-ID: <b979807a-a437-4d3f-98f9-989da52abb30@roeck-us.net>
References: <20230607200903.652580797@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
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

On Wed, Jun 07, 2023 at 10:15:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.116 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 499 pass: 498 fail: 1
Failed tests:
	arm:kudo-bmc:multi_v7_defconfig:npcm:usb0.1:nuvoton-npcm730-kudo:rootfs

The test failure is spurious and not new. I observe it randomly on
multi_v7_defconfig builds, primarily on npcm platforms. There is no error
message, just a stalled boot. I have been trying to bisect for a while,
but I have not been successful so far. No immediate concern; I just wanted
to mention it in case someone else hits the same or a similar problem.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
