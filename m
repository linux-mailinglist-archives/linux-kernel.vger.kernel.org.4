Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3959164A7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiLLTHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiLLTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:06:49 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B38E30
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:06:46 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id v19-20020a9d5a13000000b0066e82a3872dso7907152oth.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bc2DPrk+jmvIB8OtsNO1XeEuDilKuTsyr5RnoWNLVIA=;
        b=eEIOe6BJqa5uLynDP14d9654wXp1J0S5TkCOQQ2gjQ+fnIii4aYlovvJ6/HlIXYiFX
         TuBCjt689w6EwitE0MRDKTSzpnQOM1yE99H/ryU3Yuhj6BhyTawgvyEuDWj6Bx1e2lOD
         9iRHncaA+ScI85bta8K1PTXz8hOJtxV/6dV1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bc2DPrk+jmvIB8OtsNO1XeEuDilKuTsyr5RnoWNLVIA=;
        b=DeknsKabEfcaRBu5XxiN7yEwm0dGGTvn5uj8ypXT3BL/sRDBUCGvR7YHG139pVipg9
         W1O1zTR5GPpkyZWyjkGN6wdohMsg1diMGqWta7+3HwXAMMuVUSPmaERv/RHG2zvV1B7h
         H6MfFmGlbEqNaeECL3bVy8/gwPa7mo+lqsC/XOS/A7MaPWfWYay+BrRamPayfL+7Tb9T
         y6aswLVEDGKIMTORL+HxiXP8sGvKdBbvBvVOBdxemZDZF1wTR6B+wZyK6/dgD2kZ6P46
         PgqphV7cSk2/Ro3OwobmUc47jL+SfChbymgvC+h+HxEvJRjIWAOZzhkKA1dwl8tQBX4J
         D/1A==
X-Gm-Message-State: ANoB5pmg0SQwfAqPf3nkGiEX65bxfx3M/6Ex9pSZ0xI8NDCuWacC/IUS
        3Ejl3iqc+2I0CnDT9Oukw32EAg==
X-Google-Smtp-Source: AA0mqf6uTZ+e6jCs1WM/4Cf7QSikBIfgshTVvf1Bodz84WQeHECU3VgpoGsYu5W0f68ZVq2P5icfQQ==
X-Received: by 2002:a9d:178f:0:b0:66e:6f72:dea2 with SMTP id j15-20020a9d178f000000b0066e6f72dea2mr7866951otj.30.1670872005662;
        Mon, 12 Dec 2022 11:06:45 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id w5-20020a056830144500b0066db09fb1b5sm258171otp.66.2022.12.12.11.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 11:06:45 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 12 Dec 2022 13:06:43 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.0 000/157] 6.0.13-rc1 review
Message-ID: <Y5d7w5OMUtKz//jn@fedora64.linuxtx.org>
References: <20221212130934.337225088@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212130934.337225088@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 02:15:48PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.13 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Dec 2022 13:08:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.13-rc1.gz
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
