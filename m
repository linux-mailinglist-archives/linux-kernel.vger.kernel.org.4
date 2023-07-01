Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22666744666
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGADiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGADhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:37:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21035B8C;
        Fri, 30 Jun 2023 20:29:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b80ba9326bso18801575ad.1;
        Fri, 30 Jun 2023 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688182189; x=1690774189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRrHr6UEiq56x6SWgCHurtfSPLy20rMaAzy+jSm0CKc=;
        b=Cf8Kai85u62jhg4+poZxuTk4Pmojv1tJm0ihnYGXz2w+ndisSsSSi5ArOxCP9cAr+c
         zc/n95MXA9CVvhgSjJsq3x50GPRiQMjbHVHulz2c9pJnaQVDuou+6W2zV9YKmMCOmlOm
         0g/Z24JepOVXRPwbvyscBDfho6cGM39FQJ1ErziSwvmfWKLJmkSDLDBzUTsrw8APQYBp
         t9NL4sLz5U9Gel+ym1ywxQCly3ZN/mPq90/RfCA4s4jt7TdS25D2oaBjJZVwbF+YqZtv
         Pvriu/mWY1bny1dCUk8bR5lSdF8m3eXBpMaumaIq2DewmI0LZAgX0q6TQgu4JxNFVDLw
         6hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688182189; x=1690774189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRrHr6UEiq56x6SWgCHurtfSPLy20rMaAzy+jSm0CKc=;
        b=HR9bW3UCwgT3ERYMF7h9pUf6KENbhC+qjXDuLWCdWflrC/QVSOJ0CNd7PAxEgR2DxG
         f2WMmn2xrDLiDNTdKfNxWrei/Uzns3MY3j3XdPZwDHzJfoESPPtcIJhhgcbSqNUtQRy+
         yGk7ZzM+0jguhLo6BmIDyXYjL7X2Omrat48Y3kGQHlM0xqSLKzZx9uwSMW18GWbnw5nI
         fUdXY6oxJjOxE8JqCSplHs5O1aFe9u+Rg7ebG/AY/hfgpB1fjnRuceLFuzypfCo+rWhj
         oRxp1LGFp0avI5XtsqtXDoh484S3GRAcQ+xkmOXmrhQNRYGk2se3c+Zbca+yKFU2ccLF
         FKXw==
X-Gm-Message-State: ABy/qLYa+yltwPOZuMieE908YNh7BD+dxm2NBQxk2CDolq4jl+FMqDAY
        ZIzobPy1tjB/xQ7uyyCMji1n8/sRQTk=
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
