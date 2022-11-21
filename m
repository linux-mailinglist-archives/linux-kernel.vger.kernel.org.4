Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC6632DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiKUUOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiKUUOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:14:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E1651C1A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:13:59 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id g5so2888242pjp.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+miEWjJAtnDGZKESGC2K13aQrBJTCpBeMrGNcOOuCUo=;
        b=h72e6p/FkTIdXBoJPIHLPAwYiX0sUKoIYNfLigO8S8y3c5Hmp3ItR+mjG8pawk/swt
         0rYb7PZGEFIBlW4wV8boeOS0y/Tpq1t9tBOauGJCVvcBRUZtsZJm2m7Jbl96APMGvc4b
         5XGoN2yZR2a/iKRPfuWT02FW/jZppd6CW53xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+miEWjJAtnDGZKESGC2K13aQrBJTCpBeMrGNcOOuCUo=;
        b=i8v6X/dGs13eUsYlEx/ZWfX2UnqjM0EDAzHjvEHPEsxRcblspm52lUZs6QkFnORXl8
         SSPKwz2u5FNCAYUGfP5Xcs3NzlsiVs/VW6PX0UAK71v0UxJDJ15kaVrSQ8qGhIkpMF7e
         kB02CSSpuw8MK9OhENc+cCIRuF3/0qiTa8PiXEN1iOYd8zTooE9UYgUcN2o8uLhuFWWM
         2j1F09xtklEJrliHnfeyB/47FveXdQGGopCfkVv1bx5fZpHyyDeslMjAeGNzSbRW7wn/
         cbXDscfJukBrTubk9Ih9zgzDEU2yL2m4cBYdSNRZxxqK1WSQ9ttnmyYyGfIJ4NgWzTEJ
         qPzw==
X-Gm-Message-State: ANoB5pler6brrVxhifeBmgoExhrQyXkCds2XaxUqUVQUzM0F/5s7M0j0
        0FB6gS4DtO3IsfkXbpFcxs0fgbZ2zT9WBg==
X-Google-Smtp-Source: AA0mqf4J2H1pH7NHOK+06xGanIwq/IsfLuMtmvKrdt5ShfRBmYOT3EPi6ihcIuBrDAvRaEvm7bUiNw==
X-Received: by 2002:a17:902:f609:b0:178:2a08:2e7f with SMTP id n9-20020a170902f60900b001782a082e7fmr1199139plg.128.1669061639225;
        Mon, 21 Nov 2022 12:13:59 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f70800b001822121c45asm10178507plo.28.2022.11.21.12.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 12:13:58 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_typec: Set parent of partner PD object
Date:   Mon, 21 Nov 2022 20:13:36 +0000
Message-Id: <20221121201337.2772216-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221121201337.2772216-1-pmalani@chromium.org>
References: <20221121201337.2772216-1-pmalani@chromium.org>
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

In order to tell what Type-C device a PD object belongs to, its parent
needs to be set. Set the parent appropriately for PD objects which are
created for connected Type-C partners.

Cc: Benson Leung <bleung@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2a7ff14dc37e..a1cc23b86f3c 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -968,7 +968,7 @@ static void cros_typec_register_partner_pdos(struct cros_typec_data *typec,
 	if (!resp->source_cap_count && !resp->sink_cap_count)
 		return;
 
-	port->partner_pd = usb_power_delivery_register(NULL, &desc);
+	port->partner_pd = usb_power_delivery_register(typec_partner_to_dev(port->partner), &desc);
 	if (IS_ERR(port->partner_pd)) {
 		dev_warn(typec->dev, "Failed to register partner PD device, port: %d\n", port_num);
 		return;
-- 
2.38.1.584.g0f3c55d4c2-goog

