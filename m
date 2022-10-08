Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2CB5F8323
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 07:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJHFbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 01:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJHFba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 01:31:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02F3AA366
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665207089; x=1696743089;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gQLouZSSsNTmoOV1Xaub6BdjvbacVxRp+1TmYhmZBaQ=;
  b=RM0mPgD7UwFa1tkoPxppvNb0z2UsuyvTYQysu9qYHC/U2C29yM+qXCwz
   1IjmdE0xHBwhLQYamhrdDF4tx5jg77qlgdZIWL22mtTFzODUh8SmioLCb
   YMYSUFgUz0YkVkPvldC1ZX1ipqwLPMqMZH7QSrBThgJz/j4lfmBCxfbOy
   WhsppaNxK/wKcsS62dJMkgkdgMudvYq/x2W+dxjOz+YF1AGEQ4GQ+f53r
   nkDFKzTfsIRel4Dfv2NTIIZdv4y8FdfD5HonDFdUB7pZsVrwU4Dh7fwqF
   9jWILFFcaoLrMQH0/ewE0hhV5DHwTpae8i2Os8BQWOXNZUXLo6aJ/0FMR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="301499448"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="301499448"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 22:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="576477146"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="576477146"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2022 22:31:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 22:31:28 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 22:31:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 22:31:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 22:31:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1tpIJyTRjPiYYkf68CqpeLWsmH/rNdx/4oVkt79DGRkUre8XIqGpD1tTA9tm3NXd7hnkmgkrp/G9hSLxEPipUe6n1b7/qhZSGyzobzNdde6Ov31Wbomk6fBydIEga2I0/6Pe1uZzElDtTxsDQSfO/RSyRoRKWNr2Tn9nTAVDGhEboEu6/LcQGuSdGPpslCgoL+3DhewtBv6OA7F0R97BgQr4gSqGbG35WBkFMpSabawxqCmFn1KXlmgMB5k/djHpjwxjOx4OlcEZshz6ZegHriheBN4yzUpkqOCZfTruKUin0xqr7vP7qCjNVO0Enwu68lvyL/0MIwlnE2+MKnQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMt+gIrl/jLmYPH/n0ey2M0BshSyTXZ8PsOKBV1MNzc=;
 b=FnFsn0B/1scNiOZ5no1MoVpxENBsi1SqCI2N1U2OQxp+T6qYGpYFfmY9fYcOmHRFLl4vJ1VhK03NioGfTEa/1w5CGrC+2IPPchdEbHZXu8ReorJPC5sTFyaD7JzGbslMKA/U6Rwfy7YKNAdQSX86COg7ZNHcXXvP3xuSgcOreQANmMgCBMvNsIidkXhn+8yNoj+pDYbtDbhO9YFiGeNVJzBo2k5MsblaAO7bDK6Vdor4W2mVRmH0V+xRbiLBsOaVsYr9KGOvVQZwv65yjcqfKX1VHulxVz/fMG76MwZMu3iwLamgaiV2HL6kn8jIPx22WV0VaSLwQwZcBLAA66G/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by DS0PR11MB7262.namprd11.prod.outlook.com
 (2603:10b6:8:13c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Sat, 8 Oct
 2022 05:31:21 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 05:31:20 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Topic: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Index: AQHY2Z1YsyE3enznIkOfLcepaehVE64DCmMAgADvxtA=
Date:   Sat, 8 Oct 2022 05:31:20 +0000
Message-ID: <BN6PR1101MB21619BD3724574B79211F1FCA85E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <Y0BBLhHrgxYZahfi@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0BBLhHrgxYZahfi@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|DS0PR11MB7262:EE_
x-ms-office365-filtering-correlation-id: c571f165-cb8f-4e45-26fc-08daa8ee54c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59gCt0ZiTeuL9ht6aaoPFMFmXKewyEi9IARBsI2qQRMmVel4nGQrSVHinxncEgUwhZsYYzfVFyHoZui2iSfp9pSoQ0FNzuS91KoGL9SvxShA+3XwcdHIkhHjc7QtgU44QXUmZs9Qgx09cLHdff5O0szyjl5cd9lYJlpkwwiC80R3kwpzLVaCuvMGjnRxEuogJYvgZKDE0TzTT1uO50yJrv1+ZpFdBmNdInfvnZ52vYlx/ZmiiRaVVlICVt9bMcv3nexC+GvYFFS+nfcVslbPFXg9pjXGE+7/dWzKWmJ2lasnYNtZWVLDLO1STQN4Ijodgu+CmnA2h7xYEODzJFDGx51m/0/3Ejw44rpFjIBswEd3deLIVxZV0wvo3HfAq3RBc6L7qksk2BYW9U0uDhY1tOLgrP4JqiDp1dXGDTi03FK1sBAe0/orQ0tpERR8QP+LrGQRZtE2PlWernTRcltr1FbY54efxKlXfWoQcnAxJFQtYY84Ows030KJDoh36ALFQchE8PVb5v649e754kXZAAoXBQ9HwlBGNQ1jeNhDIe/tYjcSHu/MebZswZX9R+4YyCUana0j8Zu7zEylP95BDNYIcqkWsP5HKsEeoyGGSY3M/w6qYkQAmz/vlQURcIi6mT9egNWAAWwBWsDbVNBc0tKBduFxN5AZzx+gAT5BI7DDQfIcOKENkZubLGfAFSq07DFmQABBuAUI64glXh/5Dw+d8yZhrJD7PS0steIcWLYpqK3/4ZNLmt+VRWNgcQQAwYuKKPqPhIuCONCrb7P0qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199015)(38100700002)(122000001)(86362001)(33656002)(6916009)(38070700005)(82960400001)(6506007)(52536014)(478600001)(8936002)(5660300002)(2906002)(7696005)(316002)(66946007)(76116006)(64756008)(8676002)(54906003)(4326008)(4744005)(41300700001)(71200400001)(66476007)(66556008)(66446008)(83380400001)(26005)(55016003)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1f0Ly3puPAtcFCbL/mGJ2LyIKxhxcDDRspsSib3TsY3w9oVmaLXg5oqxbBfd?=
 =?us-ascii?Q?H6qdoGZJViaFBs61CWGJm/H5EHAbYHzwaPQFXo+k/kXAvE+wEXVgIT3EqF3m?=
 =?us-ascii?Q?GSRWpHK/4BK39sbWI5V3ReYDP1EPl42GJ27zA737PffPmhGud0JRWWw53P/i?=
 =?us-ascii?Q?byFWJT1sRbmW5wrmPxkwAWvYY1Kt5NgPBQYULv4KFwO99L+7Ho0IObkXwk+z?=
 =?us-ascii?Q?dQcq4+Tol/BviiLFUvyDdyAs33fasyvBl2MBAMWyaOk117QAIgG/yFURu3H3?=
 =?us-ascii?Q?fwE/95uQbo3Yny0Jl6xS35e/9QV+f13AD9rWn3IjcLtk6D2+LjyOlVWOiNgw?=
 =?us-ascii?Q?bNQtVmhS3gHF3MYxfypE/HKfAE3hHedLg6AZ4yk1JGT0hdZCqQ+s8fB1aNIL?=
 =?us-ascii?Q?tQaNOvvcnA7/9Loluf5lo8HtbNWQU7/8VvhJbfaPE+P4HR1Q1nayx37iGu9I?=
 =?us-ascii?Q?5i3mFGjBdonPax39q1oBlwssTGm74S8PeWb+762vUaDSJqHbtAfIJGJvSTDq?=
 =?us-ascii?Q?SFFLtREyBAXriH+KA9MCAvDePOfICBwRXc6c3x+N7HLWTkNmjzDNQt7JPtHH?=
 =?us-ascii?Q?HwcMu7JoRKBuycPU4vOCz0vT2ar5BaAbTrfilOyLQ0UjITkTzXFHcJ1z8Pgt?=
 =?us-ascii?Q?/cdlYA0S4T0hzEE90YuSGqHhFWw042CQUEF8p1AUL0jD0LtPr7dBjJay0y+e?=
 =?us-ascii?Q?Jgr/hr/IeByScKA5Kx+w7azAHVqU+Y6tfg8G3+NyUSs83x8Qpp4g/m9Id5uR?=
 =?us-ascii?Q?uIiAxlkZ8PLNP9oOJRcNEyU7oO7AcwaBa7eXgNt2UjYw6B9ff95/S4C3qNPo?=
 =?us-ascii?Q?1y+m1WY8BTCkJDNqyK/6Gq5EDNzYCl6bJFzIUWvtMOIaHNhdD+jMt/6/etti?=
 =?us-ascii?Q?e94wO0HlQ9S6C+OODGJ37nRt+QX7MXPPWrHVRPzGEwYfSJFrVqVdSDRS09J0?=
 =?us-ascii?Q?3vbB5/JASLpyYy5dvtiFL4raQiZqNodo96tjoOvtHWpdWnp7evU1VLLAqmwh?=
 =?us-ascii?Q?zVETyDJe90VGZ2UEs9kcsxjgs3HT5ax7pe5AGKz7EJrHhf1VeD06idnfqXce?=
 =?us-ascii?Q?0e/oFJT/gA8oP+z2f6gsZrnINB+nvNbtWm6aiquULUVOafNCSyE+sEFeK+38?=
 =?us-ascii?Q?rLayy0wGq55yHHBKLGl72FH0tgZMGv2BfQxPMqBlnE4HN5nkBgfY2E/d9ot3?=
 =?us-ascii?Q?9CA/s9CK0Nz+9FlQh68J6AesyTH0CKN529gAuS4BvuyaMd+F9Wmzo4RGHACm?=
 =?us-ascii?Q?o3kzanuvyda0x5efcCGzbDkN/MdvhsZB8sPdr4hS9SYA3J54Je056eWNoNNd?=
 =?us-ascii?Q?8pdXIkWZwwhjKgz4vgovXUmD9zfHRYtrvqotYlWgPFqL/21fpfY2OfaEbKvd?=
 =?us-ascii?Q?Zjl/00EWcNaILKmF/GVo3udFHptXjWBaPPbFTAVRz+ZWAIySNM8KsTdtV7bu?=
 =?us-ascii?Q?pXeT8nhxDvXTZwiuDpmZQ1NBW+7VEpXrk1vsMrVZcvCXzS/Nxje4EE+NQFsu?=
 =?us-ascii?Q?HL3OVGtEueOxww/NAJTeyeLmGAS+DxBqqPGFNN/JcdUZD6um1fKlFMj55apZ?=
 =?us-ascii?Q?6L3tfwqJXPCiSSpMltg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c571f165-cb8f-4e45-26fc-08daa8ee54c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 05:31:20.3636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoXTDjzX27iN/2OQq1UUc3JMufkU42zAd5yH6w/dLVcHO0oCp8Tnn/ib/FPLaVY48zNDQ4GK15iVlNPn/jMdOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7262
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Something like so perhaps?
>=20
> 	asm_inline volatile("1:\n"
> 			    ALTERNATIVE("call asm_load_gs_index\n",
> 					LKGS_DI,
> 					X86_FEATURE_LKGS)
> 			    _ASM_EXTABLE_TYPE_REG(1b, 1b,
> EX_TYPE_ZERO_REG, %k[sel])
> 			    : ASM_CALL_CONSTRAINT
> 			    : [sel] "D" (sel)
> 			    : "memory", _ASM_AX);
>=20
>=20
> (completely untested, not even seen a compiler upclose)

It compiles (after adding "0x3e" to make it 5 bytes to match the size of "c=
all asm_load_gs_index") and passes my fixup test, thanks!
