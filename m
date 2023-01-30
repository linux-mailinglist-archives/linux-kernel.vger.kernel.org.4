Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992E66819E3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbjA3THh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbjA3THd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:07:33 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9695B38666;
        Mon, 30 Jan 2023 11:07:31 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 38ad90d73f134747; Mon, 30 Jan 2023 20:07:29 +0100
Received: from kreacher.localnet (unknown [213.134.169.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 016D22528287;
        Mon, 30 Jan 2023 20:07:28 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v1 6/8] thermal: intel: intel_pch: Fold suspend and resume routines into their callers
Date:   Mon, 30 Jan 2023 20:04:05 +0100
Message-ID: <1817848.atdPhlSkOF@kreacher>
In-Reply-To: <1751684.VLH7GnMWUR@kreacher>
References: <1751684.VLH7GnMWUR@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.112
X-CLIENT-HOSTNAME: 213.134.169.112
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudeiledrudduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdduuddvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdho
 rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugdrvgdrsghogieslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fold pch_suspend() and pch_resume(), that each have only one caller,
into their respective callers to make the code somewhat easier to
follow.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c |  155 +++++++++++++-----------------
 1 file changed, 71 insertions(+), 84 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -117,88 +117,6 @@ static int pch_wpt_add_acpi_psv_trip(str
 }
 #endif
 
-/* Cool the PCH when it's overheat in .suspend_noirq phase */
-static int pch_suspend(struct pch_thermal_device *ptd)
-{
-	u8 tsel;
-	int pch_delay_cnt = 0;
-	u16 pch_thr_temp, pch_cur_temp;
-
-	/* Shutdown the thermal sensor if it is not enabled by BIOS */
-	if (!ptd->bios_enabled) {
-		tsel = readb(ptd->hw_base + WPT_TSEL);
-		writeb(tsel & 0xFE, ptd->hw_base + WPT_TSEL);
-		return 0;
-	}
-
-	/* Do not check temperature if it is not s2idle */
-	if (pm_suspend_via_firmware())
-		return 0;
-
-	/* Get the PCH temperature threshold value */
-	pch_thr_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TSPM));
-
-	/* Get the PCH current temperature value */
-	pch_cur_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
-
-	/*
-	 * If current PCH temperature is higher than configured PCH threshold
-	 * value, run some delay loop with sleep to let the current temperature
-	 * go down below the threshold value which helps to allow system enter
-	 * lower power S0ix suspend state. Even after delay loop if PCH current
-	 * temperature stays above threshold, notify the warning message
-	 * which helps to indentify the reason why S0ix entry was rejected.
-	 */
-	while (pch_delay_cnt < delay_cnt) {
-		if (pch_cur_temp < pch_thr_temp)
-			break;
-
-		if (pm_wakeup_pending()) {
-			dev_warn(&ptd->pdev->dev, "Wakeup event detected, abort cooling\n");
-			return 0;
-		}
-
-		pch_delay_cnt++;
-		dev_dbg(&ptd->pdev->dev,
-			"CPU-PCH current temp [%dC] higher than the threshold temp [%dC], sleep %d times for %d ms duration\n",
-			pch_cur_temp, pch_thr_temp, pch_delay_cnt, delay_timeout);
-		msleep(delay_timeout);
-		/* Read the PCH current temperature for next cycle. */
-		pch_cur_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
-	}
-
-	if (pch_cur_temp >= pch_thr_temp)
-		dev_warn(&ptd->pdev->dev,
-			"CPU-PCH is hot [%dC] after %d ms delay. S0ix might fail\n",
-			pch_cur_temp, pch_delay_cnt * delay_timeout);
-	else {
-		if (pch_delay_cnt)
-			dev_info(&ptd->pdev->dev,
-				"CPU-PCH is cool [%dC] after %d ms delay\n",
-				pch_cur_temp, pch_delay_cnt * delay_timeout);
-		else
-			dev_info(&ptd->pdev->dev,
-				"CPU-PCH is cool [%dC]\n",
-				pch_cur_temp);
-	}
-
-	return 0;
-}
-
-static int pch_resume(struct pch_thermal_device *ptd)
-{
-	u8 tsel;
-
-	if (ptd->bios_enabled)
-		return 0;
-
-	tsel = readb(ptd->hw_base + WPT_TSEL);
-
-	writeb(tsel | WPT_TSEL_ETS, ptd->hw_base + WPT_TSEL);
-
-	return 0;
-}
-
 static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
 {
 	struct pch_thermal_device *ptd = tzd->devdata;
@@ -372,15 +290,84 @@ static void intel_pch_thermal_remove(str
 static int intel_pch_thermal_suspend_noirq(struct device *device)
 {
 	struct pch_thermal_device *ptd = dev_get_drvdata(device);
+	u16 pch_thr_temp, pch_cur_temp;
+	int pch_delay_cnt = 0;
+	u8 tsel;
+
+	/* Shutdown the thermal sensor if it is not enabled by BIOS */
+	if (!ptd->bios_enabled) {
+		tsel = readb(ptd->hw_base + WPT_TSEL);
+		writeb(tsel & 0xFE, ptd->hw_base + WPT_TSEL);
+		return 0;
+	}
+
+	/* Do not check temperature if it is not s2idle */
+	if (pm_suspend_via_firmware())
+		return 0;
+
+	/* Get the PCH temperature threshold value */
+	pch_thr_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TSPM));
+
+	/* Get the PCH current temperature value */
+	pch_cur_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
 
-	return pch_suspend(ptd);
+	/*
+	 * If current PCH temperature is higher than configured PCH threshold
+	 * value, run some delay loop with sleep to let the current temperature
+	 * go down below the threshold value which helps to allow system enter
+	 * lower power S0ix suspend state. Even after delay loop if PCH current
+	 * temperature stays above threshold, notify the warning message
+	 * which helps to indentify the reason why S0ix entry was rejected.
+	 */
+	while (pch_delay_cnt < delay_cnt) {
+		if (pch_cur_temp < pch_thr_temp)
+			break;
+
+		if (pm_wakeup_pending()) {
+			dev_warn(&ptd->pdev->dev, "Wakeup event detected, abort cooling\n");
+			return 0;
+		}
+
+		pch_delay_cnt++;
+		dev_dbg(&ptd->pdev->dev,
+			"CPU-PCH current temp [%dC] higher than the threshold temp [%dC], sleep %d times for %d ms duration\n",
+			pch_cur_temp, pch_thr_temp, pch_delay_cnt, delay_timeout);
+		msleep(delay_timeout);
+		/* Read the PCH current temperature for next cycle. */
+		pch_cur_temp = GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
+	}
+
+	if (pch_cur_temp >= pch_thr_temp)
+		dev_warn(&ptd->pdev->dev,
+			"CPU-PCH is hot [%dC] after %d ms delay. S0ix might fail\n",
+			pch_cur_temp, pch_delay_cnt * delay_timeout);
+	else {
+		if (pch_delay_cnt)
+			dev_info(&ptd->pdev->dev,
+				"CPU-PCH is cool [%dC] after %d ms delay\n",
+				pch_cur_temp, pch_delay_cnt * delay_timeout);
+		else
+			dev_info(&ptd->pdev->dev,
+				"CPU-PCH is cool [%dC]\n",
+				pch_cur_temp);
+	}
+
+	return 0;
 }
 
 static int intel_pch_thermal_resume(struct device *device)
 {
 	struct pch_thermal_device *ptd = dev_get_drvdata(device);
+	u8 tsel;
 
-	return pch_resume(ptd);
+	if (ptd->bios_enabled)
+		return 0;
+
+	tsel = readb(ptd->hw_base + WPT_TSEL);
+
+	writeb(tsel | WPT_TSEL_ETS, ptd->hw_base + WPT_TSEL);
+
+	return 0;
 }
 
 static const struct pci_device_id intel_pch_thermal_id[] = {



