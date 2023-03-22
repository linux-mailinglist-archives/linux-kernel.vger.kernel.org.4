Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FCA6C44EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjCVIah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCVIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:30:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72835A1BC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+x0G4kqHTpGgbdw7vfVW6ifddKHs6JPex+YZZjMoekn6Jp1Pvb6a1KxezJwZZsnIsoAJaM7hmsGLXacMirfK+Yy/7lJvE1X7AYuPeAk37IbpgTv3Nh2sdbBPn0I/OG17y2Iiu4pg1ftWtLs8GepHtYar3MibGReRzre2AHK5KvZqLwwrK+qw07TZ99rgadnqtaU1KgB1lG4lQXg8r+2I5FD5Ha5FQ0WjQj22tSM76mwWDmkkY1X0THvHs/k5I3PWSqE4RgMKFCr3//yWOYH6jrqNW5vR2Q1rYIGPHCXPRaLrCWbPOOJBr5GkyQErFiN11o8N+6f+WQZ9FqDOJl+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxZ57c12aZHZpyFGw1rBUwzEqp106Aepxh9FIVvFc94=;
 b=c5Za+Vq6Wnexvwsrhe5DwHL5ODrAzapK8AUwkNkKa7z/FjE7ad9Ed7Ah6mKkdc3CtQEFDNnaHUXT3ARH95T2N9TRnbDVZZeOOvHVfe238Y9ff/dz9LdkbSQ4tNJX1LXc7zDWICF3hPlw81QYBuniGuzkFFFJiaVRsB8xDT1AffGzL8hgtZTWivuoKJ3MKhGeZiu8fVwJsD7ikND3AVMBuU0SbH37opDXkWxeR6WbSpqoDeW2/Y6pS7glTsq8zyPcqq2atGi6xwNkWkrYQdttiCCnfsstonVXQP5Hmik6JRbAa+MLd8WdGylqmTAnZwZb+xoQyZ7FqBjJkAAT+yNVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxZ57c12aZHZpyFGw1rBUwzEqp106Aepxh9FIVvFc94=;
 b=Nic6K8e/37P7DEDQQ+VX1I2l1aj8SBTjGtTTN0hmrDZAAw2XxKqiSBqw/TcJeYvWO9+PXMpAP/lPzfOQeg8XD2IG7beS/Xa0Emg9NV9mSTKdLP8KdCuSTkTJSLDsK52clWDAvrsiMdpXmoP0s5xxK17uGgeCawSFkOi9GzbBQiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by MN2PR03MB4944.namprd03.prod.outlook.com (2603:10b6:208:1b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 08:30:31 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::96e3:3428:3a5b:5872]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::96e3:3428:3a5b:5872%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 08:30:31 +0000
From:   Hsia-Jun Li <randy.li@synaptics.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ayaka@soulik.info, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org, tfiga@chromium.org,
        nicolas@ndufresne.ca, laurent.pinchart@ideasonboard.com,
        ribalda@chromium.org, "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
Subject: [PATCH v6 0/2] Add pixel formats used in Synatpics SoC
Date:   Wed, 22 Mar 2023 16:29:08 +0800
Message-Id: <20230322082910.115371-1-randy.li@synaptics.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|MN2PR03MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: b12fa3cf-33c2-4585-b876-08db2aaf909f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 954QH+XfcEGwklaaKkLtx3Bi6dh5pAJJ+3uWOoAxAdFU7RFOI70lRN+DIfxJvRjRe2W9VZnKjvae9NhNXPhpfapao2fptEzanMJZF6qudq4PAvitsGHBbtnzpegVPRe+Ahu1leEDAsNzgwzmPb7uwMZgXSmV3bXr/xeO40lVQ1k6oEfKeZ0Cl9imn7Un9D1DOSOeqVd6zLaa8tMbIEkZ1sLKZCoIt+Ju/e4x7gZZ8mIvcyNFS2r1IGebEgn/iTiddPPniEa3WPpddo87l526jKDFSEyri7jbgbF8GuqiKU6xAwINwuqBGMymYNlKoPAUj6VNJdbpIb4J62mGvYq2RcAqlSVfJURxG6BjbF0zIdo78puz2X844izGx1ci3e+PSUyo2mxNKIcL5rRn7KML754y9w71ud6Nm8Jl4/Wp8ILLARCZenae5in8F16aStDgfG3f8sWE/zeqWDSnyvLj5LUxjtI8wwsu84UDL8VRIUHbO4GxiJxeUU+eO6OlGrncsTCDcYSCuivRkV/Qa/pUIyOz59ziz+niT+WLsDlRtbG16Uwdks/QjlKlRzE9IrKYXPfhr6ujKE4dAnXMQE7sndnp8v2eGDPNn7dzCKsdgYmxe7JVXhkZX5PEthfSMSzjrBX50sqAVw90mJT0h5DdoJ+8N1SlE+5aB6Hg6qr2whV6Ty9byhXaLlhgCb4gnItDZFgqjbqAXdug934AXA6XMKJvfph0WyI4Jkc1r/dR6uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(2616005)(52116002)(6666004)(186003)(966005)(6486002)(4326008)(83380400001)(478600001)(107886003)(316002)(66556008)(6916009)(8676002)(66946007)(66476007)(6506007)(26005)(1076003)(5660300002)(6512007)(8936002)(7416002)(2906002)(41300700001)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CGBJMzPIvLG8XRwXJ7osMs/tu6D4QNNoB0udyQY/cSDaxsnORv52ONhjgBue?=
 =?us-ascii?Q?YTelRdheTGDDG8Q1NVF2gvshC0cH2bt/+vjhvNbVSZ8i5B1Ipo6Vh6nVUFGc?=
 =?us-ascii?Q?2htkPknP2ruPISRXkIj5b5MefyP7TCTfjDr8DMLcXcHYQ+O///HDzzNEkv60?=
 =?us-ascii?Q?zmiJinhOeAvO5TQP9KJj0j/p5TGHJQKI5tq04n6kSuWuxl4YqaYZLo+ngfhl?=
 =?us-ascii?Q?b+xbX9sbYymuBqNnCZr68IShJh3a3vutWK13QzHSNHC5Hz0lhRNb4hZB1DGE?=
 =?us-ascii?Q?TdMw5J5MRomUPb31LJkTlFmSHWavTfxcJSNR2wY61iqWVSY8nb8ro7+1Ok0w?=
 =?us-ascii?Q?j1YrBT1Ln+BW/XHTMDSLW7t/i3mK0hO6ewxt0CS/PbkgpDZlyNTGkVS899mr?=
 =?us-ascii?Q?FuvtwxUwVStKWrVlqtnXYU3ma+HnSvKpqpoCzrlGM71+DtMASChL+ZJyiCMi?=
 =?us-ascii?Q?X/KaTtbbWmjJNktDIJj2sigCR+OMECTrHxeErZkO/LQ3/74ICRK2JFi/jxUb?=
 =?us-ascii?Q?6BK7gyJiIIavCtkIHonQs8AG62HeKj8gmVXO9tUGgl2WtLyPBSzY+F4ntJsl?=
 =?us-ascii?Q?JyHLMfO5Gw4QBfu0FinpiWMjscw4ovzWcV//NPZqq9nk4O7s4R/FT3xngmo6?=
 =?us-ascii?Q?TfKDfEyO0fTMy/Wq7rd3K89tNq75S5nre3Yy0EjqTQ+T6JnLrX9BASRI6EYE?=
 =?us-ascii?Q?8DvMlAoBti6l9JW7+4UVJ+2fBY8MzuSOvJu1135719yMFOghXOlp996Sg/jF?=
 =?us-ascii?Q?/puFPxYBJ6zhedWHWUb9Bys6HHv4yxGB4WFQMIoQNZwG+CCcXE7KjO+iFaqN?=
 =?us-ascii?Q?FfWmhMFRHaOCBhzLJkTl7Hrog/xb5SteOegUUtWJDlf4OP1E+dYekjgixzW1?=
 =?us-ascii?Q?0AER9iXFafZunemnA3f5llNYWLqqqAhMMgcwaJoowditXKu3gwV8Nmj2HF15?=
 =?us-ascii?Q?JoobtZ68HbVdm16MO6ioixXSGBkj3rg2c6nj4bZOhvernMI8r9xzh33qfQVi?=
 =?us-ascii?Q?xThFdChCsj03TuwZbkI4SA+wCKr2ZcEGUaA+5MOTPztCpIFxYBUyaET9QFpo?=
 =?us-ascii?Q?i2EetCngMvU7g8PjrLkSwVmq7k1qsrKHVaYntu2K4JMkH0sm2rgBpv4fK/TN?=
 =?us-ascii?Q?JL/SNqQVOXSUQeUv/lxrUElip5n1asadWyBTPu8CyiXqcmzjISz/XbqzC6XP?=
 =?us-ascii?Q?tfMQHgFPrjUvcXAHvsq1ampuT+ZiAVHfxmhQGKERmy/bl1gxWiTAnRcD7UZa?=
 =?us-ascii?Q?vVyB/jEfpI9GlbHwu0PXTPcXF/1YLpfTOyNF29A+8nCnElaLviUo2LAnVBAr?=
 =?us-ascii?Q?Y6LBIteXX9FcP8rjrYHP5H4j6XS7pa4NUWMJeXLOEoU61pQ7BY2Zbo6UrCA8?=
 =?us-ascii?Q?Oq9F/g+SdIdC+pdCib+bb+6ivKEx4EDmytZ6XdVQohKzwmZ0psBw+BUF0RtJ?=
 =?us-ascii?Q?6A6t6VCsY6Gmy6D65RFZAdaykkOYsq1meopmyFmCsIiBPmNeriAAuaAf0urO?=
 =?us-ascii?Q?AUVtMB/1DUzVhUuihp/PBL8SWN2vlcm1/uyo2J3MQwcTSvqsgWGQQKcJI5fa?=
 =?us-ascii?Q?UpriTk9drUxz7yajZGWchFKYPSx6m9d49hQHVhpm?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12fa3cf-33c2-4585-b876-08db2aaf909f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 08:30:30.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhQKY9pGJbOJxgAjBsjBMZdaAYSEW9E3XhjKHFW89SYOpeHpZlGk9kyF2xyYG9ysKEDE8mkjkCDFNgiFlBmOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4944
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>

Those pixel formats are used in Synaptics's VideoSmart series SoCs,
likes VS640, VS680. I just disclose the pixel formats used in the video
codecs and display pipeline this time. Actually any device connected to
the MTR module could support those tiling and compressed pixel formats.

https://synaptics.com/products/multimedia-solutions

Changelog:
v6:
Refresh and fix warnings in its document.
v5:
Moving back the document and rewriting the description.
v4:
Removed the patches for V4L2, V4L2 would use the drm_fourcc.h .
Moving the documents to the mesa project.
v3:
There was a mistake in format macro.
Correcting the description of 64L4 variant modifiers.
v2:
The DRM modifiers in the first draft is too simple, it can't tell
the tiles in group attribute in memory layout.
Removing the v4l2 fourcc. Adding a document for the future v4l2 extended
fmt.
v1:
first draft of DRM modifiers
Try to put basic tile formats into v4l2 fourcc

Hsia-Jun(Randy) Li (1):
  drm/fourcc: Add Synaptics VideoSmart tiled modifiers

Randy Li (1):
  Documentation/gpu: Add Synaptics tiling formats documentation

 Documentation/gpu/synaptics.rst | 81 +++++++++++++++++++++++++++++++++
 include/uapi/drm/drm_fourcc.h   | 75 ++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 Documentation/gpu/synaptics.rst

-- 
2.17.1

