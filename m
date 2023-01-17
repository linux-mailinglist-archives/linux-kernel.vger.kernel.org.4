Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8914166E79C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjAQUTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbjAQUPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:15:04 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F048037F0F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:10:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTDrQj45JC6fevvd/2wfrDWXqkUT2H5oYUwPOChP/JG8F3HvBvaG8/QZCj5ZT556SDI002/lFEtT/xzVTPtZm19RlMrNSLHw5HTbntkGEAXY+g7PwLAQz1kx8mSx4XDaQeSPKaQJu/cFAnar3puuZVr+JOtqj6IfLX/Bef9gcbkQm7JZGcNEmhyQVeWAj6SUvNRK98YyEqmCVBt2ZFY6raOi+RZ77SuT/oMsb/IOJ+Rr4Q2F1H5qhdEhiVVLQ1WomMdP1ML8pPx7dpjo4+G23xJ4tXQXuDBpT8TC9eLhGVQHGCxOM7eaP+d+t2tQZbD9Vy5wUjJTYmrri+W3GxaPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t61S3nHl2KpF2HIAnVn5wMdgRRfoE2mq5Ue8KCTro1I=;
 b=a7n2yHgdfol0fW+5YQ/hmjMhnha/Dc2o+NQzTwe5WbZK0yO7m43Ey7CYw6BAgk1y95xJyUwz/5r6F/5QLFW3taLpK43Hs+KX8PYSo/BK+2JR14mv6h3+1GBJpZuzvJxzHkuXyQ8nIv06wsTDFzi8QdRGsLaFWhrnrXJHX55+I3G/+BLxnsHPuOFBdtSdJ0KOfVIN0J40Hg4+1DWDX5vK93Dh4iMgKoeU4yK0j9oMm/2l4Yu4HlaTSFVfF7LUtx5/PLfZxuJGkAqFzLZG2ICikfzvK42mcLRmPoj/E9HEQb/qs8XKvJMxGg7XBfO2TjfQtjRTJQI4lf8JaSZl0tVdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t61S3nHl2KpF2HIAnVn5wMdgRRfoE2mq5Ue8KCTro1I=;
 b=lss/TINGUHSs938PXzxaEQvRXcUImaVJSdDxJHYzPn5W55u6b2GiTT2OkEu6JbKtMF1u325Te6Wg4fNqqTEUOSBKiwOG8QUVq32ii+ZznHv9Bpr7dOiE2GPJqwmdP2E01BvfkWhl7NVdjNPMO+65i3WmcLoDQvofDTN1n38yor39P6ESVGIjnkEXECILrVcic3dGRUiLmgrEMvwoQTaTRnP6IpMMSGo4m3S6a6R+Ero5UiZqHPuD0n0MBdlDVXCuvWIcJFDxnHShwstqBqwjUeVPTtxHE6idracg75NVvEcc6W6NFWLy89XxdERMIDyWdmNrnyTLHflgWxBqZewlEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 19:10:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 19:10:13 +0000
Date:   Tue, 17 Jan 2023 15:10:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Tian <kevin.tian@intel.com>, Kalle Valo <kvalo@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Omri Barazi <obarazi@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] genirq/msi: Free the fwnode created by
 msi_create_device_irq_domain()
Message-ID: <Y8bylBgnnmzaokaI@nvidia.com>
References: <0-v1-9195b42af947+89-msi_leak_jgg@nvidia.com>
 <87fsc9knog.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsc9knog.ffs@tglx>
X-ClientProxiedBy: MN2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:208:239::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: a379f51f-df4c-4afe-73c0-08daf8be75c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7C9+m4+d9rshXtR62Oxe9WStXuckdvR5mm/mTn/+T5O/QZObSwn6oP7v2zQdJCs/WJxRT0eRpa62N0L6CwJxwXZ0OC1WVKRf21AE5quxZsw2MRr/hv4dp15rOAUuf4SOnD+T5VFbKV6sjzf2HV34IaUoREEOlXUYd5ygDq+li9LY4wZOQuDGer3QB/Y5OfpLOza4UF5wX4Z1gDTtes3icnKfE1vqNtAXgoRjLB0Q/9uvlM/Zlole2UodVLKWIaWlMgANKkIPbi2vyd5rfkJ60ovN/ehLLJlJMuqNHlHHp5SvL2wCet98kdh8uHQtGNpcZNUN8+Sk9g5fWdgdlS8rX5lK6K7T/ReW4Bo8MeDSyY+XplIr1p8c6LVy6DNoefnQT95Kt4iZ2Tf9Lth3jKCyNW4E07JTYfXMGPRWEPH52rhTmbE5cU1RIxGJlu6VMzvVx+0gYuYJzGI5fc1wini0Siag7A1VqwY7IBAt1vhnySJxE3yNV2fKFqacAGyg6s5ffmBAvTZ53tJyaQInwshpWF1C5k2g27v9X6QkWFraG7Ov/TooB0HD0Y7LpzS/RYviDkXxfSqRz7sA0I7Y5dkvFQTcsHRYX4vHq7JJOOJdh/jh59feoFi36N3c1GgHEYJjIuRx0YldXHEE0+uqmawsrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(8676002)(6916009)(4326008)(66556008)(66946007)(66476007)(8936002)(5660300002)(4744005)(38100700002)(2906002)(478600001)(6486002)(316002)(54906003)(41300700001)(2616005)(26005)(6512007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ioo9cOCKAor+JmN905lQTv972NOafycMT3Bpb8BY3kgNQHnQK6RKcT835q66?=
 =?us-ascii?Q?atQ+69VptcR1BgQigA58743J54KvdwNyWVndoT/B9UmDh9ehEx1a22ZbtenP?=
 =?us-ascii?Q?eCcB3uvEZABVFkFncSup8ZZy+9KsEWKexK1d+SsIHqfWNnr3r32A+i/SqP0G?=
 =?us-ascii?Q?QgB+sL5CbBdbIm0xcIikPOlCSOYIfgilEiBxW1mNyHPU/7wNYzk6HqVh4lw9?=
 =?us-ascii?Q?x4fE+43syN3UeMi3E+4AwBj64HeOCO48MV/R9d2fj63F3psi535YnD1Aka0Z?=
 =?us-ascii?Q?lfdjBHgA7yG2lUXtcCQFOSA+sCJcmAJYrR48unYBzsvgQod1hvjdGwy8i3U2?=
 =?us-ascii?Q?W/rBvrGsGfBi7CqLLJVCRc8kHJuYyF6wyb6H3CkjAwuRc+BA2nHMvqbSod2K?=
 =?us-ascii?Q?g1SD0+bMiELcbgptc8NyKnnyE4tJXB4vTMGqUCzdgVFeI+Z7jxoZbPgyuGD0?=
 =?us-ascii?Q?OC91l5XTQo9kp+VdM4Rji3a9tldDERtqb3e8OBXGctYrcoOiWVBPSIJ6LXFZ?=
 =?us-ascii?Q?EqQMLJHjQqTzdBM5zxbrb/owWkNXBqMho9L02fUnwJWb3EecP2S87kKtnnEv?=
 =?us-ascii?Q?HMt5Pa846XaHO7cWxqJypVKsLlFSzGfspgSB4+giZhcT0SFyFKHxzKN6GN4x?=
 =?us-ascii?Q?/tTe+NfgWx5jhRP7uxHoecKJDK9+d8zKDSi+WoG8bax5gpRMZAdlBNe0bNuH?=
 =?us-ascii?Q?2CYjpH8ndSY2ie9tkAQAotJfeDF6UXy+Zqi31w3Kg1a37RhJXwJSjxJPTKLe?=
 =?us-ascii?Q?KDo0nV12yjCyblfcr2KG4XIwoSSvaRVAXLPK+T5L9iTfJG1xkxCg5BpQPDCm?=
 =?us-ascii?Q?WfZfLBygGWrweiOCvyFxag/weWv1TVRt9S5FRgXfS2n/J7G1tRg+jypEX6Yj?=
 =?us-ascii?Q?74jYcbN/C2H4UUXaIcRil3zXgZIzwtfhezvi+I8bfNm/unXMB8gAuG+Zon07?=
 =?us-ascii?Q?r6YAlXQwifz5X3JNYnnArpmaDNPEoM/5b8yuXjx2+llXt2uiG+GGV+LQoPyG?=
 =?us-ascii?Q?t51NmwkcVVLrzBFC3dbeoPXvrx6hIUi397jEI0Bre/UhWkAsYu0+MYFqWMPe?=
 =?us-ascii?Q?UZzr+94+6mNSYZBOHPDXeOCxVMAPBeUM1XPy8pNJAfLTH5AJwJN7lkqPmRJ6?=
 =?us-ascii?Q?vOEA+60Piuzinjp6uJ0jDyaL/rFawbz4k3TaLit2o/dp1pycdw/hWpjrpCGB?=
 =?us-ascii?Q?AmItn7cFt6JIm4L8bLL6RdaZfPSqPQN1DUYg18qwOvhkxEwvVga8LlyKuLQV?=
 =?us-ascii?Q?rSoKwWPeaml/bhspPx3DDW3tIVb/CLq5DQPZdhSnPTAxr5zCUGQmZxNXDJUm?=
 =?us-ascii?Q?HsZugEjenuCJrAEC9XCAmlYzQd+qzDuMyIL+MJMEZ4LdNcgLmfsaLDWeJOG4?=
 =?us-ascii?Q?PcQL4FvElhncnfZGuPQYxByItx33fWazM012CGS7Xuvtp5mdXEF+8F/208Pm?=
 =?us-ascii?Q?oZ0debHWN1L3gcFsc5WiyG4uwXTA5Aq7DxkgimuewYDPYJJ5BStq0yDJcrfF?=
 =?us-ascii?Q?HyyQjTDHEHSNso8K/55Z+Ern/i8F8O0uXJedokiTOSNjeZx7mvOB8+z1lXrf?=
 =?us-ascii?Q?TEBmUDmu3L28HugwKswauOf1sftzugkuijkz46Sb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a379f51f-df4c-4afe-73c0-08daf8be75c4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 19:10:13.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2dsQcE3wwlNry2POwXhS8BmkeKCf93ddZeiRhhxi8rHsrD1OZKMMU6kqFV8cpKz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:42:39PM +0100, Thomas Gleixner wrote:
> Jason!
> 
> On Tue, Jan 17 2023 at 11:27, Jason Gunthorpe wrote:
> >  void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
> >  {
> > +	struct fwnode_handle *fwnode = NULL;
> >  	struct msi_domain_info *info;
> >  	struct irq_domain *domain;
> >  
> > @@ -1025,7 +1026,10 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
> >  
> >  	dev->msi.data->__domains[domid].domain = NULL;
> >  	info = domain->host_data;
> > +	if (irq_domain_is_msi_device(domain))
> > +		fwnode = domain->fwnode;
> >  	irq_domain_remove(domain);
> > +	irq_domain_free_fwnode(fwnode);
> 
> This can't work with !device domains because then fwnode is NULL and
> irq_domain_free_fwnode() will trip over its feet.

Uhh for some reason I thought I checked that. I'll send a v2

Thanks,
Jason
