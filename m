Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D144B6E5032
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDQS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDQS3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:29:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09AD5FE4;
        Mon, 17 Apr 2023 11:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO4enMuJpGiHqv/UffcdgneylbxMoCscaX8xNsrQjNs6sEingWRD2JfDW+Y1eDwntu8Ybi0OFbMxOxhaakW9ybrp3/rlcz72bUymS2c6naM1pr4ZHkW6NVz+bgUerMjcy3+lbLaXWUBZ8QsUakV5UdDLJG+TpwFCUl3fvGISlBpEo48zJCpNQsPhdUN3xJUzNCXKOGKolALOeffbIeGoxX2T8RH+DwQOleTZWIYdFz6F3sbpW6su+eOedoowte6zui57UHj4ipsCVpLZEfRZUY6fnZlg25y4TPeC536H90XUbXPAV9jJ0oQQzx6SkDXFRqdQ7VY+mmUc7VdqZG7fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxkcWhFm9w3AJvD8ui5qCKY69i0au+lIQRSWi75D8xk=;
 b=nmlIMn0EZMEuO6za2O4UHgLlZQ3mAduEwuLbAuwv8jV04QgYq1BKyXUz5zWGlpr+bZ0KSCVFkvzOdbSrxP/vw3Xvb1wY9SruKUNnGJePNlsQxy0GzIt59flqejGGKPW6BP3QHwdFwOZKfWUOYQCsopWPJY4keMBKurtW42+uWSOPQkn9UrmnD9ZpWwVMXxX1VmArvSvhb8gKTl1Gvs0hp4w/4isHNia9v/7tMMXSOi/W2LazHJZsNkhBChVtws7/Pyl9Rzai5Fla1V3HZnHof1nkdmcrq4i9DR9nsEwIA0UfTlrHyuFGLRfhHscLAZr4kGmS+JAeqkZYlAlSIWW9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxkcWhFm9w3AJvD8ui5qCKY69i0au+lIQRSWi75D8xk=;
 b=ubvQqImlCz4xoHRlg1c4115R3e8iEfF8Yw8Y9VqCXAP+p8jfiJsnxeOles877RPimpUyPLheooB5U9jzCRWPWSQvSaJnyLZfAkibOZb8YH8/uLQ+HhOOlgNQX2sCfHH/OfmQq4G5ZLXgrTr3jKxvgHl9MaiA8epTUrL0VIBLNZkuCg2bJiBVLGtLkea1xcEijdAsvM0oYzShyCleKVKalMcvE9+S1F1YrdoOeQo8sadmp3s1XLDaCCQvpC4Cp2xL0sUBCeRhdK9PGL6V2DgcKaQ7hnQNOmiCglMPhfSdKoZQQT31qbrdTRhzYUMYaw6iqz4lOyTkjxFVnQLnF3r4ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 18:29:22 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9%7]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 18:29:21 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v3 0/1] HID: shield
Date:   Mon, 17 Apr 2023 11:29:08 -0700
Message-Id: <20230417182909.33833-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: c66cdb2b-d81d-4e51-b55d-08db3f71a9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Cg2LM2FIuol0/zLYe+8giMox0r8WUZCrv/eOnKxetbaV3iTQ/PSABqaNV/BjqWED8yYeGnBI43wRHnzXmEj3Ne06M+o/JbgNeNw9UCxEtFOqusremHgpUYggtLK4EhJNBOXdPhcjWurcGpWoBrLFC018KGGfO4EKwT9dy3LVhBOXFIWB/jFE1A3tliF0AZgRuuV1+jtbDj3+OzSih8plURP737HM0Hr9pX0NVSd7o68xp6BBdmk0WwMjIVdKzPgLmk+NlXeUkpvthlnBkO5/JpBlKdOv5q+EicoHwSHAtBsbhVuAbrPiSXMRe38MBiOqwLeXgub7mn3OHn0duYK7MggMuOZjC7iN/4pD5D9AybhugHgeh7/QBCuAtshAErXfgb8wwfZKtkGU5+duPRB1ZrzDthr1Sy5k7Nqk+5/2lDkALAWVeNUmp/hzwk7ZiExh+g72bHaBr+ab6CJ2ov9zEA4QK0WMqcW/W/hQzZ3N0xUL6TnVMfeoqZHh2NA16YhEYGp7M+yGCIUZZCdGfuMm4h/WsH01d0dElxT+melO0icpFXWqNER2kh1t+qgRmtRJO4gjsWCdCyeSA9fneVHB24+PCeuLJR4FLB3ylsm0Zqv8VqQLXajon6VCdGQxaSjRXjVlNH1w9/PEiv83xVJUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(86362001)(6486002)(8676002)(8936002)(107886003)(966005)(5660300002)(38100700002)(186003)(6512007)(1076003)(6506007)(26005)(66476007)(478600001)(4326008)(66946007)(66556008)(110136005)(2616005)(36756003)(6666004)(2906002)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LSOx/vBWlwLMM+2c+chNgT86OvFtsejGU5KkgyRDDB5uw0RoLYee9wEtYXbB?=
 =?us-ascii?Q?DixNXyKZNN3LwQLGbBVdVJBjSoYjTUGcypAlOwsCx/jT7EBzutGW1fYMsjfV?=
 =?us-ascii?Q?WDFJYgeB/Tcxnp3jhvSNzDC1+r4yurB1bvVMHP45eWYtMuJIVFti6amAfBi6?=
 =?us-ascii?Q?xYggBfpjuBw6v3i+6tBG0NEMPwTgKw1mUd5UGN30+UZbJYlytlLCgnthHoS6?=
 =?us-ascii?Q?mfxJhWZdAnjbWJ+WZnQCkJUPDpGoTTrwN7e71f9BGcAy3xLHrjlwMCKbqSB3?=
 =?us-ascii?Q?DL76s+2dTdZVtmmtxN3pvPaN9Q/dNXIBhYrPPfyjwOlkm4d/IwgLyhEUW1sX?=
 =?us-ascii?Q?d3H1gorON434z9r7mOwuFVRM+Ow0y694bZ7WuqS0vUBYhQ1q8dwRAXMv/at5?=
 =?us-ascii?Q?VmyEeSC5FA7blC9LkEnDVSrSaEbsWgnQDngYTU7TNrzRVUHxnVt4Bn9kjDHp?=
 =?us-ascii?Q?J1SaNnlqQZBG0/Rg4SXkDhIrTGJdisBLZf/kTFilqD4iaWf+hkzFUzbDhI06?=
 =?us-ascii?Q?XEmBFWQXTgelu5ndyRrCgiWPXhkvIU8/HTNp26EWkfbPR7dtpt9mDaNT4zT/?=
 =?us-ascii?Q?9B+MizUvlxxPsaCAnJL0oecH7Eol/dp5/foejmBE/T6bIXfYzcqt7oCfqKMs?=
 =?us-ascii?Q?jq80g9QuOnwFPdh+cjF7nXkxa7q0KpAHFnUg/NsOGK782I50NSXKw6WPVUSJ?=
 =?us-ascii?Q?nTqlyqwIYqVqiQKS4O/xZFgIJbHuyOUAH2Pjup6q3QfENlXgutZ5jJykweaV?=
 =?us-ascii?Q?gUQS9M8cJ/k+99EO4AFD/j5xtzNAiddreAUFoOAZ/snTJb/vV6m4Go4q7g8r?=
 =?us-ascii?Q?xJRfcKxpYt+ksKXUar6QgIbvsSfC9w/2dTYi+K67rbHAFkAz4uN++cswwFs4?=
 =?us-ascii?Q?qJED+bm9YZaDYGf+gouKqwJCX77/1NtMAv9ufhG+VrX52Im21FVhLfOa3R94?=
 =?us-ascii?Q?EA4aR0tagtMmzB6xF6L8kv8uRSdKZzF9Lv0Eypg0NVUgL1sFkMwkmFVPdPbz?=
 =?us-ascii?Q?MOSWF3MN7Ga2bXiQdQKsVR7Buwafc03mhUoZxXRkJcY6aX+1Sr3vO62JLFhz?=
 =?us-ascii?Q?6CzFP/O5MJ+oLynTZz3oQzK4Gmgl0VBVqUis7zrhYy45n/ek4AiHwjbU9Db7?=
 =?us-ascii?Q?lrKQvI08R+EE5PxvoI84BtxstdIYIHVdqjoUVZYQRibTKbKHg2bbOm8U5iJQ?=
 =?us-ascii?Q?VKZzsMU75Ztr82QOJHVIzHpM/UUEtdEu/yWpLbdc4ptBrJaz2F7oGXq0npSN?=
 =?us-ascii?Q?o6Q+pHfi3Zb5GhkKzOg8Js0zLRysGepocIG8YxOXeFx1hoE0WlqMRMV4NDk+?=
 =?us-ascii?Q?nzYGRnCil/GVsfPWI/sp7bF5FAYGYoaByWf4Updy2XCCWaQS+rR2WNicY3jI?=
 =?us-ascii?Q?WM/wzN3iHd/L25+pwxiu9PXOsJC9Z+v/4SNTnXmXus5a2UPyX5nk+8YSVkiQ?=
 =?us-ascii?Q?yi13WgL58Hkb3QOJrP4P2xRYyKOHHjMfjaFLC6Y8hsumRk+1EBLyrlAlE1LR?=
 =?us-ascii?Q?0B/xJtI1WAiGTG98gd++18wSlIbKwcpl6231gleBaSTjaveTSsuLGmEGbHW2?=
 =?us-ascii?Q?yPhNiuSHjyhN1I7xAhNLB1uzMm26w/kiqHoUFmuHWeMAJ26I2Bam3EzmWQPj?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66cdb2b-d81d-4e51-b55d-08db3f71a9e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 18:29:21.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsoiSd+EvT5+PJ8INem6uPAEgf8j2N1IB7OmcyvsDpwgOrj3BWEwzy73rg59W3ldYUFtC0WWfeWWwzeg9X6JtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is an initial driver implementation for supporting NVIDIA SHIELD
peripherals. Currently supports the following functionality for the
THUNDERSTRIKE (SHIELD 2017) controller.

  - Haptics (ff_memless)
  - Serial number query (sysfs)
  - Hardware information query (sysfs)
  - Firmware version query (sysfs)

Changes:
  v2 -> v3:
     * Renamed drivers/hid/hid-shield.c -> drivers/hid/hid-nvidia-shield.c.
     * Added space between braces for terminating element in shield_devices
       array.
  v1 -> v2:
     * Declared thunderstrike_hostcmd_req_work_handler as static.
        Reported-by: kernel test robot <lkp@intel.com>
        Link: https://lore.kernel.org/oe-kbuild-all/202304011342.6Bh3cWhA-lkp@intel.com/
        Link: https://lore.kernel.org/oe-kbuild-all/202304020922.vsngJnBT-lkp@intel.com/

Rahul Rameshbabu (1):
  HID: shield: Initial driver implementation with Thunderstrike support

 MAINTAINERS                     |   6 +
 drivers/hid/Kconfig             |  18 +
 drivers/hid/Makefile            |   1 +
 drivers/hid/hid-ids.h           |   3 +
 drivers/hid/hid-nvidia-shield.c | 587 ++++++++++++++++++++++++++++++++
 5 files changed, 615 insertions(+)
 create mode 100644 drivers/hid/hid-nvidia-shield.c

Link: https://lore.kernel.org/linux-input/20230410170840.16119-1-rrameshbabu@nvidia.com/
Link: https://lore.kernel.org/linux-input/20230401032150.7424-1-rrameshbabu@nvidia.com/
-- 
2.38.4

