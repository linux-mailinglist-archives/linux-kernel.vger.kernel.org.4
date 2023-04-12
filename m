Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD46DFD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDLSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDLSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:16:40 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9645BA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:16:36 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id ec6so1646333oib.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1681323396; x=1683915396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6yK3C0YkeZPBasWtG0thFawQkYVzEsDsJhqcXXdP/0=;
        b=asSjimKN/i2Aszfl+ZnzPLkjjLIEZFj2RTSZfhLN7EuVnH8kgQHSPy/dGBXt3SMCCJ
         OcD0MDUdzIn6eRR71ZpWS0IiVjRaqKrSaG2/JN4d0UaUrD0LLr6SMOEpmrKGAgLoRAJg
         n1bf7v+40xJPo3sU6a+tLBlXAmhWd4WKy7s5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323396; x=1683915396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6yK3C0YkeZPBasWtG0thFawQkYVzEsDsJhqcXXdP/0=;
        b=Fua7aNaysieRmUCI5AI4IujSVf3yQ6dX2Up5tUg6OTVseWhCXZG7YhFE5PGq34Fa7n
         FnkDQin2dea8+8VnFYBFz90U1qeZnzukOhdSJkGIms9l+aJCOsOxVxknkNwm0CghW9br
         B/TV5Lgnys9Qa8HCOyFJhioFdT1Vjn++KATzOjQCnPSHg4YSHsojpK4SznlOUBDFcy5D
         5I/oTo5YO8tu4VuoTkuaA8mxV0KD3G7pKc9ulMtXXx8bFAKfyFaLG11U2apDYKugBFLD
         NWXKHoKDn26x+bKHB5gcHblhc9Q9f6sev2P1evQEOWsr1VIO4Iw6uQ7+wGRwhw8BMIP/
         2IDg==
X-Gm-Message-State: AAQBX9eNDpDZEFOcb6u1B5a0LNZqkrQe0QkaIlBOe8YvfYjHejVFPd47
        irAXzFyrj3gXnhR04iZu07BdwQ==
X-Google-Smtp-Source: AKy350ZJnxb7/erOSQdKo3r6KSUFa1vRi2QvZAo8RaoLpq83BtLcR47FPLfDgR2lZKwIHgI0isCeQg==
X-Received: by 2002:aca:bd05:0:b0:38c:696:c99f with SMTP id n5-20020acabd05000000b0038c0696c99fmr633352oif.16.1681323396147;
        Wed, 12 Apr 2023 11:16:36 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id e9-20020a9d5609000000b006a32eb9e0dfsm6675982oti.67.2023.04.12.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:16:35 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 12 Apr 2023 13:16:34 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/173] 6.2.11-rc1 review
Message-ID: <ZDb1gtPI2dje3Qv3@fedora64.linuxtx.org>
References: <20230412082838.125271466@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412082838.125271466@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:32:06AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.11 release.
> There are 173 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 14 Apr 2023 08:28:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.11-rc1.gz
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
