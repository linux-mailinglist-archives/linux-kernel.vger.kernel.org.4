Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D40C63BDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiK2KNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiK2KNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:13:05 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28F360349;
        Tue, 29 Nov 2022 02:11:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NstijxWGCpUH5/1HtpXtnHxyxgyC5dD0iao+hkb9sZaUKoC5fTWtp5axmrIJUWpoEyHwcfZgRm/og9Ps/1Pc2HMjEbvXDeJ7O66jjGxOi4GI6htrcKwf877oshLalUMuBix4LzymLYiJLFpBDZYSJbirY4eV93QWbyrncGP83uhkOqkq4RC7I/AjomWhwKDz5iLhssSh07TbWJb85hHpUiMgDh/bNf4tYFJjAGIRYwgXDqIhgnN3aQjOyN6wKr7AmXtzw61XNhv5A7dnT6C30GcMzPBINzRkwHqVtPv01RxEhbO3rL/HpmqYq/WaZ+ddLN6/TW8qglfGaT6sU6tibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ddCxePYf208LNv13iRvA2SYa5H+1anRlq37hgKMrLo=;
 b=eKYWf6qxqgJsevyaOVKcxvmb3xH2dQE3+JBztA96G8d8knd0ybxXjSltBZ+SOtOrZVBMJZjehdkTOTwLRNdZYb93/AeVy09fq2V1iZws8wGiypWwvVRqXfIVORMQp87FIakvQ4BJ9et3IomjTCjv3c+19R9JiKFmEAJL+6ZXhbuUlligBKfg5KIH2DyC9h1elZ0cUHC2LIDq9tQ/zraf9w4+PioVljOiKlBW9ohx/OULV043uM60LEnQtD+pm9OHWPbB2ibEh+xfp1pz1/9kk8qxuiyedw43VWcUh2AFqpqD/Lkh0DgDBE6/YCIT8Rm0xZrQ4isrShSwn2djjPYVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ddCxePYf208LNv13iRvA2SYa5H+1anRlq37hgKMrLo=;
 b=nu+GHFM97FHinahUY8S4BD4be774Pz5g7Z9c4qOCGH7ouviQiwqdyV+0CteiRoKf3xJk5gvXTlB9g1vNReFEx1U+3osg4k2FS4sbn5nWPtd3BfarondiHwnp/4UQxh8xowM1zAOpqLbSl9Zsg8oHkOPhusS/SOMaza5sS650zlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by PH0PR03MB6368.namprd03.prod.outlook.com (2603:10b6:510:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 10:11:07 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 10:11:07 +0000
From:   Hsia-Jun Li <randy.li@synaptics.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-media@vger.kernel.org, hverkuil@xs4all.nl,
        tfiga@chromium.org, nicolas@ndufresne.ca,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, ayaka@soulik.info,
        "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
Subject: [RFC] drm/fourcc: Add a modifier for contiguous memory
Date:   Tue, 29 Nov 2022 18:10:30 +0800
Message-Id: <20221129101030.57499-1-randy.li@synaptics.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::31) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|PH0PR03MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d9ba93-994f-4932-3351-08dad1f207be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23gcwD7CyWdgx+z7eDdxI6sDznvAXhWgGRQnB+0Zf+lZ4kpBg0dc4IHu2VVKEBumkPd0DcIyJy2+/jz9LAFNFoGjz341In6cb3ur9MDfPlyDqzqZt59NuhBDTBmon08dSpYCes2vvycyqzyVyRHLdhSTo/6yDOF2RKBC+iMtuR4lSxn4mh3jU3GRu8QMt3PpZI52Y9qNJXj8DSYIEOI44xSNBmpOnwvppKFelAnzy5ZbScDs0EvC1ubXy85dJHNRCJKhj8WzRvO2iaHIo0SWqv9l6sp+sOot/XzqcPkGHv/JzslX4RtJvCu5gV6hVEX1/fwN9g23ra84npirtlLf55H+TUmNmZ5r+TubQnwDqeZ9A81xqA6c84khQnFrqdImqmIgC8Bpb3U/1y+7XHfX9OY5lXqU4mdt82CvC/0HUcG21qSbNxa1xRhSpoXLYZqL3anJjIBjM2Q2Nu5lqEaSpmJaBP86dYHD6/iCFCz9j/0WZxgitsCXWpW2wTjc6JBdJRe5U01eAQMUAWfvBFvcjdoPX5nl5GpoHXiHduXcsV37dsA+3lOa/6kTmZZFzSY2llexkDJXewnmC3yubSIZWq7DsDCGWuRBM9xurr0f7TdpUK5gkyiHPYDboHpEcuRttu2TnfEuyZfoMe+7v21Ux6Zhk4yNBbWfy6BkXsJttV82hPg6j+K1sh/f0pR4q95X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(316002)(2906002)(478600001)(66946007)(86362001)(36756003)(6486002)(6916009)(1076003)(38350700002)(38100700002)(107886003)(6666004)(6506007)(26005)(52116002)(6512007)(186003)(2616005)(5660300002)(7416002)(41300700001)(8936002)(66556008)(66476007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?anIJWs960hbLY/lINvDdJqaD1ftgTWRqzvO57y/Etp+69JZ8HIF9fc0/CY2/?=
 =?us-ascii?Q?OGeMTLvlUqidfMQ4gVnSzKtA9TcjMudA8Tx3Vnj0KnySIGPU55oANj7f4tCP?=
 =?us-ascii?Q?RdUNfuoP2j00SMvj2GaIfYFBQXaP5o+brxDPF6thpdf243P0O/2z4VpNUDcx?=
 =?us-ascii?Q?Ky2dXxjW6CKA2P0JHApuq3eu0bKDhiLRJO+S1mqbbhROh1FOcp0wX4u7GN+1?=
 =?us-ascii?Q?QgAOOBPr2X1ugGJsZstU25VEd3zYiwWQAvdIkUibcWnvLOYdsEEipSwa8n+y?=
 =?us-ascii?Q?ZrFtHNx/Dmqq5WAAF/Sr4pNrYToYjT1e31UU0FDs6s4K3AAeLiK3V7aRcKD1?=
 =?us-ascii?Q?QqN/PoRW9HheMV4936BWCXXSELd9od0LoqzFkbjZ/4YEqqDUkJHF8chIOoAO?=
 =?us-ascii?Q?NDq7fho44ITvO1f9uqoho7md0ngVMO45J7EpNxxb82I08kE+ZdQWGTU0AkI8?=
 =?us-ascii?Q?KzH6PEyIt51w4DwRlPaYzr9h27RWBsaIIqUG7xNFDTUaaLr72StGCZMU9uN2?=
 =?us-ascii?Q?IIrCM6jjieD0MiGcX6obfR1WR/DwPD8oEYXm0oT0G4mFUybl/P3kfn9Irk+0?=
 =?us-ascii?Q?pQxG8HDuIcprQmG3TaUjOCfIkRD/1lVZ3Lrz6BNrHM8PaYqJq4/LObkQPVc5?=
 =?us-ascii?Q?j55WcW8uPkEjRDRXSw1teB7WFAdbgMw31npIRN0uQCv7CyPDDDl/atBYe6sT?=
 =?us-ascii?Q?Zs9PfmerqmuKFXl98/0KW4tjKvJpplsUfmvl1PUsiszdOlBaXCQ56w8l4cOl?=
 =?us-ascii?Q?JPYvbdehcQo0PdcKcDVhB6GSiHepN1DM1gR8iR4nSWfc3LUbbnyfv7O6eRaQ?=
 =?us-ascii?Q?8geYDtJGZCovuvwZLzeNjutwYm13ZmYw0PWE+30Xr0RRyVZ4q7x6Rn8gI06/?=
 =?us-ascii?Q?Rc/FLH969A4m1BCJGas2/hgOPqXaMH01Cp+zL3iTITTzTy7sArvI+jFXFBR0?=
 =?us-ascii?Q?CtbuNC4H5drRaP7GhwHY3cXG1uM6z9iGyy1PjXsH0d0usfgnK2Zid8BX/O1B?=
 =?us-ascii?Q?owVdbBz6m+bq3N8m2HEVdFJUCYbR4K+CeZH1WTc3L/RDn/4+skbcU5fZW37K?=
 =?us-ascii?Q?zZpZHzmL/sDYP/w8x2WqASR6cgLm/K2cEP1RlhMgE9JnSF5eHauERNF5qMM5?=
 =?us-ascii?Q?T8q1kWI1dqzVkLjAl8kMM6J8R9FBvbQLe8L6Ct/Y/sWsLuRe/AObRQ/JgNwa?=
 =?us-ascii?Q?uYpMJB0IEd/fnisKLnchCPfBOND5YPIQE05EwFBJx4tSJ8109K2o+fZn1ewA?=
 =?us-ascii?Q?FWcUyg9fEYYt2lGulG5nLoI38KCSdbyYWiQ2A14/hVI5vVfVLcifqc7y82NE?=
 =?us-ascii?Q?oAUixc0itoW8uojK5ygqUYiqlUwISgTtqWiKRYz+37Dd9jVz7eRQ6070NxFL?=
 =?us-ascii?Q?ENVoK3SYGfD67yi97ZKp0iF4IDcIc/1hoD4tb2C0gqK4jmlyRhgSsexHhOic?=
 =?us-ascii?Q?WQv5dtbT57tAvX5rsxBets8E5zbIND1hg/9641c2d9AFX56XKobdn62nhQfh?=
 =?us-ascii?Q?L0/2P0L2hsjVTHAcOouaenEEPJPGovCmfY/ekFf/HaVh1DfQRnxkHjtmri73?=
 =?us-ascii?Q?ce56t7wm3UyM9NaGRWlB0oHzuOq3iGQlc4wxW0uP?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d9ba93-994f-4932-3351-08dad1f207be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 10:11:07.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES/9cz5NPmqqO4a8Ax4grkntIKOXnnEFgh42wfq7XTcoa+dFJJHKaqTjEo5bW/OJQELlVZzFmLhKLfhGU8lxpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6368
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>

Hello All

Currently, we assume all the pixel formats are multiple planes, devices
could support each component has its own memory plane.
But that may not apply for any device in the world. We could have a
device without IOMMU then this is not impossible.

Besides, when we export an handle through the PRIME, the upstream
device(likes a capture card or camera) may not support non-contiguous
memory. It would be better to allocate the handle in contiguous memory
at the first time.

We may think the memory allocation is done in user space, we could do
the trick there. But the dumb_create() sometimes is not the right API
for that.

"Note that userspace is not allowed to use such objects for render
acceleration - drivers must create their own private ioctls for such a
use case."
"Note that dumb objects may not be used for gpu acceleration, as has
been attempted on some ARM embedded platforms. Such drivers really must
have a hardware-specific ioctl to allocate suitable buffer objects."

We need to relay on those device custom APIs then. It would be helpful
for their library to calculate the right size for contiguous memory. It
would be useful for the driver supports rendering dumb buffer as well.

Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
---
 include/uapi/drm/drm_fourcc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index bc056f2d537d..ec039ced8257 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -473,6 +473,11 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_LINEAR	fourcc_mod_code(NONE, 0)
 
+/*
+ * Contiguous memory
+ */
+#define DRM_FORMAT_MOD_CONTIG_MEM	fourcc_mod_code(NONE, 1)
+
 /*
  * Deprecated: use DRM_FORMAT_MOD_LINEAR instead
  *
-- 
2.17.1

