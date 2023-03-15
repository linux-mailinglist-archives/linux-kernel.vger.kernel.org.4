Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AD56BBF58
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCOVro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCOVrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:47:42 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BD99F200
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:47:35 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id be16so54822oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1678916855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNu/ZDxd1c/2898bC2pLvfVOQzHQvYoBI/Zo5PqnfbQ=;
        b=ZYA5aFwKbsbVsNtXAHs6cAkaw0w7EOg1zjhs+M794aOamSW/TRd+V0NONSBmPL9alm
         nNz3VG9ItXgvY87IrtgzL/bWuBi8MxsiHWPHXIXLJrpBHk8dIYudpF14aVtxkS1uEgG5
         64ZhuDD1A2NfeNINR56jDSjnzF55vnfed793g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNu/ZDxd1c/2898bC2pLvfVOQzHQvYoBI/Zo5PqnfbQ=;
        b=Fmz/SVgs66s24VcXanFbUT06I3Tuf0oeZIyBs6glS29WSlr/I2pD9J8rgk5NJ9w+Qg
         OkvNBQM8SDf7dmyd5ntyb3rILL6UsJw5qSU1Wt4dOU3QV3Gr8IoxuuZCir4cNMpQp3r4
         t1+Ms2BqD5djwliiW+HuCjzICpoaUTsICIuF20jwETAwOdm8vyukh1RDEPs7aE2xEB6L
         qX2npfxhbBYJPgun0uCZj6Vtoe4ZLvNUMMVbNpevU1aobU7j33oJAUgZ7I6P/VNyypOe
         LKGgRrXOHnr8zMH8NnmtxmHMQx5aTUgixaZ1FCHwkMBH2h/ehITyXABi8YJuEtFh1eBt
         2RUA==
X-Gm-Message-State: AO0yUKUn9w/6NU6wc4klA0gpQX6esMwCZbuBbr8tZ1gVnHKSdbz8dKmw
        ZkjE7xAKSyAZuGTtpVLZRf8qKw==
X-Google-Smtp-Source: AK7set/1wOi6EX3ewTUrlh0Q+V7z3U5I3m2dJos4Lkw3/kNs4+4AWTV8MxqaKkoV6Egus8jGerD2rQ==
X-Received: by 2002:a05:6808:298a:b0:384:dfc7:7d84 with SMTP id ex10-20020a056808298a00b00384dfc77d84mr1844506oib.58.1678916854725;
        Wed, 15 Mar 2023 14:47:34 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id r140-20020acaa892000000b00383ecd10ea6sm2654963oie.20.2023.03.15.14.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:47:34 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 15 Mar 2023 16:47:32 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/141] 6.2.7-rc1 review
Message-ID: <ZBI89ARxCFkPvm7/@fedora64.linuxtx.org>
References: <20230315115739.932786806@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315115739.932786806@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 01:11:43PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.7 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Mar 2023 11:57:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
