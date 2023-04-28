Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DBF6F1008
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbjD1Bgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 21:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjD1Bgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:36:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DB22D67
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 18:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682645805; x=1714181805;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x7+MdjbHscK5mzkhqSKffBgB/9/Gnv584niJ/kqkpO4=;
  b=ILnyEFRcIAMZbukIPRy8eYV1xOyBjd0cFtwuyqAjZ8v5IMZlh0BjaDSX
   gs7c8ePdg+bp0wfNMc5w+MP7F8RLimv/cov0vqrNn2dD/U8p2Cg7Tm1Cb
   PdGbm0HANjypXFC5W/yt0E3EBgTwpbf5ZZ3hy9Vd3ocrxwHTrSb1CdrXT
   AJwo+qoC04Pjom8BzzvPUxN40ku9UfTgMAW3mJw8aaAaqjz8HH81pdH+d
   Hq48IEEn3LpJkP4kKlemE4LMYILFkKBzuHo1N0vHHCSzrOpt4Ry1b+5Nm
   SiOxjjZ86EOOXt0tOJjCBWFQLy13nRdfxDoOFyqm9lOk/EeemMxbOjY2T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="433903521"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="xz'341?scan'341,208,341";a="433903521"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 18:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024381754"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="xz'341?scan'341,208,341";a="1024381754"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 18:36:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 18:36:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 18:36:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 18:36:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 18:36:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfvZ6Dwd+EogPY8bgY8irohXfYz/KTKyzxuF1zEq+9zHiVwOGzUF2PNnHBxqXcn0vQ1AWcoBXcqA8MHu0tNSrkN30zX6gzRYrWe88ZYPgUoANHHENvF7PKrmouhJN0MlVUfzXXb/DWAiAAhIlx8lA/54QeOentL/7Sn4KShjsXlZpqxespJw7Eu2KF5p1DFYd92VgJYwBwEKumntGZi0V7sISQR41xHG44oKEqcs6oEnKLUDkNSkhKl7K5PR5R3SHTt3aRJ94hMsMEbc3w3u8iJVf90P5eJip0n98c0np2YYqSpqlMGmE1cl8sjqqi8Ce4MjM/Sd2J9dC6DKa97Srw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbiYdFh+Hd42/I89eBtheZLjRxK4tA754nVfwsBgdmI=;
 b=Ajft86qi9N5NlnjqG2rFk/ACahLz1inmK5WgXcBBr6yviEi+yr0+mKBFCCP0B/zQgLBjKc2KPG751hj9UGTpDo9nsWg6BjUpF/pBceW6/MUFP8AiNrhCgxOJVyEFiaxjwwqg45zRMf2OpQjrNQX+HAIqNd2bRvdeIUDCf6WyJAYb99ZtLvZBWCfYq18Am0/xsTmpeYv7lIJNg/dJP+9wBVD9eUhMXSAKr+qQA49OXyxr6wMwn4XldlJcvb28Vgujr8IDHzS13Kb7NgFKtwZIorU3viR+2KoJwXrMpHMu+UU+AmxENMnKNV8Q1SJPg+xbjvR8y0vqsGCCmOP7OHOH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23; Fri, 28 Apr 2023 01:36:40 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 01:36:40 +0000
Date:   Fri, 28 Apr 2023 09:33:21 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Shanker Donthineni <sdonthineni@nvidia.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael Walle" <michael@walle.cc>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors
 management
Message-ID: <ZEsiYbi8dorXTI5t@yujie-X299>
References: <202304251035.19367560-yujie.liu@intel.com>
 <87a5yuzvzd.ffs@tglx>
Content-Type: multipart/mixed; boundary="64lya1TZ9AoZHSq5"
Content-Disposition: inline
In-Reply-To: <87a5yuzvzd.ffs@tglx>
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS0PR11MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 0899bc74-c193-4732-0b2f-08db47890366
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeXltdcq6/Fpi++rf2CX4H+/ehmfj33o91fH8oWNmwjP3pA10N4IgLqNJMSj7S9ZGqRcDCcvSBbCd6yHmMVNtIJ3q9hrnH1EujoHf020l9v8jj+KJeRvAqahyi76aAyNJP9xjO1LG9WtgCDEJWPPzsTPoyFB+23sSnraBOja7IpIVwUeCTS52jF+AJhzHo39EySNSrWDrbUePZZc9nXjx1ACq6yLvuVKCBXV0YJZL6o2oS8eLOenDq0GMYl7Bs6OMtJXVeAlIDn/rZleQvd6EHmUhRQPDPPmoXLTrN1zq6VIZmpQ1wPvtkF/lwR87cr13OWihEZ+gX4ykFEMJMelKOfDWcmi0NSmUiX16+Xf2Kia3Qn1PoXLiJ8Z9osWTM+ORx9UfrLCWBD4OViOfpi+I9skFYctVBGzG8GMswMtR+XrndGpLBAlQqhiZSiAy8ks5wVm7tRf95w0vMKo36cC4tKjgbaCbHGGPBOOJ3c8pYIPSES/jdqFfS0Kt4LOmoIxAE2Lxh44iGMpnbhjMczgGB7CQKkHzDv+wXW9+DjIhR9AYCxMW6yY2yKLUDL+I01fE0Czav/zREXCUExnravXPPHXWMOjPurkmfz+8VwprHAcLa8ufFOjbI5gV9hSp4P03V5SKtHv3usOr2+aZEWrrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(9686003)(186003)(6506007)(6512007)(26005)(83380400001)(84970400001)(6916009)(44832011)(66946007)(66476007)(66556008)(82960400001)(38100700002)(41300700001)(316002)(5660300002)(4326008)(2906002)(235185007)(86362001)(54906003)(478600001)(45080400002)(966005)(8936002)(8676002)(6486002)(6666004)(33716001)(44144004)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ykQgEkTu2bpANRG5nQcL+RRRDx2xAbQfiG/rSHfiPZCEOghnnzwPnVa/fBjY?=
 =?us-ascii?Q?SpZt++To0Vp85goCWGjaiaNDjvH0HMwTUY8P+NRLY/2RXsaoJm1EAL+Bn9lv?=
 =?us-ascii?Q?gh9V0snFg1WWOjVDQ9wTOE93Yu1JmVLzfBauSFo7BOPs/8I4ef2KimAAoc8I?=
 =?us-ascii?Q?Ylq9WE8+aGFqHHJICMffs8d0530Is/I3lHnQu8wSnEWk8hkBvDYLibDUbUSy?=
 =?us-ascii?Q?vsW+dJo1tbi+i3ipk78d7UFpCvSm5sr46tkiow2/vIYRaMgJrBkcLSaVZBQN?=
 =?us-ascii?Q?6YsOIFpwHuVge1++b1lWRAUJ2UtaKmpwj6DtxCaibEU8L3j6/xszTSMuwHgA?=
 =?us-ascii?Q?LjHcvGMsm3Gh2Ofk0214SHK9ReoZofonXHMPjmfO6FFXIBbiOfOD0Z0Mojut?=
 =?us-ascii?Q?sPt0YJusuInCDypxf8XRfg2YjPvLObR1QmEz5O7mJR/NG6wnYWIkyzPB57Dl?=
 =?us-ascii?Q?ma67THdx1Dwg+hUmROGla80ayCBNXtIjFabowlcXh2vpL0mMR8xX3M6wn1O2?=
 =?us-ascii?Q?dq23j/ItDUal5okqjr0fpu7mM762Y1B2waFInIZ0AtGz0pog0l07F+2SrRmW?=
 =?us-ascii?Q?MLNesSUzboopnxB6BFal8Wx/xyGI7etUpexZIVJKuexI0vvcTHTupS77dtLb?=
 =?us-ascii?Q?1jb+qF2EAHM8imspGM9IGnKeZjTTBa/rcF1a2oyIt/q22Xw3HfWrBNLAtTxx?=
 =?us-ascii?Q?Il/lGFg3sOWMlc/iBTXPUwhYSi8cwIcP0TnfnSaEPwTTXZl+gjaTX75WnvPe?=
 =?us-ascii?Q?OIS3t3TMQvfkrPNc6+Xag1vZSfWS/gLA1+cy3Pa8wixwpsi3cpYJ/lK0Ls+6?=
 =?us-ascii?Q?T0e+aQfX3sgQSvRGSe5Hruz0MFHhChg8kNjn72GRom4PwwVo2ojea7aMxn3B?=
 =?us-ascii?Q?9SoRJFW2GpwHK++xTbPtY9perT+P/MPmi59ylK6dmeEtTN8dg/SKE9domebR?=
 =?us-ascii?Q?fyLiecFcqZcyRuT3D92tlkzLPCBzkhPUkQ13Aee4ZRS4Sm4rbjMxtnSvHFeO?=
 =?us-ascii?Q?ZPIlooea4cp9WZ7hN9fp2flIeJKJ6qUu2e95UMN1hBCSy32YAnhXb3tLDUbQ?=
 =?us-ascii?Q?L0nrMSzAB8nXlRqag5qgMh6dUDFAKqQ6pmPOHZzYmK/Sd/Hfc6BvehilYAbH?=
 =?us-ascii?Q?NEkuzqIG6kmT2kU+2kKrfGLxzFF1ERpouKDifeBjbPWUJOoYJw2TF5E7ww67?=
 =?us-ascii?Q?0+FfRlC5th45lUce8sUXSK8904IoFk4kRVeHAXlr827HoONElLu9hssWFhNN?=
 =?us-ascii?Q?DoCJ/0VaToqoDdHLrSOjE+pUaVPpH6aS+7CPkVlZJzciefC8UvLEhFl0whJy?=
 =?us-ascii?Q?ZIVTKwgIEuN6q73hrFtBdiOBlDLHRNsAJCEKt3DpSD4kjNg3U9J5QukNlNLS?=
 =?us-ascii?Q?YekXrZJouPa2YSEPNHplfKDoHfekaeXaTkevTBhZo4lB04CxQ1gaSdmRfPjr?=
 =?us-ascii?Q?s5LwT3a35oAqwmrRJsm/Nnp98st6VEri6q+qLFTOZkdNQhref60kiQBkqQed?=
 =?us-ascii?Q?7a92ugeFKTaVRazAKhU/9LrYbFTwDpMyIXKKeGLEKOxeue1ciUpx12zisZ2N?=
 =?us-ascii?Q?3GZayo4f8EXUO49ZlpVCWJIgcqJdh6fRRkHzkodZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0899bc74-c193-4732-0b2f-08db47890366
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 01:36:40.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMbMXPz+j67DyWSiDjdqwze70T3uvUTRPYUDQZeZl/hKgpd+x5EtYkrrPqdz+/RbXKOlDzMA/nXV6rhJkm7z6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--64lya1TZ9AoZHSq5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Wed, Apr 26, 2023 at 02:08:54PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 25 2023 at 11:16, kernel test robot wrote:
> > kernel test robot noticed "WARNING:at_arch/x86/kernel/apic/ipi.c:#defau=
lt_send_IPI_mask_logical" on:
> >
> > commit: 13eb5c4e7d2fb860d3dc5f63d910e3acf78dfd28 ("[PATCH v3 3/3] genir=
q: Use the maple tree for IRQ descriptors management")
> > url: https://github.com/intel-lab-lkp/linux/commits/Shanker-Donthineni/=
genirq-Use-hlist-for-managing-resend-handlers/20230410-235853
> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 6f3ee0e2=
2b4c62f44b8fa3c8de6e369a4d112a75
> > patch link: https://lore.kernel.org/all/20230410155721.3720991-4-sdonth=
ineni@nvidia.com/
> > patch subject: [PATCH v3 3/3] genirq: Use the maple tree for IRQ
> > descriptors management
>=20
> This happens during CPU hot-unplug.
>=20
> [  206.930774][  T228] block/008 =3D> sdb2 (do IO while hotplugging CPUs)=
           =20
> [  206.935757][ T2086] run blktests block/008 at 2023-04-22 16:27:25
> [  207.199359][ T2086] smpboot: CPU 2 is now offline
>=20
> [  207.468574][   T30] WARNING: CPU: 3 PID: 30 at arch/x86/kernel/apic/ip=
i.c:299 default_send_IPI_mask_logical+0x40/0x44
> [  207.568426][   T30] CPU: 3 PID: 30 Comm: migration/3 Tainted: G S     =
     E      6.2.0-rc4-00051-g13eb5c4e7d2f #1
> [  207.588372][   T30] Stopper: multi_cpu_stop+0x0/0xf0 <- stop_machine_c=
puslocked+0xf5/0x138
> [  207.596649][   T30] EIP: default_send_IPI_mask_logical+0x40/0x44
>=20
> This warns because fixup_irqs() sends an IPI to an offline CPU. In this
> case to CPU3 which just cleared its online bit and is about to vanish:
>=20
> [  207.622147][   T30] EAX: 00000008 EBX: 00000002 ECX: fffffffc EDX: 000=
00022
>=20
> EAX contains the target and ECX the inverted online mask. That's
> probably the ata2 interrupt as that later detects a timeout:
>=20
> [  238.826212][  T174] ata2.00: exception Emask 0x0 SAct 0x3c00000 SErr 0=
x0 action 0x6 frozen
> [  238.834522][  T174] ata2.00: failed command: READ FPDMA QUEUED
> [  238.840378][  T174] ata2.00: cmd 60/08:b0:90:3e:90/00:00:25:00:00/40 t=
ag 22 ncq dma 4096 in
> [  238.840378][  T174]          res 40/00:00:00:00:00/00:00:00:00:00/00 E=
mask 0x4 (timeout)
>=20
> Which means that migrating the interrupt away from the outgoing CPU3
> failed for yet to understand reasons.
>=20
> The patch in question is changing the interrupt descriptor storage and
> with that also the iterator function. But I can't spot anything wrong
> right now.
>=20
> But what I can spot is this:
>=20
> [    0.000000][    T0] Linux version 6.2.0-rc4-00051-g13eb5c4e7d2f
>=20
> IOW, that test is based on some random upstream version, which lacks
> about 30 commits to maple_tree, where 12 of them have 'fix' in the
> commit subject.
>=20
> Can you please retest this on v6.3 and report back when the problem
> persists?

Thanks for your help looking into this problem.

The problem persists when tested on v6.3, but not 100% reproducible.
We ran the test on v6.3 and v6.3+patch each for 20 runs. There are 9
failed runs on v6.3+patch, while v6.3 is all clean. Full dmesg is
attached.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/disk/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/1SSD/i386-debian-10.3-func/debian-11.1-i386-20220923.cgz/lkp-skl-d=
06/block-group-00/blktests

commit:
  v6.3
  32c58fc685e5c ("genirq: Use the maple tree for IRQ descriptors management=
")

            v6.3 32c58fc685e5cd6b5947a5f8e9a
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20          45%           9:20    dmesg.EIP:default_send_IPI_ma=
sk_logical
           :20          45%           9:20    dmesg.WARNING:at_arch/x86/ker=
nel/apic/ipi.c:#default_send_IPI_mask_logical
           :20          45%           9:20    blktests.block/008.fail
           :20          45%           9:20    blktests.block/012.fail


[  214.484584][  T235] block/008 =3D> sdb2 (do IO while hotplugging CPUs)
[  214.484586][  T235]
[  214.489534][ T2125] run blktests block/008 at 2023-04-27 10:06:38
[  214.749748][ T2125] smpboot: CPU 3 is now offline
[  215.009645][   T28] ------------[ cut here ]------------
[ 215.014948][ T28] WARNING: CPU: 2 PID: 28 at arch/x86/kernel/apic/ipi.c:2=
99 default_send_IPI_mask_logical (arch/x86/kernel/apic/ipi.c:299 (discrimin=
ator 1))
[  215.025527][   T28] Modules linked in: loop(E) dm_multipath(E) dm_mod(E)=
 btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_generic=
(E) intel_rapl_msr(E) intel_rapl_common(E) x86_pkg_temp_thermal(E) intel_po=
werclamp(E) sd_mod(E) t10_pi(E) coretemp(E) crc64_rocksoft_generic(E) kvm_i=
ntel(E) crc64_rocksoft(E) crc64(E) kvm(E) irqbypass(E) ipmi_devintf(E) ipmi=
_msghandler(E) crc32_pclmul(E) i915(E) drm_buddy(E) crc32c_intel(E) tpm_inf=
ineon(E) drm_display_helper(E) aesni_intel(E) crypto_simd(E) mei_wdt(E) cec=
(E) tpm_tis(E) cryptd(E) ahci(E) drm_kms_helper(E) psmouse(E) tpm_tis_core(=
E) xhci_pci(E) mei_me(E) i2c_i801(E) rapl(E) syscopyarea(E) wmi_bmof(E) xhc=
i_hcd(E) usbcore(E) intel_cstate(E) libahci(E) evdev(E) serio_raw(E) i2c_sm=
bus(E) sysfillrect(E) sysimgblt(E) intel_uncore(E) tpm(E) video(E) libata(E=
) mei(E) intel_pch_thermal(E) ttm(E) ie31200_edac(E) usb_common(E) rng_core=
(E) wmi(E) acpi_pad(E) button(E) fuse(E) drm(E) configfs(E) autofs4(E) [las=
t unloaded: null_blk(E)]
[  215.112194][   T28] CPU: 2 PID: 28 Comm: migration/2 Tainted: G S       =
   E      6.3.0-00003-g32c58fc685e5 #1
[  215.122171][   T28] Hardware name: HP HP Z238 Microtower Workstation/818=
3, BIOS N51 Ver. 01.63 10/05/2017
[ 215.131716][ T28] Stopper: multi_cpu_stop+0x0/0xf4 <- stop_machine_cpuslo=
cked (kernel/stop_machine.c:429 kernel/stop_machine.c:469 kernel/stop_machi=
ne.c:619)
[ 215.139966][ T28] EIP: default_send_IPI_mask_logical (arch/x86/kernel/api=
c/ipi.c:299 (discriminator 1))
[ 215.145961][ T28] Code: 2b c2 f7 d1 85 c1 75 22 b9 00 08 00 00 e8 cc fb f=
f ff 80 e7 02 74 01 fb 8b 5d fc c9 c3 8d 74 26 00 90 c3 8d b4 26 00 00 00 0=
0 <0f> 0b eb da 3e 8d 74 26 00 a1 64 b8 2b c2 f6 c4 02 75 0d 31 c0 c3
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   2b c2                   sub    %edx,%eax
   2:   f7 d1                   not    %ecx
   4:   85 c1                   test   %eax,%ecx
   6:   75 22                   jne    0x2a
   8:   b9 00 08 00 00          mov    $0x800,%ecx
   d:   e8 cc fb ff ff          call   0xfffffffffffffbde
  12:   80 e7 02                and    $0x2,%bh
  15:   74 01                   je     0x18
  17:   fb                      sti
  18:   8b 5d fc                mov    -0x4(%rbp),%ebx
  1b:   c9                      leave
  1c:   c3                      ret
  1d:   8d 74 26 00             lea    0x0(%rsi,%riz,1),%esi
  21:   90                      nop
  22:   c3                      ret
  23:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   eb da                   jmp    0x8
  2e:   3e 8d 74 26 00          ds lea 0x0(%rsi,%riz,1),%esi
  33:   a1 64 b8 2b c2 f6 c4    movabs 0x7502c4f6c22bb864,%eax
  3a:   02 75
  3c:   0d                      .byte 0xd
  3d:   31 c0                   xor    %eax,%eax
  3f:   c3                      ret

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   eb da                   jmp    0xffffffffffffffde
   4:   3e 8d 74 26 00          ds lea 0x0(%rsi,%riz,1),%esi
   9:   a1 64 b8 2b c2 f6 c4    movabs 0x7502c4f6c22bb864,%eax
  10:   02 75
  12:   0d                      .byte 0xd
  13:   31 c0                   xor    %eax,%eax
  15:   c3                      ret
[  215.165363][   T28] EAX: 00000004 EBX: 00000002 ECX: fffffffc EDX: 00000=
023
[  215.172308][   T28] ESI: 00000023 EDI: c1045a80 EBP: c30fdeb8 ESP: c30fd=
eb4
[  215.179248][   T28] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS:=
 00010002
[  215.186717][   T28] CR0: 80050033 CR2: a95b2f4c CR3: 02400000 CR4: 00350=
6f0
[  215.193662][   T28] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000=
000
[  215.200601][   T28] DR6: fffe0ff0 DR7: 00000400
[  215.205126][   T28] Call Trace:
[ 215.208266][ T28] default_send_IPI_single (arch/x86/kernel/apic/ipi.c:228=
)
[ 215.213396][ T28] apic_retrigger_irq (arch/x86/kernel/apic/vector.c:880)
[ 215.218095][ T28] irq_chip_retrigger_hierarchy (kernel/irq/chip.c:1473)
[ 215.223658][ T28] fixup_irqs (arch/x86/kernel/irq.c:371)
[ 215.227753][ T28] cpu_disable_common (arch/x86/kernel/smpboot.c:1663)
[ 215.232451][ T28] native_cpu_disable (arch/x86/kernel/smpboot.c:1694)
[ 215.237150][ T28] take_cpu_down (kernel/cpu.c:1035)
[ 215.241415][ T28] multi_cpu_stop (kernel/stop_machine.c:240)
[ 215.245766][ T28] cpu_stopper_thread (kernel/stop_machine.c:512)
[ 215.250549][ T28] ? stop_machine_yield+0x4/0x4
[ 215.255246][ T28] smpboot_thread_fn (kernel/smpboot.c:164 (discriminator =
4))
[ 215.259943][ T28] kthread (kernel/kthread.c:376)
[ 215.263688][ T28] ? sort_range (kernel/smpboot.c:107)
[ 215.267858][ T28] ? kthread_complete_and_exit (kernel/kthread.c:331)
[ 215.273334][ T28] ret_from_fork (arch/x86/entry/entry_32.S:770)
[  215.277599][   T28] ---[ end trace 0000000000000000 ]---

--
Best Regards,
Yujie

--64lya1TZ9AoZHSq5
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--64lya1TZ9AoZHSq5--
