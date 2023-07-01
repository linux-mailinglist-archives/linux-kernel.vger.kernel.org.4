Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D352174463B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGAD17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGAD11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:27:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50964691;
        Fri, 30 Jun 2023 19:52:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b80ba9326bso18661885ad.1;
        Fri, 30 Jun 2023 19:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688179953; x=1690771953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRrHr6UEiq56x6SWgCHurtfSPLy20rMaAzy+jSm0CKc=;
        b=ZjGI98TRa1qxIvziozFUY2FEPZAksLh/7yLdUYiFmOxEO68OhLi63ynh8J6EXVAKil
         7XZXpyQBdXEFRv0b6YOB0y5l1XHJfz4wq1ffgFybhTpG6gBLyefIFt5ThNi3GS20BS0T
         Po8T+7X6QaRuL2GIXNOof2z1zpZ4Zl/lIpwDn1r0tJ5wQKf+x6Xxo+1u8RNnTb6ShvvZ
         ScB8IXg2zCngn0BhdAA+lvaXJ3wXyIQaOwZiSnRtrAdMs69FmTzZaT73bCoKeAMHAaVv
         /ZwnGy1+LfAWyGHichONUkSgF94WAtdzwhrPKatP2EcbUsix3N2IEdQLtKRxLZZs0r35
         QKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688179953; x=1690771953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRrHr6UEiq56x6SWgCHurtfSPLy20rMaAzy+jSm0CKc=;
        b=grIYE7NvUArHkijRu+bXuza8dc0WBRKurve2l3yK/ZohlKtqLHn15ptFlaxrmyZmkI
         /urzd00kxTG8dnrzvRBXQt4BqRIfxq5rW4tX4TYcXRcdGV8KNSXn9S7E4QqDoOr+6ES0
         14G4Dnhfmm+Nc7bLSnzQ+6ixu/CVnUeu5+1yp6Dl5hfozfBaE6PyPuE29JWfDZmLQDxx
         SoBxRKmdchuxg9kCwkliSy+TzN/PA2EPOKVMWzLxIhAO0Ds55aJThKky6nsqTkPRGPMb
         QY3nWexE32JTWE1xn6vzlX4lElvJZ1Nov5N2k+j9qgAwZfusmEFhVUlHvEcoPABwaGIN
         KPig==
X-Gm-Message-State: ABy/qLbrmGmCK3Phmj0GMP+m4wZBVH66enEK3CmN3Vwzttnnq5flQBFV
        2+DIxyP4gOHlkFWNdqdpXmA=
X-Google-Smtp-Source: APBJJlFqB8Bf8VkiGpreAMOsX6QylwofUfVYvcXRfj1zAgibD2LC/YRQP1Vgyp9B+2sNdd1Ge36MYQ==
X-Received: by 2002:a17:902:e5c1:b0:1b2:a63:95aa with SMTP id u1-20020a170902e5c100b001b20a6395aamr4572712plf.54.1688179953021;
        Fri, 30 Jun 2023 19:52:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id az12-20020a170902a58c00b001b0034557afsm11370517plb.15.2023.06.30.19.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 19:52:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Jun 2023 19:52:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 00/31] 6.4.1-rc3 review
Message-ID: <eb3f2352-98c8-4d33-beea-d2d88dbe3371@roeck-us.net>
References: <20230630072101.040486316@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630072101.040486316@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:33:31AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.1 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Jul 2023 07:20:45 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 520 pass: 519 fail: 1
Failed tests:
	xtensa:de212:kc705-nommu:nommu_kc705_defconfig

Guenter
