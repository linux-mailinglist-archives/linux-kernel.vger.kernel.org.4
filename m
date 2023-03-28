Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C48F6CCB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjC1UrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC1UrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:47:10 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC60212B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:47:07 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 61-20020a9d02c3000000b0069fe8de3139so7122924otl.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1680036426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9TqwHS5VwuEVtgFkkRpwnXddHrCsiKppKpc5MLhcFQ=;
        b=KFbL9xuwqXgkaPDPLXMmcQu+jorC1YLUIQEP6RSeWACsh4JPTSgbvYXhpotibsVLrp
         59dEDCVqWpulJ4I3nKs4YjftCfdzyuPAvAsrq4SNuT7uXcmPsSaJewBT9jJdngPHVWRu
         VAc7LwTF1/MtSynU+n4sNiKgq9dpJkntyJcD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680036426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9TqwHS5VwuEVtgFkkRpwnXddHrCsiKppKpc5MLhcFQ=;
        b=mNZdlTSY2x8YVIbf7SbJuk5AskkYC0vPIoF/k1pyO/3KTAYEyj0042cgY8CArloKu5
         o5UJzfqR5zOsrG5vg9dKaGfGfiNbGxouX0MndwdexwyC2MLJZE0Jj9AIreWy0yphbKrc
         RSNMdFdXlP3TrQvcFb6r5gIWpNyxi0n0HvUXjeClH2hXS5P/oVGAjdRc15mCVJ/1uIGD
         LajRL5iGubcCWankek+C10E8873SDksIhm/e40roYJOKaFvki5vfks0n454dEExJzvws
         h2NqAws2HJcohbWW0KSyfv0kBG7M/qDmDNFcYCef0/GW0j6M2HOU2nsbWkeELvRYxFk8
         1LCw==
X-Gm-Message-State: AO0yUKVd75I2ARUJF12ly4C64C8g5YTd/BQ+5dQfuksOpW9eUHplQaqr
        PFBXVHaMAMwZKFGGgDE0ccjEYA==
X-Google-Smtp-Source: AK7set/VDHp+PB8OuqkSD6KOGOyXWkSsZU2I5b0CJcb3uf9UpPzC7sBeEYWNQ9FL5EgVF+JYxr99ug==
X-Received: by 2002:a05:6830:d7:b0:69f:afc8:119e with SMTP id x23-20020a05683000d700b0069fafc8119emr8493332oto.32.1680036426395;
        Tue, 28 Mar 2023 13:47:06 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id l26-20020a0568301d7a00b0069fa776d3c2sm6961811oti.18.2023.03.28.13.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:47:05 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 28 Mar 2023 15:47:04 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/240] 6.2.9-rc1 review
Message-ID: <ZCNSSAzHmtTHCw9O@fedora64.linuxtx.org>
References: <20230328142619.643313678@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328142619.643313678@linuxfoundation.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 04:39:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.9 release.
> There are 240 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Mar 2023 14:25:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.9-rc1.gz
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
