Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1566B598D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCKIvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCKIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:51:30 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C4C120845
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678524687; x=1710060687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mLwGonNfGhWipxmoMxQ2rTdsL5ddT/okE/q5rFTUuhQ=;
  b=Aim29CnEge9dx2Il7XLHFQde3HaINVf9fT4HWDiU+Tn4YDYMMORbrOcV
   P1y87Qu8BmkYCPuWXIBnGZP02KegI5iC0LpzarviPqapclinS8uJxu2dh
   IrxHNRcgAJfHkOv9lS9nvRVwkpwv1rMGYgF6tnqgAJ5PI9i5HoDybI8N1
   IRCuWH9tnaQsieSeeVon2PZ7qfOADTYOyfR+ZrWV9/cGelkPHhPLy5BA2
   voRmU+Li9zTZgmSON5QY9aIKNORbszkdquTaAueGZwX39jCOO3js5LkxS
   rf4vAnHddrjNivXBVoDjjQIn0pHLHSJTJirjKhHvbleGIdyb4zAeP/p4b
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="399486190"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="399486190"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 00:51:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="1007404675"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="1007404675"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2023 00:51:26 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 11 Mar 2023 00:51:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 11 Mar 2023 00:51:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sat, 11 Mar 2023 00:51:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sat, 11 Mar 2023 00:51:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqNJZV64OhbL7TP128QJbZitfhw0YWgoxAkRaNKRMCKxM2Nuz3xb4Z0Rq9yWqHyd6tbVSa85ylXEROYx6O3WNbeUjLiGdrosIdjIZzR1TB4Y1ZG//0kpmupEP5tukCB5V7vYPD2aPBTEhYbMedKiN9nl0ivBfQAtiNI4725Pb5i+D39UzoYknxq3BrHbvXs7aw0rDtuF0KnWCMP27clV3yF1v14B3siGKoWLlb3RUhlCsrIh4Rfxkm7au6X2rIRrn37KH3DYjfLilxukX/kHBZECTICfTlXkmJheTQdlDvdqGF569sBsWg9TWCQt16V+gzZtrUrPdQKM0+1WyDA0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1XUTvX9Ytxn4BKjEY9ileb346RNZ2vgm674QN99o6I=;
 b=KyJOmN10I0Xz4Z2DTI9PUaia4GKV0M5Kd0jdKJgnofZY2jZgDpsI40NyNCJI5PkGzCPysaDSBs99LWoTAx4N3vPOMc4XLHxr5nnbTyJnBwIiuILXSs5lXzjoDig1Y+TE+Wu1VRTXMpfjcTuE7rwEAgcEYJpNgGrDGeqjkFdRrrxjKGRGO7lh8VM8qYDNK9mEBWFBa+lGKAyqnMMdM+LawOjfmk4+o8fz1zEvv7MTiEyqZU5Z63a/w1n9TmY6WoPztxdkF77lah34IplvLwbk60yHZfxWSY2zoJ7O2pQbQk5B8l4hevkosbDG5R9L9ODlJPU0aYu2MIOGBVFw7jP0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DM6PR11MB4529.namprd11.prod.outlook.com (2603:10b6:5:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Sat, 11 Mar
 2023 08:51:22 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::7576:1f4a:2a6c:72f7]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::7576:1f4a:2a6c:72f7%2]) with mapi id 15.20.6178.019; Sat, 11 Mar 2023
 08:51:22 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Liu, Yujie" <yujie.liu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@alien8.de>
Subject: RE: [linus:master] [x86/vdso] 877cff5296:
 kernel-selftests.x86.test_vsyscall_32.fail
Thread-Topic: [linus:master] [x86/vdso] 877cff5296:
 kernel-selftests.x86.test_vsyscall_32.fail
Thread-Index: AQHZTKnKAz0cZUMjhEmzxrol8C6BSa71S77w
Date:   Sat, 11 Mar 2023 08:51:21 +0000
Message-ID: <SA1PR11MB67342994923BCFA093DF91C2A8BB9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <202303020903.b01fd1de-yujie.liu@intel.com>
In-Reply-To: <202303020903.b01fd1de-yujie.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DM6PR11MB4529:EE_
x-ms-office365-filtering-correlation-id: ab0c1085-ce8c-4c96-8ee4-08db220dc9d4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yuFrtrlk2QQLyAGxdFTVj9X16qpzJvLyl2XYzA85/rnehRdX8kEQaXjbz4/VVlZ7BEvCfnhiL+qTchT84Qten2CYBp/ZOBL0058/cTHZbNIL0DejVLq7dbjg6sq+TzrKPDHovO5SqH/PJqk0JWUMusiHmvLmTfX4Wxp3TQsO3Y94Ll6nyeoMAE/7e+Fwzmv2d8r5KUrViztJI6b/jbfJs+9b0PY0nsG1x4R0YJ6kUtbjHe1pIqteRKkfouA6Hhkv6987goTm8NbXCAKJJ3Gzbi12RG/iog417HJ6K94FsBbnnF8W/6WA6Sx1v0rAfQQpIgCVeeotrRwQK/MaTPM18RG45mYfE5oABaMyOFxyYoMImwxYTTl6YYovf6tobN95U4/6snCRT5O/4KddgWWh+YrQvfU9r/MwF0SExULzd4eEd6i4xncO/HcUzu8R5qJy6P/WP+vciGGIfJWxWnlwQU338gg6lsfTL9PBfmn+xEsFX/mIoeNaOyOKarCbNFOXpaS//rD8ogs9Pprtgrp/VhVqOpoIuLfh/9LLLTYpPSsCZ1YJxzA/aWFmScFczjLtWifRKHa8/XHoE+Z1KNwxrjIhr6dlh8ir2IdJGZdxR5hffD6Rhl+732Oka1SuAlZfziX2Kbn9aAMRyJm6+crsaZo5ZQSCeVT830BILHW7b5g4l8m2Xl5jhdNqtNNasn8yURgEt4PbCjaBKcOiGPiHf8TiQbz9s56z3LgguIWVxTM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199018)(33656002)(83380400001)(82960400001)(186003)(6506007)(26005)(7696005)(41300700001)(9686003)(52536014)(966005)(38070700005)(66446008)(8936002)(4326008)(86362001)(66556008)(76116006)(8676002)(64756008)(66946007)(66476007)(2906002)(5660300002)(478600001)(38100700002)(110136005)(54906003)(316002)(55016003)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fikBvjgYGkAH7JPKl8eF5tC6IdHwHxzpg4+f9HNWI6RrXAPYdPEOGay1TyRK?=
 =?us-ascii?Q?dLbtnsykZI/QQBTul8WkEck0lZxG5WpexN4xDr0EVK/Dm993guJw0jpD2UXP?=
 =?us-ascii?Q?RMODpY5lC7/3+HuMMA+Pr0TVqlpeIqp5JJXKEJ5X8shibhvmiWPhe8AfIU2R?=
 =?us-ascii?Q?MYrCrt+EdvLZp+gMdc4JkqjV/fdFo9voNs0xKA3hq0xB3Rbz9CaWvwT5/W7/?=
 =?us-ascii?Q?PtO7q2B+1rlhIONMGMSln+XcI7wLlNbiAfBGfofw5SQVFHa724zONYNYsujw?=
 =?us-ascii?Q?F3QoBtz/b2KkHZDtjwQHW0bqYCR/4GbaDxlE+xJ7ccrL4Opz1Hfu4I5JeYgP?=
 =?us-ascii?Q?iZKN2QVs8F55j8x3HuUxzpT7brMF9tAX8kflZKr9SChzgvpv5Q02RWGX18tN?=
 =?us-ascii?Q?XT1XN24TlOG0IX6gXm0zfotZ+/pjX6ki2Jh7IonAC7YVb2hT4Wk032cGx92r?=
 =?us-ascii?Q?xBZRtypGsq+GwYGdqqH7Xc/INoY+viYjfvNZZsFSSbrZcehabbfgZKF+iUe0?=
 =?us-ascii?Q?4uUzrx7LmFad/l5QUhAUuuzTpWi2of4g21mgs+6dmPysJPhvETA4i16tTyHz?=
 =?us-ascii?Q?3e6t4wHhWkzin4zrckYXVkLvqFWRw5fxV3g5XrgnwBAWDWYSqyXk2jzNvU9S?=
 =?us-ascii?Q?540BqHaPQQvhibvc6K+wGXQJAxe6vfpPmRoE8ZcTSwefWsMH8f4VQ7wu+4Rv?=
 =?us-ascii?Q?yS8Shn23mIttToWAH4kpvwBPbWD/otAEKw+pNSUyVu7Cesbz9lORPfxe1vmR?=
 =?us-ascii?Q?PxozBOngOuwViYaq5hvQFpHKbTMN3cjxNG/AoE4FetbDhJ1ikS2bXc84OzN7?=
 =?us-ascii?Q?x+4cJU/5+XiHsL1QTVtxEwLZdbaa6S3Gmg90l4EXJ7j8lP27FBQwYTD8LmpB?=
 =?us-ascii?Q?v3p20+acQLfm/4uwUsXtbEebQOH7szrOZYzM5bCDEd8+Jj6DWK+heXezNCH8?=
 =?us-ascii?Q?WIFCi5cxh5qt8ZEAHidvkwZstrZ9WFlNnKDqvw9cmWGf3jVQ6XwzN5RILz/1?=
 =?us-ascii?Q?+OVTmoZWrYuBQhI+6qVzNjMnYYKigpjACiXWrPbvTv7m0gJQm9wAK4Q0oGGa?=
 =?us-ascii?Q?G0XyITJ66Hf+mdOksC3NRxM7tzHg3nO9pQ6NfBVN5aTPOKrXH3BwI7v2Hk5b?=
 =?us-ascii?Q?WSk2WOSfyj+9QWqAnZ6s2X/Je01AUylfuMX1ZKTFRahBebZW/ycN62coFYJc?=
 =?us-ascii?Q?ZtSEKpdSDZ39tCqi+JNgXkXLsAbQLgbj+V0VM/8M0tD3xXdwL2gEwUjghwcN?=
 =?us-ascii?Q?nzH7miF/nN8AbR65GjxXg4T8PkVF3/YpabijcXsVrkG6Zq1M1MHUO/694JE8?=
 =?us-ascii?Q?3u+zoYcVwpa++KT9Z5r0eRXmo6jJ1l9Xqg5pXX65PMV+B4SfpobSDu/TKriz?=
 =?us-ascii?Q?9AF7QxMVP2YEsTrEqNjt7awdGCzPpj2nG9UatE+XUdiO05udXl8A708fGvUq?=
 =?us-ascii?Q?H4rjUkTbLXwfcksYFPvwjTEtJm6Gz1gO8D7/wnBpF3FJKSNpoWqwgntX+GPt?=
 =?us-ascii?Q?AoJOLZkEx1tPAx2Ve/5e2EYIxeApvDWGwIs23niH/g/z5tsx2CjJN2USdx6v?=
 =?us-ascii?Q?lSt8zZRjPuj9V0L9bLU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0c1085-ce8c-4c96-8ee4-08db220dc9d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2023 08:51:21.8658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fP9uDZFiIq2y0/vMf/cejASv7krPl2RpBvIdBVMYZrAxgCkZ4nepMNSnmyAn26GztrpZS9rPnzAQy9JJGiuKtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4529
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> FYI, we noticed kernel-selftests.x86.test_vsyscall_32.fail due to commit =
(built with
> gcc-11):
>=20
> commit: 877cff5296faa6ef312f8002216bbf73bea006c7 ("x86/vdso: Fake 32bit
> VDSO build on 64bit compile for vgetcpu")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> [test failed on linux-next/master 1716a175592aff9549a0c07aac8f9cadd03003f=
5]
>=20
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-d4cf28ee-1_20230110
> with following parameters:
>=20
> 	group: x86
>=20
> test-description: The kernel contains a set of "self tests" under the
> tools/testing/selftests/ directory. These are intended to be small unit t=
ests to
> exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>=20
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60=
GHz
> (Kaby Lake) with 32G memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
>=20
>=20
> # selftests: x86: test_vsyscall_32
> # [RUN]	test gettimeofday()
> # 	vDSO time offsets: 0.000017 0.000001
> # [OK]	vDSO gettimeofday()'s timeval was okay
> # [RUN]	test time()
> # [OK]	vDSO time() is okay
> # [RUN]	getcpu() on CPU 0
> # [FAIL]	vDSO reported CPU 227 but should be 0
> # [OK]	vDSO reported correct node
> # [RUN]	getcpu() on CPU 1
> # [FAIL]	vDSO reported CPU 227 but should be 1
> # [OK]	vDSO reported correct node
> not ok 9 selftests: x86: test_vsyscall_32 # exit=3D1
>=20
>=20
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link:
> | https://lore.kernel.org/oe-lkp/202303020903.b01fd1de-yujie.liu@intel.co=
m

Shan Kang found the same issue when she was testing the v5 FRED patch set.
The root cause is the 32-bit getcpu() on 64-bit Linux kernel is compiled
with 32-bit Linux kernel GDT_ENTRY_CPUNODE, i.e., 28, beyond the 64-bit
Linux kernel GDT limit.

I will send a fix soon.

Thanks!
  Xin
