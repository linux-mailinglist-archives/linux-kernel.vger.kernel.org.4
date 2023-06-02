Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4C71FB12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjFBHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjFBHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:35:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F121DE59
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcdhgBgm0O2Q3MfBfV8dHnQ+JcoxPjNtyjfC4O3wBu8pRg4WQVEQxYrgEujPBAonATLxfjdY4hPD9Xq97GOEP9s+Y4jJault27kIUz19POrj4IG930G32xiDljLbaZXnCK9hIT11Noeyxan18hkWhej9dhSRDr6e2f0cFjHPvar8tMUVSYN+gmOFpxC/vCqrL2PNDCXjYNdSiIBSGmyKwuQAUhRlLDf7vYOTYHyERUxdytjCSLPXE74Nol6dUpenafL5cIAECZFL9gqM5J6Gc1heJVDxNRg3Xx66Z2dbapcuDq1ytQVcaUk04RzJ7/chZ3xncHolXfIJmtLbHzHPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJDDIycSYQNtqsGjKqbve7Qjv+/XqdfhAEOPWQ9n1Uc=;
 b=U3luT4T2nL6dTyFayoVK6eJB7yvSPpPLaf3uJsOsa0rsLMkI0RekGdD9P2gGtSuWRtas4E9cJLyw9FZXNPbTV+xxDX0XRbydP3gw1fo9p+mBIfdioulpfQ4Cf4Z6JtE0Lv1mrunf6o8MK/UdZPLRPLgTKUh4tSzRBMopw8XwgktVxMqMpmqD8Of/DQuA8tEQaE6Iz0rPybSFuPzskHRw0ZTnEdhtqpSOALHbZAIgcwfKkFyzAZWvYuy95KVAfSPyo8sUzZO//YbPiF6BpPoMEL/5QZCRLupnePyNZODSXDZ3Rib3nsPo6PHwF5INNFvN7r5RRKDCW0/4y3t1HsqDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJDDIycSYQNtqsGjKqbve7Qjv+/XqdfhAEOPWQ9n1Uc=;
 b=rZ1LD76hB5luXn/nOqbfgPAVBwfQU5nrfQK4sS7jlP6OZArqEnHAiXlBn/IQPS2lzCJEvz240x8RLTgSTs/lbKvEl1jQ3vK1OFQW6mRKB2fAfwQjwH0orhkww9cgdlJxT0qOjXmcWgPl57x7Ep3CZ3d05jpvB8YyRsu0aiEnwmt++WyOULX7C1uZZUbEh0h6A9xH8x990vrbItI7FhjmGXZQ6iA2W7CtEp7Vf9G9G0xtTbKTvB54ifEuPnPmhv979J4jl8nuATfVg/SqXKB0opHvr6lrnsZL0fzXD4FCfC0Rwbd/kQ17JVPDd/lHX4tJ+OXdklcAEw9OxsV7MtOsRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TYZPR06MB5201.apcprd06.prod.outlook.com (2603:1096:400:1f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 07:35:07 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::60d6:4281:7511:78f7]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::60d6:4281:7511:78f7%7]) with mapi id 15.20.6433.018; Fri, 2 Jun 2023
 07:35:07 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] vp_vdpa: Check queue number of vdpa device from add_config
Date:   Fri,  2 Jun 2023 15:34:42 +0800
Message-Id: <20230602073442.1765-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|TYZPR06MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 34125a4f-f00e-49ba-1e76-08db633be314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZQihxrGS4lXNOg56hbBwlBzJDAfXoWxTWmNv62PMuN31dKl9ZcPDH9qCopAV3wiMqx5EzsDin/Tfi8n88Rwo8Kk12gUe2nI3HVPEwNVOiKxDd32QuZktS5oWkpw+Hu3g6FDGs1fByvQt9PCVqliI1qfLd2dlvpwfNhtDUpA1nheHlbaZonrRMNjgpf/oja1JDo+XKZC9aLXr5R6nQTS1R2h+yitXKJkLXan/5BFnzh8cgvBGv/BTY3/3c1/p9Kc9WlrgHpVoV/A06dA3/9bbSYcogXstSba9BF9SwNn12wNbb2+dYmUsbd5k4IOt6y7hoocmKnlA1r1Mx966OeqNQTsyg6aWegXJwXg4YkvZPVEQ3fkoo6I4cB1UuvWfFeF1F6efhTmjsTf2Zg5fqTrnEimXr9X3polJ/B7z6uHveHLyTmchFmIsjR5ZNJoMmcp2d5enYYIOczFTG0OP+1G2Ik77GwtThQL73XTlmSIsDh/2lQuan3L5oxAmWdY7w1cldGcYsirHEytJV6A95MPuZyyrg9rY9kZnCUPv3msEWrv5ayCn+rAo3qkQfXfsrVVtc8LhDQJnrOnb/QorQ6X3oGmPJOmhyUkKlgWo+JDUt/QL6vEQ2yr3LVZZA1TclnM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39830400003)(366004)(136003)(376002)(451199021)(478600001)(41300700001)(5660300002)(8936002)(8676002)(6486002)(52116002)(26005)(6506007)(66556008)(6512007)(1076003)(107886003)(44832011)(66946007)(66476007)(6666004)(4326008)(316002)(186003)(2616005)(2906002)(83380400001)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17Xq0hD7jmha7dD6RgJJRorCilkd6kbGnF1ZmGOyQ3dnNlX9MzAkjofjfrvY?=
 =?us-ascii?Q?WgK3TOoUfRxYwhXUGEqLInV7QcfedP/aQ32IF6cskFUPAI2du2Qz9UgmtvBF?=
 =?us-ascii?Q?xXJgCwMEie06eKcVVorUBTBLoelUzRl0vy2yB9lo+O20mKkA1fFEr/4ZKde0?=
 =?us-ascii?Q?ZC2p48IuRJFENHbXgLw/F2xmalTkqeiJlwp0Evr2QpxBeGo04ePgo/n2CS3R?=
 =?us-ascii?Q?wx814Tk0EEWpHmw8N+qFRDnKWVGAF8A7SZ3FNfMrwqHQkDgX5wd9VHvJr2xC?=
 =?us-ascii?Q?61kyma54vWhgC0AGaZIqgY8+PY7ejIO/iL7yRAec7xAqPwsFg2z7V275pHaZ?=
 =?us-ascii?Q?RVmguKrLfq8IeLRss+NgHUEk09xlSAMR9u6FINkP9HgXNcD6p05AIUiH45pu?=
 =?us-ascii?Q?1JyPJnzu+IBWhfFjskGdGh1HYlgtFqniGES/VQvPf3UVr+Fnb5m00px2UNXx?=
 =?us-ascii?Q?he8Vo+h1oL4TSROA96ZDE031ojiZWo9l4zzSpIQbLXa3MgahoXJ+/BN00OWm?=
 =?us-ascii?Q?21pZau3XCSYjJQFpLjxf6mzcgDc7T/oM0YVTKAwbKIKradVxNRBRcJI4ny+K?=
 =?us-ascii?Q?BO5axmi6tiGk9bgklEEnYGsT3i8RF4zt4qhTKR/+V+3QJ1cqxZ0yRePjeIZI?=
 =?us-ascii?Q?Pl16YF49Oa/nQaN6HgTWU2kY2MAiaUFgD/vHVnpPI3jhIOmbnLo8plp+BTZ5?=
 =?us-ascii?Q?s7C9Gk56WuieKslNw3sI5/uJIA3BeY8RSqrpXWBuO1HY6LH610GrehhrfJTj?=
 =?us-ascii?Q?yASjUaYb7w4nbSBgJzRLWmJGVVlsLv1kSdSXLIJts5pPYibDGn0+pyzD4Ulx?=
 =?us-ascii?Q?GYoNVCRMBEgC951g/YvuF5F21VhdqhSnKHAp4kk+NL3SCXgu2mwl6w9dedU+?=
 =?us-ascii?Q?LTZmdhduyEEhYgAJoSd4RX1OzIXnbiBCzzOgGSibV+BljvYaMV0WfKamqt7z?=
 =?us-ascii?Q?410TTa2J+BZgz575i+YydkjDH/IZx/K2BbL8O+JTY/Ms1MuCht9Ns+GjC3LG?=
 =?us-ascii?Q?AoKNCgENKT7//4pVvfd0GXYG4wxBWzX88Lvpa3xmE6nn9NCkNIsVDPLLhZU1?=
 =?us-ascii?Q?xJQUbcoTCQRYdsgO28mpsI31pAFeAFL8UjTqqZjU7tsukuQHpA4DFiVxk1cE?=
 =?us-ascii?Q?ErkO9LbdbeJkJzIClVfiWhso425P+9zdjaC9bVEw5/IekUA2QCQpo3vjq3Kk?=
 =?us-ascii?Q?daNGVHy0Xl71wwlBdAlPcr3vhc01WddGR+Bv6Zw4SvStMCqDZT4b1aOHc/pD?=
 =?us-ascii?Q?/ylBoHaKYa8DwAJOjxID2E17+wq2wwXIk6n1ufoO1K3V8C+Jk6XEkorecPbz?=
 =?us-ascii?Q?LSoNmitC4oNePHLEpG0plhvgOtdPTW1pPTenrhrdNUpDDKqrYfzGR1h9g1ya?=
 =?us-ascii?Q?4yfECJ66rRB+AldpV5Vy+HDp9/Jrb5en0mvcO/bHq5SLsSb6QOqMwpabv0+h?=
 =?us-ascii?Q?DCdM6jbU7oV01YozMQ/N3zRTQETT7Bxz2DMSLMIDkj6BbLAz0wA+P+0kFBzz?=
 =?us-ascii?Q?26Ncox3Gmogkmpu8esWKRbLoMsashvJn0SZOWvmiZbN/ryuRPXA6We7mwznT?=
 =?us-ascii?Q?yBi5miilA7rOUu12sXssJOrSQiAnw2PwDozXA1iluYCaV1VP8c0MchDxYVyh?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34125a4f-f00e-49ba-1e76-08db633be314
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 07:35:07.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2NI82gHSSbU5UY3gzrejJe8CBlAkZfYLTM/UHfhlj0GJOlgUXrsQkC8/EOnWjfi9PnEgBgy1ff09AmO9FLg6nEq/cu4JLfuuReAJn54VRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When add virtio_pci vdpa device,check the vqs number of device cap
and max_vq_pairs from add_config.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..4bf1ab637d32 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -478,7 +478,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	struct device *dev = &pdev->dev;
 	struct vp_vdpa *vp_vdpa = NULL;
 	u64 device_features;
-	int ret, i;
+	int ret, i, queues;
 
 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
 				    dev, &vp_vdpa_ops, 1, 1, name, false);
@@ -491,7 +491,14 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
 
 	vp_vdpa->vdpa.dma_dev = &pdev->dev;
-	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
+	queues = vp_modern_get_num_queues(mdev);
+	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
+		if (add_config->net.max_vq_pairs > queues / 2)
+			return -EINVAL;
+		queues = min_t(u32, queues, 2 * add_config->net.max_vq_pairs);
+	}
+
+	vp_vdpa->queues = queues;
 	vp_vdpa->mdev = mdev;
 
 	device_features = vp_modern_get_features(mdev);
-- 
2.25.1

