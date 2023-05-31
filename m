Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A617183CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbjEaNwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjEaNty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DC2273D;
        Wed, 31 May 2023 06:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C83563B3B;
        Wed, 31 May 2023 13:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3ABBC433EF;
        Wed, 31 May 2023 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540711;
        bh=xofLHve9NdTRBvTndbHU2RqSkaajMrMqmzcFrW5GaR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQkhSVrav2obDDx74DLUZyhWJqNN+U/V6MWM9npTqbENe8cq3AQPGDvO/EA3qmwiN
         vBPJiuwwBgA6U/Qvo5G+V+KuPkRxnXbepdBzWmHfIt1Lf1VHCfqitKSRtW8+1w7HED
         2Usqo/vmt3nXahrG+ha+rIy9VqMTvO/OoMfAXyeO8gQbK2Pi5cYyWitjvlemO4e+1E
         13SQmkfBTL32gPmmx0Q8A1UoFUSd/mP1/fZ/Z3i0TIxTwmpjaTPRmxhSn+QalLVBXf
         El21nNdZHc0MQT+0x5V8Hp82DEX4x67LeZt8pKNCaLmwkyb7wfAnpNPZPQOMVUWYSv
         2kTlp8PRnoCrQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandru Sorodoc <ealex95@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, corentin.chary@gmail.com,
        markgross@kernel.org, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/17] platform/x86: asus-wmi: Ignore WMI events with codes 0x7B, 0xC0
Date:   Wed, 31 May 2023 09:44:50 -0400
Message-Id: <20230531134502.3384828-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134502.3384828-1-sashal@kernel.org>
References: <20230531134502.3384828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Sorodoc <ealex95@gmail.com>

[ Upstream commit 362c1f2ec82cb65940e1c73e15a395a7a891fc6f ]

On ASUS GU604V the key 0x7B is issued when the charger is connected or
disconnected, and key 0xC0 is issued when an external display is
connected or disconnected.

This commit maps them to KE_IGNORE to slience kernel messages about
unknown keys, such as:

    kernel: asus_wmi: Unknown key code 0x7b

Signed-off-by: Alexandru Sorodoc <ealex95@gmail.com>
Link: https://lore.kernel.org/r/20230512101517.47416-1-ealex95@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 6424bdb33d2f0..78d357de2f040 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -555,6 +555,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x6B, { KEY_TOUCHPAD_TOGGLE } },
 	{ KE_IGNORE, 0x6E, },  /* Low Battery notification */
 	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
+	{ KE_IGNORE, 0x7B, }, /* Charger connect/disconnect notification */
 	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
 	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
@@ -580,6 +581,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xA6, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + HDMI */
 	{ KE_KEY, 0xA7, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + HDMI */
 	{ KE_KEY, 0xB5, { KEY_CALC } },
+	{ KE_IGNORE, 0xC0, }, /* External display connect/disconnect notification */
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
-- 
2.39.2

