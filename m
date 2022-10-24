Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5517C60B55E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiJXSWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiJXSVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:21:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3699298207;
        Mon, 24 Oct 2022 10:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKiilMIUvweIFmx1LHpdkCBHE5DOoVrgGD0w8WgR+zmvvuYYrY+X17TI46vT/dDDA0VFx5+s7ujXjBZec/FVcmiDCY2ygBqUpi5am6Cl57I1lfpiWOl5WptwL69YvqhZy8oPR7JhRs+44J0OWgCwLpEFWwvpg6CYj/xm32ke51UDMvxORW2w+pOfS8rhrs81EHKWAGYuB0I1da+WBMzY+rTIwYmyDBUnqhqxwfvJuXTlSlQh2WVsiSoHF6vAuX2UAW7gtnoqLsmJDd977zHb0gAUrb4hsePr26wC6q9/TNjFHb+X37lNewYnGTRn0UfiWOm5HWefH5rojbLtJkyPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGzsgQVpqFtbzIrhAUgcVDQ4VrVjFyukKfnCITCXZRY=;
 b=iaWQKE8HI8P+jjIB1CcYihQ59Kzk92taawPwTxHk8gZTuEwI0iOE6C5s+fiohpDseiC4/8VojGFaIhk4wCTO608P69WAEnvWE3LglV1x+nYgUm1s9Uq+oWoB7ZtNNlXiY/RDpuy2beDPAEfpiNi8UA2v9/5b3oNUPMZWsM7KAaovtev8DGEWaZhdb1kKvopLCLPYcpbzfXVdnOG1k8iPbVTuEMsBatFkspP7pRrwPLyaEkEYOWKC579HO8gZp+3MQtrZD+4MIaquDIRvkc/+4ub/Udo/nN9FVDsfvDGT6BGLfRi0OWqpsBFOMmgofMM6+y43yMYW70YrnOL0s64MKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGzsgQVpqFtbzIrhAUgcVDQ4VrVjFyukKfnCITCXZRY=;
 b=ql8OqaSqlB7J0/D1BtdHRIFO7wNhV+A4aLbTSEEJgbOTRVU6xsijti5xeRdnknT2CO03UPzqhGhKFysXCUK0FNtiEgsHwcb/pHCxKU1XUMEXHt5bMmFUYEXWzMa4TiXHoRIF+geYaoD18EWxNMSgbyguxCG63YUcf8x8gbLsX8gBAr7YwXJTqMBHa2IcoAWt5BS2s+zcDyJ2yjLhznw6LMwJd99rts3CVy9sAR/LrHObhiU07U66UrzeL7NFsAB6UETgD9atQ+kFQ5DvIIak/own/AvvAJQgItIOJGv66gGbxbkPm0RDxx7Sr10aViDZgTCemfKrIs1C1x6TF1kRjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Mon, 24 Oct 2022 16:59:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 16:59:24 +0000
Date:   Mon, 24 Oct 2022 13:59:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] iommu/s390: Implement map_pages()/unmap_pages()
 instead of map()/unmap()
Message-ID: <Y1bEaytSOAoVjtLq@nvidia.com>
References: <20221017124558.1386337-1-schnelle@linux.ibm.com>
 <20221017124558.1386337-7-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017124558.1386337-7-schnelle@linux.ibm.com>
X-ClientProxiedBy: MN2PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:208:238::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ccec39-f554-4746-ebb9-08dab5e11a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89RKvxfGbp+lVPKuj0av9sKjTpaiQv2+wUyS5zIFsqt3tTf+kh1dOl+hz62BWq0ItThkC4ZG0uDfbP0XIeRxdFmPduKtV9XqeyuAw0rPwyoZ/PBuLrrzi5Bo+yBD/CffypgoLI8u+dHXPzor24YESn/Ila9UkbYlw1J0A9GdWIixYKPXAMemaMQICVrg1q6NqObiCxRonkdEKBY7+g5/l5yXVnYSu5AHzSB4r57d0DkcyqhXCYvNNK7g3O1zWeb2rvkHu4AgdbDB9CKHWT/pUqBqZ5Z+DalHYMsy7WZ0b99q3jEUurE0QfBkAcluu7Gafxkk5BxkQ7Zw6z09wj0znAdlDGkIdu25c+1zfjl+VxtPqi3FqPa6Mo+gPt4sU23uRwBPWKZUMHtqpl32LIrHmxsWpTeBMR7b7HJRATv/qM+ZSWiROx7GvXzT1BIWmkHZbXW/JfcvRBAOmUjJU73onwllkCy0KhJaSROQ6pAsWQ4mz06pMdUrURLtn8Skz4TdLq2Y1g8vlS23J2B2vznGIo8GuGIwwBq2pI/4LTkdnRL2miHh5FXrzLbC+lls9jrz8OFy228GlzNqS3IVLHhYiUoLSCK7taXG+woY91mGVMIDfPJPmiWDsqoB3VvAtMzWNpaV3a+yCa4OlDz/PXMWFuxkLcN9WuLvIjx4yZQ0gU1ToqtE8RzJWsyh3uOiSsDqkU9NB+C9MT3se0661yTclQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199015)(5660300002)(7416002)(4744005)(66556008)(316002)(6916009)(54906003)(66946007)(4326008)(26005)(186003)(478600001)(41300700001)(8936002)(8676002)(6512007)(2906002)(66476007)(2616005)(6506007)(6486002)(36756003)(38100700002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?khhI9LYdb19QjX32/Bwkd4zOlYU3wI37MDL5/PNnB7tQJowPhnMde5DD+6Cq?=
 =?us-ascii?Q?frY42LwoGPva0jkZDMNWmkgB8cCZfwUpH49O+a1eYwKbb7kNbpL3jjK3vYkM?=
 =?us-ascii?Q?XrPIlEX5QSrTT4SB5wUgCWfReSiAg6eSiiuyjrLapwtiOB0gihxJSm+seBIi?=
 =?us-ascii?Q?vYwM3BI2SrGsqWz+rDPM0A4Eg5zoGQIg7uRiavAdJGaXyg/bK4Lgr6ol0C0Y?=
 =?us-ascii?Q?j2T0VqVYvlbVEHfb887eMR++QBUM6l7bQRnXTfdMvDUSw6JzNKSGh+Aqjcwa?=
 =?us-ascii?Q?nV1y5r0qfOE/W/m0sHebFI7wSI13qgkLs9LgZyYsIruO3TopBEHzO2AM0/aO?=
 =?us-ascii?Q?56h8LF41AFH/LJhykdX0rBzvyMz/7FPqpM2C3ArPzqfCiapxH7074o2WzQ8o?=
 =?us-ascii?Q?6wtPz2R3iwkDURMPpFKgTcAXbWcYIA2QZkUE0HgLWpTnEkIiWTjmkg/6gS5X?=
 =?us-ascii?Q?NWmjeGPwViZKhgLorCkg//U8btPhQBFj8xDwZfuC7+6NsfiH4dAoOZrRH/fd?=
 =?us-ascii?Q?ViMR9k3O44UmC56rjgvq3v3/PZ22PeL1FqNXbCJpoO9GXD+t6Y3dBmhu86DG?=
 =?us-ascii?Q?BQijYsStCf7b56BT62wWz2tg/I3p82YNtJUT7m/5+aURdkm4zulTVIu2GoXY?=
 =?us-ascii?Q?VssM+PgMMWXfZunmqJxfUl7LamM6/y294HIn0R11FUXr2a7thpUH8+EWA2ui?=
 =?us-ascii?Q?phxE/EfRSP59VvfJbJwp1tS7Cc4V0PsZNKkYzXSKCtmdXwi/bI2meRehOe5V?=
 =?us-ascii?Q?CTOixKFJNIIMdcPqZLspT+f3/pXePn2N142iSW+DjVwEESCP52KBdHMalklZ?=
 =?us-ascii?Q?zpLyfKk4YgX4k2trcrKDXzSE2wHQpMeQ7rpl8uD8NQ74RQcoYk+GzE0InV9g?=
 =?us-ascii?Q?gZpCtvZeOqGv0FhCLpx7eZlyfiB2meWCzIHoxh0wZZ6K9Fh+RqyWZLHearku?=
 =?us-ascii?Q?JCur0MX71MmTXwvJgyY7hD/Yb5IkFms2BtUSIMVibLItuISZPQ3Ukf2jePtd?=
 =?us-ascii?Q?8VvYFEw0TT38eZmqMer6v/CND7fwD0x9SQYttpVb71ub11YNT1ZvOYY882VX?=
 =?us-ascii?Q?zl47enq0djYgfxVRp6aOcQFw3a2vKyNLn9Zv7jhZ1OW59T9HHl2LVbm6rYPE?=
 =?us-ascii?Q?wUuZDjlCPcHhTJbG6hQ6FlqOW1n3ZJb3/Iz9SeLg5Je/K0siryP9KJQL9ZcE?=
 =?us-ascii?Q?vrB8lSOt1e8Ctr/I/dU9Cd36MC+HJltqdEqijApRGnncXVt5iJHSt6lPvLVC?=
 =?us-ascii?Q?tvEOSylszJ5h3FyYfkT9JxcpvdvIKnU2VI5V/R2NfSN6YhvlHN6tb7xPn78t?=
 =?us-ascii?Q?hxfWcmm0vmnxGPfJ92/UCtY/Gn76J3GVCCB9teF28c14Ba5Lxvq1DzTf3bxK?=
 =?us-ascii?Q?7jBkp2qnYiTl2xuhcaH77xhktd+VxjAdw1LCqhvS6zLACaBRnRXfJ5ewB3Uw?=
 =?us-ascii?Q?CSPnumEkJz59K7JRmG19csDvpcT9bKKTyP9Vk6X/sGqVysfVjVy7admsclu2?=
 =?us-ascii?Q?cNJwpPbHou0z6wm8w9ZyAckq+28cFI4JWs0SH4xH7B6YUihRaqD+hdXw89+X?=
 =?us-ascii?Q?/fMsqFYf2JGDK35s8eE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ccec39-f554-4746-ebb9-08dab5e11a93
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 16:59:24.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dS9N6qaQTzHsXnvm/aztOyEmL5sNbJRDa4MO+tXwaLmN+tuXuGQoKsu2ISM4TPSu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:45:58PM +0200, Niklas Schnelle wrote:
> While s390-iommu currently implements the map_page()/unmap_page()
> operations which only map/unmap a single page at a time the internal
> s390_iommu_update_trans() API already supports mapping/unmapping a range
> of pages at once. Take advantage of this by implementing the
> map_pages()/unmap_pages() operations instead thus allowing users of the
> IOMMU drivers to map multiple pages in a single call followed by
> a single I/O TLB flush if needed.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 48 +++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
