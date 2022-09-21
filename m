Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129955BF683
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIUGkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIUGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:40:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B45719BB;
        Tue, 20 Sep 2022 23:40:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so1225807pjk.2;
        Tue, 20 Sep 2022 23:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2Z6JNbAW/4RJD8l5E7x6NSV0E79HZM78mYuWpdpWpas=;
        b=mK9j3JDv2ZEHjZC5vJGBXbX12sn43JVMAltsfTtlbRxBTcogeIptZSKgJ6ZWEW6ywy
         qIeEpPEVNgtU6F3Z48rC/xbRnX6eHGZnaO5kOnmScZfkvt031qbjzyOPX5SkQUcmgway
         jGIChVVHER0kNC9udr0QEDMc/UuFy65MWZFUf0ulvdPNmal7OFczF05AWBY4OVDy6FeR
         VdLKv9mZ4KNeGWwKCXXtONKtJuni8fmd79yMj/Trf+GpW6FtZssn3pUiHnvbP//91CAH
         88FNGGUKPxLCWGJjnkPEnKl14fF4BSGL8Rx1GYhbeHLRUqoNbE2fUed+gn1sY1nqxxN+
         kSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2Z6JNbAW/4RJD8l5E7x6NSV0E79HZM78mYuWpdpWpas=;
        b=4WCDBPLvluJ3E9kOx27qhrnBXbICbh7b1kt/Pa+5FuiM4Vw7fnLYa5kYb9EZninsO4
         o0ts4qPlTErARPtH8Kz4Y2cd3PlsxiOecLRh18noKb40vSBbPj/8HGDU3oLI4K5JdDTh
         RkzHzq1d1+GYr97iW9IH/l0EWQslsKECnrv8T1Vm4tiQX6d5nTPM4S/fiZzke1MF5Kri
         jSlJGspu3c67PvJ6eFTNJZP2NK4RO4vCMcH9MMU1+/0dsowuQTjFiszMNPE6DPhc9NSR
         cJ9GpxBA6j9xBUvS7rklnecsZMDEgxWx094NqUUSZxw4Wyffuhzr117MuZeGua5P2NbU
         Zw+g==
X-Gm-Message-State: ACrzQf3HgmEHoSDePSRmyudD57O8xxhsd5IAayfbK/bJBGuLGgf9hBrS
        YCeZRRQTPfh7EmJO6hgDjoA=
X-Google-Smtp-Source: AMsMyM5noEpIj+UuwUwfyTi+BP2tFYFz9oauL9ERUlPpBhMDozKolXK28ewoxTq9oXbcMHHvBKyCYg==
X-Received: by 2002:a17:90b:1bc3:b0:203:84d:59b1 with SMTP id oa3-20020a17090b1bc300b00203084d59b1mr7976365pjb.37.1663742431958;
        Tue, 20 Sep 2022 23:40:31 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id o13-20020a63e34d000000b00438e0db80dasm1039162pgj.65.2022.09.20.23.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 23:40:31 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:40:26 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Meng Li <Meng.Li@windriver.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: cdev: Set lineevent_state::irq after IRQ
 register successfully
Message-ID: <Yyqx2hhuohVhMo84@sol>
References: <20220921032020.25398-1-Meng.Li@windriver.com>
 <YyqKfxpAjdSU9r+2@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyqKfxpAjdSU9r+2@sol>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:52:31AM +0800, Kent Gibson wrote:
> On Wed, Sep 21, 2022 at 11:20:20AM +0800, Meng Li wrote:
> > When running gpio test on nxp-ls1028 platform with below command
> > gpiomon --num-events=3 --rising-edge gpiochip1 25
> > There will be a warning trace as below:
> > Call trace:
> > free_irq+0x204/0x360
> > lineevent_free+0x64/0x70
> > gpio_ioctl+0x598/0x6a0
> > __arm64_sys_ioctl+0xb4/0x100
> > invoke_syscall+0x5c/0x130
> > ......
> > el0t_64_sync+0x1a0/0x1a4
> > The reason of this issue is that calling request_threaded_irq()
> > function failed, and then lineevent_free() is invoked to release
> > the resource. Since the lineevent_state::irq was already set, so
> > the subsequent invocation of free_irq() would trigger the above
> > warning call trace. To fix this issue, set the lineevent_state::irq
> > after the IRQ register successfully.
> > 
> > Fixes: 468242724143 ("gpiolib: cdev: refactor lineevent cleanup into lineevent_free")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Meng Li <Meng.Li@windriver.com>
> 
> Good pick up - the IRQ shouldn't be freed if it hasn't been successfully requested.
> 
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> 

Oops, that should be

Reviewed-by: Kent Gibson <warthog618@gmail.com>

