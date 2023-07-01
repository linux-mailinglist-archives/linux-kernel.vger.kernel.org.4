Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778874466A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGADpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjGADoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:44:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3433C29;
        Fri, 30 Jun 2023 20:33:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666ecb21f86so2064691b3a.3;
        Fri, 30 Jun 2023 20:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688182401; x=1690774401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZrQKm7bBhs1JNxT56rA5/OMhAsHxnnLLFgOEAX9YEY=;
        b=k08Ii/74iAVsRfh0RSq9uJv3+02eo6LqATg7jvI4nOgF09k0EzuzTgwonyK4W8BSxX
         8bw0fjvsI5JQV6Q/5Oln6nRZZjKG+qy31wO/Nd9VVoB80X21SMiNm8yGamzhd7GiqAXj
         vY0x6qOKAT+rA6bCOfaszrxBgL9zsPsrbyWv7w3uyMmBDSAn9D6SiXyNmIrCe3sSzEoE
         dINqUsfrfsbmkG1DguPFEEaRWp7+1e7qlQVdMdXekfjUOn0QtjqLjBmOkrgpx+FbWHky
         CX5zj16i5vD4Je5H68WOESGPxOyfZotXvfdiPsnhTwRq1DPmW0wSbqam75enfAvDPb0M
         eByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688182401; x=1690774401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZrQKm7bBhs1JNxT56rA5/OMhAsHxnnLLFgOEAX9YEY=;
        b=BQhGn8qWcgMMxta2IpMAUeh9sqyWtSYoSDGhe77ce3CaJBvSRmFUHAaq/4KhXJ+oEB
         36knz7ZDYq1LL5gvsfMqBu5lNciiIj6iS/sHiJYZjYCnPLLmftxwA0RhIUlTC/erK7X1
         xy5NnbBXM95qBNJaKlA/RPRXbTUPmj46KNrp/pxVBgihOnakmKMMcqMLANhBrGd2y21h
         nmXLwvr/ATdtGSUOuPlvPIB3MxIIUEzAqMLX3RZzFR0PH3aYuyVr/e4jCb+/87J+i6O7
         AAqr/IQzCOMg61hnzxDSwNU8J33WMl4hl6bSap3g2QJsocDyuvvlqAW/tMTRATcdYAuE
         aKoQ==
X-Gm-Message-State: ABy/qLaObYtqylgvQg1GoSJaOA1vyKPMMt+52AqAZIV/geJ6/aG9KXRl
        /ZzzM7b4KlbHsUApEZmpT4JjRn1sw0A=
X-Google-Smtp-Source: APBJJlEnlU5gBGG2cEbXdoOjLSasJyyrzY8KAvqodbohdJ+Naj4Ioy2mmdSY9OxQcJC0QhQYO2QCjA==
X-Received: by 2002:a17:903:1c9:b0:1b7:d23f:8a57 with SMTP id e9-20020a17090301c900b001b7d23f8a57mr4520822plh.24.1688179929366;
        Fri, 30 Jun 2023 19:52:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902bd8100b001b540e334b0sm11334997pls.298.2023.06.30.19.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 19:52:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Jun 2023 19:52:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.3 00/32] 6.3.11-rc4 review
Message-ID: <f75e9488-c88e-4a83-bff6-ba2c0058432e@roeck-us.net>
References: <20230630072120.689306958@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630072120.689306958@linuxfoundation.org>
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

On Fri, Jun 30, 2023 at 09:33:36AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.11 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Jul 2023 07:21:08 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 519 fail: 1
Failed tests:
	xtensa:de212:kc705-nommu:nommu_kc705_defconfig

Guenter
