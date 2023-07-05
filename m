Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1917485D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjGEOQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjGEOQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:16:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C543410F5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7MzXDNioq3hw+pWBvBJPJZCO22bC0IEvdrGQzbI+Nvl9mMPqaSk2aEwawNYyjF7RU6oCeik1N1cJIKNGiKt/qjBFS6LtunZLeP9ATCagf5kvaTrScuhRf7/1F361ftwoNG4Wk2uIXd0wDw27GOVeuAZLv9d6U1vPaXtIkVGmxc62oQcmt+zZ6WTB+XlnI/mZyFll5KrBiuvUahyqBVcws83HRC0Z1UQ7DZweEiTV3prKhWyfWAyODOKq1uyP+C9AGB6ej0h5oLD//a+gNNWxHhwXldpp4fpPx01u1+tXZLQLvm9HPewdR2s7mPBenXpIXwQuoIFDZZMG/gLrIp2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EyCoHSvXKpheUqf1gQ3XpRPOUbyyyBor67dvMG+iPE=;
 b=iyf4MEBBPc/ZM/Pah3CMlj/yRUANhvvNKUm50gcGwgVum4WTf2hnepqimrZcpDn4sm6283f1hK+PNY6NhstnRFJnnHWabZeB45r0xD+oqgdqDUSsu72rwYhhBaxnBpQIUWq7mrtYlupAhfbMHfi1EldLIIFnmkRNWldbinI4t7yekUxaIBUAO+ufwnbzWqwcMh1y9LnzgIh5Y8tH+nAagCRsuHUQC6ZmkXd9ORQn3V4rr12irElFbCbXHpv7iFLoJDQBQ3c4TfXb2poEAhlsNcXOicHzOxKq2BjhmRjUWRB5MEG9suQzgG/RvnI3jQaNCbLu/QK3XmPfsfTPk7moCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EyCoHSvXKpheUqf1gQ3XpRPOUbyyyBor67dvMG+iPE=;
 b=hKe6moKdjvYLkI4CzLR2MvuuztecdfJkN5DyM7L0QtaqBU34LB0F4EI1L22R39k+fkIUwPssfqWWqmKMNLdO6bU6vgmnb1XXsmO919dItAR1oAsGkHw/sKAKx2awyhXRuV9eupREL3mtfaK1FSWAcqoXWbghTXe4LL2rD8pdn9aFyr7+7GZtmKCnqiweLLIQ5QWpd77f33UYGm76q1HsO8rnpbTejmYf/OC15T1aqgp8cqutfG+EOOMROMva27scrbc/oJacoId/rZIXdV5j7P0xHfYoz4IK1CLCd+WJ2PogPSKXc/sn211p4rlH1Nw5DRqQD+AjpzPrc74nsvVcUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6)
 by SEYPR06MB5109.apcprd06.prod.outlook.com (2603:1096:101:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 14:16:45 +0000
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019]) by TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 14:16:45 +0000
From:   Zehao Zhang <11162513@vivo.com>
To:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zehao Zhang <zhangzehao@vivo.com>
Subject: [PATCH] timekeeping: Convert to use time_after macro
Date:   Wed,  5 Jul 2023 22:16:26 +0800
Message-Id: <20230705141626.461-1-11162513@vivo.com>
X-Mailer: git-send-email 2.32.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To TY0PR06MB5706.apcprd06.prod.outlook.com
 (2603:1096:400:272::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5706:EE_|SEYPR06MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 718758f3-78cf-474a-44d7-08db7d62766c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFIRQ2CAqLcvOezTimgeqp+l+CO+HSXuPaIXk6FYSdybX8qgNIKanEgRwHLC8b7MKNTV8VPkZrB2FWwx2cLPPyLfu9yoa31bzqrLVuutv7M83cFGKHT+xhsG6I01NRbeys98GCqE1ftxwZ3Q4ydLIXFVukwguXvryKyvkgiv2K7kM1k3pfsYpL0+Cmnj+HSW4bNRD2itDu+s9rmU8v6s6VnPc/rwdKGLxrPHyz85l0bulHOIxox8BFNzXYhg2KvXyymv08qyJcRAHtUW/bysuHIH0wS0lnEIEmtm8tyq5PjTKte7jTp9kX0KO+Vq5C2fwnfWi3Lr5rMbM3hZFcLjL431yH8480FgREvJlGaj6kzS93GBccEX00XyH+XQeuekGRlTgT1kJ/F3S/UQGD6WwMCBgEz1oJ46j52Q2L9N2AnvYRtu7fgn4obS4PjI9GcmtTaJkaD55AhllLeZNLXoQdwFOfkVNlkdHqtp/KTbq/QxnnSUzqU2TZ7Ht1UyJtViysqtoeb4KNvlUFbrwtubg67B+a+IwJlQ79ruGLFLWOBtwnrn/9C5krcymGIxnWoRP5QOJEodRFI0ZmtneRa5H+MCU6U+UGaOvZqLILEn6jmOrTOQTbRR1+xxCtIrxZggtex1QH0kECDq5T/1XspuCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5706.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(2616005)(6666004)(6512007)(52116002)(6486002)(478600001)(107886003)(186003)(6506007)(26005)(1076003)(2906002)(8936002)(5660300002)(41300700001)(8676002)(4326008)(66556008)(66476007)(316002)(66946007)(38350700002)(38100700002)(36756003)(83380400001)(81742002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjJvUcjPMZN0BbPkNsuGeBHGqj4FACMs4NkQfVV5N2iBk4lCe0B8f6+pfJxX?=
 =?us-ascii?Q?muYBBUMHpTX7W58NmNm1pqOjHZXseDQBcI8k8EPLk4tmg1m95ezmeVtCdoyG?=
 =?us-ascii?Q?Zz3BlcuZaej/8vqiNVX4OEASQ0CijVIRr6C71zEA7AkYPChzrI23slPwbxdv?=
 =?us-ascii?Q?XHo4gTTTGWvHaq94Phyr3sNLcRNkIwfnQLK+euuQB2Zw01ZX1TA5UqBk3hAc?=
 =?us-ascii?Q?4rrbYblzavGZOTEP/8EXj+jfCYp5CHA5B4qv95woB7mRcvoOTxLWva3fuxpA?=
 =?us-ascii?Q?NBZxDRjX8Kn573dhiO1WXuV4EUNy1riL5eTTho4aXv3AejOMVIBgzhqHYN24?=
 =?us-ascii?Q?Yo2riUzl7Jvc8yUxsVYl3TjV86NpCzIrpsWH6+PA7l0r5UNISGd7EBuLUDZ6?=
 =?us-ascii?Q?iweu18wPvzBVkhtYoOA9ozVE1HEc2BAb3iAPki/7G0TbYHNr8WXiqWxEnp89?=
 =?us-ascii?Q?u2XBSRlK45EG9S/qyiWNjLibXaEmr1juUGCMAABi1OiizFHQXa6DXiSIp1zD?=
 =?us-ascii?Q?tOc+kP0ZfW09W3JYKqHv3qXixUSXyJSe3qVCQRZYbopUYSO8hcvBd924qkyb?=
 =?us-ascii?Q?BBVbxiCEEVUCUxtogZrlK9D48xnnhmGQIK0kJ+iWAp5DXajq0Vdd4rCT119k?=
 =?us-ascii?Q?TdLeqxeenCIHcomwxWLZoriYn7desD3iEAWfCdLP3d5bl4FhI7HWxRyJbDmX?=
 =?us-ascii?Q?e4eshxsjG50kCSN/R/jEGXJfTBKQFMz/l67ULd5vF+/H5CwqPkuMrcFh1LB0?=
 =?us-ascii?Q?/6JEosPVXJW41yx3wePIgd0tMbxVzvlyOQrO067op0Plv8sqqFaDqAlwPQJh?=
 =?us-ascii?Q?j5LIwEc04qVUVt8IbBgTE4QwEWdjrRx6N9mOpCQrxPlVGhSxgVw+XwTBiJZv?=
 =?us-ascii?Q?HqBptiYTEZOuuKv488dDH08wIMv2YTudHQwStX+i1mQH/N4YRiXOl3cS+BpI?=
 =?us-ascii?Q?SC7ENue4fhjhFfwyQmfhHuiUzfisS42YYQP0IkrtcmyIFNGQnXmwO0NCNmlC?=
 =?us-ascii?Q?6LZDJPrMex8tVIe988UFpx3l+KvP1GxesZLSaPelOpRN4JN+iqIJzFYYapzD?=
 =?us-ascii?Q?XdiWaZoBOC0mQ5BWUXhaOge1kWTIxDDRYI1/he62z7zAo+aXsobN9Y6Szbt6?=
 =?us-ascii?Q?m+qCgQxDlBkRsnKr1ngU4IhGzw9rn5WH2e7uail9sNL0De6wTeNlV+lJgaSu?=
 =?us-ascii?Q?/1U+KCdZ/Y1qzyVn7GPTAqo4dCpQUwORV4F7wQsw1vT0dKHG82MiXnajQvv0?=
 =?us-ascii?Q?BOe3gj+VqFnHViPxOlurC1f72uTeeayw5BJCd3sBvgVsjmtAZ4y0x0a700pT?=
 =?us-ascii?Q?IoPzHIGbyVlrnEJYlOaQgZo5QxUOuAs9KWtI5yuxyOxmIDZCtRWDNtUMRPP0?=
 =?us-ascii?Q?awTXukc2iKlAH006a6wL5ggklkm6L2ZcX97mEd0veZdFUdu0Qbq9n3XDTAjE?=
 =?us-ascii?Q?Yt77LVTj70fW6XNweRIXdfx4eaDB1TalH8KAiD4gkk4GYatnmoBT711JvJmS?=
 =?us-ascii?Q?/5Snww5AitQB5Kfvw05wAh5IolYsmb4GJmTOMMbfQfl13yEv7XE+6KV2up0C?=
 =?us-ascii?Q?nIyXRX/DjSlNIrA+8Psw4pwoxlEZ4fOQCWZw6VFa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718758f3-78cf-474a-44d7-08db7d62766c
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5706.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 14:16:45.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0s2tYSxhKI//yQiUIrkRTPq9U6i+NhKPVKXH95aMN8UwavHh3LfL++fLZ2v8oOzgOnmtwBxYM2LdZRzBtuEgNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zehao Zhang <zhangzehao@vivo.com>

Use time after macro instead of open it for readability.

Signed-off-by: Zehao Zhang <zhangzehao@vivo.com>
---
 kernel/time/timekeeping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d02809dbb..b57bcb9b4ead 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -217,7 +217,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->underflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
@@ -227,7 +227,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->overflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time update capped.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
-- 
2.35.3

