Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE256C702D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCWS17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjCWS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:27:57 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFABE24BCC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG0zOWLp9nEeyw1+5w/gexIMLIG2PSgAaue728Ff5hwJKgjGrASwjOzjC8QJ3cL80Mb8av/iql33m+sKbLSUmfAajBYUBWD/r4VOwodnwug4I9v1YvuyFM8LIiCXxc/xaCj7TY1DaBpKqBw+17t9zNe8qq2UQUimNkRhtSZOY0+vb907UYUq0T/dUUn+Vpgv9GNoosqMApdwLp1Pz5u0UOWyWe+WETsvKj905PhmNBosoOhNHts3Qw5+vib9HIo26vOmH29N4OLP5CVmKFCc1Z/QOaOHvR4eSfJrN5vTGNmu1au9tTg5Ho+7jxfJSsClbC7lxTkMf/paSR7I7G0yUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGmnri4yK3W6YpANDYT5wcbKwjm6uXhuem60jmPQwzc=;
 b=Y1x/KcWW0tUR9YPfyEh9fBfbGGQ0u5tjb9XGll7Ioxf/LVR2sSJ/h6Z1UsL7ldgGybgZRDLeR8J1ySQwyVgZ3Rr7AKsV5azUq1llSlMfgDHqDZcbeBYaEOlsKX0oNkz7t+C9FZ9akcqLQ3NHYIHGhmMgH7elYdA4bn2sRwy44FYdz9FXl2BwxvzrpLaU/najZbgA0YVlAysSgqQ97cmob2AU9npdss4CeKLeDRg2w4Vy0IQ5p2GtoE5x94hMfNnBEn8BYMVyd5pxYffUajbcN1TLNFpIphGmrT3JDQr6OLmYykuQN43ddIC+UtTF26v9iFKvfig07MlLMGX/juuKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGmnri4yK3W6YpANDYT5wcbKwjm6uXhuem60jmPQwzc=;
 b=B566O5YU7ZAPQfW1kqSKGVzMvpoAcnLa9vKbHOsqTMQsoLQxPazuMQqHhf96tGhC83KpAjwnLH3Wdstmncq45ODF1O8M0JFhZ+J0SGLH/Ny4Xa3No+LFCgBAJY1azbr7gXfmVoOrgFtMYAj3v7Mk2xGKSIvntQ7tCHPUp0v0ucjw0jhFay1WL5n8PZYwzTviYFzojf9c1EW5g6AHgxF2hqWJfDuIo72q7ONK3URKP85W+4T9pGFK23xVv0V9vX16r0OEbE0+vkID0rDDmff3oa5/vW5kbq6hAeEsQZ9hLTi6bK97OW/ns1sa1VQHN43R4TNV4RdUS7xqbLLRgzgxog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 18:27:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 18:27:52 +0000
Date:   Thu, 23 Mar 2023 15:27:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZByaJYq9S8jHUdWa@nvidia.com>
References: <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <ZBr3/1NzY5VvJrJQ@nvidia.com>
 <ZBs2xaa7Ow1pnB3C@Asurada-Nvidia>
 <ZBs6xlqMGYhLbI27@nvidia.com>
 <ZBtVN4o7GhjHF5Q7@Asurada-Nvidia>
 <ZBtZ7F3NsxngcKIq@nvidia.com>
 <ZBtoj3deE2Y6k9lq@Asurada-Nvidia>
 <ZBxDM9JJSbx7yB8e@nvidia.com>
 <ZByW3CkGpt1W59XO@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZByW3CkGpt1W59XO@Asurada-Nvidia>
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c53e46-7703-4f45-1d31-08db2bcc504f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PL9j3GYz2ClJwoXY+FFpaJg3NsID9SDhrHNj1ZTIWWKWbsEVtwnnlBuIZCliIqXZ92qUf0IP0fWJYXZdmSz5o7mciIFPTHJmSC5iCpWPELHJWYJaeoYMwux30u5oD7y63y7+ppz9x92Q4A+HbOtpag7EoqmKY8jCWeSs/ZVgMqkiH37CEtGOEBXPVN0Y7U/PKIJ/nR+DNYYwMbHIwxlvqSxDCxSfTpsJr6fNpPZeXPk3qrfXPRkFRAnvWpzgpjtiOS0sMGST18BtIeagugiuDzf8lBFFuKVxxxT5KLoJLAm6cwYV1gFLBBYSyDHyR/btfsQTQtgEqzIKM9b/7GkBul8x4g57U85uv0S/QYtmZZm+NxP7e/89k3vfIJWl5RMcvJvb0WeZzTVFnPXM2H2q3tGPlopgQCMtW4q/ztvYBeIpARdKoCWUABOxxjRd6HJbE3SLhGFpM0aDGk5G2xGd/dEA5L4WzPqK0NUbRTSn9UX8OJ/bi5ZfYn1j4u1S7pmpoAy6s8n/jLxbkcnBymyYhb5NT/DZeCZRS7PKEvLsbjZ1p/xFJRV9wexF7aS6Ci8ac2mz8EzzMNMuNt9W1HzSdITRUuNtfWjcpy/+Dx9rg2k1YXZs24u5hUDd+6YDPzUqTlmo8/IRGIyzPcNaNaGqNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199018)(41300700001)(66946007)(8676002)(66476007)(66556008)(4326008)(5660300002)(8936002)(7416002)(6862004)(2906002)(38100700002)(36756003)(86362001)(6512007)(6486002)(186003)(316002)(6636002)(6506007)(6666004)(26005)(54906003)(37006003)(478600001)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GaH3C19uqQj5Sbtih9Q/chUMy84ngkhpyO6qk8Q+RAev1tF1PbkzirR9pPGR?=
 =?us-ascii?Q?G+9hHhTKtvr/gz5WgYACZjnYJZ8bobJ7TCTUdOWrqQxyPfaxLJaTh7W+dF67?=
 =?us-ascii?Q?I6OSrf/bdqp8/zPTuqbl99/IxpQl4vJqr6IumNxn2hQild5UxvQZIQhA0IVc?=
 =?us-ascii?Q?Fb6u/omEevM8d0YBuiSUSGpDNsjFKY7r1JGs+CoFbShfmuKGvRCt3ug2PFXT?=
 =?us-ascii?Q?WM1/p+1OMupb/GfVjMnoHMVzJJdbARZb/svtWr7ZPlsIIU5cUKd02VBWm67C?=
 =?us-ascii?Q?9R3hyWsOi4qr+oldySY1+UgFAy5DQMFSBgLehRM8VE133wALrB+LJ7dblOzN?=
 =?us-ascii?Q?uWkigeSnWeZz3zAedzw3gRmFPu0U06eB9hnouibHYY9G4U3AUhYij60qVcZe?=
 =?us-ascii?Q?tioWRQPgiEzmdQ1nsZB1OlHpM4JGcDYcQECTvWBwRVT+qsgmUqRQlzXg5INs?=
 =?us-ascii?Q?HRKRstlGiaTq5lfPq4KNkYadJgTRH51jP4WlC3QsQmd0A7YYsCdLP2jhmsPC?=
 =?us-ascii?Q?lynPgTF/EqvbJuxGOwZ+Mtkd+BJrsgdounavxtBVLbhV+9vrSQAKKwxbCDM9?=
 =?us-ascii?Q?0jQibRfCrsrYugWXwQDab81x5LGZ0m0ko/cMO48Cv8wyYs7imZTYHMQcEiUW?=
 =?us-ascii?Q?IPSqpN5MIjmQp4sh1F/xS/8Lv9/1fPm1Ki4wzQ1UmJWbfvl7vMT10Ogc/lTV?=
 =?us-ascii?Q?5485mWR/DyiuA1iq+MfxqkHVzFYJp+IBpLGT8lVnChKQJYB4xWwvIES/B4AF?=
 =?us-ascii?Q?9QM4H+X2EgdNeWzQYORek/m+7LeaTCatw3dbJ7MwIR3VQotj97rlUXzPBwCt?=
 =?us-ascii?Q?ZjLgDuFDbAZPJcfN+2+/ry/bUyo7q+9YKeylA6TlrVPYZ7vtwbg6Zy0i2xXF?=
 =?us-ascii?Q?uM2147E3WBVzSGZaxx6OH5NqPuoa6ZGeZ2qG6YG3DDO1VAaUl6yE9OxnqXeF?=
 =?us-ascii?Q?/H2HyYvKA8VLCfpz0fgf6TDSpULaCkvnFpEP0WZ8nFGSRdaY7tObd+iikODo?=
 =?us-ascii?Q?Vj4vAJRQFNbW76bOcjU6ZaXr2ls1yRpCHmKFoLgDFNpCHIGqAo3T6YcSYKeS?=
 =?us-ascii?Q?7RoMUSofx45gXJexhU8O8Y/t264mM0WfYS6tUVWe4DlQMDKlG2clb/5PHxVw?=
 =?us-ascii?Q?z2JE4/jdHcD4k7roy45Usrv4TlhIZ9K65bAJrP12fi1FL0UU2sLNXKJF9TKr?=
 =?us-ascii?Q?mUnMzSn04KLzPScHOt8ay2OPx71jxiT1eeayzESxQG3jL6wnSOY6b6wSGPNy?=
 =?us-ascii?Q?rdTQaoH1k+y3WglhGzYp8LInS+LmJFd9kUcS+7cx34/q5cYYU7R0/qT215Tt?=
 =?us-ascii?Q?JWt+umgEOwZiBaJpQlUkGao0YJUfk9Cc2YDZ5SIyMUueJCli4MfsAi7Q4YBO?=
 =?us-ascii?Q?jWOLtMwGEBEHJmumjsVAhOyTLIbJKZYPX8BnB0XlnJx1n+n3XWeNT4GKIZS/?=
 =?us-ascii?Q?7xX72bgRuKqBq2BrAdIeRRVKBD7Yv8ifjX4E0wlCH7wtNpSmmspuB3yckXGL?=
 =?us-ascii?Q?adxXo9aQL9E62q8fEOmPiEKYb0xiq9N1uM7Vv+KR3CCk+E9hSa2D9G6AL7z9?=
 =?us-ascii?Q?YykyPOO1ExjhSRoZxr7oLrglmwkhg9l2+LeF9yqK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c53e46-7703-4f45-1d31-08db2bcc504f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 18:27:52.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lC7b5y6T3W/JlivyBxQook6MCfovGlgJ3IxQPIyDFGEwdxiKKgiAVkp8TCBEim55
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:13:48AM -0700, Nicolin Chen wrote:
> Oh. So that the s2_cfg data structures can have a shared S2
> IOPT while having different VMIDs. This would be a big rework.
> It changes the two-domain design for nesting. Should we do
> this at a later stage when supporting multi-SMMU instance or
> now? And I am not sure Intel would need this...

If we do nothing right now then the S2 unmanaged iommu_domain will
carry the vm_id and it will be locked to a single SMMU instance.

To support multi-instance HW qemu would have to duplicate the entire
S2 unmanaged domain to get different vm_ids.

This is basically status-quo today because SMMU already doesn't
support sharing the unmanaged iommu_domain between instances.

If we chart a path to using a dedicated S2 domain then qemu side would
have to change to make a normal HWPT to back the S2 and then create a
real S2 as a child.

This implies that the request for S2 has to be in the driver data
today so that the driver knows if it should enable the unamanged
domain for S2 operation and lock it do an instance.

So long as that is OK we are probably OK to be incremental..

> > And a way to request the correctly bound vCMDQ from the guest as well.
> > Sounds really messsy, I'd think multi-smmu is the much cleaner choice
> 
> Yes. I agree, we would need the entire QEMU community to give
> consent to change that though.

I suppose it wasn't consent, it was someone needs to do the difficult
work.

Jason
