Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC816533DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiLUQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:18:47 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323E2250C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:18:45 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id v82so13748665oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+bNXioDxNImLTRjcMNz5wv3wPkQ00PwGxcuhrFvOFA=;
        b=ShqBpPcKfU39heppFQgA+EfPn0ynOOQyj+YmUmCRkX3CdHJjmyJ2JK1jkHdpAHr+LL
         F9B+EYn8Yz35ZsMqBsJ2/jDVd/9Qsacr+f/rOu785CEBZe65aEkjvpO4vws43SnUodHY
         LzvHj7lZskMbNHooN12F1rGCGf55BfggbTl5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+bNXioDxNImLTRjcMNz5wv3wPkQ00PwGxcuhrFvOFA=;
        b=kfyWFmKYOuXiOKrgRdkK7sGFONtQkyqX8lVhfr4+No6OJqTGTQcvQjUedzSSKHKfmF
         J3qDKJRbvuBcEfWAQa5Sruc6D1WK6Puyp+xU9qUw5rwEgt8B0idibpo/eQtipsD6CaTC
         aw1mHGaQQRQpK9h1zN1lMhQyzbu5yzwUyBDZw+ClneKZg4GLQaT8wZ/CsdVeuQCWqVke
         b1H8c0hfapv5psbALImNK7CmWQXlPala+/zX2PHQfMOcxEwYZZ3eTkV6II/CnHo57L9z
         +dKbtcdOKTiI44ouVqX9SnH/pImumzVAeTvSmgLaR8X/F3sXdYfJQkYsDJ7VuN5Y9OeN
         +zJg==
X-Gm-Message-State: AFqh2kqE+NC3VUn2b/KYZlltsbad4IKJ8IPm+3Xz1IyN1rg/4RKoNPk3
        GGAGkHb6gMTavaEzHujVrnTM0Q==
X-Google-Smtp-Source: AMrXdXtcRbZ41cs7IPkAwPfKR/1iE5afGVWCLVd3aADKKt5k7zhXfOz0qVd3i2fxizOY6AHvkI9m7Q==
X-Received: by 2002:aca:1008:0:b0:35e:bfd2:4b9b with SMTP id 8-20020aca1008000000b0035ebfd24b9bmr1022506oiq.55.1671639525042;
        Wed, 21 Dec 2022 08:18:45 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id es10-20020a056808278a00b00359ad661d3csm6891742oib.30.2022.12.21.08.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 08:18:44 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 21 Dec 2022 10:18:43 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/25] 6.1.1-rc1 review
Message-ID: <Y6Mx43EwwV1akWCV@fedora64.linuxtx.org>
References: <20221219182943.395169070@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219182943.395169070@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 08:22:39PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
