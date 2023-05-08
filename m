Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6556FA1B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjEHH66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjEHH6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:58:53 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0AD7A8A;
        Mon,  8 May 2023 00:58:52 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3487QqkG011998;
        Mon, 8 May 2023 00:58:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=wybb7csgti6PZ/4OnQUT5BT/u0GFyNhURtuC+iUr2y0=;
 b=V1UXALHrBWysMaaA7HWwgRUsMkFDZRXLbS8W9wF17cbehHOSmquL7nCVdF87SV4xla6S
 uxbyEqgfFdpMXqjISJz04/8C5P5tcZe12TdRXEf/FH1WIPuE9OEtex0R8/9ETrkGR77g
 2ZDe+P1mWjFxjaoUKhVmLL7lTnicNfjH0qQXoUlewiKFFnrHKyshfu6nNx1Ghw9s/Q3O
 yrXTbVEKg3Sur8hjIsshuoThJgftnR9C46Z8Dhs+uZKhW8RK1stMPYj6535fOFYI8Aee
 b5mw/uf19ewOgeGW5L23V9+P0Z+zT2n1MWdHqt/SuRaRSdMGE4He59Jz0PN5YW4dtBdI uw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qdpe43n4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 00:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAVSPgqCMwI4loBAdVDGHwirfZqT3YmqH6/EfXi8mlp3uGVgFWyOCpvEp2ekkDrYQTBfYAXoX58JxxCTqoHJQPyMy4Qqx2oRbOiVIOJwwjZ8Qzouve5r5AH8ETGnVVibJTXr+MbT8nYn0kBQY9DRh6+Yyc/d0WSsczoXjWj9yHL2ARziV6YYB7GZ2pg8bl87xIWDDZOj7yV5CFiYfeRyNgbOvywMVIC2xLmq8t5rsEEzGXX6EXGKgQV85FW07yRmU7ZU7mRWWZmcd5xwHCwj17uSR1TMPLjPg7udjGbpT5qGg9CV1xUSQN6dKYckpoA2B1rH2MhSwNTwYw/li2fPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wybb7csgti6PZ/4OnQUT5BT/u0GFyNhURtuC+iUr2y0=;
 b=dCyo93jtD3Ebl9jiTB2UkBqUvHwFW8DzemBmhIHMEfSqrMB+MXveG7C9K3T+YsToUJBLybLZsxw+EtzyFGL/5aQKNJ98EOF6k2EOEnycvPqN9wmRYjrXSznv5mGkQN7zBkVGSNXMW4R3hwMYJjE3W48mNJlw9JvYMqQon0KsjOPev0rvIPN53zFlaWrtVJzFrlGO/znab2NkTPNG3UQKRAz7QZ9qdclGjpKe6+R1y3gcd18qaIhmMlAMXfTpmkrIunOY3TrDahL1QHN/QO1Wuq3w6qknA3WRZ0/g8qhdKBkqWVvyrnIKDZWSUOd6ha/0a5sk9F3HJtfZU/k6Zh1Shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wybb7csgti6PZ/4OnQUT5BT/u0GFyNhURtuC+iUr2y0=;
 b=guzRNr5sWwDJMdSKtF+/HgxHZpQExDQca2Qa+vf7bpkN2ZoyepajWRrDyH7diDpktF1W2Y+BiRArwz7uSMXGhKsVZpMxRKaXxKpNj6WTHiBJp6zdFxxAg9tWFnNzzsTNxKhDMgwngLFWQA/p+OE1M1unviccc6bdMeJ+rPVTpFoudNqzmp2dX8eEedfJWbr+0gqh9ROdY/O0n54egbl8VLXQHCjNNGpX1lFyz+UmcdgRbrW3crdRytpIGKKBvXV82l3sUizx9nmFaYo7cRXFRE070+xI9yywwacxN5KfHkMQGK/qpkPAW34aTqCr6YHzG0EFuGSg7sek0FcouBI8ow==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SN4PR0201MB8821.namprd02.prod.outlook.com (2603:10b6:806:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:58:46 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:58:45 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH 0/4] audit: refactor and fix for potential deadlock
Date:   Mon,  8 May 2023 07:58:08 +0000
Message-Id: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|SN4PR0201MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 024ba718-b69d-47ca-dc25-08db4f9a0c82
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y41dyCGpEstoj9HnrQYIR7gIl3/VjUXv7LXMd7bGU1KuPuNxIL2e9JZUPS9WiMLmWLPi6Uzb1cTV1AlGyFJ7b5DlKM4JNn69ygQqCovWOCS4sMRO2FW+ZXfNU7BrtYjUmgb3+c7F2CEo8Amegr8yKf+JCSL4lYCgud+ZNBRtZbeZcdbAQ/SahOhSVJu4pbLDI3kiyw7Iqcr5glSO96LbrZRLDeDfFO1rafdb2BDoF5OV0GSZXlhzQdfMeHgMdakfOkVEXuR5yg7zASNoHzyy6A3O+HnIW/572IeSRfB50AC4qzV49Xbf01Qdav6xksgsa/jk2tvxQtdlpRje0ZqMdFKNiuGgZzRBpYs+W97VYVU7v3pICuFLpY/Lu/+tackXrkRbxsR50fHoENhlKMKYg1KzKtNH9/TY5SjtkBKJ7lhrTHaq4yf6idceNiAkzL9W+kkRdEUjvF3XbtczaK5WFG/8gdixQtOCrgaycx3B+XrqbI9ke+PE3rjmhzKiINkLbozLoX8ny0LZg/1tZhfS1EId8z2W2jDulADw7+81FC8H+uRtXm6TA67BBVQDMuJp/N8pcROX1FX+RRpBXhoCtfvIgoj9F//7hOaioE4PyfwSSHfX3U7amlA2rggQjBsg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(52116002)(66946007)(66476007)(4326008)(478600001)(316002)(6486002)(86362001)(36756003)(66556008)(83380400001)(107886003)(2616005)(6512007)(6506007)(1076003)(26005)(6666004)(8676002)(8936002)(5660300002)(44832011)(41300700001)(2906002)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?arfCXgpUeTR5rYEWBliOsrsKKs8EMBejCMVDk42awIDt/s4T3SE7mNdSkOEJ?=
 =?us-ascii?Q?2F2ufvQLJfo4gb25CExz0og3nH9ySyV317sf4MSdL79nGUMmMzNGr1yyhf2d?=
 =?us-ascii?Q?DNOsfCutcg1i9/tdaAa3KU2pYnm8r/nb5n3i9sps+z5MLzX2tt3ZhMMYHjc1?=
 =?us-ascii?Q?gKN46Q7WmHHQv2wLg04uXjGeNdXjNm5gxwUqhnkxaFwcdXQQnvBKOTTdWjot?=
 =?us-ascii?Q?gvbhKPTelQ3asKEQaks/zy38gTIH6HPIESFioyIZ0/QyOCGG19vFfzxu26cO?=
 =?us-ascii?Q?NKe0JiXAuywd5r1KNqDF2DgXClDAv0INZs0ehRKXuCV7sksH3c0/6wYtaL6n?=
 =?us-ascii?Q?2nSnxXZUYffh8f1bI85s/36l3eOlgElSBDsKibKd30nmyB/3mmfucWkx0D5g?=
 =?us-ascii?Q?sIBExxb8qa4bw0hCSzws1Vq6IDapSBgCaVXE2akszTq8vZ0ULoYuDzRHsDEx?=
 =?us-ascii?Q?CyUySUwjWCqBKWO5WLV61bCumx2KOTpKyKMKXjEFs07NnoOtzZKKhILqODZs?=
 =?us-ascii?Q?T0uIknvz+qoInjOk75jcCCRH9nXqIkh/0pxFaqt157hS0D0CxaPAyzc54cC1?=
 =?us-ascii?Q?syF5BkJqmcX4rZlU9PMtRw1dGoSP0XS9PRr5ucsaDbDmdmaMP+eYKGK88FUg?=
 =?us-ascii?Q?OGoWyc3rQVpXDj7droglWx3h8qgp5zBbUSLFrqQ+v+Talug8jm/cLuasrwFX?=
 =?us-ascii?Q?pNIu1tcHvlwpTckIoCXMwLG9FuiyL3DcAFJc+8NQXQetawaVfPqMQneOiJon?=
 =?us-ascii?Q?xeKn0LQe1I9ZgKYZQbhNPqK6/fMp1GhDIcXWKtByE0sNboqmu1Rc8wKsde1q?=
 =?us-ascii?Q?TFCS6c3wh/suUrKtTSglmhhON2kg+Gwu87eRjW/cyjZGLt0ED1ezb2/BoCok?=
 =?us-ascii?Q?SKO4ebTF03fQ0StS0ZoQK+Ol5kJvOR9oOJWj/6AlxD0eFR4GyqsDBqGKAsK1?=
 =?us-ascii?Q?qYOEqmcCaWX8itDNBvclMoosQAvm1nNrLKQu3YSVZOeLboCSW81kgIJZ37pS?=
 =?us-ascii?Q?9TumPOP0lkL8ZawbviWAfEeAylBqjZ3ZNglWKowsVWI3JDX7z+uti31XFxvp?=
 =?us-ascii?Q?S7AxsrpBG0mj3VM/UctpN/PXXzVSG78tvOQH8PCHYh6GVTTWS+rcfiPGo+Ef?=
 =?us-ascii?Q?3i31/nrC1TwvQaUAhqk0a1dtOLhVIq1/PUTMQJIZVR242bLTi1bPe93Ll9rE?=
 =?us-ascii?Q?42eam75NH2aio9rRC2QDcxBYb8cdBZ0JsS9vGb5chcBN0QfLeOX0CZQ46jyn?=
 =?us-ascii?Q?SgunHgK9OnfwMkW5Spnqh81GGiY8hQqCVPxIsG2HrugwH+k0tMf9anNyAqof?=
 =?us-ascii?Q?TpCybIM31CwZmot4ullWiHyYizXHTwqsPAloTzAzzrIKn29w9HjdZC+QfIv/?=
 =?us-ascii?Q?uIGgiqmMfnIeaNGxLSRG3siC/gme65/ikYU7o+aoaPCcb9qNBtOi4PJuOz+M?=
 =?us-ascii?Q?MRZdNG41ngb/a2YBdBTJ8ofch5f2UlAgSfwd2VzrM/2WGd72aqjsTCkCzKoW?=
 =?us-ascii?Q?vxdEgC2TFYyPhSDp8WkItrGE93cHB0hw1R3jPozjBs2HFTI7q36DtHHyasek?=
 =?us-ascii?Q?zlQ6tgRsIZmlyY9iUkWBakmrq4Dhe0Uo1sKSOIBx7nlHSrnCOOT3bpa5o4SL?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024ba718-b69d-47ca-dc25-08db4f9a0c82
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 07:58:45.8769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2UKVcoNT9D+eXIG6I8Sy/vEnrBROyg/0GK+djT2nEZNmCFl+h9QAh17UoyY1Fc3qQYIqmwlJktCGYWPbO+Pm2zy76JawNFYeS3o6qDPD6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8821
X-Proofpoint-GUID: o9KngwlqifAhUNGrQviQ-ATo-O8S3D8m
X-Proofpoint-ORIG-GUID: o9KngwlqifAhUNGrQviQ-ATo-O8S3D8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_05,2023-05-05_01,2023-02-09_01
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

Commit 7ffb8e317bae ("audit: we don't need to
__set_current_state(TASK_RUNNING)") accidentally moved queue full check
before add_wait_queue_exclusive() which introduced the following race:

    CPU1                           CPU2
  ========                       ========
  (in audit_log_start())         (in kauditd_thread())

  queue is full
                                 wake_up(&audit_backlog_wait)
                                 wait_event_freezable()
  add_wait_queue_exclusive()
  ...
  schedule_timeout()

Once this happens, both audit_log_start() and kauditd_thread() can cause
deadlock for up to backlog_wait_time waiting for each other. To prevent
the race, this patch adds queue full check after
prepare_to_wait_exclusive().

This patchset consists of the following parts:

Patch 1-3: Refactorings and a small fix preferable for deadlock fix
Patch 4: Actual deadlock fix

Eiichi Tsukata (4):
  audit: refactor queue full checks
  audit: account backlog waiting time in audit_receive()
  audit: convert DECLARE_WAITQUEUE to DEFINE_WAIT
  audit: check if queue is full after prepare_to_wait_exclusive()

 kernel/audit.c | 71 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

-- 
2.40.0

