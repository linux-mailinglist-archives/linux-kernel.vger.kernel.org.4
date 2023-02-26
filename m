Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0F6A2E95
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 07:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBZGTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 01:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBZGTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 01:19:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DE2E070;
        Sat, 25 Feb 2023 22:19:18 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so3220259pjz.1;
        Sat, 25 Feb 2023 22:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qlQpzpDWouCZvN38z8Ys3T/2tl83Rx2ipztrVab6fBs=;
        b=FuaVkXdy9RUTFUEK2s9yI/PyyjomPXYeixX/+r8NE+dLLPKHAoTBvQpeO04YLasB9F
         Moe70sy33/4LSYbEV7AM7ldFxXC4x4b1bqrqoSFQGViDw9k0dBgb/fSriMYQ4S0rh5tM
         mf0HlSbF8aZG1lXVbKtSCrnl9SXLx+qv2Y6Hpz+uNakDBDbUfm58KQW8I/OjdRBRttQ3
         +ODYZdM/lnJ4GuXhj9MoHFZiYgRy4sAlZ6DriKHnJ9ZBa26t2GQ/dkioCnz5280IGzH9
         xrvd9e1UbBbCNJDzMCMSFfLtGJb/ovyC+/IB3e4CGTOJV9houv7p22p1u9rhVAqGRUPx
         1H9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlQpzpDWouCZvN38z8Ys3T/2tl83Rx2ipztrVab6fBs=;
        b=6y+XRG62h23JjKDzI24wpWWwgu6VZGAjrWl2Ua6YFDGAGEYklWFPjQi5NqEfmZE7ks
         d8Bbui3ABJyAXWmf/mzt9a6QQU34u35WGxbPx11DdnKtKPTTAcdxjYUvjQIqfG1pnNQC
         ImUpNu2iJgflhOiWQlIRFlaIf5BB63e+QLR4l8qjqdrQmufzFL/eHDaRgxbjWEsx0SA8
         AhV1Gp0QsxadL0rC25xtbWFeVYhValDY9RWF+RytBUxqONmn9chtEXDOfThSdw4p8dA1
         oFF26PpDdqet+QQncXXseTDPP34PWfJX5hgGI17A/b3E8BM9VYCFTdbywrB9cxXpR2Ha
         6BsA==
X-Gm-Message-State: AO0yUKUIWXewi9N3nQaqrysMBnTJ8JsuNKSe3XDL7bGt7DMViWSvyyLJ
        Ol2WlPnZsMQSiZW0ISsimFQ=
X-Google-Smtp-Source: AK7set/EKqP6FWnLNrpTf5XcwQn7K4cjEVb4WoZr3mrH1wYGqISH5Z6nJ5JjU4pWtfsn3dhfNFR2IA==
X-Received: by 2002:a05:6a20:698c:b0:cc:4118:6605 with SMTP id t12-20020a056a20698c00b000cc41186605mr13747639pzk.6.1677392358329;
        Sat, 25 Feb 2023 22:19:18 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id c15-20020aa78e0f000000b005e5b11335b3sm1990068pfr.57.2023.02.25.22.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 22:19:17 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     lenb@kernel.org
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH] ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects
Date:   Sun, 26 Feb 2023 14:19:12 +0800
Message-Id: <20230226061912.2590679-1-void0red@gmail.com>
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

ACPI_ALLOCATE_ZEROED may fails, object_info might be null and will
cause null pointer dereference later.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/acpi/acpica/dbnames.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 3615e1a6e..b91155ea9 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -652,6 +652,9 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
 		object_info =
 		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
 
+		if (!object_info)
+			return (AE_NO_MEMORY);
+
 		/* Walk the namespace from the root */
 
 		(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-- 
2.34.1

