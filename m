Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4596A2EA5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 07:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBZGuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 01:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBZGuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 01:50:17 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE7CC1C;
        Sat, 25 Feb 2023 22:50:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso2172808pjs.3;
        Sat, 25 Feb 2023 22:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5iyHjTQQ/j7r+U18i0a6jAPGa0luyUfnQmV6+2zHLXA=;
        b=Vv6QEEsmdty2TIaMn1vVB/vVYcbngXdOa4XgDQRmdqzTu3TiHZPkWkjrVKbE2Y6zEQ
         xt0AQ51K6zgACYhgDOtxO/yBTduAHuAckbW2blbKwR1HcDH+ZYEmvQ9GqpIWyJVtDDYR
         EZ1Jx0rrkgHJkfEOADfuuz4bhDhDIaa8taq10zxkZCZjOU6gyXIbUDnUoH/8OFYoI89o
         nzsJNZB1gBJxy2BvbUiXKZwhTnud7rBc1P+jyF+6yEt7nl7DsEwf+r1JyR93VGR+E8gb
         pwqyCvDVnKEHfYwgqSqKhktxa0d0DBc4WKE/u6KMYNwZ7AF9v1rxlhaF/Yw2xqnFaxXG
         1fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iyHjTQQ/j7r+U18i0a6jAPGa0luyUfnQmV6+2zHLXA=;
        b=Eir0O1Dv6TJkCFJMdmzXIA12lYcJ412SmnA6xmPqKDT2CsSzgtTJe026Er1yZm9Od9
         G/4gZ8Qamr0+xkGiwYzOsTbkUfVjl/uDVkJFqb2V02A2J/bDU68tArvUnecETZjwNGde
         2x9acIri+DFxg9HXIYkkOdIQ7fjo5omC2tn4ISklkn23hc0A9SIp4WhpxQlw3e1nNDKQ
         tfQRvbt7iMzHtoNmHUPAqMNWlgal7yxclNcYRJ+QGjOlnRnHRgUWYytupsXEFBbpHgNY
         x9OLfveaIV/GIz8ojP9nxT5eM+Qhu1R42SZOQ2EVqc5SvwaYujRj/0diLWlbcVODivsl
         V5Dg==
X-Gm-Message-State: AO0yUKWNArK3eXEvo0uPPJZYjMJJrmVDAdLJvAzFF9v+1TkHzklbWGzc
        X5LJ6JZ2ygJaI/GX1fzXqFU=
X-Google-Smtp-Source: AK7set+IxfSoeRgdESTtM5wNKFnTW3/wXMc+FAEPA8tBDuY1ftLC9X/56NjrD6HpB9+InhBmD/922Q==
X-Received: by 2002:a17:903:183:b0:19b:33c0:40ab with SMTP id z3-20020a170903018300b0019b33c040abmr25151961plg.43.1677394216099;
        Sat, 25 Feb 2023 22:50:16 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b0019c2b1c4ad4sm2164925plt.6.2023.02.25.22.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 22:50:15 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Chen <void0red@gmail.com>
Subject: [PATCH] media: v4l2: check null return of kmalloc in format_ref_list_p and format_ref_list_b
Date:   Sun, 26 Feb 2023 14:50:11 +0800
Message-Id: <20230226065011.2688452-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
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

kmalloc may fails, *out_str might be null and will cause
illegal address access later.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/media/v4l2-core/v4l2-h264.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 72bd64f65..c7a088882 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -306,6 +306,9 @@ static const char *format_ref_list_p(const struct v4l2_h264_reflist_builder *bui
 
 	*out_str = kmalloc(tmp_str_size, GFP_KERNEL);
 
+	if (!*out_str)
+		return "NOMEM";
+
 	n += snprintf(*out_str + n, tmp_str_size - n, "|");
 
 	for (i = 0; i < builder->num_valid; i++) {
@@ -344,6 +347,9 @@ static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *bui
 
 	*out_str = kmalloc(tmp_str_size, GFP_KERNEL);
 
+	if (!*out_str)
+		return "NOMEM";
+
 	n += snprintf(*out_str + n, tmp_str_size - n, "|");
 
 	for (i = 0; i < builder->num_valid; i++) {
-- 
2.34.1

