Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0D6EDFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjDYJpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjDYJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:45:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F945BB2;
        Tue, 25 Apr 2023 02:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HszOafWLizJmLLAS0BeqYpPH5HJiV1hFD9FYCXcCPxt337+KntsR0VzZe2DATHJ3NlBSgkPkBkys7qhTlFMAFHZogA6Qzf5/NXTNT9spc0IWhmnlP/QpxuNNZsLV0C6Aigj/ga8PYQFwdJlK0GF2WsFcS9MKXs1gZznv6Fc3rw5oXr+YA5I/9DfVzwrymv27ORafTs7cSuw6xF32sQraVa3iI0OBqgY6deoQdRj4NToc0FlxcTKWLQBA+toaNkXHLcDn6zltE7210P55ntn/s8V2EjjLJ+BffvFiTV8/9Pgb0WWXsg9PzgReKoBlp7uLwgP2G2FzcEykNx9iCTojWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9L4rxpaXgwZR1SpW0PhoeHRM5AL+j9I5cwCshNlZtQ=;
 b=hbN2EyOAncsVksHPzyCNv7DQ2lQGppo64m9vGATUzQUGJQwxevRNbpEQdjtLpAcA7W3awWO/9srOtlPQleq41R4lXYBkIoFbqwSXI2l/bZBAdY7GQuH1T60W6FOr89kSejhouYlWv40eRRL2BW00IgPjxuF+Yo9LyfmFXoykkx9/BXpKGmGP/VwI36yeMj9zzSfA/0fQETn8uYj/IplQluMzMrNp8ypjGpDI7pGVOEZRe469cwe3x5VURd4j3LigPHIjGCSivr7IKJv3dHpjhjo36eRnKP57L9VQav65WASIe39/ZXPWKVUzSqGQqPmNkMsnRCtumunW8nn1Rg+ICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9L4rxpaXgwZR1SpW0PhoeHRM5AL+j9I5cwCshNlZtQ=;
 b=a8QChJCEMmKr73zw2P2/l6GbvZOWwggbxSnSFBRwNWOMHhVRepHgllmsbisslsTbuIY7uPadr2bVmQRFU/UgRM0XCK6cvUjRrsemQwxpswzn0AgpWOSBqHFbGwGMhRk7dL4xgWnXYo6Ok+ghpikkeJQ1/q6ZPZEIjOw6SDsEOaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com (2603:10a6:150:84::17)
 by DU0PR08MB7995.eurprd08.prod.outlook.com (2603:10a6:10:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 09:45:27 +0000
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54]) by GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 09:45:27 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
Date:   Tue, 25 Apr 2023 11:45:15 +0200
Subject: [PATCH RFC v2 5/6] media: v4l2-ctrls: add lens calibration
 controls
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-feature-controls-lens-v2-5-faa8ad2bc404@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682415922; l=4669;
 i=michael.riesch@wolfvision.net; s=20230425; h=from:subject:message-id;
 bh=eBONwYST4/o4m/pM3GiTe2/yHf9eJ+FpTy4YFguoSfM=;
 b=05kJGQQHrBJOZwxhgSBVMl05LtTi7ZYnhIqYBAA9ATK21S0LkL+mXt5n5zyx89NrQwFYRX5Kc
 /Yvljyu9qGPA6O+zzXPHpKTr7leFKi7qWjL31bs2YiphKJO/uGyh1bo
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=1QQdXA2QbwdxaQn/VQK0hz04C8IBYhDowbK0hlNU4Ng=
X-ClientProxiedBy: VI1PR0802CA0032.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::18) To GV1SPRMB0046.eurprd08.prod.outlook.com
 (2603:10a6:150:84::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1SPRMB0046:EE_|DU0PR08MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: b12e232f-c01d-4f9a-6f6f-08db4571cca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idgigqa4YGrVoh1U/5n2R9ELYwHWXlGLq1oUqzrkfenjG4uiTH3OzhTPCKYBBC32dU8xDmw5XuyqpTgR+X5JA56PkFP2eMML61WoocJblnx1ysJIU9OvrMeg3sIQT9jGM7eOQkIN6QlbMKdqtlxBXpS3DF2Sj6/4mrvOiTiyuZUe6NkqzaSm4jWw9nSPTeVcl8JkKMlS9uF2kayeOAvCUA+eeGpC9XjwxeS+UaUO/tc2xSlrZBjHJd1hDpd4xl3f1k/5hSTZt/7EBzXEkeJRffysSlELpJSWn0CBR9dfHUYaRyqseMVYYSealGrt/fYJa+MteHP77ZVEgUqDSCS4HOmUdIYfT7bk/gstfUFRQhtiuN/4GcTcjQq97RCGjCJzK56LyCde4hT8Ebi7uql0uqT1O5ZpVIVAkSHHAeUAMkLTn0cxkHrMTy7Mirn5bvZzH+/HQrdKfyn5cxJj/wzSd1Kt1q5Jx1mynMmjFwqiIL+NbPK1EpFuZthCchlwN5zfxeiFGzCXzCHGmy4lU1hnIc55NjLj6CWR5emVcty7jssMPmVpek6q/h6PsXxXXxRG391tdCGiofMYUH253XpPPEx5MAKHlriZDzBLEezH3TQVAfpbHNsXNI6YHexKRrIr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1SPRMB0046.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(38350700002)(38100700002)(6506007)(6512007)(26005)(186003)(8936002)(2616005)(83380400001)(107886003)(44832011)(2906002)(8676002)(5660300002)(36756003)(478600001)(54906003)(6486002)(52116002)(316002)(6666004)(4326008)(6916009)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um1ueVk0UWdlS0IvVEQzSSt4czI0VWErODVlaWhoMHl3WHVKbk1ueEFic3ds?=
 =?utf-8?B?d2tUUGVPOTFhdExkNFdJY1VnaTAyWE9neitOSGt3NDlCVGd2SVFvOEliVy94?=
 =?utf-8?B?SVZXdXM0bjhTdUF3N2Vwa1g3dmw3RENlamNtNisrOU5nNTlsK3M3cHZESFZH?=
 =?utf-8?B?NWxiRm8rTjJxTWtuRkNaR0dBZVJsU05kYXBZWVZWaHdmbzlWMDVYOTRON2xz?=
 =?utf-8?B?TTcybnYrWTBtSEdMUVlmSVhiVmV5NUpZcmZHT2JmV3JMNnVBVlZqZFVaMnJr?=
 =?utf-8?B?Y0RUbE4zdkNyVUJuN24yY09tbEdYY1ZieSsybU5yVzBVRHU3RWI4OXV3dGY1?=
 =?utf-8?B?ZnRWdmRLUlMwcFFYV2JrUFJMa095djc1cDZ3TXZpT28zNmY3L2dIOWRiSHJ0?=
 =?utf-8?B?S2pyZ2VBdzdmN1d2UWJaeGRnTkJXdUN6WTlBZDFXb3lsUkF1TXBkZXdGcm5Z?=
 =?utf-8?B?NnhuZUMrZHRZSzJVTFFERW02V3pmKzZEKzRLT054OGRTSFpQck1KeG44dnhC?=
 =?utf-8?B?ampkM0YydWZtNGxSSjgxNGF6MWNYSXFzUnFmMDB0Tkh4d0ZIWTJLNi9FNXBR?=
 =?utf-8?B?NE9EK3lkMkptdjNacEUxMXBRcSszVGdIV1JzbkIvUkVUd1o3TTNMQTdkVmFi?=
 =?utf-8?B?b0IwVzFMcUJuTGZ1NGtWZ0JaRG1xazM1R2pqb1hVdVRWcGhwNmRyOGRhblJD?=
 =?utf-8?B?elJ6ejNXNDhBcW5iSU9yVk9oeWV1SHFXOUNWdEp2N01oVEVUSDduczNya3JX?=
 =?utf-8?B?bmh2V1B3WVphd1NRSVZTZnMvZ1owTlpUWGkxcDVqZG9qL3Y2ZE1yWU1Wck4y?=
 =?utf-8?B?dEcrVFpUZnhENXJSeVFzWkJyMkFKR0dadkM1WEZtK1V5cW9ha0p5M1ZyVWpQ?=
 =?utf-8?B?SmpiQU1JRmVFZXNiM0xOYWZlV25BcXY4RWdrTXFVN3V2OUhZVDB2NVRMTzht?=
 =?utf-8?B?NWRyUi8xRFVJaVpJTzU5YWpvcFZnOVhpaTJLb3VIVWFvZjJ5MnhVYWgrbzNU?=
 =?utf-8?B?Zk5KRkpHbG5tb09lbVRrVXovQlh3SEwzeS9zdnpHK0JIRVczZ3l3SFE0N0Ix?=
 =?utf-8?B?Ty9DSGJ4QjlqNTd3bGtVODRvN2NLWmxZNnVvT0dKN01aTVU1T0F6SEVqb0xR?=
 =?utf-8?B?ZjB6ZFJyZ1ZYODh2amt5NWdzakcydExObzVWemFpS0FSeXFSVHRRajludWJn?=
 =?utf-8?B?b1JobTJPbmY3c1c4bGFEcnVOVk5RNlk5NW9OYnNhZmR5UzQ4MzhPbTlYajQ0?=
 =?utf-8?B?NkVpeDNMcWE0ZmVSemNsZWNGTTVZd1ZmVWUvNFpHaURGWTY0cXdXcU1uelVP?=
 =?utf-8?B?U2VxajZMZHE1Wm1VVzdkTUxqWnRaamIySUhLMUNra2s1bTlvR2tkMjRtV3dG?=
 =?utf-8?B?NE0wSXA1a3BuQUl1L29BSTJaZ3d1NExrc0dJMWxHRnc4MjJPRlJyWkVnYVJn?=
 =?utf-8?B?bm42N3g5dXpXYVVuazZ0dkpjakN6d0xEd3l4ME5QU0x4QU1nNkVYWDAvdCtv?=
 =?utf-8?B?UHRmcm9pMTN3QW41ZXJkSUJQYlJETHBncURQZmN6K2ZLbVNUaVpVcjNRRC92?=
 =?utf-8?B?KzVDQ2txTlVSb1RDWWZHQlYxSytiMUxNVklnVDB4VFNuWVRWaUlTMmN5K2hv?=
 =?utf-8?B?ZG9IU1lpVmZNT0JBaTFIQitFVEszU1QvaXhOUzNwYkZGM0VDcC9QcE5xOXBh?=
 =?utf-8?B?T1JMUXp2eU9uV1BTV1lQdy9pRUFYanRvMXZXZ3R3bVU1RGMyL01XRkVBTkp1?=
 =?utf-8?B?NzVLeTF2M3JYaGVsQlRpNFNhRmU2ekc0Y2UyWXZOZXAxZ3lKalFQdnI2a2ZI?=
 =?utf-8?B?Wkh6WW82SDBHMTJ6WjBqUC9uMFIySXNIM3ZlVWZiWmwwSDJoVFo3bVNFSUIv?=
 =?utf-8?B?OUZKazNTMXd4WFRSTDJIbERHUkVnTmVsSTN1SklwM1UraVhoRXMydDY5QmRM?=
 =?utf-8?B?TzJyZGxPU25OMVJyNFlNMzc1a3VUeWkxTzEremR2VXNIRU1aVmEraUxiOXh2?=
 =?utf-8?B?cFZ0dXVpRGxYak5maUdCLzVrZnNvM3I2ZnNLWldJZWdQUldBdElBTXE4NTRq?=
 =?utf-8?B?NXlYQUZ6Q0xXKzNZOGxuMGo2Y0hyMGI5MXR3Vk5Wb2tnYzQzUEh6c05wb2Rq?=
 =?utf-8?B?bjRhaEhuZ1NYNkxYU1pQOThtRmVSNWR5Wkd0VVdmb3ora3FlL0Z2ZmhwWHRZ?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b12e232f-c01d-4f9a-6f6f-08db4571cca9
X-MS-Exchange-CrossTenant-AuthSource: GV1SPRMB0046.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 09:45:27.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+XRvhBZV5u3cUQ+AyxExazL+pzJY/by/wOjuHVLUFyD4i0wrDfcu4RnZXLr2ibOE7+HouCBOQ5P687sYzLD7BZGrDoZ3REvmyNdoWpqdHE=
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

Add the controls V4L2_CID_LENS_CALIB_CONTROL and V4L2_CID_LENS_CALIB_STATUS
that facilitate the control of the lens group calibration procedure.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 35 ++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  4 +++
 include/uapi/linux/v4l2-controls.h                 | 12 ++++++++
 3 files changed, 51 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index a17620ab03b9..8b54a0f3a617 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -297,6 +297,41 @@ enum v4l2_auto_focus_range -
     (V4L2_CID_ZOOM_ABSOLUTE and V4L2_CID_ZOOM_RELATIVE). The unit is
     driver-specific. The value should be a positive integer.
 
+``V4L2_CID_LENS_CALIB_CONTROL (bitmask)``
+    Control the calibration procedure (or individual parts thereof) of the lens
+    groups. For example, this could include the mechanical range detection
+    of zoom lens motors. This is a write-only control.
+
+.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_LENS_CALIB_STOP``
+      - Stop the lens calibration procedure.
+    * - ``V4L2_LENS_CALIB_START``
+      - Start the complete lens calibration procedure.
+
+``V4L2_CID_LENS_CALIB_STATUS (bitmask)``
+    The status of the calibration procedure (or individual parts thereof) of
+    the lens groups. This is a read-only control.
+
+.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_LENS_CALIB_IDLE``
+      - Lens calibration procedure has not yet been started.
+    * - ``V4L2_LENS_CALIB_BUSY``
+      - Lens calibration procedure is in progress.
+    * - ``V4L2_LENS_CALIB_COMPLETE``
+      - Lens calibration procedure is complete.
+    * - ``V4L2_LENS_CALIB_FAILED``
+      - Lens calibration procedure has failed.
+
 ``V4L2_CID_IRIS_ABSOLUTE (integer)``
     This control sets the camera's aperture to the specified value. The
     unit is undefined. Larger values open the iris wider, smaller values
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 3ef465ba73bd..faddfecba6d9 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1050,6 +1050,8 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_ZOOM_STATUS:		return "Zoom, Status";
 	case V4L2_CID_FOCUS_SPEED:		return "Focus, Speed";
 	case V4L2_CID_ZOOM_SPEED:		return "Zoom, Speed";
+	case V4L2_CID_LENS_CALIB_CONTROL:	return "Lens Calibration, Control";
+	case V4L2_CID_LENS_CALIB_STATUS:	return "Lens Calibration, Status";
 
 	/* FM Radio Modulator controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
@@ -1596,6 +1598,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_FOCUS_RELATIVE:
 	case V4L2_CID_IRIS_RELATIVE:
 	case V4L2_CID_ZOOM_RELATIVE:
+	case V4L2_CID_LENS_CALIB_CONTROL:
 		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
 			  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
 		break;
@@ -1603,6 +1606,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_FOCUS_STATUS:
 	case V4L2_CID_ZOOM_CURRENT:
 	case V4L2_CID_ZOOM_STATUS:
+	case V4L2_CID_LENS_CALIB_STATUS:
 		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
 		break;
 	case V4L2_CID_FLASH_STROBE_STATUS:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 8d84508d4db8..24c0eb5f4d29 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1004,6 +1004,18 @@ enum v4l2_auto_focus_range {
 #define V4L2_CID_FOCUS_SPEED			(V4L2_CID_CAMERA_CLASS_BASE+41)
 #define V4L2_CID_ZOOM_SPEED			(V4L2_CID_CAMERA_CLASS_BASE+42)
 
+#define V4L2_LENS_CALIB_STOP			(0 << 0)
+#define V4L2_LENS_CALIB_START			(1 << 0)
+
+#define V4L2_CID_LENS_CALIB_CONTROL		(V4L2_CID_CAMERA_CLASS_BASE+43)
+
+#define V4L2_LENS_CALIB_IDLE			(0 << 0)
+#define V4L2_LENS_CALIB_BUSY			(1 << 0)
+#define V4L2_LENS_CALIB_COMPLETE		(1 << 1)
+#define V4L2_LENS_CALIB_FAILED			(1 << 2)
+
+#define V4L2_CID_LENS_CALIB_STATUS		(V4L2_CID_CAMERA_CLASS_BASE+44)
+
 /* FM Modulator class control IDs */
 
 #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)

-- 
2.37.2

