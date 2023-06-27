Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF92E7405B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjF0Vf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjF0VfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:35:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826B8211F;
        Tue, 27 Jun 2023 14:35:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666683eb028so2719374b3a.0;
        Tue, 27 Jun 2023 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687901710; x=1690493710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmQ9zd7xQJwvNtpIkcfyPK6Njo2kIyN7smRGjB7ejEQ=;
        b=fPh6lHNmMZLYTTSo//0blngZIkfu79zQJYcYrEU3jeDEPQLY9/E05lfdk2ninoZoca
         p2i/MU4IhwuSxG/jRDxMCuvkOB/VTL5pl2nVmKLgIO24oNSQ2DLtNzHPJUXimm/8874H
         1k0NhVx2Rboi5+K8UlH4OZ/7fRcuX5AbNAelhYvqUp4YtMhGgwnvDfY9ArfdVrqsCqYm
         kGy7rUNWz+RPsA0YHNM6w/yx/qbtkww7W4zQGH2T/uuC5ex9ixy90FVo4kGR/WI8nWag
         MZNc69e5iioHr74UeeqgmkKN5EuZ2sUQrQNwGBiiCJKyddi3VvfP6HKBWHe55vjfOvpF
         9j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687901710; x=1690493710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmQ9zd7xQJwvNtpIkcfyPK6Njo2kIyN7smRGjB7ejEQ=;
        b=FycG1iYWoGSQ+c5sgH8LpYmknwl0fqVG+VWVutuWYmRD31ZGqqPmHHlMtyU7fHEBz3
         gZ6U3hlHud1cNbLXW0H7jsKS8yEJzPSzYEXC+reWXA4enQ5+O5exzbV2enX9GPtoC/XE
         PDkUReddMupFIfeKWAtw5qpqA7TebSsawrFGeqvSOTUBx/s7pZfs9CLYjbvSxTWyIxYK
         wpZBw75KxDNyPAna7+zEwdQphxe8351bfbsUvJnina4T9aKYZgjQ7RlwxelWYb0m7WEc
         pAbNRgmk1j3CN12y8LNFlPQHkYYvVGitZrPTCOLOTB94Z1J9vEbmr42GGYCCEmpwLKZ/
         XeMw==
X-Gm-Message-State: AC+VfDyGD/jTldcRTiUstyK2ADdLIkH0CiaI6o4wNxccOOujuYLk18bg
        Six87uwhpWjZpbHKI6f/Vwk=
X-Google-Smtp-Source: ACHHUZ4au/NvssIowVsyZa3y2/EUVClG0VLbd5u4HwP5k/6eL+ZA3fLp+nQBjNPvHqalJw+5CpluCw==
X-Received: by 2002:a05:6a21:585:b0:10e:f369:2809 with SMTP id lw5-20020a056a21058500b0010ef3692809mr18579392pzb.21.1687901709902;
        Tue, 27 Jun 2023 14:35:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b0064378c52398sm5809209pfn.25.2023.06.27.14.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:35:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Jun 2023 14:35:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 00/60] 5.4.249-rc1 review
Message-ID: <0876bd1a-b500-42ef-81a4-7bc35f31b927@roeck-us.net>
References: <20230626180739.558575012@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
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

On Mon, Jun 26, 2023 at 08:11:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.249 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 455 pass: 455 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
