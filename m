Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427E065CCCD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjADGJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjADGJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:09:17 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A80217E09
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 22:09:04 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v3so21573462pgh.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 22:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugbM9GhIHqb4MVhnuzFZlbylgderdj1/9nzv3BJLAfw=;
        b=XN7UcaT/R6KMixGU1AD3M9jb1Wnx1YjmLA6GSFhzDoKqrQ8IupYAFh37F9qL6LDrIO
         nNdnBX+ndVgeatZ1K0YRNlFN6b+/VkggE7paFRmF/E8CTVJl1Yqob9cGfI/+K8vhGjkF
         onos9srhmZfOYjwy/OPJyHLxYB5ZRpdSwTGBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugbM9GhIHqb4MVhnuzFZlbylgderdj1/9nzv3BJLAfw=;
        b=CGk1ndN07KfBl6BXOH67uKJB9dDatOFDPQGiLdfQkvy4emVaimPXZGE2pF3EbfkzXf
         N9+u5FSvKodQ8kBghkgDbwabNWw/As6pniRKegxVVeTO6sXbcC0NDcX/Z1+SZA5XF6fx
         Trivbl/43wuw0OVBruGxRXI5y6Zhc9WMuow5D3RQj8lN2iiVL5D5BR7Qju4G3g5mdAXa
         4BlMMvbJ7efVFT6TyYVtUVxn+391EbAgeMist44F0+LpzhIPNO94hsvxblL3ZFsvfbei
         H3JoiX1GMmQdvsIUagQJMvg+x4jQbOrQbftLTmNV+Yg2XkWdoSdyO9wz2sXAqtKYCcXH
         M23Q==
X-Gm-Message-State: AFqh2kp/RHOC7SCZ4K/yHZBk5rH0n46/8oA793Y2QQ2p/zypZM96SQtn
        Ea4AMaDH3wghUzZb7mWt2yCvEGB2D/fAcus2
X-Google-Smtp-Source: AMrXdXtggieJeeDwqXLkoF+peCXfavToOZMjMTl9uWWSTSP3J9bSXdHxt52TTKfZ8IcoA8KPzARU9g==
X-Received: by 2002:aa7:88c3:0:b0:580:963d:8064 with SMTP id k3-20020aa788c3000000b00580963d8064mr59521363pff.20.1672812543417;
        Tue, 03 Jan 2023 22:09:03 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b00577c5915138sm124660pfi.128.2023.01.03.22.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:09:03 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_typec_switch: Check for retimer flag
Date:   Wed,  4 Jan 2023 06:08:45 +0000
Message-Id: <20230104060846.112216-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230104060846.112216-1-pmalani@chromium.org>
References: <20230104060846.112216-1-pmalani@chromium.org>
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

Not all ports have retimers. Only register a retimer switch if the
"retimer-switch" property is present for that port's mux
device.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_typec_switch.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 2536bda03bf3..9ed1605f4071 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -246,14 +246,16 @@ static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
 		port->port_num = index;
 		sdata->ports[index] = port;
 
-		ret = cros_typec_register_retimer(port, fwnode);
-		if (ret) {
-			dev_err(dev, "Retimer switch register failed\n");
-			goto err_switch;
+		if (fwnode_property_present(fwnode, "retimer-switch")) {
+			ret = cros_typec_register_retimer(port, fwnode);
+			if (ret) {
+				dev_err(dev, "Retimer switch register failed\n");
+				goto err_switch;
+			}
+
+			dev_dbg(dev, "Retimer switch registered for index %llu\n", index);
 		}
 
-		dev_dbg(dev, "Retimer switch registered for index %llu\n", index);
-
 		if (!fwnode_property_present(fwnode, "mode-switch"))
 			continue;
 
-- 
2.39.0.314.g84b9a713c41-goog

