Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3C6FEB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjEKFWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbjEKFWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:22:03 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC49444A4;
        Wed, 10 May 2023 22:22:02 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B2umdn031008;
        Wed, 10 May 2023 22:22:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=DmrSAZVuHCrey5O9Rq+tNpzQRHC2Zw3e+d3VCs5pbDo=;
 b=UXcovzx1zUcas7khkACTxdVwQEBMiKFdhaeTztuYJN+PODe04D2wzY4OQ4mkTV1upMwF
 o+G5miYGNpMAQc1rYdi9nmTU8PUKYi7DrZCUusGrXDvSCeYcpDCNmgits41SJBNCAGba
 fOzQUZk3bpfPP+fOyGdXqzOhjEumoLU3eAgPUwEjeImlx3Co5uWQB+/L7QCIhLE1k/kg
 moUAGkGadQvnkQIAOecFQgIenBOhYuMSKmIP5jB+PaWBJvnRmMGXlG15KO1tb/Me60DW
 pJbjwcX1g7gKlwcd8XPhtDchaN8nV15RUkB6djJFAlUWRSAtGKlWSYF9EQIcCzcNia5s jw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qf7tbp81s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 22:22:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM9BzgzsUKygcIm8KhMcvijRFIX+0EOAOzMJhA5k7+lrntBoiqce8usP6bDiJDhkZLZjRE8yEO4xxxxAV+krhlsF/dmaidbsovqR0K3AaWwgV6yhDHuhBBommAuNgVppV3g8m4qHb/fi9aQDs9fu8AKb9kL6n0ipRyuTlfAWphvg0j9O+mPCLgCBpBPYLhiCM6FWQ0S9em/RDprgf2l6lO5q8gJBss+Obcs4tlWlhrLPlUMARiISAB0Yxb/GPjnUvoQ73Js8hmZDnZFzx0L5+FubumJE7hjn48miVoMUOkPPXwMHyqvMrmM2IijMVZSfkWQknCmiNfSyPlRUby+cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmrSAZVuHCrey5O9Rq+tNpzQRHC2Zw3e+d3VCs5pbDo=;
 b=hJLYGz3KfUiLTWUp79WG+o9S2T2+QgpVOtK5XK1GnmgITu0v5C00KjRU7UUNDnFRIfnAQJXxKTJ1wK1Vo+LpwdA0CrrMTrEM5jkqkmQhYPRA6X6eILzdUNFDQvaS14sIZThaY751kSzUfaxXLiNg6CF7xRDHQg8s4s9MR8Ywug5fZ0B9oOJ91vKbx/m59rEj8F9iLfNBX580nJsvkywqNF7R8pmLyKV8/5FLWKUaJltUzQ3b5LmZqN2fZJhoPnezRfN+bxE+EWPySW7f+MAks4i/jA6TiYUV8yLXWRbSeriC6HOWpfFRz2thSGcru57R6om4cdWtfHIRC48F2mioLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmrSAZVuHCrey5O9Rq+tNpzQRHC2Zw3e+d3VCs5pbDo=;
 b=Rmyty/Ht3+65k2lmubtaA+r5r/Zy8TKHz/lULlrTpjUa/x6Whq6V/E8T5+6WdXe2j0PZTHctJPMZDETni/0XAyjGKx71DFmQGmonbYijvF1W4it5tdN8/Ghg0ePuNUPWS/RI7ucuoGSyESK5Q+Jj5fT3RArYJycqbwWivG7zaqzvfk2xtcp1uP0qPFcK2kFkYsFJKYn7cjXnEuNGvhq505sN+Ab7b5h2lTAb3VKl0rXvXhZRhW3dN1HuqARtL/ItpyGgfcbmUhg51uI06AEeG/CNphfUKX02yMLz1WFXRfCd0F5duuPCGdOso3uAK3eLdki8TaArwpWxOAMkJBfFew==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by LV3PR02MB10006.namprd02.prod.outlook.com (2603:10b6:408:1a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 05:21:32 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 05:21:32 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v2 3/5] audit: convert DECLARE_WAITQUEUE to DEFINE_WAIT
Date:   Thu, 11 May 2023 05:21:14 +0000
Message-Id: <20230511052116.19452-4-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230511052116.19452-1-eiichi.tsukata@nutanix.com>
References: <20230511052116.19452-1-eiichi.tsukata@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|LV3PR02MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: 224db04e-07b0-4e18-aecf-08db51df94bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1GbmqLwUlEFNoXPwVkFe5w5xSZpAROLt2mbBKvbG/HEO0omDt/r4mx2vmxyIUKy6SWV5U8A2E9bqvGG8vHHUkSP3tKZmxsFdBdIutaUUEkIhEyrofzBDzvS+Kq/QI5oxYVRKj7WNX5KzVTEpvxNJy6PotE8WD0/hBLJd6X7sYlcQ3vWdDC8PVGZjVXwbd7H8kJIhWI5OOMeZOqfCgJVorJPeFJJCXwsSrQQu7/mmWfdgx9GtwrIxKOukbQSL7Q6A27hyPro/IxRZLJY6aGCps8TgzeNAyZP19OMfP9ftAJZgsK+Drlr1Tgu7AY3hZ9+p/Z+GSz0KOCea2gYgbRayYmVD9BE3HXvrq9vfwfDP7gOAxV9LQqom01B73zcidNbWOgqzlmH0RK3bIQqZR44Ir5+sGNOz3KEFCg2BSA1fKlaBegQsv84EycoiUK/Ca8UWQDRcfCHLQOWuOhDB90qzjUaL8+sznFMIkqOunNcoexbIwPkk9sjw8fUhzs9Tx90TH4Wgw8VV9XRO949gx9NCEN9ZA7/bNwue/dQ+OzQy/7+ydZ087cGnmYe1sZM4IORdA4LKETzMt76g50XkM8nUP5G99D3qirvtmfJdPhC4txJLEfHdOU1Tf42xuasrdrR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(478600001)(36756003)(86362001)(2906002)(4744005)(44832011)(5660300002)(2616005)(38100700002)(4326008)(38350700002)(186003)(316002)(6666004)(6486002)(66946007)(66476007)(66556008)(8676002)(83380400001)(107886003)(1076003)(8936002)(26005)(41300700001)(6512007)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ts1SZ8ulNxidivU6chHYjUEBGr5jjsmc1a+KwkyQrIMtMHeXt2L4vvAMRTly?=
 =?us-ascii?Q?KPh3UhLoIWXoFHHnO76D7vX4XiYcVzOcxH6YAi2VtmNS0hsWVjYf0jl7/dQM?=
 =?us-ascii?Q?Qe9zP4WJfFlnGeBLe8AOXJsZZUcPK7PXr4uPL5kppW9OYzOMAZVbX2Clsd+P?=
 =?us-ascii?Q?d4RPZIr5OR0zWUobMWvYKMg4eqj/dyd6q+5pve2pB5/2mnCKzbElRvErOmGg?=
 =?us-ascii?Q?IcVSnVxw43ubzd0cnWwsYxS6aeZFltEMUrbAoiZEU/mb7IKb2TNQv+JuxZkx?=
 =?us-ascii?Q?5EkUMf1jhaF0+DhIlHvo3VgJIijOA1fjaBnfNYxip3bIOsfGbKQ/Z67Pw8sM?=
 =?us-ascii?Q?cACV0OqNx7nvHOihEVK814rwvDbxJ74OKHlX3/KL5t0p4N+5nvW8tVAPk1Dm?=
 =?us-ascii?Q?3JeH6kdTQ32LjPnW7ec1R1y0/MZR8LfqvfnN+Z01EIlYNrWuhxggDxp7VbTH?=
 =?us-ascii?Q?xfze62MxH24oPO9bPCOEijgCLUW6CrG0boSceKLul972NEwExxwEN670O2ag?=
 =?us-ascii?Q?8peCuirI+5auWIGLaG1cwG6DHTMN3EUPVjHWnLLqcMmvObpdT0I/PmR097oT?=
 =?us-ascii?Q?+iujSxTJMdz3xCa9tz4IdNsdCgGEgdaU33jLx4Wso98oPF9fS7cttFfnEXwu?=
 =?us-ascii?Q?x6NAB94zlOsHQUVK3s1MXEt4+vNyiKZop2opUQCgBN6fJgLjW7SCrcDkMtdW?=
 =?us-ascii?Q?0H3WrjL6dbvmDhnb97IeXEEtf+rkB2SP04A1BIhqv8HyVgPFyRNp8mMUC/FG?=
 =?us-ascii?Q?dX8Bsie14NR3kHpi67Bp4C1IKrR44TnQwaLsq+9XiI4zUCf7lkF2YX+F5hmA?=
 =?us-ascii?Q?TXEHr7PBQNzXHk1dUSp41W4CEaIcnwJ9FFqtOrr+M2dbsP4JOStpCOfmvWAu?=
 =?us-ascii?Q?tD1estuHSgLVAjA7hqcdKiTz7UGw7ac2KknK8PX4lA/FfNBH2ZCWTAx3hSVJ?=
 =?us-ascii?Q?wd51wAssozcp/mxU8hFLqVSicy6pEFqJyCm/eHecSkvDsKbZK1ZCfDoj6+R6?=
 =?us-ascii?Q?XDQB6iMhZJOC3qHO6iWNWg6kF/yw7xhhLaWCWQ0ZmtYXiwnQGx1jkeEq+j6F?=
 =?us-ascii?Q?OrcBHP5GhPLI899SSbCMxKDrn3qTyE2Mvfdn3oKe4rYOoyIRngiG3yL0RaLT?=
 =?us-ascii?Q?HLjx/KEt92QCe67AwQjTe0Goy0+G8DtDIhRml9rwy8rRPbdiGUnpNHQWixPT?=
 =?us-ascii?Q?XwTlEOh7WzyJklHNmYh5+Aggmnc27gKxyhwHPqI22dUP5MAgLxYSGXbkdZXm?=
 =?us-ascii?Q?hxRZktvKeB+RFyy5FD9TL/05P/V6qI9Qt20Q+JQfIllW38fRCPXK5MvYJU3u?=
 =?us-ascii?Q?ClUiN7L0F2e+xT/qpMipthfc4YWYiO2f4rHodlTKvEDlHbQI5XbaYwhkKqoi?=
 =?us-ascii?Q?iIcp/8gL0bK3VL1gnz1/VhlJ0RDbH+gylF/OXunbgaUbD6dY2daFXpANXQ8s?=
 =?us-ascii?Q?DGKT9lqlMWK29snbNt0JuiFvchT5qkDGi2n/d5XruCHXZl5SZUJ9aC4eWabW?=
 =?us-ascii?Q?+OG7i1ZzYcmvfAebXKw2OzlgelPMjWN3xUnGhpYKOckA7vOzdsZ+7Hv5anaS?=
 =?us-ascii?Q?L6SG3+IR22Pv89za5FpiD4wWGvaMcguihooujGl1nZtTNhO2pdAz9hlaFF3V?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224db04e-07b0-4e18-aecf-08db51df94bf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 05:21:32.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8TFZwA0McWm2RO4Ag91R+TNdO5RVMpgBEwP2+5sbzWoZ0Ykfeh461YvkUBGGpd1yeWyRatQ3LWx8CSW1NEQLWWae5Yi4hQonVPf+2CvCEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10006
X-Proofpoint-ORIG-GUID: 4cHUNpz9ONHELrYwMCm1rTV5MLw7j-mX
X-Proofpoint-GUID: 4cHUNpz9ONHELrYwMCm1rTV5MLw7j-mX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is no need to use DECLARE_WAITQUEUE, use simpler DEFINE_WAIT.

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 kernel/audit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 89e119ccda76..bcbb0ba33c84 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -640,13 +640,13 @@ static void kauditd_retry_skb(struct sk_buff *skb, __always_unused int error)
 static long wait_for_kauditd(long stime)
 {
 	long rtime;
-	DECLARE_WAITQUEUE(wait, current);
+	DEFINE_WAIT(wait);
 
-	add_wait_queue_exclusive(&audit_backlog_wait, &wait);
-	set_current_state(TASK_UNINTERRUPTIBLE);
+	prepare_to_wait_exclusive(&audit_backlog_wait, &wait,
+				  TASK_UNINTERRUPTIBLE);
 	rtime = schedule_timeout(stime);
 	atomic_add(stime - rtime, &audit_backlog_wait_time_actual);
-	remove_wait_queue(&audit_backlog_wait, &wait);
+	finish_wait(&audit_backlog_wait, &wait);
 
 	return rtime;
 }
-- 
2.40.0

