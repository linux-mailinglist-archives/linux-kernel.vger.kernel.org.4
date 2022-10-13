Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9048C5FD295
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJMBbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMBba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:31:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7455D10A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:31:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so3593690pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDg2KrtY+r5hSPNOLM52oF65/4/O8DHcMPpTQZtCzCQ=;
        b=XbXesjLZ5whYOE7XwY49ypj9z76tPcVopGS2MzJ2IwHGPtQRAvc94Gq6wORsemobTN
         Q8t2p1mNDYYCX9C/iGOAOYovTO9yTWZvIZcD7QLtcpJKAHn+eJImzIMUWDn1wEj3faEY
         /Vjvuze4D1e7zqGw+n6IWOF1NgnCgnD8cqQTZ/F5LXfOq2R0BtgDC/itpEkBY55hVj+m
         F+BHsl2+Ub/IaWnueZ1M3/fBcs2BWA9IGsqcxZLpSi1qaDRGt6M1TwBM6DE7us5YRODg
         A8h/4ylUh8vyZAytUQLiVo9YkGYgdr2vask6/sdUq4QofXaRyauCg9ZX4moLWXTV3jcr
         +3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDg2KrtY+r5hSPNOLM52oF65/4/O8DHcMPpTQZtCzCQ=;
        b=CbNtVJlwmw5Z4UsWNgs45Fx3yifDg8mWyrwaZcDO6pkm5barFNll6t3coQkOq6BvI0
         38osrZtFB6kDuR1DVCvu2SkRqITFzP3nHAv5A+nIEVcq9+hB8e95/2aeA/+XDrSD6cSn
         11L3lWAiKlpYnRznsK83BQTO+B34f1TqMooisXjyK8bNR7P56oPGZF6zaTpTffnbYL6J
         Qaw2qj8RZQ8r9mPoGnU6zMDLklHY+pq6xBSMnY7O7rR1ARs/Y7fP011bt0Empjl6MXPA
         AIFUQeHqU0og1sQrOCeO4mxbfIbjDx4Ro/c8KeQC1L5gk5XCAAmRGzokrIHcDFnc6z2x
         oXdA==
X-Gm-Message-State: ACrzQf2hpjc+aryJqsIQuEDezzT6G9JYkm9UnurjlTrizwHsxGB0Gio1
        8Q029XupkE3m/VOFTZH+ANiH/A==
X-Google-Smtp-Source: AMsMyM4mcjGd6wqA2OV+UDjn06MD9sW/Iu14J1FoveduF0MHp/qblYvX6ElyeN8DV5D2Mox/zgjvZQ==
X-Received: by 2002:a17:90b:1643:b0:20c:c7c7:d598 with SMTP id il3-20020a17090b164300b0020cc7c7d598mr8385533pjb.97.1665624689152;
        Wed, 12 Oct 2022 18:31:29 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id ik7-20020a170902ab0700b0016f8e8032c4sm11167699plb.129.2022.10.12.18.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 18:31:28 -0700 (PDT)
Date:   Thu, 13 Oct 2022 09:31:21 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: imx: Add missing .thaw_noirq hook
Message-ID: <20221013013121.GA2354004@dragon>
References: <20221012121353.2346280-1-shawn.guo@linaro.org>
 <Y0bpU51o88u6iH0R@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0bpU51o88u6iH0R@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 06:20:35PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 12, 2022 at 08:13:53PM +0800, Shawn Guo wrote:
> > The following warning is seen with non-console UART instance when
> > system hibernates.
> > 
> > [   37.371969] ------------[ cut here ]------------
> > [   37.376599] uart3_root_clk already disabled
> > [   37.380810] WARNING: CPU: 0 PID: 296 at drivers/clk/clk.c:952 clk_core_disable+0xa4/0xb0
> > ...
> > [   37.506986] Call trace:
> > [   37.509432]  clk_core_disable+0xa4/0xb0
> > [   37.513270]  clk_disable+0x34/0x50
> > [   37.516672]  imx_uart_thaw+0x38/0x5c
> > [   37.520250]  platform_pm_thaw+0x30/0x6c
> > [   37.524089]  dpm_run_callback.constprop.0+0x3c/0xd4
> > [   37.528972]  device_resume+0x7c/0x160
> > [   37.532633]  dpm_resume+0xe8/0x230
> > [   37.536036]  hibernation_snapshot+0x288/0x430
> > [   37.540397]  hibernate+0x10c/0x2e0
> > [   37.543798]  state_store+0xc4/0xd0
> > [   37.547203]  kobj_attr_store+0x1c/0x30
> > [   37.550953]  sysfs_kf_write+0x48/0x60
> > [   37.554619]  kernfs_fop_write_iter+0x118/0x1ac
> > [   37.559063]  new_sync_write+0xe8/0x184
> > [   37.562812]  vfs_write+0x230/0x290
> > [   37.566214]  ksys_write+0x68/0xf4
> > [   37.569529]  __arm64_sys_write+0x20/0x2c
> > [   37.573452]  invoke_syscall.constprop.0+0x50/0xf0
> > [   37.578156]  do_el0_svc+0x11c/0x150
> > [   37.581648]  el0_svc+0x30/0x140
> > [   37.584792]  el0t_64_sync_handler+0xe8/0xf0
> > [   37.588976]  el0t_64_sync+0x1a0/0x1a4
> > [   37.592639] ---[ end trace 56e22eec54676d75 ]---
> > 
> > On hibernating, pm core calls into related hooks in sequence like:
> > 
> >     .freeze
> >     .freeze_noirq
> >     .thaw_noirq
> >     .thaw
> > 
> > With .thaw_noirq hook being absent, the clock will be disabled in a
> > unbalanced call which results the warning above.
> > 
> >     imx_uart_freeze()
> >         clk_prepare_enable()
> >     imx_uart_suspend_noirq()
> >         clk_disable()
> >     imx_uart_thaw
> >         clk_disable_unprepare()
> > 
> > Adding the missing .thaw_noirq hook as imx_uart_resume_noirq() will have
> > the call sequence corrected as below and thus fix the warning.
> > 
> >     imx_uart_freeze()
> >         clk_prepare_enable()
> >     imx_uart_suspend_noirq()
> >         clk_disable()
> >     imx_uart_resume_noirq()
> >         clk_enable()
> >     imx_uart_thaw
> >         clk_disable_unprepare()
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> What commit id does this fix, and does it need to go to older/stable
> kernels?

The .thaw_noirq was missing from commit 94be6d74d040 ("serial: imx: add
hibernation support"), but it did not cause the warning until commit
09df0b3464e5 ("serial: imx: fix endless loop during suspend") changes
clock calls.  So I should have added:

Fixes: 09df0b3464e5 ("serial: imx: fix endless loop during suspend")

Shawn
