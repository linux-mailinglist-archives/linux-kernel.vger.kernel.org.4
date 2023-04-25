Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AAC6EDFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjDYJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjDYJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:45:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A06CC15;
        Tue, 25 Apr 2023 02:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDWY2AqZVN1WaZ0NfJlBFbfwfiBNM+WEXDQSqSeLQ8R+9QJvHkTnXij54BC6ShlpIrC/0LQvmCVf9e44A715o+7Gnz10cRu2PaBoMJur791h1VU2JsY+uHJ4Pr2R43Xhe3iWrLQEBrHX9/6kKFcm9EZ05wPV2WLM4PjkpkzvBJ8LcGrrXNJixRNz7AYRjW9WJzgE+wm7htdONiw5CZ5HpZtMAhb+EuyhEKbbuYisHFLEiR6h5Mga5VWjZHE3ytJcZhIxzUsm6dgOOjRsnVATNYQUMvgK14ze8aLanYOrf2Ahry+C1XuPXEP1719+y67hHDQ4gz668yoJXmbWtw9j6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVGzAIOKuT8PiHIjsfy7+8gDVMXb/GXNKV39YoMg2uY=;
 b=MFGSnnObpaTf84d1SO582OZ/UutbFBv/kC0SbNuBw3Y4198behVzv8vpV0+p3be2PkH3wj9bdULrwqyhBQv5Uk+TeyAZMp9LleLMUfqnUYVCvJShV4L6lS9J2PzMz99OKGx6hWe6XbyHgXZp8bPBx6fpK1EINTR7nGYsp8hso/7uEB6Oa0L60jskRCf3y4rHp7R16glQuFqSADNGocBKGQmAuwc+Tq6UDfQBSdQiJXWf3w0smQa5lE7p3RuBhuwkh1KQyjoLMZcSf4TeaXXa4yQEPRruNy+KYS2HdXGkluhwj/AcWGbfwuEptTWSWosZD9mctkhi5hbCuyE1UjPeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVGzAIOKuT8PiHIjsfy7+8gDVMXb/GXNKV39YoMg2uY=;
 b=K9659784cy4vnfPFZ7Foflbpr5cHSgiPPhljG3DbuIhuWYxibUFVr9Ya7/Fqe8paMxBBr4C6qKznLU8os87+NMn3KlpZCyvmOBezPQWaYUESrWlGfZuJ0jqDpoxImjhghyvLOSlHTjfJ7Nj0LO4mpdJkdsjD22thyJEcpTWlogM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com (2603:10a6:150:84::17)
 by DU0PR08MB7995.eurprd08.prod.outlook.com (2603:10a6:10:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 09:45:28 +0000
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54]) by GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 09:45:28 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
Date:   Tue, 25 Apr 2023 11:45:16 +0200
Subject: [PATCH RFC v2 6/6] media: v4l2-ctrls: add controls for individual
 zoom lenses
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-feature-controls-lens-v2-6-faa8ad2bc404@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682415922; l=6440;
 i=michael.riesch@wolfvision.net; s=20230425; h=from:subject:message-id;
 bh=nqNQJR05ouemc8SeZlYTZLqLg/Oag/CugYO/mHK9Nxk=;
 b=I8PTDREyqsHC6mCfu8BfuO++6UCHtbLMVx4XJPANgzhyh5Dzk0FMX8TPi6efD2OlbdxDKCjk4
 VnUeGknkP/WA95ewUc5ARo0gNJdPPG7X6W3W33hAa6YVqNBi8Tow62U
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=1QQdXA2QbwdxaQn/VQK0hz04C8IBYhDowbK0hlNU4Ng=
X-ClientProxiedBy: VI1PR0802CA0032.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::18) To GV1SPRMB0046.eurprd08.prod.outlook.com
 (2603:10a6:150:84::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1SPRMB0046:EE_|DU0PR08MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 141a057b-b329-4535-0303-08db4571cd23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5Ho0wxXTszNVbSSp6RDRwj/JB7HdSIEzwIs/puPO9A/iHCyIOqWl34Ak0s9lq/AB8uPjWoWFdB9VShQkmI9PqahomtlJ5rnF6ZhRsOpEr/oHzFewtW+7fFJYzzXARO4ysrTbts1FjcG0P+U2x4wTrpibDlT3CxPLUsCx8Cw/0DUfffaUKZxXbM6WPrc0fTIMLXPT8vk0xcOZs1z8nnCkjJWme0i0UxcLfWAHJoM1tc/Z1SVA5RtOhS1nj1L1QO1QOmk0gQ51ue5gRJ0lSe1Ci8YrLSgAcrQwZEci8zkIV4Ksqbmi4AWdFo1tYYynqVcK403lA/3QWkdqnvLOwk/0aRsf6cjdHP1Pfc62uc+vY6L4S25OJHfMlaW+OtX2YPoyVDyN2i8sRPy0+UTjd6Ca6D8s6OkEmF6JGy0DuMAsG6bVe2EIJuS4IOdxMXVEG3bLj9aMtMrD2/QflqrNN0C0OlgCPccsX8UkvrY6cCKScJKieTJILLkonKcZ57sTnkDuYd8gGO62QIAamlMVxVH49S8ypFCMHWjN+QY5UZKrAa46SjiInWsjAvHQEATpJDQCwh2PQlwEBy/3zaF2eYJGmUqMnwrYxdjgnExLiRKmDSNgHx3kDuCitlYKqquXVky
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1SPRMB0046.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(38350700002)(38100700002)(6506007)(6512007)(26005)(186003)(8936002)(2616005)(83380400001)(107886003)(44832011)(2906002)(8676002)(5660300002)(36756003)(478600001)(54906003)(6486002)(52116002)(316002)(6666004)(4326008)(6916009)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUwvTXl4QUZicWhJRE4zQWtPS1N2NE1PNUxHaE90QjZEYXJOMmtraXlBS0Vv?=
 =?utf-8?B?T2VtK1RWeitwL2dqaEdLQitCS2kxdkg4VFAzell4MGt6bEk3MHFIcDNJRXl2?=
 =?utf-8?B?Z3hzWGY1aVZqZGRQa01sUzd6UDNXQzZSenEzeVp6bnVUKy8wSkgyZ2t3V2to?=
 =?utf-8?B?UHFJbXNuSnQ3SFcxdklnN0hDTzlBZENVOUJBWmYrOFdLbUs0SDVlT1RydExH?=
 =?utf-8?B?RWJNY0twQTJyYUZMcTh3aWNDLzRxRGlhYVRVc2VwVGM4OW5sKy92eHRuUWls?=
 =?utf-8?B?M2k2SElXM1lrVUhHYlBWdGFFMGM1N241b2svaU1xbml2eUdaSXBJYTd6cEMz?=
 =?utf-8?B?OHltT0RRdStJMFozcDhQSXB1RmNMVi9EMFlvMUdsSC9yYVRqSzd1QUhpRlV3?=
 =?utf-8?B?OHBHVUFMNTd5NlJrZkczeUlicGFaR0MxYVNXZ2JydUNodUdpV216VkRGaGhw?=
 =?utf-8?B?QjVveVErOEpLRWM2V0g0MTV0UTk1RTRqQ1A2N2lIMTZWOVdBOHdKcnJsR1lo?=
 =?utf-8?B?U0lHSlE0NDg2SFRPdkx1VFQ0dC8wck13akU1RnQxNWl4Q3JWWHRETXFPUXNP?=
 =?utf-8?B?WWlMRVNVaTQ0YXlad1AxeVdkR0RwZlNkZm8vZ0tHeVdJZHhOcVR2elpvY09u?=
 =?utf-8?B?UXp6ZUxqZmI4bThQSXJESmdHeWozK2xLMEw2WWlzU0wxZC80TmwrVE93L2dW?=
 =?utf-8?B?OWFPamh4dHlPMkxOYXREYlZzcjl4YzVRWXhGaUE5ajU0aHh6Z0xhMHFubG9Q?=
 =?utf-8?B?YWw5VmFab0hmVGNvN0N1U1JoRmZ5Q3ltWjdHc1dWcHZuRXVVRHI1VkEwaWo4?=
 =?utf-8?B?UDVORlNrSmxrdFN6dVRhd0NmbWJlR0dMbmw1ZnBzNlNIR2Q0LzkvVjJweW5U?=
 =?utf-8?B?SklWMTYwdU91MVBuVTd2UEUyR0x6b2c4cFpjd2Vodm8vejBpSVhpNlJvek04?=
 =?utf-8?B?SGM1SGFxN0NnWVg0L1RnVFhGb2xnei9zNDRDT0dwU09yL291V1ZvQUo1T3pI?=
 =?utf-8?B?NTVtZENVZFNTTHh0eDltVHc0WVQ1dGpWaWJHSDJGTUVCcU5vN2tHRDR2Z2Fw?=
 =?utf-8?B?UkdOeGtVVUZLUzIzUThYMzZhY1A1NG94TjR3UFJDVmdhSEJyODhzWDNaL2dM?=
 =?utf-8?B?R0pNU1RwbDAzMEl0OVlPLzdmZHpjdDFVV2FhUStGT3JDMVpTVERkb1E3YnQ2?=
 =?utf-8?B?UytpamIvckhaOEpVcXVvWEVrWjJScFRvekNOb3VxeGMvblNOWWF3NHdrVllj?=
 =?utf-8?B?enRCQS9hWC9WZTVvZkdoTSt1Qm91UjRkcnQzVEM4aEk0RWRWSk9yMnNMNFox?=
 =?utf-8?B?S0ZKNzhsVmdxM0JxSWJ6ZFh4S2V2bXZ0TzV1akZsaXVIdWU2dkxZSk5vOHRE?=
 =?utf-8?B?UjhUQ2cwdEZRTGVYVTR2VExlemdJZmdDWEZoMFZmOVAxQWRyTHVRMSs0LzMr?=
 =?utf-8?B?MHlWOVlxY2c3cmtJWFAxM1VXMlZ4eGsyM05FcFphajNjMFl0dVZyaVlTVzV4?=
 =?utf-8?B?M3NJQTI1WXMrZVFzVFIxcjFhSHVlazdYR3JzNm1za0JwSVEreDRIOFpCdGFQ?=
 =?utf-8?B?bkZNRWdlMkpkVGJDSGtQbjVlN3VvQ3YxL1U1T1VGaWw3T3JXVjlvSlQ5dlg2?=
 =?utf-8?B?bnBuVkd1aTJxeTZtZERzb1JQR25lbk1OcFJuVTJRSGhVOEYzanRFb3ZZU1BJ?=
 =?utf-8?B?ckNEOXY2T211ZStyR2VqakVtYldIYmJqNGRhMjZwOWttcm1UVlo5bSthRVNy?=
 =?utf-8?B?aUFuYlpUWE5PcG9ZRDdtcnlFQytxRmNiNFVVVGZ0VUJvNlJpUENpVlIxN2Ns?=
 =?utf-8?B?c2k0b09ybjFaOGptM0VRVVRWRW5XZllONnBweEcvbkRFWmE0eHJCSXY3aWZH?=
 =?utf-8?B?UUJIZ09WNm9QNXRmK2oyWWVPQU9BSG5zeDJQdSsvRWdCT2Q2MlBybytQWERX?=
 =?utf-8?B?dWRoQkhobFdCZGtIUndIblVPdGpxSnBVUTR3V0VyU3crZm16dTlNR1gvZzNx?=
 =?utf-8?B?OS9CV3pEd2VLb1dmdkp2QjlCSWFwNVE5UTJyNTJuRTV2ZFd4c0FJTXZVU2ZL?=
 =?utf-8?B?V1JWOHM2SktUdkt1RDVObmYyQTFFSWVoRC9vMkcxZG9WcmZwSGRLbUpBbVky?=
 =?utf-8?B?TnV5RXpnMkJwWXV5djlVQk9OTTNtWElzMnZrN3YrMnE1TGl4SXQ2VHRLMkIv?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 141a057b-b329-4535-0303-08db4571cd23
X-MS-Exchange-CrossTenant-AuthSource: GV1SPRMB0046.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 09:45:27.9933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgYCAOlYcfZIKXr4DbwXEae8SyFs/0qjwu21KxRMeVfFMXlRcchfaI6CRh1EsZ52GxC7gIuLTgxhqBJXgoo8q9u8zE1rcdMtntpjKZC7Yhs=
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

A zoom lens group may consist of several lenses, and in a calibration
context it may be necessary to position the lenses individually. Add a
tuple of V4L2_CID_LENS_CALIB_ZOOMx_{ABSOLUTE,CURRENT,STATUS} controls
for each individual lens, where x = {1...5}.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 30 ++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          | 25 ++++++++++++++++++
 include/uapi/linux/v4l2-controls.h                 | 18 +++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index 8b54a0f3a617..21391f076971 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -332,6 +332,36 @@ enum v4l2_auto_focus_range -
     * - ``V4L2_LENS_CALIB_FAILED``
       - Lens calibration procedure has failed.
 
+``V4L2_CID_LENS_CALIB_ZOOM{1...5}_ABSOLUTE`` (integer)
+    Set the absolute position of the individual lens of the zoom lens group.
+    Most likely, this is done in a calibration context. The unit is
+    driver-specific.
+
+``V4L2_CID_LENS_CALIB_ZOOM{1...5}_CURRENT`` (integer)
+    The current absolute position of the individual lens of the zoom lens group.
+    Most likely, this is done in a calibration context. The unit is
+    driver-specific. This is a read-only control.
+
+``V4L2_CID_LENS_CALIB_ZOOM{1...5}_STATUS`` (bitmask)
+    The current status of the individual lens of the zoom lens group.
+    Most likely, this is done in a calibration context. The possible flags are
+    described in the table below. This is a read-only control.
+
+.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_LENS_STATUS_IDLE``
+      - Zoom lens is at rest.
+    * - ``V4L2_LENS_STATUS_BUSY``
+      - Zoom lens is moving.
+    * - ``V4L2_LENS_STATUS_FAILED``
+      - Zoom lens has failed to reach its target position. The driver will
+	not transition from this state until another action is performed by an
+	application.
+
 ``V4L2_CID_IRIS_ABSOLUTE (integer)``
     This control sets the camera's aperture to the specified value. The
     unit is undefined. Larger values open the iris wider, smaller values
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index faddfecba6d9..8a78cffcd3e8 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1052,6 +1052,21 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_ZOOM_SPEED:		return "Zoom, Speed";
 	case V4L2_CID_LENS_CALIB_CONTROL:	return "Lens Calibration, Control";
 	case V4L2_CID_LENS_CALIB_STATUS:	return "Lens Calibration, Status";
+	case V4L2_CID_LENS_CALIB_ZOOM1_ABSOLUTE:	return "Zoom1, Absolute";
+	case V4L2_CID_LENS_CALIB_ZOOM2_ABSOLUTE:	return "Zoom2, Absolute";
+	case V4L2_CID_LENS_CALIB_ZOOM3_ABSOLUTE:	return "Zoom3, Absolute";
+	case V4L2_CID_LENS_CALIB_ZOOM4_ABSOLUTE:	return "Zoom4, Absolute";
+	case V4L2_CID_LENS_CALIB_ZOOM5_ABSOLUTE:	return "Zoom5, Absolute";
+	case V4L2_CID_LENS_CALIB_ZOOM1_CURRENT:	return "Zoom1, Current";
+	case V4L2_CID_LENS_CALIB_ZOOM2_CURRENT:	return "Zoom1, Current";
+	case V4L2_CID_LENS_CALIB_ZOOM3_CURRENT:	return "Zoom1, Current";
+	case V4L2_CID_LENS_CALIB_ZOOM4_CURRENT:	return "Zoom1, Current";
+	case V4L2_CID_LENS_CALIB_ZOOM5_CURRENT:	return "Zoom1, Current";
+	case V4L2_CID_LENS_CALIB_ZOOM1_STATUS:	return "Zoom1, Status";
+	case V4L2_CID_LENS_CALIB_ZOOM2_STATUS:	return "Zoom2, Status";
+	case V4L2_CID_LENS_CALIB_ZOOM3_STATUS:	return "Zoom3, Status";
+	case V4L2_CID_LENS_CALIB_ZOOM4_STATUS:	return "Zoom4, Status";
+	case V4L2_CID_LENS_CALIB_ZOOM5_STATUS:	return "Zoom5, Status";
 
 	/* FM Radio Modulator controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
@@ -1607,6 +1622,16 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_ZOOM_CURRENT:
 	case V4L2_CID_ZOOM_STATUS:
 	case V4L2_CID_LENS_CALIB_STATUS:
+	case V4L2_CID_LENS_CALIB_ZOOM1_CURRENT:
+	case V4L2_CID_LENS_CALIB_ZOOM2_CURRENT:
+	case V4L2_CID_LENS_CALIB_ZOOM3_CURRENT:
+	case V4L2_CID_LENS_CALIB_ZOOM4_CURRENT:
+	case V4L2_CID_LENS_CALIB_ZOOM5_CURRENT:
+	case V4L2_CID_LENS_CALIB_ZOOM1_STATUS:
+	case V4L2_CID_LENS_CALIB_ZOOM2_STATUS:
+	case V4L2_CID_LENS_CALIB_ZOOM3_STATUS:
+	case V4L2_CID_LENS_CALIB_ZOOM4_STATUS:
+	case V4L2_CID_LENS_CALIB_ZOOM5_STATUS:
 		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
 		break;
 	case V4L2_CID_FLASH_STROBE_STATUS:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 24c0eb5f4d29..7c49c0ba23d4 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1016,6 +1016,24 @@ enum v4l2_auto_focus_range {
 
 #define V4L2_CID_LENS_CALIB_STATUS		(V4L2_CID_CAMERA_CLASS_BASE+44)
 
+#define V4L2_CID_LENS_CALIB_ZOOM1_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+45)
+#define V4L2_CID_LENS_CALIB_ZOOM2_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+46)
+#define V4L2_CID_LENS_CALIB_ZOOM3_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+47)
+#define V4L2_CID_LENS_CALIB_ZOOM4_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+48)
+#define V4L2_CID_LENS_CALIB_ZOOM5_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+49)
+
+#define V4L2_CID_LENS_CALIB_ZOOM1_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+50)
+#define V4L2_CID_LENS_CALIB_ZOOM2_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+51)
+#define V4L2_CID_LENS_CALIB_ZOOM3_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+52)
+#define V4L2_CID_LENS_CALIB_ZOOM4_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+53)
+#define V4L2_CID_LENS_CALIB_ZOOM5_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+54)
+
+#define V4L2_CID_LENS_CALIB_ZOOM1_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+55)
+#define V4L2_CID_LENS_CALIB_ZOOM2_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+56)
+#define V4L2_CID_LENS_CALIB_ZOOM3_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+57)
+#define V4L2_CID_LENS_CALIB_ZOOM4_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+58)
+#define V4L2_CID_LENS_CALIB_ZOOM5_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+59)
+
 /* FM Modulator class control IDs */
 
 #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)

-- 
2.37.2

