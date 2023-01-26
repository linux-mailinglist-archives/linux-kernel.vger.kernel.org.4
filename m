Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A308F67D6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjAZUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjAZUpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:45:06 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23306744BB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:45:03 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id j1-20020aa78001000000b0057d28e11cb6so1416482pfi.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwzPZHPsAKvYmgPaOXFHIXWk96k1/mVIbUR6ZLbCeOo=;
        b=sjTOX0tbY7UDj7YQC9tG/vi0URtTLhlec3V0xhmTN6Ohhmb/18ffK+c6FLzN3QyAYz
         GDDO1TNPjs42kQ7KWyo4E+sg7M1a5Nieesq1IHuJ2RwuCl6hJGOjmFYV4S7PqQxHb5oK
         TYcxVTJLQF80vwvBhtWBStbmFPn2rTZx/4hjn3Mt3sVzIc0A0Y9yqEWO7URlkGiaZpN2
         QineabgOkUVT6Bu1LVaMreQvfN+EtyHAyaPyKOxTInstmz8MdJED/A2SO6Z28OXoqufW
         0LOaKnIdPiCYfI4sZ/UEf13x4JqGjhUPWHKmkuUA/LJTSmmg8/ORfZoeBsm6Grt8AeO5
         f3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwzPZHPsAKvYmgPaOXFHIXWk96k1/mVIbUR6ZLbCeOo=;
        b=WJJETCQch46S8B2mqkfe5avQU0HZ6lhxxAgRJZ2pJbFLO3jkrGUIKSBWkckcHucBer
         Hew00ZawGliAPIIK9s76xhuyAImDePiUsJ8ZdwwGfS94PCxlVcBMMreVpblzOztWNAV6
         jhb2BGawSW570vh+RGIBh5tMz7ahrGlklboxLaro1fZEastCITqgG4BH40LulqxH9itx
         eMiFDVs+c5Pnt7qzAC4aW95fru4kJZ7sTlvgHZlbTSGC/6WjigHlh8fXuGUdluI6TXi8
         QKaHcfsG47N8s3qOxVsQdaEdviYOb+4etbntfVQ67IuNwb8dqpLkhmAHGHVdQkwD6yY5
         2n8Q==
X-Gm-Message-State: AO0yUKUXF+EEEHMUxL9PI56opMwBQ1Z7fXdSkaCyvxK+CrVGQ2H4j3s4
        1ZW6EgZ0VmcQjHSCUrRVmMQXj9HRhc/MpD4=
X-Google-Smtp-Source: AK7set+MGxgQBz/1oO7K76qmPJ54mP7Z+dqqknPhNPhQ8N2pNNvbFsTR8SK9GU3iWYgoDuawG0diyZOfrB+NmiY=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a62:2542:0:b0:590:7829:f566 with SMTP id
 l63-20020a622542000000b005907829f566mr694764pfl.50.1674765902603; Thu, 26 Jan
 2023 12:45:02 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:44:42 -0500
In-Reply-To: <20230126204444.2204061-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230126204444.2204061-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126204444.2204061-7-zalbassam@google.com>
Subject: [PATCH 6/8] ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>
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

From: Marc Zyngier <marc.zyngier@arm.com>

ARMv8 is a superset of ARMv7, and all the ARMv8 features are
discoverable with a set of ID registers. It means that we can
use CPU_V7 to guard ARMv8 features at compile time.

This commit simply amends the CPU_V7 configuration symbol comment
to reflect that CPU_V7 also covers ARMv8.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index e949e84a2dec..b77f4a0d9072 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -403,7 +403,7 @@ config CPU_V6K
 	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V6 if MMU
 
-# ARMv7
+# ARMv7 and ARMv8 architectures
 config CPU_V7
 	bool
 	select CPU_32v6K
-- 
2.39.0.246.g2a6d74b583-goog

