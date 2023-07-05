Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3A748241
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjGEKge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGEKgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:36:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B8DD;
        Wed,  5 Jul 2023 03:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EawKUI2wDF0s/rkz+Q37G7SgZexPTRH8/D/53NVA2TnkckHNky+kumxjtRzJ8tANaYNERTgyoyb3GaH/BW7+JW05ld7sw75TUGsLgijibiQf3/zK1T7vN/EbwDmBRnGYTZKW2Ex9/29I6rWqgxRUY79hS733vqZ6r/YbUO6BEuYRbYvgxDZJaBf3mJ2ydJGx9sLxgRZdN6Mp/G7djEOn72ws9LNpXXZnTi3mMPxNB7E6T6eSwfIO8oWgJL7qCCQtHO3nQ5PPg/zjAyCYz2gKOcREwBXzzPVkAC0ExtIUgyIRTkRjXYxhgMz+d852haBgfp2mk1t20pZmdJG0OSyfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZFg8q3ajWVrs9UEYy4kTEEdFVbMqkr0P0XEQtGAKZc=;
 b=Kzpo2YTsDqfiTyER25KmYwnplS90QLNojCa7JOJ6P/jZ3d55rcjUwaf9g7xWKOiPa7G9Vp3SagVmRvS42TQ7vRCi/CcF/qdtfV+YGvxPH7WwHMkQd9GaLsy62R2iF/42XscPm25iypwLzN/BjUrQfJHXrB81+pafSTZ2t4SDCnYxF24tzzTE439LkqB1/Y9nc4nu706T05iJ++xDRVsxighpOGscoUMvcwxOv5vr+hGY8Ip/jzXfAzFQAYC96a8cH/8zzOe/jvibPt4+3gehKttgdx6WSsXS4bQSxx/HEQ+q5qVPvIFE7RZTnRhBo9SDMVy3Z5QrJIk/egWBCGllRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZFg8q3ajWVrs9UEYy4kTEEdFVbMqkr0P0XEQtGAKZc=;
 b=HMl4pvRlm/RsWSaMb3zr8gfOWlRhY6eVW8/SuWbPC4kS0eOgLqPf2PAa3Wqz4m/nfFqaPwASsy/VraDnHFhgriW2XP1sFSSNNd4vit7dC9fN73of/D7PDnUKDGRQzW3WQf8xQmkGnEIyMTEb5M9ya+qmGR+7ciK+T6W7DPqoFeE/AK2O0WqGJwaZCJ2VVZLrNchekjH/J8BC1ZxAEJ51FCoIKO6/4A7r+O9ST9e5nuE/yUgLhV0W9hO1upO+DilZhru9Wbrv5qrOAc29YQ/tVDCDzg3Lo3M9EYYd7HgAQJoDHverI8oPV5tTnYj0RgBwbOYfpcPb+XX1hXnKB/Y6PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 PUZPR06MB6145.apcprd06.prod.outlook.com (2603:1096:301:11a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 10:36:27 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 10:36:27 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Markus.Elfring@web.de, Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:QLOGIC QL4xxx ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] qed: Remove a duplicate assignment in qed_rdma_create_srq()
Date:   Wed,  5 Jul 2023 18:35:46 +0800
Message-Id: <20230705103547.15072-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|PUZPR06MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7acd91-616d-4d55-872d-08db7d43aff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFOroHnWvPAY0QyySoVtMqoGGH4XZnhJV5xdd2UOpKx/DkbKm53lAgD59CGDFFvBWy6I9DwbWDB2P05brvdEfvhnio9ITyTFA/nl9dPT1XjEtBCNhkPq11fZhMaGJj37pv+77gYLkRdL8I3aclfzinkgsTvpR3h+Bme9KYE7e14Koor3aeAGcSgILMw6/GuLBSnI3/56mGj/XHeoKs/5KioMVqfnzJE75160GhoJgVhhiB+yfABaikTWDT/UK2pXAAcnRhMh98KbVmVTyi7SWtAq+hkKvh+wUxs8AY92Lt4XBANx1L+/cK46742JIs+eHdJnzmiqn5jnBmKoZ3OdL/OaeIc8KM158vFweeZDD+63dxHEp/RviHjbxrg5HeU+pY/mDCGqRXPGrsj+3cCXtRHBjKNkDk6ywrkATZmyiAOuD06lsZebl2dvwIQQiEN6guVM3uirxP46fcqkJx5eSvsSgzhg/w5FSBf4oPKV5AlceaYVWsz4uHU1Y7pmHzE/lUbEQPXEa7cW3d6KEm9TfZ/+1BoxGJhY8rI+KPv4nUdGb+L0QMcLBz8HkCRmFKsBBFRIWmIpCiLL44Ajwcmebqz2XwaT2k+ZXrypzyi0WSJWjrg+UTztk5wKa8Ge8tYF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(2906002)(8676002)(2616005)(86362001)(8936002)(5660300002)(6506007)(6666004)(110136005)(1076003)(26005)(478600001)(6486002)(107886003)(52116002)(186003)(6512007)(4744005)(38100700002)(38350700002)(83380400001)(4326008)(316002)(66556008)(66946007)(36756003)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNPOn14lbzm47XahL8Ai5sa+pKwUaru9WJOkSjA/XREfeAwTICbBtO4GjTMe?=
 =?us-ascii?Q?PrXYlfoNBDmfeibPnZTEc2v6DVhT+QhC6ipS5of++kQL2DN6q5scJJXKJFpa?=
 =?us-ascii?Q?6y+nTlS7BSpuok+OrIeqK3BA+6Xs+K56yZZSV5WxWy4iFNnrqVbPyi34ZO+l?=
 =?us-ascii?Q?rWDSMkU81mO+9hQ2qtzqS8Sn3cgY86IHNDqvroEYzgyHnU6/kJQgzEyOSyni?=
 =?us-ascii?Q?7jsMGzpHQze7ecNEdxuZw+xyPpPAX8lI01dzUCCmgBgd+fevRsVF6hCfFq45?=
 =?us-ascii?Q?HYs0ck4Vxgblb2BKgUimE4S0ioHpz3lHa7g86NMqI8V1rhh1h3dgAUirhbao?=
 =?us-ascii?Q?qQlf+cJGFr1++2Y3xOvLL+hzigtqzvmYmDGzypUYh3bRSpybOAA5ZunBwbfx?=
 =?us-ascii?Q?QuKwYtq72pOQA4TW4Hf90iQtgVQXZKg9jo7zXD5YfedSkAFh4WT/dm8Q1H6a?=
 =?us-ascii?Q?aZtpMRIc282p/BNeXG8tW1NpYPJLsxQ6tBiY2dwzvqLgNmf13/bvisb/Oamb?=
 =?us-ascii?Q?V6JuI6+5rInlG3+U6aoMt8afPTEj4cupkJ7geQjbhY5EEPdzeVVoh6LZ1PvN?=
 =?us-ascii?Q?VLQnW+C0wCXYTVQdZ0EoYyjqQ0Jhkjm3GOizomSp44oeF0xEGMd4MF8sDSUH?=
 =?us-ascii?Q?+OekHqExW2nCT6hp4c4FHzImrTi1c9uJBSYkNwmxVuj2n8Rex3LwH5DuM50G?=
 =?us-ascii?Q?VWHKYhkXolGYjHAHqrrWpUNAR9hSwKEraDoVtXAZ5NlHJZm5BWfiAatZ4vEp?=
 =?us-ascii?Q?LIk8E8cPj9WWEDEgC0kSnHLgALar3bgGoMHG9udckNOCMRUl6Y3HTWafjGC2?=
 =?us-ascii?Q?2tShZu5C9X7ARR3GUht2pKbI5xDJVFUKnIV8IqFR4EtNvCEbLQWfrkdHrbdK?=
 =?us-ascii?Q?l742/v4i0O99JlJHnPdTY2kDyf8l7sqZxrNe/iMfkJMcTVTCPYVPiJmtXHGd?=
 =?us-ascii?Q?Wu+BWf0KUI6tbIU9zN3ipJghb2GEWF6EJ5Na/jX554n+F59coUTxGM/KyUPX?=
 =?us-ascii?Q?Aqk8TYJeX0Ub4EMhjHF3AMBRYt04RHIcIDLS1RR28uSwArzpLwoULyBlNa8n?=
 =?us-ascii?Q?q6MMiPdM6xLgNDHfNe0Wd70/E+FLQp+XWGJWDUDrVuEf0/bNrMV/KdgqOyL/?=
 =?us-ascii?Q?3d7PbU0S9FjpQ3J8Rm23yNAshSgg6PI9c9JBpna7PV7QRq5miuAoSqXQVbcM?=
 =?us-ascii?Q?Nd5pbYRp5Rt0ZbtK3axy9KXIygX8ga4gLdBTEsTT8G/785BGDIPC5Pq6VtON?=
 =?us-ascii?Q?BiuMa3AuXmqtqMtlM0i9zg0L7zKjmFXM2D29E7TsOC8R1mWRBpKODeKmAMqJ?=
 =?us-ascii?Q?KzKHcf9oK4kspQzdZpuP2hcd3sMxr8MZRzic7uasdeHymiTdt6jZCvk6s1+N?=
 =?us-ascii?Q?mgJBc7vmTKzuVhHS/XH8qI13gjqBDSRjEFi6ZBqu/lCgntXnfhM/avyVqHch?=
 =?us-ascii?Q?QukFdNgcB5qKODoVNKwp5ha5fX6kLsgPdyD0FweVCa71MPqQIlybr0WXbF8R?=
 =?us-ascii?Q?2C1dKdHwgWb1XQxbZDhfxTGBcFrqM04St0bTFcpu5VUKmjAplMMIHyKqYNJg?=
 =?us-ascii?Q?KdVKBpjzom61uWJtIT5MidISzcOE0NH6e0oySoOQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7acd91-616d-4d55-872d-08db7d43aff7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 10:36:27.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCHag9Qov+sRWbOy8H7bvx1MPakQLySq6Il4swzPNSHvjprZUZ9Prm3QR9m8jxyQDqR/4oqgIUkGKW5e2NGI/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete a duplicate statement from this function implementation.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 5a5dbbb8d..41efced49 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -1795,7 +1795,6 @@ qed_rdma_create_srq(void *rdma_cxt,
 
 	opaque_fid = p_hwfn->hw_info.opaque_fid;
 
-	opaque_fid = p_hwfn->hw_info.opaque_fid;
 	init_data.opaque_fid = opaque_fid;
 	init_data.comp_mode = QED_SPQ_MODE_EBLOCK;
 
-- 
2.39.0

