Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132495C0230
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiIUPtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiIUPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:48:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F569DB4D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk82IntGd0a3wYRhgjvoRwiZz3c3uVvG6shHizlNEeu4tQaX31iK91F/qlEYG3n4pbEttD7PmBjWmEcslC1GJvmRNPqyIxY8neHOUEFE7MJrCefCUunvuf7ZrRAx6NNYdAbr2PcCBfVlpFBDXhpCPmboFmFOiQVocCH0H+CsMH1eEM3uDCTUb+iaO9IBxwyCh33Vn+lo7t5+lCC7OdiduG5Hwp2wzUfvGj09K7EJ5dg5TcF8sYpg/A5WviFFTJiKIt+QFILC5igkL1lu2Yj6f0SenutHUAT5mhxgEyY8k02bm5Rb+/dxe+HFeHb2zePjjdSylYyJUYSyu5GLpnJ2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OB3r6j4LVYR/79F1YVqxSD8CjlfnBY/M0V2Dc+uP3xY=;
 b=i/7/bz4u9DzXP0UmheIUhXsM7ySPO7xmy78y3HvB7Ytt7Z6u0pOSGtX9QFRIYiT8bJmMWYJqI26fwwIdGccDjL0vNn0YQg9zjvA+sbjfvO1OlQYzlfQcfNnvCAIMEp9jTyOgbbC3eeodmrLSg3Mjdz3Png7UDPMgJRoo7iR5BbYDl4Ukc3lrJynxrxxaL5fVYZthliNbtWsdmOoqCrCzPCW1e7yQRwZqYfTnfBJp9s3vEKizT+ay+cS37e4Ypo4uV7AiOz7hZT06BOzbV/j84p4A97Lfa1lrdv7oKgn0DMV1zr6AJm0rtgFUKn84YFIfq+CswfTtAN0Jmd7hPmekXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OB3r6j4LVYR/79F1YVqxSD8CjlfnBY/M0V2Dc+uP3xY=;
 b=XzMreTTzxUd0T+ZUviwQ2hfux+EjF0WpnDsBGbLJYlAMMl5zrNHi8fbm5YDdmJvwq4h8zRLo1n2IDVS60nSHTv5ziuC7m7bBpq10w8l0sGwSLIV97BYgJenrN+Jl/vq1/m/RM9otb9M2rAtNaNxXBn1HA6wPGE3+liuUFH2gz3pYs9pzSG9QIuMUC9b0iu4IiOUO+uEQafciq7rHsWcscctq4dY+1Sk3q0CuCKyYgKCgdYiqSNJgs2yEN2G5LRGTnqDfQ9Gm0LxbrBDM+I4aYvUt9P8y1OlqofF9aAqxoNKxE9LdzwgAAFnEtAvVGSoTsjub5ZYK29Q7GugjrUuVkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.18; Wed, 21 Sep 2022 15:47:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6%6]) with mapi id 15.20.5612.022; Wed, 21 Sep 2022
 15:47:40 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
Date:   Wed, 21 Sep 2022 11:47:38 -0400
X-Mailer: MailMate (1.14r5916)
Message-ID: <FE41BDA8-F7EC-4FBC-9647-A5A835CDECB0@nvidia.com>
In-Reply-To: <20220921060616.73086-1-ying.huang@intel.com>
References: <20220921060616.73086-1-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C9FFADBF-8EFC-4DE7-A31D-AB6E399BBCF2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: aefdbc25-7af4-4551-f1ae-08da9be89d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrYlNKFC1L/mU4687v8ei/rtjd5MbveLyH5rs4JQVG+9lpYfTzEq+tBwpjhqp8Ynb1zOX642llrakA8syErB5u3IZkCU00hMFZ0e7EoQxWrmXn4AWUNce6szI171ZFCD5Op6vZZvZEiS5aRD6wIfCqKOKbj2MRAjc6im9ljYMlF89CF7v0G4XOW6cMID7wFJ1W7WHtoMxsFDIvI4wN4IOKKQLnvz40qLXyJb5/ne2MkCN5o7bDJTYU62q/KHqPB9gVy5V3Zu9NE1w2KP7yeO6URg4lpx+7LtIbXffnHSHilKcVMTM1QAlL11nI5mfFEjajhnWBxszNXE8OloV1SvbHfPGxNb7WliYGvPflaOfJfK9YIhlJuiKniHNbVf5V1+Yb8Efxix66tG6FWzo3CVBQs1n50K0X4wuy2M0mu/Qm8L0ulZjIkGisVjRl7KEGsS2+7zCrocbsOJeAWm/ziXYsgOX4oKBfFuiw6x9CwJjllPmFa+WSjlEhS4Z2XwVq+qhs8pL2xWJDrzxrK3WQFOsrwMfoyJf3oE6BZ6FRYMorCFUZXD3L7e07D0BH5U/nNFLzWD8GYbiyOh4TDAuJ2xn5cFom8ztIEnXpee8jg3h+/ufRCi8rEAX/e7k2GK1rdZ2CcruABN/7AfaMcEqA+uGtoaJmPOvbI3eMzFZQQNGksOYMw5oohbmuLK+4lHHXp8f/C3OX5cJRle2GCJsRSSusQ3IX8qU5yXUiTJ7rbBSuBosv9HMnyCXoSBpGl3US3fxnqxMMAp1ernJLU1ZkkmmwAwh9ansmLhZ5CbDerA/GCoBdOSze7TvVM7ROB58aju8/5RLw/XXAB1ooBOTsTMJ7pafI5p/eWvYUukVlm4sNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(66899012)(36756003)(966005)(6486002)(478600001)(33656002)(316002)(186003)(38100700002)(83380400001)(2616005)(5660300002)(6916009)(26005)(41300700001)(2906002)(6512007)(54906003)(6506007)(8936002)(53546011)(235185007)(86362001)(66556008)(66946007)(66476007)(4326008)(8676002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R6KVAScT5642AiOtyhLQcCrJ/cUa42khj7Uyjt7u4HG3C6KtYCJUj+jT3dHX?=
 =?us-ascii?Q?ZsQZdTUZ6oEqcDp9a/OrdxjDsYp3ZwJ5GSWb3i5r7wc9XMyUts/jUYd7YYK7?=
 =?us-ascii?Q?I4Lnrdia+4VJVRDI33DC+Af4tYsCemXs6KutfwcyrAYM7kflJv027fHRT1Ed?=
 =?us-ascii?Q?o6J2FDnCx6uu77xWIcNMuo2iqyMJ5y/AHseH7FIM1WGC8IeyvD6ItMiaaJi5?=
 =?us-ascii?Q?8cRM3zv2Nz7AWk0E7qi4gg+I56mMeWqhdiWjWZircAQ9W4VRdRFWMrDewhO/?=
 =?us-ascii?Q?oz5FZJ+Fnc6RIBjzacYZfPVxSQlylnDfOk+3Ec7qGNHokDJu3icM/vejF/Hs?=
 =?us-ascii?Q?7sHKdHnF3IWJFq5pWmd9X7C/bxhMhS/r6I8QS2QVfS1vk2AADX0hJxpWIwV7?=
 =?us-ascii?Q?3uO7rITsPALBNg2JPnQCsSX6BrN9Wrk5stCnqWrmfAB2sgIgrfTQ25CfgoDB?=
 =?us-ascii?Q?6cKbqjNScyCz3sYfrV+Vt54NH9Zt02qpYe9NvlOZhiqlOGvt6VhNJgR5HLj6?=
 =?us-ascii?Q?EH8hALRFV5qxs5+QID7tPorSDUfjsQRIRhITlVsSAqpluWygU49Cp3/QzOQB?=
 =?us-ascii?Q?fOwGHJ2j7Idc2C0wtyas6bo45wix5JOjgo899kQCghleRSmx9cTpEU176umP?=
 =?us-ascii?Q?Kv8n8PAqfVCYvqjm8ERxF3mplFDROQjh26NxFmlpiAkc/p6jcz9CpCGz7qel?=
 =?us-ascii?Q?M4ty+4ogEMmvO7fBUk9BT3krFA+06XVuuOBOaye9sMpi7rJ1gMgynw3zYpBB?=
 =?us-ascii?Q?SOElGNVGNn0Bd1REVoLc0LtJIUzamTr2DKlNoc1yRieqaVCo+SqOPc9V6iPk?=
 =?us-ascii?Q?EzKORxvhaUy3Cmm0rD6VbWozEjkEqIPpf5r0Zos9a0eiLeLDujxwGspOjZwg?=
 =?us-ascii?Q?xRPTEm6S6DhHtFivsW04yJJKUpmVlgd95f+/suRPIUL3bfqMBE1ubS3Q6xhC?=
 =?us-ascii?Q?qXpEgyoeqe5h767vduD+KtvdpTUdl2t6CDqVgJCb748KbZup18u9vyrNXFk1?=
 =?us-ascii?Q?d6EKvqaR04ITnC4JtuzfUq28eOKqOwyEAGboxW42BN0DE3TDPluaTvbZPJsw?=
 =?us-ascii?Q?+lGDGehJOXV1/IH5ltiNze+2nLMc92mYdJzcsN+mlpU60xgowWI+engLJJaU?=
 =?us-ascii?Q?syVFHgYgDzvcvN5lnGPD1Vx3S4DedFpMhDhgpZv/KkCGTm72tJjXO4S5i1tn?=
 =?us-ascii?Q?IoZN45HfFGjXsLtbJ0Zlo273XQzMVX4nIDB4cc0NEe1ZC3P6wl+4dnSDkx5E?=
 =?us-ascii?Q?C3Vodlf11DBWt5Mfc3vARY8xXgfENlbJULp5pNYlZMScRBWujY4W79RQvF89?=
 =?us-ascii?Q?4gg63BOUYz0GcQhw6exLqVGPHTaZ6riCzmSXFp0BvQ5o6RotujtMG0AsGA9n?=
 =?us-ascii?Q?QNAoH2+eMgJYQKxoJAeewdnh8li3RWESiXrriGQRtet8+0RvZ7T81zkf8WGa?=
 =?us-ascii?Q?cHzfF8yJeDg9adZXhPlxCk3pAkRLVYhof32l43cb1gzJFjoHiRabW7tHJjQT?=
 =?us-ascii?Q?h0tSCUxqWQyd9b7rYg0mVHkI75Xy7n9aGWAzxSERzFXYNPJZ4lP48skI634K?=
 =?us-ascii?Q?1Y1WK83J89983szcuULpmlCRuqg41j32smeADuoR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefdbc25-7af4-4551-f1ae-08da9be89d8d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 15:47:40.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+WbahUCEXCoQPW91fBssbn98r/dHeRDY54OjXj88FuTataK6eIDn4Y+tZjRKlzQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C9FFADBF-8EFC-4DE7-A31D-AB6E399BBCF2_=
Content-Type: text/plain

On 21 Sep 2022, at 2:06, Huang Ying wrote:

> From: "Huang, Ying" <ying.huang@intel.com>
>
> Now, migrate_pages() migrate pages one by one, like the fake code as
> follows,
>
>   for each page
>     unmap
>     flush TLB
>     copy
>     restore map
>
> If multiple pages are passed to migrate_pages(), there are
> opportunities to batch the TLB flushing and copying.  That is, we can
> change the code to something as follows,
>
>   for each page
>     unmap
>   for each page
>     flush TLB
>   for each page
>     copy
>   for each page
>     restore map
>
> The total number of TLB flushing IPI can be reduced considerably.  And
> we may use some hardware accelerator such as DSA to accelerate the
> page copying.
>
> So in this patch, we refactor the migrate_pages() implementation and
> implement the TLB flushing batching.  Base on this, hardware
> accelerated page copying can be implemented.
>
> If too many pages are passed to migrate_pages(), in the naive batched
> implementation, we may unmap too many pages at the same time.  The
> possibility for a task to wait for the migrated pages to be mapped
> again increases.  So the latency may be hurt.  To deal with this
> issue, the max number of pages be unmapped in batch is restricted to
> no more than HPAGE_PMD_NR.  That is, the influence is at the same
> level of THP migration.
>
> We use the following test to measure the performance impact of the
> patchset,
>
> On a 2-socket Intel server,
>
>  - Run pmbench memory accessing benchmark
>
>  - Run `migratepages` to migrate pages of pmbench between node 0 and
>    node 1 back and forth.
>
> With the patch, the TLB flushing IPI reduces 99.1% during the test and
> the number of pages migrated successfully per second increases 291.7%.

Thank you for the patchset. Batching page migration will definitely
improve its throughput from my past experiments[1] and starting with
TLB flushing is a good first step.

BTW, what is the rationality behind the increased page migration
success rate per second?

>
> This patchset is based on v6.0-rc5 and the following patchset,
>
> [PATCH -V3 0/8] migrate_pages(): fix several bugs in error path
> https://lore.kernel.org/lkml/20220817081408.513338-1-ying.huang@intel.com/
>
> The migrate_pages() related code is converting to folio now. So this
> patchset cannot apply recent akpm/mm-unstable branch.  This patchset
> is used to check the basic idea.  If it is OK, I will rebase the
> patchset on top of folio changes.
>
> Best Regards,
> Huang, Ying


[1] https://lwn.net/Articles/784925/

--
Best Regards,
Yan, Zi

--=_MailMate_C9FFADBF-8EFC-4DE7-A31D-AB6E399BBCF2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmMrMhoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUUw4QAJEbxS/3LSVolG9jaL2qk6/s3NeJYx08U4pE
tjoywjt2RAnE/ZV6MlQn3XRnn4rbDKkFNGBIh6wRXa+wX6OPmOLOZPcdjHSoV4xA
flVLCddYPOTLr1xsOd6FtBfd6UlKj3XTPe2r4/tRtbjKRglh5029fisI/SUw5ONU
ND1WN9SMVdQ2IVHmmtCKhDnPSlE2ZkNgikd4OUc8LBby5y+xF3py+b9C92T2nkoC
mb65gF5MiW/9YnZma/73pTVSqDB752QXoEld8ghcqdXrtfQbIfWSUbc0Z22ToSiX
70SDEX0+ZrQHOmWB5xYy6ne+Bf8QoKW1vGO5k52VkY4PmcfSr20Wu9MpZvzA91DZ
yGaZn2g42px3chQQ26gk/Ci4ZrDyHyyHPNBbDyX3gQqJfB6dr8uMXgbD/c3S96DD
ZvUY0Gx93dn4KAwDwyMUsSmHyVLhCtPpd8ci0BDHcdU7Q6PbujK54std72vlj6GX
cV+HGicH9tlNTrXNkiKQTCvSiiTKNs74Bx3wIEbcW+C0gWK8EGf/zQZIjiymTwrh
vDOd7LWF8TvN7aAYY8902b6dGFcL0voFqlA6r4DF3ZjodiVxHhIrVsIoLgfQh4Fl
DGHhSGzDkMUIkZDt2J9vwn/1JRmxKN9gwhhsXol2+nWTI3r8oAfUDBq70Y/kN31A
+xIViHcA
=Pfuf
-----END PGP SIGNATURE-----

--=_MailMate_C9FFADBF-8EFC-4DE7-A31D-AB6E399BBCF2_=--
