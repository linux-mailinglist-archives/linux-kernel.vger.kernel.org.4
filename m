Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6D5B4E85
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiIKLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIKLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:41:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F9437F91
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662896457; x=1694432457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vIaTbX/bywdAFYjXFuddXGVgyiyoHBNhvXBv5RMr/JY=;
  b=A6g77Nl/gL028paSiDs+wGDZUInQDngnmr1k1KToZljZx3b4es2cj4n0
   oZuLmh2l8OLFSr8ntkoXs6V/4/WiLuGrHsnaC9nmvlu6YeeiAzbQSKjFl
   nbUvhNNN9Hww5CnmPT7wxkVQw6201ZRoCsN6dq9VdCEEZKQWOpv7vgpaC
   +558ctz5BulIsCQ9ntSGuxtScO3wSJ4YsmhVp+18oW13zpfCKxePfncHW
   uPu4Hrf2zLFTyqLu39tz0QEjlh9vwGnP3i5g7jJ3uCIuPx09dF9UugE3s
   wPudICX3vraHOX6qroLUHlivk0wsbDmGwjki1MG7PMbRvrDt+OeMdyhBW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="384012077"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="384012077"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 04:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="677753206"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2022 04:40:57 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 11 Sep 2022 04:40:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 11 Sep 2022 04:40:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 11 Sep 2022 04:40:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 11 Sep 2022 04:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLXzK1mY8RoOpA14sZM8+3pANkYTOdgwP+4T2ICBazUv965XiJnRtbObJQ8VHSfhHV50ogcPsYIUJsj8xXyvDIdmxEhiIRwrsK3//Cct4sKiM0QkahvEmFuoSUdLXy0Dhd4DrDpYAXrg3PNmtZrutbmT7A15Bjz9awyvcdWdyzip4BGxmmI2C8mfZrMF7PqC5b9MKiZi4RA6fVwGLFpY5Af96lJkYvisJrvjumzWLnsa0CnnBOkE5HaU2gxC6Gn6YRBOGnAnGTcW6Xn+8ghWwdyP0SfKx8ZleNn59RNPIVh2vnQwstxo9iqRaWTh+4LbMrqjY7ERN9FB5/qclZ+BAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jxs93/+KSY538GsU5z0Np6OOaXermyPrdQyMTAj9DGU=;
 b=PErsYXi0DIOR/T2a7HyP8Sbm2S9iA4P1HxHbuilRD9jSxnvlJ0M52I8PU3jFrqE7fI9/mLx5jETZ4zNpxvE6PV7L/W/i+TTUUUu9p2grXdNn7L40nz9utJe7m5FAH5QkCtBFmW38ARxUQeYzGjKXPS0cOmKI3MsYLnaCSUkZgEM7GqmqkukrTWaMsvuojvPcGFvj1vIAni5G26mE/fo6Um9++9uUMKmffNPjyyOhP1mjmGkPOgrip8+XT+P0tDCipb3tjfvZEQUCjp8erhGxT3i+34LyKfHmZ88CzWTLrmJykBph0Prcq2MVAE8xgyDxC9hqaWM1Ndz4X54u6qR9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SA2PR11MB4827.namprd11.prod.outlook.com (2603:10b6:806:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Sun, 11 Sep
 2022 11:40:48 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::5482:e4d0:c7d9:e8be]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::5482:e4d0:c7d9:e8be%4]) with mapi id 15.20.5612.021; Sun, 11 Sep 2022
 11:40:48 +0000
From:   "Li, Philip" <philip.li@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>, lkp <lkp@intel.com>,
        "Chen, Rong A" <rong.a.chen@intel.com>
CC:     "Jason A. Donenfeld" <zx2c4@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: RE: machine_kexec_file.c:undefined reference to `__tsan_memset'
Thread-Topic: machine_kexec_file.c:undefined reference to `__tsan_memset'
Thread-Index: AQHYxdFMwPVIJLKrJ0Cb5fw2O2xBWK3aGRcAgAABxcA=
Date:   Sun, 11 Sep 2022 11:40:48 +0000
Message-ID: <BL0PR11MB2995CE38D40350C0FEBA3841E0459@BL0PR11MB2995.namprd11.prod.outlook.com>
References: <202209111930.zTjXeajS-lkp@intel.com>
 <Yx3HnuEDyFG0+G62@dev-arch.thelio-3990X>
In-Reply-To: <Yx3HnuEDyFG0+G62@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2995:EE_|SA2PR11MB4827:EE_
x-ms-office365-filtering-correlation-id: eaf2f39a-c428-4bd0-4cd1-08da93ea78f7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n9e/ZJuSKUtN02tFVXgWxHII7smTA83kkBxEZ+0By/QgJbbz3ThNvwYCp2Bn3txR6Krx3T5vXBxPw9kYGsfV0+MWgIfeaqD8Igi/heYM369Yc9lP0mSpGxa7WKFpPGymM14IjyKh5Ps2B1EeH6pyS3hV1K0kHfaqx5NF1B6p4CW1tGMSvqjr9KSfjWXKquhFOWetKWoV0Y/FRLkWeWigkl9TMYg6Ax2JnD5qxZ8kBlYQLhmrXaUCn+VA9ZHt+3PHyohhmwJ8Bs/bJK9U9QZWZnbhrXf5Ubkfzla+4T5nzv68q7Qu/yE3AyL8XtwvrQ6ZQMhTabtx3Ljce7lGW/hsR6xNeOAv3kF7ME4gXO44rfnkVEGdQKxr3ZLm7RjMdD3029YQ2Z+p7uSNpU06d7cxWYTLUd0kiXDQEnNhD8xxsV0xv4c4uUKXl9dAXi9q8FAq7qG9S+bL4ko7ZyQiBFuG9tAoK5BY9zn1BYUD5XtR0rXQyLGec8acevJyi4rQuoGnRTvYiGF4JLQ4JhjSkkAEFmszt2bMuXdbJnWPYU+06UssrJBpLflcFPUwICcn0HfggyWIcAmkXa3vq1UsmNujXNb4UkVwSZObFNrr5q6i5lpa9TJ1woUn8D1mFyeznWho63XumTj6urmWtNxYxYLVYEUdTj1Fd0PzqdOUQCMjDg05ez16fy0MjUBozONSha+WZSB5v4lcxyRjscsuS8ayptT+WPOPSqb9dbcxt7P2sP9H3wok1LTSyblRcgeRzogN3HuwTUvmcxV0zafEYMtlkx1ZwCLW+z7fUDWliZNtrsjZ+7llUxszCXV2xRwSJtCa8dxo55Lu/ZFFsgTjY2yXMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(346002)(136003)(38070700005)(38100700002)(8676002)(122000001)(86362001)(82960400001)(4326008)(66446008)(66946007)(76116006)(66476007)(64756008)(66556008)(33656002)(83380400001)(186003)(6506007)(7696005)(9686003)(71200400001)(966005)(26005)(478600001)(2906002)(6636002)(316002)(54906003)(55016003)(110136005)(30864003)(41300700001)(8936002)(5660300002)(52536014)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HJktGOMy288BgGylWXQyOt8ei7DuxB7IuMyoJ3XG22iucaKhB2YQCAQVrfai?=
 =?us-ascii?Q?mfX62kkIWvfdpjN4P/Og0wVDGy3Bk6lbq8oGq31gZq+anFextAV7BL1wfCsj?=
 =?us-ascii?Q?VDyzinPMEfkCHUTUzg727hifnwmgln5eC9qhrmkgP2E21Tx2W02C/Y+jBQI6?=
 =?us-ascii?Q?Atm8MM0y2+anAnZzBjxLpY20eaZ8b4yRc2axmpkG9K+Wyz4Q39itaJQuvmxb?=
 =?us-ascii?Q?dqNrDQm6MY+Uxj+jlAuhT3zMLJ0ztiUidFWkejDK82DLV47YTM01g9jfqf2h?=
 =?us-ascii?Q?L/yF46EBsHd+Hn6rT92ST4rj207DHbFqtovS422WCQ8/yvcz3+zVjyZ28kK5?=
 =?us-ascii?Q?b6M+m5+fX3uuSS1kqTlqkRpJ9hm0zRc+C5X6bAarBKj+CiLYUcUtG6V+DhBM?=
 =?us-ascii?Q?EmrGDJm8Atfm+9PCfyc09I1Sx2oPTnY/WmhFXUdIYxAZam0JqTF4Gc/R75s4?=
 =?us-ascii?Q?OLAHal+LtrE5Jm/J5hNXdsfxd9yd1YSPeNXVVFytALyGoUGesOMzBPuqf/oY?=
 =?us-ascii?Q?+4DWvKOXfG8CJCmoEcXEdUPkOX0xwV2BhU1J6eayMxI2baafVBabdUO6PhAZ?=
 =?us-ascii?Q?IaEdjhWPz0vCvts9ixBs+YV7TGrPNo+CRRdLLoAC4xw0OlS1fBu9em9Ls6CN?=
 =?us-ascii?Q?ZiLmcFcSI3jYzeIX1YlLvob7e+OiPYB8aaFDvo1MJ0CLkj45zxGmC2SDV9k/?=
 =?us-ascii?Q?bDfeZ7oMaCWN7V+ypBh9FBhO/cUOvIZdSG7p+KP9hPc0vcMQbovsmaPvRcP/?=
 =?us-ascii?Q?J1EsYVoi89+cGASPotHib6vobWAK3kq9Q2wPG4UrgNHSGySHB00sLXtJrrb9?=
 =?us-ascii?Q?UH6blj7pfPftpcVlp/U1gxAUkx5lwTIdDD6X5NBmVoBuUrMQ6Z/rI0GRl9yr?=
 =?us-ascii?Q?tOO9DGTwqxeTNarcdkdDbW4/pC6/bkwDOhpUL6D9bIO+OBTonBBwSkicizEZ?=
 =?us-ascii?Q?hZXroDMVMnATWeyxU11h8MEVhEPrctG0x8Jmj6UmXixuOSPBra0qb6qk6P/Y?=
 =?us-ascii?Q?/IFymw2evpcMVHdmXHJ3+NHgIHYmhcXd9iBbUFzqNo5ysOzpltHtIeqHYsOV?=
 =?us-ascii?Q?16bVchbZktE+PgHDvU3ID0B2TsXfjChT5OB0BjVmA6v9iKB+ozwIQjVxi3Sr?=
 =?us-ascii?Q?k+LNDBUoVIswdMXeyWbMpvq+JuH3rDW11nL0s3Pc3+pdSTqzqCS6SDLs83+o?=
 =?us-ascii?Q?4+3+CLEc86EjVVH0uP3csL8Wi4CmQY3i/1eCzISierRmM6bL+RC+Y0zfRmqF?=
 =?us-ascii?Q?j63Y4YrpeCUbDvzf4DefNTawofmXe7hGGDufB3InWiGdocv8BbdJVypRlKSf?=
 =?us-ascii?Q?tH3XaAiy1sn6/EtUbqTeHlqxbLqr4ArpDbAqAbpgp4KYhJS9cpBDBZ/TyhB7?=
 =?us-ascii?Q?F7bh/ZOKlPa7ot3a8ZB87tfdCcG80B8Ut1WeX40pb7vrP1tsBsfRpnJf7Lba?=
 =?us-ascii?Q?bYesjGbE6GoDfZcb1tKPR/zW3ShAAv6efmm7GIzYxU7OvBLAlUgTBPUluzoV?=
 =?us-ascii?Q?MJFSl3hBDHQBRPJBgPrQHZofb1bAUsQ+FmXgWsO8k/8vExhqKEta0+pSDsMr?=
 =?us-ascii?Q?OnR3YUwOdkMhhz9nQdtuJFs0oMUk1vaL3ASiEfHd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf2f39a-c428-4bd0-4cd1-08da93ea78f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2022 11:40:48.7293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqgEEhOX1HcVgVKR7rBY1xN3egzsOtJVVU+DsEnbjZ31KI3aRAGlwpSCcJhcFT9Y+GuYoSz84htsFyRK7TwOPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4827
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: machine_kexec_file.c:undefined reference to `__tsan_memset'
>=20
> Hi Intel folks,
>=20
> On Sun, Sep 11, 2022 at 07:24:28PM +0800, kernel test robot wrote:
> > Hi Jason,
> >
> > FYI, the error/warning was bisected to this commit, please ignore it if=
 it's irrelevant.
>=20
> Please do not report any more instances of undefined references to
> __tsan_mem*() to kernel developers. It is a compiler change that causes

Got it, sorry for the noise, we will ignore this error asap.

> this, kernel changes cannot be responsible for it so it is just going to
> cause unnecessary noise and concern.
>=20
> A patch series to fix this is a work in progress:
>=20
> https://github.com/ClangBuiltLinux/linux/issues/1704
> https://lore.kernel.org/20220909073840.45349-1-elver@google.com/
>=20
> Cheers,
> Nathan
>=20
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   b96fbd602d35739b5cdb49baa02048f2c41fdab1
> > commit: b7133757da4c4c17d625970f6da3d76af12a8867 crypto: s390 - do not =
depend on CRYPTO_HW for SIMD implementations
> > date:   9 weeks ago
> > config: s390-randconfig-r044-20220909 (https://download.01.org/0day-ci/=
archive/20220911/202209111930.zTjXeajS-
> lkp@intel.com/config)
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 15=
46df49f5a6d09df78f569e4137ddb365a3e827)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install s390 cross compiling tool for clang build
> >         # apt-get install binutils-s390x-linux-gnu
> >         #
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Db7133757da4c4c17d625970f6da3d76af12a8867
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kerne=
l/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout b7133757da4c4c17d625970f6da3d76af12a8867
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
W=3D1 O=3Dbuild_dir ARCH=3Ds390 SHELL=3D/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    s390x-linux-ld: arch/s390/kernel/dumpstack.o: in function `show_regs=
':
> >    dumpstack.c:(.text+0x674): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch/s390/kernel/dumpstack.o: in function `die':
> >    dumpstack.c:(.text+0x892): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 1210904
> >    arch/s390/kernel/guarded_storage.o: in function `__se_sys_s390_guard=
ed_storage':
> >    guarded_storage.c:(.text+0x53e): undefined reference to `__tsan_mems=
et'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 1864652
> >    arch/s390/kernel/sthyi.o:sthyi.c:(.text+0xdc): more undefined refere=
nces to `__tsan_memset' follow
> >    s390x-linux-ld: arch/s390/kernel/sthyi.o: in function `sthyi_fill':
> >    sthyi.c:(.text+0x206): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: sthyi.c:(.text+0x238): undefined reference to `__tsa=
n_memcpy'
> >    s390x-linux-ld: sthyi.c:(.text+0x2ea): undefined reference to `__tsa=
n_memset'
> >    s390x-linux-ld: sthyi.c:(.text+0xbf6): undefined reference to `__tsa=
n_memcpy'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 9927
> >    arch/s390/kernel/ipl_vmparm.o: in function `ipl_block_get_ascii_vmpa=
rm':
> >    ipl_vmparm.c:(.text+0x6c): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 95
> >    arch/s390/kernel/unwind_bc.o: in function `__unwind_start':
> >    unwind_bc.c:(.text+0x5e4): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: DWARF error: invalid or unhandled FORM value: 0x23
> >    arch/s390/kernel/smp.o: in function `smp_ctl_set_clear_bit':
> >    smp.c:(.text+0x15a4): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch/s390/kernel/smp.o: in function `smp_ctl_bit_cal=
lback':
> >    smp.c:(.text+0x16dc): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch/s390/kernel/smp.o: in function `__cpu_up':
> >    smp.c:(.text+0x2296): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: smp.c:(.text+0x22a8): undefined reference to `__tsan=
_memset'
> >    s390x-linux-ld: smp.c:(.text+0x25aa): undefined reference to `__tsan=
_memset'
> >    s390x-linux-ld: arch/s390/kernel/smp.o: in function `__cpu_disable':
> >    smp.c:(.text+0x2a28): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 8626
> >    arch/s390/kernel/stacktrace.o: in function `arch_stack_walk':
> >    stacktrace.c:(.text+0x38): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch/s390/kernel/stacktrace.o: in function `arch_sta=
ck_walk_reliable':
> >    stacktrace.c:(.text+0x134): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 73
> >    arch/s390/kernel/nospec-sysfs.o: in function `cpu_show_spectre_v1':
> >    nospec-sysfs.c:(.text+0x2a): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/kernel/nospec-sysfs.o: in function `cpu_sh=
ow_spectre_v2':
> >    nospec-sysfs.c:(.text+0x9e): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: nospec-sysfs.c:(.text+0xbe): undefined reference to =
`__tsan_memcpy'
> >    s390x-linux-ld: nospec-sysfs.c:(.text+0xde): undefined reference to =
`__tsan_memcpy'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 2692
> >    arch/s390/kernel/module.o: in function `module_frob_arch_sections':
> >    module.c:(.text+0x478): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 123
> >    arch/s390/kernel/kprobes.o: in function `copy_instruction':
> >    kprobes.c:(.text+0x12c): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/kernel/kprobes.o: in function `arch_prepar=
e_kprobe':
> >    kprobes.c:(.text+0x5fa): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 11596
> >    arch/s390/kernel/ftrace.o: in function `ftrace_plt_init':
> >    ftrace.c:(.init.text+0x50): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 274
> >    arch/s390/kernel/crash_dump.o: in function `elfcorehdr_alloc':
> >    crash_dump.c:(.text+0xa4a): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: crash_dump.c:(.text+0xb10): undefined reference to `=
__tsan_memset'
> >    s390x-linux-ld: crash_dump.c:(.text+0xb9c): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xbb8): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xc80): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xc9c): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xd2a): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/kernel/crash_dump.o:crash_dump.c:(.text+0x=
d46): more undefined references to `__tsan_memcpy'
> follow
> >    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcoreh=
dr_alloc':
> >    crash_dump.c:(.text+0xdb2): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: crash_dump.c:(.text+0xdc4): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xdd6): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xde8): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xe08): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xe7c): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xe98): undefined reference to `=
__tsan_memset'
> >    s390x-linux-ld: crash_dump.c:(.text+0xebc): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xece): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xee0): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xef2): undefined reference to `=
__tsan_memset'
> >    s390x-linux-ld: crash_dump.c:(.text+0xf7c): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0xfb8): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0x104e): undefined reference to =
`__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0x1118): undefined reference to =
`__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.text+0x11e2): undefined reference to =
`__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/kernel/crash_dump.o:crash_dump.c:(.text+0x=
12a8): more undefined references to `__tsan_memcpy'
> follow
> >    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcoreh=
dr_alloc':
> >    crash_dump.c:(.text+0x15d0): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcoreh=
dr_read':
> >    crash_dump.c:(.text+0x18b0): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcoreh=
dr_read_notes':
> >    crash_dump.c:(.text+0x1920): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `get_vmco=
reinfo_old':
> >    crash_dump.c:(.text+0x197e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: crash_dump.c:(.text+0x1ade): undefined reference to =
`__tsan_memset'
> >    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `save_are=
a_add_regs':
> >    crash_dump.c:(.init.text+0x182): undefined reference to `__tsan_memc=
py'
> >    s390x-linux-ld: crash_dump.c:(.init.text+0x194): undefined reference=
 to `__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.init.text+0x1a6): undefined reference=
 to `__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.init.text+0x1b8): undefined reference=
 to `__tsan_memcpy'
> >    s390x-linux-ld: crash_dump.c:(.init.text+0x1ca): undefined reference=
 to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/kernel/crash_dump.o:crash_dump.c:(.init.te=
xt+0x2ea): more undefined references to
> `__tsan_memcpy' follow
> >    s390x-linux-ld: DWARF error: could not find abbrev number 80348352
> >    arch/s390/kernel/machine_kexec_file.o: in function `kexec_file_add_c=
omponents':
> > >> machine_kexec_file.c:(.text+0x30): undefined reference to `__tsan_me=
mset'
> > >> s390x-linux-ld: machine_kexec_file.c:(.text+0x110): undefined refere=
nce to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/kernel/machine_kexec_file.o: in function `=
kexec_file_add_initrd':
> >    machine_kexec_file.c:(.text+0x270): undefined reference to `__tsan_m=
emset'
> >    s390x-linux-ld: arch/s390/kernel/machine_kexec_file.o: in function `=
kexec_file_add_purgatory':
> >    machine_kexec_file.c:(.text+0x3e0): undefined reference to `__tsan_m=
emset'
> >    s390x-linux-ld: arch/s390/kernel/machine_kexec_file.o: in function `=
kexec_file_add_ipl_report':
> >    machine_kexec_file.c:(.text+0x5e0): undefined reference to `__tsan_m=
emset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 4017695074
> >    arch/s390/kernel/kexec_image.o: in function `kexec_file_add_kernel_i=
mage':
> > >> kexec_image.c:(.text+0x70): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 87
> >    arch/s390/kernel/kexec_elf.o: in function `kexec_file_add_kernel_elf=
':
> > >> kexec_elf.c:(.text+0x352): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 1885236
> >    arch/s390/kernel/trace.o:trace.c:(.text+0xba): more undefined refere=
nces to `__tsan_memset' follow
> >    s390x-linux-ld: DWARF error: could not find abbrev number 10151
> >    arch/s390/mm/extmem.o: in function `segment_type':
> >    extmem.c:(.text+0x550): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/mm/extmem.o: in function `segment_load':
> >    extmem.c:(.text+0x60e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: extmem.c:(.text+0x85c): undefined reference to `__ts=
an_memset'
> >    s390x-linux-ld: extmem.c:(.text+0xc80): undefined reference to `__ts=
an_memset'
> >    s390x-linux-ld: extmem.c:(.text+0xfe4): undefined reference to `__ts=
an_memcpy'
> >    s390x-linux-ld: arch/s390/mm/extmem.o: in function `segment_modify_s=
hared':
> >    extmem.c:(.text+0x1750): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: extmem.c:(.text+0x1998): undefined reference to `__t=
san_memset'
> >    s390x-linux-ld: arch/s390/mm/extmem.o: in function `segment_unload':
> >    extmem.c:(.text+0x1d4e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: extmem.c:(.text+0x1f96): undefined reference to `__t=
san_memset'
> >    s390x-linux-ld: arch/s390/mm/extmem.o: in function `segment_save':
> >    extmem.c:(.text+0x21ac): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch/s390/mm/extmem.o:extmem.c:(.text+0x21be): more =
undefined references to `__tsan_memset' follow
> >    s390x-linux-ld: DWARF error: could not find abbrev number 3642308623
> >    arch/s390/mm/maccess.o: in function `s390_kernel_write':
> >    maccess.c:(.text+0x4e): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/mm/maccess.o: in function `memcpy_absolute=
':
> >    maccess.c:(.text+0x462): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: maccess.c:(.text+0x4ca): undefined reference to `__t=
san_memcpy'
> >    s390x-linux-ld: arch/s390/mm/maccess.o: in function `xlate_dev_mem_p=
tr':
> >    maccess.c:(.text+0x962): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: maccess.c:(.text+0x9d2): undefined reference to `__t=
san_memcpy'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 704951
> >    arch/s390/mm/pgalloc.o: in function `page_table_free':
> >    pgalloc.c:(.text+0xc3a): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch/s390/mm/pgalloc.o: in function `__tlb_remove_ta=
ble':
> >    pgalloc.c:(.text+0x10c8): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 12578
> >    arch/s390/mm/extable.o: in function `fixup_exception':
> >    extable.c:(.text+0x20e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 12654
> >    arch/s390/mm/dump_pagetables.o: in function `ptdump_check_wx':
> >    dump_pagetables.c:(.text+0x5a): undefined reference to `__tsan_memse=
t'
> >    s390x-linux-ld: dump_pagetables.c:(.text+0xa0): undefined reference =
to `__tsan_memset'
> >    s390x-linux-ld: dump_pagetables.c:(.text+0xb8): undefined reference =
to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/mm/dump_pagetables.o: in function `pt_dump=
_init':
> >    dump_pagetables.c:(.text+0x7c8): undefined reference to `__tsan_memc=
py'
> >    s390x-linux-ld: dump_pagetables.c:(.text+0x7f8): undefined reference=
 to `__tsan_memcpy'
> >    s390x-linux-ld: dump_pagetables.c:(.text+0x82a): undefined reference=
 to `__tsan_memcpy'
> >    s390x-linux-ld: dump_pagetables.c:(.text+0x85e): undefined reference=
 to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/mm/dump_pagetables.o: in function `ptdump_=
show':
> >    dump_pagetables.c:(.text+0x96e): undefined reference to `__tsan_mems=
et'
> >    s390x-linux-ld: dump_pagetables.c:(.text+0x9b4): undefined reference=
 to `__tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 10066
> >    arch/s390/mm/gmap.o: in function `gmap_put':
> >    gmap.c:(.text+0x6a4): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: gmap.c:(.text+0x6b6): undefined reference to `__tsan=
_memset'
> >    s390x-linux-ld: gmap.c:(.text+0x7d6): undefined reference to `__tsan=
_memset'
> >    s390x-linux-ld: arch/s390/mm/gmap.o:gmap.c:(.text+0x7e8): more undef=
ined references to `__tsan_memset' follow
> >    s390x-linux-ld: DWARF error: could not find abbrev number 1066736
> >    arch/s390/crypto/sha256_s390.o: in function `sha256_export':
> > >> sha256_s390.c:(.text+0x140): undefined reference to `__tsan_memcpy'
> > >> s390x-linux-ld: sha256_s390.c:(.text+0x152): undefined reference to =
`__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/sha256_s390.o: in function `sha256_=
import':
> >    sha256_s390.c:(.text+0x1c4): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: sha256_s390.c:(.text+0x1d6): undefined reference to =
`__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/sha256_s390.o: in function `sha256_=
s390_init':
> > >> sha256_s390.c:(.init.text+0x74): undefined reference to `__tsan_mems=
et'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 87
> >    arch/s390/crypto/sha_common.o: in function `s390_sha_update':
> > >> sha_common.c:(.text+0xa6): undefined reference to `__tsan_memcpy'
> > >> s390x-linux-ld: sha_common.c:(.text+0x13e): undefined reference to `=
__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/sha_common.o: in function `s390_sha=
_final':
> >    sha_common.c:(.text+0x28e): undefined reference to `__tsan_memcpy'
> > >> s390x-linux-ld: sha_common.c:(.text+0x2a4): undefined reference to `=
__tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 1238827
> >    arch/s390/crypto/sha3_512_s390.o: in function `sha3_512_init':
> > >> sha3_512_s390.c:(.text+0x30): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch/s390/crypto/sha3_512_s390.o: in function `sha3_=
512_export':
> > >> sha3_512_s390.c:(.text+0xc0): undefined reference to `__tsan_memcpy'
> > >> s390x-linux-ld: sha3_512_s390.c:(.text+0xd2): undefined reference to=
 `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/sha3_512_s390.o: in function `sha3_=
512_import':
> >    sha3_512_s390.c:(.text+0x17c): undefined reference to `__tsan_memcpy=
'
> >    s390x-linux-ld: sha3_512_s390.c:(.text+0x18e): undefined reference t=
o `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/sha3_512_s390.o: in function `sha3_=
384_init':
> >    sha3_512_s390.c:(.text+0x1f0): undefined reference to `__tsan_memset=
'
> >    s390x-linux-ld: arch/s390/crypto/sha3_512_s390.o: in function `sha3_=
384_import':
> >    sha3_512_s390.c:(.text+0x29c): undefined reference to `__tsan_memcpy=
'
> >    s390x-linux-ld: sha3_512_s390.c:(.text+0x2ae): undefined reference t=
o `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/sha3_512_s390.o: in function `init'=
:
> > >> sha3_512_s390.c:(.init.text+0x74): undefined reference to `__tsan_me=
mset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 43
> >    arch/s390/crypto/crc32-vx.o: in function `crc32le_vx_update':
> > >> crc32-vx.c:(.text+0xa8): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/crc32-vx.o: in function `crc32le_vx=
_finup':
> >    crc32-vx.c:(.text+0x288): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/crc32-vx.o: in function `crc32le_vx=
_digest':
> >    crc32-vx.c:(.text+0x424): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/crc32-vx.o: in function `crc32be_vx=
_update':
> >    crc32-vx.c:(.text+0x658): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/crc32-vx.o: in function `crc32be_vx=
_finup':
> >    crc32-vx.c:(.text+0x838): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/crypto/crc32-vx.o:crc32-vx.c:(.text+0x9d4)=
: more undefined references to `__tsan_memcpy' follow
> >    s390x-linux-ld: DWARF error: could not find abbrev number 1172571
> >    arch/s390/crypto/arch_random.o: in function `s390_arch_get_random_lo=
ng':
> >    arch_random.c:(.text+0x2ce): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch_random.c:(.text+0x30c): undefined reference to =
`__tsan_memset'
> >    s390x-linux-ld: arch/s390/crypto/arch_random.o: in function `arch_rn=
g_refill_buffer':
> >    arch_random.c:(.text+0x408): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: arch_random.c:(.text+0x442): undefined reference to =
`__tsan_memset'
> >    s390x-linux-ld: arch/s390/crypto/arch_random.o: in function `s390_ar=
ch_random_init':
> >    arch_random.c:(.init.text+0x2c): undefined reference to `__tsan_mems=
et'
> >    s390x-linux-ld: arch/s390/crypto/arch_random.o:arch_random.c:(.init.=
text+0x80): more undefined references to
> `__tsan_memset' follow
> >    s390x-linux-ld: DWARF error: could not find abbrev number 1403790468
> >    arch/s390/net/bpf_jit_comp.o: in function `bpf_int_jit_compile':
> >    bpf_jit_comp.c:(.text+0x208): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: bpf_jit_comp.c:(.text+0x270): undefined reference to=
 `__tsan_memset'
> >    s390x-linux-ld: bpf_jit_comp.c:(.text+0x45e): undefined reference to=
 `__tsan_memcpy'
> >    s390x-linux-ld: arch/s390/net/bpf_jit_comp.o: in function `jit_fill_=
hole':
> >    bpf_jit_comp.c:(.text+0x9744): undefined reference to `__tsan_memset=
'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 8135
> >    kernel/fork.o: in function `trace_event_raw_event_task_newtask':
> >    fork.c:(.text+0x14e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: fork.c:(.text+0x204): undefined reference to `__tsan=
_memcpy'
> >    s390x-linux-ld: kernel/fork.o: in function `trace_event_raw_event_ta=
sk_rename':
> >    fork.c:(.text+0x28e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: fork.c:(.text+0x344): undefined reference to `__tsan=
_memcpy'
> >    s390x-linux-ld: kernel/fork.o: in function `vm_area_alloc':
> >    fork.c:(.text+0x4b0): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/fork.o: in function `vm_area_dup':
> >    fork.c:(.text+0x58a): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: fork.c:(.text+0x5a2): undefined reference to `__tsan=
_memcpy'
> >    s390x-linux-ld: fork.c:(.text+0x5d8): undefined reference to `__tsan=
_memset'
> >    s390x-linux-ld: kernel/fork.o: in function `arch_dup_task_struct':
> >    fork.c:(.text+0xe40): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/fork.o: in function `mm_alloc':
> >    fork.c:(.text+0xeea): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/fork.o: in function `mm_init':
> >    fork.c:(.text+0xf3c): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: fork.c:(.text+0x1002): undefined reference to `__tsa=
n_memset'
> >    s390x-linux-ld: kernel/fork.o: in function `copy_process':
> >    fork.c:(.text+0x2878): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: fork.c:(.text+0x2994): undefined reference to `__tsa=
n_memset'
> >    s390x-linux-ld: kernel/fork.o:fork.c:(.text+0x2bfc): more undefined =
references to `__tsan_memset' follow
> >    s390x-linux-ld: kernel/fork.o: in function `dup_mm':
> >    fork.c:(.text+0x43c2): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: fork.c:(.text+0x4928): undefined reference to `__tsa=
n_memcpy'
> >    s390x-linux-ld: fork.c:(.text+0x4940): undefined reference to `__tsa=
n_memcpy'
> >    s390x-linux-ld: fork.c:(.text+0x497a): undefined reference to `__tsa=
n_memset'
> >    s390x-linux-ld: kernel/fork.o: in function `create_io_thread':
> >    fork.c:(.text+0x4e74): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/fork.o: in function `kernel_clone':
> >    fork.c:(.text+0x4ef8): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/fork.o: in function `kernel_thread':
> >    fork.c:(.text+0x54a4): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/fork.o: in function `user_mode_thread':
> >    fork.c:(.text+0x5534): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/fork.o:fork.c:(.text+0x55a8): more undefined =
references to `__tsan_memset' follow
> >    s390x-linux-ld: kernel/fork.o: in function `sysctl_max_threads':
> >    fork.c:(.text+0x6068): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/fork.o: in function `dup_task_struct':
> >    fork.c:(.text+0x6772): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/fork.o: in function `copy_sighand':
> >    fork.c:(.text+0x6934): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/fork.o: in function `copy_signal':
> >    fork.c:(.text+0x6c66): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/fork.o: in function `copy_seccomp':
> >    fork.c:(.text+0x6eaa): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/fork.o: in function `copy_clone_args_from_use=
r':
> >    fork.c:(.text+0x74a4): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: fork.c:(.text+0x7552): undefined reference to `__tsa=
n_memset'
> >    s390x-linux-ld: fork.c:(.text+0x766a): undefined reference to `__tsa=
n_memset'
> >    s390x-linux-ld: fork.c:(.text+0x78c0): undefined reference to `__tsa=
n_memset'
> >    s390x-linux-ld: kernel/fork.o: in function `fork_init':
> >    fork.c:(.init.text+0x1a0): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/fork.o: in function `fork_idle':
> >    fork.c:(.init.text+0x2b0): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: fork.c:(.init.text+0x316): undefined reference to `_=
_tsan_memset'
> >    s390x-linux-ld: fork.c:(.init.text+0x338): undefined reference to `_=
_tsan_memset'
> >    s390x-linux-ld: fork.c:(.init.text+0x36a): undefined reference to `_=
_tsan_memset'
> >    s390x-linux-ld: fork.c:(.init.text+0x39c): undefined reference to `_=
_tsan_memset'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 14327
> >    kernel/panic.o: in function `print_tainted':
> >    panic.c:(.text+0x2de): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: panic.c:(.text+0x416): undefined reference to `__tsa=
n_memcpy'
> >    s390x-linux-ld: kernel/panic.o: in function `warn_slowpath_fmt':
> >    panic.c:(.text+0xbac): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/panic.o: in function `panic':
> >    panic.c:(.text.unlikely.+0x2c): undefined reference to `__tsan_memse=
t'
> >    s390x-linux-ld: DWARF error: could not find abbrev number 51
> >    kernel/cpu.o: in function `trace_event_raw_event_cpuhp_enter':
> >    cpu.c:(.text+0x242): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cpu.o: in function `trace_event_raw_event_cpu=
hp_multi_enter':
> >    cpu.c:(.text+0x352): undefined reference to `__tsan_memset'
> > ..
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> >
