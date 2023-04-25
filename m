Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48B56EDFA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjDYJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjDYJpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:45:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045EE5FE0;
        Tue, 25 Apr 2023 02:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYnO6QQivTGNifrhYRHyBF3V1GuF95LDT1kZi2TNJMwpyhiPrl8UqBFlZL9xkKu6GPYZzHtRKxtVzYSQjUWmai7a+/GpMWQO2bjs12DivOguNJJ9z9EoXwhcKVKaA0aMTM9zh/QOfUDUGbv9ea/nihnBLitpdllSCv3DFLVPrx5A2/lbN9OI0HYrUb6/+gZ49upkIR1PDPo2GHwBWLDcUvvsoQOAEMHHopWXGmq/mbWZxfnWfxaQNP3PlnKRZsNtpyt9ch66YNDQ5+euHbEROmxCdgNf4CEr85gdOIM8x94qfVVhfPRmZrTBl2kaVKElG6RxZvmO4e8N4OghEblGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLuld8DVZQUl9JD96D4KgwpO+GrK8L1VnMH9Vmashgs=;
 b=O0WtZoFrTFLpLnaf/uRLqA7jclSQ78Efw2Bqt2QnYjnns46YNkFJON0eTbnLfpCLJBxGuVrUpoGPZbVLGJ7/6t/lt82pzMNr42R3pt58Qpynw/i3ojePgDnzybGcdAmhztRA5aKaT3jwyyVbFHJRCRbrDJ9E+PWqvrWjpdFHI0vSBMumhwKNcwAahplBKWhrEA/4y4C313ZUj6d0E28dAeIcI1R2WlyV3YcZlqgl0QaVF83S8BlLdxOVvfiTuofNW7TAjCX62VE9uwLdcCqSv76gIh6HPpln5HANfCxCoi8IBQ8qbyAs1iTOlr7fNutDg6TfhEJKtRgBH6MPqU8QMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLuld8DVZQUl9JD96D4KgwpO+GrK8L1VnMH9Vmashgs=;
 b=lmrNszoFMKjBRS+Ae5fm1mtwYRAcI9a3p0f8BespJ7GkiCMrHzs7GSKpTjEBDaXEagOa4Q1XI+OcD2gBPoLFxCHhBoL0d2M0f6Ys1x6u3ZOAQfwplasDgf7xN8tuLj78SjZKLhhf8gnkPasBllHRoX4q8EocAojNdF8d+ryVB5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com (2603:10a6:150:84::17)
 by DU0PR08MB7995.eurprd08.prod.outlook.com (2603:10a6:10:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 09:45:25 +0000
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54]) by GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 09:45:25 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
Date:   Tue, 25 Apr 2023 11:45:13 +0200
Subject: [PATCH RFC v2 3/6] media: v4l2-ctrls: add lens group status
 controls for zoom and focus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-feature-controls-lens-v2-3-faa8ad2bc404@wolfvision.net>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
In-Reply-To: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     libcamera-devel@lists.libcamera.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682415922; l=5400;
 i=michael.riesch@wolfvision.net; s=20230425; h=from:subject:message-id;
 bh=jTe/P0FictDH0WXUKp4+aPsn/OR0dr8kofVL2EiodPU=;
 b=q+A4kfSu5mcb74thT71W0+NUs8JKLAvBQnN4oe+mwNlYiI9s0a5IS8ab/NrMWzdGOWMGIOtQm
 jYP3VNmdccTB+y15tld68yx3ooPyKxoPA6VxIYpNm+B3DQ1gJJN6TaW
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=1QQdXA2QbwdxaQn/VQK0hz04C8IBYhDowbK0hlNU4Ng=
X-ClientProxiedBy: VI1PR0802CA0032.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::18) To GV1SPRMB0046.eurprd08.prod.outlook.com
 (2603:10a6:150:84::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1SPRMB0046:EE_|DU0PR08MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: c9bbbe5b-b84d-4d9e-12df-08db4571cb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCeHmzylZzfasjO4Jxrz/E1vxsIZsEQJdCArZxUNgdZ1pJUPT2qKcn2d5B0pa0ZjwCulumhU/7lIIOkT7OylzKvxDyhdIXjRlTDydTHQpO46WrtXyIttEtgbXIgyGk0zBU+VbxRPxgaIPgvTLYcaoIIuYOrHJcvHfuvydZLR5q8+bOSmpT/I8hvv4x9A1lOoxTzF2JIRpYYPDWSoDH/fdm+7fn4+QIC2EgbqLpeABfKGtAr8CVToHO9udlu+pdH7PRYMYOeWsM6O0wNXlS1Au48/1nSCfYULB/dz5qXji/j82ugHujPqFVOrGzvl+PEOo1NzVQj46Pkf8xDzJdaZgxST9ugh3p5zg+XYdDa0utL93bUoRY/ObPq22ko7kK8GrE156Y0OxUgcj0xxcM9+5CLIrNdwTrBHdVYHteu3hbeT/Xft2i/OuXcQaYkCpwTAi8+kdkwYMGXhXyCJu02T/NkTjLeY2fd5r+7bPI98ykqcS3/DxpmDjmy/lb7dPW5uXRT54R7quEvZ5jwqC1XU5MxCWkZBXXOACK20MFS2Cl+5VpUy/70bCOS5G8VKVx/mAA5eUAz4SKHLpMHPjPhDfS7cGogpJ9dJ6pIz2wlmvQKeGqZTRdPtLIVTxvkeVTRD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1SPRMB0046.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(38350700002)(38100700002)(6506007)(6512007)(26005)(186003)(8936002)(2616005)(83380400001)(107886003)(44832011)(2906002)(8676002)(5660300002)(36756003)(478600001)(54906003)(6486002)(52116002)(316002)(6666004)(4326008)(6916009)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDVhMjNUYmU1ODlkREtSNlJTZ21jSzkxM1kvdG40Qk9xWDcvWjhEWllvcTF2?=
 =?utf-8?B?b1lsMXNld3dUcit5VEh2bzRWMk9ER3NyTUhJeWpndXZrNDIvZHFEWHgwQ0JC?=
 =?utf-8?B?dmlxV09Qb0VnTlV4NVNscmdTalZnU2IxbmprNDFHMGlQSmdFS09OSjRaK3ZJ?=
 =?utf-8?B?dmU5TDIvT2JoWXlTc29BeUNlT1ptc3pHS2JrWmQ1dmtneG1SYVRrVi9JaTFT?=
 =?utf-8?B?VU4vWStRd1V2SlE3OXZmNGhuKzI2VVBnQXN5QVYzamplRk1sSWtXRUp2SHg1?=
 =?utf-8?B?NDNqSVd3azYwR0xpdFlKc3VvbmhETExIOWFHb3IzWnY5ak5IaHBEMjJLb1M0?=
 =?utf-8?B?MnZWRXpMR0tjQjRmVVlTU0htK1JqUVJMQWZWc3o4NFVFU0cvM00vRDhlQ3pt?=
 =?utf-8?B?c040MklHdUV6eDA0VjVRVWp3V2Y4aTB3bWZ0aHBibXRGYXNsRmttRkVjREM4?=
 =?utf-8?B?R3R0V1VsRzZNSkdmc3BlL2dIMU1RMkFJWjVuS3ZMbDZXQXBKVjE0emc1NkdR?=
 =?utf-8?B?bkxBbnJ2L2RnOEZGSThzb1FkWlc3OWg4WDJuQlN6c1RTNFMvb2grdlY3Mkgw?=
 =?utf-8?B?S2I3VE93c3VYRUhyc2k5bXl4VmJvU09pdEZDL3RQYXhzM0l6WGJmQ0NnbFFW?=
 =?utf-8?B?VHY5WHdYdTByNUMxQ050S29jUmllWFZRUUhLMFRoUnc5RmdadGt0eENVa0dy?=
 =?utf-8?B?YkVWS1FsZHZ0bkZ6WHQrTlhPREhpaDR1MkRPK3JtcVZRWkxid3JWRVUyS1Js?=
 =?utf-8?B?L1lFcXFkQ0ppUmExYmIvc2hBQ1ZYMzhRbnFqQnNyV1hsTGZySHdIcG1lbDJP?=
 =?utf-8?B?T21peng3eXUyeStMNTQra2lZNWxaYTkwK29WdGp3RXY2SVJKRFNSbFNyNVBR?=
 =?utf-8?B?SmJraEZiQVFHS0FXWGM2ZTczUXYzNDAvUzBJZ1I5TzdtdG1TN0FVdjlHaytr?=
 =?utf-8?B?OXhKUXRIQ1VpaWRDWlZMQzFLSThLU0Z1eGd2U09tWDV4K3Y0dk1mYTNrK205?=
 =?utf-8?B?ZWJsOWhYKzFYbXozYnAwK01LeFB3U3RyRXpkd3FobXp0TGtrcWRoK016U21L?=
 =?utf-8?B?TStHSzFrcjhwVGVyN0drVTViWUUzU0gvWnVBdlNxeDdnTnBocHpKUlpSWE1W?=
 =?utf-8?B?Mjh2K3J2TjVRSVZWNXhLcmxBN2VjOGJkMVZpekFKSjRSTE5BR1RDYTNRUHZK?=
 =?utf-8?B?TjlpVUtwWFVKSEpjbjhFK0FlRE8wVW5MN3lLTWNRbVRuSktUaTF1R1lIYkRp?=
 =?utf-8?B?eHdiTDRHbkFJSmczcnprNi93NEg1TThjYzFBWmZRZ055NzZlcTk0dU9HaUJD?=
 =?utf-8?B?OHB6YnIyNnhXU0Z0eis5YVlnZDR4ajlMMWZ1MWZKL1FaTWlyUDZ2bE81Zm05?=
 =?utf-8?B?U3F4M1YxQTRtdm5DMVcxamFFTTR4cldzTk5qc09USnlhV2piTEo5SzJjK1B4?=
 =?utf-8?B?Vks3aXZVQ2ZIYUNycnk5SVFabVZwVjJUcndjWWZSSjlBUW1rMnFYU3ZjUkJj?=
 =?utf-8?B?bG9nU3ZCWld0ai9KcDQzVWFIbkRXRDVwbDdibFlzeDFSaWhpWGd4WDlEQU9y?=
 =?utf-8?B?em9uVDdBekhBWURFWVJTdFVwMTJGQWRaQys2WlpXMkYzU291a2pMcjh0OTNT?=
 =?utf-8?B?eENoU1RWdUVYVjBYZ3JNejVkTm5HWjZMdDFQeURwZks1NmFzdGxUcVdxQjFT?=
 =?utf-8?B?RmN6bG5GR3didnZ0cjN0bm9KeXVPTlgyOU5BM1BpeWtQWHRSMGU0Zjl4U09P?=
 =?utf-8?B?YVJZMW5UcWFRMVJaMWIraWh2QVBFeUlqZlN6dFhIZ08wWWNiNUpScWxvUzgv?=
 =?utf-8?B?cnM3VWJNcFVIUUNtVTkxS1F5bllTYm85R0ZoeGN5cGxnOEc5RDB3a1EwMk9j?=
 =?utf-8?B?Ulg5MDl2TUhyclphdlFQUkRpZk9vVzRsMjZJbmJNbmN5STZvM3RTRUwxZGhQ?=
 =?utf-8?B?OFBHVnhjZjZYRUlWTHNtZUllM3BJTzdiRmJGaThsRFNEQm5OaDlQMFAyYkxm?=
 =?utf-8?B?OHIvNEtPUlpyelVKY3poRG9ndVVJZDN1WmtUcm1MSGx1WWc0OFlFSEgxdVRl?=
 =?utf-8?B?MDJPZzlmVTR3ajBEYzBmcGg3cndRa2pRK2V1NlVQZ3BRT1pvam9LczNiOCtV?=
 =?utf-8?B?UzM5QjRPM3FYUTJkY0NSUFFSalRnbHlOYmZYUVRXaFdmNXdmeDdHeSs4VUxK?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bbbe5b-b84d-4d9e-12df-08db4571cb9c
X-MS-Exchange-CrossTenant-AuthSource: GV1SPRMB0046.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 09:45:25.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBtpHv1xbmlZF57ajBLFX6fQh5kB4SJyuslA6EDvQY0EoCKob87W/Cq83ZqLjBoGFgcsop658jp/A2wJj8qgmXcsxaZHeU+j8+M1kBZd4Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the controls V4L2_CID_{FOCUS,ZOOM}_{CURRENT,STATUS} that report the
current position and status, respectively, of the zoom lens group and
the focus lens group.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 46 ++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          | 10 +++++
 include/uapi/linux/v4l2-controls.h                 |  9 +++++
 3 files changed, 65 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index 42cf4c3cda0c..3ea4175f9619 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -150,6 +150,29 @@ enum v4l2_exposure_metering -
     write-only control. It should be implemented only if the device cannot
     handle absolute values.
 
+``V4L2_CID_FOCUS_CURRENT (integer)``
+    The current position of the focal point. The unit is undefined. Larger
+    values indicate that the focus is closer to the camera, smaller values
+    indicate that the focus is closer to infinity. This is a read-only control.
+
+``V4L2_CID_FOCUS_STATUS (bitmask)``
+    The status of the focus lens group. The possible flags are described in
+    the table below. This is a read-only control.
+
+.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_LENS_STATUS_IDLE``
+      - Focus lens group is at rest.
+    * - ``V4L2_LENS_STATUS_BUSY``
+      - Focus lens group is moving.
+    * - ``V4L2_LENS_STATUS_FAILED``
+      - Focus lens group has failed to reach its target position. The driver
+	will not transition from this state until another action is performed
+	by an application.
 
 ``V4L2_CID_FOCUS_AUTO (boolean)``
     Enables continuous automatic focus adjustments. The effect of manual
@@ -241,6 +264,29 @@ enum v4l2_auto_focus_range -
     movement. A negative value moves the zoom lens group towards the
     wide-angle direction. The zoom speed unit is driver-specific.
 
+``V4L2_CID_ZOOM_CURRENT (integer)``
+    The current objective lens focal length. The unit is undefined and
+    its value should be a positive integer. This is a read-only control.
+
+``V4L2_CID_ZOOM_STATUS (bitmask)``
+    The status of the zoom lens group. The possible flags are described in
+    the table below. This is a read-only control.
+
+.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_LENS_STATUS_IDLE``
+      - Zoom lens group is at rest.
+    * - ``V4L2_LENS_STATUS_BUSY``
+      - Zoom lens group is moving.
+    * - ``V4L2_LENS_STATUS_FAILED``
+      - Zoom lens group has failed to reach its target position. The driver will
+	not transition from this state until another action is performed by an
+	application.
+
 ``V4L2_CID_IRIS_ABSOLUTE (integer)``
     This control sets the camera's aperture to the specified value. The
     unit is undefined. Larger values open the iris wider, smaller values
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 564fedee2c88..794ef3ab0c02 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1044,6 +1044,10 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_CAMERA_ORIENTATION:	return "Camera Orientation";
 	case V4L2_CID_CAMERA_SENSOR_ROTATION:	return "Camera Sensor Rotation";
 	case V4L2_CID_HDR_SENSOR_MODE:		return "HDR Sensor Mode";
+	case V4L2_CID_FOCUS_CURRENT:		return "Focus, Current";
+	case V4L2_CID_FOCUS_STATUS:		return "Focus, Status";
+	case V4L2_CID_ZOOM_CURRENT:		return "Zoom, Current";
+	case V4L2_CID_ZOOM_STATUS:		return "Zoom, Status";
 
 	/* FM Radio Modulator controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
@@ -1593,6 +1597,12 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
 			  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
 		break;
+	case V4L2_CID_FOCUS_CURRENT:
+	case V4L2_CID_FOCUS_STATUS:
+	case V4L2_CID_ZOOM_CURRENT:
+	case V4L2_CID_ZOOM_STATUS:
+		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
+		break;
 	case V4L2_CID_FLASH_STROBE_STATUS:
 	case V4L2_CID_AUTO_FOCUS_STATUS:
 	case V4L2_CID_FLASH_READY:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 5e80daa4ffe0..793ee8c65e87 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -993,6 +993,15 @@ enum v4l2_auto_focus_range {
 
 #define V4L2_CID_HDR_SENSOR_MODE		(V4L2_CID_CAMERA_CLASS_BASE+36)
 
+#define V4L2_LENS_STATUS_IDLE			(0 << 0)
+#define V4L2_LENS_STATUS_BUSY			(1 << 0)
+#define V4L2_LENS_STATUS_FAILED			(1 << 2)
+
+#define V4L2_CID_FOCUS_CURRENT			(V4L2_CID_CAMERA_CLASS_BASE+37)
+#define V4L2_CID_FOCUS_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+38)
+#define V4L2_CID_ZOOM_CURRENT			(V4L2_CID_CAMERA_CLASS_BASE+39)
+#define V4L2_CID_ZOOM_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+40)
+
 /* FM Modulator class control IDs */
 
 #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)

-- 
2.37.2

