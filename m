Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF1680F73
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjA3Nxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjA3Nxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:53:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BDE36FE9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:53:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLQuuDxDAQzSK8Lc/P3xvoyimnj+Bam/1MT5Y02wCFg0asc2/kcn5n5eRfygtQwXoUHEyOl31Iz1eMzA6Yeov5OGMps1IdRFyNa/f4AzCvq0JuBhFCknXljtOODmoS1zAQdJsoXb/BLqDbts2TMwq3ldj3bV/jyQ5Ph3W/glugBa6gHHplxHnCiLt/qYgDox46u2IhyeGOj0mJl06vc33I96R8cur/MIIBZ9/ef0Ib42VNZ/uZhuw5aVgUz2tA75qf5vmgahO1g6oT0Y974Dn4fvgjDa7jbvZjSyYqOBBLyDTOAcSo/fQz290Y1joP7aGzWcSgHiN883zZKccEceBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEUavwcM6ArKRu8OT6ztDG/yKPY5SLheACcX1Sf1ZH0=;
 b=l0sstRdNffE85m3WhvxSfosD6cyWqIsFau9wdmGC63gRTbt3CZ0C0h5spdckgkEVtJhHlhBFS/4jBtkD3w7Vp6upCnrDd5y5JXWpuNqkmpRYkY+uiSWwB92C0NTasyM07cC6EovOgN3v9FQoj6+jC9no2Wvvymsvff9agQgkZlK77LlrH5jjVHaOxC9Sp2EefUdLv+W44Ij2aUHWiWJxChzuLF38ip/AwFUkzG3b/upwDbC9pAPbhcACFDbHqpqP9VF32+XPYjsBJjf/ifK3x35pBuHxt0SlZo9tVxKlDtZc86SdHVovOuo1XDlgpMjcKIWETPbLGQ/EY3izUWA1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEUavwcM6ArKRu8OT6ztDG/yKPY5SLheACcX1Sf1ZH0=;
 b=jluXcax5uCoVZfgN4NHAhsKvyCqsfRxhdUjZJ9wqIMnny6tBB1qpAbTvmZvyHG30goS2DkSVJ9m9HgAkdZ5NBzePXBtA8beU3uLcGrchDVFaPFKtBBa+JU4iB9HKx1GPz/yQzl2TZkV9zEFCVAJ0JNv8kCeCVH5/zdrYRwhQ6PRyfLBSAHHqKAZ2cFZjIH7x6HPBaIurG9o4BrU1p5u5eb6ebVeMI0S/q2ZWitFxnFguSHRLUWz036Zn99r6fEZ91KXZ8t+jqpxDhCij0+Zq82FF0kHfGUNvekYaO7TS0WA+WXRM+9cuziQhoL1Yo4W/s8gDZlsDtLL8d2gJ8/Cx9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 13:53:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 13:53:48 +0000
Date:   Mon, 30 Jan 2023 09:53:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, hch@lst.de, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Message-ID: <Y9fL6gc4gZlQSzht@nvidia.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
 <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com>
 <Y9KRBRKdwSIRrvQw@nvidia.com>
 <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
 <6e0728ae-74a3-b76f-c5c3-6504e13c721f@arm.com>
 <Y9PxKLyQg/+ZrK6a@nvidia.com>
 <df59477f-3751-7314-40ab-9519dbfe0fe2@linux.intel.com>
 <14a5130c-3180-87db-5a14-2aaeaf97b7ce@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14a5130c-3180-87db-5a14-2aaeaf97b7ce@arm.com>
X-ClientProxiedBy: BL0PR0102CA0035.prod.exchangelabs.com
 (2603:10b6:207:18::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d97268d-de50-4baf-1beb-08db02c9691f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjF5GF9dHCTmX4SGqCf2VXnVCujwpuCeAPuFTpCki0UgXJXeJJMvAIEmkiUBKItA90p4MxHs6aJ/QY1CToTWWZkGqGexFGSDL0Ttr6lawaa4FE7xvAf3+Cd+yAlYYdFEH5DqtOm5kWxD4Ozy3do3eG0qnIBvRFSg0wyBsXLNDHqw1QoXH57MeDFma/5tIOE4wbkq0ETfUyr8pqEGpKkNykfmqRoP4FraUDMFXq6tVWpfTZj0cO3juesRV7XK+apXfvXKEt/0HoW1OxEpEw107vPqIccnHtt2VdZJFBsEIQHPWnfm/0/D+yZyZHvVMZeQqwm0z4ij4FG5jf+oiqmzI3ydrmPR34NCK2dDECFvlJiV5tI4hFbqyj77If3GnMrvEiEj4QWXRkSXYOlAxjexiCUCK9NPWqWdqHanGbNx5zpLVAy0/EaXldRHJLqjBcm1Gcj5vwWnYjw5t9Vx3Lb3i9UTmhCvknRvSq7q9BTgeh0j1Dn3KnbpeC3eF2TOWwmOqn8DuoC4tcBCqYtLw5utr+BkrsJYujA+MDTP9qKHqVtQfM9Ano6XkGuDhp32VP7pFOXqvW3LXh/rttR/S3ewJttUoiSsEEFUbJt3Bp4KDlqicBw5uEARWijWLoJesXmnydkfr7Xw/bg4Et2JZHgwZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(2906002)(316002)(186003)(4744005)(6512007)(26005)(6506007)(5660300002)(36756003)(2616005)(38100700002)(6486002)(66899018)(86362001)(478600001)(4326008)(66556008)(8676002)(66476007)(6916009)(66946007)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYr2k0bOK4vV/nkZZeMxE5KwOXj+mvUS7ArUOAL8sIWlszlO0jSC5KkJrfJB?=
 =?us-ascii?Q?rFnl5gnyDqE53r9Wk+oSv3fggEmQbxgcen1NOssr0FjfdwtnwxfxMW+b7Ia0?=
 =?us-ascii?Q?wtu6aqZnXSFdv15ZXXbm73Agu/FKl4ESIEy2Viw+WUf8hUBkVXzWccqk48Ur?=
 =?us-ascii?Q?IXZEua0oXMaxFA5y2KKDmWt+Jfyfip7iiykF/uQ9LafmH5XwLVhcWewOZVeQ?=
 =?us-ascii?Q?eOtoH1ILS91uhoBB1bwONReQHHqHU79A3FX5hVOcZBPGWUIgrw4bafkn7az3?=
 =?us-ascii?Q?0qFKhLQnvJKEzz1h+aKaYqhZV3oMYVL4gCq+v3gXlFunwkUXsaILMTWCz/LA?=
 =?us-ascii?Q?ayO3uNmyKnI8nacyHcwXEzATzPYwEfcMcpOYZ164SX/CR169SIotewcEOkO4?=
 =?us-ascii?Q?flUcVXB4dHF/JOWLVDH4L23gJnlf5pXREdW+MQ0b8eEV8cxdUfPsOux8aTDx?=
 =?us-ascii?Q?1yC99rE9VcisHrjN93U9LyhwiurAdWwIwo5ybACYVsNrLcKQZ04UAxH2uHzV?=
 =?us-ascii?Q?aw2nX/PhiMLSdTR504vjwne7C2i3b52+VVtokRRhF0V3/Sqs2JbSJc+wTKoJ?=
 =?us-ascii?Q?8AB2pmIOngO6JkK+3P4yFlGTk+pHxZQmB0IU8gSS+52vg47x1x9+S+R8h6ec?=
 =?us-ascii?Q?fuji92+hXQdOgnYkasxkYjc0oXZK1brER/eUXTq6n8W5rzbLjbri5VexwgOv?=
 =?us-ascii?Q?jd1nEnu/BIujVM2LUGKWwuP9ZrN/wfAIwVpU0+TRzt84vQSFzYzvAY9FzPQZ?=
 =?us-ascii?Q?SJSBjUjWCVcmQszmhmaTtCkF0fVQq+8etugx129okeI5t3CG/Z1ovylXk9dN?=
 =?us-ascii?Q?YlUqQ+ucVaSoMNMR+KiSrEv6MCtSaN3uJ0lJ+s1ouDjBMz73oqeAwLzEGdvL?=
 =?us-ascii?Q?JJla9iHiCA249BC1fPzDFD+DBCBPcIaWaIs7Cu8FCoPLkk27ki9kAeCj1Lq9?=
 =?us-ascii?Q?UItrBMDzgYNCouMzC1oBnbTgBSALwfvZruOwPD/gE2mH6sDXePGKjq3r9Q7T?=
 =?us-ascii?Q?oTiUPKuYzChdUIfG2r/JMiLKiXLXS3dlj4XrUA/fjjFGFWol1s53CyUWs5lp?=
 =?us-ascii?Q?v53qiffrCYdi1iuuhIyusyljNHPAq6N/0pCINMpRtw5nmFU+LLGbjKhU6PWl?=
 =?us-ascii?Q?oXWNIpErQhHQffzF8p/L9wOAwJkhFe/yff+eefE05ZkP3iVL3w+KYObfaB8r?=
 =?us-ascii?Q?DyR8VwFAl1a3q2iEghMzevpgg2C59AQBlDCvfpNq6Mn2X0KQxJeC0UK1cELJ?=
 =?us-ascii?Q?/VJ+D2fM3DUSaXmY6HCoVQJLg1EzdHycAL4b2Yp0GMcizcd0QTrv132JfYvM?=
 =?us-ascii?Q?/SliUPkQQXJl2VrPN5SPPvFk7PiwNTpApQS8h3ouxpjiRB7rkK4F56YqjBAt?=
 =?us-ascii?Q?T6TRjCOMI8EvbI4qY1ammkCRfiZ6x554y41KGbpPZYwy7zawDbsL0F8546Hy?=
 =?us-ascii?Q?1WQsZ6gPvCeDcZ/A7L5FbAgamGLUwN0fJQ43THb0J1E4gAQ+ngYQmZtWP3kS?=
 =?us-ascii?Q?sih9+oAwzEeY6HM6SxzsG8mwmQdFclNUqSRWDpLFiRgEEeYfAvf9LR/zxcOd?=
 =?us-ascii?Q?cYYm44SySYX4YKFT+TPPbYo5zjSmok9vqzF1IEjR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d97268d-de50-4baf-1beb-08db02c9691f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 13:53:47.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSePNL5u4o/Nj583jKCA4ozYGP0VV2bbkJ4pwe/+T2jnYb8I2/ojUU9xGPcSgF7r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 01:49:20PM +0000, Robin Murphy wrote:

> All in all, it's only actually the habanalabs ones that I'm slightly wary
> of, since they're effectively (mis)using device_iommu_mapped() to infer the
> DMA ops implementation, which could potentially go wrong (or at least *more*
> wrong) on POWER with this change. I guess the saving grace is that
> although

IMHO habana is not using the DMA API abstraction properly. If it
doesn't work on some archs is their bugs to deal with - we don't need
to complexify the core code to tiptoe around around such an abuse in
an obscure driver.

Jason
