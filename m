Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DE768DC26
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjBGOxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBGOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:53:08 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C105DBEF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:53:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJMhSCklnUZe8kYhsbhawYuqJRacF/aZVA4giOCqOmzFhtK9ROPrRbOLy9JKZ+AY05hxswLoVSjaBDVOZxhRvhOEDX/5apuUyPVQ/dYbPZ6HykBL6+8NQ4AQLNBcGGrwHM/PRKqH2Qe+ti63C3QOZ5VUdR8M0gElh0hw2CIFFJI4yCBLEzgvoidt2H8NukQglCLJQLZyyDkOodZrcwLkjPAZ3phhRXXONZgN94yzUkLNvH/P1vUcfho67Y7aWr9eIv9P6AjONx1RzSicBOcLuijn7xvs5EI2fbYJVZnVffX+x+g0jiUkNbGhD4cXsdfT5Qxgfw9Mao0bz8FHonU1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vIAEAFN+157ENzHvyODMx9JJjwbxIbUUz0yMj9HN00=;
 b=OA0UQSlCYjf9kFgoKKzNM81sHMgGzjHtnmxZ5pdcqJlSAaG2TMs5llIqJAM3RJA/7fxmdwzsVYH5knEWVGf5WlkKEq3+DF+J/BKgZDFyuPYE9NwB683ws4h9M2vq/DHZw3NGMZyw+AgGu5/QLlcAkjek/ynXcKQ4IlZShB5CyYuxCfHeXkRmpcchQJo7oGpzPikSE9hn1QpMz02tV57wx7k734KEkoo3Z0NGjtCI5JNXvuddXngMSlyiWNdDh0HPpXqvusUREGql5OYWnU0+K4SzHo9ebTuU6igO9mB5Ah0LBGTiLNHFlZ3f8ahD8YFWJ8Fvn4erjHo1xXLuzUnRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vIAEAFN+157ENzHvyODMx9JJjwbxIbUUz0yMj9HN00=;
 b=HESSZq95xOryRQU9sVn8NIjzQuKd+fhB6jYDIgdO+aRy8FW/gZ6LlKat8SQKCMZTE9HZXhbsr48fWJfnHpc/NYUS3fo26KOamDvgw1iD1PR/NmSg3FuIM0bhg8L6JzBe3QEIxMYjdhIN9b1EwAGV54OItvJrH/+Q5QcOnXd/0MNjb/e2PSgMB89LWXIPeLuDbmx6MG4MsSh52QHDMN2vCuyG47hjtss9kjzjl7da3NzBfHcXi0Gc/ETroLcK8voz/UhYSlXwmrd+6oKXCoSLp7JpmNhp/ij3duWtCqzExRxDyshTfPXDGt+4Os/PN3pXYvlxA+YoNAf0lj0d1fUZ2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Tue, 7 Feb 2023 14:53:05 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%9]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 14:53:05 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v4 9/9] migrate_pages: move THP/hugetlb migration support
 check to simplify code
Date:   Tue, 07 Feb 2023 09:53:02 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <D5C828D9-2EE3-4E8C-B76A-5EF5684AAED3@nvidia.com>
In-Reply-To: <20230206063313.635011-10-ying.huang@intel.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
 <20230206063313.635011-10-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_62B9049D-6E74-49F4-B971-A942C71294A7_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::30) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd5f5a8-1f1d-49f9-27a6-08db091b04bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrI54/Zo9qpcxe/qTPEeVajH4Y2+HqWieQqnqArJ+P7o74SRXTla8WC5VUC4cxOcXbTR9OR9Fy7AngZvLbhXw8CUVB1YtZ4ueftoJO3xmj07EqVpuSKH+2xoT+3vgiPqJtxQgWNjeD4Mm5tjkdCRFNF7QyvyjRYbOnBzZbXqyCBeKAciHYJraZ0WSJEwHccStGh97r03PNh44fdMzN2pv+rW4dkZHh6hi2E7D8J6A2wSD4H8KTMn2Ok2BTx174g9KpZBAGU9oL/ljqL0VpB5tzdBXh6gWtKs+I4gJH2qLpYs45Ul9eDVGfkFtpR7igxM2VYiP0i0WVh1loOs//pxxRzikX7FccJX2BhhgQqYaXIDjl5a+ClAba3BSFh4YHz/uSWEAdwmwzAUqUAyUSUD/gY5OFrQJsxLrEQoxurRortrg6FQB3nrEzhAS7yIx3uMt2syxl6/phos1v2s8/txeAXwBju2lN5BpxPhw3shrr0cadKdfF9QUDl0EsrKIG4rUSHMmFfxg8CFwoDMzpnwhkPD7xOt0n9A8Wx2q5dx8PKbTS7h0V3m72EclWicwKmuz/yAZopMiSTezCEG6lI594l1cE/kCbG5/Wgc/AwEA7PfebvhJRQ/6ZEULHk+kuU7FeK6yiGZAm4aF2Xs4ZOszoQWfGJMVf3gr7l8hm2hLLlrZwWEJL6LSfRIeQGQWQGzVfcnRC7Jtnx+7rCMdls75ESG6nl82Od51ncX3drCnJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199018)(38100700002)(36756003)(66556008)(186003)(4326008)(66476007)(235185007)(66946007)(8676002)(316002)(54906003)(26005)(6666004)(6512007)(6506007)(53546011)(5660300002)(6486002)(86362001)(7416002)(83380400001)(2616005)(6916009)(41300700001)(33656002)(478600001)(8936002)(2906002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7om21Mj9DbljBUpTagUmfSS1nBiQtSPGX0RVXC11t9dqpiidbc3gRumC2vU6?=
 =?us-ascii?Q?Jf8+QZ6lmjrkLCJ+Mu7160NRsHTUqNM3IRqGVOsZSMYnqpLy2OlaVPCWNsUO?=
 =?us-ascii?Q?EW0q+bgNMaXmnB3l//zhDQqvMBGoBbsELwQ93LNAPK1O2p+bB9jZCNkbNBtK?=
 =?us-ascii?Q?LOmjZ/50BNX/jw2LdaNh4jHLulJIYfYDfl+1w8YurwHF8CuPFPlEOnTOmKGo?=
 =?us-ascii?Q?o+hOFE/WrU9VoSY7rzLYwF29WvdgUK4+AiQIHFNJzWcvlq1ljqDKKNW6COx8?=
 =?us-ascii?Q?b5v+kJ+W7z60YAyOGpBWZdUUQmxAFTekRaefZJIqXAaLprpUBQH1G8tf3joR?=
 =?us-ascii?Q?eN7fBG28D7T8m0s1cGGSNIRkRza/RTTN9wi/qyAhSr6N6hLUWMdClzEigAeL?=
 =?us-ascii?Q?KigmfSJzCj4Hm4lLna2e0h0EPfCfD23z7oM2JHumCb5+rD2LUbAGr6kjrSOS?=
 =?us-ascii?Q?T25nRJLjWtfFiaYe+48rEuRofpxkDfV4jgZJp0mMyTo8abwhVqGwu4GUyHZd?=
 =?us-ascii?Q?ZSLu5sE3mAHEjQmNsdN2k7AD58OIm5P41xepO/LiZjGEzlRm6e2r71iqCbjg?=
 =?us-ascii?Q?ClwBQaOfc8s8B2+Qaok9XJ7ascy7uuo/ecuWGlhFMXHaRDVmdV/p8j5ygG/W?=
 =?us-ascii?Q?MmbQ91ZydmBzVb/dd7x+19JLpfDki4CcQKIxypERumzGdYkPrFBlyffcuwQ+?=
 =?us-ascii?Q?oWF1eBBb7o2zsS68R7EfsVBTLQwKBsLizpYxuQmTCYxh0JB+dqRvuuJDnGU3?=
 =?us-ascii?Q?4WCGaMe1gUW4XVjb6zoTwVymBvG+iugo77egLJSwyfRK5rCO3iSlGRuXbBOj?=
 =?us-ascii?Q?bTSm/ossTwV1nySZQKoI2HFZF7d23XRDS8eFujtC5k66AAL7v3JEaEuy23aZ?=
 =?us-ascii?Q?dqbpQxQ9zuTHDSQUUIW2lgf4Cy5SMj/qsuaKXR437JVVkorgpleCQtHHr+LG?=
 =?us-ascii?Q?d0obAq81k13diydXCaRuwexQ0WmbLCKyix9+VSrSaG8Pz89z4PhRh1YRfBVC?=
 =?us-ascii?Q?Bit9zpdTQ/WIFs59dS+zxfG5Amp5KjNeI8e3kK8QHOOkOegIsu0pcdMB0wcJ?=
 =?us-ascii?Q?C6IFWs7BQBTvXXjtOw0YG0cMLYPEN0mOknxp0bmdjaPsfCuNZoEbOJFWw1uj?=
 =?us-ascii?Q?JwO8Fs5de12zYf78pvHp0W1JPw3Um+CWhw7HqKO+VC/skb2brXyBcbuDKmAB?=
 =?us-ascii?Q?zFXEpdjY11BQunVRSLcsZBI3ZQYftm02i7gx5hKOs+nv4UfDjd7FYclypPYl?=
 =?us-ascii?Q?fDyoJ/uB1Rl+mft9XuIzgFs5O9LquyDBKByNlUtWGbYOAigTY52z4Z16s7af?=
 =?us-ascii?Q?DCMNFBPidkNMS+j5TOawR5/bmvxUrdJ9N1+5HtYw1/J7yTWXXHcIHL+/W1qr?=
 =?us-ascii?Q?bG7fla+DJB/BlbqeDE1PZJX49s12NQaSeEudKm121NMW11NQK5HgiEoKoWWP?=
 =?us-ascii?Q?YwIeGirr4OxHEAyZXcLdC3gf3qBkMcWr85I8tKtV+ypAK+7N9xf8MMrzREV9?=
 =?us-ascii?Q?+9e8gBEOXlFPtqfhzC9TUleIBc7h7p4/wQV6tEgsRQYgY4RTjeRn121Y+iR6?=
 =?us-ascii?Q?nEmkbRqAHRKeobNATDNY1rLCTd6fgKtsBviIsUZm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd5f5a8-1f1d-49f9-27a6-08db091b04bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 14:53:05.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTvdCkx0bFnY1+hcKC40Lt08IYbJpVgabtKyo2ub7H/FQmYryhsq2L3h96oTioiT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_62B9049D-6E74-49F4-B971-A942C71294A7_=
Content-Type: text/plain

On 6 Feb 2023, at 1:33, Huang Ying wrote:

> This is a code cleanup patch, no functionality change is expected.
> After the change, the line number reduces especially in the long
> migrate_pages_batch().
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Alistair Popple <apopple@nvidia.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/migrate.c | 83 +++++++++++++++++++++++-----------------------------
>  1 file changed, 36 insertions(+), 47 deletions(-)
>
LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_62B9049D-6E74-49F4-B971-A942C71294A7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmPiZc4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUglgQAJYPfrS9E4LuNeW+Q9DdqYvCJBngH38bSfBO
FE18dXhM8IxeXxv3cK4ClitRdxNuAuXLJQQxMwAQaJzt33gmMhF4RneazAh6VOu/
zgoGQTcsj+cW3gcLb70zSNr66FY9wStSBBRhXJlbUpe1y3vkpGidZJ+PGKB4Vp4u
2+65zLF7UL7YaKGWBYRiM5SqM+/khAf4lSwTwtHp/pjPGKWwC3YjJa0yCdcltLMc
/EBpevPifGksge0RrgsySXmnDAmBulr+mAtx+y7+nHb11hRp4nWAh1ong5V+33Ta
CGrtSvsYBfNQTcKwjKqzb6p4uCZyF6lxjqBlAbjvxzh1+Q2nVLy3Gm/tEecDjlZF
5Yn0G2QtdlIZc/ABDVyIp9GDkUhcBsR9Vo2n2WGUsLWoFwrzsrT1TYb09qPlfzYw
UpKSnvjLvSdTfsgKEgJdKLc8Dj7dBUJM8ZsYowpbuCugAlzIz5kih/W+5FBKllmo
CTI+vcdr9ZJwVJ7o7rDeG/Dq4p+NTqpOy19OYidrxth+FK0BMPZrPiEFRKJm3PMf
MC1kmM+6lAQbd3MNlZxVSkZiBKg+Dmry1EXgG5jtk8DdrYFqasOv0V3IrPXN0chq
qAW5n51Ep24nTM/8Z1gxZbEf5SY5Hv1OOD6cBBBbbjyK9aqjvBgVYdb5k1MICuXl
hWTj0n2i
=zgVC
-----END PGP SIGNATURE-----

--=_MailMate_62B9049D-6E74-49F4-B971-A942C71294A7_=--
