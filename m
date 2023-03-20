Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8195F6C21C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCTTmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCTTmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:42:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2092.outbound.protection.outlook.com [40.107.7.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4927EE9;
        Mon, 20 Mar 2023 12:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlJj2lu82ih+qIpxGHJLtl+Q2I29K6ZFTOFa9AuDrRh9wHqMreBTYJF/4GIFfQNfi1UrVj7OiARuOgVXxOoHZwUTS+C9fhxUeXYudXADqMuPwpFbnlMEIEtu7UB82GCHyO9MAFmHWjfWej9W6Tuqt91v9n0RWIKtTrGahrB+HLZE+sBQhBnCtXTzGBUsTlLzCw2F+iLkIP97aoJwKxN6pXUCMWqwpNKm2Sc2g7IG7P2vrbzMN2PB/XAU3mI09NqIVNahL1rv1LFB9MBH/dg7NfRdwKl+ovEeJMghlzQY5fa/y4LIEMMIJTByfv2AWLol7pSluCUIQ8m74QTFPoQ9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Muo2np+Qx9uuiVhiT07EL+FyvdusUbyAGr9wSm3sqD0=;
 b=AcQNyofHbLGQrznApPoZP6XhDBPTbA6k4MPtPyimdgAZLVPIL4T/j3XsoDTw6i0816ABKCiIr8+PRhjsPkrLGsWVJ3lUDW/36a6CtnFPcqCtwr3Wr6KDNi3l87NWywSVU5jurbiH610PFfjUYQcoeGWVxu5G4xUnHkGwwLIeYKpu75o5ZkHkk9VBJYWa207Kvtc2J22NbY7B4fuUGC5uMuNLb6elHKBXFw8qrY4DOwfl7xI66o1p8csxpDaFmsc6wITA2z1KCUML0oWL6et+c17+v0da99l7WtaemuMrNPtFNDp7syyJB+eYPbC35Ij/VjWBoc2gVeG3DqFVPpeyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector2-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Muo2np+Qx9uuiVhiT07EL+FyvdusUbyAGr9wSm3sqD0=;
 b=I0jgf+M1tR2RAafh31gJMGsEDAAmGaiFgH9E/HnRshkQ5BCnLOobcTk1sEy1bustp9WWiHSYtA6JaiPFGFG7f00V4pjWidSciaxTRu3Hs/tSsXqhK2sF7BRRX42xEQGoZG2/TKbBsvFUovSY1sKOj8QhL2rVtu9i8beaK4qBgVGwcqJ/512oC0y9g1uQS5hB2mxguYtj1D6CIe9XeeYIDzwXzCN/4cC7NSvwKozMixX0Nb4ytVVMexQ9c96JprsW/5pUBDATj0zvDkqTEAM1AUHCUOZajBKD0/QvIHxCZMEFAvF1j/O05+H33Mp/9aeYqn2jWsvwSVMJBiEO/rLgeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com (2603:10a6:803:13b::17)
 by AM0PR09MB4065.eurprd09.prod.outlook.com (2603:10a6:208:1a1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:37:32 +0000
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::33c6:e01c:20d0:45d]) by VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::33c6:e01c:20d0:45d%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 19:37:36 +0000
Date:   Mon, 20 Mar 2023 15:37:31 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     lgoncalv@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 5.10.162-rt78] Restore initialization of wake_q_sleeper.next
 in fork.c
Message-ID: <20230320193731.GA36840@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN9PR03CA0428.namprd03.prod.outlook.com
 (2603:10b6:408:113::13) To VI1PR09MB3582.eurprd09.prod.outlook.com
 (2603:10a6:803:13b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB3582:EE_|AM0PR09MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9d07cb-ef5e-4ab4-c2cc-08db297a8ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XyAbmpGI+1vG9goboFTKC/By/I5rVc/dVxYmtMj2RmmQTP18bAvjJ+VdgUwnPfK7XbRxrwWCc7n378iPECYbddG1DfYsTHs5eegsaE6q6uc4zgSQfmdNL6S9TjPFHEWOkLJzE3s/DE79nRDxjLutTEhJUMsmLTv8EcCYPmcEO1ONvFjxGDY+u9LXbAuOcUpHkMTTIv4rGB+VB1DuSOmbPmTWrXUxxaUgol6wYnHAK4Mci/iTlgaz/iWvAjvsWLacdZh4duyP77NiSnvZEUc2MZX2p3cPsTihDVr1fAJ+V9EMMJg9EqsoVT5ZgGjiI74MuxU/lhrYDL8w48PzU9rnsiVASifXAb420JyuRBqCcAHQ8EuWoooMMCDmZXy0LOrvVVR6yvAgWhn8nCrTtCMKzfNm90SNhmauWyQAHcJ+ftnWmwBi6qV2qIDNHP50ncDRy/Nki7iNmpTcrxGNIEngeGpkdXgaBipdLuoMeqQSc/djuAyevPL7ZHvRTvaYASoFTTtEBY6bmWPBCBRC8rl74JUCiFIlqaNWNblzXeaJbEtRcEoo3PaCQLcqtz/FFFpPHQXNVnpxv/XRxO0BwzBZle1EcBpZSMEG3xG9a+q/XDwBOlYSHy/8hMPnc1tGMlP37IEI1Tj+w8qX/uwhiAXe1T0NVFPpeuvH0wfncFOTcC3/OYrBOwF4gzjmLPEMgDQv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB3582.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199018)(83380400001)(478600001)(6512007)(52116002)(6486002)(6506007)(316002)(1076003)(26005)(186003)(5660300002)(6666004)(3450700001)(33656002)(86362001)(38350700002)(38100700002)(8936002)(2906002)(66946007)(41300700001)(44832011)(6916009)(8676002)(4326008)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AWB8opotYcmDIw8fNiCZ7+VtigD2HO9DecfIwzzleICLkmD/sgR5Jf7tisNC?=
 =?us-ascii?Q?rBybFqa8jbZuPrEcEaTngJ79T6915WFhuNihDh8DDKVF1IV/cUyYal7VXkQz?=
 =?us-ascii?Q?j4WGT5jFIW+vmgDBVwSwBWgpGnhECQLv7HiGih4scHrVBgPcZvYcFIo0jTKJ?=
 =?us-ascii?Q?1TKppS60/g66I1kDjb0oPYPkCfAb6egw/5ZHCSNdDxvMomWjQ0tZSfB4dR2M?=
 =?us-ascii?Q?f5j0w+JuatCHUvfSqjDKbQZCsJ/ocyzHDUaHDp2rljf/ZVo/gy9Wlq7wawCC?=
 =?us-ascii?Q?d4CMLUg2LVTSSCaW5hIcH6sEmXu6EriS/ulIZLfgS+8l11dvxV2r/yUt0OOU?=
 =?us-ascii?Q?XXoTp22huIOYiL9WKqgrOp10Aj7zslcS50dR5SXJo1SfsOABWNpMRdPRoqve?=
 =?us-ascii?Q?IvBRnAqxQhMrJbElOBYwPQTM3JXM8ZrFqxyODsXvgOZ0rLzJ8KWUO6RzYGdZ?=
 =?us-ascii?Q?HHoVSmNaJZz/qiZ4H6Hc1iujIEmpStqo8q+Ri46Dq0MTPaCq0H9OGDPByMZq?=
 =?us-ascii?Q?Ufd3/NeEpXqCUV0rbu7/eH6rqQo90MHFfBJjQf8qpOhzpb2nmlvL28bMyUuC?=
 =?us-ascii?Q?h53oWfoiDqo5sf2sf97hRrnfOOeLpZkHuO5jMNlcxTPs3g2NOE1HKjb49L28?=
 =?us-ascii?Q?q35jUPNqQjQaVzduHdaXXEd9zsGk8jjkfQ6IeDZ1Z+fGuH7nS0OfmJmA/auC?=
 =?us-ascii?Q?HDmwscoLSI9ysyBm8a357gAPINjUgaeHJmD2Y49x0vUvjpGGDb0KciZDcRRX?=
 =?us-ascii?Q?cuZVJy2Ujs40OkxT39nLo8VdbPUyJQRd5WlGhf791TjFgrFwVCP/vyN0+asi?=
 =?us-ascii?Q?E3Q85tRDpwKBUF8Djl1rt57MmpVXV/oxsERrlOCSdGek5SkwhjsBeV2iqyd0?=
 =?us-ascii?Q?SjJnDkVkHsOBrsRRzjDhafJmzKKMRpCKJBQPApsKBbu68NLfDNl9HeNED71K?=
 =?us-ascii?Q?rhZnefOHqtspbjTol/QIDWLOnKf+WzEaUXzSZelQRtr1dld5aUIpZvrrPvH2?=
 =?us-ascii?Q?a15BE7/fn46gJCH0RfWFlaPy7z02zGMFBFbdf/5yYHSGT9FXCW/yhwoV40ki?=
 =?us-ascii?Q?vHPuyNMJsuxyH7+sGWlcaoZNYS+KuVLWARK32eTxxBVzY3CZs6L0vqERJceT?=
 =?us-ascii?Q?dU9v0WBjtILgtcbooRZzcQoNYilDMYpsRELs7XlIz2kYLEZgWEFdFGzM5SEt?=
 =?us-ascii?Q?/rP/eWRMypMvaha3k/8UH1xDlTgGOUDcoQ0Ypyiwv3Iwo7weCR2wjy0hZ9c6?=
 =?us-ascii?Q?wLKyguGZTpEA/nXiXNVvUpm+OC8MUQ4Ucil6MxNlYVu51IE6pjyPYjmynw8l?=
 =?us-ascii?Q?tjUoQA3ajkVdJlby/0FEqfhPLJVWezeOKO6xWZWprHjemWKpAUcSRs9INJaP?=
 =?us-ascii?Q?0SyXbU4AnFI8toZprmGqcYH3pfcvg5jxFYaNkEPH/fWr4xq6IGp3Qa2TUs7q?=
 =?us-ascii?Q?2mGSDjUdW51ra3SPoUMqDzKYwI69t8ZdY+SDVTlNv/jNtorVGHpah5J6kTHj?=
 =?us-ascii?Q?HMLh2G5v3g0sW7niaRWQIu5d58zlb0gpm/43QgJtBdXEFk3HpLg89sa9GW3i?=
 =?us-ascii?Q?ep/MDWq3X0+d0jYELFTcsUDIkXV+ZMdlLDp8M5u02ii9KLLDMvN+0G4bXvly?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9d07cb-ef5e-4ab4-c2cc-08db297a8ecb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB3582.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:37:36.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHoJstBkKA2Ia8PbA+MsOGRBbdtwZhDOONENR31U7M4EEZQTjtBYM8FOYEWDBWmG+heD0Dr/VBQ8choUoIOr7lvvPrt30d7mXcXfDJFBpvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4065
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the transition from 5.10.158-rt77 to 5.10.162-rt78,
the initialization of task_struct::wake_q_sleeper.next
was dropped.  Restore it.

This appears to be only a problem in 5.10.  5.15 does not
have wake_q_sleeper; 4.19 does have it but its initialization
there is still present.

The 5.10.162-rt78 patch that damaged fork.c is:

   0170-locking-rtmutex-add-sleeping-lock-implementation.patch

I do not have a simple test that brings out this problem.
My test consists of a shell script and eight binaries,
all of which were written in Ada.  strace shows that it
does a few thousand forks in rapid succession.  One of the
forks stalls out, after which no fork after that returns.
Eventually the 122 second stallout occurs and a large
number of threads are shown to be waiting for tasklist
lock, either in do_exit or in copy_process.  The kernel
.config has rt and many debug features enabled, lockdep
included.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com

Index: b/kernel/fork.c
===================================================================
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -960,6 +960,7 @@ static struct task_struct *dup_task_stru
 	tsk->splice_pipe = NULL;
 	tsk->task_frag.page = NULL;
 	tsk->wake_q.next = NULL;
+	tsk->wake_q_sleeper.next = NULL;
 	tsk->pf_io_worker = NULL;
 
 	account_kernel_stack(tsk, 1);
