Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22C16661D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjAKRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjAKR3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:29:33 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD3395E5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:28:17 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-150debe2b7cso16341684fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u54AezqJjjpM+HGr4IJs9A+cPR+RvkDqVZbwor81vek=;
        b=LAPsO9RurEB0r9THrmxm35xrP8vycJrtwQDDWQYt68C1TFRc9uKOfrPgCC0/xvGF/K
         j4h41s9nRZDT44jVc9HBVh3hSFEE5elJV5BFIA+Ij4kAkkPPN94wMfQD9Op/QolgYM2q
         wk1g+HG1Ti5OoEOb4bBIKwwWslh6Ypfeja68c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u54AezqJjjpM+HGr4IJs9A+cPR+RvkDqVZbwor81vek=;
        b=75t4ZQ117uQm9wTL3hVbX5dNfqwrUBtlfa1Yh0C3LYv13k/YS8QKODpGKRKzfZYCgH
         F8eeIpyKeW7gC+ygzed2T7gE25gm0JPTNiQ4Y975/SQSYQg3P9n3XxrmmpVSCN7VPk8G
         CYYKO/6xA41iF6emFnwX1Y1KEMiiPH9s9aXLyAI/ww4FnA9sSfsrHIrWtKlL7rekA686
         llF5FuFthRfIU1kituMOcCLZXrTbf882DOY5nks9xfWzOD+5UHI35kPQ0XCCP9pkWvL6
         6o/fu5VJTrgSkcFARa/uf6fTViFZmkWSLSiH42VZZ0RDaRCXnRU4SO9AnoPpZhDVzdni
         7MHw==
X-Gm-Message-State: AFqh2kqSk+b83iJdWBjMBsCoACxPH0EVD1BqY8GF+qi56e7nHZdd2BZi
        QHxeUMKtB1s/UfKNxXzMOvlDRw==
X-Google-Smtp-Source: AMrXdXux1df1fFmYjJ7Bb6xj79MJxEeW8UUn9KvAGsRK1VijyG5s4AkNRcRQyVoNAWocXDr3l5vyWQ==
X-Received: by 2002:a05:6870:5b85:b0:14c:7959:8c2e with SMTP id em5-20020a0568705b8500b0014c79598c2emr1742032oab.2.1673458096651;
        Wed, 11 Jan 2023 09:28:16 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id y9-20020a056871010900b00143065d3e99sm7638241oab.5.2023.01.11.09.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:28:16 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 11 Jan 2023 11:28:14 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/159] 6.1.5-rc1 review
Message-ID: <Y77xro03HZe/+DyP@fedora64.linuxtx.org>
References: <20230110180018.288460217@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110180018.288460217@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 07:02:28PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.5 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Jan 2023 17:59:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.5-rc1.gz
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
