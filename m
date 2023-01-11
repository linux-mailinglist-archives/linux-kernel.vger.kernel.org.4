Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC94665181
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjAKCGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjAKCGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:06:08 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC88FCF6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:06:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z4-20020a17090a170400b00226d331390cso15542380pjd.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBFAbmggijOhKjLzf9il6pua2012DvMDyGgeIBZj5ls=;
        b=m2MFXy1xICKP7wXEyoTOm7zW0ptblveblZ8XnwBpeo2AKBwPeFD5jmjnjHS6MtgLnx
         KyKFP2HmIFuQmtQYccuYE92XM+qfF/VMEIgI4zwELU1woAYUZ7poA9Qb1r92ssWmC6wV
         ur7+Sh2GggjJFj+4LcSt6TetHYyIJ8lb2nBSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBFAbmggijOhKjLzf9il6pua2012DvMDyGgeIBZj5ls=;
        b=5gZLLfufbb6qePy0ym9lL+1KbJQuMOogt5qpzqFErGeybUs374ZWBybUMZeWYSCY8a
         dEg4UqRXrYxfS0D5g+GQmpXg2KWQOksub04O46vKq2VEon8SsM92Z8EB2EezqWCb97KK
         3wlaxriypYwVHaaDfY0ePiDJF+uopnYAusJ7IScZLUdR0JSr4ERRuyfqaxIn6LeEKFEC
         J+p8/XoZqjuUhxikKTapgQji9SY+bhoFLXtC9xCdiQPbDg6ek7Zh9aemCBfLZG8T1wln
         3hvc1eumSuocJFnR2ZXwIpF2rcp4++c6AK6luRBd6jc09wuUQTtvcpwW9mvZdHALxRZD
         F8bg==
X-Gm-Message-State: AFqh2kpWWU5v1eRnIvjLVkn0pxehMdogI5MFXDwVsM1cwBwThtiO/RI5
        oLH/rI17E2Ts/ywDaL1kXvEJZFnbk6H9rG6k
X-Google-Smtp-Source: AMrXdXuCj84I+jhx/wOedwvaeYXtbs0dOplLvj21ewxSfXqBwZfxqQmziQeUa4iUXnqxygc9yO9fOQ==
X-Received: by 2002:a05:6a20:b285:b0:af:ec0f:f6b5 with SMTP id ei5-20020a056a20b28500b000afec0ff6b5mr72803915pzb.11.1673402766884;
        Tue, 10 Jan 2023 18:06:06 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z6-20020a656646000000b00477a442d450sm7336738pgv.16.2023.01.10.18.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 18:06:06 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH 3/3] usb: typec: altmodes/displayport: Use proper macro for pin assignment check
Date:   Wed, 11 Jan 2023 02:05:43 +0000
Message-Id: <20230111020546.3384569-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230111020546.3384569-1-pmalani@chromium.org>
References: <20230111020546.3384569-1-pmalani@chromium.org>
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

While looking at the DP configuration VDO to determine the peripheral
configuration, the spec (Table 8-5: DisplayPort Configurations, VESA
DisplayPort Alt Mode Standard v2.0) lists the options as "UFP_U as a DP
Source/Sink Device".

So, use the correct macro while performing this check. Effectively it's
the same as the existing code, but the proposed macro describes the
state a little better.

No functional changes introduced.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/usb/typec/altmodes/displayport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index c0d65c93cefe..746bfbf3d557 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -426,7 +426,7 @@ static const char * const pin_assignments[] = {
  */
 static u8 get_current_pin_assignments(struct dp_altmode *dp)
 {
-	if (DP_CONF_CURRENTLY(dp->data.conf) == DP_CONF_DFP_D)
+	if (DP_CONF_CURRENTLY(dp->data.conf) == DP_CONF_UFP_U_AS_DFP_D)
 		return DP_CAP_PIN_ASSIGN_DFP_D(dp->alt->vdo);
 	else
 		return DP_CAP_PIN_ASSIGN_UFP_D(dp->alt->vdo);
-- 
2.39.0.314.g84b9a713c41-goog

