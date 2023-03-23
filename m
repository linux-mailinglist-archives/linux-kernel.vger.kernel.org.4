Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B536C6719
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjCWLvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCWLvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:51:38 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC5A3403D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyZquNdp3pJrW+YsHrg00GTOKYYpW6t7fX/sVUHUdELOLCKkOrTElguq4uPTY6VSqYijN2JNdJV8iqx8R6hAQOpwa4SqhIBQB3YJt/Bafu8blNlohqioPUZ7nJ37sBmo1+aYNEFpc17kZEKVtVdlkyjMkJ0w+dM0HX8R3Dd2QhF2fSzW29JboMVU38dnyYjebUDBB1xg5HIO1xhIEIimvGyWy4nQ31SdzRiABUMMZmgm2e76jhIcn93mCJAEvlCZtv/5R1DyoPkhEHTklnmEno8L30Z8IF4Mm34lJw7lbreGXmqwWDCJAQGK8ZvhaPKdeWuWShW5+jb6kDOXiisojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gGmit19sw96rW5Urnd9cg4dtnXKtuEWR7VQpRs05Ss=;
 b=AOrKpQogKHotatB6iiwCNt+mn46V3WsOtkDM4lNm6wN189kdbwpyHRLyZd2Dz+JQGBaT9Vd2mQumeWEefCzynvMJUvotLamXFO1l/04+5n1Kn8TTnZx9bReZFiQz/1QDgdGL4uB/Lcn4tGqYCR3YiNND6ZTFcHCzSKQbez5eVSqKpF0BnjuzUpvrysJJ1LEaCXpQ0v40xuNbss6KyFhfUrxLJmPoyFo0tYJWSu3qL9DcqwxUta8MHESCDm6u1WVjL/DXa+Jkhh5M0J20n14cj037t5GXwy/bTN6b7HNO27xV+TlEgNL0vywptHVzEB0Yu7ZR041OZNa/T8O8dokhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gGmit19sw96rW5Urnd9cg4dtnXKtuEWR7VQpRs05Ss=;
 b=OkBm6EAyJL5gNcSNgde4W5YVRfhLt0NEXXLjum+W3dFmIWVaxQdmnx352wEW3aic78emEKcEV4hNprjPajFGRtJNWouDuk5B8xpLI8uSawLCW+/yx0ZbAjOKeXJJ1TTQNheYmUZqf7FiT+gPFtSB7TO23REV0M5o4zAo/OAjoUdvJmRn+a1vLvqEszfOiv/M6vE/Dp+Tw0Kt8s4j3bZqjXzeoHHlvAWD3W9NlDlM1fC6k9fjZcM52E7uyVldGK2dUYWs1WMMvneEZHM2ZrxeGXYvuEk633jerygDwj1o8t1IltDg1vyik/1ABc3lqLkOdDchnPgM9n9wa04pCJpgBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 11:51:32 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 11:51:32 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: drivers/virtio/virtio_balloon.c:40:44: warning: left shift count
 is negative
Date:   Thu, 23 Mar 2023 07:51:29 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <2A07826C-FDAF-4769-A4A9-30D81FC4251C@nvidia.com>
In-Reply-To: <202303231958.9lByNCPW-lkp@intel.com>
References: <202303231958.9lByNCPW-lkp@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2EFEC590-B7E5-497C-B44A-F7365B8CB1EE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:c0::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f5bfb0-dc2a-4dc0-de89-08db2b94f207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGcNIcbf5qa0+gIjBn5hrWHp34ayum6Q+W08nOV+MIN3fA/EPzLdrN/YR8vSVo5scwG/+OTJVp5HlamFmQCI4CIFP16u+vklbEvHXtqY6V9Bpetp9O5X2bsiP9ZfdZ8SMIi9Wbg/PnWiGfqLc1rorqK8H0mb+1shePw+UQiL6VV+4DhMRZTwSoxVmIrVTGBUFlQGsesEK5glPp27MQY6loDzEfi9+aaxmhJnnqg/TVEReb9u3Bj/m7VZYdOr6UgwMQ16yROOG72hnSP+sH8G6JaHkA0XhVbpPq+iHsr6bbmTCfJxrMShwX8SGZf+j2q5y/XKygZdDOmuy0Ol4M+e9Qk4SJETuQ7wAldl+fHRlw2tScz9yBUY0baCfNSFe7PLDOTW1XFLFkE2YBUhPnUwlxlPVtKK1Y7ycI3tA7CRV0rIydPpGUqqEUg/70EBUL/xP9txjx7wuWhjIIyRok0P9909mKOt/PQcSnonbPe2HAEb2ajy1PE90mY8d22tgA//dzNsNGoVHK4V4kDI7njBQkYHcz5heyxrB7j0M4Ldw2ik0bfG4auPXQcD2chz8PmmL6kRs5Y7FoZjhS8sQaxmMy9HNhBzFb5ZUDsU10jdtVBBc9UCfuo92N13IMsi6eL6NDCz6wTHIrwWt8f+3+zfGQp5DMyQUpjVbxg9NT0u2PKmPyNwjY3DRsZhrY6SuAPIrqpRoYhYzEAcuDTQb//UP4YfI82nZflUy+cO9COWpDTT8+X6je3+3stS/l57SxMwNHy9GgksF5flbAvLX7eVDfqJfJboEq7MhXyYo/813elQCVgAxrkg3UBwc0P6pk/9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(41300700001)(66476007)(8676002)(235185007)(5660300002)(6916009)(4326008)(2906002)(4001150100001)(86362001)(36756003)(33656002)(38100700002)(26005)(6666004)(6486002)(966005)(478600001)(316002)(8936002)(66556008)(83380400001)(66946007)(6506007)(54906003)(2616005)(6512007)(53546011)(186003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QX3/jK6i/M1USNwNJesZMrba/DzQyfam8bGqu4HOb6m0sCzueGQ/h97OITZ/?=
 =?us-ascii?Q?zN0ieSOspm42Ankn9fEW30lEuYM6yOnBK1ULKqA+5y1Etiezn3OqCO3dWcCv?=
 =?us-ascii?Q?J2pzys49NxX7CR+yAccPG8xLAhziCmSrBO1wsUrOwmrYtfPzTJikF9SnN9rT?=
 =?us-ascii?Q?vEEfiYYzfx0UZ/fQepzCEvMSJWb/9wbRvr50FQf6/2gKHcmQXbpIFcpY7141?=
 =?us-ascii?Q?shbigoR8s1Pgu7WcKRGKcuPfku6zEUEzP1cuALYafOxlf+/V9eBQH0V/1hq+?=
 =?us-ascii?Q?tktAnvvA74Q6X/p/sDbgvQxPLR090vdz4NWeZE8UD3qcGQw/1tdivVGY8KY3?=
 =?us-ascii?Q?wyHYao8F2+cHqQcFFNGPsaJ2iVHpdTNMj23+XV6ba4P3DurooLFkCYWZJ5ol?=
 =?us-ascii?Q?KAUUyIPath1LTUYBz7fB7IClJAdPwRK7lY4DLgLlfgCIM7spmNLeAgBptVVM?=
 =?us-ascii?Q?9v13bqm1yzAwZrJ8620rPb+XkPGXDztsZozpCmm1U1EHYg00avaLIq4zdR7r?=
 =?us-ascii?Q?+cup/vUsxYJDyLXLILUxxf4mcu8LdVl7Lx7xsgATiGh/P/b9tMayftMwjpQE?=
 =?us-ascii?Q?8x/hkBt0UhTfE83yJ5NrbBHt/Uw2vYQjbefCf2CPFBHyOzu2RfxRNrVrRGWs?=
 =?us-ascii?Q?XhYEZDuy3Tqovtk9Dbp/EWftOLOTpWGXw+gtp8EAJezSaTUoMsGe4bERRfKB?=
 =?us-ascii?Q?nzbCOr4kBckAHVGxTdxGPoHVg4Up73I88SItCNenzgfId/ElduoGkuRFinab?=
 =?us-ascii?Q?7duv9Tz9mhwevqV/70tjrJZVJwhWIM2pqy29NH8xDCzyWOZxMiL7CBJS6dFi?=
 =?us-ascii?Q?FkAg5pEM2GBpqREoBNyk7fKt8M8yzWt6MopiugMRtLBtZ5yCpHDoAnhjOhzh?=
 =?us-ascii?Q?Re85CeMEAv9c7X3D9Ge7Qb1UBIrffTsJWD0VHUgWOCs2G0+Sc1XnLw9iPDQg?=
 =?us-ascii?Q?JN48es1SJwjJm5KzXiQ2AhiOQpLdIeyVC/LA+gumC2+KDo1GkrqI+4LBiKbT?=
 =?us-ascii?Q?jMtYr2UYCXJzm3N+MN2qt5p1ujQQXQCj2hgFfmt4A3DMBIcdk3g7h6HA+OZc?=
 =?us-ascii?Q?481EQtTEHJBvQ5MP3aIvS22Dk3tcFtMf45MQNGVBhLc5TFM16xBBLOoqhxNJ?=
 =?us-ascii?Q?wQciwNU1+lU80DVk1IHbm/MWb8oV0PdLk9O9EHlRo+dJQeVnQGZT4sqaP8hV?=
 =?us-ascii?Q?6LNmi4XVjcjopiYOqfSN+DBMDCfP5el2qlklylakLt3ilxD/aFm4qQOETt1s?=
 =?us-ascii?Q?rSXKY/NTiI5FqNDL3QSrhYGruZkFtm1FBQFJKVG8XFSW+U46abMmwTqG8JUX?=
 =?us-ascii?Q?txzLWljNgUFJfzkirW6eJxn/vu+ItirITSZggfU/bh3D/Hlc3ffeG+o+n4OL?=
 =?us-ascii?Q?es8BJBBs6mJ6qmIJql0DTKd/5dZ3ex5v50I9JP/xz6+wX3hGaHtAtJKlKKsF?=
 =?us-ascii?Q?yWleMIaZKu0GJhgaF1KGzR44+xFfV3JZSkxNUsKAf9+MdizOUswWish7dGu6?=
 =?us-ascii?Q?T9euN0joKSg4yHIj0IWeFUguCcfXVva8hfQFPW1qaZeas0WJT4BzZ1TJTkju?=
 =?us-ascii?Q?aSS+LSNXw8oxtbCqm9Xxor3Tki592VcXW105sLZu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f5bfb0-dc2a-4dc0-de89-08db2b94f207
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 11:51:31.9594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfTr70Ng6VsLmbESIqfL/VAOeGoNIkTDC3drhdeeuaVGDz2l1ymP79aNqLfRgrnm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2EFEC590-B7E5-497C-B44A-F7365B8CB1EE_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 23 Mar 2023, at 7:12, kernel test robot wrote:

> Hi Zi,
>
> FYI, the error/warning was bisected to this commit, please ignore it if=
 it's irrelevant.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> head:   fff5a5e7f528b2ed2c335991399a766c2cf01103
> commit: 0192445cb2f7ed1cd7a95a0fc8c7645480baba25 arch: mm: rename FORCE=
_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
> date:   6 months ago
> config: sparc-randconfig-r005-20230322 (https://download.01.org/0day-ci=
/archive/20230323/202303231958.9lByNCPW-lkp@intel.com/config)

It is the same issue as: https://lore.kernel.org/linux-mm/91E887E4-0867-4=
21F-9C75-FB9CFF15C33A@nvidia.com/

> compiler: sparc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D0192445cb2f7ed1cd7a95a0fc8c7645480baba25
>         git remote add linus https://git.kernel.org/pub/scm/linux/kerne=
l/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 0192445cb2f7ed1cd7a95a0fc8c7645480baba25
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Dsparc olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Dsparc SHELL=3D/bin/bash drivers/base/regm=
ap/ drivers/virtio/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303231958.9lByNCPW-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/gfp.h:7,
>                     from include/linux/mm.h:7,
>                     from include/linux/scatterlist.h:8,
>                     from include/linux/virtio.h:7,
>                     from drivers/virtio/virtio_balloon.c:9:
>    include/linux/mmzone.h:636:33: error: size of array 'free_area' is n=
egative
>      636 |         struct free_area        free_area[MAX_ORDER];
>          |                                 ^~~~~~~~~
>    In file included from include/linux/math64.h:6,
>                     from include/linux/time64.h:5,
>                     from include/linux/restart_block.h:10,
>                     from include/linux/thread_info.h:14,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/sparc/include/generated/asm/preempt.h:1=
,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:55,
>                     from include/linux/mmzone.h:8:
>    drivers/virtio/virtio_balloon.c: In function 'shrink_free_pages':
>>> drivers/virtio/virtio_balloon.c:40:44: warning: left shift count is n=
egative [-Wshift-count-negative]
>       40 | #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON=
_HINT_BLOCK_ORDER)
>          |                                            ^~
>    include/linux/math.h:15:46: note: in definition of macro '__round_ma=
sk'
>       15 | #define __round_mask(x, y) ((__typeof__(x))((y)-1))
>          |                                              ^
>    drivers/virtio/virtio_balloon.c:808:25: note: in expansion of macro =
'round_up'
>      808 |         pages_to_free =3D round_up(pages_to_free,
>          |                         ^~~~~~~~
>    drivers/virtio/virtio_balloon.c:809:34: note: in expansion of macro =
'VIRTIO_BALLOON_HINT_BLOCK_PAGES'
>      809 |                                  VIRTIO_BALLOON_HINT_BLOCK_P=
AGES);
>          |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>>> drivers/virtio/virtio_balloon.c:40:44: warning: left shift count is n=
egative [-Wshift-count-negative]
>       40 | #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON=
_HINT_BLOCK_ORDER)
>          |                                            ^~
>    drivers/virtio/virtio_balloon.c:810:42: note: in expansion of macro =
'VIRTIO_BALLOON_HINT_BLOCK_PAGES'
>      810 |         blocks_to_free =3D pages_to_free / VIRTIO_BALLOON_HI=
NT_BLOCK_PAGES;
>          |                                          ^~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
>>> drivers/virtio/virtio_balloon.c:40:44: warning: left shift count is n=
egative [-Wshift-count-negative]
>       40 | #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON=
_HINT_BLOCK_ORDER)
>          |                                            ^~
>    drivers/virtio/virtio_balloon.c:813:31: note: in expansion of macro =
'VIRTIO_BALLOON_HINT_BLOCK_PAGES'
>      813 |         return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK_PAGE=
S;
>          |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>    drivers/virtio/virtio_balloon.c: In function 'virtio_balloon_shrinke=
r_count':
>>> drivers/virtio/virtio_balloon.c:40:44: warning: left shift count is n=
egative [-Wshift-count-negative]
>       40 | #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON=
_HINT_BLOCK_ORDER)
>          |                                            ^~
>    drivers/virtio/virtio_balloon.c:831:43: note: in expansion of macro =
'VIRTIO_BALLOON_HINT_BLOCK_PAGES'
>      831 |         return vb->num_free_page_blocks * VIRTIO_BALLOON_HIN=
T_BLOCK_PAGES;
>          |                                           ^~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~
> --
>    In file included from include/linux/gfp.h:7,
>                     from include/linux/slab.h:15,
>                     from drivers/base/regmap/regmap-debugfs.c:9:
>    include/linux/mmzone.h:636:33: error: size of array 'free_area' is n=
egative
>      636 |         struct free_area        free_area[MAX_ORDER];
>          |                                 ^~~~~~~~~
>    drivers/base/regmap/regmap-debugfs.c: In function 'regmap_read_debug=
fs':
>>> drivers/base/regmap/regmap-debugfs.c:229:32: warning: left shift coun=
t is negative [-Wshift-count-negative]
>      229 |         if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
>          |                                ^~
>    drivers/base/regmap/regmap-debugfs.c:230:35: warning: left shift cou=
nt is negative [-Wshift-count-negative]
>      230 |                 count =3D PAGE_SIZE << (MAX_ORDER - 1);
>          |                                   ^~
>    drivers/base/regmap/regmap-debugfs.c: In function 'regmap_reg_ranges=
_read_file':
>    drivers/base/regmap/regmap-debugfs.c:376:32: warning: left shift cou=
nt is negative [-Wshift-count-negative]
>      376 |         if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
>          |                                ^~
>    drivers/base/regmap/regmap-debugfs.c:377:35: warning: left shift cou=
nt is negative [-Wshift-count-negative]
>      377 |                 count =3D PAGE_SIZE << (MAX_ORDER - 1);
>          |                                   ^~
>
>
> vim +40 drivers/virtio/virtio_balloon.c
>
> 5a10b7dbf904bf Raushaniya Maksudova 2014-11-10  32
> 86a559787e6f5c Wei Wang             2018-08-27  33  #define VIRTIO_BALL=
OON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN | \
> 86a559787e6f5c Wei Wang             2018-08-27  34  					     __GFP_NOM=
EMALLOC)
> 86a559787e6f5c Wei Wang             2018-08-27  35  /* The order of fre=
e page blocks to report to host */
> 2a946fa1c8bc26 Michael S. Tsirkin   2019-11-19  36  #define VIRTIO_BALL=
OON_HINT_BLOCK_ORDER (MAX_ORDER - 1)
> 86a559787e6f5c Wei Wang             2018-08-27  37  /* The size of a fr=
ee page block in bytes */
> 2a946fa1c8bc26 Michael S. Tsirkin   2019-11-19  38  #define VIRTIO_BALL=
OON_HINT_BLOCK_BYTES \
> 2a946fa1c8bc26 Michael S. Tsirkin   2019-11-19  39  	(1 << (VIRTIO_BALL=
OON_HINT_BLOCK_ORDER + PAGE_SHIFT))
> 63b9b80e9f5b2c Michael S. Tsirkin   2019-11-19 @40  #define VIRTIO_BALL=
OON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
> 86a559787e6f5c Wei Wang             2018-08-27  41
>
> :::::: The code at line 40 was first introduced by commit
> :::::: 63b9b80e9f5b2c463d98d6e550e0d0e3ace66033 virtio_balloon: divide/=
multiply instead of shifts
>
> :::::: TO: Michael S. Tsirkin <mst@redhat.com>
> :::::: CC: Michael S. Tsirkin <mst@redhat.com>
>
> -- =

> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests


--
Best Regards,
Yan, Zi

--=_MailMate_2EFEC590-B7E5-497C-B44A-F7365B8CB1EE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQcPUIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUeo8QAJBnaNs2yJfof0KvBymnU750l2HVyjZMQnvb
/5jhnPVOfLIpqcN8IMfVSlJ/mQl/lSyD/0rH0RRQzlhS+UF6cRL29LxQ8Y0vQZST
Ff0EPnKiqilRGzVw7Qvh50lpTpk+KVZzZDa4kfhN/bmKIYqpMTrSWFJtyWsqoniB
pfODusa7gVzo6nMJUcY89SXCNFju3oBrGKUM2km18Auz6LCtTpGIgUC/6xkqavhu
SJ5ubuUv1LBvnzc4aFr+ctT7WHLfmCm/T24DDekcW56tzdv56R2MeKlKKVQfm6DF
NmWeEcdn33XARklHplXMwAIsX94AwLXm88v5FO1hLLw7V0FZWW+eIXZmZSKlG5sf
S3DqBrW+m22DdJbX9HDNE3cCJCAEta/ctwvuAqzC/p8tQByrdMfEKabwhV/oiPBk
jP+xapfJkWXRyAHWSXu4+K+5kgsjfKSE9yCMovpr4Iwt4O9HO/NJrazXOxjIz6SR
Eu0Z8EPm7EHUlwZQ+BoUcKDfOagKk0cmGsAIjHkTgXwyLGj3VE64YHQSRPhxzF+m
RdIEKzLVIvbdS4kkD8Ts3Qa2MGO9xbjiB/ITCrsxQWE0+x2Hb5wKYWLYdDuTY9Nt
vaEfGdBv68QUerE3HDPzilevdyBfrLj42iWPCEGfQ699xEYrasE2oLjKH+Rl35dJ
VIY9nEU0
=VNdX
-----END PGP SIGNATURE-----

--=_MailMate_2EFEC590-B7E5-497C-B44A-F7365B8CB1EE_=--
