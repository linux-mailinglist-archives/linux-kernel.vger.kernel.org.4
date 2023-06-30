Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E6274414E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjF3Rdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjF3Rdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:33:33 -0400
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B037BE6C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:33:15 -0700 (PDT)
Received: from 104.47.11.176_.trendmicro.com (unknown [172.21.19.56])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id AE58210A28461
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 17:12:36 +0000 (UTC)
Received: from 104.47.11.176_.trendmicro.com (unknown [172.21.178.36])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 2B48F10000C22;
        Fri, 30 Jun 2023 17:12:35 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1688145154.290000
X-TM-MAIL-UUID: bc47f6dc-f1e2-4258-8266-33b2b274a254
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.176])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 46DBC10000E3B;
        Fri, 30 Jun 2023 17:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKKSIxnG/BwQ2sxs4Uq3vr/ZsR8CCySj2JHMBqImtwPz/WV97jgg0uv7CTiBP38xTutFeesd7AU0sh/M3Nqmjtxh1yoRGDEBRxw1z7W/EB0L3wCEuqD/9Zbu2AWoBjhjhoeGvoAoi+aUorVLRIYUlRjf5Db50Z2SK8Pw/R7VpbQ9zXcWLqQqIgelEXci2x76QJEdyBOYBbbiXAgZ4Us2FwCo9U3krelZcBotuPX99ZmRGuDt/iLChc5chRDVbWKW0mHc6SWKbzBWJbdzxsfugNfRRnRLud4BVaJQ5fkw5qryjzs6YQYoT04yvoXxweB+OJPkUoJjGl29seBNKjJqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9NbgHcVcRIpJ1o8jHBxREqk9X7WWyDwFMlxSLETOxE=;
 b=a1OJRxjsLBEnmpD7u+NMgYybn50YynSOCvS6RySAJEKWwx1ePJ8RNQRlf/3r9GTIn3Z4XyAt8ZPja4kCfgVHMtjjrvQwjzcgVngDt0WvVpea/MmrZNYslPjdhPZrAY0LH875yf9Mg7bWKcPQ/Ue6DDuPUbC8hipBMAQaSYwnTmP+oKqwsCWal8e6HSKS6ZiCIvftIH47+s6j2kheoCIwvX57wckQPqA2VFTBy9p8A0K8DpQ+N/iSs7AzzjCB+bWgeRe3z8TMwBX+z08UY90jFcQKrVjGGyKMm1ucZ2ucScsfpa8RrjqMNG40w5P1oOGosccDAZJw8e60N9MmXmpdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=arm.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 4/7] clocksource: arm_arch_timer: Export counter type, clocksource
Date:   Fri, 30 Jun 2023 19:10:47 +0200
Message-Id: <20230630171052.985577-5-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630171052.985577-1-peter.hilber@opensynergy.com>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT061:EE_|BEZP281MB2005:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 43f0c4dc-6b26-40af-3761-08db798d2f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 217UTAg+BHziMoQ8pM5wo3B1PFMHCsvQVv55bxD3MGYVnrB8sZhtyMydZ0UqcssrEOQK5JyXY4bpRALj61FMH1LOLQiNP9UpMnplB00lJGufsPXUNGfIvpc/orlkPHOGgQSLXl/N32LcODHGgAvAjykq8LMqhIuRJNZKMoztTo2Mp0IlDMk+h1dnpZn9+cnD+wkNgcUXO+jgVCgCieb2bWF9FGsMyeH73iUU1dLnLmdY9zA5eu/ejhbXehNKEJlYN+gElxGEeZUaOhiPf0txSrt8doSBzmvYjfmrH9vPtqaPuIWWvGTEhQnQSOVKApAmiWW61IEgQZd+4jedZpIcAHv7S81XSVXx1GG9z0myubWPM0qCYDDUKQo94iYqxkjqcJppS0hp63499IkSwIOd14/uUjZMmiqPr9H4mbi/a6WDpxJAG6+G98QoRNj01Z907u5IoazJDzN49BI8FAR7Bc/fpAshlVGIsR1DR17bmdusobdGJ8he1NY1gfDO1v99Ggttg+yHgeErGGiHn727blsATBwjvwGAhnLMj8IStHlxoTeR4LRGOc8PPpRATFna6k9bcx1duiPRTw6E03wGaYR2IuEqjlKhSq9Mq/rRapArNenB0ycgeykiWLWV8JK00s2K4iGFOSvMchwjSdjm5FBo2h26KOLUIx6VpLPFChablUFcXLd9UD0993Nxx5hZIp66tR4hjPftsABDIUJn0jGz32HueeAhPXGj2aGCphcLzvXqXDy7L6BLzg0vuqSDoXl3FtZ8QE4TfQd1ZU724g==
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(346002)(396003)(39840400004)(376002)(136003)(451199021)(46966006)(36840700001)(966005)(478600001)(36860700001)(47076005)(186003)(26005)(40480700001)(1076003)(336012)(83380400001)(36756003)(2616005)(82310400005)(86362001)(81166007)(6916009)(4326008)(70586007)(70206006)(316002)(2906002)(5660300002)(44832011)(8936002)(8676002)(41300700001)(42186006)(54906003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:12:28.9126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f0c4dc-6b26-40af-3761-08db798d2f11
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT061.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2005
X-TM-AS-ERS: 104.47.11.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27724.001
X-TMASE-Result: 10--2.385400-4.000000
X-TMASE-MatchedRID: W1Gv3YQwcksfq1C9yqtpY3iXIXWXK9Sta3FVQe5d4zs3j/Mq9utADezy
        hpwh5Kn1QaSYRDMTd7qDdsVaS6GBx8eYpzz6yNBUUlO0zoIcpU6B1fO2o4QGcOEKbxqb5I/nhf7
        60Jrkn7K+1+8zb5yWP0dRX+q/OXWrFFzaf2J+d+zW0zrdUW8Q+Ytm4/7hkNAG0kDOV2EVXlmbSR
        3JK+cvXno17dTpompJBjNUyX1MCsUTfhpDeOWkVYYtgu3ZTSlqcnxszfxH2Ckmx8kl1Wnd+q+eC
        SMeOiOkfZ9uentPYeaJcb4M4L3rfi1QF7giu85XOwBXM346/+xtaDgQylf8ASH4cW+2DMrOI91i
        xqpCYnJ+yCBP6lg3OpZ1wa3cQxeJ
X-TMASE-XGENCLOUD: 09e92e8c-4928-4749-896e-f0ec90671b87-0-0-200-0
X-TM-Deliver-Signature: 454AA7F489DE1321776A11B1FC23D40E
X-TM-Addin-Auth: J2WEeMMnNi36NAC4plcsdivwdRHsoSn/K1YCkMtas4HCMIRhbuNiXqqRqBw
        V/jJPRW/heu3DW9M8mjz66E1+y76MsWgeiZYfCE3AwQxb6VsRlYiO5n9wMN17IEHhrt64Ai426u
        56iALRoI+qNnXz3a1x4s1i8JJMf99tFCI3OSq/cqtaMFGtV4qbOMX0dHvVMpD6z15cohAOh4n0z
        UGRMDiIOg0pZmlrlB+zGExkI5MNSKvVY++vEE/+r9NWf2Sjt+KndlB7MrrgffOcJWUSCerY0lYI
        sLtYJhezoMRkoCw=.PrUJTGDOxGIJ7ANxvKcp0OFgX4bc8nZXWE/5xINoL59tNQq8GAt6FJNwm6
        JbR6c8kL6fIdSA4tuKKNn6O7UQ9tMWJCYtvpdGyvgjTSDPkai7bnRshyiJqVb7lOWmh7sAjXUON
        wIl+z5Qr8TAkYwfppEIejzwbF3kyd6Yztb0TF9QQP6vYmC3150K9xyVglvGJHwEZG9w3miLGI/T
        eDdWiUEJGYl6LheACjmPv1kty5rmYaFoFBwXi4qWFC1ncDe1jK7KdpDK1h/cU4j5QN8PjRfSvaO
        GsjtovCBRVDFIEBekW9ClYk+1Ut2/RhrS9oeUeDRwhUHiqDKRJiFDQ9u+Cg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1688145154;
        bh=7GJ/6QyfKmdk9vfZ7fTYL619asKPR22BGPfJCTCrlBA=; l=4094;
        h=From:To:Date;
        b=OgmWdB2fJ0aEfknPUyIUMIh7XG95cOVap9nxE/ldScaW3KfVEewlqeRQJt47gwZzq
         NjpGouwZYxwbxYkKc+p9YABfzu828ElP1MWH8tCdpgsOP7W3OmBqJCjR1KiYhqlMMP
         nkbVd7b+L56kQalvO9M5cx4DQcUSCiX2pe0AilN7Ci+O6Iadqn6hiRP7H2A+3fPtRc
         lnoUbjgnJV9k3iNxUz9AScVcUhPJJ2F/5YAS3slXZx+7SyM2+OVt5A6bkh1QCFw+wq
         9gQVzFpCIOuLr/uqFV5KT2JiAENEY6TY7NcwXDLcojY2nUCA+41WoErLF8gszJ48OT
         22/3Qy/o3MLgA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export helper functions to allow other code to

- determine the counter type in use (virtual or physical, CP15 or memory),

- get a pointer to the arm_arch_timer clocksource, which can be compared
  with the current clocksource.

The virtio_rtc driver will require the clocksource pointer when using
get_device_system_crosststamp(), and should communicate the actual Arm
counter type to the Virtio RTC device (cf. spec draft [1]).

[1] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00592.html

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/clocksource/arm_arch_timer.c | 16 ++++++++++++++++
 include/clocksource/arm_arch_timer.h | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e733a2a1927a..cebdc1b2db4c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -92,6 +92,7 @@ static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
 #else
 static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
 #endif /* CONFIG_GENERIC_GETTIMEOFDAY */
+static enum arch_timer_counter_type arch_counter_type __ro_after_init = ARCH_COUNTER_CP15_VIRT;
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
@@ -1109,6 +1110,7 @@ static void __init arch_counter_register(unsigned type)
 				rd = arch_counter_get_cntvct;
 				scr = arch_counter_get_cntvct;
 			}
+			arch_counter_type = ARCH_COUNTER_CP15_VIRT;
 		} else {
 			if (arch_timer_counter_has_wa()) {
 				rd = arch_counter_get_cntpct_stable;
@@ -1117,6 +1119,7 @@ static void __init arch_counter_register(unsigned type)
 				rd = arch_counter_get_cntpct;
 				scr = arch_counter_get_cntpct;
 			}
+			arch_counter_type = ARCH_COUNTER_CP15_PHYS;
 		}
 
 		arch_timer_read_counter = rd;
@@ -1124,6 +1127,7 @@ static void __init arch_counter_register(unsigned type)
 	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 		scr = arch_counter_get_cntvct_mem;
+		arch_counter_type = ARCH_COUNTER_MEM_VIRT;
 	}
 
 	width = arch_counter_get_width();
@@ -1777,6 +1781,18 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
 #endif
 
+enum arch_timer_counter_type arch_timer_counter_get_type(void)
+{
+	return arch_counter_type;
+}
+EXPORT_SYMBOL_GPL(arch_timer_counter_get_type);
+
+struct clocksource *arch_timer_get_cs(void)
+{
+	return &clocksource_counter;
+}
+EXPORT_SYMBOL_GPL(arch_timer_get_cs);
+
 int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts,
 				 struct clocksource **cs)
 {
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index cbbc9a6dc571..b442db0b5ca0 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -43,6 +43,13 @@ enum arch_timer_spi_nr {
 	ARCH_TIMER_MAX_TIMER_SPI
 };
 
+enum arch_timer_counter_type {
+	ARCH_COUNTER_CP15_VIRT,
+	ARCH_COUNTER_CP15_PHYS,
+	ARCH_COUNTER_MEM_VIRT,
+	ARCH_COUNTER_MEM_PHYS,
+};
+
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
@@ -89,6 +96,8 @@ extern u32 arch_timer_get_rate(void);
 extern u64 (*arch_timer_read_counter)(void);
 extern struct arch_timer_kvm_info *arch_timer_get_kvm_info(void);
 extern bool arch_timer_evtstrm_available(void);
+extern enum arch_timer_counter_type arch_timer_counter_get_type(void);
+extern struct clocksource *arch_timer_get_cs(void);
 
 #else
 
@@ -107,6 +116,16 @@ static inline bool arch_timer_evtstrm_available(void)
 	return false;
 }
 
+static inline enum arch_timer_counter_type arch_timer_counter_get_type(void)
+{
+	return ARCH_COUNTER_CP15_VIRT;
+}
+
+static inline struct clocksource *arch_timer_get_cs(void)
+{
+	return NULL;
+}
+
 #endif
 
 #endif
-- 
2.39.2

