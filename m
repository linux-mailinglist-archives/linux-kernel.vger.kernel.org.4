Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE457094A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjESKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjESKUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:20:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8CB1AD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:20:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5208be24dcbso2139545a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684491616; x=1687083616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wba1YArvykmSZksSn+PRwHxHWmhMmfjRVISgjVjCTk4=;
        b=de0+lVs7fkMKCXKZN1Uo3v1hZWz7Q0rLROV5fVLqv8ZK4RiAwZ4ihjvw9OXZc0TjWZ
         /zXm+CgtQcIJ9lctzjY613itfA6hAd10/oaQX+Uim+w8FDQey/YmF6rmFEEb0mYbeO8S
         PDKb2qdfHgSlBS+LD2+OcTziblsjhcIZP44+9ZPqUvPDcxqPnCYsWA5pIA8uFbmn2YGX
         jXnkaJA/Nk0gPNdc80IbR5sKerOv512segljfyJCBc5XqQKOx/Luksx+uEp/cNwcIh+y
         tSTXMOuqaTHfSPxKIBjS98V1MKWJXtinmIwKWXU9LoW3lnE2PLBoYJXCVL0r6G402lzb
         ZolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684491616; x=1687083616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wba1YArvykmSZksSn+PRwHxHWmhMmfjRVISgjVjCTk4=;
        b=VRatWi/cRcnEcp1/98WFZpwIZRfTz98HWhhvIY/qh5JsuRFlZ7iJmDaV6CM65MGhEo
         2CEtpM8kFZtroutzlvrIXBxx2QrD5I66ZjVowrovU7l5Oz+3uUOa44ZqpE4+UeVslmNl
         9k1o46WtNl8JBSRe/rIzgKou7m6vjXTaxVNPqQo5kDpYxA5KlXyjU16/BMf7vpMG6oHP
         HQ1cxLYI4SlIMM2b526+KJBSg+ibwSQf2dT2ReQgvOA1N+IJsN7d6lmhA+QecL57pZuG
         M/fgeJ+DHgMzPyuHkxPv1UsNzsLo07K0DJVJDkaNnbzcqb/6w0NRl1qoF9L0eHBvZDWv
         nqeg==
X-Gm-Message-State: AC+VfDxYL0KegJ/tj/HxyecIwmyb3got6oozLAR2vmYAo3KLqFQjoKFl
        qYFY+OxsxEBtzSppVJUfDlA=
X-Google-Smtp-Source: ACHHUZ4iDDAHgVYfvn93q6kUTIsh196jK6e4uGk1QBRgVFTeo4UoDjg08LB76NZrjlzPoz0t7WrbyQ==
X-Received: by 2002:a17:90a:8c10:b0:250:1905:ae78 with SMTP id a16-20020a17090a8c1000b002501905ae78mr1651705pjo.15.1684491615776;
        Fri, 19 May 2023 03:20:15 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:92bc:26c4:ce02:816b])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090a3b4700b0025374fedab4sm1239643pjf.22.2023.05.19.03.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:20:15 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH v2] Staging: rts5208: rtsx: Moved else statement to same line with else if
Date:   Fri, 19 May 2023 15:49:20 +0530
Message-Id: <20230519101920.27342-2-kartikey406@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519101920.27342-1-kartikey406@gmail.com>
References: <20230519101920.27342-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved else statement to same line with else if,
this warning was given by checkpatch.pl

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
Changes in V2:
            - Moved else to the same line with else if
            - Moved comment on else statement to inside of it
---
 drivers/staging/rts5208/rtsx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 2284a96abcff..47dacef0aaf8 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -399,10 +399,8 @@ static int rtsx_control_thread(void *__dev)
 				chip->srb->device->id,
 				(u8)chip->srb->device->lun);
 			chip->srb->result = DID_BAD_TARGET << 16;
-		}
-
-		/* we've got a command, let's do it! */
-		else {
+		} else {
+			/* we've got a command, let's do it! */
 			scsi_show_command(chip);
 			rtsx_invoke_transport(chip->srb, chip);
 		}
-- 
2.25.1

