Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC21609BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJXIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJXIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:00:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003D62CDE9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhjjI7Sf64oMSuzwMk/qO26I2KLKZOtDD2+xrHkUNz4LL3Ofj9zzwD8t3fTUh5onagFPXCRj1s8j/iWC3mHzPXTloMWkZ/+cq4tacSlD079AvV/OB+Lx94ZSPQay3VqEkFNuZ+GUovqtAs34Bq6T97cnJxdl+DTDPcoYuATxvW4mZng1uQAZAhqm0ivJHOh776FqDHGSCppznbsk8TfMz/2rmMSvHAUCkEmXRoKK4LImtHJBNxwNqNWij13uUCVFfurFfT+vCRTC6HkqqmBJ13iOjRsNSXIthij79FUfWaR6QdeAxLDYbXVIbQ0Qmcz+HITevpla7k33ZSgh8lAagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csdK0leqCOC3qwKZgXd1lXiEUAcymE1LRx1Ipy8sqSw=;
 b=YV+H4sh7nfr/O00FTgSvHVxL3QMoKQD97Tp/vr2ksrzW74L1sSLBK9ynmlqTJQb/kZdBQ4R3FOPOY0hSrpJ2nW+vjYf3FNOb722d2vTZpHpZ4fcamJZ2bSCavDkaGfGoLPUAjIps7NB49Rp92sgIfuJLqPJ+0xWFkwxDKF/PJ2cfiUGDaFGKcKbM8+Eksjxshjzvv+JS0pTOME/pdM4hunY5ezE4JOX6Unaj+Ql7K2BkNZRO8J0Ekop4nJvU81V+YGo7hNqQJljBVCfNTY1PV8LIyakTWmOU+3WQLupGBqzGFJXLk9lJklT8ws0/uAufGMravDCGXyU2zoasa4GyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csdK0leqCOC3qwKZgXd1lXiEUAcymE1LRx1Ipy8sqSw=;
 b=YFq3XQ6oMKR9qk48/0u373D5/TOBO/VXRHxfpJ9ctnbxPc/0KWy/B/LApUwN05oOtFG4EswlXVUo6Bx+4/5loWE3ZNu2TNc+pAp5FaviHlyKnx1YAeFOFhhaZlg9//3Xlh1AUZfGU92JL+4BHUhN08ws1kcCLhgLqzlxGqdgGEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN4PR01MB7455.prod.exchangelabs.com (2603:10b6:806:202::11) by
 BL0PR0102MB3604.prod.exchangelabs.com (2603:10b6:207:33::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Mon, 24 Oct 2022 08:00:26 +0000
Received: from SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::ebe2:243d:ff84:aaa8]) by SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::ebe2:243d:ff84:aaa8%3]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 08:00:25 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Corey Minyard <minyard@acm.org>,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com,
        Quan Nguyen <quan@os.amperecomputing.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ipmi: ssif_bmc: Use EPOLLIN instead of POLLIN
Date:   Mon, 24 Oct 2022 14:59:56 +0700
Message-Id: <20221024075956.3312552-1-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To SN4PR01MB7455.prod.exchangelabs.com
 (2603:10b6:806:202::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR01MB7455:EE_|BL0PR0102MB3604:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7a0f43-cfdb-4a36-e739-08dab595cef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: te9hQyz64OcYDxxq2pjN2M4kVhrFCo8gaaLaiA3oN4IlkLpSvb3KLcumTmIVK6iOPol3/yf7JQyowlpyQ+D/cMydaJY8CEPpvnU3bfVI3PcAF2NV3u0+bx+Zdz/4AZAAbDRUKUjNDCxqiFkHzTnqiv5FEnRbwoq0cHc0gFpQfbGOsFb4wKRaJYkKC1pb8DwzT/dzoZnlWD7iMRv+hqOVQX4NdVw/t4wmL2p4hgbjgokl7I+2lL6kOMuqUdHWTnzG/mB816UsH+IXnaHWdKcsmP0Q8HwPokaRvra0vcOtP6Fwg/RoOzpd2J1xVgNcIM81kJUqwRXOBRTSVwgV+j+RYeEsVRgTDPnrSqGnxuiRmGMZGKsliA6pfabA7Sz1NdV4AxxJbrWpxw2nnjXYg1DplUV6MzN0y6qjjhEmyLUOnAvoHgKkUGriapJKqwOYNYGJN+6WcL/K32eI/05rttBjKfQ9LbzLNrYXNS6J7Jbx6sTSu5di72alR5r+qp/Sz9XV+n37IwnHffIggwolH4Ad8zuLtt7aADRydwl9tt9mWxgEt6q4YKub4U0v3G4aPDLdEuPYrZGW9Z3MjrOf6pFjk6HTvgnMs9gtPbrAYvKEjTbNZydP6VmyeIUUynB6lpxc4vwin0SfCVU55RPF79vFkJ0d7ufNz/F5Y9mH0dWDpWoPdp18S/2TZkKPnFbj83YTr0iPEmthjELOn33Y0O9SPsm9IT+Btirffq/bUkd+9lE0wofX3Rk52JU5kKcB8pXMQG+M00EPn6a5s7c7V8AwZ7YknmpoEsj2gxTde7g5HY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR01MB7455.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39840400004)(346002)(376002)(396003)(366004)(451199015)(52116002)(6506007)(86362001)(41300700001)(6512007)(26005)(4326008)(8676002)(2616005)(66476007)(8936002)(5660300002)(66556008)(6486002)(966005)(478600001)(6666004)(66946007)(110136005)(54906003)(316002)(38100700002)(38350700002)(1076003)(186003)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HnkOV9KWZnW/BpTgcJbYPXvP4/VYbtCBrnULMiHJ5o0+HkwD0ZrEXrHOkEqL?=
 =?us-ascii?Q?Q9bf86qg92a/E8H6dj6q0m0aX77dUKKDl7EBH1CNpljW+nAj4FEVj1WV+6Zz?=
 =?us-ascii?Q?o5+q9OSUiMjXz2Bm+/vBAqWvCMIP612F91GfDkkQ168LEL99eU3ND4DwuuWI?=
 =?us-ascii?Q?rIkwpJ0ccLSYPYDsmHpQ1BiTk9VTaImL+LgujK9H6u6vtIgmi76vGkqqzpXS?=
 =?us-ascii?Q?1sMJZo4rGzJam+TftdcoPOWLBk/Yvjs3hzMqc2mTKbmWlr/GtBOW5fIR/XKW?=
 =?us-ascii?Q?Cwla0d18K+ObmEstaWcv1JEjOVUT5Dm9qiGE4lORSYzMAMI0gcw0j45KTkCw?=
 =?us-ascii?Q?8bzM2Bj6cG6LnZS7AlWm+NyhDXTxpw3BWkfckQyh1fHEoEgSCcwr4x3Bk0OE?=
 =?us-ascii?Q?qxXjwzs/8ioaEscQZHTb21NhLtc864rHwUmJTxtPl8QGWA1LdVIQEcXEFjvO?=
 =?us-ascii?Q?MEtIPb1apnXH8EhCbrceL5mEEPeMXPN6QKRhVMFxp9UEX4iT9Xxo5eAJ80zx?=
 =?us-ascii?Q?ZrPMk65Y9MDTi3Fj4WDzqDrFONtFen8zAJG+7530MC0WuFoM8GCO+Zjn90tr?=
 =?us-ascii?Q?Z0bEo10wcwNaxzTH4X/S1bGhv0ed1JTJn6QvlIpSqvqH0tAL0gWRrJxvltHk?=
 =?us-ascii?Q?kXaJaKH71zZTuxuY4VfWHH5FxflLo5h6MLneM2c8pZZEGXXAtsHnA9FM9fHF?=
 =?us-ascii?Q?qRGOsxp46drQOrSIhGZgZkWAoJNaczusKSaP7N0p7TNAUb5VwCDK47j++vLK?=
 =?us-ascii?Q?rChTWdad1tSkvx4CAN25U8XMGl054hCycFN7LmphQ2A9Hd0DM6rsdJAvywyj?=
 =?us-ascii?Q?k5Hb34WA1MPtjVSI8ZmCG6z4vwrF8IV1ZaDd13W6J0cGEbtUAyjyGA11uYkk?=
 =?us-ascii?Q?bcbq8Q5A82RociB1IyOWmTw1g5Lfw+ZhgJ2E78oCVvTVx54c6lzs7B7S+YXD?=
 =?us-ascii?Q?sd39F7m76/OIHtqxDmlFO3WK6tNdfBk2Tgb9UcFzYcy8c8uXfE+js7VF2cn1?=
 =?us-ascii?Q?uSi0SmUFyIA1OFOALLlrnhy2LTYmPg23Oy4C9E6Zv3qp+8CujMIgV8dZK/TN?=
 =?us-ascii?Q?+1NlvZik+1GVvW/mD6C37CibTbYSwaI5Vi2BaTXootAch8MIV6K38uiCE4xt?=
 =?us-ascii?Q?ipUHWhI4SnfuuY5Yl+IXztxOHYUMWu6xKifkJ98sybxFVgGIn6hr7oOipcVM?=
 =?us-ascii?Q?PNbQZVgL/1mJ19kOU2HYie+l6B2XhDltH1g0Vjq9dl5bmrxtPzbrsmVPRTm7?=
 =?us-ascii?Q?O/JlN2U2OFBoC9WiWOIEy2GxNpfVYVd7PFG0DJzSGkQzu+OmssAYn3x5NpnJ?=
 =?us-ascii?Q?VKDf/cS37btyyIpQWQhB6Vb6fW+13/YZvn1CdGTjrxn812l2lZuUU04Vg6GG?=
 =?us-ascii?Q?exZAXEovdpX/oeeO08GoT9ZX1i9aXKVYegcuVJYHZjQuKG/7FCMWolOtWH7g?=
 =?us-ascii?Q?fdr4z9kygocyhBfDtU6aAvAqb/OM96+HSj/L31fBbP+z2ElTDcg/rmbABmqb?=
 =?us-ascii?Q?KebTekAIm4KBjMST5/1c4Ws17ZAE39PKCsPIemopwsJFE0JlEObEsj1/HbQD?=
 =?us-ascii?Q?4zt1vUKqACOMY0/rHRWQgYy47n8Q5Y2Px8R4GpL+u1Gs/8TgVcFYvAYLKp7n?=
 =?us-ascii?Q?8zMicDJ16qPfYGtzZ611y20=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7a0f43-cfdb-4a36-e739-08dab595cef2
X-MS-Exchange-CrossTenant-AuthSource: SN4PR01MB7455.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 08:00:25.8607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db8700CTspdMQ40v5PdfsoGhK7KxmEmLYJPBBG6w/qRAzWEQpO+PU7+QA2ApE0TZFrOPrskT7De9AGK1frTU+oVV9BReHo0qnjdURTj9beM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3604
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following sparse warning:
sparse warnings: (new ones prefixed by >>)
>> drivers/char/ipmi/ssif_bmc.c:254:22: sparse: sparse: invalid assignment: |=
>> drivers/char/ipmi/ssif_bmc.c:254:22: sparse:    left side has type restricted __poll_t
>> drivers/char/ipmi/ssif_bmc.c:254:22: sparse:    right side has type int

Fixes: dd2bc5cc9e25 ("ipmi: ssif_bmc: Add SSIF BMC driver")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202210181103.ontD9tRT-lkp@intel.com/
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
 drivers/char/ipmi/ssif_bmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
index a7bb4b99000e..2d8069386398 100644
--- a/drivers/char/ipmi/ssif_bmc.c
+++ b/drivers/char/ipmi/ssif_bmc.c
@@ -251,7 +251,7 @@ static __poll_t ssif_bmc_poll(struct file *file, poll_table *wait)
 	spin_lock_irq(&ssif_bmc->lock);
 	/* The request is available, userspace application can get the request */
 	if (ssif_bmc->request_available)
-		mask |= POLLIN;
+		mask |= EPOLLIN;
 
 	spin_unlock_irq(&ssif_bmc->lock);
 
-- 
2.35.1

