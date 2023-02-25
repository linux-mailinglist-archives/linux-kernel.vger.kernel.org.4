Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744CF6A279A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 07:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBYGly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 01:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYGlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 01:41:53 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054F628CF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 22:41:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53865bdc1b1so29580697b3.16
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 22:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OrQSP8TAn8N+zYQK8fGqHLRC5rsrL7DpO0WJomJKQV8=;
        b=sICGMTCOH2lNa54l5A62ZPY+JQ6qjceag6FBJ5Yl9YrHlc8563mk1XHCL+OLpvRdRF
         FwoutWmKj/QBhHrP+CMV4P2GUk0AfzXQKMrqDfGnrPZB8zODZB5OHrW+AAO7zvy6jZYN
         IY8D3KBlujCpc9yrRNq3SArLBXXFgpcYO/U7PosPxqu3XMYhmUKjGLCcWQxUnkYi5gaJ
         IEky3qNyzF0cuC7aWsqdc8ovelOCyH0Ajw3z565ofKvfA9EZm6zQqUzvT8rJ8u0/VwN7
         0sp+AK6F/fhYOaKmCKkCcoMET2xL8VvAvB2ltWK1RRj3fXNvDzfeJ7DECCE8G16x+dWJ
         /wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrQSP8TAn8N+zYQK8fGqHLRC5rsrL7DpO0WJomJKQV8=;
        b=Wz01U/MKQncso8NPIf2+Vhk+SRPwpz0AVLdPuw1KF19w13Ay2y6RNIn9Pv8nRsONQn
         jg12NjFWHsxsdOcfnUvU1+DKuMNTK1SABPj5SdcZuzurC39gb6DlEGgQslm9r3De7JgI
         7tXjIkgx9wvv6hDsqwf5HT9QC2d6mO3gTYmRll8bhIoB1hdUjiJburJK37gZM+G359Jt
         iA05MR2DDTFQpq2mBQC/bdwgzenHLTmlKQCOfjQcIwUfNUEcM96MhaepmnwszwCKtP3p
         c3CXwlze18PCqXEZx+jn0RYpR1nyLOPibs+MmOL0kZ4f5kkS/BE4vIkqHi/03CxWpOjc
         92gg==
X-Gm-Message-State: AO0yUKXwnvj+ig0aEsnTH4aJVWxNoc5rgKXkp1w9byezSkLZ96C3iSP3
        nSXp64Bj6iQDXYq4Jgu4S1iJ+I0zLCwyNO0=
X-Google-Smtp-Source: AK7set83+emUmGYMsuXLMtnzV0gp5ViuLB18ckxCcUUoiUUlF2WdayF4F0npFHUhNE7Mj6rAwVq4uVy8Y2k2MI8=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:36e2:326c:12f0:fecd])
 (user=saravanak job=sendgmr) by 2002:a5b:c85:0:b0:a64:658a:5710 with SMTP id
 i5-20020a5b0c85000000b00a64658a5710mr512228ybq.9.1677307311760; Fri, 24 Feb
 2023 22:41:51 -0800 (PST)
Date:   Fri, 24 Feb 2023 22:41:47 -0800
Message-Id: <20230225064148.274376-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1] driver core: fw_devlink: Avoid spurious error message
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_devlink can sometimes try to create a device link with the consumer
and supplier as the same device. These attempts will fail (correctly),
but are harmless. So, avoid printing an error for these cases. Also, add
more detail to the error message.

Fixes: 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robust")
Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f9297c68214a..4f02a10f802f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2088,9 +2088,9 @@ static int fw_devlink_create_devlink(struct device *con,
 			goto out;
 		}
 
-		if (!device_link_add(con, sup_dev, flags)) {
-			dev_err(con, "Failed to create device link with %s\n",
-				dev_name(sup_dev));
+		if (con != sup_dev && !device_link_add(con, sup_dev, flags)) {
+			dev_err(con, "Failed to create device link (0x%x) with %s\n",
+				flags, dev_name(sup_dev));
 			ret = -EINVAL;
 		}
 
-- 
2.39.2.637.g21b0678d19-goog

