Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E56B28E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCIPbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjCIPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:31:11 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4D0EFF52
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi8KAw/19BVI35MHJezuZVuCb8wQJJx2geWtgyS0dgsjK0Ps0yX2lG5BeRmoB/iNL+cZGL7umBcQJEn1GWYjx6Knw3uTJAAt4yRtvAj8LsOMfR9ynWwzeSanP5wv3FaJUQsmwBE96Moukh27rV/kqIgIXTzLJQMNAHZzylNW2n25948as5cgfMhknP1AQFbYGGUOZCoVv/H4u/sE7JqxTXq2rxZcAfczAH9UQE0RCDcb8Lsr4QnpjGqdoiMojqBRfyEt4o2z52v7WsO1uKkmzuzMLtbtStChissMSbkmji1PixP76/3tp3/GeEYtajAVEr6FXdoSrbRmCKXqJYlpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MjxuIIQVLdlZJGM+0A2XGPEGes8vAEiIcV/lvp2a8Q=;
 b=D34rd7wy97GvCrBYfDsIDKf89nWTlD378L86ah/gM1FsnmvNybyJzXvwzhmtrOINeCCff/lSoNIYGcR48hZfyZArmzYf4nlsusDMaQD/yii+itTDYXb1C/f8AYvE4qT9eDH3JfO4XM/HSnTBdBu05oO/2O8XKGk5w3q0qsTzCdKEDDJee14wtnvxqLBd3XPBcJjwwT4C1ptcCRqUxAPrIVEhreGPcOMzx8F/A1mxIDKGQh53zpCB1Eqx3XrL5USWJosC8CB2MKQcSYSFdRBwLBXRkieY6TPGbw4m2k14Oj0vzJQNdTDpa+hE+CzA8uJC6/jFtjSh6ip3TyHTiT5Ffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MjxuIIQVLdlZJGM+0A2XGPEGes8vAEiIcV/lvp2a8Q=;
 b=Y39lZHYGlmx97VZavPtkC5U9mRS3rKyswDwSh7y0j57wwnDiOibl+XdNOZPyunZ8s+hQ9evVanLYdWKdiulWFQW4O05+Em9SxTIbxwS9M5rdNjgK54oVbQpj7wYju6M/TzwAZeTSeS0KDJEn2UbEgQzzIGdy3ksumalL2/OxMOq4bcZhRAEtmFRe5m6a+3YTi40E4wsRMLvs6sgEnRpWjQi5+AP5TUwPfL4AjxLLYgPdRDlB4suCo71bFHzK/iccqcHB6L3JIXUrHlvtBgj6Zo4/RnzuTLZv4kK7OgxZrHQziQbbPdVUA0jt+/26zEfs64WKeiAx0Wi/9+7CFjX2uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 15:31:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 15:31:08 +0000
Date:   Thu, 9 Mar 2023 11:31:04 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZAn7uC9UweiNdGkJ@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: e8da711e-fbf5-4871-11c4-08db20b34da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHCVw8hARRPgbDRPV84dNLcXlMNOenpiO1WdBrQNGBf/bAQ3zUE3KwPTVWWZyGQHM6ute/QKbG0/GxSXQeKK+4iuRfZCwn08KagXb9kJLhJdj5nzx1inRwGpyylm1CtO6urbX5vixlu6efOQ4QxqwmAQlEEAt0tnTybT4RVzaM0OK5p4A3anCHhF23ze/2C5df7ZVh8g9jyD71ktoHNUQjI4B//6/6+gKxl2r2ZuvJVVmenEwaIvKS1yGTtOydcQggPQOXRWGx6XbPEFH//BjIvXlcNQ8N1g8HTjO6SBvYBcYKFZufkka/5uH3S1yc4ZaPumQHiTKdPIlJy/t7/OFMEqYKBMaYeBwtqphupUrAo8HXJAmFGqhVz5xxaDXKibNcGXFm387NZbvwiYtRFfPYRXhE0rlaYwvdAy4mn/JfMWMTevPegcrPq+ZJbKalPAECDvPxG0FTU905zmTNXoOGGrWV7opo7g1w1zwXKov83+a2k0Ark8bLNvufkOIDUloNnmSBaFr6G2NTIo+PfaEau+tiOGlcPWMu09A0tBBKVsh+htNLCztZ/3cPOi6th1i63WIQ+G34zWGdy7s9Rcg7WYQYmch8DHbl9zJoQcX6+fl9AhnjdnTP9cXsCFfSQYbYDQ2S7CPZG42yoJi10W0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199018)(8936002)(36756003)(7416002)(5660300002)(26005)(6506007)(6512007)(6666004)(38100700002)(186003)(2616005)(86362001)(316002)(41300700001)(66556008)(6916009)(4326008)(66946007)(66476007)(8676002)(6486002)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SIIKWlMIfRedMScPq9eLr3twmvOzEkXeTdtFETbUkscvs6y1d1LGOtxjVCCz?=
 =?us-ascii?Q?gsdvDf5RffxOog1NJMlhik7qMGYeB4XiQvQ67RcQMjGy1NXMFKJh6gK2C/Yt?=
 =?us-ascii?Q?Lhut5/LK+TnkjJ0O5auGmRBqyK3SDVTcSqGnMie+6Yo+n5Mphlg8h5YTMW8r?=
 =?us-ascii?Q?yBkwgI/dyQspTX8F0L1m19+req5tATJgQ+f6bp6UhJC0rqmYm8uxFbbM70+e?=
 =?us-ascii?Q?aTHCN5CjbJPY/bbx8NGhLWw/rs9NbIh0u61Lv0776WIb74//gTFfQgo/aXkv?=
 =?us-ascii?Q?rdRA8+uTEN3f7n/+iQlHLQ3nEyRdaXiPJnQtWT2ZVzQAsk+Tdfln/tLiJug/?=
 =?us-ascii?Q?82+aTrh19snV5Fh4qFyGoerLRs5Sh4ui7A0v1iCMm1Aumn21+0hUpX0w2chr?=
 =?us-ascii?Q?c2lwqh7/C3h53VoEHcbIxit/Apz3TGH1oBDUnAzp9U4f2pF2EasBb8xQNknh?=
 =?us-ascii?Q?dckfrhqgLEOy7Yh/55Wj5NPpMt3Vel2fL2Li7hXTgR3kZGn3T+fgMEAmuSyA?=
 =?us-ascii?Q?QRYeT9jnIUKxdcwhx+uu41P8DPFBCZW5r5gURXvZIlpjaOQXVdKlXW1KUiWr?=
 =?us-ascii?Q?eFWBPbww80SdMGQe5GeFhmela2p5POrgbapBKMnavVZN51Zeqh5jSDlG3D1W?=
 =?us-ascii?Q?8B1ub5l7BTJjXhsV4wYdvXFqUxPt/1TpNBRZzME4Z65kmV9Y8RkmmKRWeeCX?=
 =?us-ascii?Q?cPzdR0USnR1J3UavUwDIaqq/ylFrIXRmawXeKdrK63IihkceZneW5sYOilvu?=
 =?us-ascii?Q?1haR2rqhksSxyWcjh/pJoalp1otNzCW0tGFSdx0sGrqAyKiAbdZXd6herLAF?=
 =?us-ascii?Q?sm82Hq7JlxZCxJpbW00xTJeXmZOCBp18Vwah0CMCMozRohh1FJB15D5H8DIa?=
 =?us-ascii?Q?E5T0lbpd36T4SKV11LAwcjFDgkw0pskS1oaR1vR5Etj9TU4ubCs+T2yMaN3r?=
 =?us-ascii?Q?qWy5CnVR8UGY0aA6vJhpfYpZtUj2xNT+oYNnzfIZPL8zVHIjXC00NGRQKMrT?=
 =?us-ascii?Q?gYNPynUe7Tua8e8dhs73uC2idDV41vNfrcfGS623V1Lu2RSh3GdGJ3Y/stn1?=
 =?us-ascii?Q?1S08pvf6emCrf24wWpPB1lCdGbpLVsNQj3qa4uaIlI8iJsYEA4ZYlgsUcNK/?=
 =?us-ascii?Q?dG2dngHoyDmEw1ty3W2px4LEHE+faBwbX3gjY9EWnpQq0LD6m+75ncNRTDIB?=
 =?us-ascii?Q?aGBbEPn//DZBnEhiYrcm3gGdZyNg2TL44QimGztrjlqx0ZHek2HfeFbaKvB5?=
 =?us-ascii?Q?onm78QDOkigR7IGNG4FDaeZS9DL2lqrtVj+1DZj6ueyriIuTJWn26p4FdEVA?=
 =?us-ascii?Q?loH8eEU9fupDIBAk8qr6GLIz3sztU0ctzTgMQw76rCc0TqqMAHebl2098hTR?=
 =?us-ascii?Q?QtUDB/l4IusJsQo68u5FTC5MCTneoFQrCh7SpWfT4Kv46LIn5zbrs455swiF?=
 =?us-ascii?Q?AgMwJY/AtrTlNxGRfwcWMKOAEt47+8FVxqDbaksfPBmgeYZqsdOM7vnBW8W6?=
 =?us-ascii?Q?SGSpnvhBe+BtEBSI9pWK5twB5CuIhUoqFsdxgkKQD/h7LXWQL6XDaDKiOyj5?=
 =?us-ascii?Q?+PfzrVDJfBLz5vCMqGwPEZjIKTwVBjwWCLmbiIuA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8da711e-fbf5-4871-11c4-08db20b34da9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:31:07.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFrhmflV2oemLtEtzQ3mrYJdf9SN7nu9t8pSlRNjh+jwBRbaC6Xp71h05BH4+Q3j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:49:14PM +0000, Robin Murphy wrote:

> If the design here is that user_data is so deeply driver-specific and
> special to the point that it can't possibly be passed as a type-checked
> union of the known and publicly-visible UAPI types that it is, wouldn't it
> make sense to just encode the whole thing in the expected format and not
> have to make these kinds of niggling little conversions at both ends?

Yes, I suspect the design for ARM should have the input be the entire
actual command work queue entry. There is no reason to burn CPU cycles
in userspace marshalling it to something else and then decode it again
in the kernel. Organize things to point the ioctl directly at the
queue entry, and the kernel can do a single memcpy from guest
controlled pages to kernel memory then parse it?

More broadly, maybe should this be able to process a list of commands?
If the queue has a number of invalidations batching them to the kernel
sure would be nice.

Maybe also for Intel? Kevin?

> Also, perhaps I've overlooked something obvious, but what's the procedure
> for reflecting illegal commands back to userspace? Some of the things we're
> silently ignoring here would be expected to raise CERROR_ILL. Same goes for
> all the other fault events which may occur due to invalid S1 config, come to
> think of it.

Perhaps the ioctl should fail and the userpace viommu should inject
this CERROR_ILL?

But I'm also wondering if we are making a mistake to not just have the
kernel driver to expose a SW work queue in its native format and the
ioctl is only just 'read the queue'. Then it could (asynchronously!)
push back answers, real or emulated, as well, including all error
indications.

I think we got down this synchronous one-ioctl-per-invalidation path
because that was what the original generic stuff wanted to do. Is it
what we really want? Kevin what is your perspective?

Jason
