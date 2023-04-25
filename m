Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AFF6EDF95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjDYJpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjDYJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:45:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14D549E1;
        Tue, 25 Apr 2023 02:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc9iNw0IVAqqywh3q4zwwvjtto6y5TFW9/591SPVyVLdZNukbJqz4Nq0S/VUSgGfX4Xe66hmuRPZ9SVUQnT2YWB4gV0VnX/tH/xp+GO1DbQIfXJhFlaMEvEdsoel9tM5Ipz6r88AbyEmoupDYcEJ/NH5Ygjc5yW7yB0EKXbG2tCLLIum+XmNfkSi4qv45KTBf3ZxzTCa+mxR0U7UOU0LF9pC6EZ0yLVlj581j/zwZDEPptfK13mbAbGzDORY7KxgDide6YqrlDGokcyFyIBsd9OJ2q1RvxKldOB3VDS/1CIrx9qtSq0zJP9JiEbPoV7DO75kfL0TuOT9C5rYTa43+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuCoKyWTDPx6eKC8CwMgM7bBA9pUsSLyk6V8IYhG+bE=;
 b=R6eHrr8rd+efKVskRH7IZlxhnkSV0G/CV3SS59pfzcsg67QqK99vo4XKybzCSuaYUkvVGAvcRHriXO1nMNCXJ4xOCHdovQB9gPLxZOJbY/1kNPT96MbFGx8weFOV1vJx3cgzgkRLcPZ1RGsLPbfEabudOykx3xF0YT6FPGTncWH7WexknE5PWRLg7wzKQorgbBjjQNuRvrFZGy7/wfnTY9VwnauuYX/1B/iTLvqpmJUSL87r3BLCKQrII9sz+DVDneC+Cbdc81EmQPskQBmAO5FPQokmlOKJ8GfPqk9aoS3JhF1rPOtHVrV9iEm8UOBalEUe2oeyXf6hjYeQYIl9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuCoKyWTDPx6eKC8CwMgM7bBA9pUsSLyk6V8IYhG+bE=;
 b=WQ80ZUWFkt3tv1SDjK/NsdOrIltVWyEde/vR3vhYWcnFoTuO+HJHNbeKiVOQpRAKz2YNnTi+/BJqzRK4J22DMFD1oo9oLrnrZOFmXTkK2w2IVIipEnnaHb38amcRWh2WcpuHR2NCrdlrg9behlvb2Zi7H/hs0iP9cuNmaDCP56I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com (2603:10a6:150:84::17)
 by DU0PR08MB7995.eurprd08.prod.outlook.com (2603:10a6:10:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 09:45:23 +0000
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54]) by GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 09:45:23 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH RFC v2 0/6] media: v4l2-ctrls: add controls for complex
 lens controller devices
Date:   Tue, 25 Apr 2023 11:45:10 +0200
Message-Id: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACehR2QC/4WPwQ6CMBBEf4Xs2dVCW0RPJiZ+gFfDocAiTUhr2
 ooawr9b0Isnj7MzL7MzgienycM+GcHRoL22JopslUDdKXMl1E3UkLGMM8FybEmFuyOsrQnO9h5
 7Mh6rQsqtbLgQXEFkK+UJK6dM3c30F9r8QHPu5qjVz6X/AufTEcp47LQP1r2Wn4Z0sf7UDykyl
 IKnxU7lBWvo8LB9+1mzNhSgnKbpDRoHdQbsAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682415922; l=3735;
 i=michael.riesch@wolfvision.net; s=20230425; h=from:subject:message-id;
 bh=FJLTmQCSIQ7EFhVAQ4CVmtl+q2IZONM4Z4PC+Z9A2oU=;
 b=xicDx+5R3ZxUiPjo/zPHbRk4RyCKOBV4HA3xieUZYvqGBrAOX8U4CsMgIaPs0D4/9iaoWtse+
 LiwKV4ONlJcDYrv8JiQ0ZQWs/DMPVZfpdpO4Jr0M/SEYdt8IekNskoN
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=1QQdXA2QbwdxaQn/VQK0hz04C8IBYhDowbK0hlNU4Ng=
X-ClientProxiedBy: VI1PR0802CA0032.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::18) To GV1SPRMB0046.eurprd08.prod.outlook.com
 (2603:10a6:150:84::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1SPRMB0046:EE_|DU0PR08MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d63146-cdb0-4f21-859e-08db4571ca36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jsHjUWl1LGPPqWK8sHMRB6z2OgK73/FIL1116cFP0LbnRFnO5ZZ25fTLLmVbwAVbj/AsLtjS+gPaoF6rhOEbmZlqDijzXN3MxQoeNk3Ntc8uCR3QaJD3A+536tbPSxHkkJ99iVcB0bwtidm9RHVX84afFP2cfBosku6nHRIKiSr3X3zge0NkmliExD+CRKtY4dKf8zK5wb1F4Dy7TMnbNK16rET2kSWJPq9QqrxFPQaXv6uWIkAwFfV4iN4x4vRDnDvakqaYXTSU2rMwbKEid2O17RRkTkI1NhpJ9uq7Z0ydJ4XR1NQM+ILPmMF2+Ch0jUfHSSiik9t4pU2e++9du/EoAGjkkndDo41vtQ3wrmCxdrfApc/6DgEA1p5HFMDByn9Q5qG04zxV9++xEcFstGj1TQUcqk7SawypsWck44NEW4zHzDDBebEsP+Y0dWF1P3Lo6TVmaGY4dT/n+CPynR+rKLy9DqF7I7zsYqv6HSXi0/z4PzHLEoDWc9hhuBNt7nrd2DXrxGhkbMnrsUBOlZ6PMb84w+o4cAOdnNTRzst9dJfNoXEv32z84wRHofM0ADtqAMm0z7PKTiJE8HEyh+LNf6Qp5GzHmVNcM5HTqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1SPRMB0046.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(38350700002)(966005)(38100700002)(6506007)(6512007)(26005)(186003)(8936002)(2616005)(83380400001)(107886003)(44832011)(2906002)(8676002)(5660300002)(36756003)(478600001)(54906003)(6486002)(52116002)(316002)(6666004)(4326008)(6916009)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YklaMk1mSnBhYmNOalB2THp3cGY0VjZsc0hxKzl6dzBkTFJwZWNHc2RsaFR0?=
 =?utf-8?B?WDFnQzA4RGdLRjg3TFRQamFHS0JhdCt0d2ZpSGxhN2hmVmZ3RXg0bjRrbXlF?=
 =?utf-8?B?TzFMS09GYlByVkxGTDBZdy9CT3Z4aGRKc05LMUd3ZnZqb1BSVGxxVmNIemwr?=
 =?utf-8?B?RmVsV3BTSDE5Uk1HWkNiSGFVaHoyYWpMVjlGZm1ncSttMjZxeUhiY014RC94?=
 =?utf-8?B?K0VGU09UdUFFUmtXZHljUk1RYmdzbWs0OVFTWkJPT0F6RVNWcFpmM1FjcDRL?=
 =?utf-8?B?ak1iZHJxZUpUODJQeXUycDR3Q2crMWJmL1MzUklYcjY4YU1uNDQ4RnhKWW52?=
 =?utf-8?B?ZTlXTmtPK2hJWHlkRG1wSlcrWm8rMU93Q2ZDMXRxZGpYSWltOGQrUUJMbmRF?=
 =?utf-8?B?OTRkRlBObkh5b09CN29wRlpDZk5RTitvYS9qYm1tWmI4SEtZMC9hQXpEZEpZ?=
 =?utf-8?B?RFg1TUFXUjZZblpIcCtrSk00SXA1eEhBNWJHMlpneUt0UVBpMERtc3RLU2tG?=
 =?utf-8?B?cXdGRlM1VE5hV0NueklBMEQvanp4bzhwVk5WTmpzakhpVXhScytHYStIMFZl?=
 =?utf-8?B?bmlqL0JMU2dVK3dFRVczUVpuY2ZKOE92TkhaSnJwVzhkTUw2VjV1dkpCUzZy?=
 =?utf-8?B?M2ZvVmw3aGd1ZFNtbHpVNVhYcm13V1FTRmxOUC84U05CdXFiL3NMSkhuZmZv?=
 =?utf-8?B?YnRPTG85RDJxNDVmSVlCazhVcTJINkNYNHJEbmpQcnVRWlpod2Q5STBZNHNU?=
 =?utf-8?B?bDNSbXUvYUIySHkxa1Q5SU5FamNLUm1IaW10MFpCeHcwOWFESTlyTUVPSnh6?=
 =?utf-8?B?SDlEcGIwTWN2VjJseERKWXM1TjhsaXRpSlVCb09XQnUxY2cySDR3VFNzb2tp?=
 =?utf-8?B?TmJOcDhNUlc2c0xMV2ErS2xFUWdNUS9YckM3KzlqUXl6R2JIYW91alhpcFVZ?=
 =?utf-8?B?cW1KeWc1Z0xwODVzc1NIdTdlbUxmUHU4SnNKVnIzSFpsbkpES09adi9sczk4?=
 =?utf-8?B?amRmN2lsYlZ3cWYveGJHd0JzeHhCWXdYTFBSS29sS0IvZzM4b1ZyOU9zb09E?=
 =?utf-8?B?WkQvWHZ6dXZESFdSWEMrQ2FtTnlxQlRnOEpESlE1ZjJrS0tYVHNVajB4U244?=
 =?utf-8?B?YXhiQ3Brc0Fyb1pCdS9BTENJVWQrK2lTQjVEVk5PM0hYZk4vLy9BT1pqRnFG?=
 =?utf-8?B?Z29hTkJLdjN5Y2xBeUdnZzl3a2xKK3dZSjl3VnBuMzlOU3J1V0wvRnlPdXEr?=
 =?utf-8?B?TXJKU1lYYXh3UmNaNCtKQVFQRjBpM0xUQjIzeC9Id0o4T01KSkdhNjl6ODEw?=
 =?utf-8?B?eTdPcm9ZdWIzNW9sV2ZJaGo2amQzS0M1OHA5bWt4Y0tCbThjZEFpRUJJQXRF?=
 =?utf-8?B?UWdhdG9YWHd4em9BMGlqTG40N3JOSktJdmhQbXI2aVMxUldVOXRDSVhNM0lz?=
 =?utf-8?B?UTVsV0tEd0JoRU42eHEybm40Q3VhTG1OU283RXF3TERsU2N6NkJDWHBQbVFz?=
 =?utf-8?B?bjVrVVh0YjBESmxyMjJuL1htVVRleGxNNHNyRGVGZHZJT0xTVHRFbDN4SFhi?=
 =?utf-8?B?OE5xQ3ZwNWUxQkF3YXJ4WjU5K0NLMW1xSlJNSC9oQTlad1Y3RCtXbWhhVXVV?=
 =?utf-8?B?aVR6T0NVNjBBc1FWdEU5UkY0VktqbWpoV2xuNk5IMlpYYjdobmJockRLOXZq?=
 =?utf-8?B?cnNGRDBNcTBGUld4b09KeGIrWkNFdzFVY2dZOGtjUE9CRWsxcEx3NWxCSG9I?=
 =?utf-8?B?WjR5aVd4Q3RnRFA3SnVxSHl5Z1BlTmhZbTVaM0NlZnZQWSt2UUphTkhoaGht?=
 =?utf-8?B?NjJ1S3p1NG96T0JLMDkvSDdpVnpCZmZORkh6blhKVDJyTkVNMldPb211UlJQ?=
 =?utf-8?B?UytwZGRqK3NjY2ExZ0Y2cDAxeDM3YXdUQlpvS2IwMmFpUi81aFRLSzBRd2Zl?=
 =?utf-8?B?Z2JZRisvVmpnLzhoUFIwb0xXZ2V1bDRWQW1ZM051dVhtNitzcGFteC9oUXYv?=
 =?utf-8?B?c3ArN1NtVHZYckhWTi9rRW5yb1dJWi8yYUx2Nmx6a2cwdjdyMUI1Z1AwRThN?=
 =?utf-8?B?TWQ5d3lmaXdaRW4zYTFkbks4d1R0OThZbDNMZStsd0phUVFpK1RmZlNac1l2?=
 =?utf-8?B?dzlZekhhMjdoSXRNRFpsbkd4NS9rSGtVNTBiVEZWMnhZaW5KT2VmQS8wcDAy?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d63146-cdb0-4f21-859e-08db4571ca36
X-MS-Exchange-CrossTenant-AuthSource: GV1SPRMB0046.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 09:45:23.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: um/OsNF0dXFNxv6wirhWF0vV4d3ZgKRk6ZaVxcmVpXcsoRvwLVnoMN4z6Dw9cOtCzThBNEKUGUPDJQhS/+m3oPJhP37AFipVjs8MAIwSc4U=
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

Hi all,

This patch series aims to add support for complex lens controllers in V4L2.
Complex lens controllers usually feature one focus lens and one (or more)
zoom lens(es), which are driven by motors (e.g., stepper motors). As a
consequence, a few crucial differences to simple lens controllers (such as
voice coil motor (VCM) drivers, which are already well supported in V4L2)
arise:

 - Focus and zoom are slow.

Compared to a simple VCM driver, which reacts almost instantaneously, the
motors that control the lens groups may require some time to reach their
target position. Therefore, the control process in user space needs
to receive feedback on the current status of each lens group, such as the
current position and whether or not the lens group is moving. Patch 3/6
adds volatile and read-only status controls for each lens group.

 - The velocity of focus and zoom can be selected.

In contrast to a simple VCM driver, the motors can move at different
velocities. Since the produced noise depends on the velocity, the
control process may want to optimize the chosen velocity. Also, some auto
focus algorithms use different velocities in different phases (e.g., a
coarse and fast scan vs. a slow and precise scan). Patch 4/6 adds speed
controls for the focus lens group and the zoom lens group.

 - Calibration may be required.

Since moving mechanical parts are involved, calibration is most likely
necessary. Patch 5/6 introduces controls to control calibration procedures.

In the scope of calibration, the relation between the lens positions may be
fine-tuned. This requires the ability to control the individual lenses and
gather feedback on their current status. Patch 6/6 introduces a pair of
controls for five zoom lenses. (Five is a placeholder here. The most
complex objective we had at hand happened to feature five zoom lenses.)

On the user space side, it is envisaged that libcamera operates the newly
introduced controls. Please note that no tests with libcamera have been
carried out yet, the integration will be discussed after the first round of
feedback to this RFC.

Version 2 of this series include two new patches that fix mistakes in the
documentation of existing controls. These mistakes have been pointed out
during the review phase of the first iteration of this series.

Looking forward to your comments!

---
Changes in v2:
- add patch 1/6 that fixes unit description of V4L2_CID_FOCUS_ABSOLUTE
- add patch 2/6 that clarifies when to implement V4L2_CID_FOCUS_RELATIVE
- remove compound controls _STATUS (struct) and add controls _STATUS
  (bitmask) and _CURRENT (integer) instead
- fix V4L2_CID_LENS_CALIB_STATUS documentation
- Link to v1: https://lore.kernel.org/r/20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net

---
Michael Riesch (6):
      media: v4l2-ctrls: fix documentation of V4L2_CID_FOCUS_ABSOLUTE unit
      media: v4l2-ctrls: clarify documentation of V4L2_CID_FOCUS_RELATIVE
      media: v4l2-ctrls: add lens group status controls for zoom and focus
      media: v4l2-ctrls: add lens group speed controls for zoom and focus
      media: v4l2-ctrls: add lens calibration controls
      media: v4l2-ctrls: add controls for individual zoom lenses

 .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 129 ++++++++++++++++++++-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  41 +++++++
 include/uapi/linux/v4l2-controls.h                 |  41 +++++++
 3 files changed, 208 insertions(+), 3 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230406-feature-controls-lens-b85575d3443a

Best regards,
-- 
Michael Riesch <michael.riesch@wolfvision.net>

