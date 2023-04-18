Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834356E6E90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjDRVrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjDRVr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:47:27 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CA65AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:47:17 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-18777914805so6349758fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1681854436; x=1684446436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfZlw8AlHMxVsS3tiMBAvH71RDRSOAAoNTnFWBIvtwY=;
        b=Md/5OB4ZHkMeXPiXDoQ3mKe5o9xdDBIf7ZW33imyrQ1i778qqYLcYBiG3njZNyfsbd
         wK0xtH108mTALoDQma+YkiMjhwo3HHa0TuTwhdoyK0o2pwm/KpL/0yqW9c88x8PFGLTU
         0kly5TX0D0WvS81iEzSTZ8NenHqqUH7xqfys8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854436; x=1684446436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfZlw8AlHMxVsS3tiMBAvH71RDRSOAAoNTnFWBIvtwY=;
        b=KZKOhuPPy6xFieEbT/+yjuRW+gdUY0eiw+AXqMa1ZXb9FdgSpr0aVvxURUAHdHhE3Z
         IeKrFl5L2r5xL7RIVaBrWqrHu83oKHuJfBoYynOovXQfxVoct8K1YzbKDcn0d0BZlMXf
         SsfMFhzaRrfk08KA16xVUHs1WG9Ff/C5k8S5juXIMtxbCVaR6ifmByfml9xV6uNyt680
         wEvgLI3i9qSWxvu07qaDm0cENCwcrVggjWJf4wMLfXUMx6rQXIH/NxQtUGIQ+pSmGMH4
         OJ1ACVGbB52kwWod1SALxzlvtl7iFWdhL0MHTaw4z9M0kCUm0arrW1nrG1Jt/A5doYgE
         KyMw==
X-Gm-Message-State: AAQBX9dUR4JRLo0BXtOMJBYW3kHB3KgN/VzqxItOkoIneIGwyNG2Ideq
        mKA5wzq6levodZSPuZfdxg+FMw==
X-Google-Smtp-Source: AKy350bvwxZIoP1TokwhqCpLgUkLtNzYMkJUALfJwFX186XZ4vsH3m7WlpcgTtoJidMsj/eG06rbIg==
X-Received: by 2002:aca:3cd7:0:b0:38d:9dba:6a5a with SMTP id j206-20020aca3cd7000000b0038d9dba6a5amr175603oia.15.1681854436620;
        Tue, 18 Apr 2023 14:47:16 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id k206-20020acabad7000000b0038934c5b400sm6300453oif.25.2023.04.18.14.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:47:16 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 18 Apr 2023 16:47:14 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/139] 6.2.12-rc1 review
Message-ID: <ZD8P4gAi03rLRNJA@fedora64.linuxtx.org>
References: <20230418120313.725598495@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418120313.725598495@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 02:21:05PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.12 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.12-rc1.gz
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
