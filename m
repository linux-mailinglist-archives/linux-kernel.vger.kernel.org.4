Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CDA6AE4D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCGPda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjCGPdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:33:08 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89487E78B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:32:51 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n6so14494079plf.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678203171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAaIzsWI+DXQ807RCKvS+zEYcv/H3X+nOpua3UqPND8=;
        b=c+U7tgYtMbvwsqogjSKc1e3jIlbaa2okhG0YBUKZ+/YpKGgJjzUmnneyowcxRJm6DW
         6jRthk68ytVUzM6sh77z9yVlZ5e5B8aQ/MoNxhzWxjPegCa/OgwXJGGSl/BLJRDTvUrz
         SIWK4/R9Du0ulewEUbp9nuwXkJNeU36Yux5/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAaIzsWI+DXQ807RCKvS+zEYcv/H3X+nOpua3UqPND8=;
        b=74dlXQw423tRScMNgIRzRDGJsK9TLIxG+vM5VmiyarP7s/ONRqGhmQcU0p6bKTnGTH
         0rVWKkoJzWHimmIzu+/aLTAJJ+jXtBRdAAIIaOayp82LAW+sNSlCZRflKCAmOfWil0Pj
         CliLpkMW3jwt7EyVixfqUqa2Um+djqy80rG4NyVMgQmGR47TqLIbK7RKe5Nm6B0U7TM6
         fAW4fMP1JNqJ6B4amOZih5B5yD4V6DcY9nYtMXirms3ooUm095p/kzAzRdvjlDOpfxQA
         j33TUrlNXZk4zDYfEi1L5Bs5kzuiam3UMoXcSXcXXYtCMW3gsogbT5vlFRRDuMtGrAnr
         gkuw==
X-Gm-Message-State: AO0yUKX+WfmsU9TXgf8dSdH+ssMwS9Rcg7cQVAIcxXo9H3Dnb2nMrUOu
        gEQNVIwaiq8fHfGqZbC3exiDEw==
X-Google-Smtp-Source: AK7set9YT+h+URl5z9jkarOCmjqbanYlcXm3N10vAqJLY2v22NAZ3Ao9oO5SaoI6/ADUBN1+wljhtQ==
X-Received: by 2002:a17:903:1c9:b0:19e:6fd5:f4fa with SMTP id e9-20020a17090301c900b0019e6fd5f4famr15192866plh.69.1678203171195;
        Tue, 07 Mar 2023 07:32:51 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:2023:7dda:98bb:96dd])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm8586843plb.59.2023.03.07.07.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:32:50 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tty: serial: qcom-geni-serial: Add a poll_init() function
Date:   Tue,  7 Mar 2023 07:32:13 -0800
Message-Id: <20230307073155.3.Ie678853bb101091afe78cc8c22344bf3ff3aed74@changeid>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid>
References: <20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sc7180 Chromebooks, I did the following:
* Didn't enable earlycon in the kernel command line.
* Didn't enable serial console in the kernel command line.
* Didn't enable an agetty or any other client of "/dev/ttyMSM0".
* Added "kgdboc=ttyMSM0" to the kernel command line.

After I did that, I tried to enter kdb with this command over an ssh
session:
  echo g > /proc/sysrq-trigger

When I did that the system just hung.

Although I thought I'd tested this scenario before, I couldn't go back
and find a time when it was working. Previous testing must have relied
on either the UART acting as the kernel console or an agetty running.

It turns out to be pretty easy to fix: we can just use
qcom_geni_serial_port_setup() as the .poll_init() function. This,
together with the patch ("serial: uart_poll_init() should power on the
UART"), allows the debugger to work even if there are no other users
of the serial port.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 74a0e074c2de..00752ff783c6 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1534,6 +1534,7 @@ static const struct uart_ops qcom_geni_console_pops = {
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_get_char	= qcom_geni_serial_get_char,
 	.poll_put_char	= qcom_geni_serial_poll_put_char,
+	.poll_init = qcom_geni_serial_port_setup,
 #endif
 	.pm = qcom_geni_serial_pm,
 };
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

