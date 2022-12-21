Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2396533C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiLUQEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLUQEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:04:31 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710CFB4B0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:04:28 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso2480943ooo.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJmsn58xKPbGHiKrj82Ko5wI0bke7L5N3g2n349swQQ=;
        b=VKZh8Z+o5HVhAYyL+Km4C+pZUd+tLLpykKq2K/NWLT0ihGl9RzIOi5JSJAcyYXbrbr
         t5eUzkVG7RqeD9P5pckYLyBQYGRLG36GEjIUPTJJqHneXFr3ZcS4nkHwNvOCqJO44CHj
         sbXsoUOqo6DrXBuRI1E4Kj/ceWeGFfg+MFf/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJmsn58xKPbGHiKrj82Ko5wI0bke7L5N3g2n349swQQ=;
        b=2RISiOce60PwRBeEpEOwylmnDwnr4SaGz4E7gEFlji4+QffJnTsxApPxuvl4LDdNIJ
         UWC5EJBbgOa75uW7h/iQT7NWNpTx/0ZgV82YN0JE2l8KCUAMxLEheKANEEXVsbakJZrV
         q+Lyt5tnmIA/IP4cWuinM5s+R3djsVWCeM3MjpZfOgfZQpfGDI/E+GnZQzcOrjNvXk9I
         dBHKo9JMV/4nuKLFHmpAgPcnS3fsMX75gmKhDhqjhHOv9yAGKQwqwb96hbSBiG2gGUaL
         2mxHtUDh871shcQfrRmWxeZBlbk/ju4zqoK8C5jijA0RJWuPl37v2l8LXwmBiGwzaYRL
         DlVA==
X-Gm-Message-State: AFqh2kqXxrDiUiS4PEqM50pMPWq91yMSSXm9pwwjjoYXJ8i2sIJUOuNl
        2duYsmw+BOqA2lGeXIKChOmibg==
X-Google-Smtp-Source: AMrXdXvFCPfGpZRQD5dV4PjhY/izAVNd9gTVAqDtT3zxjxX8W42bImEfLYj6CVX1qzV+cfy5caAGYg==
X-Received: by 2002:a4a:43:0:b0:49f:8720:d5b2 with SMTP id 64-20020a4a0043000000b0049f8720d5b2mr1070027ooh.8.1671638667751;
        Wed, 21 Dec 2022 08:04:27 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id a11-20020a4ab10b000000b0049fb39100a5sm6205846ooo.37.2022.12.21.08.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 08:04:27 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 21 Dec 2022 10:04:25 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.0 00/28] 6.0.15-rc1 review
Message-ID: <Y6MuiZJZ/6wLsXpu@fedora64.linuxtx.org>
References: <20221219182944.179389009@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219182944.179389009@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 08:22:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.15 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
