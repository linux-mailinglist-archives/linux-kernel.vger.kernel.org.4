Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEDF742BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF2R7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjF2R71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:59:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B275330EE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:59:25 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69f216c73so15014601fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688061564; x=1690653564;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UFwrr80Kb1N/6sO3WTMK7kCswr9ccgbZi7qJt2dECrA=;
        b=au2HS2Ft/uHW3BmOlZ3MivrkaJMZ8P0F4fC7yqqNYw5sVsFw4mXkHBUXHfBWr1ST52
         d7/NEI7ITAp+tBZ/cCaHesAfdg1HgKUR6oUWOdqf37AkGk2oFgOjDzpdMlI1LmhYIQ39
         VZ3fs3wEDgciRAfmyUwffMsYBCW5NfI4N7k9hRDkI8c4y8XFNQdH7PH7Yq0PMTW6eDM2
         9gzsY30VFjtuMuHNp8VmeYncPSDa/kfTvgrv2pit597XF+j23JwIPA6uADVQnU2jZEo/
         wklHzeyUHeqNIbsASxDTYXQ7hIRnDD4io6ML7wfeEg2BY836F0UiS7VveUkTaoN/QcNb
         nogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688061564; x=1690653564;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFwrr80Kb1N/6sO3WTMK7kCswr9ccgbZi7qJt2dECrA=;
        b=kRi3k3bUFDlgsqlXXDYYGv9zHX+aziX9op3jOoPkZI16nbgvRJyPBSRrwk91w0mnXs
         e2mWlpN6IJy42cpfD/RR2G5QMvYWtjMF5ibI0s7ph8gYUvCy3nrwHG/quY3ea8e7OjTE
         yDPM6IA5LM0ftRuLAfntINOoqBwC0GT2+Xo2LLsdMpmy7yxD7E6ue5PSpQlgL7A9IEz0
         1UZ6lLfsk6fobclNRjhdPHdFgBar01UaD6FdkCc1NMkWpeUwJunmBvg+94Xjpz4D/mUT
         2eOwmlHzAyuRped3qMkeLCgOk6tU2NXBdfLHZgZTXLjJG3tn2sDJ2SvzYOzJgXySqIsR
         lEkQ==
X-Gm-Message-State: ABy/qLaFsHnIhXenfFxNf+9mdBpQXpqMgbb7PU++NwfxK/h0Mqxsjq61
        MWg8DARY5vnXmtSVbfWwXXBWMPUWCjaoRoI6qj9ylrzrUhI=
X-Google-Smtp-Source: APBJJlHarO5T+Dk7lSZsesWrREGFbVPlOdDugUbifIpej4IgI44Y32NzURbTC/2OPeZ8voF1ztPYFtJg+bmoDDNvGBE=
X-Received: by 2002:a2e:95d3:0:b0:2b6:a85e:4c3d with SMTP id
 y19-20020a2e95d3000000b002b6a85e4c3dmr349529ljh.32.1688061563748; Thu, 29 Jun
 2023 10:59:23 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?Vm9qdMSbY2ggTWFyxaHDoWw=?= <vojmar213@gmail.com>
Date:   Thu, 29 Jun 2023 19:59:12 +0200
Message-ID: <CAHneum6-Y4niCe7rp11Mpw9+rsZUDfK8ErETzWUfvqkjrxvZGw@mail.gmail.com>
Subject: [BUGREPORT] Issue with FM350_GL modem and suspend/resume on Linux
 kernel 6.1
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux Kernel Mailing List,

I am writing to seek assistance regarding a persistent issue I have
been facing with modem functionality and the suspend/resume feature on
my Linux system running kernel version 6.1. I have already searched
through bug reports but have not found a resolution or response to a
similar issue. I would appreciate any guidance or insights you can
provide to help me resolve this problem.

Description of the issue: Whenever I set my notebook to deep sleep
mode, the system suspends successfully for the first time. However,
subsequent attempts to suspend the system result in an error related
to the modem. The error message in the kernel logs is as follows:

[ 375.151668] mtk_t7xx 0000:2c:00.0: [PM] Exiting suspend, modem in
invalid state
[ 375.151680] mtk_t7xx 0000:2c:00.0: PM: pci_pm_suspend():
t7xx_pci_pm_suspend+0x0/0x20 [mtk_t7xx] returns -14
 [ 375.151719] mtk_t7xx 0000:2c:00.0: PM: dpm_run_callback():
pci_pm_suspend+0x0/0x1b0 returns -14
[ 375.151736] mtk_t7xx 0000:2c:00.0: PM: failed to suspend async: error -14
[ 375.152120] PM: Some devices failed to suspend, or early wake event detec=
ted

Steps taken so far:

- Updated kernel and modem drivers to the latest available versions.
- Checked for BIOS updates for my notebook model, but none were available.
- Disabled power management for the modem by adding "options mtk_t7xx
power_save=3D0" to a configuration file, but the issue persisted.


I have also confirmed that there is an existing bug report related to
this issue in Bugzilla, but it has been unanswered for an extended
period.

https://bugzilla.kernel.org/show_bug.cgi?id=3D216523

https://bugzilla.kernel.org/show_bug.cgi?id=3D217590

Additional details:

Notebook model: ASUS Expertbook B2
Modem model: FM350_GL
Linux distribution: Ubuntu 20.04LTS
Kernel version: Linux 6.1

I kindly request your assistance in resolving this issue or providing
any further troubleshooting steps that may help. I am open to any
suggestions or insights you can offer. Please let me know if any
additional information is required.

Thank you for your attention and support.

Best regards, Vojt=C4=9Bch Mar=C5=A1=C3=A1l
