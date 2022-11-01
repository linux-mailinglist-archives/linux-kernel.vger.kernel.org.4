Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D261477B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiKAKGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiKAKGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:06:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A79193D9;
        Tue,  1 Nov 2022 03:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewhXSV95+nY18uxbHWOpbTxULpuKaEVYumMCkQ3ONp1jg9w6LlCbmlZVFyHcwoW2kaliSwo/QuX+JI/LfJhDfGxGa+mWB5NXFv5Ny2eqAfUTwqX5uNY6nAgjAu4JT2h3i4+fkCIoLZ1ucpNgCco1TEMliZmEYhTS1UK67qoGiIEvpFvf0+SD770Z17EahCezg+Ltxsm06srGMruJ91nuLabw0N3/y6xoalkUfZrY5IOHa7HhnPsP3klsPdHDff4yRG/gJwIPK3Jjhpz9nl4RGKMjyqTw2CWwJ9+PsUxk3cq6fAYFNG/oyYU0vuqxrmfnaP4sB36ajtFWADY6ydz0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj8X2JAuoVt7MYn/KTkonbBhmATOBWmno/dmYGJjTjI=;
 b=Q4sxO2xHzy8Li6MxiiZ/PQjvs/InoEty6N4GNkECAaYC3mMeWXEJQr6LZZg9GdQ2gVlPlLEgK7aaCg8dbRNOtHWL2QURw//KZbm05kYa5qNYXCPPbEBVyf3DjV60wkxz0+bRY0W0QhSZy+oMog5Kz4qei5XdlYI/xTvBfZ5Gw5uOsFVF/YCyjfjMCNm5zVLdK4ZuaaEB7VWsGT2KWM+OCOgtze8hxFuXjLqWj56OhKZVm8zql4Px0EZ5t+Q9Zui03+oIMlVI2hdsQAJxuF0D/ZAbgTqW1I4mmZxBG52rlPDq6XMYNEiot2ZxI1awDcU6rMd35VC9PqHMjNhMdRJOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj8X2JAuoVt7MYn/KTkonbBhmATOBWmno/dmYGJjTjI=;
 b=C81wPAyEm2dN+i9BcxQPjZIIZrkyP1mtSlogl95mCfo2bS6fidVAh/1qjcr8gr/5ZwbdNEbC0/nrQ4cvHQAAyLtFV9pcUAPMQYxudJZWVgeq57l4QXBkNYJ5H5p9aS8Gquzk7u9JZlAryqpOp7jlmuvz+X4Burv/r0p4y6exfo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by MW4PR03MB6362.namprd03.prod.outlook.com (2603:10b6:303:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 10:06:05 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%7]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 10:06:04 +0000
From:   Hsia-Jun Li <randy.li@synaptics.com>
To:     dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, ezequiel@vanguardiasur.com.ar,
        helen.koike@collabora.com, hverkuil-cisco@xs4all.nl,
        jszhang@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mchehab@kernel.org, mripard@kernel.org, nicolas@ndufresne.ca,
        ribalda@chromium.org, sakari.ailus@linux.intel.com,
        sebastian.hesselbarth@gmail.com, tfiga@chromium.org,
        tzimmermann@suse.de, Randy Li <ayaka@soulik.info>,
        Hsia-Jun Li <randy.li@synaptics.com>
Subject: [PATCH v3 4/4] media: docs: Add Synpatics tile modifiers
Date:   Tue,  1 Nov 2022 18:04:48 +0800
Message-Id: <20221101100448.66712-5-randy.li@synaptics.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221101100448.66712-1-randy.li@synaptics.com>
References: <20221101100448.66712-1-randy.li@synaptics.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:510:5::32) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|MW4PR03MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0cd50a-1852-4a7c-9024-08dabbf0aff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkdjGMztzOGVzQli/RLaPuR7/KfEZfWDFL1fWdPjghWEWT6goXtW3nx+DRSi6iLhWIlaE5e3peBtNDXz3H8KW3+TaC531/98F5d0ApkKBtv9d9fxwhQwkAKVpY5jxQCZhuA9t6ru19NgrDrx7tvXOr3frPvXTzBvaCV7pHt5ZnKmOR0/pqJihuSQoYOCunSl8pzvJGUzrzYo/jA1qBInxv3Q2CziYwiKKcRBMROgCUiKoIe3xl/0JRob97WHqXFU9X3f0KggsjkJPVLmNSIyPsW2V/0TTxjHj/QVJA2+h9TOA9D23y2+27A+LVzdztnFPYNwZczW/IF/sijxrgDxMq2jVJTreJPEypWKE7sDAgFxy98ka66MnppY935n6nOTWZwM/TCGTe2t37PkyzwVmholNSbMfHMCMkxHnqRKOe3tdj6dAoNhHgtJyhkd57X96CNhHN5iDmk+se5WaceuhVep78O6ao52X/aJZxIEvrcnYHbsw4Zj1I8iPan4GF/DEZs+ZGny58e0WkdW+4eda0xMR6fSfFeCPTVoiTx1Dno+AtELXDpBpVQQNNq1fuAp1lmUk9oHs9mS/R2SevlDGRLl/GmKai1kXEjmXn6rmJCOG9qF/e7p+GBrCaSxnCZBX6ZHy+T5Cb379O/4UJIRW+2Sq6Jq0hjTSaowvA4hyc1+v2SVOnAVakEr2PzrQz+TCsW8phXlE9zfmUkSRhmrJSEr5enPH5ubhEQ7JAnPT7ic2vz7Gyqjh0wI4VIr16Bn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(36756003)(478600001)(86362001)(6486002)(6506007)(66946007)(316002)(54906003)(6916009)(66476007)(66556008)(107886003)(4326008)(8676002)(6666004)(52116002)(6512007)(83380400001)(8936002)(5660300002)(26005)(41300700001)(1076003)(2906002)(186003)(7416002)(2616005)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xiEZ0dsLmpDHMJJi3776Mn1OmjCOWRZhpCy3CxEJHm2A3HffBl2b4JZmDlBV?=
 =?us-ascii?Q?DWtxpoK9G7CjWSB8ivn3QrH8Z8FOTXXftzm+uZHiUTVjE2/VzN/8i2IJl40R?=
 =?us-ascii?Q?mx40O+p61j9q6G41LC2RxZbxeqEwbCERLxEPAWMARp08yHSaOxA2CXAJ8aEN?=
 =?us-ascii?Q?JUjE4oi4obhtv//NgLkC9j35/egVwPElYaobvQJBfnOXQNxMjffUybFCHqUL?=
 =?us-ascii?Q?W9kUcNd18gSC6+3kcDw2tEdl70sbXceA4wyPj6jyZfJwKSUlXwKwr829Q8GU?=
 =?us-ascii?Q?QFee4p+2xj3/dVIhhHK24jJpn9OE47k4SX1hawZNh+454bYbjOP69CvrGYuf?=
 =?us-ascii?Q?LEbz5hxbjhwBqvXbcHfbp6qRPMNv8i9aXJbLliArkwi7+QtzOvhCqlAULwXQ?=
 =?us-ascii?Q?xa/gni7GzXWiQ2nMRc03lcL3XkdJ6e5ASv5kn04xbXH2OdWBHoU5svpS5bep?=
 =?us-ascii?Q?fpGQ4lAl/r8D8kixfLRQlLSb89WadBTJ8jGwp6GcOZChmQ5s61JhdFi5g482?=
 =?us-ascii?Q?E3k5agoiGVcdQPV1QMU6oh0JtQqyI4Vbz0tiYyvjOiM+Zy/xp8zXNn5M5+Xv?=
 =?us-ascii?Q?96PoNXv6vMmnpD2vrOzD66p2sITueTH/G3jRKqnG68/si3MR85A0zPotOb/P?=
 =?us-ascii?Q?b3Rp7AQqMccJvmv4sM7cUYjwsI3/r5Wgd2kNqz9ETPVhAdV+FlNwt18mVtv9?=
 =?us-ascii?Q?e2CXPR4Y5RIdDvpRAQBzaTU4jy1GJ/vSelU7wV7vTh4Ym+NQSqyj2UJtdcfK?=
 =?us-ascii?Q?gYbrAwOvcgRkkhCUIu42A+z3T8BqIxg8Neuz0Ce4qTLsW1yjcAkSbKZMhIoY?=
 =?us-ascii?Q?iNbd4vtMM9AwfFDiRU6SofSAktJFKifs6M0znJxw4BMGluu481DvtetG6zY0?=
 =?us-ascii?Q?yv4RIM5bIy5yUTq2sHYlD3MBOd664VARLHvrMRQyOebsVURO872WEEP5n+pd?=
 =?us-ascii?Q?R6kvbuN4Xxavzg4BeFF+jne+HQEex/TyK73be0/+Df6AtqPFgSxIpuK9/E0y?=
 =?us-ascii?Q?BQK7Gs+lXp1cEQr75n9I+Bj0mNnRBvWgWMsOBf1eGrQBJbnkARypbrkxs89m?=
 =?us-ascii?Q?F2GzpyQAi+4Bnig+rVGYWsryi/ZNbTzEiYNqFsnUddD4p3/UAAoldKSmd5/m?=
 =?us-ascii?Q?lXm/r9PRGY5vrhRSPjUN/AgAUvheQ2ZiCXe0qiBjridUJ6sVB7YVr+pnhrJu?=
 =?us-ascii?Q?DwYcWyWchBJHQcNOyH+LZ1JZfX1q4/tXHxgCj5UOahnijib6ghUQjIUIcWTS?=
 =?us-ascii?Q?4UYfJNuRveuYNrY4DKrxQp44vMxj/Gscu2puNWDIuintq8MHAfTMk0ki9ygS?=
 =?us-ascii?Q?qAk7sxs63ufg4KJSJdjO78bMx6jGFoW3hXbZsQG7RrCtPyjJS7br6qYYJqAi?=
 =?us-ascii?Q?eIA34GLV4BNJwatt5rXv4NI7s8RBAiDCxRy1FZCtm9iZtwY+uaJooII6DbqW?=
 =?us-ascii?Q?neaIByyoY4Pvg7nl4ujkNRvMke46NuFYVvgc8qiK/4Zzb1od2bywH0rHc+oB?=
 =?us-ascii?Q?j3vlZ1tPhVpvQDP8ElgviO710lVD82QWJLL3Bho89xdO4dDV5Jb3Zqt6cpac?=
 =?us-ascii?Q?K+S/A3j8FwzMr0bDkONADd2reykPzhC/uZglB9lH?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0cd50a-1852-4a7c-9024-08dabbf0aff9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 10:06:04.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIgqwqd9U/luus+kLaZdlRcZ6JQOlOCPKegv60VGsP47uI9GCRb6fc1rZoi8Ed3D01o1reWHoWsJQrgSlJDRfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6362
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Li <ayaka@soulik.info>

The pixel formats used in Synpatics video smart platform
are too many. It is impossible to store them in fourcc
namespace.

Signed-off-by: Randy Li <ayaka@soulik.info>
Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
---
 .../media/v4l/pixfmt-synaptics.rst            | 86 +++++++++++++++++++
 .../userspace-api/media/v4l/pixfmt.rst        |  1 +
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-synaptics.rst

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-synaptics.rst b/Documentation/userspace-api/media/v4l/pixfmt-synaptics.rst
new file mode 100644
index 000000000000..edf6525a3ef4
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/pixfmt-synaptics.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+
+.. _pixfmt-synaptics:
+
+***************************
+Synaptics Pixel Format Modifiers
+***************************
+
+The tiled pixel formats in synpatics video smart platform have
+many variants. Here just list the most widely pixel format modifiers
+here. The value here should be the same as the one defined in the
+``drm_fourcc.h`` file.
+
+.. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.5cm}|
+
+.. raw:: latex
+
+	\small
+
+.. _reserved-formats:
+
+.. flat-table:: Synpatics Image Format Modifiers
+	:header-rows:  1
+	:stub-columns: 0
+	:widths:	   3 1 4
+
+	* - Identifier
+	  - Code
+	  - Details
+	* .. _V4L2-PIX-FMT-MOD-SYNA-V4H1:
+
+	  - ``V4L2_PIX_FMT_MOD_SYNA_V4H1``
+	  - '0x0b00000000000101'
+	  - The plain uncompressed 8bits tile format. It sounds similar to
+	Intel's Y-tile. but it won't take any pixel from the next X direction
+	in a tile group. The line stride and image height must be aligned to
+	a multiple of 16. The height of chrominance plane would plus 8.
+	This modifier current would be in conjunction with ``V4L2_PIX_FMT_NV12``
+	or ``V4L2_PIX_FMT_NV12M``.
+	* .. _V4L2-PIX-FMT-MOD-SYNA-V4H3P8:
+
+	  - ``V4L2_PIX_FMT_MOD_SYNA_V4H3P8``
+	  - '0x0b00000000080301'
+	  - The plain uncompressed 10bits tile format. It stores pixel in 2D
+	3x4 tiles with a 8bits padding to each of tiles. Then tile is in a
+	128 bytes cache line. This modifier would be in conjunction with
+	``V4L2_PIX_FMT_NV15``.
+	* .. _V4L2-PIX-FMT-MOD-SYNA-V4H1-64L4C:
+
+	  - ``V4L2_PIX_FMT_MOD_SYNA_V4H1_64L4C``
+	  - '0x0b00000026100101'
+	  - Compressed ``V4L2_PIX_FMT_MOD_SYNA_V4H1``. It stores 64x4 pixels
+	in 1x4 tiles. Each plane would request a meta plane (MTR plane) for
+	decompression. A MTR plane would have a 32 bytes parameters set.
+	* .. _V4L2-PIX-FMT-MOD-SYNA-V4H3P8-64L4C:
+
+	  - ``V4L2_PIX_FMT_MOD_SYNA_V4H3P8_64L4C``
+	  - '0x0b00000026180301'
+	  - Compressed ``V4L2_PIX_FMT_MOD_SYNA_V4H3``. It stores 48x4 pixels
+	in 3x4 tiles, echo tile would have 8 bits padding. Then a group of tiles
+	would be 16 bytes(128 bits).
+
+	Each plane would request a meta plane (MTR plane) for decompression.
+	A MTR plane would have a 32 bytes parameters set.
+
+	* .. _V4L2-PIX-FMT-MOD-SYNA-V4H1-128L128C:
+
+	  - ``V4L2_PIX_FMT_MOD_SYNA_V4H1_128L128C``
+	  - '0x0b00000077100101'
+	  - Compressed ``V4L2_PIX_FMT_MOD_SYNA_V4H1``. It stores 128x32 pixels
+	in 1x4 tiles. Each plane would request a meta plane (MTR plane) for
+	decompression. A MTR plane would have a 32 bytes parameters set.
+	* .. _V4L2-PIX-FMT-MOD-SYNA-V4H3P8-128L128C:
+
+	  - ``V4L2_PIX_FMT_MOD_SYNA_V4H3P8_128L128C``
+	  - '0x0b00000077180301'
+	  - Compressed ``V4L2_PIX_FMT_MOD_SYNA_V4H3``. It stores 96x128 pixels
+	in 3x4 tiles, echo tile would have 8 bits padding. Then a group of tiles
+	would be 16 KiB.
+
+	Each plane would request a meta plane (MTR plane) for
+	decompression. A MTR plane would have a 32 bytes parameters set.
+
+.. raw:: latex
+
+	\normalsize
diff --git a/Documentation/userspace-api/media/v4l/pixfmt.rst b/Documentation/userspace-api/media/v4l/pixfmt.rst
index 11dab4a90630..738a160a4c41 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt.rst
@@ -36,3 +36,4 @@ see also :ref:`VIDIOC_G_FBUF <VIDIOC_G_FBUF>`.)
     colorspaces
     colorspaces-defs
     colorspaces-details
+    pixfmt-synaptics
-- 
2.17.1

