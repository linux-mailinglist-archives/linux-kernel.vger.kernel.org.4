Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3209B6C128A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjCTNDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCTNDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:03:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27212BC2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQDWRpDy4zHsqgz/cWzPaxVbWLsMW894qfyXlc2AH52v/5Qmq+EnHqIdKtYa3WIHIMnnxXK4j+z1shxv3sk5/O9hghNxYioCW3s7WSp6NA8+XMJgK6wV1eaS1LuHAmSxLpGYXdqJ44DNKgMv2KN0RWTMHDCL47NqqaDPvJhds9Niy80mwT+DNYD4pbw+GlUJ2YGyymcGz1AA07OslEzoj8LgSUNvnNq52wBHt5bkDchGO1kdNzBQ9Js6QsgRHAEUhqcdQwHizp7StvmAy2nrtqTOZjm4NyGiuvgvloGuSYqJiUyg8yOY6VU8NLOCKbf0WqBCg0SVb8doCkT38gvayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei9FfWGJndp1U8e/2naSqMIFyhO81B/6vFTrG1QYMcU=;
 b=Ffehj05L8PzeU1hatw+sLkzZxBzVP4egJM4xluxJI1yr+wu4zUSxBk/69AT/CDVE+9Sk431YDnqWBo97dU7UmtHWZlbZ4sZaMWudx6ekVsO1XWuhwF+qwlXJohWce0yfaFSVRwvNLPzoywL3bnBlo2PSYvFwLc5N+Hg4paIIgnr1jGGeP+gRt13iiVOjvVtOPnk+1LD5uDVyP2+UJgeqIMaQPkmtH25MyhoH2S9bPQEGbRJisOEEQDfJsYwC1wv7F/tJt8XQv7yGNFAjkghA9xUQ+x5Ri1DvsYbD3E4vS5DQ3Dh9YRgEi8LPD0HSwUxT1wkRp9Srvx4CzwVZNyvZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei9FfWGJndp1U8e/2naSqMIFyhO81B/6vFTrG1QYMcU=;
 b=WmGbJOl5w6XL7wZcvMuejeieKYoB2HSrT51t4lkFI8SK2BtwSafywCjsKAvcFEWU/T2rL8Z/8vXcXO+hHqtQel8CGs37tA67vV7wxZEhq9NHS/nqq/FGFF9t6ToTG0eUfGlVUAoG+4Z5RUIqnXPYowP5AkfhemjoND2YesEDN5M2RqmQk4nJGK5kKpKzMCXkWI0haCcKDE/FK895RzYjCyUTMoGK6iRpumG4VH2H01O8nRI2ZRkPCc7zktOFUl1Dc1eO6KieDjidaBTHHyqRmxPjX6lBK5+S+Y2hcN1mg0Uz9qjj23CExAKDtw0ao5Zd0kQcaa0LriHzB/mE+z7lCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Mon, 20 Mar
 2023 13:03:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 13:03:06 +0000
Date:   Mon, 20 Mar 2023 10:03:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBhZiCOQHAxEaamy@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:208:32a::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 7139f3d5-e767-405f-8765-08db29437251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92yQZ2mWsQVIZDn1xrkH+F2xhiTpEZbC/Qfh+kI7KVML9RWtL62/WjMbnujZKIs5iWTHQYZ5OoGITXXupqzU4FXZhQ8kwCsh2cOBqk4A/T6WxkxsKZ8NJDPrd7kwBCEhyP1YbEsGVnJahckXCyAQZywehN9Y2iPHNoswuXHfsUtuOQ9XZcUciIKHJ4oOhk8uRK/tOR2Ze6wO6rk3/H3w/Bk9rm6uiiq9vQrujs5TZxVHCsUoutNdDpvaXgQfNTrorYzipMNRxb8gn4urK4CE6FmNgJbn15PjCpImRE0wKRomNfykTCPQBd/NyxvXsDZefPqvLtqRagQd6t+wdZbnsWYMYwy96qfVaQYgXnAx/QS16pkOiv4WPjv7tFMcONNQeb/+inZhozqeBeSJMZStdLoa1VBPmQyURaTHkyyfXL5s6kQjed937Fctn+czsDCA3C0ZsImSg2hdNVxjhzu4bu37FZ2yRbfkXXbGoOLSIL6ktHcGAK6D/dbsI3XMuh3xpe9J13BhXrqA1HOeUVy//LdsPRsqJ9sDHdaT001R5prM8A7HbJdzPerjSbwVXGCwri5litCcRFAEw7eTTTUJ2be+afp38m+drr+UrCMAHNLU9S+OicxGWnxIO6eybLzxnkpHbpUIsOBh87h8Wm6btA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(66476007)(36756003)(6862004)(2906002)(8676002)(66556008)(8936002)(6506007)(4326008)(6512007)(41300700001)(26005)(2616005)(186003)(316002)(83380400001)(5660300002)(7416002)(6636002)(37006003)(478600001)(66946007)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8iqjB0LZzYVdvCVi8CeB+HYmiT5LM6a8kLp+f00ab3wjiU9HLNQ2hi56Ggn?=
 =?us-ascii?Q?U/+/QLLaNvf7LLrAlYFu984SjCQXHnhwXQUpDLgXhdlvKbDM/ywzHZErv6cd?=
 =?us-ascii?Q?/E3o4TOJ2WMwC5DVjUjByQxVt9gFliaANg3ONsEU7K82KtrSNDrkuERFhxm8?=
 =?us-ascii?Q?dJrqCYjxG/tU6NTIJgZuxC/6xvh6UO9OGqVGmcAqQ4+GK4EuNKAPZrR5AHiQ?=
 =?us-ascii?Q?h/2fJEJFzkMkkLO+0BP1W1huWADAhsRZ575M/mfCWAvKitqxtarjbS29LtMa?=
 =?us-ascii?Q?BPSOMv1cy/dQ9NgDVfJFDNSDdEFEfN5coTWk7WoUrukQa2B2zAhoAknoip0p?=
 =?us-ascii?Q?obGLGiBSuOe8NSkypi79lIvOz0pM04sU/5PyGt8QrEUKPDdWPOduut62+5WJ?=
 =?us-ascii?Q?gnZ3GGbOXVJhrrFh9LHLGTHF5UNDK7sXrdIriRrz34WWEygVCp9Ggc9IKSa8?=
 =?us-ascii?Q?62W52MZIUN9fZ7Tf3bHBKLLahFvpy1jP/+XzIY40P0W1uoDgPV7O7d4yFDKA?=
 =?us-ascii?Q?SK3uVeFgUObDG+rWlmyTsXzr5BLk/JTSrVzfLXebyF2F2c0RC6IAwO2zf7od?=
 =?us-ascii?Q?PTbcJXZ9hwWRsW3H3Y89uuOXcbHFXRs3bCpaZFTqha+gNIHbAn/2ibxNry6M?=
 =?us-ascii?Q?w98f23YmnC8g/aFgN9WHGb/Rj/gRAVo8I/6w/E5bVQ2w4UIAlwBEnWKLL+1a?=
 =?us-ascii?Q?3VobgskYY49zfh6j9sm5nER3bpE3+IYxx4x9NFT07ueU394r7AbZnzhOaQDS?=
 =?us-ascii?Q?kLmJXnYR/pGMYKaffqLcfepzM0hg9D+VqQ/cAwpcRxf71I2InuK9loZnCkX/?=
 =?us-ascii?Q?fZlL4nJcFORs9b/zaXeyXt+0eN9yx8dBSd1W9CDKfDBRu0Uns8wwYkLKAXlr?=
 =?us-ascii?Q?859jnO0TpB2GVqxnUnlqJC1+3XNDPwLlaZ34faqEsjnH8U1cR3Wz/LRTNLo3?=
 =?us-ascii?Q?nwL35K8pzLubvCGk7Bhuuf1TKk0sSgOQQs6FFPpsFa2Nzj5QzWhoOknyNU8v?=
 =?us-ascii?Q?LAQF3u+V0pWvq40s+I/dp3Dw+a2dRMeGIb3NazVm17G714N3enQIo8CLdMAp?=
 =?us-ascii?Q?8h+DCwFgPpXkpEQWBopxnNH2xWOtgTOcHpQRVb+wgDUW7QnN4HJrz/W7RoVG?=
 =?us-ascii?Q?U0h/0CRlLbb0QLKl4lURQ10ue8SRDbrd1zr86NCLqt1zFWy7psIhlIwkS6mL?=
 =?us-ascii?Q?3KtcGOSlL2HiisfKANWFCCJ4RWpU2Edu8d047E0XgH95WVDTzhPpCeUR5Qxt?=
 =?us-ascii?Q?A96uTG+4gcyeH8qfKAcHXaa09E8baUPnl5DiSRktXqDXghENUezebEuTLWgd?=
 =?us-ascii?Q?JDgqxpYrS3v65cr1ub4/DfWw+iqr9uGXsNnfXo/18C1/CTQY5zcEMhlGFS/N?=
 =?us-ascii?Q?pLwnp8Hv0/HK0vFJO4WN6jqcZTW0EScbZ/T1K9mJh8cC6BzyXFhMvYb6brS9?=
 =?us-ascii?Q?3BDSwtCoYLjUox0upV8XBkcby+JA10wFroC8pUCz4walIX2jsSBWbxo2a1yY?=
 =?us-ascii?Q?0rVC5ngC9uO+uThqF2wpfGzkC+7b9ofWbImy8VxZs4gbBYIuaCnTcqrmw8ow?=
 =?us-ascii?Q?Wszbxco0csNhK+gs0g3zAh2gpqlSSMbtmh/evnpa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7139f3d5-e767-405f-8765-08db29437251
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 13:03:06.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QtcgotkxfDrsb0bZOGchrRNTFQwpys2mLkgZYy/1oTO1ZV8+twS/vt05/EcCMul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 03:56:50AM -0800, Nicolin Chen wrote:

> I recall that one difficulty is to pass the vSID from the guest
> down to the host kernel driver and to link with the pSID. What I
> did previously for VCMDQ was to set the SID_MATCH register with
> iommu_group_id(group) and set the SID_REPLACE register with the
> pSID. Then hyper will use the iommu_group_id to search for the
> pair of the registers, and to set vSID. Perhaps we should think
> of something smarter.

We need an ioctl for this, I think. To load a map of vSID to dev_id
into the driver. Kernel will convert dev_id to pSID. Driver will
program the map into HW.

SW path will program the map into an xarray

> > I suspect the answer to Robin's question on how to handle errors is
> > the most important deciding factor. If we have to capture and relay
> > actual HW errors back to userspace that really suggests we should do
> > something different than a synchronous ioctl.
> 
> A synchronous ioctl is to return some values other than defining
> cache_invalidate_user as void, like we are doing now? An fault
> injection pathway to report CERROR asynchronously is what we've
> been doing though -- even with Eric's previous VFIO solution.

Where is this? How does it look?

Jason
