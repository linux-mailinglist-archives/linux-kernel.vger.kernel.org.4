Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5705968F910
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjBHUxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjBHUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:53:42 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E5144AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:53:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id v3so779340pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 12:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dBqpwpFfFQBOadN4l8Gr/FOmdtaSdVNxoegPS3Fx9rE=;
        b=LFX/iUS561LGIszFtMsAHc8Ydderc1HcuUYmgsxr8O6k3eZxp9hRxWy6nAEoaIRZQ/
         On52OOekWV9Zx82LIrY+K7lTHDOR7YK6t1wwu7mQ3nKVaucPkyEHu3tUm8EAgR1S//XE
         X9nm8rYerg2nkEGd2jB4L+P1tdS/uuy3WBg2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBqpwpFfFQBOadN4l8Gr/FOmdtaSdVNxoegPS3Fx9rE=;
        b=2NpWC1lNqUI9S2okLBAEPaD/lJlIJz/ysHRrD6g80mm6TB1ZtncXRUPcWNZ2MklUll
         2+v52oiMW3OM1lB+A8Mzwe677bXbEU3c1D4B5LZCFj492I/klGLjIKbzF3x8/3o5bPp1
         6St/o4naCvY/5auivWZ+8oKlsT4aVLCU1lkl7ZGKAZUjoZDFAzyh/kTjPoOZlxCMn+ug
         VYRKOqi9wJsZ7deBRca6bTbndlyqfYHdOXVsA4Wnh9dOuL7FnzFt5+qmsTjZ655xSuS8
         FRY9fGJ76J3rEc7sDXBBeO2lYEb1v1Z9SD4dSl+uR5upKn0Pj/0hLrKyeg362DBQxIYD
         84gg==
X-Gm-Message-State: AO0yUKXVJ8SVaEvLjcc2Y8JrwOvSFxbAB0rD6UqNRDstDTeAR2bQKADJ
        qFz8kqYQl0ZOvE++j/71cqBrR3DYnv8FzneE
X-Google-Smtp-Source: AK7set9rK+FspJQKjYz2lT69SOJtB/4D1Y6PP/AkbpDVBmk+zHSMM8Xk8fEzJZWVj5wpI231op+66g==
X-Received: by 2002:a05:6a00:1d0a:b0:5a8:473e:2fdc with SMTP id a10-20020a056a001d0a00b005a8473e2fdcmr1813364pfx.12.1675889619998;
        Wed, 08 Feb 2023 12:53:39 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z11-20020aa785cb000000b0058e264958b7sm11920618pfn.91.2023.02.08.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:53:39 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        stable@vger.kernel.org, Diana Zigterman <dzigterman@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH] usb: typec: altmodes/displayport: Fix probe pin assign check
Date:   Wed,  8 Feb 2023 20:53:19 +0000
Message-Id: <20230208205318.131385-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While checking Pin Assignments of the port and partner during probe, we
don't take into account whether the peripheral is a plug or receptacle.

This manifests itself in a mode entry failure on certain docks and
dongles with captive cables. For instance, the Startech.com Type-C to DP
dongle (Model #CDP2DP) advertises its DP VDO as 0x405. This would fail
the Pin Assignment compatibility check, despite it supporting
Pin Assignment C as a UFP.

Update the check to use the correct DP Pin Assign macros that
take the peripheral's receptacle bit into account.

Fixes: c1e5c2f0cb8a ("usb: typec: altmodes/displayport: correct pin assignment for UFP receptacles")
Cc: stable@vger.kernel.org
Reported-by: Diana Zigterman <dzigterman@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

I realize this is a bit late in the release cycle, but figured since it
is a fix it might still be considered. Please let me know if it's too
late and I can re-send this after the 6.3-rc1 is released. Thanks!

 drivers/usb/typec/altmodes/displayport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 20db51471c98..662cd043b50e 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -547,10 +547,10 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	/* FIXME: Port can only be DFP_U. */
 
 	/* Make sure we have compatiple pin configurations */
-	if (!(DP_CAP_DFP_D_PIN_ASSIGN(port->vdo) &
-	      DP_CAP_UFP_D_PIN_ASSIGN(alt->vdo)) &&
-	    !(DP_CAP_UFP_D_PIN_ASSIGN(port->vdo) &
-	      DP_CAP_DFP_D_PIN_ASSIGN(alt->vdo)))
+	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
+	      DP_CAP_PIN_ASSIGN_UFP_D(alt->vdo)) &&
+	    !(DP_CAP_PIN_ASSIGN_UFP_D(port->vdo) &
+	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
 		return -ENODEV;
 
 	ret = sysfs_create_group(&alt->dev.kobj, &dp_altmode_group);
-- 
2.39.1.519.gcb327c4b5f-goog

