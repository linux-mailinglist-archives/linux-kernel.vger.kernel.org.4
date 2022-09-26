Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1725EA9E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiIZPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiIZPM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:12:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF864DF36;
        Mon, 26 Sep 2022 06:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOBaqfHSQFHj31Z1NaYUQvEQS+Z5slb3ZPSuqYUFA8xgJqXMjGhDSNcIUjFipv6+aFno0Y2zsfgiPt6jZjUvVPBmK1FHE/08zESUuOrzMg54nfuJflDXZ2p+q33ECBWRwPznYH0BcESDhpOpgWoKZWyeukxlxp3KaTeQ3c9actJhgGQAOBx3Q3UEITM9cEX5MO0J06zgygRhboQWKVEjo4cZ7sC8Q3k7dDGP12WkpzG2v0P/OdApQ9HSsPFCW1IpGSpx9wyoWqi7yY8ByljHueTjyGlEXCi74KHImZFdAVeYsmZg+YPTwcSZRX7QM0rUKjqyP7f2p45HWgWvWzW7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cPFv+XV0PDapbXTowIrg7vfX/xcfuYIAOAWrW+lOtc=;
 b=X+sO13a3JoK27WBszLCD9175Fom+QrXDyqeVugbxbc/mtOn1ArA5zRyhMn5pBGO2Z8Mg7p6wMfOqSnJsGvvcSn7Clw/UiP0ug/VYW7//ux0n3h1kum380ucg5KmWOqsOQufRlQ0t0GgsubbrwmZUO5ikL1HRbIp4yE+yqfWlP1rIOdI7prw8KN72My7HAZVIjSHpADqdgyPKpHzvwYuML2hqPgPuylGjwtBx/brWoxlM4fx5Ut57vz92k5M7GBS4C3v/ppM7e0B4nh274dqO6tifQwl1zuCHBt1oChB5N4U2slHjt/FyN/nPJLNzymWSzoPBnr48+iNszGnnAX6XJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cPFv+XV0PDapbXTowIrg7vfX/xcfuYIAOAWrW+lOtc=;
 b=KsBVPP9dK1mG3lIytaZ8DwdyPdavl+sVOVX9Vuzdvo0e5sIw3d/pVH2/OjW882fLGpP3eQaS2pudf1FtcCQ1bG7Ma9PNJgTxTvrRGBBUoDkNmYuy7Ea3WY1PyWHXcxZ1pOtgWXfmoBwIcqmKek+oo3R9J8BwFNy6Xf/aAZi05mRDh+rxmijlrbMiUHt/CF6kKbqGmtnasux0ICSufYp9IbsARJgkq39eWD5YRjshZ5w1Pv4qtU0O47K6FLNZH48o8K7EhFrCFPrtOYStELnmCwDzqdz74kk8SexVsWG6dCaLcJ58grT1NzsPMYhHBv5PuO22XVo+U9wVw18UOxsQsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 13:51:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 13:51:48 +0000
Date:   Mon, 26 Sep 2022 10:51:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommu/s390: Fix duplicate domain attachments
Message-ID: <YzGuc7jVSvE2g91T@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
 <20220922095239.2115309-2-schnelle@linux.ibm.com>
 <YyxyMtKXyvgHt3Kp@nvidia.com>
 <b581d4f575b834831f8c17054f73b5b92a891d25.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b581d4f575b834831f8c17054f73b5b92a891d25.camel@linux.ibm.com>
X-ClientProxiedBy: BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 0568330a-6b9b-45a0-4c19-08da9fc641bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4xPyu5av1hLKCQf//TDpiOS5o4oKdEALk3K0nm9sNTC99J0sSO2w7bRILvEFdNd6F0aeVdBfbQrbVDyWNSpAQs7+wkxi+LI2QOJLh+HE1vvudNipKbY6FJUNBFdUNeqKSXOwCXzUFYSARcSrf4eK4i5lMvIYbf5IzRKvVnVlnvyhQKK3f3QlKJS2VLTRffsnGX3bXeeyRtgEzbcHVweaEUFepiFjO7XW+VRhSaHQD2BTYhXruNZ51Tj96MgeDre2pe6q8MGX6y6jLleUR9m3dBohXIipAbACneKvVVzprEPajktrHIr2i4MZJ9bDrvDPk0mi0ZMA/31hoKtQ3lLA4CXSTNV9GrDwPOfo3v9Obtu/ns+DAVnwQrJEbqDQ04Kh9uYlOGN5nwhCahvnw/xLZJVayb3/yydxJjdD6PeoCr5zhJIUttengg4yzOknQw0yZBWPPJ6IyG2iS1CB981W+mV8sfDGTRkBsMfwq5Zj1eGSUyrxYcwrUrF1XOzXIQX8SDyruQhlsGLWSpqTZUiP6y1UmwdvTzputOvjIX4Y+EFYaBmAX+ettqMr6FeQj0zuX0+kh+ypH6Tep2+7axA7s4ngyJgMiDGu7wOECWcKYJ2jMw2E+7xXhWfPuc227tyiM3Ra+hEQ/QZ3EaFMbClL8GiaH1buttzTIm1K5/bEAwqfy6GPz4Nb/8Og9xYQIi1vi2oNrHoY4egdlV/7Mh8uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199015)(83380400001)(86362001)(6506007)(41300700001)(6916009)(186003)(54906003)(316002)(36756003)(8676002)(38100700002)(66946007)(66556008)(66476007)(4326008)(2906002)(6486002)(2616005)(5660300002)(6512007)(478600001)(7416002)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vH1AZV3z8AvuxEYsx0bXllJuQ4LjXySTQg0GkUPu5//0kMTneIpUatZvoJD8?=
 =?us-ascii?Q?2BJNmkGhGasY+jyUBHZ9uY7Kdh8+TgzYZT8Q/ka52ax8WHf84FyK8aj7cRFv?=
 =?us-ascii?Q?LpBDgFtc3Mt+0EVDI2XnlOgGFscJ8Xehhdp51Zd1x2gSqD8WT9RuTlky0BEf?=
 =?us-ascii?Q?xJQyxxHw3TDJOK2hbhnCqyBTXzYlWcGVJh2w2pEqNObLVk//7F5tp/wql88g?=
 =?us-ascii?Q?cqLHQKpqof/CRv0Xu9c6YLX2vdNYM0ozCyQwrKbPyEzKwkJ2K+EgaYOibtf4?=
 =?us-ascii?Q?L8IBqNFgJ+tEhd9Q97h16QQv52Edk723rjOfmbvFT7rpc9e+6Eqd1NTCPn1f?=
 =?us-ascii?Q?inBLbfKRvs9pYFfkWUIw3cn++ghMUm6ek0une1E/CS/6f4+ZShW3PNsNDFVl?=
 =?us-ascii?Q?kBuzaRPfEf4yZ0/uUFJTPxAxvy/SnrIIS7KOribYur6NowjGuPgGF9JbJrDP?=
 =?us-ascii?Q?nqcuY48kvQdeMvtdNz63wegHndFyAHJWOys7H9845ihrIjHBAoU7ccMBilZ0?=
 =?us-ascii?Q?eHB4/niKjKHIVRdZhGF2sdrZUFwBtkAr3eDTpTzHed6iz52yYnRw25LQcHis?=
 =?us-ascii?Q?MuPbwGAX5irjICBc1MfQoCGmFaXBg0ge28o/B7DL1S4WDjllx72AaSwkiWRz?=
 =?us-ascii?Q?h2ww+xtHvTIPVrJMjwRcTM2LQygo8aPgNl4vPO9ZTmAxOFDxRFWljmSJums2?=
 =?us-ascii?Q?o658YbRICLPNpUmgyumuKkljmJ7Td/1G4dVPqhiQn0KY2iJ9Lhx8SfXw6ptV?=
 =?us-ascii?Q?3P5SUUcFA6lDuGZZultD5d8lg0gyFuQ2lZQHOmN1gXZ8uzTlU5hRQxHm57rC?=
 =?us-ascii?Q?zyXdsWXQQroHgQlHT084hRV+bMHrxNOmhDUpZA1/6wgqIY8IUZLeEe8D8uCW?=
 =?us-ascii?Q?wU/QzCA9LdT2/2L+FRfFnLZM1TnOE2SOisSajJjEJq9uvDVElG+go36lqHps?=
 =?us-ascii?Q?G+oHBxtV26ahxNx3DnhSvxZAjMsEWWOzxbIyUqJtoL2JSNock456WbTExjf7?=
 =?us-ascii?Q?tE7gYHI84OcgN+arAAQophL+xUlry1r+LSGfjoylmd/EBBcq5OR9juoNzKKb?=
 =?us-ascii?Q?90MSdH5/WqDOKB86QRz3doB5U/samONFgP31TpzpX5eyfsxiweT6c9Cd+v2T?=
 =?us-ascii?Q?A+On2I52My4iq4roA0bD1Jey/n4ogDA6c1OkNj9JXV1WAxRRsBUPq0mjZpUS?=
 =?us-ascii?Q?a6a95xlMIeH2un3DN+ais9mpD60OT0RKWSxIQprRkK/sNDa1OuFO2CbmWFln?=
 =?us-ascii?Q?hEjreTrdRZcYwEcqRCrPlNcA+Dk+o7PNlMRpBtVq7aXND2dmKpCoNhUIMidB?=
 =?us-ascii?Q?Z1nUuZZsIcK5y1+H5Lu2ViIVM9b8QGPCjC+71E6dPOSHByZitZdHDDACin/3?=
 =?us-ascii?Q?QrQXiaOVoUebyPHm5NhGsPEuEAiESJSk0dEQlqhc1K7j2gN+WDtm3YrvhECB?=
 =?us-ascii?Q?YYSAWwvWIuEfOozArIw4eyTnzDObXc7SGSUOeG6swJxgeUBn2i8/z/Otq+Fa?=
 =?us-ascii?Q?MKBjdgc39Obl9DXHpu4DyBqrT2UU5oSp9J926QcQ7lwam6ByUqqPPF1TLOoS?=
 =?us-ascii?Q?sevrdxWorfyCYO0OIWQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0568330a-6b9b-45a0-4c19-08da9fc641bd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 13:51:48.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp73XPEzWaxZIazAahMaoD87PsfqQxFccjoE2LVDA6h44ar6DdFbwGc/hOa17qps
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:29:49PM +0200, Niklas Schnelle wrote:
> I did miss a problem in my initial answer. While zpci_register_ioat()
> is indeed the actual "attach" operation, it assumes that at that point
> no DMA address translations are registered. In that state DMA is
> blocked of course. With that zpci_register_ioat() needs to come after
> the zpci_unregister_ioat() that is part of __s390_iommu_detach_device()
> and zpci_dma_exit_device(). If we do call those though we fundamentally
> need to restore the previous domain / DMA API state on any subsequent
> failure. If we don't restore we would leave the device detached from
> any domain with DMA blocked. I wonder if this could be an acceptable
> failure state though? It's safe as no DMA is possible and we could get
> out of it with a successful attach.

Is this because of that FW call it does?

It seems like an FW API misdesign to not allow an unfailable change of
translation, if the FW forces an unregister first then there are
always error cases you can't correctly recover from.

IMHO if the FW fails an attach you are just busted, there is no reason
to think it would suddenly accept attaching the old domain just
because it has a different physical address, right?

So make it simple, leave it DMA blocked and throw a WARN_ON..

Talk to your FW people about fixing the API?

Jason
