Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110EF5FC511
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJLMOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJLMOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:14:19 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002D97AC0C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:14:18 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id mx8so10743286qvb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk0mJuYJ+uetlsgCAR2M/DnPNvLXVpY6+d7GL5QMYbk=;
        b=ZvdRu01hmrSgFO9/Rh33/Yd+y1vZBaRao9GdzK3ZxsZcSWD5nAxGyT/d0SfWtUb1oJ
         k2elDptzBjtDCJ+4TmgCYwOW8ZeQ74Ed7cHB5PP65Tl0GYS7HSPwd2Pqy59QRyrKxVlN
         /yBkBsyhqZW2A2vce1Kj5JWSeHOXFLDtHAeCvhApQcB9314nXzCxhwiah+r9qjIbd3tK
         8GpKUB5mLsxo3YkRyxkRtx8oDn5cn+RqMYyMJdb7JRC9Gu+FST6j6Y8M6tYNCRFdXDYM
         +xmGk20CGBkmjZldDSIXMMWlxSehnBCaDxQf2EKCHRj0f5xH34agGW4tZRf/2twjhVwx
         ZIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pk0mJuYJ+uetlsgCAR2M/DnPNvLXVpY6+d7GL5QMYbk=;
        b=XPa+eFvns3REEYRDYka3D19vA4JUCf//567Sjk91AMow4TfTpP1pOjHC2UYO4ECzrA
         DkRRgV6DTystDIvMuVz5AY8WaMqoubwZAsntRBrkkiFSyHGXkvdNBElUEJNgHip22gJ/
         jf6Hs3prBLePC8UFK+w1J1wzVJk6tR60IQ75f6pKCcDuc/5uAHlGlVxWZkf6dS4Qg/T/
         kcvP7hm5urfeEko2zhE1jFAPOiIYZepIh5O2C34tAzUOxOluLHXQM2jHlFe7PY5ll6Gl
         VEEYSB87t5q6TWtp2hDh1fzBcK5UICeXtqgN4g50IvKWuq2c4H4Mf9MqZ51gwOM1wP+O
         2e8Q==
X-Gm-Message-State: ACrzQf0kJg16pDkrlrgjtatXXn/NRnzSXLuHKrCc7FelNs3JYVMylyG/
        xs14re/WQDWBaHvWXxSKeA9qvRdHxYI44A==
X-Google-Smtp-Source: AMsMyM4uG6jpcLDJXYitOq81RNFGH1xslouPo9DAAgEWM0PFk9clcCnutoAgaND4pYP+SBcOxDbcVw==
X-Received: by 2002:a17:903:31c9:b0:17a:e5c:1332 with SMTP id v9-20020a17090331c900b0017a0e5c1332mr29402552ple.86.1665576847187;
        Wed, 12 Oct 2022 05:14:07 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 9-20020a631649000000b00458a0649474sm9438182pgw.11.2022.10.12.05.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:14:06 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] serial: imx: Add missing .thaw_noirq hook
Date:   Wed, 12 Oct 2022 20:13:53 +0800
Message-Id: <20221012121353.2346280-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning is seen with non-console UART instance when
system hibernates.

[   37.371969] ------------[ cut here ]------------
[   37.376599] uart3_root_clk already disabled
[   37.380810] WARNING: CPU: 0 PID: 296 at drivers/clk/clk.c:952 clk_core_disable+0xa4/0xb0
...
[   37.506986] Call trace:
[   37.509432]  clk_core_disable+0xa4/0xb0
[   37.513270]  clk_disable+0x34/0x50
[   37.516672]  imx_uart_thaw+0x38/0x5c
[   37.520250]  platform_pm_thaw+0x30/0x6c
[   37.524089]  dpm_run_callback.constprop.0+0x3c/0xd4
[   37.528972]  device_resume+0x7c/0x160
[   37.532633]  dpm_resume+0xe8/0x230
[   37.536036]  hibernation_snapshot+0x288/0x430
[   37.540397]  hibernate+0x10c/0x2e0
[   37.543798]  state_store+0xc4/0xd0
[   37.547203]  kobj_attr_store+0x1c/0x30
[   37.550953]  sysfs_kf_write+0x48/0x60
[   37.554619]  kernfs_fop_write_iter+0x118/0x1ac
[   37.559063]  new_sync_write+0xe8/0x184
[   37.562812]  vfs_write+0x230/0x290
[   37.566214]  ksys_write+0x68/0xf4
[   37.569529]  __arm64_sys_write+0x20/0x2c
[   37.573452]  invoke_syscall.constprop.0+0x50/0xf0
[   37.578156]  do_el0_svc+0x11c/0x150
[   37.581648]  el0_svc+0x30/0x140
[   37.584792]  el0t_64_sync_handler+0xe8/0xf0
[   37.588976]  el0t_64_sync+0x1a0/0x1a4
[   37.592639] ---[ end trace 56e22eec54676d75 ]---

On hibernating, pm core calls into related hooks in sequence like:

    .freeze
    .freeze_noirq
    .thaw_noirq
    .thaw

With .thaw_noirq hook being absent, the clock will be disabled in a
unbalanced call which results the warning above.

    imx_uart_freeze()
        clk_prepare_enable()
    imx_uart_suspend_noirq()
        clk_disable()
    imx_uart_thaw
        clk_disable_unprepare()

Adding the missing .thaw_noirq hook as imx_uart_resume_noirq() will have
the call sequence corrected as below and thus fix the warning.

    imx_uart_freeze()
        clk_prepare_enable()
    imx_uart_suspend_noirq()
        clk_disable()
    imx_uart_resume_noirq()
        clk_enable()
    imx_uart_thaw
        clk_disable_unprepare()

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 590a25369531..e5163c2c4169 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2603,6 +2603,7 @@ static const struct dev_pm_ops imx_uart_pm_ops = {
 	.suspend_noirq = imx_uart_suspend_noirq,
 	.resume_noirq = imx_uart_resume_noirq,
 	.freeze_noirq = imx_uart_suspend_noirq,
+	.thaw_noirq = imx_uart_resume_noirq,
 	.restore_noirq = imx_uart_resume_noirq,
 	.suspend = imx_uart_suspend,
 	.resume = imx_uart_resume,
-- 
2.25.1

