Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A616F731C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbjFOP1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345237AbjFOP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:27:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D34F2964;
        Thu, 15 Jun 2023 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686842847; x=1718378847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bh2NlQhryCZVuhCAfINmC0KI+n1Ar4Mbm7WVoW9I23o=;
  b=Pn2vospciDpTMtWf6Y7IeJywXSNgKo5C+S8onE6NnRvWVkEQEuGjo5pV
   4VugPQvpGF44MfOxHzsq4oYSgHiuAPkI1nyiEFbtc/TbuuQ8vNb2ZnsdO
   4F5oIuTclPu1LUMAGePzEfgpIaOAh8OMmxYSs+8u2XZLkBL7lQwjpG2Wp
   KtzsuK2UdN1ennP2dqrRClRGPYUbylgVSsaXBCs5kI5MuK4Xyxn9Is2Rt
   gC2rpb+m66k6wVc0x8WCSRW4jduBRawausC9/Oc23MbpcFJaaLyMl8wjU
   ZC0DFyKttXFo4jkAOUNbXK2z7rfM5IyjJ9bNI2q73msuECgFfvLs65Jds
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348638250"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="348638250"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802409615"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="802409615"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 08:05:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 08:05:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 08:05:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 08:05:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 08:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5wjtu4RGJhFXT07U3pumTy/L10R+MgSfNvVwxiXsZJ4FOMQYYzP/NNp7Ws/CN1v5EU5F6BqSCnP/56dvoiRJvP9tXpIuOvnOzRuX5zMY3iYkbcGJW5hPsDvtrgK+E4gQ9rNa53r8CUfc66g7anMR9hq8IVgpLdgT7iXN9HE+hUQWBAQFAy1BqDrJsLIbgqe3nnVXugq24YYPaGaUfVWemkOR2hWruMXnuNLWtr/EYHIX3caupmd3sDRyjmrckWxfbqHnrc92Vb7t6vd+jTagUyNVEj8VOTubF+Iz9SU99qvFNlpUxmFfMPYJknSbg3c1gr7UVoN4qZO7WOqfsQv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRffppm8KD0z5tbvvMZtOOjzdDbYn0fBk/kKMqiEFgU=;
 b=gGVB09WuzLGrjXeHyIahc/ibtWQgKhSfCY9R1d6OQOQ28yGG7fHCMsaT7YG1hd1ZdHJx70vxiUhKf4cJbt/v8C+u6WeA+2aN5VvrBYqzZgkH2hLUzFz32trzkZlnn2fwE3FhWhaIow6BEPtlNlbffshbbKlU8Hc3ZXME+8YlF6T1E43rw84oKiulcyW4md1hO8xVabrJMgzNXbXuzZmTcEYNPP3XOxcUMnxbCfys2KQdwT0iGdmDRAGVjikJoFy9/sO5Qb5uY/3+VSy9x3j8NvUNLwHz36AZ5DX3jZ/VnK0Pqrhb2MIfi1x5LsQL8PyP+rvleeubdxM5doaxbriX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2779.namprd11.prod.outlook.com (2603:10b6:5:c6::26) by
 SA1PR11MB6784.namprd11.prod.outlook.com (2603:10b6:806:24c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.27; Thu, 15 Jun 2023 15:05:43 +0000
Received: from DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de]) by DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de%4]) with mapi id 15.20.6455.030; Thu, 15 Jun 2023
 15:05:43 +0000
From:   "Jadav, Raag" <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: RE: [PATCH v4] pinctrl: intel: refine ->irq_set_type() hook
Thread-Topic: [PATCH v4] pinctrl: intel: refine ->irq_set_type() hook
Thread-Index: AQHZn4gBPXOZzjOwf0Shiugls1EKsK+L15oAgAACIqCAAA0ZgIAADlVg
Date:   Thu, 15 Jun 2023 15:05:42 +0000
Message-ID: <DM6PR11MB2779545C0ACBF833E857EBD28C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
References: <20230615125022.27421-1-raag.jadav@intel.com>
 <ZIsOvBGLJTCo45jp@smile.fi.intel.com>
 <DM6PR11MB2779FD7F6DF3A0126DB85E4B8C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
 <ZIsbg2h0u93tCQiz@smile.fi.intel.com>
In-Reply-To: <ZIsbg2h0u93tCQiz@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2779:EE_|SA1PR11MB6784:EE_
x-ms-office365-filtering-correlation-id: 3cc2d4cd-7008-4d74-b5a3-08db6db1fd1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mQT+PD6Ge6VE3sP66DqTxpTPJTp+FlLzYVQyeUdsueWCjUvixyPPZL10PVOBEqOVVtQ9h2DPggEisfSULv9Gf5w3wQiBD5Cn7a//Ccqb0NLPLtdSyromm8Go1GugNS8TSQGIl0XT2fqSRU0lTox/HXGT9zwSboYrnlCEuoZV0pR+VNXfYo5psHH1LD3FNOTZ5R7C5Fka8zG/dGkdbRI8s+RBRw3cDUvuNd8Pf1vPfn3sJJ1zFhaZT/TwLdD053FFWJfVTCiFRWsmAbaHmWJPis4fbYMlXOQ0kNhVOQjOa0fqcmifQY8uUw0DeSMu2EbkkHQFZxMX73SADFYT0/XHH2RM1MDFuOoa6N9BQ4hg1TMTC1MB8kbvJu9ODmQtX2Y+pU1GT87f9REDffrz6DTxVNl4fNfSDNlHuQZOXK20O+SvXm8HFTJWem3m2VL9CKfgjcla41JwTFMMCvLR9LCyg3KHj44K61q31KeALZRpS9gvqeSf5c78eh37Bf041O5CceG4/E0NshpVT3NDzSRweqkou+WTyFieKJmBZFRdhNTbWaUB9hBsVqtFrd54jXRcBe4AOgINI1JE484R66ImcppG2j2Ab7FYjYMm+jRBEstNuhQM6Ba93ZTj5aaCO4Pc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(76116006)(7696005)(66556008)(33656002)(41300700001)(4326008)(316002)(478600001)(6916009)(86362001)(6506007)(8936002)(66946007)(64756008)(9686003)(122000001)(26005)(66446008)(71200400001)(66476007)(8676002)(38100700002)(54906003)(52536014)(83380400001)(55016003)(186003)(38070700005)(5660300002)(82960400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0IBNbLXMncwxDpJxbCpr9KqSW2IucPdwNE6Abpnq4qV7ooX6ubvHnmBQWpyh?=
 =?us-ascii?Q?fryLLhxRedPIyY4YtzkhW6l7P/AhV9K2gK9MLFmWwrHp5z3BWoN+JZ58EXX8?=
 =?us-ascii?Q?NBW9/s1llbpzLiJb0us+lN7P+cK69cFi8PKgs0HqYmaIwBpsQrhfe7h+MpFJ?=
 =?us-ascii?Q?bXGSNauue5Uc7dH0tvNZsnY5W02tpVJNsiamLM3qv3wsc5ZKtQaOxRInDvEU?=
 =?us-ascii?Q?dx7P+q4eON2XR1d/2/PizSRXunKuKR+YPjEACUR2enGmMVU16JCJLJEy2KND?=
 =?us-ascii?Q?ehXKTJ4oqoLtjJqudgAdILgyt8VVtO3pikkYqkZ7T+r04b1cTi0rGPXFn+ee?=
 =?us-ascii?Q?CWqgsqLYCm4MrOMZAD9uecENJWOUezieY/Y0qgnklAMvZ87Tsv2PF7/e736K?=
 =?us-ascii?Q?+a/+xLzAo1Woc7hsZ+bWj8ioM72DVikBQVSs4WPTL/RIIVFR8/6TE/TNTNPs?=
 =?us-ascii?Q?pRtObhmTd4LWncFxp5NMd1iXRvwm72SclUrhw4Yd8V+CRuaQwk61/sdYKg25?=
 =?us-ascii?Q?Te4pcIQ2PQl9BL0yGM9GJytgrNauHm44qA95gEHsdd5pEGVutSZIZqvJAEZR?=
 =?us-ascii?Q?QRBWQw3aHiic23Z25PadeeHlqhxiNiqm+9Q/0QGsLT8aZYwGyM2Zg1NcJhpW?=
 =?us-ascii?Q?J+4mw4tVn9uVnzzwUcdJ7yoVTEgmIJwsu6jxJZwWHXvRHFOIkO6Oks8p2/+Q?=
 =?us-ascii?Q?3Ej06EtPaHehv1JBHpBkXLDH1rsaC+HL5qQY5Mn+9rpOSg1yXA0hviAowfUG?=
 =?us-ascii?Q?DOeAs3aPAZWMWETVoYE5fK23NzwGe/LpiVS1OP94QdfHJgmC5Yh3MzwJnhx+?=
 =?us-ascii?Q?UXPtf5h/JMkxHkav/DYr0QXwhfmMAHxbrBOSIBlBSmf0enISgppJYWNJjccD?=
 =?us-ascii?Q?qYcC0x15FEQMdJIRJzXijju8q7A7OyCqhslxC0g4tBnLsphZF24UMRpl8cBF?=
 =?us-ascii?Q?xkEWOGXUJLelRj5S/VGdIdlBc69RxJ22ryLSQeZo6hChb/Z5QAVzUXs6nAnP?=
 =?us-ascii?Q?shq4yTv5tNRSxakhmmLd47lqbmFFTyr1uhSypNxtNHiMT40kVulGAgIsqDli?=
 =?us-ascii?Q?hmkI7LsgkKKEpT7pyGPKx6wgZvmDcAGm9XoELWDog3qnNEDNJuEmtIgB59o3?=
 =?us-ascii?Q?MTAdjFB4qkRmy3VwuyznJ4rQnl6lUPw+aGZZBcDc1Q4kIx+4mFdaIEcRaDgP?=
 =?us-ascii?Q?LeIQBkmc801QTJ/quB5kSEJey++tsNUF6AJeRJUckzyUnkihdaeGPrhj5UUx?=
 =?us-ascii?Q?WDEcCldW4KDenppzg3KFdwqNkkyg23E0dBmcUIK1iKofPutUQA7ARIOzfExA?=
 =?us-ascii?Q?pBoHdWCkT7K47V8xERlr7rwwWF+S4GublBw6qUeNN+VDpoaW3KF5bpS5ebdr?=
 =?us-ascii?Q?Ef+O+GS7koqB6ylI4q6afKJui5wBHnzSIoNxz138yeNgkduDySAGlEy4naS+?=
 =?us-ascii?Q?oFKco54gBjl9xTjk55scazarkl3drPCmofSXwRXR967lpyL+i1U9QNx9k9zf?=
 =?us-ascii?Q?+uHvmrsELCvKqV47NJwi/WbG0O9ksj6w9NPwDXHTLtPRGeywg2fOQA6ONNR2?=
 =?us-ascii?Q?MukUjKgEf8quSN71tj4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc2d4cd-7008-4d74-b5a3-08db6db1fd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 15:05:42.5556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrL8sxrgqKm9q1VG/LuaDv9YkhylOhmeSFvsBBxrCOAUGh7qNsL1XMGlhjy8ha/uDr86GTNPaAG1gmf/jOjJcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6784
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 15, 2023 at 01:35:19PM +0000, Jadav, Raag wrote:
> > > On Thu, Jun 15, 2023 at 06:20:22PM +0530, Raag Jadav wrote:
> > > > Refine ->irq_set_type() hook and improve its readability by:
> > > >
> > > > - Reducing scope of spinlock by moving unneeded operations out of i=
t.
> > > > - Dropping redundant PADCFG0_RXEVCFG_SHIFT and including it
> directly
> > > >   into PADCFG0_RXEVCFG_* definitions.
> > > > - Utilizing temporary variables for common operations.
> > > > - Simplifying if-else-if chain.
> > >
> > > Two questions out of curiosity.
> > > Do we gain or lose bytes with this?
> >
> > add/remove: 0/0 grow/shrink: 1/0 up/down: 33/0 (33)
> > Function                                     old     new   delta
> > intel_gpio_irq_type                          317     350     +33
> > Total: Before=3D10469, After=3D10502, chg +0.32%
> >
> > > > +	value =3D readl(reg);
> > >
> > > > +	value =3D (value & ~PADCFG0_RXINV) | rxinv;
> > > > +	value =3D (value & ~PADCFG0_RXEVCFG_MASK) | rxevcfg;
> > >
> > > Same question if we change this to be similar to the current code, i.=
e.
> > >
> > > 	value =3D readl(reg);
> > >
> > > 	value &=3D ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
> > > 	value |=3D rxevcfg;
> > > 	value |=3D rxinv;
> > >
> > > And I would keep blank lines after readl() and before writel() since
> > > we have more than a single line in between.
> >
> > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-9 (-9)
> > Function                                     old     new   delta
> > intel_gpio_irq_type                          317     308      -9
> > Total: Before=3D10469, After=3D10460, chg -0.09%
>=20
> Do I understand correctly that this is your patch + suggested above?

Yes, this is tested with gcc 7.5.0 with default -O2.
I see some reordering in disassembly even with this simple change,
and I'm not entirely sure what kind of weird tricks gcc is pulling here.

