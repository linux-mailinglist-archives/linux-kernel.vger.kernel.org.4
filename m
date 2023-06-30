Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38774414C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjF3RdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjF3RdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:33:13 -0400
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877211FE7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:33:11 -0700 (PDT)
Received: from 104.47.11.170_.trendmicro.com (unknown [172.21.19.48])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id EAF6C10A25576
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 17:12:30 +0000 (UTC)
Received: from 104.47.11.170_.trendmicro.com (unknown [172.21.178.36])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 07BB810000D10;
        Fri, 30 Jun 2023 17:12:29 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1688145148.576000
X-TM-MAIL-UUID: 86f23f87-e04d-4cef-a032-bf5c1ece3099
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.170])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 8CD0D10000E20;
        Fri, 30 Jun 2023 17:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5PDywLNPEoByCJScO2ZE12/BW2HdxlMPe3UdVNys8IHumrRMmCofYh9wWvdcr6G5dqjvEEgCxIRZe7vTanbn7jieSxYRmah0fC1EjglRHeitOYiTDPlFpQ1In/qk0wTMc/UibbLJ+wtB5cOmf6DdomAkvk4XcWHuOy0UEg1QDd1lTxd31EZ6pqqmP/ycUuB6zqO6DrQNZeoup5vgc0/HbeB+Ddki5/DpbDAADFcO+6WaDK8TokxO2elf/H8XJsryT+3Zbq9QwFJjgKBFJDENFEQ0ykpsLMUMGFIca7fjG8HUkvEAxwD4caHulC1k2aHkzGVVah0MIhiRnrGzAYJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXN+mcxHCBD/Bc+55O++gwMaslKK7ehhRDriFCoeY88=;
 b=fZr06qRyjL0y8Vohph4xOAthjoz1OiUVTnQT8DSzvkkwZ7o7pUrdepRkfv3mtcTTxx+/clKGE7FRzWJoq7gkeQ5BoRLdzTKil/s9D8oCRA7yR1VyjccnkEomqKvXSyjvs5GnFH/DhoD27DAxFBD7oHZl/8UfpBO2+ilWiJKVIThvM4LiBXvLMr1kyZMpQVbmkY8VPUix4Qv/QWVM55mPGq/rVKg4eMaqF7CBSLmHYceZtHo5oG4OGzxvh7GgIlSMwaRo6i8YegT1n8NbOfdWR37mGEGiEuuO/dPR6uBlj9pjpWGs3pSnhw/T6vuAdCp7l2kaGnZ7R0W7KeCeVAXz+w==
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
Subject: [RFC PATCH 1/7] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date:   Fri, 30 Jun 2023 19:10:44 +0200
Message-Id: <20230630171052.985577-2-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630171052.985577-1-peter.hilber@opensynergy.com>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT036:EE_|FRYP281MB2106:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a56cb0b6-6348-47c2-3cf9-08db798d2e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ub4xbx8gL3Xf4qnFyZgrn9+pByovhq+rsSihZQ/5deL1bqyvrg8E1LVopGtunXCPujPA320KrUEPYpxZYQBNd0s4oDoEymutiPAHo1UdTbRZgBcAjXR/O0T02VgPV9+hYT72vZriKhjVHW1WRevUxP9FPui7gRXDEVpvrBUVh9PssPgcWeBrp/RvxtbtgLzLg5abDRdBaieumEVnVGqkJ3uvrsIG814puc10S/om0HlKBpwaU7MLopEnes5tE1zrkjW5jcDTusUPkSnHBSBVZBuMEdkRXzHUSR1/Q/KQqtGsWeq3H6YQv9KxZsJWTF7iLUWELR4tRks7XEVNU4yXFs0LWyXgTdMq754G12H5/8W+l0Kz37g7he5I5ayuDvDgN07Z2OdxXw0ph1u9Z8EYS043b3cDcXENQCDnHfC+4cA2j1dAZeF//CcgSONkjHkl4qyjedw/sur2sUBJxDINqTYbYS6pbjuVAlaEf5nTRGibqREol3G1kLd3gKR9amm1tnoqLApIJLHt/5KsWWs27rH3JYLUh+DgnbaAiB2GDPIDEu6tddpXTAZfQWODR8mvDNC/3tK4gIR0Rm8rLx9+UJZjvXiSpIhboq51vrwoh3s76fPwaMziCFUKO4vh6YcNBzqkSScAZh2/7MMuXjoXFR1RNGNerm+fJyGSTnmX2KWbc6nbS+5A1dsDinNTrzwjATRh/5QUUWB4Zur2e4qe2Ibsu803bo+WIA/7pIpVBdpchvhcR8zuwG7/HeRTtHrAZW4z2vCvu56tUmdaXcgKkw==
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(376002)(396003)(39840400004)(136003)(346002)(451199021)(46966006)(36840700001)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(26005)(44832011)(1076003)(478600001)(6916009)(4326008)(70206006)(70586007)(41300700001)(316002)(42186006)(186003)(2616005)(2906002)(4744005)(47076005)(83380400001)(336012)(36860700001)(40480700001)(36756003)(81166007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:12:27.4554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a56cb0b6-6348-47c2-3cf9-08db798d2e35
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT036.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2106
X-TM-AS-ERS: 104.47.11.170-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27724.001
X-TMASE-Result: 10--2.538700-4.000000
X-TMASE-MatchedRID: SVm/7o6CSMO6TyUO/xKZhTakEkBtr136rutCeVh17xk7dRmDCUrvToyD
        IPOAt5xjKy3tE1HfkQHDxsdOfchH340cVCEiK1Pf0pUa1RtpyoMqq8hD1DGRIOU0ANNKseCVi8+
        IGr+Jb3Uyk/Hw4XN9jTDfSGFUeim/x10k8QqyoAwRLjqoJJt/9Ye8/oJiio9KA3+iPIxcfrY69F
        U9T760azOhN3RGo1v1NMyO/nomWfCAp+J3UCS7tJfmvpdxWEjowcHhVE1atjtxZskk+1rr0wD2c
        Tn+TrXw
X-TMASE-XGENCLOUD: 04980225-2de2-4c51-a9ba-2ac3d94fe891-0-0-200-0
X-TM-Deliver-Signature: 8A49E00382A2AA2D967A2786A772B5E2
X-TM-Addin-Auth: R5IOi/pDqqAVg65gh0FlFR2xaV1lHVp8faf0lFZ1rN5Zer5q7PeLxG8r1pu
        0sMKwNZ/xEGe5kuSsll6h4+tUMi1c1H1RnKvLMjGZ0w8v3y/tkx9svkJASeEmkQKBnd4zo8dIEs
        DzJPGq3QgEjNlOjFaqtWMtui2/LOB0EpMAVPsQ+KtRVYgISrVLnx/EMVJuq6FkbEg7NuVgUbvi8
        ALBRk3L5TtuW1T6S8OXaIdoLWTbDo4fSfKwIycDJnxrlLylycFbnqlGbsE9kRZXUm5TE+FIIt7R
        CHRNq4KhHmj0CRQ=.gAHxG/GY+BbIZvt/xoHYcRtWP2oBWhH/QBlvxnoo13JFOmMR1/bnB8madT
        +/NN82fHG/rAGfOGUi0BFqSUxCC6iY6uR8QpRAVWORhwt0JWVKvBpGW6O4P+gMrxIM2Y1lulCDx
        maGZlp3TY7sZ8zylMzWrpSx/p/k4rnanudhPW5pOwL6xfqbnfHaKc6C4Zk7H938zUgCi/zeFdYm
        RfAUIBfBu/C1kwHx8NDqed4bo/ScVfvm+g9jYEiN4TyZVntSnJGGGCjViV0MHgJk6K5+qEoB6yF
        sJEVCbXgexFGLPGGWbG91oNvRviFQF9beGBl1iSgj1NgEMRBubC0WpI6Cog==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1688145148;
        bh=KJ7jdUAF6nQwrGeh3TA5XMiM4xrWxyEC0N2xmTiFGAg=; l=991;
        h=From:To:Date;
        b=t3mhNt+7SLp07gRdKR5fSDttFdItnUSqNJxsBl1dY3kmyVSMnllDRvtu5mCWRktUe
         8Fbh7XgsvH0JyXKB0sKSs7O6AEiYJBA0pzKyN+8Bvs6pRglvjerRRPL9j6aJvmAnae
         F2B64CK2d+65P/GxAJOjjLLLF6nf7Vk1w2g6x8P3wErQwJEcPKK2d+rBQprSNNWFxi
         CPOauH/E810SF0szXxv6YZIdCKdQvUxnSSWJX5bp5tRgw2aSWIiq5D5oQDFBXWeT6V
         Abk2fUBaxRkSKjXMfY7QOTqcbDdsHaZzdZf+Ig24bP/3skjUziZhd4qR8pa3ECTMJn
         hDpGnkkniAhvw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cycle_between() decides whether get_device_system_crosststamp() will
interpolate for older counter readings.

cycle_between() yields wrong results for a counter wrap-around where after
< before < test, and for the case after < test < before.

Fix the comparison logic.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d02809dbb..8f35455b6250 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1186,7 +1186,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
 {
 	if (test > before && test < after)
 		return true;
-	if (test < before && before > after)
+	if (before > after && (test > before || test < after))
 		return true;
 	return false;
 }
-- 
2.39.2

