Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A49D6EDFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjDYJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjDYJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:45:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F65C15E;
        Tue, 25 Apr 2023 02:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdJfWUJamBHEzqqzWnYt4XpKtzL5MDYgF+9ydAA5N4bf4eSqvJpL62JmWWKYjNml+FDmsDP7/KH0B6wIghCO5+gflNEuOekYjWvKaGBJ4P969/q9kwNgqNo5NzPZolrzF5q6KA8yloHVydUyMzHW+ammKImtT9haAZOqruL3cuBLXxfIkIVr3R6rCbWtpS+gIQJqVPN+QJwPyv8pE/LHcUg5ZsUmqqtDyLa8lX+m9/1of3pJfZrOIiT5gzKW6vUMtnx3z2uhyLCwTEHJfiRxQu4Mk8Nq5hcsMRiyNBw1mpNHYTaQf84iuIRCI5vdmg/8bEl5nDMQN3C1Se8GjB5csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQrDJvOM/69KPMgS9CzR0tv6l6Kk/FgdIf0NDXzqS9o=;
 b=nmWs6dPydYgDFO7jmKiUUuT9zZZRGz3k9DOEJ+jdNLft5UHqj/EpHrwP9zpean0DvxU1R+bPWTTaARHmgIlNamloprvghLZCn4B2BsehMN8GoPY7khFtdkDQmhrbzhRWoIPOxBlGnQfFfYQjztXCVRUeeyyg9vCWVnXW4+dKIpEOTOTvncDiAiNV6X01fC6J265BZf/GExkdW50r1pU8x9yA7RSnt60ktO9M85px3xGA233DY16FVuYgwTzzncCgh+8CffS63+M8RZEtI8pDwQbhT1BNTl4lVtSj96LK1TCswH0gm5P20HJiJBY8V0Jr37njhZ/WblUp6akvBidZ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQrDJvOM/69KPMgS9CzR0tv6l6Kk/FgdIf0NDXzqS9o=;
 b=kmt1j1fbhlj+T8jn1r+/bbqM/g6CpYDcnOsKTQjCEDfEdMRdtmND7LOsktXd8ei2BuirNzSEe2pu57+jlzP7+iYx32OzFtbQFmDCrG00/HjZTiVTQFPw/P+WXboPNsHksWgMRc9UdfO2fPDmEefc7WuCvvFYZoJjnrznfzJW2sI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com (2603:10a6:150:84::17)
 by DU0PR08MB7995.eurprd08.prod.outlook.com (2603:10a6:10:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 09:45:26 +0000
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54]) by GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 09:45:26 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
Date:   Tue, 25 Apr 2023 11:45:14 +0200
Subject: [PATCH RFC v2 4/6] media: v4l2-ctrls: add lens group speed
 controls for zoom and focus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-feature-controls-lens-v2-4-faa8ad2bc404@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682415922; l=3264;
 i=michael.riesch@wolfvision.net; s=20230425; h=from:subject:message-id;
 bh=B6OiJRa47o14LtJJ73V2E+VFtxvPLWW9YHiaI+U9DCE=;
 b=JtypR8MO8CEbYK0b+q55Wzuz0OY62YDr3AARmuBx0AF9uIg5IbZwZ8S57w/DXaxkykw2d5KJI
 VLue5UZQOq0DHIWfSvqtvLD+7Zrn6KwjslShkZGLCNLDlRFVQdYK5dR
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=1QQdXA2QbwdxaQn/VQK0hz04C8IBYhDowbK0hlNU4Ng=
X-ClientProxiedBy: VI1PR0802CA0032.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::18) To GV1SPRMB0046.eurprd08.prod.outlook.com
 (2603:10a6:150:84::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1SPRMB0046:EE_|DU0PR08MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 977200d2-c61d-427b-c89f-08db4571cc3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hv1M7+ibVKiYX3nC/eM2IrwaIgG6SvaTOfVyvAdlq3E3aSI4euUwYkVFeyT6xCWrOCFLDd/vQO37CSdjPg7rBMKFskDHc+/BhS/o0loIaFVHZWxkRLnWWrAUdYlZsqgrCEWB4LdjQXUwH6mOLKHpdFQTl7IFyE5A9xMEP7OxFY3opYoOngCTGrbu7GPCsQQXptjBQNFqGWcEk5YlOsvCF60dK4K3YLeMcpIqYFe1JH4UOV2OnBk6LJei/aYA2hE9Ygd9psM+n2jXew7CWTgQZT8nRq+qCEIseuh1QJ3ez0J7LeJ07mFbCLbivn8wMU33UTo2/pj6NxUqJ6pr1fPhVSame0z4v2r8qyLYK41/2bTii61WwhllxKN/kYOQLabVu2dHpt+80w9yKntm3qzis01B6RVSNfkd0OIFXRt8RZymNBqNq2z6y/V1zyHWlNKG9N7Bob2olGjnG4biuvqRvzd0gHxihIh59dae8ZyIUfCR545X3n9e8ue9EGYkAu8E6CBM/XE+Oilyjet08SISe5ewH7CciuLc7infsOC1zisJQMzgDS2DigLo2TQMRadwkcqic1wq/Gx6a57POqKI5QIG8CVYwbWxbxdp8xFEYfL5Q0LJsMdJSF8WPYaLfGy4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1SPRMB0046.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(38350700002)(38100700002)(6506007)(6512007)(26005)(186003)(8936002)(2616005)(83380400001)(107886003)(44832011)(2906002)(8676002)(5660300002)(36756003)(478600001)(54906003)(6486002)(52116002)(316002)(6666004)(4326008)(6916009)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJJY08rTGVoU1BLUVZrS3J4OUtxemxZaGFQN3NEYnUxcHhJV0JpNERDRS9S?=
 =?utf-8?B?TEF0TkZvbzRBSXRCZTBkWGF3WjByZ0tkV21nQ2lDYUxyN0tzaHN3cnRob1l1?=
 =?utf-8?B?V3ZaaWpZMHoyMkI1cm5XQkkrcVpoQStzMmpJYTU1b1BiQVNpSmd6QnlWOE5n?=
 =?utf-8?B?NkdSQkcxUWlqQ0RCSTduM1FmVzN0NnV3YlVvakROT0FMVWh3aklpNURod1k4?=
 =?utf-8?B?QTlyb29JWllTWHNXT1hxV0dWelZiNkE4d3lrMmF0UllVY003cEtQZjFJYllX?=
 =?utf-8?B?VGVEUFNrZWJWblozQUFUMFNXZks4c0h1MkFRZSthRmd2a2VnKzV5QmhwMThG?=
 =?utf-8?B?eTArcUtDUnhpNW5nM2g3MHBxRWQ0Y3IvY0lQVmVSUG1scjg0TXYraXlmb2VV?=
 =?utf-8?B?U0tSQ3RrSWtjd0lVdHo4dVBNTnFmV0JlSHZVVHVxSkFpMkMwVEVQazBSczFR?=
 =?utf-8?B?OUw3d0FZQkVLUVNzVzNRVmZ0NGd1dmhuMEMxb3RheHBUZVNvYjVVRitvOS8v?=
 =?utf-8?B?TnU4aXhmcVRTUkMybUZmcXl4K1ZDdTI3cnoyWUF2K1lvUHJ4MUo5Z1Y4eVhq?=
 =?utf-8?B?aXg2SFByMGpvcklRVWxTdGU1Z2hUT29VQzhTeUVzTS9wUVRidTl4T0QzSG9Z?=
 =?utf-8?B?ckQza2RjWHRlZDI1UmJFdlJPSDMrTnIwTVFJYVM2SWxFellEV3RhZFU1a0o4?=
 =?utf-8?B?a0FxTTRGR3FqV3FBalNUU2hNQlVjVGxwUmIxZzYzYVAwY3phMnBVdnR5V0xh?=
 =?utf-8?B?RXBEWElYSG9LTjNrbU5pTVF3YUMwVUpvc1B4UjVUY1BDaHBta1REdk45Q3pj?=
 =?utf-8?B?RGw1MXlyVkpHUW9nMEw1SnpPUTZxK0FUWml2YkpoZU44czN3aTdLSy9OUVp2?=
 =?utf-8?B?TzUxYWpyRTZVbGFodFF2NytyclFsQXRzZkJGcmtSRTNSNGZpdkJGUHNsT0JJ?=
 =?utf-8?B?c2x1V0VaLzRUWVFKejBNd0UrMFBoRWFpSXdsOEduUEY3Unc2eVM0N0Z1ODZV?=
 =?utf-8?B?TXRJMkY2dE04OExWNk5zbC9yZzIyb2xMelhONFFTbUkxMjIvRzB6S25xQ1dl?=
 =?utf-8?B?S2NYQUlTNDAwNUZFYnBuV2x1VDdqeWtWV1lUYjEwNkZpeFk4RzhOdVpRMWJL?=
 =?utf-8?B?RmYyaDMrU1MvMnR0aUp2dEZ2U0lGcEYwcmVzeVhHckFrejh1Zm1JdGhtMUw1?=
 =?utf-8?B?NFJFWkdVREZHNzZwMEtucTVBeTAxckNMVWdoeXZaYWJzZmpYNEZHdGVWNXE0?=
 =?utf-8?B?NEEwc3NQcFZYa3IvQVkwU2xudzJiWTlpL2kvYjJXYmZzMldodFZPYlJZaFIw?=
 =?utf-8?B?bXRiZG5tVGlYZFNFQ2Q5TCtOWE9zOGV2UktNTE1xNldxSDJ1eFN0Mk9QVDUx?=
 =?utf-8?B?dlBQaWcrMkhobmprOEZ1MnVNNGJhSFZOQ2RuMzQ3RE5pclVtZDBIMUxRTzY3?=
 =?utf-8?B?UEhlM2pQVW15UERKWkJESXZZME1pU3dXZkVlR2Faa2pUQVhocmJmd0xHbkpD?=
 =?utf-8?B?Vkl1YW5pNW94MVJZR1JtSWtnWERINUFNUGVuem1LcnBBQ3RBRVdaR05WajdM?=
 =?utf-8?B?U0FCV3pNcVR2NU9yTldDUzlOSHdtSHFNdVgrWDRDUnJRelFGQ2ttK3lFSGlS?=
 =?utf-8?B?TEtxQkM4d21nWC8xa1FodTFUdHg0OTNIUncyZXdTdGpDdndDeERqZDlLS1pE?=
 =?utf-8?B?VFplRG5QYjhKRGhMTGV1Yk4xbElMNFlxOXg1djk1ZTBoUzczdElxRi8yMVVH?=
 =?utf-8?B?NFBBVXU4c1ZydFc5MnlpdG9LSmRxWDdCd29IV0V4VTVJbEdON3pQcS83QnIy?=
 =?utf-8?B?SzdpUExDei9oWFZ6MCt4eE1kcmYzU1hyQnllQ0x3YURFc1QxQjZWUnlZeHh3?=
 =?utf-8?B?dXVDRGFML3d6YTNQWVJKMVBRZ1hEaEJPVnN3N1RlY05FZ01SbmR3US9HRjMx?=
 =?utf-8?B?NzNmMGw0c3BXc0J4dDUvYkFPcHRzeCtkWTJEdHp4VmNVUTJObnlEM1pwK0RM?=
 =?utf-8?B?UmRIZzdyMHM4MnNFZmRwWndTU1AvUTJYNUxzMEVnQ1prRDd4cmUxbnZiV0xo?=
 =?utf-8?B?cnFtZWFHZ1U5ZHRjaU53ZjFTWXppK09IaDFZN2k2YkJNM3Z1bUxWUEo1Zlc0?=
 =?utf-8?B?QTFDL1BwY29sYy9KcURkdkExTTVRNzBWMVlhR2RxK3ZieHlWamFqeWVaanQ2?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 977200d2-c61d-427b-c89f-08db4571cc3b
X-MS-Exchange-CrossTenant-AuthSource: GV1SPRMB0046.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 09:45:26.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ic03Ri6QJsvjZMGyqp9jYpF2ZNO+BSdAVsqESARqVlQfY/J3uSdVBezToOgCBjDcm7NPxZUD2ByBa+8mgT713uaszDJmybSoHseu8lmJeQk=
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

Add the controls V4L2_CID_FOCUS_SPEED and V4L2_CID_ZOOM_SPEED that set
the speed of the zoom lens group and focus lens group, respectively.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 10 ++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                  |  2 ++
 include/uapi/linux/v4l2-controls.h                         |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index 3ea4175f9619..a17620ab03b9 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -174,6 +174,11 @@ enum v4l2_exposure_metering -
 	will not transition from this state until another action is performed
 	by an application.
 
+``V4L2_CID_FOCUS_SPEED (integer)``
+    Set the speed with which the focus lens group of the camera is moved
+    (V4L2_CID_FOCUS_ABSOLUTE and V4L2_CID_FOCUS_RELATIVE). The unit is
+    driver-specific. The value should be a positive integer.
+
 ``V4L2_CID_FOCUS_AUTO (boolean)``
     Enables continuous automatic focus adjustments. The effect of manual
     focus adjustments while this feature is enabled is undefined,
@@ -287,6 +292,11 @@ enum v4l2_auto_focus_range -
 	not transition from this state until another action is performed by an
 	application.
 
+``V4L2_CID_ZOOM_SPEED (integer)``
+    Set the speed with which the zoom lens group of the camera is moved
+    (V4L2_CID_ZOOM_ABSOLUTE and V4L2_CID_ZOOM_RELATIVE). The unit is
+    driver-specific. The value should be a positive integer.
+
 ``V4L2_CID_IRIS_ABSOLUTE (integer)``
     This control sets the camera's aperture to the specified value. The
     unit is undefined. Larger values open the iris wider, smaller values
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 794ef3ab0c02..3ef465ba73bd 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1048,6 +1048,8 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_FOCUS_STATUS:		return "Focus, Status";
 	case V4L2_CID_ZOOM_CURRENT:		return "Zoom, Current";
 	case V4L2_CID_ZOOM_STATUS:		return "Zoom, Status";
+	case V4L2_CID_FOCUS_SPEED:		return "Focus, Speed";
+	case V4L2_CID_ZOOM_SPEED:		return "Zoom, Speed";
 
 	/* FM Radio Modulator controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 793ee8c65e87..8d84508d4db8 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1001,6 +1001,8 @@ enum v4l2_auto_focus_range {
 #define V4L2_CID_FOCUS_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+38)
 #define V4L2_CID_ZOOM_CURRENT			(V4L2_CID_CAMERA_CLASS_BASE+39)
 #define V4L2_CID_ZOOM_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+40)
+#define V4L2_CID_FOCUS_SPEED			(V4L2_CID_CAMERA_CLASS_BASE+41)
+#define V4L2_CID_ZOOM_SPEED			(V4L2_CID_CAMERA_CLASS_BASE+42)
 
 /* FM Modulator class control IDs */
 

-- 
2.37.2

