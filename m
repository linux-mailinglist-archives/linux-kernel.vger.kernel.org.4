Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A52C6A964C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCCLbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCCLbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:31:14 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC6113EB;
        Fri,  3 Mar 2023 03:30:49 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id fd25so1349986pfb.1;
        Fri, 03 Mar 2023 03:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677843045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6RNuvoFz5fD/fH7/1p3nNqLtid6rjBFpG3wpNETfTY=;
        b=E7J4oCVoDrSrgXFmHAibCE4JVyXPjYGq/svSesvgERVS2e+39WuRl12DZgkGiwr4tV
         YJgk2orOigu7rAM/5HWfJeRKEMcma3Ljh3Wtl/Pv62IlaU9JjwCR9Y/oAqvF894LZI1+
         N4TNZaljA+G7UZHH+lLpnjXbhB/sPUgLrKWA+ywCHQg0hifyq9PG+d1X4diGGnRtbEeR
         5ZCg70phOy0D5+VVs3jtUDRHyxFvSEqlmyd/+gk7Jz7bwq+ktJGs4Nz6TXI1kiPBJBmD
         tcDKB1Hr2G7jj8kC5GSFtXKe0PNb7cYa+Vl5xCvRYxR0MS6ZAMM/u0ne2+AqZudODLRk
         OUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6RNuvoFz5fD/fH7/1p3nNqLtid6rjBFpG3wpNETfTY=;
        b=dBa4jnf9a+ltMTr0WNVay+MfvrkUXYVQUBYyp1pen68E9Zk5jPwpph6zksaUvKPc19
         vg2tDT96JNFU5tJhOjKrrTtFdqg4rhVGRj1Fp3l3kneC/jKGunYtxWC7sa8Qki24whKd
         +aBCvJMqXOYDrlGr8cvxMxTAFA12+ta23/R66U6B6yNehC/m9YrVUAw/hezSyNHAveSg
         TtxLWD8lVyEq9+jzErWXt+9Pq7ozm95Nox16AY32Ky0lFkRL61HrlLBYlpGOMKfI8dOl
         8w7B9Ah8Jt+Y0a/4+/PSWtJxlPUaD7QRzrCsrG40oAgkTSKxQS3Hs5FO2L2T6FISUVD9
         zbrg==
X-Gm-Message-State: AO0yUKXfYm0feT9x1HmAKKa7B8s6/s0A1h35kzFLpX/gyqo+3RELETFP
        1EiBYdw9wjYqbB7QNZYXAAk=
X-Google-Smtp-Source: AK7set8oBIJfyFFYsH9yrAp8ZoxBD8kIUliHnpVoh/zmfCpdWzDQN86O0zXmv7LIAL1uS57VCOiaSg==
X-Received: by 2002:a62:1848:0:b0:5a8:9fc6:6fb5 with SMTP id 69-20020a621848000000b005a89fc66fb5mr1845483pfy.16.1677843045414;
        Fri, 03 Mar 2023 03:30:45 -0800 (PST)
Received: from localhost.localdomain (124-148-239-17.tpgi.com.au. [124.148.239.17])
        by smtp.gmail.com with ESMTPSA id n4-20020a62e504000000b005a8c92f7c27sm1356262pff.212.2023.03.03.03.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 03:30:45 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v4 1/4] apple-gmux: use first bit to check switch state
Date:   Fri,  3 Mar 2023 22:28:40 +1100
Message-Id: <20230303112842.3094-2-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303112842.3094-1-orlandoch.dev@gmail.com>
References: <20230303112842.3094-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On T2 Macs with MMIO gmux, when GMUX_PORT_SWITCH_DISPLAY is read, it can
have values of 2, 3, 4, and 5. Odd values correspond to the discrete gpu,
and even values correspond to the integrated gpu. The current logic is
that only 2 corresponds to IGD, but this doesn't work for T2 Macs.
Instead, check the first bit to determine the connected gpu.

As T2 Macs with gmux only can switch the internal display, it is
untested if this change (or a similar change) would be applicable
to GMUX_PORT_SWITCH_DDC and GMUX_PORT_SWITCH_EXTERNAL.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v3->v4: Collect Hans' review
 drivers/platform/x86/apple-gmux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9333f82cfa8a..ec99e05e532c 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -346,10 +346,10 @@ static void gmux_read_switch_state(struct apple_gmux_data *gmux_data)
 	else
 		gmux_data->switch_state_ddc = VGA_SWITCHEROO_DIS;
 
-	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_DISPLAY) == 2)
-		gmux_data->switch_state_display = VGA_SWITCHEROO_IGD;
-	else
+	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_DISPLAY) & 1)
 		gmux_data->switch_state_display = VGA_SWITCHEROO_DIS;
+	else
+		gmux_data->switch_state_display = VGA_SWITCHEROO_IGD;
 
 	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL) == 2)
 		gmux_data->switch_state_external = VGA_SWITCHEROO_IGD;
-- 
2.39.2

