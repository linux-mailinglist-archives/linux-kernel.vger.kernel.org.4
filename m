Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009E96661F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjAKRbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbjAKR25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:28:57 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623153E869
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:25:18 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id d16-20020a4a5210000000b004f23d1aea58so436847oob.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDHX0didgEx7NNXd2mrLuD7KLRze3bUT5PfKEBhLQbk=;
        b=GEMbsofdELSoxX5S302sWGhE26vk8y2/1xI+xpXiA51vd2F80yKKK+QTEvts5z91n6
         nrhMzwwNCgHN3c0dG6KJpNgDp4A558eZRvHS64j0gF6vCdtzjevCrIHOpt94/rdfCltQ
         0dyzaHqgc57iyUC3Rpc6KJZ9ad746SsOYehZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDHX0didgEx7NNXd2mrLuD7KLRze3bUT5PfKEBhLQbk=;
        b=cPvnzikWuyZC/Sz7j+rEd53XanmcUU31MUwMStwAFaTcxHSzF3QsL03eEI5MHkkWGy
         KgQE1SAcWUd0T6IJYIxAdpEJII5JqYIiAzAKQuOaD2rDruHgKov8qOZXfAXXlQ7LNodF
         /4JSlbvCfryCV8ZTSuQu0SWaMBfCuJ4KK4hG0WM9AzbM00Q2Rx7eEbl6OkBh9Q3/k4Ko
         1tgh41smfYGLNGXvEQqBNrBG997z1KXZ4JbTBwoMNhSFHdgOxIvGbv8ox5+fOPeX4VC7
         R7+Yay3yfSZMhWX/pk53oKKXJWe3qQlH5ctkpOx/AxbVSOoYkSI80X4yYW/AUco2IdMl
         D21g==
X-Gm-Message-State: AFqh2krHT1H7jm0eS7VKRovaE49XeZuBaTUMETOhxETBGur3/xy6Vqrl
        yjUIY0uBLSzzj/DFuAcRwJJ//g==
X-Google-Smtp-Source: AMrXdXsHjOAqQ65hK+eAjJM3izvsckhP1hCa26zI2DqF0gCiZsLYEJNJMw/d/RVb5QVSgXxHfpkY2w==
X-Received: by 2002:a4a:ac88:0:b0:4a3:b889:4c21 with SMTP id b8-20020a4aac88000000b004a3b8894c21mr35113344oon.0.1673457917580;
        Wed, 11 Jan 2023 09:25:17 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id j7-20020a4adf47000000b004a5a69c1861sm2689702oou.22.2023.01.11.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:25:17 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 11 Jan 2023 11:25:15 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.0 000/148] 6.0.19-rc1 review
Message-ID: <Y77w+5mqOR+n5G9K@fedora64.linuxtx.org>
References: <20230110180017.145591678@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110180017.145591678@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 07:01:44PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.19 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> NOTE, this will probably be the LAST 6.0.y release.  If there is
> anything preventing you from moving to 6.1.y right now, please let me
> know.
> 
> Responses should be made by Thu, 12 Jan 2023 17:59:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.19-rc1.gz
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
