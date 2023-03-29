Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E056CD140
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjC2Eue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2Euc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:50:32 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209662D46;
        Tue, 28 Mar 2023 21:50:30 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680065428;
        bh=3uDKL3dxAD8wUGaHcCtXGJ0ik0XhHCgJ0XsIoOMR6mg=;
        h=From:Date:Subject:To:Cc:From;
        b=bsYwTtfS+4xkWfPFqC/VUCJHKjRkhFCGJa9s8462OKpDQOGfGablzqi7G1aSPs2qq
         xH4JGx04WWJFBXkIv86/0xZEVopT3qol6ylsVdkPNVTf7ghf0yiQB2R8NAP+TTAwyY
         4qJKH1QB5MUYwxaUEFn9+s0cJuhmbeBoBg47j4PQ=
Date:   Wed, 29 Mar 2023 04:50:25 +0000
Subject: [PATCH] platform/x86: think-lmi: Remove unnecessary casts for
 attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230329-think-lmi-attrs-v1-1-5794f2367cc2@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJDDI2QC/x2N0QrCMAwAf2Xk2cDsJrP+iviQbtEGa5SmijD27
 wYf7+C4FYyrsMGpW6HyR0ye6rDfdTBn0hujLM4Q+jD0Q4jYsugdy0OQWquGMY6U0nSYOB7Bq0T
 GmCrpnL3TdykuX5Wv8v1vzpdt+wFpjO6TdgAAAA==
To:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680065425; l=1970;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3uDKL3dxAD8wUGaHcCtXGJ0ik0XhHCgJ0XsIoOMR6mg=;
 b=VLmT86d5sNkUhvSPhj+1JdaQQqAB7clQbigXTWogDddXcTmRsmJVLQ8BL/b79XBx3jqBPxDaP
 SPk90swaAUFCYYddQGWptkFLOYldeyfQx+s3teWsmFooWrN8KSPdJ0M
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These casts are unnecessary and could break if structure layouts are
randomized or implementation details change.
Use the proper syntax that works without casts.

Also remove some unnecessary braces that checkpatch complains about.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/think-lmi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index c816646eb661..02bfd6e3fed2 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -862,19 +862,18 @@ static umode_t auth_attr_is_visible(struct kobject *kobj,
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
 
 	/* We only want to display level and index settings on HDD/NVMe */
-	if ((attr == (struct attribute *)&auth_index) ||
-			(attr == (struct attribute *)&auth_level)) {
+	if (attr == &auth_index.attr || attr == &auth_level.attr) {
 		if ((setting == tlmi_priv.pwd_hdd) || (setting == tlmi_priv.pwd_nvme))
 			return attr->mode;
 		return 0;
 	}
 
 	/* We only display certificates on Admin account, if supported */
-	if ((attr == (struct attribute *)&auth_certificate) ||
-			(attr == (struct attribute *)&auth_signature) ||
-			(attr == (struct attribute *)&auth_save_signature) ||
-			(attr == (struct attribute *)&auth_cert_thumb) ||
-			(attr == (struct attribute *)&auth_cert_to_password)) {
+	if (attr == &auth_certificate.attr ||
+	    attr == &auth_signature.attr ||
+	    attr == &auth_save_signature.attr ||
+	    attr == &auth_cert_thumb.attr ||
+	    attr == &auth_cert_to_password.attr) {
 		if ((setting == tlmi_priv.pwd_admin) && tlmi_priv.certificate_support)
 			return attr->mode;
 		return 0;

---
base-commit: fcd476ea6a888ef6e6627f4c21a2ea8cca3e9312
change-id: 20230329-think-lmi-attrs-994abb757e98

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

