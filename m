Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427E36C6715
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCWLuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCWLuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:50:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC633CF0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOMCtpLsjNpx0WX4jJcRBeMjQN+hPiPkZcYii1bB1Yf332sbYHmjgviSccFaW70hG9vumeweGCqMo/29oCFg+CwkgSKmKRamPMjCewcBlG85xm52WYUI3uysKczUv/F2Y7zFVBPmH2p5T1VNJ9nTGYCINgUTBborDdzfIXbe0MG1zB4OXkM+WEHd0h5zORFLiZjMEetEWE314W7sa6vG6D9CymgfYnXXk+2LdDyTiP6AAc9vySAwQnNnU363QumNG67KH0s5eXsoaDtNYGbuQAs9EnYL7L+f9NVQTfRz0qOG0VVnWfwE1UBvBDFryb/354WA59T92IZJ9KE50rQJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1pCmnjanYRqiDuol/VNu6FwG6Vyqzg9JTTZSPpoEio=;
 b=JMqovNfyA6Ea2NzyKrZ+TX91Z1qwNbzx0AsbP4wwGwpScWCuZSGrUOykwNspWWBqxYfGAsFxLukXx/P3aga6kuslX63j1niqADX/BHcZQozGXyQKep2wsOBoY3SCNG1xUz4ecuAm7vK7n3lTxsaKO89hRG3Rwsuu2qGXGEtCSCnFXYedQ69JNJTm0hBE2FGSEoLcWyXAk3VwxHBWbHBuwvmKVGSRg1Ka2gVGtTuDayzmRcNOMJ+ZpGyhBmhjAoN+T6mtANCT9QmIY5ARCPGZbY5Pxwas2T4eRZwXUkzHxgnL/QweMwJV1mzRkAVtT7z4HPGTaw435Ih1u/ZAnJSuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1pCmnjanYRqiDuol/VNu6FwG6Vyqzg9JTTZSPpoEio=;
 b=VTNJZ+85r9m7smapLA0pXmocVtdkdfImMM0nMwRGl58PTWdxg4AMqGYDzXjRo0omR1s2qIqcMlfvWjskc8IhDbDa0i/YwHX0E3FTrYuPCLnhmUkGuohySO8rGlsYTb/x76SKiHxr/mRefqd5xXUxAOGJZv1U21FJy6Zii2EtkWjtMwApJPF9WnkHrDaZZ/NY6b7j2emvaSpGlGAv2YdZS/bLnH1J5MOV6wSxiejs7q3a3xO/jDBjqf4uKF6VaJlcbadVVpXZ/G6+JJhPkEHGk4RNfTbTd4hz/D5DO6iM3Luqxa9izyziJMO9DssBT40TUmwFIiJkY8FQddfccyJLDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 11:50:04 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 11:50:03 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/sparc/mm/tsb.c:405:39: error: left shift count is negative
Date:   Thu, 23 Mar 2023 07:50:01 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <91E887E4-0867-421F-9C75-FB9CFF15C33A@nvidia.com>
In-Reply-To: <202303231810.eJX8zyTf-lkp@intel.com>
References: <202303231810.eJX8zyTf-lkp@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0A6A6035-3C7C-4285-8CC7-953A99475A8C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:2d::34) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 3373cf53-b5aa-4fb5-e3c9-08db2b94bd61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agajXhhf3b/owcgr9DRthEO4172tff4Fx7DiakmmHihv3D9RxFvl71p+oENZabMdpw8paISrJmXlAZUnvQKD0E+HvX1RT27qtcPIF/gguaySKkpAXefsS3tO+Xc5RcErPdUIoB7KgmEDr43hCa7t6uZ1esKTHTDXijegzjUflUfxk72677V51tu0MvWNvulD1yW4uUoOypm4SrEUwmcOSbFYFZ8hsA/IqWD+MK96iM7MEx6+36gQWp4PBOJ5IgAkglWbkEDoJQoXWcsg0mQvrih2onsoJPSf9CP/xnqBUaNgj2qnawK2aYinFeo3Wcsj+OQr5OKDcr4aE+21WwyBXErou2j1JDi6U5D00kM+wtXS7Lrj9mVmOr5GirhzhT6tljBOf9G/dXF4sPrK3Y+2lNwL+KfLKIYJ162ob2EvSZFslbKeRug46Lq0hwW0cQKCGA6BVlFQ3xu82b/uyQiom5GcxaNVmCHEHYWAl0mx11zqZlrzfzcRrdUTEFDhtUh+aEWqNr+DumDZwTUYRHo6Im0G+J3XGXHgoRj4hHFq9gWZXzGQpjSxNSgibWNUVnW8Ti9SYR0NMuU2gO1WgHlPT2YhTaRUu0VzHQPDPNq+ON0chlUMc9U+QTYiy7djohBvjWb8xCI1Fh2UDEpEk4++aR3CRqAiF7PxMpWnmFByulYNsXjB4ly4Ydef4QjPPHv7vTUIc/cVPS29na44GEq4HjUoDsnQLmAv/YvxkLs/rSx6+5rHkdSzg3xofBCELBR2NblOAQzyAMMEUQUdYR+nGPMkbOqEw5gr2QvAFyWfNN5iBTvCItInIcuNCqjOrlLk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199018)(36756003)(33656002)(26005)(6512007)(6506007)(30864003)(53546011)(6486002)(966005)(235185007)(83380400001)(2906002)(86362001)(41300700001)(66946007)(66556008)(66476007)(316002)(54906003)(8676002)(6916009)(4326008)(2616005)(186003)(38100700002)(8936002)(478600001)(5660300002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DCOajPqgiJOIsPbBkXl32ICwIgEpq6tmiCI/j5y79FXUARM8OdWl49gQ+fUl?=
 =?us-ascii?Q?GHFiv5xybCIoSb0QqJD9rCd7DywbfdWAgamKiXU43ihIq0BzjOlIydu8Ab/J?=
 =?us-ascii?Q?TlFeEoMDuYuVVCxD+RVLmF8+5aQC36L3kJEFFgg5kRqknpfjwBVnmr9N+B9l?=
 =?us-ascii?Q?kr2bIk2CQVy93ZRKX62YbSrpHuEI8I4ygFQAs8VONJGaQmB5ml/8VnPlnUbL?=
 =?us-ascii?Q?57+a8Ymrpjy3WTvb/09hdbMoLWSu3Njp1WXvMBcXIilRrZ6Gjl9IDKScnQGM?=
 =?us-ascii?Q?N1Ktk070GwPthXWGgSDyT3/T8wcroQ0ZP8dJVMXz4YxS/oXEIW0Pr6hXx+Gh?=
 =?us-ascii?Q?eJrdtYG17w8aa5OoH+1SeqNkp7bPS4soiWnkxbAtspNJPZb70H1CEkcHInGd?=
 =?us-ascii?Q?DA5k8D1HO4pgQ3iXdlyO8UzEGTM+rrthZIPJcqGxHhDjc+i29Teo3/dxCGhL?=
 =?us-ascii?Q?yuR9OlprP4aDN0OoAaNZWVlrBLJBBEETw1JjN6Gaj4XsmxoG7rEGApx3rNCP?=
 =?us-ascii?Q?El1UIqRN83LtHytXx/94QPkoBSN1s61zl3M+C1FXPy9XaNZ4JVMpCAJr4Ik7?=
 =?us-ascii?Q?JRU/tGMDWh59nF/l7hXN2L0LQ5KpOvOzuPnAOCeiJbe6NC/diiuQ6EU9V0dK?=
 =?us-ascii?Q?5Gu/RSGsHH/TOmnE2WyTZ4uNnp0LWXBkzIfRBYfKIlayWLpaNnHZO0P9mq3C?=
 =?us-ascii?Q?VYyxSW0QQgOhcy7iDB5oq376U/KHpq549LxrYjW1AVXduy/AWLSeez+4TRvQ?=
 =?us-ascii?Q?cLpCH20PqJcz0/ulfTW8ldTMkqI5UloNdtBFt41sgeMt2kPqX9I1Rjx7R3Dz?=
 =?us-ascii?Q?a15IkDtkEnHVXOOc9KGkALA2FpZ3dqsovMbmew0O0Nl4QmPTJF4aqGas04EX?=
 =?us-ascii?Q?V989cUTt6NNIuKvsi8OH2/SausPBasGabrtr74P72cTrqpaivXgZIDkKrmoG?=
 =?us-ascii?Q?GAGsIwit5RwRuAYTs1pdtPiY0jRMD1mJSMh3s+cENIpVGVjnLOwGDuelyEhk?=
 =?us-ascii?Q?hDCihXuHcbDPOqE4r4F/MWMPi+Y031Pfxre6Gp8+C0zzLmNSOnc7oKLmOpy/?=
 =?us-ascii?Q?Si4QEXaIcTv/9h+lPomdhc335vmbXUF4l2ebJRFO8fLSyKX8MAWi3mfXAorZ?=
 =?us-ascii?Q?a7Qw9s8f9MQTBzIP7EpWs1xQDgO64LUqeQ/ub2eeBgpQ3uZq7CGagwOvGq8x?=
 =?us-ascii?Q?s+ot0yqyn0e16o4wzshQrJxF7jopIVIBXpF58iuEDsJ1R7otGDS8i+srPzNP?=
 =?us-ascii?Q?PNPpu3e87TIZbY+qu1DMJKqboEx0tKjF/FrAyf/fnH3dJgviQOjAIjQxHET2?=
 =?us-ascii?Q?kUkf0xg1IsxEcp0ENW27Vm7y2l76lhP6XuW110tHfodcUnXaAyw2OengF02x?=
 =?us-ascii?Q?zFNBd60+xzDW6u7iFygKyLSZNLm/fhIUwTgG3TqxGt6J7v2wNzpZuDmvyirO?=
 =?us-ascii?Q?X1MpnmSuGVHjC2VI1p3WH1l+/6X255v7YyMfM4i7SOLuKD3W55JQtsrStEo5?=
 =?us-ascii?Q?RqpBHe6pzlPFJsotLAMY3H60jsn/GQcCUXa+4GPNQB+InwIfARdpXfsS6+ib?=
 =?us-ascii?Q?erWPATJggFfZ+FbqF1InIXIEUptgOdC9MOCFoVFe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3373cf53-b5aa-4fb5-e3c9-08db2b94bd61
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 11:50:03.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9y27HycvU/mCzW9wOPTCsNIdDjQnY2X2TKgmUcyt6VA8GHME2ejWaWy6Hm606iu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0A6A6035-3C7C-4285-8CC7-953A99475A8C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 23 Mar 2023, at 6:40, kernel test robot wrote:

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
> config: sparc64-buildonly-randconfig-r002-20230322 (https://download.01=
=2Eorg/0day-ci/archive/20230323/202303231810.eJX8zyTf-lkp@intel.com/confi=
g)

Cc Mike, since he is working on ARCH_FORCE_MAX_ORDER.

This random config sets CONFIG_ARCH_FORCE_MAX_ORDER to -1, causing this e=
rror. I am not sure if we need to always set a range for ARCH_FORCE_MAX_O=
RDER or random config generator should be changed to not use non-positive=
 values.

BTW, this issue pre-exists my changes.

> compiler: sparc64-linux-gcc (GCC) 12.1.0
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
ross W=3D1 O=3Dbuild_dir ARCH=3Dsparc64 olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Dsparc64 SHELL=3D/bin/bash arch/sparc/mm/ =
drivers/base/regmap/ drivers/media/usb/em28xx/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303231810.eJX8zyTf-lkp=
@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from include/linux/gfp.h:7,
>                     from include/linux/slab.h:15,
>                     from arch/sparc/mm/tsb.c:9:
>    include/linux/mmzone.h:636:33: error: size of array 'free_area' is n=
egative
>      636 |         struct free_area        free_area[MAX_ORDER];
>          |                                 ^~~~~~~~~
>    arch/sparc/mm/tsb.c: In function 'tsb_grow':
>>> arch/sparc/mm/tsb.c:405:39: error: left shift count is negative [-Wer=
ror=3Dshift-count-negative]
>      405 |         if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
>          |                                       ^~
>    arch/sparc/mm/tsb.c:406:43: error: left shift count is negative [-We=
rror=3Dshift-count-negative]
>      406 |                 max_tsb_size =3D (PAGE_SIZE << MAX_ORDER);
>          |                                           ^~
>    cc1: all warnings being treated as errors
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
> --
>    In file included from include/linux/gfp.h:7,
>                     from include/linux/xarray.h:15,
>                     from include/linux/radix-tree.h:21,
>                     from include/linux/idr.h:15,
>                     from include/linux/kernfs.h:12,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/of.h:17,
>                     from include/linux/irqdomain.h:35,
>                     from include/linux/acpi.h:13,
>                     from include/linux/i2c.h:13,
>                     from drivers/media/usb/em28xx/em28xx.h:22,
>                     from drivers/media/usb/em28xx/em28xx-audio.c:14:
>    include/linux/mmzone.h:636:33: error: size of array 'free_area' is n=
egative
>      636 |         struct free_area        free_area[MAX_ORDER];
>          |                                 ^~~~~~~~~
>    drivers/media/usb/em28xx/em28xx-audio.c: In function 'em28xx_audio_i=
nit':
>>> drivers/media/usb/em28xx/em28xx-audio.c:808:29: warning: variable 'de=
vnr' set but not used [-Wunused-but-set-variable]
>      808 |         static int          devnr;
>          |                             ^~~~~
>    drivers/media/usb/em28xx/em28xx-audio.c: At top level:
>    drivers/media/usb/em28xx/em28xx-audio.c:47:12: warning: 'index' defi=
ned but not used [-Wunused-variable]
>       47 | static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;
>          |            ^~~~~
>
>
> vim +405 arch/sparc/mm/tsb.c
>
> 0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  379
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  380  /=
* When the RSS of an address space exceeds tsb_rss_limit for a TSB,
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  381   =
* do_sparc64_fault() invokes this routine to try and grow it.
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  382   =
*
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  383   =
* When we reach the maximum TSB size supported, we stick ~0UL into
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  384   =
* tsb_rss_limit for that TSB so the grow checks in do_sparc64_fault()
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  385   =
* will not trigger any longer.
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  386   =
*
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  387   =
* The TSB can be anywhere from 8K to 1MB in size, in increasing powers
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  388   =
* of two.  The TSB must be aligned to it's size, so f.e. a 512K TSB
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  389   =
* must be 512K aligned.  It also must be physically contiguous, so we
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  390   =
* cannot use vmalloc().
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  391   =
*
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  392   =
* The idea here is to grow the TSB when the RSS of the process approaches=

> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  393   =
* the number of entries that the current TSB can hold at once.  Currently=
,
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  394   =
* we trigger when the RSS hits 3/4 of the TSB capacity.
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  395   =
*/
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  396  v=
oid tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long=
 rss)
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  397  {=

> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  398  	=
unsigned long max_tsb_size =3D 1 * 1024 * 1024;
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  399  	=
unsigned long new_size, old_size, flags;
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  400  	=
struct tsb *old_tsb, *new_tsb;
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  401  	=
unsigned long new_cache_index, old_cache_index;
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  402  	=
unsigned long new_rss_limit;
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  403  	=
gfp_t gfp_flags;
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  404
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31 @405  	=
if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  406  	=
	max_tsb_size =3D (PAGE_SIZE << MAX_ORDER);
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  407
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  408  	=
new_cache_index =3D 0;
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  409  	=
for (new_size =3D 8192; new_size < max_tsb_size; new_size <<=3D 1UL) {
> 0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  410  	=
	new_rss_limit =3D tsb_size_to_rss_limit(new_size);
> 0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  411  	=
	if (new_rss_limit > rss)
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  412  	=
		break;
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  413  	=
	new_cache_index++;
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  414  	=
}
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  415
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  416  	=
if (new_size =3D=3D max_tsb_size)
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  417  	=
	new_rss_limit =3D ~0UL;
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  418
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  419  r=
etry_tsb_alloc:
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  420  	=
gfp_flags =3D GFP_KERNEL;
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  421  	=
if (new_size > (PAGE_SIZE * 2))
> a55ee1ff751f88 arch/sparc/mm/tsb.c   David S. Miller 2013-02-19  422  	=
	gfp_flags |=3D __GFP_NOWARN | __GFP_NORETRY;
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  423
> 1f261ef53ba066 arch/sparc64/mm/tsb.c David S. Miller 2008-03-19  424  	=
new_tsb =3D kmem_cache_alloc_node(tsb_caches[new_cache_index],
> 1f261ef53ba066 arch/sparc64/mm/tsb.c David S. Miller 2008-03-19  425  	=
				gfp_flags, numa_node_id());
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  426  	=
if (unlikely(!new_tsb)) {
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  427  	=
	/* Not being able to fork due to a high-order TSB
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  428  	=
	 * allocation failure is very bad behavior.  Just back
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  429  	=
	 * down to a 0-order allocation and force no TSB
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  430  	=
	 * growing for this address space.
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  431  	=
	 */
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  432  	=
	if (mm->context.tsb_block[tsb_index].tsb =3D=3D NULL &&
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  433  	=
	    new_cache_index > 0) {
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  434  	=
		new_cache_index =3D 0;
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  435  	=
		new_size =3D 8192;
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  436  	=
		new_rss_limit =3D ~0UL;
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  437  	=
		goto retry_tsb_alloc;
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  438  	=
	}
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  439
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  440  	=
	/* If we failed on a TSB grow, we are under serious
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  441  	=
	 * memory pressure so don't try to grow any more.
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  442  	=
	 */
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  443  	=
	if (mm->context.tsb_block[tsb_index].tsb !=3D NULL)
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  444  	=
		mm->context.tsb_block[tsb_index].tsb_rss_limit =3D ~0UL;
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  445  	=
	return;
> b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  446  	=
}
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  447
> 8b234274418d6d arch/sparc64/mm/tsb.c David S. Miller 2006-02-17  448  	=
/* Mark all tags as invalid.  */
> bb8646d8340fa7 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  449  	=
tsb_init(new_tsb, new_size);
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  450
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  451  	=
/* Ok, we are about to commit the changes.  If we are
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  452  	=
 * growing an existing TSB the locking is very tricky,
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  453  	=
 * so WATCH OUT!
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  454  	=
 *
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  455  	=
 * We have to hold mm->context.lock while committing to the
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  456  	=
 * new TSB, this synchronizes us with processors in
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  457  	=
 * flush_tsb_user() and switch_mm() for this address space.
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  458  	=
 *
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  459  	=
 * But even with that lock held, processors run asynchronously
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  460  	=
 * accessing the old TSB via TLB miss handling.  This is OK
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  461  	=
 * because those actions are just propagating state from the
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  462  	=
 * Linux page tables into the TSB, page table mappings are not
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  463  	=
 * being changed.  If a real fault occurs, the processor will
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  464  	=
 * synchronize with us when it hits flush_tsb_user(), this is
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  465  	=
 * also true for the case where vmscan is modifying the page
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  466  	=
 * tables.  The only thing we need to be careful with is to
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  467  	=
 * skip any locked TSB entries during copy_tsb().
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  468  	=
 *
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  469  	=
 * When we finish committing to the new TSB, we have to drop
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  470  	=
 * the lock and ask all other cpus running this address space
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  471  	=
 * to run tsb_context_switch() to see the new TSB table.
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  472  	=
 */
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  473  	=
spin_lock_irqsave(&mm->context.lock, flags);
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  474
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  475  	=
old_tsb =3D mm->context.tsb_block[tsb_index].tsb;
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  476  	=
old_cache_index =3D
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  477  	=
	(mm->context.tsb_block[tsb_index].tsb_reg_val & 0x7UL);
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  478  	=
old_size =3D (mm->context.tsb_block[tsb_index].tsb_nentries *
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  479  	=
	    sizeof(struct tsb));
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  480
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  481
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  482  	=
/* Handle multiple threads trying to grow the TSB at the same time.
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  483  	=
 * One will get in here first, and bump the size and the RSS limit.
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  484  	=
 * The others will get in here next and hit this check.
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  485  	=
 */
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  486  	=
if (unlikely(old_tsb &&
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  487  	=
	     (rss < mm->context.tsb_block[tsb_index].tsb_rss_limit))) {
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  488  	=
	spin_unlock_irqrestore(&mm->context.lock, flags);
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  489
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  490  	=
	kmem_cache_free(tsb_caches[new_cache_index], new_tsb);
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  491  	=
	return;
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  492  	=
}
> 8b234274418d6d arch/sparc64/mm/tsb.c David S. Miller 2006-02-17  493
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  494  	=
mm->context.tsb_block[tsb_index].tsb_rss_limit =3D new_rss_limit;
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  495
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  496  	=
if (old_tsb) {
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  497  	=
	extern void copy_tsb(unsigned long old_tsb_base,
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  498  	=
			     unsigned long old_tsb_size,
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  499  	=
			     unsigned long new_tsb_base,
> 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  500  	=
			     unsigned long new_tsb_size,
> 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  501  	=
			     unsigned long page_size_shift);
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  502  	=
	unsigned long old_tsb_base =3D (unsigned long) old_tsb;
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  503  	=
	unsigned long new_tsb_base =3D (unsigned long) new_tsb;
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  504
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  505  	=
	if (tlb_type =3D=3D cheetah_plus || tlb_type =3D=3D hypervisor) {
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  506  	=
		old_tsb_base =3D __pa(old_tsb_base);
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  507  	=
		new_tsb_base =3D __pa(new_tsb_base);
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  508  	=
	}
> 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  509  	=
	copy_tsb(old_tsb_base, old_size, new_tsb_base, new_size,
> 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  510  	=
		tsb_index =3D=3D MM_TSB_BASE ?
> 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  511  	=
		PAGE_SHIFT : REAL_HPAGE_SHIFT);
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  512  	=
}
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  513
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  514  	=
mm->context.tsb_block[tsb_index].tsb =3D new_tsb;
> dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  515  	=
setup_tsb_params(mm, tsb_index, new_size);
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  516
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  517  	=
spin_unlock_irqrestore(&mm->context.lock, flags);
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  518
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  519  	=
/* If old_tsb is NULL, we're being invoked for the first time
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  520  	=
 * from init_new_context().
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  521  	=
 */
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  522  	=
if (old_tsb) {
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  523  	=
	/* Reload it on the local cpu.  */
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  524  	=
	tsb_context_switch(mm);
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  525
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  526  	=
	/* Now force other processors to do the same.  */
> a3cf5e6b6f2548 arch/sparc64/mm/tsb.c David S. Miller 2008-08-03  527  	=
	preempt_disable();
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  528  	=
	smp_tsb_sync(mm);
> a3cf5e6b6f2548 arch/sparc64/mm/tsb.c David S. Miller 2008-08-03  529  	=
	preempt_enable();
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  530
> 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  531  	=
	/* Now it is safe to free the old tsb.  */
> 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  532  	=
	kmem_cache_free(tsb_caches[old_cache_index], old_tsb);
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  533  	=
}
> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  534  }=

> bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  535
>
> :::::: The code at line 405 was first introduced by commit
> :::::: bd40791e1d289d807b8580abe1f117e9c62894e4 [SPARC64]: Dynamically =
grow TSB in response to RSS growth.
>
> :::::: TO: David S. Miller <davem@davemloft.net>
> :::::: CC: David S. Miller <davem@sunset.davemloft.net>
>
> -- =

> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

--
Best Regards,
Yan, Zi

--=_MailMate_0A6A6035-3C7C-4285-8CC7-953A99475A8C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQcPOkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUCwIP/2GasQ5NPoSeuxj4LMtE1ZZ7OVVigD8qpre2
RKDGDzm8Mrz6fh/OmtTq2TDQ1dsXivWqv0QUOkZiqKeDZz7GXPuLrh61+uBDihow
WpvjlM9j4ftXY2DL5RfqIoay8p+wpTG0pgNeWiEHMP0X+43q4n+3x2iRnGaf1W4t
qsUulQ1V4CRbcAcfFzWVxX1C/5P5XbLAPMh0CepTVJNToucuWRYpamHYsypXELtm
amihsFyG/Uzsy/40+ODM51XSe9mfawWtu6SFAcxsH0mQWJvwezIdFAWabSbMt3t6
TTPY6P+KvkIFE5jd9/Upul567oW9bSeAcWtJfFLeT3pHIeVt86kk4Md4BVBcOPXV
ezXVHZ5yjGSUgAFwK8KsizUceIJ9YFEqX2346+ZpKQH6QIvm183KO3EJ/HJjKiWQ
JP+CML1sFvtAiYY2T+DHhdFWUck1SMFgr5i8BXTIn+EiOO2TcvrhU1sw/dymqu9o
nsSQQZldILvKLXAtk6jkK7IW4Rxti+sjIvH3lDHzg14DXGfi600PaLnerq0ZMNI3
A8FNGxR96pg6jGzzvDAX+VTeNSDNZlNcXAXN/dgw084ZKMKNShXWMVWfupl8DQ43
n5gC2f8eFes/5wTbmDYXHmW5fKahRm67ix2ABC+RyItFRphrc15EjfLAdHZjlPrz
jca3aVCp
=EQc7
-----END PGP SIGNATURE-----

--=_MailMate_0A6A6035-3C7C-4285-8CC7-953A99475A8C_=--
