Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04597744133
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjF3R1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjF3R1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:27:22 -0400
X-Greylist: delayed 889 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Jun 2023 10:27:19 PDT
Received: from refb02.tmes.trendmicro.eu (unknown [18.185.115.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98791FE8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:27:19 -0700 (PDT)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.19.113])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id F11AF108FE5B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 17:12:31 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.166.90])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 769AF100017A6;
        Fri, 30 Jun 2023 17:12:30 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1688145150.028000
X-TM-MAIL-UUID: 1a4b49c5-5fbb-4004-86fb-cca94cc54f20
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 0720510045509;
        Fri, 30 Jun 2023 17:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqMlCXf/SSLS2cqfEvSIx+ucPsNwE8XQeRxwq8WeQ4OXLBHowuz6GN97YfWrOLGvw7fSSX0TFIc8pCilHqejonoQjf9YwizwE9IDNDehGE6PKruptbYYiT5EyJJdgE/79JygxqGZp1aG+l1T9LVDd1Opxc+KNM7UcoARRz4QAyB3ojTvx/A0DX7lpQkd/710PGqfFKhG6R4xovN6kNtvAQc4NmUl4ayDPB1XgDyYuht7GMqXJ+asN9Q4Vxf+S4LhNrCiXfrYq1OSVPKN3/nBP4uSfqvTQ3fkNRgbo+kKjMvdhKp4rVah8BGM4/Bqi0jpF8uszhn3C4V4DhQuS2iR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/AApkBYgQrRMxPDdlg61GqM6e0QpZo2H/Km3r71LWo=;
 b=B+QBQxiMcmgbj9G2f4PAUbiQK/lFD0Aaly4Fz2FWexmpvB1bIdocvGFzqLHT6ggeG9pOZac1T3CqmBsv4U/SUp/KegbU+1K2AMaut+3U5gyFUhTdqRg1s5qAmAXaFufv0GWDKiwJZkLOjTmqlLJoUToi94ALoWRG8KfOkqzWaNx+m+mfe9kbWYQP49Ym8OPmVuhmNn7us6BRBMxOOJoaE54s+xTe0UgMb+werSZ8oD1I5MS7QFuKFUNVX+eXCwYveVyygCFK0EJP71LBRP2mAJLIrt8X8PsRRZXl15qOtfz9JZXs4u6clv2SW/So4WOVFwTOEiDzXv/3VgXxwqDXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=google.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
Subject: [RFC PATCH 3/7] timekeeping: Fix cross-timestamp interpolation for non-x86
Date:   Fri, 30 Jun 2023 19:10:46 +0200
Message-Id: <20230630171052.985577-4-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630171052.985577-1-peter.hilber@opensynergy.com>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT062:EE_|BEZP281MB3382:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 20f1c5f6-e9fc-4955-00ba-08db798d2eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCTJzpusdmd5HQLxa0xJBAcRauvsUeO7bAftUC89GRnNXXqpzBW2a5FqFoBTY7zv4qXPBWG21UbBgVD78V2mXQSP2f8yIKnNmoGcaH19WrLdlCx+INUlClvQGGOIb55V0aehG/D92QjfBizunK+i2S3xw2hdXMtZh6/8pvTIoktC6pbcjxUkjHry5DLhxrW2gq1OCJXzrDSu3eFOjlwZK0M3Uq2mmAYjlRwmWaEN7ZBKaurf3JylcMYVvaCyyNBa3AIUURrVPM/VoDimYyCSs0ft672uxSaTng1HBU6d/aO0cX03vgML8AGcJGIjT6seFc2Vo/3W3a64ee0+W0Vvwd6Bh8KDMPI6Kc6CWB4PZmacC8CrF6XyPEvVrnvbGqMQRKjfHlYGmCk6l3GkTcBi2PXTu4p040oo9xa4fMGciFG1MS2kWade74thZfCAIh6heuRC15sUpkk5k9yZMG/y1q2h+lPRkxIhVBV7MI7zzjqD/BmTvki7BDDxHoAz2MPvoS4yBQfS2qoEMu0Q+WY5cAbvdNofLZbwWY/IlXGnu/Qew3MvhZjDC/pJqLTOZy5lK/WwVnbnBCCS1g49zO4cAsZLEX4MsJbTc5CMyS9HOScDQXBg15NawWDnf/A4nk9lwKgQkVU7NXw2PKpZc33CFs+1TE+rwHIDfXBWEQmAUVGsXXlslQQrKddr7itwAABk2M4V1mzdFNc4K+UfFBhTBlB/fS3SakijPw5354sWZk49fOrdMhNV1BtOFq0mLgk2RMHlgXw2KeFx2L/sd8XDdPKZQzhbErEa5imj2bMAiCs=
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(346002)(39840400004)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(336012)(47076005)(83380400001)(2616005)(2906002)(81166007)(36860700001)(40480700001)(36756003)(8936002)(8676002)(82310400005)(5660300002)(86362001)(54906003)(41300700001)(70586007)(6916009)(4326008)(70206006)(42186006)(316002)(478600001)(186003)(44832011)(1076003)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:12:28.3305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f1c5f6-e9fc-4955-00ba-08db798d2eb6
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT062.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3382
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27724.001
X-TMASE-Result: 10--4.514000-4.000000
X-TMASE-MatchedRID: vFGChw3WFt9eKR/wKUhyN50UyaWO1QCnDNB/jaV2d3ufOd3yw6VkrA9M
        5f/N3N4Qthzaop7IM7sxRT5xs1+q/JuBYEgl4gCvJw66cQh/R5eB37bQADgKr2kRdpOqv8vywmu
        Rf7t8+crfNpMtD+fWwOUTedInjF4ziRz4gknBIqDk+QJ4zu017ddP7KM+8gexMHiMmW0ZUNss3n
        AY9fdM9dh5c4TN8zbZ7PVkFWMnCn8N5Rk4kJccyL/a0nd+hIFCI/NGWt0UYPCPILr6ZIjnGDaWr
        KX2wgM5ft7/Qwb81tOa8WPi91Yg/EO0p1hE1Fv7
X-TMASE-XGENCLOUD: aef0d7f4-5fc6-4e25-92b3-7d1ca97f1c13-0-0-200-0
X-TM-Deliver-Signature: 5F4C735E15E25C3882DF00FA4548FB32
X-TM-Addin-Auth: h8TSFSCO5W/H03ZEsIu2bxA8yuwiRmvm5BZ6Rbk84YfiEgmlUfHYX1Fzqtr
        8Ud1u47b/kkLfJIlS7qqmBHAosFSj852SyGsWfhdfERjxnFTKEt0PdDk1yuBl888/OXrUJAhNL4
        3JgzfywTMDpIPBL+gGaR7cSZzCDhRLLQ8QcXOcCFBzjrIkwvylGNz+46G/v9dAvSeA1DwReavkL
        Rho/mnEDNds0J1/IYjU2EGtDMHAObuc5LD9tOXSH5VVEYBUFrcrbSuxFh8HZe8lrUwDCQrUKQvD
        JyaW0U3Xl1G4DHw=.o1VdnndHBG0e1esY3dUZhkRihEzRRitHAwHFWvm1wWcK5jzDPV+7P4PmsB
        n5rFg34jtye6yZB2lT4mHBGtsiwCdlDRQg3gLcrppVeM11MrSXkCHzZid0A7lpqb2tUYj5+aic+
        Y48T7uj1F0HScNXdzZfTxwqJvB0Q1BIfwaCLnoRKr1RYB2SccGM2z+QZGIIqqAZgD6uynT4p4yw
        ZbBPKLnu/sFAMXwZDsQf89oROl54qgwaAjLHc9plurj34HgxwWUHKkwVTE2jg+7p7nsps5xrwuM
        JlbSBMgRr111Usm5jlVupkxwnVh8YCxtFEbH3ec7f/QhEeKe/y8WCYe8W5g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1688145150;
        bh=nYjxLeGfkRg/ocG7JLN7YAACduDGu5P9dwsmki6C2Es=; l=2048;
        h=From:To:Date;
        b=Cc3w3HSrCEO657zi+DaF5wwCgJ6t0ucP5aQC01DluiTLnfIHDMDJzEHdeNxxTY/6e
         qtSjghjtHvwp4D+5SLdTGAvDPnn1oZAk8MZvsyT+Nk/uyGoEoO0Jkp6o0NWVQUbLeI
         +uUTqWrs+n5CWCvdJnuCaIeLLbVfQ8zQAq2fD/kxEOlfq9/crJnBUzQzSEuUYP2ZGG
         HV3W5V5Xb9L83YGGk5ehT9TdXxY7Vw9a3kkCIgB4Jm9ApxvGQ4Q5FxmHUNNZqWBVwZ
         NLRk1Zni+yMGbfAAblEwpG/tBBug9GXVzmJdl7GzLy0Y2BL4Y0A5UffQ168zLBJyhj
         4EbZtnTDhF3bA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, get_device_system_crosststamp() unconditionally passes
system_counterval.cycles to timekeeping_cycles_to_ns(). But when
interpolating system time (do_interp == true), system_counterval.cycles is
before tkr_mono.cycle_last, contrary to the timekeeping_cycles_to_ns()
expectations.

On x86, CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE will mitigate on
interpolating, setting delta to 0. With delta == 0, xtstamp->sys_monoraw
and xtstamp->sys_realtime are then set to the last update time, as
implicitly expected by adjust_historical_crosststamp(). On other
architectures, the resulting nonsense xtstamp->sys_monoraw and
xtstamp->sys_realtime corrupt the xtstamp (ts) adjustment in
adjust_historical_crosststamp().

Fix this by always setting the delta to 0 when interpolating.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 kernel/time/timekeeping.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7e86d5cd784d..7ccc2377c319 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1259,10 +1259,15 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				      tk_core.timekeeper.offs_real);
 		base_raw = tk->tkr_raw.base;
 
-		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono,
-						     system_counterval.cycles);
-		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw,
-						    system_counterval.cycles);
+		if (do_interp) {
+			nsec_real = timekeeping_delta_to_ns(&tk->tkr_mono, 0);
+			nsec_raw = timekeeping_delta_to_ns(&tk->tkr_raw, 0);
+		} else {
+			nsec_real = timekeeping_cycles_to_ns(
+				&tk->tkr_mono, system_counterval.cycles);
+			nsec_raw = timekeeping_cycles_to_ns(
+				&tk->tkr_raw, system_counterval.cycles);
+		}
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
 	xtstamp->sys_realtime = ktime_add_ns(base_real, nsec_real);
-- 
2.39.2

