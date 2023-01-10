Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE656664285
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbjAJN4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbjAJNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:55:40 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ABC921CC;
        Tue, 10 Jan 2023 05:53:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/909idTsQbLckDWKKsok/5PomHtzsmBjE84zJFlrZ9u4QlaGFKVzrauISBtezjQh5057Ev+U21mQIu2X/mW0hOn4ermHHC47hMhq6J1pAyAdvuq14+veFNRkfoToMQ6dWFNhC2fZ3NerOQn2LCY7s1Cahj29eXfbdFoKTYUERTEQFBB+39PxwTOpTKCroQ4t3iCtg+/NZWASR6h1zfqP6EAA3t4Ds8iqyaRKXxEO+sf6cgo6Q1l5Lm9ZpPNSJzkS2JQE4Lc/FEbudBX+lE9L0VLbiS9UTIYTm5pEDQ0vm3m/G8KAIGT1m2o2u4IgjTWn1u+7w+L4oX2ozR8E611Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8EM953M/zgLAt1OaeSXbwzWc4O+1o0A8sKM26V4row=;
 b=nS/nlAH/90fNPhYkmHxVurftxlXffjuCwT61uRIbp2+Nz6hGr0J0xYhSuT24CLBxSPHsOdrJs+Z8Y4nswbOPchUCf97WNyjHeHhctwVjO2pxyB46L8wTT9AusGcII1QO5Q0jIzJSGq0xWSu+s43kw1pFAMlJlc7YkaKxtM2Q6gjT5/uZ/X38C+ZgsU5Iv5YgTM6GgvWF0QrRU0VgcoGf+FwsebKkIDz04Yfc+tmq83Y3Cfe9en9RSbc9A/9BsxpdLUFJ4ybtlPYDMOg1WS/7JWWseprFnQk8xzrKGoQ5DzdcPLD8YsQeFEgmrw6zAUCnnEPYxIsGLy5mYOpwcMEoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8EM953M/zgLAt1OaeSXbwzWc4O+1o0A8sKM26V4row=;
 b=Sn4tqINNKnIPXsjFmpmCqlnytmZ1Vh6HIwgVoWlQkhxrLjAOESlOeHs8FF+5I3bMRms9Ms7qnfxTQ7nU+7Hybhc9/GK+9UPBsS4Xv4rOt8L82sS8qgytN8K0dTbMQYV3bKxZZMUjRpO04OLl4KoQNbsnMoNLnKPBMC0L5/HwzF1uzKCM6XE1FsDYlGLCqUWrBLXLVRe7s+flBgwsr6Ps5+bkuyDDQrbr1egs8CrWePKD7iM2Tx9OTCybiISrdpWVyeuOzTI/7EqKyH4wMQyzyztFmVc40L+Gr1MLNHgB3QJGEwB+LwebVmWWOPLPM6d7DPp8qk/wLpACsvFDoVmLjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:431::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 13:53:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 13:53:36 +0000
Date:   Tue, 10 Jan 2023 09:53:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org, axboe@kernel.dk,
        logang@deltatee.com, hch@lst.de, alex.williamson@redhat.com,
        leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH] lib/scatterlist: Fix to calculate the last_pg properly
Message-ID: <Y71t3yyFvdLXM+qd@nvidia.com>
References: <20230109144701.83021-1-yishaih@nvidia.com>
 <Y7zyyTxdoJulq7OD@casper.infradead.org>
 <a1f3b6ad-7173-70c7-4361-d01f9af1b7d6@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f3b6ad-7173-70c7-4361-d01f9af1b7d6@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a4e4fa-34be-48b1-80b3-08daf31211ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgWz9+xfz9Abo9Dp0ub6X10ytJWKf5SS6XP4tIIjzPUHPcJ/GOeouQTbZmGGAqTLWhNgDovP/9GWJTSEdTRGvi83LgQ9djxK3dXwlAVrrjVXS2DMHWdY03EjDqnUdY9JkD5gxGbSJ0B16zjIaUVG3DxVtoc0XP4X1C6DoW0xLxW7bcs/QrxrMpAz7H5G+rNUKQ6JxcSAdlVdri6z8/8cpgclQtgkqlr/JeU+olUq5PzhgCi9KnfoNXAFR9OGli+UdawcHCnCxrLlgtM24zKlftprhO9eLouBWLg6dU6iI6b0/lELZAs65oa7FUcsl5Wq2KKs2+SzQVOi1XXoHqJbJGNL944nv/8h5edqr8gND63r2R5OfD6V20R9Px+EdMfj3O8graYIzWR82lohjYeveMOdQMeBjlr65dc37GhtqYatWtw3j9BrnDmfMzxfQBUHOyvubIuXgdrG6bfewhBWibXNIU9LocHs1HKHDjeRtDUPu2DPwXijXdgoV42/iQHtQr37E2XJmwlowT4JrMKNf2RH6gHPc8c2obvZkyj4weDLXU0/TIViDtRm4Akph4mMZzo9a11X3piImEjYEkT24Vwe8vF2ctaj4uVgTW6OcmOZwYhRrtfUWA3e4+RDpxJz5WQwQArrS7PrrCLNJXFul5WJInv7mF2x8/ZauPqRiYbxjx0DbOEFG3OHg08OLJCQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(4744005)(316002)(5660300002)(26005)(6512007)(186003)(478600001)(6486002)(2616005)(41300700001)(66946007)(6636002)(4326008)(66556008)(66476007)(8676002)(6862004)(8936002)(86362001)(37006003)(36756003)(107886003)(53546011)(6506007)(38100700002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g910uR3fUeLqeOUgKfr9YNuz24o4DyivjBhP9COWGrGCOZQI9RxYWkY/Cy/2?=
 =?us-ascii?Q?AH8moHYdzToXcOqPb22nBBuVqIVLHpUs++v6MliXuDXltnCr2E8MhUhIUMRA?=
 =?us-ascii?Q?LvnXsc8ANAAl2WwXpa0JwKaapzVI74TXDNkx2a71lYIpw7mOJz0fNNlkPZyO?=
 =?us-ascii?Q?BmbszyKJ/+sn1LhmULqNesBdzSZ0mAI6H0mJHy4ahhFa3TqVCeJfsA+dRM6m?=
 =?us-ascii?Q?59BXfDu4UDA05IJf6gnqV9L4k2Gm2QOQqcbsuo667i6qq5ejLsV+nGk8pz1f?=
 =?us-ascii?Q?UNV+JGtES310cqKNT/2nRFcGbyT6JbcowY/ttNus7WB1gQvsk/9pVvONsJmh?=
 =?us-ascii?Q?LW318tzEc2mIxHn8lDcg+VkeeE7lGeH4mVv8ksp6PDI9Y/VnD3q02XFlQIgq?=
 =?us-ascii?Q?hl9UILuChNIe54Hb4/Li5oHoQxORMUGYwfyQVnRdvW68D8uEavVlrnVKuTHn?=
 =?us-ascii?Q?F/WJjdUneEEhCmvC2VzQmdwEws+H/zAN3isGae1pyyLQljWuy0W5zI9HqgpU?=
 =?us-ascii?Q?7xHH/WnHE2cTQpwveS0eP6XmAagxWoFQ/uLvAAvdooebB9TzosCPcF7hHAiI?=
 =?us-ascii?Q?SQn86K6NMQsEFRREvNK8LrBeF5c8jwsoAh1xq2X54RxDrBM/qCXV/HCfkD9s?=
 =?us-ascii?Q?lkpI7gmR/Mjyzjx3L0hxJE3j9o0h3X7KuWBAXHtwG4Rnlx8zE5NDYQ2YLMx3?=
 =?us-ascii?Q?k7NOD1pkUoycsBPrcAtLVqfBTEmXL+gTX1rlg6aCVVdTf8kPc4/B1ULcBEQQ?=
 =?us-ascii?Q?1EEATZbkm4DTH4KDdZaoa9zzrFtmcEO5nD7MWrAugnwfHZgjMJjk29pL39ZK?=
 =?us-ascii?Q?hYFqKDxPj0BXiwZaSDqHSa6g+TJ0UdaTvC0WTp0CyVdUZ6hc7e6vIxkHv5KX?=
 =?us-ascii?Q?zRgYIVlK8xMBWravYTnp/9BMx0kq8TSMyNkjb6yk2WU9pOZH8idgSDG7cR5l?=
 =?us-ascii?Q?sb1GYA17eypz3Bwm/FO1n/D14ouE4Jg7yJiMVwx7J6lQN+rNkJowk2HCIOxn?=
 =?us-ascii?Q?3DX35ipBxnpRud+5A5gDx60Ws70iJ8GKJk50iS3K7etKmgPiW6U0YRkYMvmd?=
 =?us-ascii?Q?3n9e/+3B0GxR9K/isfYxP1BDsj9Mzn/rTQDxgXOZp18sMQqCqIoSSDVKWIn6?=
 =?us-ascii?Q?0UFKAvYMZ3ShS1jUfJ4ePllhTAZqgemFOOg6sjJGrRXhCBxIDOjLR1zBevRn?=
 =?us-ascii?Q?dSa6oI/Qkr4/IQcA64xN3F6tonl7EydzmpBxlnCTZfM4YDyd5TJAiwsEdSrh?=
 =?us-ascii?Q?nOLVKrPtzkWpyYghzL6WeeufFEaYFVJTHd3lHtEHTtmpfPgE30a8sILpkufg?=
 =?us-ascii?Q?EIwc5kgyf7Vwf6vAfy43P4N82MfA08aJyORXEorU3FX2xfyJ++YJeDXf7s7Z?=
 =?us-ascii?Q?vMazM482/j40zDUgwVEiXktH/S+N350rIWfe5J8ajVtV5+m4yclkCveYdEhU?=
 =?us-ascii?Q?DI7X0ecC3OVz+AnS4EdQQLwzjhrMBh0+FjHC4PacVx9slTt+1bQbn1WOaFWw?=
 =?us-ascii?Q?lZypiDWpG1osE0CDF6Gm7ANkyUOwbnxhpPoMl+qorxxAAT1xGlym4NYqqB38?=
 =?us-ascii?Q?5NfAhjpexUCSU2aBbRM7l3qWzC3W9f/7w38kPjb4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a4e4fa-34be-48b1-80b3-08daf31211ef
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 13:53:36.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiUgJ3V2ua0y6vGLQo+i1AyiI17w/7ihzny5OTNBBrb0uyinUd2WqzRammqgO+MB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:01:53AM +0200, Yishai Hadas wrote:
> On 10/01/2023 7:08, Matthew Wilcox wrote:
> > On Mon, Jan 09, 2023 at 04:47:01PM +0200, Yishai Hadas wrote:
> > >   	if (sgt_append->prv) {
> > > +		unsigned long paddr =
> > > +			(page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +
> > 1. page_to_pfn() * PAGE_SIZE is spelled page_to_phys()
> > 
> > 2. physical addresses have type phys_addr_t.  Oh, wait, paddr isn't a
> > physical address, it's a pfn because you divide by PAGE_SIZE at the end.
> > But you will get truncation on 32-bit, because page_to_pfn() has type
> > unsigned long.  Anyway, this shouldn't be called paddr.  Maybe last_pfn
> > or something?
> > 
> > > +			 sgt_append->prv->offset + sgt_append->prv->length) /
> > > +			PAGE_SIZE;
> 
> In this area of the patch I just reverted to what we had in 6.1 [1] where we
> were good.
> 
> I can send V1 and replace the 'paddr' to be called 'last_pfn' if it's really
> needed.

Please change it as Matthew describes so it is clearer

Jason
