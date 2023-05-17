Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63EF705E61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjEQDwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjEQDwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:52:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C6A271B;
        Tue, 16 May 2023 20:52:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-25343f0c693so165524a91.3;
        Tue, 16 May 2023 20:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684295536; x=1686887536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUXFRmo2MSjUiP3pz0lzOFDLD9CCDZHx5JZ6kXK49MA=;
        b=YTS0qcj/hG4UhEBJb3/I8+r3muMeN3UAkFTzlWc4pOy86nF2hlfHA7HHcNw0QA7WdU
         ysiWX5b8G7mWmzoet7jUv0bFKWPXaFJCHGreU3hWRcOHCJ91BupPc//853th0Mt1i532
         qPVklvWPJCLhju91sHhOKM0X9nff7OeDHtkF66UZ29B5Evjc+jmIXfyoqPHMdDShJ3BQ
         ZHYT50y+Y8kahR3mv8MVczj1df2eQup+P8Y/Dbss7EWF7wkJWVFSve4Qw47huUc9Zif2
         We61ylGUJVMi4FZGqwYlGVTiwjh33TAlQiujlpl/9sUV7YLcaMxo4EeSI5ailX3IuKHP
         Wdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684295536; x=1686887536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUXFRmo2MSjUiP3pz0lzOFDLD9CCDZHx5JZ6kXK49MA=;
        b=b4OabB9Ija9US2/g4w2cqTTV7Xr4FUK4c3+i9SZzF37U8UTiMUHR8WgE5NIxFTlCh6
         TD2D/iS5HyOI396Juvd37jBYk7kCr7bf+lps2IB4h0i+i0Tr8NTIuExaNeoNbnpkPclW
         g4KUQ/Yonb07SYu7jqp58Ph37cWNgohbqoucRiFvTkxpYyQQKqw0Eg8YcgbswB3MMykz
         ETmroYOQBxeK4+4RqJEX815tAqYPmS+LVeBL+kXWgD8rTl9UvqtrVqgUAarPXgFVYUSC
         XeCS8xEZQbUb0TjM49eKfqoRSASt/bAkD1/ubmLvQHRdTaSYWEUqMVyr+8wy5Iq7ZCsv
         jgOA==
X-Gm-Message-State: AC+VfDzF/FWHfynifFB7EQWssD9NJ9gqnQ36DSQQpfwCZ7p48491SIeJ
        AUnuv1h2oLa+Mm5SgsY7cLkL0UUluFg=
X-Google-Smtp-Source: ACHHUZ5FxCBS+0YcXJo3FhDTsN4EFNwO8RkcXyTXtu4z6LvH4lM5z60eFxhe/fPZQebwejl0so7hAg==
X-Received: by 2002:a17:90b:350:b0:250:1905:ae78 with SMTP id fh16-20020a17090b035000b002501905ae78mr39147491pjb.15.1684295535825;
        Tue, 16 May 2023 20:52:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t17-20020a639551000000b00519c3475f21sm14303276pgn.46.2023.05.16.20.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 20:52:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 May 2023 20:52:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.4 000/282] 5.4.243-rc1 review
Message-ID: <739bd109-b32d-46f1-b382-e55f34efc11a@roeck-us.net>
References: <20230515161722.146344674@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:26:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.243 release.
> There are 282 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 455 pass: 454 fail: 1
Failed tests:
	arm:sabrelite:multi_v7_defconfig:mtd2:mem256:net,default:imx6dl-sabrelite:rootfs

As far as I can see, the second SPI interface fails to instantiate.

[   21.491528] spi_imx 2008000.spi: bitbang start failed with -22

There are also various new warnings in clock code.

[   21.492631] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:986 clk_core_disable+0x124/0x2e4
[   21.497524] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:845 clk_core_unprepare+0x268/0x388

The warnings in clock code are gone after reverting all changes introducing
PM support for imx spi code. The boot failure is gone after reverting the
gpio conversion. In total, I reverted the following patches to fix the
boot and warning problems.

d6fcaa127cc6 Revert "spi: imx/fsl-lpspi: Convert to GPIO descriptors"
9783b21b591d Revert "spi: imx: enable runtime pm support"
4a8bdbf7462b Revert "spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync"
e6c5f497ff35 Revert "spi: imx: Don't skip cleanup in remove's error path"
d6ea758df74f Revert "spi: imx: fix runtime pm support for !CONFIG_PM"
b9dbd028c970 Revert "spi: imx: fix reference leak in two imx operations"

Is this really 5.4 material ?

Guenter
