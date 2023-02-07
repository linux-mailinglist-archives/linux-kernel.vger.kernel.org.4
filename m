Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E54868DBDD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjBGOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjBGOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:41:48 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D69076A8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:40:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRxaJuS/azFeIQihrmNFgjlKbNKGio4FvHrLq8sksz1NakDIQQvUcCrHaqrm3x+eim0VKohwYCwfRfShk1GtXyWABxwBCCLhm9rTp62d6NJqTggwRVR6Btejv92kXwrmliuf79OJiMwx8ams5HIot1V/Anxs2v0U+PSm5rMDUNkefqOdSa/c8KlCMpTTuimCn285qd5gBNfLCQZvrvKHBVhAoGrYxk4EVx33MLBQJaM/jAG/TIzr88YPmouSkpY8h0k5chk434gxRdw6x4ziymFroweJjkFZlpLup1Lj6fekfhD6a1dParHKwfZDggVuazbJlM+2Kd+DH0MmIkkAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbPuhRbPu/xCZ8hgbQyqTj/SRMBQ8OSQe1Z1dnP4aAg=;
 b=O025+RPLym7m8H/DrN70jTqwr+h88RYxaBuybHJDOXheLo78ws33TMqlJwx4v3XNppi2T4Bx81a4P99vxruMy+VCK05NjasM3cy1OpJ0mpEMIeTyOKTZj+2PqG6xpeNr20r1FVLraTPW7zl0OgLwENheEjD79T52YM/I8AKyf6IxB0QoVvnJ6Q1iokXLa/2XVxCHC9VTZgsBSSsCUhJB1qTHBe6Ka/NRljlfaBb7q5deVn80WesM9Xkut8x7nCR/OIpg5QiQ8C2BdTZSj9WfEs1KtWJgj1wVUtVvu+tiHAbTwNq2E/C/6DkcVbo/dORrGz+sRK/kLoLZK3VZbMWd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbPuhRbPu/xCZ8hgbQyqTj/SRMBQ8OSQe1Z1dnP4aAg=;
 b=TR68pbpi0VQsFiTaQn0zdWT3v5w+tulAT3CGcovcy6+fQ3hXwcVTUpN09og7nXycj6FLFW8WLUkU4eeiZ7yBPoq3X/dQss1PZe4WqNcU7GSPJImEk2fpuJETFlYtOMthyVPB2Ubsz3CgoL3xi3SD8CgVT5cggshqan3lSsqDzesw7V1prfyA5FKm9AuaSjy9cXoJIDDUjjK8DNpVNsuuzjiLNMYN3A1TveSuam13apoXoKAd4k+GFPaGRnezMKjkuUMtt+y12WtBDIxrMRVmrUqPfQaBKvhgBdbIJoH2TKJadhlhE/Xuhm0lI5OhYJz4mGAhk9girqYJDXc6Zcy6sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.31; Tue, 7 Feb 2023 14:40:12 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%9]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 14:40:12 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v4 6/9] migrate_pages: move migrate_folio_unmap()
Date:   Tue, 07 Feb 2023 09:40:09 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <7D090B16-BC76-4041-AB4C-6FE471C5B485@nvidia.com>
In-Reply-To: <20230206063313.635011-7-ying.huang@intel.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
 <20230206063313.635011-7-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6243EBBD-5A99-43DB-B508-6FD7449E43EB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0078.namprd02.prod.outlook.com
 (2603:10b6:208:51::19) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e5e976-b34b-4686-634f-08db091937af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eSn58K+uCisOvCTZUvM9aDfJ2op+WQvlD00++rffLSMp1eAn179xctmMpn284VyFAc1BaiMvVcgft0Tw9HpD6CATvYlJ+SU0AXsYh3IDezCYCbhZX26wei1/oY8k5gDFfbCp4MP5reC7hG3HGytnDuVXOJdLQXL1Pd0lMDTWTmF0ZfZMhRKtSyWraM9a/IUImassEE4yh42qKt1NsfmNpWvVd12vrSPzgmVX036anMaFCNjjaqfDCf3EST43p+mdjR5M2nkmVx8QR/syxZSM4E25AL9nXtM+Y1ZRSngbhCUwnEulBQzAncAKOf371qE3r20chNv/p0A716DDXBKmDjZMBpMlACt+NTr1GceW7/h6EBPHccC2/SgscVlqrDA5GJmOKCg4OGimbbbT6snMye2FY85C963mj3fFDsb9mmoKKUASDbE5aZIDad/2ZKucKxA3tZRrQ3b7ho9iYbi3jrhEumcMq2xn5HSTz+4dT3cDCd8p6D/1kJjqTJb+2IWkukiqUihqZJuxDp58KQzNwALKE3QTjB0tU8d//QQ7apdM1+hSdhD6ilhkZt7eRfdZgnQqOXLBfhe51MBmn+DvXOv4DmfyNEjngrxZruv3zc4nyOhyDVe8csWYls1xGuOiXmP2v8/CdADPUiRYC3TDVcbVz72UaqoYi3nGN+pclMfS118fHmVT2WmWKEN+98ZhI5qyY5JMMa9dfTtNYjrJoeBHxu6+TdCqcRZkWCFrKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199018)(38100700002)(83380400001)(86362001)(26005)(2616005)(186003)(36756003)(6512007)(33656002)(66476007)(316002)(66946007)(66556008)(41300700001)(2906002)(6486002)(6506007)(53546011)(478600001)(6666004)(54906003)(7416002)(4326008)(8676002)(5660300002)(235185007)(6916009)(8936002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Hziu8CnfeueHh41Sp39omA6Wenob2qeg8KiN8p5aT2vZTnHJrpU0Wn3imuS?=
 =?us-ascii?Q?DTUicdE7LWneGFbCTb+MUJGxQ51YWJY0atgvLVfpPYN7nwodPN/k1PQpNISe?=
 =?us-ascii?Q?nnh2g1188exXZ75/9XLbi4GnDUlJPTAAw6NeRFGGlCp5xfHJiG+MJUXL10R2?=
 =?us-ascii?Q?46n6w1i8FntgMOs3RLwZyPbcUGlsrg7hLpb4aM4alwasZc+41a8kJSE7sT7y?=
 =?us-ascii?Q?4emmwIVZDa6nybLWI0LopCm/CKRMzgZ3cRdVzSL/eZ5DX41zo0pcqwBuEyKK?=
 =?us-ascii?Q?WkMyHjOsCeAdsk31vEYx/JX+drtH4baxDxMOh+cmkcqIHaFy8OOKwuYTQBhF?=
 =?us-ascii?Q?hymEjpWC7YUpP8FyN/MkvI2zgp3r9mijp1vk9reSn9F54bCflTjMInZ2kSMg?=
 =?us-ascii?Q?BK11h0jYnQMEviN1917/zM5eIpMIj+bNipiTIG40E+uEI5IHkrDaIXh8kVJC?=
 =?us-ascii?Q?ERuvpeVQBDRwWJa/1viuvvyE0MMoFQd3TkvUev4HqZ6abwsBYzYihDgWxqVo?=
 =?us-ascii?Q?lvyOK/U8huKubpGwiGxOYXbcbA2QBgB6DT1D51IvhXBuCjv7Z5wVKp/2NIES?=
 =?us-ascii?Q?lZpYydcTanUxYiJLAWwqr5LX/vcfak6HUXNL/K/3bE9PZQH9kQu7btQSoxL+?=
 =?us-ascii?Q?8ijKIwcimeAXVh0QT09/UsL43kUlLQx1s99ymGeV96sbL84y20+Wk7IK2LGh?=
 =?us-ascii?Q?plU6gVT1Ww1CWvfA3TrZXqGGfJMYTneqDEWqMhykVQ1RqLfY24IdWbx51JOR?=
 =?us-ascii?Q?HGohgD33EI3NZa05wlm1ropM3MCh3br3rZp28SMtDv4v1WBd0pV864g/Mb3S?=
 =?us-ascii?Q?1xUEaOEgZszZxvXdzQvvSLyVN7olhnWng+hXYarbKTpgpgYvrOVTeT6S//Ut?=
 =?us-ascii?Q?ZDw6oBGbvQn84o6KIvl9PfKhAghrYPj/jnw93cOAPbrUsaCctBPPWNLkCwgD?=
 =?us-ascii?Q?7z+OK5UqcDCF6X9EJ5Oj8dX6DVNwRQyE/KgxAVdH3B931zfQuW2P4pZS2wIL?=
 =?us-ascii?Q?pOdLkyNxrzUWlBgHpqas4tkykUF+Y6HanVV1altWvAThvaQ5mZHC0ZpFtphs?=
 =?us-ascii?Q?IM3WuvHUHt9VCfWw707w8aSqMrzt2ZGWz4w2nvPddqzlpCjnFpyy8c1Pywcu?=
 =?us-ascii?Q?SyMF9lvWS253Pmvign08S+6bVhk7cta55zGwMrWs0xiEkhADGeA/XpKQKgSc?=
 =?us-ascii?Q?gsEo9GrDk97KdaU0hYTutLXSpkQEWRd/R8pMlLJ88bEA3TmAQFZHFXc/ar1i?=
 =?us-ascii?Q?psBU9/97/iQz3qc0KkDXKZqMl0RWNMQi9moNUzWZvTVLbKweUUZaNav6nwHd?=
 =?us-ascii?Q?tWjFD5nsFycPhIfJiFa0uFVshMWwezmNdreAxNQY2HUTwSIsCVrKVPadtkcM?=
 =?us-ascii?Q?6MWpamyk584YQfTNBuLOG5skqqWTbQy4MkhVQVH+vcwD+QfNpQznVaT12ytK?=
 =?us-ascii?Q?Zlsy/N/1nrBl8/z8cVh9/TMKmd1tdLI4L/RmOQ2HxQZvQmyJ1Q9eXRz28FPe?=
 =?us-ascii?Q?Y2LdTs083Br8gyaxaT2sJmjXZkBKhyWOhINy6bZ8rqQl9c6rXuX13hZGCxHa?=
 =?us-ascii?Q?pLO1pFVPwNNP/kAGe3IGmsnd8xyWG/We41nh+K0n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e5e976-b34b-4686-634f-08db091937af
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 14:40:11.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8ySaU+/2YTucfALzEoAVQhe2hbiX/3faD+eQxrSgTU6S8h52qfm/VCwUH9URvwu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6243EBBD-5A99-43DB-B508-6FD7449E43EB_=
Content-Type: text/plain

On 6 Feb 2023, at 1:33, Huang Ying wrote:

> Just move the position of the functions.  There's no any functionality
> change.  This is to make it easier to review the next patch via
> putting code near its position in the next patch.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/migrate.c | 102 +++++++++++++++++++++++++--------------------------
>  1 file changed, 51 insertions(+), 51 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_6243EBBD-5A99-43DB-B508-6FD7449E43EB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmPiYskPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUTPkP/2jAjKhMOY3lD0qpMYszX+rNXuHXEPZ3jOvp
s1wsPWdcJF+2e/yImdfeRfxpcbpnwBOY/obLUM4vrmIwKfuW0yoVM17iueOOGfUg
ww4FBFT/wupCuyeSH6nwy9u4a3xQfQmBy4Q5ctAYjs9qb0db7+hWTs5u6cyYzQV+
2j5eL760e9ZT4VmriZJY8fpF6bbtbQ9wG1z5LJZ21kg3STJTkp2mTaFme4TbI09+
zZDAOVmgctYdh/LEh4X9fzsu9g780oIvNRSXYIaDNTSb+7qRsF3qDP/z/s20u1x9
cNgqEqiF+BreMt3O/B3g5exPyMbGbXH+ujEnnavoQRUjpfSEwn/KWCoGXKD4pbTF
0cX/YaJOwnOy8+40blekhe8KVk1hbtMn0FvxTeUwQ/2FNXZjdj5xenGzoNjOXJ7n
2Ry8ojmpd6/Cu54wOvLJ3p9GI0IXIPF+ar78ZafpJbMIT5bSwixCPhicE8W841ey
KSD5hVgt6triOk8POdIs3pUURI5gUOWSIVDXoaVMzOlk0it4e9np6R/HXiuEHecg
dlgwynXySG0gr58X5sJmzyl8DY4z+M7VNgf4ItBEf0l5/zudh29jKDwvQkn5Io+G
Ug/AmTgwm1C8CzqKCjstVqt9FTl9V97M3LNs52pnmqGcNVJO0v13oYHbEL5bOM4S
rF6Wu7Pm
=Fsd8
-----END PGP SIGNATURE-----

--=_MailMate_6243EBBD-5A99-43DB-B508-6FD7449E43EB_=--
