Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAAB74801A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGEIun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGEIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:50:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0419B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv8tWCWaD/YroYs4+T83EJtzraTeTgB2JgsUwpHM/mvWfJq7VMHoCIQJnQ7KU7rvlNnjl4depi1aFCeFOPh/Cn6jPAZYGfqdODv/0v6/xcckGGdnPmckIsXd7qzspffGVUvQjAbqp4Pjro+5EJuwfzTznajjNIadPTrvCDTvUlZc5OQfAINL9PCaESGsakqYxQeLPdkIPgJS54mlRDaDjxxbqnMG6j8jsXMZUHPkaY3KHd6nwz95c+R0SEAV0qAzldQHlBnyYmU6JEJu/RbslIZS1dTvJoh2nDmB9LJAIRASTe/W1vUGmhQ+ps4nhXZp+AkC3H/DTlw/qlvwESyrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbB2tjvqEux+nu8pBQzW3kjEnTTtIsGYIQMBFJI/9rA=;
 b=AUOjZsw3e7NEqP0A6FOrfhfqhli7Tx9YkB/FDChPuzFxIfSkqjRtKn1bRIUtfd3rhzvNggr+SUBs4u5qR7tmsw1J9ZSMIs6ENg5CMcna+ewLKLZ/7AjfulOnH+VfU8ciUHILTdJBb0Odtp1GhJkHNJgzhksrquBVRzlUmVxgRjk7lFjsyCxF6rNYp2Uww9pO0KJa3S6O/a3JJVCo1tZMVvSjcze8RoNKtemuigGwFkq7brveJJnZquwImEvy4to60kNHQoravUqwsTqPIfnVp0NyQ4S5drKNt+KPFmYRu9fsleLmEDFkUVV7KfVjgemwQ8j0SmN1NwKulDSJ76HDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbB2tjvqEux+nu8pBQzW3kjEnTTtIsGYIQMBFJI/9rA=;
 b=Zax5rl5XKB7Ou7KXpRDHaOeSVDqEVz5YOKFo073nA/vApmvZh0KZJx90KVxHz0s2Z631xOto+l2keq2Aqux44TlXaAH+atUQcsIPmFzmdZSdQXoyPEDxhFwvmuy5On3dPd42EdfjTDWfOcDrrBLJx/Y/NznPZffIFyQVY/CnVzJ4LnKRH0jc5IWsUgIA4qRk1zGdB70zljWEgW0wn433y1t/uFHGkLfDW4fKj3coYFu1Bz2yL+Kf+4gsooLuF+iW4paYcOTRXtSgzo+xBN4rkNPnyiDxkLfyNGmT9pJUvpXSSO7DOivKCZw7eHpPzQRZT7EDRWj/oM6VKAUZ+ly7fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6282.apcprd06.prod.outlook.com (2603:1096:400:429::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:50:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:50:33 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Minjie Du <duminjie@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] sound: seq: check struct system assignment problem
Date:   Wed,  5 Jul 2023 16:50:22 +0800
Message-Id: <20230705085022.13078-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 936f4a2a-be03-43d3-1b95-08db7d34e433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwwAmz1DhFf1Mf77YxI401WFqDTjS6Tn41vNatxyhsbngTXulL5Noj9sCKePLyctX7ajIXCjlQ5dZcJR9Xhqu31tO/mY/diqcWsfjMjB2BS1xTWqrJ1pPyY7gNFnJ+nL6YWyXykulbY8yDt63G76wm4wQeVHPCeGuz1F7jE185q/xoOMcGLIUIGT87DWxRDQUVyJbQz03OSL9aMDsYV77QAYnT7FXE/Ld9hxlicu1FkqJJD3G5neHaxvJiD38a3enDJ0kOKgdQK0/3N5dPW6UpwHpBlon4bP/0tE6h3O4bLHEhQj5+6MdINMuIbPy0Ks6k6xqEA+CfCgi3q1q0pu1hQwLQMcd5pvTIzRYjOLz4ZZCxDZr6VsAiovDJzc10Xt1+zSkWizOAnMgEjMtN09MLUCJV4r3pcgjiq5eEmDeUMZkKqaBMTEZGMKs15/JEE7+cV9E9dU7P3D3tcNR7z5p++WL0ibLgxiGUIeiDvcccW6Wbo7mafAGILMKydvRNujrRNKlbS7v42cgT/t/BDygm/+17XDieZF7iqr1axFYm6fwAWNROliQf5aGlWPlwzwy+tXyLxLsBV3EsOiMSymsGLLpTd4aQqh/rUg5SlEEFsGHhGZEHFm8QcJOvRoThF3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(66476007)(4326008)(66556008)(66946007)(2616005)(38350700002)(38100700002)(107886003)(186003)(86362001)(6506007)(26005)(1076003)(83380400001)(6666004)(478600001)(6512007)(52116002)(6486002)(110136005)(36756003)(4744005)(41300700001)(8936002)(8676002)(2906002)(5660300002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4XMqQH3AN5/wZ7ALvzPv4v5PjcYXJXeYHtl7MecLDDhnGDxYRKZ/X5Dd5t4A?=
 =?us-ascii?Q?gDPcsY44bJl+ljLSm/9kJ1UDqHFvFu+oeo3MEPRtSeCSUeiYcF0VdEr5hFHF?=
 =?us-ascii?Q?znOYoh27S0LZvAvdXZqsGoLFYHi4z+mffPnEJ4zkR3AF/RroukEujgN6ULuS?=
 =?us-ascii?Q?Nfj46HFZI8ocbo8hy3SbzRbsfflKYUxrEyu8kEujdqTLG+/L2IKr/TkBajA1?=
 =?us-ascii?Q?fgkd1sKWEJO5SUU2iC4hHCkt9SwkiepivEjZj4Z+72nhKA9bxY8VVkh62UIy?=
 =?us-ascii?Q?34Gp6V5Xi9rcwBsxdRDsgIYVzOvDJyITttF3sV0xb6JsJHAEb1l5N8HEe//J?=
 =?us-ascii?Q?snuXR51g1ZDLWNyW7fzJRF7QqtwJ2vt1JmOZ1GO91EsG4v3tKOgUUSCy6MSS?=
 =?us-ascii?Q?uFjPbYF4gxL9zYRNMe1hv3HjWBTU8H/eqLeVrjzYrC2t2e1O0APGamdZQlEO?=
 =?us-ascii?Q?bRp6MszHy4TAITOYDXDa8wp0qCER3Ja3xf3k79pifsMUQOhm1qK5wwq1jLlZ?=
 =?us-ascii?Q?T3bpMQaNr0pSGpybVKuzJlAz3mmL7/n2Vb5nAo9e5ciY2pIKS+0IDkqDAtn3?=
 =?us-ascii?Q?Dm53+0VnzoP83hQGLkx0SErKsm8Z5aEiShM5DRxaoJaryKRJjAtR6vZH/e4f?=
 =?us-ascii?Q?dlHr2BbiUTEn3kWX0raUEPh1XEIUkveDeadO3dPXUT/UrjfnTbb2lgUmAqWD?=
 =?us-ascii?Q?93gdKdF1wcPykd/SWt8T+iEWqe4WdH1r6lxARIAEOYTolPm5wLiz16pupAyO?=
 =?us-ascii?Q?NJHvmnjXt0MIkinGQTVCECfl/FbxkHp051YwSPftLrbQdYl+x676kMHHJMRk?=
 =?us-ascii?Q?11Qrw48mygNzLkhajsuWe4q//4PjhtFt+8JBYZyFfsppI9z+8ZnyWyodraKx?=
 =?us-ascii?Q?D+fHkky6nauT5xW7wmNz4cDU1i1g5td0RSbBWBOwl2rJwNdyKFfOKF4OTNLJ?=
 =?us-ascii?Q?e55zOOuvGmccEmrIJ+asxBHPOvYu8kmfgbkTl0IDscbQg4A2i2DIbaCUwor7?=
 =?us-ascii?Q?7wIqclhoWZ7xnrLlooDhfrHnOejliwsw9S3WlgUzqwzCD3Yy/6W5zDrRz8sS?=
 =?us-ascii?Q?rJhdYVIExB51zj1WiwEKztJqVUcCxGy3pwJN75dw/4kfhHzSKft9g9h4F/83?=
 =?us-ascii?Q?Tz/dl1BrFTPiU/nUWwyuFCBsm9tA2C2zqZQ/GoMLtJ8uYXAZfdPrqGkSBQyw?=
 =?us-ascii?Q?+NvjR/hVSqhovqsYlhAmPCYGSeyUQRMMjTzs1x4p3TlrIQ3TlqK0B1UiMmh0?=
 =?us-ascii?Q?uRDREB5bVw0ikZ15tMHsQh5WeFPHryClLbxPnSE/DTBKTartpQeJRplP5dhi?=
 =?us-ascii?Q?QONy1hoknZOZUDQk/g46gDvn2yERFkTRagzk/bHfwynaLmEAmYPf2j64w/6g?=
 =?us-ascii?Q?77nsBi4kHulRy4UBNiGOPL+OKP8pS/yXznjrKJojAmdZpveSHnrAlKXUn0jd?=
 =?us-ascii?Q?tplEk+SVpafLrn/p61xgD4VRuU3j+ptotWULvazUkV5JO1lcoNp7Xe3BwgbL?=
 =?us-ascii?Q?1voP/0sWdhhK+YZY3QQPe5U4II8Fjbm8L9DN5+dgX9JoJoSkLRk4h/Q66SLj?=
 =?us-ascii?Q?zRNOYp8WA751A7GtF6+6assb/ixf31pHfMMZHHyP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936f4a2a-be03-43d3-1b95-08db7d34e433
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:50:32.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kk7atITCcsRTWHqhBWYo5qzf6CndMPUQjsEGmJQzBykyUoB2H+B9RaZ70Czvp+raB7E9t05q1f3QxMwynxu8Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6282
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make data->system.parm1 avoid double assignment.
but note writes "RT message with two parameters to UMP"
is one of assignment is for system.parm2?
I'm not sure, Could you help check it out?
Thank you!


Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 sound/core/seq/seq_ump_convert.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index eb1d86ff6..60e637149 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -713,7 +713,6 @@ static int system_2p_ev_to_ump_midi1(const struct snd_seq_event *event,
 				     unsigned char status)
 {
 	data->system.status = status;
-	data->system.parm1 = (event->data.control.value >> 7) & 0x7f;
 	data->system.parm1 = event->data.control.value & 0x7f;
 	return 1;
 }
-- 
2.39.0

