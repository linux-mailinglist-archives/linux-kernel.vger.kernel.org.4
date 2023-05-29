Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F07151CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjE2WVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjE2WVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:21:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F4292;
        Mon, 29 May 2023 15:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2w4P3ilLQ8KagGuGhsO+NBUqq/ctLYmxl+71TN3jo3bn+6qemWumZDDXRg5Tqalu8BiSXz1DpnG1ox7r2PYn9g3X/YqRchUAubXp2LfwBm9D3+lgH3LnZ+c/GArTq4SjqvD+JSkaUV6ElBzMkguN3Jn12TNRVHiVWVOovJFbn+x0FHO3O/b7FJZi9rM746kupuJk+MOElDcmZrR2v7g3hvp8+1AMmPHSW/chrT+3DMi//yu5UjwGrdz41CECMZOWMN7Ykn3OnYeS8uJJ8N9x6xVq4gecLEWi+9nkH5KTlFo9oJCobd4aeTQFiPxAqh2N9D+IJIXBbJQxYRGQzK1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Y/99eWkTe7Ip9O/z1iHWLHlVTk4HlnJtTJku0CXsck=;
 b=VYjSIv+Tdpnb74QuUlE7m76mx8yxP9QG+bPY9FsCFTLwuOhB9gawph9agVKjMZcjwDZL/jSZXVE2qSF0CtwezGFdHzfD6PodUnqHnFqqweLGawggUZ72rxzn4+CRU7j17GG0BnYxtd12I0k4iM9PHZ28yMHlQWm+Tat4UqULf545IuA/Fwi7CfhpfyteWuyw2mzxrWL9x7Xd9oAutI6s4U8bjSuU+AZ3lo7acJHVsUFMcwoI5pQ7JKlr6kdwZzzYTjhVjYBiczAoP/9TtIGH2o5hdSVI/o01t9B+K0XjWsyBAy4f6HV56PpR8I/LlP82rXRpfNPFwtHuIKd+N00S+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Y/99eWkTe7Ip9O/z1iHWLHlVTk4HlnJtTJku0CXsck=;
 b=FIDrBLOLVXdyG+9fXqD8s1HeaBjhyG1J2+4NjXIO9MVnvxX+9kC28UxgIcHCuLyuYkDDZooE7aeICg9V57rt6TJc4tqPxpsgZ4m3tQL83FEV4miiKUKsg3As9byyMpZqYJqxq/zVDQ9u5uNKHLgkEIi9ANghoBpai1IoKPfbr4llG2CElUg3JP9sESUJao6h5c+BBz8acDA4bpGyk+TbWKuBm8AZvm3kmeuZlbagPT1hPSfaCpb4tarjpzH55WsnnglToOxniwMBvmYq5b4Zb2RgaameP8DHuFFVvTMdI0n7fkFiKCcUs7u+r98iikmvQNyMwTTD+8x8uVcUAqA9Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 22:21:07 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f3d4:f48a:1bfc:dbf1]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f3d4:f48a:1bfc:dbf1%5]) with mapi id 15.20.6433.018; Mon, 29 May 2023
 22:21:07 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC v1 3/3] HID: nvidia-shield: Remove space prefix from label in shield_haptics_create
Date:   Mon, 29 May 2023 15:20:52 -0700
Message-Id: <20230529222052.68913-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.4
In-Reply-To: <20230529222052.68913-1-rrameshbabu@nvidia.com>
References: <20230529222052.68913-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0012.namprd21.prod.outlook.com
 (2603:10b6:a03:114::22) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: ae99d667-12bc-40a3-03e0-08db6092ffb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zUgx2bJuchgLVcJwdh4eNHqLovY/2jXz6QdD23lChNopCTRZ/6nR1H2O0TINyK7drykjG7g2TzYJN2Gcwomq3/CQsXBEuXiWtlpIwQ7UkmbzEYbIoz9dYIWMFiXfsoGvkdaQu6ZkYw9eS+0aNoQqrZsTIPUeyLAq/BUTb5vku4mO3wG3uBFX9lPpJCiuO2T3MZHu8CWrxD8KfwXq9LhXkObpFM0qA6ZPFqWvO3ljpXzgf1lvGjPEROIgbEPSI432XBDb3sIFUx5f+JlUzrgaRuL5bi6AVsQxmaeioJRtCvKeRFT3Z+B5fjPSX5U6WcYhzecx0DPOKeD/jPBspvXLwxmJQ+vYJscDotnDveXuoF+rZWKRuHWMdnlMHqH8XnmrXervr5w1dC7xCWfWGK6wIwNRonUGIjXgubljDxAft+gXJV5yt0n7n7jCJ/Y+oF/Aun7dwIRVlx/nyLPXrfvCN26rRa0ZMB49TxWZvl4yWQV0UNETHNfw8teJefSbLl9y9bO1+A+BOeJwQhTgu/VbV3tfnysznXf8uLbIfT+kNOA5RXkNCmugR0cG46vE2Vg/I5lYpVN8aY6gaCFXF/JbTDEUd5VX02OXu9PxnMexlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(6506007)(6512007)(4744005)(186003)(2906002)(2616005)(110136005)(478600001)(26005)(1076003)(83380400001)(8676002)(41300700001)(38100700002)(8936002)(6486002)(966005)(86362001)(6666004)(316002)(66946007)(5660300002)(66476007)(66556008)(36756003)(107886003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3KvJq7um15qH5n/xSyD5ejc5jK3vppxImCBAKMwu8YvoEY7WqXE+aggxBGp?=
 =?us-ascii?Q?P8LOQS6bJ3Q84dXCqzoV7NM7NJjykhKQTXdxCis8aOUV9Xr7K8EpPxWY+gCe?=
 =?us-ascii?Q?myUNJmfXtH0loY8uqtAScsZwiSRgbCKfSxQJ5L+8hqEptf7lA+cvr659EtJP?=
 =?us-ascii?Q?hWhtYLOdQsvoYVHvdH5RaIfsc2/2YXQg1LzQ5Sb5n+J3vvbqUm0t8bgGvUvA?=
 =?us-ascii?Q?vHOLcvRl59YNsL3iuc7yUknY/cHLsyYRm21tw3I3ZaiplxC4Thl5FkH5FzTa?=
 =?us-ascii?Q?9e5NOc/xw2Ws4ZT44QVPsyqspJww6yoQKs8GKoWBLVFhNwVShEsb68Sy5by/?=
 =?us-ascii?Q?Ip/I18074wMT/w7UrErEsNKmbmiWXlbNCZAc/GbCXfmEM9MODPJNbeQQ4JMs?=
 =?us-ascii?Q?2ZcSsKx/Z1OgDLCgh+w3q7qUv1biVdXHXhFMqcmkDmE8ltmm8yhM8GfuZ3IY?=
 =?us-ascii?Q?5OhH1mMmvAlDF1GL+ve8/55rxI25S0DRhxIgXUDBVXWXfZnRqLuTmTlarqc4?=
 =?us-ascii?Q?POX2Zp606ygk8tqMC8/5GiWvBSPlH4Bttt7I1r2Fb+NfU/gf07wzqO2saKbf?=
 =?us-ascii?Q?lBqL/5K/rwKgNY9JAj1bmwFTg3l+GriDtG/m5FYMaW7vS6N2kc3nP8f1ZNub?=
 =?us-ascii?Q?ngxOTa+XagFF/13IiYoyHY7+IakCicqQkFX/+DMneMS2PeXfiXuekkBP/xhq?=
 =?us-ascii?Q?cOkfaWbn5keWBrlracLbFwFv6SnaZX4sqqnuwvTtTKxlpUVIO8qK4rYRkStD?=
 =?us-ascii?Q?XAmqRoDxOryNqgkwbSNUa1sEOo6jOO4ZDeCV+tMpsbwu1HqQ1Q07XzJuW3Bb?=
 =?us-ascii?Q?oV3ijigyINetn52Z6gd5cotDS/sKWTZ/VP7JQiiIOP2mP172girY7r672db3?=
 =?us-ascii?Q?Dz8N/FyZnpBvLStcz6id2yG7VYSLeolgjOQepPwJe+8JODGKICRT00ROYjKG?=
 =?us-ascii?Q?ZmU4+E0MDQyOLkxpY3WM1PYsVOvME3ZkHxOGq/5VaafhkvKqlyM9UkwO/BuH?=
 =?us-ascii?Q?sqXMfZUZNKM3MjfICfoUA5UtbxlceQU+oMEmvXpYoTuP1YiocHX0/cnjvSli?=
 =?us-ascii?Q?+ZoVi7NeUGSuMMeVh/3iGFm12Hhrxo3a0vIwgAqvDAaGQWv8HjCzEJ5gy1nv?=
 =?us-ascii?Q?8+E2oN2Zn2ewUSKtRCCRNh5yyz1J1Tr3pg4P2hOypL3TQAnKGHPB8zOTtTX8?=
 =?us-ascii?Q?zaxqPedhX5aY2SVAveURdxqHhHk4yZ5bvhHobqEHRlD/1yxjDrHYXY41ViwT?=
 =?us-ascii?Q?NL00GUExLsV1v8/ov3ZF9vMCUfb9XQXQaGGlqlG7s4u5Q0SUyIKpOrYmDLS4?=
 =?us-ascii?Q?TnytIrIUBTuaVKXesbk1Km9jcLvMNpSgAdOJ/sbdkq86hBTfIF2I5tLphTw0?=
 =?us-ascii?Q?Hn+bbetoYizo1fctVJiAnPbzDFtx9TTxY94tGWLEV9qHxWiG6E8VeqT/0XzE?=
 =?us-ascii?Q?vlj4nzK2ii2a9OCPJLfuAJXXsNoFt12HhmsU57R2BNLP0PQNLfLiJaPBEz+T?=
 =?us-ascii?Q?t2fNjEgD78yYcSyHcbRTghqQniNNHskmSx5ZpwSYbi2l2a3UbgS1kYevQH5W?=
 =?us-ascii?Q?EZtAYridvTKYjo6E37k5Uml6jnDFtWohbyytRCjnPe1p0QNzZ11FPg3Bxkig?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae99d667-12bc-40a3-03e0-08db6092ffb6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 22:21:07.5890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiVT7HvSjmzdNkJE9ZW6XeQPF2ddzybbd3SgdZQWbxUhNb8fBJgd1D8dAlBzdrdjxAh9fVRQ+7Vzbx9QSpiUuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accidentally had a whitespace character in front of a label used for error
handling in the shield_haptics_create function.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---

Notes:
    This patch really should be updated in the initial patch that introduces
    the nvidia-shield HID driver. Using a separate patch to just illustrate
    this is a cosmetic change if needing to resubmit the original patch for
    nvidia-shield.
    
    Link: https://lore.kernel.org/linux-input/20230418203747.24000-1-rrameshbabu@nvidia.com/

 drivers/hid/hid-nvidia-shield.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 7dfaec1c07e2..85700cec5eac 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -202,7 +202,7 @@ static struct input_dev *shield_haptics_create(
 
 	return haptics;
 
- err:
+err:
 	input_free_device(haptics);
 	return ERR_PTR(ret);
 }
-- 
2.38.4

