Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B985E7318
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIWEtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIWEts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:49:48 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56793640C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 21:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3DSprUDq/FqhEGE8l9h1jb5dyoN8hkoLehZvTwYg1pg4aWLJtVspxK3gBWf24NBeoJr+nvCdH3OvnahmhP+oQ3Ot5VDY1s/UFblsO9tKRRWGfnK/cTF00nbNrpsiuQS/NTzMdnm6E4aeEnR0Xwysp4FqQ7BRZTkb8hOjFXnlskTFpLY91gA+k+0IQ52SNk8n7CAVoVbVdi05KmbzHlTb1DHXGfkIIr9slG4TOGwaAFH4iKCR3v8oeT9xmL7g/T4U1MIOZfXJzeoYk7qqh4SDC5Df/M+tOkkf3C23Nr+6v6aISX537rRFHhwcGwmtB27uiiiDxjSXJyLdAQA6eNPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBPRynJ1sxucRyNYddjQKcSlM7ldZonFssf+yZqHvJs=;
 b=gOJf1+giXIffSgQi17z7u1JSAVJm5P0VxFq8B/Ts/Estj/hwFBfkE1KVtWwcEo/0GdIehXxl1XbfnJ0qkSpUsTCiA3aKvKLXLvOM8sq/f6ZYM9QwLKeRM2PnzqAl0xtZ/LncWbiIG5PVv+Z8rFZlvbU4uYUyPF9/ZYJLgOHH8xU+JPODKV6b1Vx6lqZeAXMY7qFWJGogo/DcTzcUqr42lfw5v3lX1Y1zVWDculVr6pC+cM+UfUFmMQHCQ23no63M+KvptdvRPqUiAK1Mr60/OPo/7grtiis4fRWDObrInmJtnbxYWc4KDM2aSWXPydVoFa3EgGfIQ2fFFroDwqXu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBPRynJ1sxucRyNYddjQKcSlM7ldZonFssf+yZqHvJs=;
 b=ct/+NL7szUX8CqQXcGRIVYaKSZ6JRKOJJXMSZCAU+VJ/UR7RGegWmektryLpY72IQ2IP9YOavkb0XCf4d5TiTV2KZmE6GZfuYsag8dskPB2MMgK8zHlkKks2nbEPPuCJpddRIuTr3SF+bILxGlmxmsoTSOkXCW9FUBz6BNiStNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BY5PR21MB1492.namprd21.prod.outlook.com (2603:10b6:a03:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 04:49:45 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::aa88:3e78:5589:a6dd]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::aa88:3e78:5589:a6dd%9]) with mapi id 15.20.5676.009; Fri, 23 Sep 2022
 04:49:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices
Date:   Thu, 22 Sep 2022 21:49:09 -0700
Message-Id: <1663908549-118490-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:303:2b::25) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|BY5PR21MB1492:EE_
X-MS-Office365-Filtering-Correlation-Id: 613bf13d-172c-4adb-ddaf-08da9d1f08c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzA6nH6djqjn+sXVPALkFCF3Yy7JApNp8qpO4SlA6e1DtKKxegmNOde0QlnHxFL3wM0JYYOT55bnoKqkpO3EmjM0qOZU/FIInfocSLXH34CIiji2WXuKQvQor9yYsCuyOOvQ/loprGn6fkqrwcOgx62kyfHH9HrLKY+3lODiVQJVgm59dp4Uizl8d24OOPcaYVxCDd4h4x/FxWLMVPaXnR0lpg6XK2TfYo6NWUhiQWwrM59Qk7fssZu0AwU58NXWP4OAed8C8bUu7BsLObgtY7fZEBb+QuRIRmtSaVyzpLLQ+WGuBpb1nfJGXOH5pA+nTrLbevbg1wslp3nNZQXxoDGiuwKZyfPErv04eyy5jAbI4XUDkRHI0ii/XcU5cBZ3WHlUCAqb7VGDAcobCGsLFUDDl6PZZ5r014xaoGb9sjvS+fFmS2dDS63vhwc4iFhuNiP5RQ1IPTo9EjiB+/sEo8GoDIxZW83hbyvTQ9OHaM1OUCD5ANCDcLDAzK1oerCV0P3RFTYglWAox266oqTlhqM4fuO/+SXyG06DIVRhvVn+UB8gaym7pzjySGkzBV3Y9piE53e9nfS/lb3XN9ek1b9s6/c650IKQxmaEuNjAB7Oggm6hIbuRdAFYD4BQwdTVA93gPXURaYUFNLQUpDyaBgzk/LIR6O8M04bCv0sNRdvWHKz+MI0G56EPLBIMvGPOO6Nluphip3dr4GE9sY/PhHli6UjZbS9ItGm4FNOcPaA7yVipw+0W+UoiqDusxxX5o+GdyUwIINuegS6QKeXj65HuiyQXZ7NIgzw5WVu3qB6S1pvb3INd+bgk9FUSsXK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36756003)(82950400001)(86362001)(82960400001)(38100700002)(38350700002)(5660300002)(83380400001)(2906002)(6666004)(6512007)(52116002)(6506007)(107886003)(186003)(2616005)(26005)(316002)(66556008)(8676002)(41300700001)(66946007)(4326008)(8936002)(6486002)(478600001)(66476007)(10290500003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rd3G2953rbYqfYVLW0HPoOKcDYiFaEISVfTty2kCVadUa1OlL02Jm7MiVPpm?=
 =?us-ascii?Q?F7cVvWOS0ec1dajOqWG2PTZ3PAV6b0I1cGXvQQ5GHA4au4f5pH3aRAsm6+ci?=
 =?us-ascii?Q?f1YhcIy+aPy0m+B8jp5o5XlsJRVapt4KSLBs432do5P5hDj9SuIpXguimnEm?=
 =?us-ascii?Q?IqM1p4QsaxYRYqWhoHmHRs09e6R/dWjryX/1EXXZh/1wloo9UcaJpseIwdLC?=
 =?us-ascii?Q?kAknCGWl8ewIzwrksgtAP3epvvxRlPxgDGe9YlluX1KPnbwlxOuEezbxlBQA?=
 =?us-ascii?Q?DHrg4aVVgc0f5nN9nK3GwBwuo85FzEARTNehSYROBe1s160M0MoWVGCD2lji?=
 =?us-ascii?Q?vNWr9zeuT/JjtymAhGhkQItAh1FPjzbSRWRWmdyH8ogWKz7kAzra47P3iHcp?=
 =?us-ascii?Q?MIzSTWHxccRhhGvapFP+dXFMS9xVgV85Nctu4vrcpdsUGJLQa0fqDRQok4Dl?=
 =?us-ascii?Q?HKdKf0/xP4waSofocS0NP5LYH1BJsJpgvtyfRS2qBm6RW4Lo9NaSSLkAZwEM?=
 =?us-ascii?Q?SFmRBZ0WOu9MGe8R4zfIYJu+4ZCZ2jqGajB/MEOqLNQGKLdhiZuOjnkFWjvK?=
 =?us-ascii?Q?9eax1psUfV/0TyiQpKhnDyvMYKYhmwdyTIYbJ8pusXt4afQA4vrqkh5VzF0+?=
 =?us-ascii?Q?V6uIo5pl8yZNihJaNTM1MtKTa6PsF+c0eWzJbPTNXxqHm83kLxrj7MsZJsKJ?=
 =?us-ascii?Q?BCd0mnWoYV0aTxrAX5JHYjd6Z6yYdN5/mNXS0gZAH50vmkDpMyvlKMmav4rB?=
 =?us-ascii?Q?hCWlolAHMSXv5hyJgGajl2xqrS5zUpAqkj3biNiLOCH29niH03eTY9Lyq+R0?=
 =?us-ascii?Q?zbaqH/TxsVN+axLDDEbTIaIWPWa7THTD29Fq7M6qPMZ0Z+gSrqzctA7arLfx?=
 =?us-ascii?Q?TFSWmuKZp8EutPsn0HpYPkoJevfGinFTZrVz8PHE9MFkf9zoPUkGs+RBM0qu?=
 =?us-ascii?Q?H5cHfq+/5VolDbrgVrE/rT4h6sN2KY5T+As7kYzcZMxdsj8gW22grWTgz596?=
 =?us-ascii?Q?qTwa8NVyVZn/maqkSWozp42J4Re0kgE2hzxaYPzL0TqAOq0bR40kcI1EUPin?=
 =?us-ascii?Q?ftG5z/IAyxKPpL+JP8IeqNF6HtWkEA3JnC7e0h+1KaUYsfJvzGpNEHTfks+G?=
 =?us-ascii?Q?uA0hYWyW49dmZTqhzunR+iVKEFFeAUyt/EVrBiAlrucpDWF7logDAGUlnvqR?=
 =?us-ascii?Q?oP8iMkj9lT7Tr9nml0CmEevcINzSumh79v9LmR8CrNuB2x4LKix3M95doG8F?=
 =?us-ascii?Q?DyuQmeN8UANWgav6klsqcxsoTCLTHOL5fVgTH3jeyCHr3RG5FOAI8+ZUJ2vQ?=
 =?us-ascii?Q?n2OIaa35Ec6l8lLCqbZAEPzbsfPxZrcHJZdXx9qkC5PPYNMtfKzKY4T9VmN9?=
 =?us-ascii?Q?wAvwgb1mB2snzNsW38pVjw80IHW3AyAmN8J/RHgFZJEvvflzmD444ZunHsNO?=
 =?us-ascii?Q?Xm0WnJctnXIiaaMgsjUSW2KncJXkf/4QjGMcXnBDNzVogne6vWHeX3uro9ZV?=
 =?us-ascii?Q?fz6+vI+t59quoG2FsJ9Pp6ljQa5idjA0IhdHnG2J7qH2gyVdR3iLrpJeBFw/?=
 =?us-ascii?Q?U8G8DQ7XaMEn5iGwlWdXJdyOkRcOajF8KdeUEpll?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613bf13d-172c-4adb-ddaf-08da9d1f08c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 04:49:44.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZyR69cy8w8tK2efIU3opdDqFoIQF2Inb3HOQciDmgYg/EpIoAXI81Y+lwuQY7edmRisnspdExOFMAo/Ay1klg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1492
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOC_PR_CLEAR and IOC_PR_RELEASE ioctls are
non-functional on NVMe devices because the nvme_pr_clear()
and nvme_pr_release() functions set the IEKEY field incorrectly.
The IEKEY field should be set only when the key is zero (i.e,
not specified).  The current code does it backwards.

Furthermore, the NVMe spec describes the persistent
reservation "clear" function as an option on the reservation
release command. The current implementation of nvme_pr_clear()
erroneously uses the reservation register command.

Fix these errors. Note that NVMe version 1.3 and later specify
that setting the IEKEY field will return an error of Invalid
Field in Command.  The fix will set IEKEY when the key is zero,
which is appropriate as these ioctls consider a zero key to
be "unspecified", and the intention of the spec change is
to require a valid key.

Tested on a version 1.4 PCI NVMe device in an Azure VM.

Fixes: 1673f1f08c88 ("nvme: move block_device_operations and ns/ctrl freeing to common code")
Fixes: 1d277a637a71 ("NVMe: Add persistent reservation ops")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0038283..45ef8e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2162,14 +2162,14 @@ static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
 
 static int nvme_pr_clear(struct block_device *bdev, u64 key)
 {
-	u32 cdw10 = 1 | (key ? 1 << 3 : 0);
+	u32 cdw10 = 1 | (key ? 0 : 1 << 3);
 
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_register);
+	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
 }
 
 static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
 {
-	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 1 << 3 : 0);
+	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 0 : 1 << 3);
 
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
 }
-- 
1.8.3.1

