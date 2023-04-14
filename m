Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF06E2886
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDNQl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDNQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:41:26 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED41B4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:41:26 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id bu14-20020a0568300d0e00b0069fab3f4cafso9021403otb.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681490485; x=1684082485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCROuI9qGjr1e6FaOJtEHxCuk9OEai2bcsOdmRyfB1c=;
        b=kyYl6bs2HrKDvZh6E9n298QmLiL7EjVs/iO/39n8M8kJVVNrOKfK2EYRFhTripHtij
         qVpXzXi5x2YhDQYFYxRZqvEHCwUQWM4tOJ1Y0PyJbYwjQJbegz3y7T8NF4q2kCyragGS
         PxSm0oqrcTBmRi6y7Bmv8gahjU42BwW8y9KRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490485; x=1684082485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCROuI9qGjr1e6FaOJtEHxCuk9OEai2bcsOdmRyfB1c=;
        b=XQYsnXU+h+8qlo+wrI3DkLWgbX6uXi+OBGBk1yqvjwFLJUmHvKWX9tte+S2C4SFr6f
         7bM5kada1SXZ8DWfQeEe2s52LqUpIw3dNRyJPmABsUprQ4cS64Qz+rm+jLmYYYJOJdOq
         4xVrWKlWzPcV+lKfpu9K4BxGUg7cYKtRvNXuW8nhSB9BYCMl9OO//qD7FPKyg2XIoT1r
         wIQV4qXFKLJQIjUqE68to8lJQ/bnfMEb3ua5L2AoxDcnP+NZBFdVlh6s/d9M+vTo2mqK
         wsmDST7yy2ISEWf6wa+YhvPdIg1Gx0Q1jM70X3NEJzgVw6ZqCbrdASF1Nqv0eimJBWxZ
         u0TA==
X-Gm-Message-State: AAQBX9fvVlGaX2kwEp2Gpa4+F9vVNFD3a4++uEAwzANq3m5yIGgPn5Ud
        o6LQ9GroVVCPNeAACGrgFiKyH0GR6s/KL53fO/M=
X-Google-Smtp-Source: AKy350ag+kyBqmzLO90L50j5ns7SVe4q/2efsusk0PADyjaMpFOY3TbikCHSfyucmDOHnQicca5+sg==
X-Received: by 2002:a9d:7f0e:0:b0:6a4:2a63:ed64 with SMTP id j14-20020a9d7f0e000000b006a42a63ed64mr2730851otq.0.1681490485395;
        Fri, 14 Apr 2023 09:41:25 -0700 (PDT)
Received: from jdenose34.roam.corp.google.com (99-137-158-190.lightspeed.cicril.sbcglobal.net. [99.137.158.190])
        by smtp.gmail.com with ESMTPSA id u8-20020a056830118800b006a2fd720f82sm1870354otq.7.2023.04.14.09.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:41:24 -0700 (PDT)
From:   Jonathan Denose <jdenose@chromium.org>
X-Google-Original-From: Jonathan Denose <jdenose@google.com>
To:     lyude@redhat.com
Cc:     aduggan@synaptics.com, amandhoot12@gmail.com,
        dmitry.torokhov@gmail.com, jdenose@chromium.org,
        jdenose@google.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, markpearson@lenovo.com,
        wsa+renesas@sang-engineering.com
Subject: [PATCH v2] Input: synaptics - disable intertouch for Lenovo L440
Date:   Fri, 14 Apr 2023 11:41:15 -0500
Message-ID: <20230414092353.v2.1.Ieb687047a5b75c7b7ee5dd258207ef5ca9a3b728@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <063c8f77c216ffac463532023009124542d54c19.camel@redhat.com>
References: <063c8f77c216ffac463532023009124542d54c19.camel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When intertouch is enabled for the L440 a (deep)sleep/resume
cycle causes the touchpad driver to hang which causes the
touchpad to become unresponsive. Disable intertouch resolves
this issue and the touchpad is fine after resume from sleep.

Additionally, when the PNP id for the L440 is only removed
from the topbuttonpad_pnp_ids list, a message is logged to
enable psmouse.synaptics_intertouch, which would cause the
sleep/resume issue again. By removing the PNP id from
topbutton_pnp_ids and then adding it to the
forcepad_pnp_ids array, intertouch is disabled and the
message is not logged.

Signed-off-by: Jonathan Denose <jdenose@google.com>
---

Changes in v2:
- remove debug statement

 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index fa021af8506e4..b7218b7652c20 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -150,7 +150,6 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN2001", /* Edge E431 */
 	"LEN2002", /* Edge E531 */
 	"LEN2003",
-	"LEN2004", /* L440 */
 	"LEN2005",
 	"LEN2006", /* Edge E440/E540 */
 	"LEN2007",
@@ -198,6 +197,7 @@ static const char * const smbus_pnp_ids[] = {
 static const char * const forcepad_pnp_ids[] = {
 	"SYN300D",
 	"SYN3014",
+	"LEN2004", /* L440 */
 	NULL
 };
 
-- 
2.39.2

