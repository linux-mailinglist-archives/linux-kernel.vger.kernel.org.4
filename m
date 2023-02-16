Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B827699C44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjBPSXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjBPSXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:23:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3C50AF2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:22:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z14-20020a17090abd8e00b00233bb9d6bdcso2959047pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6uh9i4Yg2UK+dtGNl63Dd2v2b9w/htIfSHYIG3sIgo=;
        b=mVXuI8tX22NJDu6yVW/g1R+u+kgg7UXHeVhfNyF0TbYKOj0ZLb3xWMXyv+ME0Gy0rG
         tVCkdPYlWPmzvGBICTXFxxMRlSS8pK/B2pxXGD9Sc36/petkDWVVq6qQSlCJSPy1sEg4
         6AEhM/RTUff4Vh1y1IE6JfJ8iJDn39isEDMJI5giDQ4EWkEQRw9J6xFOwqvn4VmXNGM+
         Ws+txz0rVy1NiDnjoPhdWs8J1x1YM1/HGFFOzizB5CJuJMkMuD6f2JS8IUgzj1T42PEs
         u7s3Js0bFqORE8smkyQu+P363zbCeyeYdVQRhTHs9bfJBw+/SiFAtZAR2SXhVgOjav4v
         YBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6uh9i4Yg2UK+dtGNl63Dd2v2b9w/htIfSHYIG3sIgo=;
        b=mXQauJfs+0khAU468/g1edfeA8LEg79FMQxt2buIzUOHbX9BhB9RYuAkZh6byadBfi
         73bS7PMwfmYlvYwbfI3RB2HP3CK5MKrZKlLuD8/Qw+2PTnnlonXFOhxL6onMuXeZdhMI
         Yn0W1xBjAsUkpUSjULSBhA4XOhjn5ENzOqiMKbo4MbJlHeLmUNNkeF/qAn+Y0vqBhp+b
         VXTDVGGqrnS/6GczpNKJx/Pu+n6mToGmTu2l+bpCUXUzBjfbdo9EJP3d7pw+ufKfTnPe
         ZjejVrUdsTbpWirYRl5PZ1j4f8PPUwQ8IxxTrTeMEP2ZSXW8VV2QOBu2Y76KUXyEi7CY
         EVfQ==
X-Gm-Message-State: AO0yUKWdbVWDOOzFTFceFT50lOAR6EGgYzYEzFG5Nqo+lyznZUI4j3k5
        6UOTWGEtsW1YDjnrYjErLGWFzQ==
X-Google-Smtp-Source: AK7set8osOOcu+B/NPunBtlVAq9P8M092Oegw2Ys2UWMJiWbFSK/cFchK4srmj2/JHgMb6lllccJdQ==
X-Received: by 2002:a17:902:e88d:b0:199:15bb:8316 with SMTP id w13-20020a170902e88d00b0019915bb8316mr8101008plg.68.1676571748298;
        Thu, 16 Feb 2023 10:22:28 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:22:27 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V2 20/21] MAINTAINERS: Add entry for drivers/acpi/riscv
Date:   Thu, 16 Feb 2023 23:50:42 +0530
Message-Id: <20230216182043.1946553-21-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI defines few RISC-V specific tables which need
parsing code added in drivers/acpi/riscv. Add maintainer
entries for this newly created folder.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39ff1a717625..d47212194457 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -450,6 +450,13 @@ S:	Orphan
 F:	drivers/platform/x86/wmi.c
 F:	include/uapi/linux/wmi.h
 
+ACPI FOR RISC-V (ACPI/riscv)
+M:	Sunil V L <sunilvl@ventanamicro.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	drivers/acpi/riscv
+
 ACRN HYPERVISOR SERVICE MODULE
 M:	Fei Li <fei1.li@intel.com>
 L:	acrn-dev@lists.projectacrn.org (subscribers-only)
-- 
2.34.1

