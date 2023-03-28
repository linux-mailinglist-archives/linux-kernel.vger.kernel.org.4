Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAC56CBA54
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjC1JSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjC1JSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:18:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A8259C9;
        Tue, 28 Mar 2023 02:17:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn12so46791840edb.4;
        Tue, 28 Mar 2023 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679995065;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K9oP7/yRfVILURsIVCn4qyL/bl9YxnAFWd0gdh12Pk=;
        b=hsEY4XO3s4eORD7G5g5xh6HJHdnI2POCiTX+QoIY5l7mhUpRTBOsLeDW4NLwdUfw81
         543bt0awuC2F+f8h1QY1nTyniGQJPzab8cF3XJ6MtzklMiH9b3M8qLoFuPu1WbVJv0sb
         VWtOYf42OdI3dVfhNg0D0ght0hrc3hOvM1XzZywROJ7mVsbrfhq2niV5DUDEmeA+6fYb
         2kKjvC7pAuPx7knYARdcSQqP+rblV1XjbUMQs/JNtR2ACapY+9StNATejJq+inQp2ND9
         CYOpXS0T9XetX5PgK9HNw+Mxv92n9hIWTsJChpQpzBW9OvhRgEpBVVifEjgMroUV4Bct
         yv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995065;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3K9oP7/yRfVILURsIVCn4qyL/bl9YxnAFWd0gdh12Pk=;
        b=4p7SeN80xvha07D6DPxjYMVUOKzwKfnf0pcTB2tHTd1OKa4V0NX3A1agOMqgq2lX6/
         5hx8y8+PKNguAdf3W6FunClwOwAOAil5bwP/RS2mzCK0vYa80E9AUCM84AJOMPWQowVC
         mFRbAZsZXepUl+EnYGE1sU9J0Fv0PUXFc+JskqlICB2o3Rzv+bNocaX4ihB6U3R510c6
         LPlWcWEGkZxr3Cr9TMA4Jvov1Q2Bqe2iwijeMmI7j8ClF+mm/29mrhxqCXNV5zjJdDNQ
         xBqfpDZgsn0FiHlJVjfTef/VopzBe45Bd17dmN0JBV4t0cCKEx5Tre/4FzyTDExAfbkL
         bCZw==
X-Gm-Message-State: AAQBX9c5BjO8FKzLcsF0h4x6YuRns83GFKWH80imufW1LzX47yTT10wK
        oX31LyFaoap6c0n007Z+cVs=
X-Google-Smtp-Source: AKy350YWHO2hFdKwRwavXXq1uDnljv2JnTt4NK/8WlhJXRPTii2qp5bBsyLeBR2I4+rVcWDwLOnheQ==
X-Received: by 2002:a50:fe94:0:b0:4f9:9e56:84bf with SMTP id d20-20020a50fe94000000b004f99e5684bfmr13882874edt.10.1679995065164;
        Tue, 28 Mar 2023 02:17:45 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:6423:97b3:4a44:24c1])
        by smtp.gmail.com with ESMTPSA id i24-20020a508718000000b004aef147add6sm15749141edb.47.2023.03.28.02.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:17:44 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust entry in THERMAL/POWER_ALLOCATOR after header movement
Date:   Tue, 28 Mar 2023 11:17:37 +0200
Message-Id: <20230328091737.6785-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e97b6e04095a ("thermal/core: Relocate the traces definition in
thermal directory") moves include/trace/events/thermal_power_allocator.h to
drivers/thermal/thermal_trace_ipa.h, but misses to adjust the file entry
for the THERMAL/POWER_ALLOCATOR section.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Adjust this file entry in THERMAL/POWER_ALLOCATOR.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Daniel, please apply this minor clean-up patch on top of the commit above. Thanks.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e61e3240758..3e0dbf8018d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20847,7 +20847,7 @@ L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/thermal/power_allocator.rst
 F:	drivers/thermal/gov_power_allocator.c
-F:	include/trace/events/thermal_power_allocator.h
+F:	drivers/thermal/thermal_trace_ipa.h
 
 THINKPAD ACPI EXTRAS DRIVER
 M:	Henrique de Moraes Holschuh <hmh@hmh.eng.br>
-- 
2.17.1

