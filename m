Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3819747CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGEGFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjGEGFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:05:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D0C10C3;
        Tue,  4 Jul 2023 23:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYpEzq/Fx2R32siNWrWdDl2b0UCWoH1jmdwdHJfVD/E/8OhYaccRKhK8sfYZ8NdhTVXBHKismRMWc8bBJGiUEHUvZY7MJEp7UBVeXS5lfBmd9zmRhtTyblopCjSG8f9Ld4jfR+mHijYTWe+L5LOUy81kIzcaZ5miflCR2a+CRO8yPk0twmKKzKb9fsd+8sxU0wf+AXR5zxvbXStTKsVuzVUhamhZVPf+wgogcawjG1F42I5MBVuxQ6SObsgnypzWQjvMQLfqtKstGJgsmr2ky60Q+x78zbL2JUaK5TBDD4Kr71y7I5VQaXywYhHnEErmx7IIGyMy5LwOdW/xLFJvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsD52tFNU1DukOTMc2jN7elxwEEcaYBbelMbU5SPjZA=;
 b=P3C+XZDb9Dg82WUMDAlvCh81MoMsnuqZCwOEpPBTgLA21UuwlgY3U6iV551evuNepe/MoPBvmXZ6o2QgBGmn0rvj0ETzkDnqHlXBRiy3H3TaQO0MKF7I8VxFzPNz9veO0h6o6m6QZxKIfGPc7TWK6RpQkh8G0hoJ3RaNkpo9/stDLm0vMiYvsaC3DTie1tiuQx75GV+gN2vhScL+1f17b1FFTyFGO22AJuorXvy+7ZII2x35wpfbU445u0sjqkGEjwIEaJdBGGzcojRKS7UIhOeq202Hk9qVry08jgZf7P8iyc33lZP3+2R/UlnV+9J563Ah81y3R1XP3yyaeVWhnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsD52tFNU1DukOTMc2jN7elxwEEcaYBbelMbU5SPjZA=;
 b=dcXTfysS53DY9c2ft7PdXa5yaj5QhXJuW7vXx1EqloGTprSQzazhM90uFgR691zPeo2xW20nmYBU9KAteADNHMyG7qrPPZzOjP/1MUWQIwLVtniI176ruj9AdjbZrsTt/VrEkAdMgPNJfoExF0QTi+6P2cjFUOJEpJ+SkKd6G4bWvZHKPBlzPG+qJ/XtD++dRb+HjL7g30Cvvk8ADLfWxcfRgEuTMlSO/s8f2w6h7iWFW1nfD5B052mg55yrHVQkFpv2CcCOVGhX3r8MKiZCanBwfd4kqaiyMT5qny2yEpHdwVV1WEHGP5owpgNjHsKePpubYnvberHDneRoe/ddnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:04:50 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:04:50 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH HID v1] HID: nvidia-shield: Pack inner/related declarations in HOSTCMD reports
Date:   Tue,  4 Jul 2023 23:04:14 -0700
Message-Id: <20230705060414.581468-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4c279d-f35d-4327-4812-08db7d1dbe51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kbqi7BH7IUOkSRl7s+i0i3mej9K0aBUDnorCDtR4y3lLkasL59Bo9O27NeZmVWekQw/M9bpxXeAeIz1pr1bczkih1jk0F5V16+hUdSTMR7NPfnl62YZqnPphYVS26qFD/nubi/N+V/Dj38XlqmZqCZcvuWvW05530G5l+btFkmATHjoWGndIa/YGmfx8zgjebur3RVBGsZ6o55qbCsrVFlr5oON78pAKLO9lFJ3vZMEfXAzSd056p/VweTahnSjju29AgF+PV4n6Wppu4XIUjEhYfB8T1GkwyEYWXHb9DbNwUmX8z4YSXFYGhKZ2RJy2S1Zb8guhdfiSnQFiIDXuYR1Gi+xTKVLyCyg5I+pdY2kGTdtmBljbAMrHtVcG/7jkjnZSPkbnSEHNrKS9FDHcEXbg6ckIFMIkCqg2+WwdonfZvfNWygHucgZOm+V96TX+mRu7P8QJbwFvNzxM4/fO5yxvUpWgJY7pdqz6TANRKAZc1NyMPb9hPNa8MPXnrDxGFEMt3VDEWK4qrGfhw7KvEdXlreahXUy7vt7q8hNAKAEXDiK0auTO+lfcfJ4dhBFwgRQrUqKH/3gDpWJh2MTiHmuN9COV4iwbZ9yqG9fwVAnWsyVf/1a0nvODCJYFqQaSUFtsX5JLn4zCHk/z1xYwHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(186003)(478600001)(966005)(6512007)(1076003)(6506007)(26005)(86362001)(2616005)(6666004)(38100700002)(110136005)(66556008)(66476007)(316002)(66946007)(83380400001)(4326008)(54906003)(6486002)(41300700001)(5660300002)(2906002)(36756003)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+nc/PcVV+MXcs2bi+LroLenWEB79CY57GZHda1nnwDbqxn9n1raD24n//N4?=
 =?us-ascii?Q?nFD9LG24WtbvPWh03ag8f1wXxlrM8C6DGvROdt6wCh/uwAZLJn1kxgwmmlwD?=
 =?us-ascii?Q?k1q8xgPWOM9sd3L1dHOykKXMmgRRY8+MQf3wReq2R724rdC4oiJW1HfVRl2N?=
 =?us-ascii?Q?A2IS9LOgdw35RnuGdJNLIcRJl6u0tXmmgfuWPmIbnsKqDQ9gK3zobRPUOK6f?=
 =?us-ascii?Q?fG4SRYpq9rKq5nkZwrb4FFPr91pyuJPW4BfcwY4l05QaXnIkIYJfbskIiMML?=
 =?us-ascii?Q?0xMaOi104/Lj3GlUnyfKc1Hm9/zOKzyI5Gn2iQjbD9Fr9qdrQRjW/uqodGjG?=
 =?us-ascii?Q?NojQMRxInMN3M5eAFMkz8ozseXvd9LfJTwqmSy1H0quyyVEIXx02VbWrLH9i?=
 =?us-ascii?Q?bG+Ilptc1dtGmnR5uBNsJA8quam4tjJNutR89ONFPXz+rHmoJ4gXMJRKBQz6?=
 =?us-ascii?Q?J3B7G/dOTwKbLIr4ttCrlDzIr/PVM3Ct5ocj1olg93oHYobuH1bM7pmJSd3E?=
 =?us-ascii?Q?XLD1EfgLAPCbv0649sdp7JQAxLC7EQChhsPvBAorqKwse9SaMs3j52APbA9d?=
 =?us-ascii?Q?REafMFY+OF9jFitwE3ipFy5AHiys05ZOlOnBLhhka4rD/9D32WM4CpdT/XLM?=
 =?us-ascii?Q?xno3oAqVTJYiGEzIVyBGdb1FEzdML6i7nYWCCfLuoJm6wZXEDn54rh0qCSxi?=
 =?us-ascii?Q?5Xx7COeO6nGxWB/uZQd50TKpVuulRpPC10uNxkWkgJwuAIJ/xHZcLHi686il?=
 =?us-ascii?Q?xTXm6z6+Q6aTf5CtrBawLZkUglqNg/Xn0zzEbkJg9bNpazQcRf6GVwERsMDE?=
 =?us-ascii?Q?Q3YH6947Ym8f4ELHHulx+6Ac52aElnZ+SlLXfxPgJPTORjD6uHgucAXaMlCm?=
 =?us-ascii?Q?4KUpt/42oD3hv+l/oQjgOSsP6ODBOeULOEI6E8eCczr8LvCcS1jshwsu5sxs?=
 =?us-ascii?Q?IAD25u/T+JEpLq7X6Ty/8LzAyJdil0Co6/lLrBo6bBznJ/5ebuwsaF6WFuUA?=
 =?us-ascii?Q?IhnUXNRw0OgfJHX3f3AAkwLbmV4JvwnydfVi13ffx35TUXKuLrOvGsZunx2Q?=
 =?us-ascii?Q?UlHPvq+WPcvGH4AhBXy5WGQsTsBWBEEXWe2POBmamxiGgq6zFhLprEZF6ZwO?=
 =?us-ascii?Q?GpgIVzxka8tH3B/wXYTZ9OCdr6KEyBuY//YcbOgijMYv7qDsPldDtbUZ3YG9?=
 =?us-ascii?Q?c/e1LfeplC8p89U9ErzA6Bb+/AmcYYoF/MB3VxHv3xGosl+Jg81RTG7FQkFo?=
 =?us-ascii?Q?0L06JsiYtThp191mK7eP5XrfnGToDZE6LtY81W2BHYNaMXMcMCDvGxxmbTsn?=
 =?us-ascii?Q?q/oKywiFIw4NZBb/wkAVdfGBjslzLuVx7AftIw4ZTAkwX6C3F70NXgLt3Jc2?=
 =?us-ascii?Q?c+vmp8QWpUi0P0ZAfbrnSQ+JTBOkrp5hks7gfZ1gjFIkjrhbNa5wqa1fGyFE?=
 =?us-ascii?Q?SDelN/JmX9ADTnDJT6A28z9VjzGAi8trMuTNxlCWAY63T4AI5kLsokb6DK79?=
 =?us-ascii?Q?GL2XJ68YB45B2GiuQtDu2s0uRT44xjlI9FZ+lB9jGd+PGpxrFJxeGZNWnL8n?=
 =?us-ascii?Q?1U3g/Y/uQHpRfl/l2ZOFpHLj5e7twSGX/k6ESBPl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4c279d-f35d-4327-4812-08db7d1dbe51
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:04:50.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+IQbAKJLXuGkUA43V0T52XSvXUh3asXp2A8ESBvdnZHbo9CI129hw9xeGt/VD/JGmISHbeEOND/2cD8nhFcKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match alignment information in composite type declarations used by packed
HOSTCMD report structures. Compiler packing attribute is not recursive for
inner declarations. Mismatched alignment information can cause undefined
behavior in code generated for accessing composite type members. struct
pointers passed to thunderstrike_parse_board_info_payload and
thunderstrike_parse_haptics_payload are an example of this being
potentially problematic since alignment information from the packed HOSTCMD
report is lost.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307041500.6bKn7nCl-lkp@intel.com/
Link: https://github.com/llvm/llvm-project/issues/55520#issuecomment-1128617570
Link: https://gcc.gnu.org/onlinedocs/gcc-13.1.0/gcc/Common-Type-Attributes.html#index-packed-type-attribute
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 drivers/hid/hid-nvidia-shield.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 85700cec5eac..a928ad2be62d 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -63,12 +63,12 @@ static_assert(sizeof(enum thunderstrike_led_state) == 1);
 struct thunderstrike_hostcmd_board_info {
 	__le16 revision;
 	__le16 serial[7];
-};
+} __packed;
 
 struct thunderstrike_hostcmd_haptics {
 	u8 motor_left;
 	u8 motor_right;
-};
+} __packed;
 
 struct thunderstrike_hostcmd_resp_report {
 	u8 report_id; /* THUNDERSTRIKE_HOSTCMD_RESP_REPORT_ID */
@@ -81,7 +81,7 @@ struct thunderstrike_hostcmd_resp_report {
 		__le16 fw_version;
 		enum thunderstrike_led_state led_state;
 		u8 payload[30];
-	};
+	} __packed;
 } __packed;
 static_assert(sizeof(struct thunderstrike_hostcmd_resp_report) ==
 	      THUNDERSTRIKE_HOSTCMD_REPORT_SIZE);
@@ -92,15 +92,15 @@ struct thunderstrike_hostcmd_req_report {
 	u8 reserved_at_10;
 
 	union {
-		struct {
+		struct __packed {
 			u8 update;
 			enum thunderstrike_led_state state;
 		} led;
-		struct {
+		struct __packed {
 			u8 update;
 			struct thunderstrike_hostcmd_haptics motors;
 		} haptics;
-	};
+	} __packed;
 	u8 reserved_at_30[27];
 } __packed;
 static_assert(sizeof(struct thunderstrike_hostcmd_req_report) ==
-- 
2.40.1

