Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE10626537
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiKKXNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKXNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:13:09 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3E363CC7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:13:08 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id b62so5530416pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmjht/hVO1qKtZApkaycgUVmJWkPJQVFE4gCtMvHeIQ=;
        b=mi7vvLSbUqjf6eYDklwz4PxdGeRjRl5icdTCigGyh7vAmd7DxvW1+VQn3OC6on3njF
         ZXQbtjY2evJ4xsO1M58pR3sWEibkDblu8PJvoLQs1pf61kbKF25CvcjCHM6SQ2dgNIAC
         IqrM9FseUitb/bwaO2ZoBazNavf0OEswXHM/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmjht/hVO1qKtZApkaycgUVmJWkPJQVFE4gCtMvHeIQ=;
        b=daQKtCBW3c6TVTv1VIFAbH2eIa6/0eRz2sU0b5S4W7Gnj0vQiNwdILmIzJLfpZucVc
         2uPMuNWOGUa0PwDLUYGxCeTp+IEuFYaOdTU2WJ0lS/YxSIT+yD73fzMwYgYMLVUEAyxA
         H7Ehs2rNmyjs1aLWP4VzSgQzojV/Wkv4cha/ZC6TqpGYvapOX1It6/L/Y85D0s6DvNgs
         uOqguT/+lJSKo+sYXdMc7aagHo2k+Or1eO+xUtncrxlwqjS6GGeEBlXeRIWh0yAgutB6
         Kyi4h2mlT+aRgL+hUZ+6EcRmnP82ifzgRqQgEaW41pbtTIc66e6ug7UNGN8yX3qqCUtl
         CwUg==
X-Gm-Message-State: ANoB5pm65tn6YH+kKVZ4Tox2KWn+7iy3HeWtx9u2KOzDHap7RJmUdMfJ
        lzuHFDTPVxv3r+w4inGENcLjvQ==
X-Google-Smtp-Source: AA0mqf5rxc3hd/kcsj61i+VfkB38xqV7oUcWId0NEijGnleSVEE6bthM12vd8724/F2aVxqYn5cvFw==
X-Received: by 2002:aa7:8813:0:b0:56b:f64b:b385 with SMTP id c19-20020aa78813000000b0056bf64bb385mr4651731pfo.68.1668208388204;
        Fri, 11 Nov 2022 15:13:08 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:dc0d:97e5:4cb6:b4d3])
        by smtp.gmail.com with UTF8SMTPSA id i188-20020a6254c5000000b0056e0ff577edsm2087362pfb.43.2022.11.11.15.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 15:13:07 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_lpc: Force synchronous probe
Date:   Fri, 11 Nov 2022 15:13:01 -0800
Message-Id: <20221111231302.3458191-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit bd88b965ae8c ("platform/chrome: cros_ec_lpc: Mark
PROBE_PREFER_ASYNCHRONOUS"), and then some.

It has been reported that there are issues with 'cros-ec-keyb' devices
that are children of this. As noted in the initial patch for its ACPI
support (commit ba0f32141bc5 ("Input: cros_ec_keyb - handle x86
detachable/convertible Chromebooks")), it's possible to probe an ACPI
child device before its parent is probed -- hence the need for
EPROBE_DEFER. Unfortunately, poking your parent's dev_get_drvdata()
isn't safe with asynchronous probe, as there's no locking, and the
ordering is all wrong anyway (drvdata is set before the device is
*really* ready).

Because this parent/child relationship has known issues, let's go the
other direction and force synchronous probe, until we resolve the
issues.

Possible solutions involve adding device links, so we ensure the child
doesn't probe before the parent is done; or perhaps some other larger
refactoring (auxiliary bus?). But that might take a little more effort
and review, as there are many other potential sub-devices of
cros_ec_lpc that could need patching.

Note that we don't have the same problem for non-ACPI cros-ec hosts,
like cros-ec-spi (commit 015e4b05c377 ("platform/chrome: cros_ec_spi:
Set PROBE_PREFER_ASYNCHRONOUS")), because its sub-devices aren't created
until cros_ec_register(), or they don't exist at all (e.g., FPMCU uses).

Fixes: bd88b965ae8c ("platform/chrome: cros_ec_lpc: Mark PROBE_PREFER_ASYNCHRONOUS")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/platform/chrome/cros_ec_lpc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 2e4dba724ada..7fc8f82280ac 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -557,7 +557,12 @@ static struct platform_driver cros_ec_lpc_driver = {
 		.name = DRV_NAME,
 		.acpi_match_table = cros_ec_lpc_acpi_device_ids,
 		.pm = &cros_ec_lpc_pm_ops,
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		/*
+		 * ACPI child devices may probe before us, and they racily
+		 * check our drvdata pointer. Force synchronous probe until
+		 * those races are resolved.
+		 */
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 	.probe = cros_ec_lpc_probe,
 	.remove = cros_ec_lpc_remove,
-- 
2.38.1.431.g37b22c650d-goog

