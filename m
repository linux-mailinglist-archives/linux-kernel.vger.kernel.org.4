Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BBE67D380
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjAZRtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjAZRtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:49:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719D4B1B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674755343; x=1706291343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0haLna1vjt7if8NOl7jmlBmQCkXcy0iGC5QmeqlQf2c=;
  b=RS9HmkmIUML1LXgAF5UAnOoBPtEj6dyLkZjBrFyc624ILADA2GWTiyWX
   5TduepZUpwrFmyZzu2DC7i2seDdiWh91pOHfHbUUeTyTuCvu8IvV6DSJi
   ST4JH1sYdoddYO/czhncaWfrS8EtvUjBulZNs/FXKm3XiHS+eDlaviq+y
   stg3x3XntF1gdiRt+v542G+BLZ8Xua46eJlaiXRitpU5ky0XL2Z/hW8wU
   CxlZeYMgjhdQ+St0oz3NEzKIii/W+HmCbKR9Pa/Ui44Utvz4zR3S5CmEw
   8cutecJT1I8Xnr2zPqYu6dGe3liBME/HuTUY2lcYkOh8iUnOmJvt3Swyf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="307235239"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="307235239"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 09:48:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="771236831"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="771236831"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2023 09:48:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 09:48:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 09:48:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 09:48:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 09:48:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa807H2mSQJS2ABHg6DLjFbb4fhLeSggJjVC98Y98l79QAtGujvKRMgDqLmH3H+EF3A3wenx/lFTWquwX7k6o9TfJE4UFOojU/zCKZ2Bd49Q/huqrniENXSu2hXEGZMhR6dxGdvhfJS6aJoJ7fdi/6f6flbRAtCflmiq8TqjFNX3QrnDjgkGJvpudpEwGdct10+gCnOh4+R71wEEe7Q56Ck4B8kD1bJ5cOhaVKFE8QvZEr2/NLjhupjTOzSu3d9XZg1s9tEbiN6mIwg3SHeKJM1EAT/8p8M8iE/yDPu2eLYOeGySdsva/ZTKh5LNHIEG2dg7hlW32ZrPfE9bMNbfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0haLna1vjt7if8NOl7jmlBmQCkXcy0iGC5QmeqlQf2c=;
 b=Q6qaA/nnktSCnx41shDQmxf1Xw9R0MMuY3MOgv6oKcVR3o1o68MCGP+nUxcDXS3ff9nhnCJ0J5zTAProRXPsxHgjr4niQiXrjojMQs3O3DT+I01ixB/P1m+Lhqi14gV1ZcwwLVtopCYTQEhW4j+DXAxQF4J0jhkIfcANdTqD27wCtgiLF5dZphT/4A5d9WnTEIrrQGVUSXEb1NKfKArX0xzEnGNr6DQpxpMzFwkanZC8nphuzh6yBWGdpBFozcvl3rXm6kaoDfMUTW3W+d+YqEvRNfI4iuY+E5e5WzKr9R9/NhKtRmFZ3Xj/IdPsh9xm9iYxw9T6fMFv1h4tbOoctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 BL1PR11MB5432.namprd11.prod.outlook.com (2603:10b6:208:319::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 17:48:33 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 17:48:33 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067AAKubQgAAALAEwAAVZrAAAB1DTUA==
Date:   Thu, 26 Jan 2023 17:48:33 +0000
Message-ID: <DM8PR11MB57509016CEF6C939DCBD718FE7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9Jh2x9XJE1KEUg6@unreal>
 <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9KG6g0CHlnKwuW+@work-vm>
In-Reply-To: <Y9KG6g0CHlnKwuW+@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|BL1PR11MB5432:EE_
x-ms-office365-filtering-correlation-id: bc405798-20cc-4653-116f-08daffc58b16
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJpkG/+tPpWfS5j9Jess2kRtVMb5LVYB4gBNX9XopvKxNj3OhKFhMCXa4b5PDAo8Rf3Ru/b58rD+VpgH75+XE+9l5r57vs5++vuWKlJCJTF5NvrMoEyiz2Eb+6tM9GqUWqHlCdKq/6sgOyW7uxpo+KvZMpGTFH7U+5NjB5/dVWHSe0mTNtL4S5mvCqCSKqqB8XKyA/hYMQyFaZENU5qm6FTuSz1OfMOGowyxpXV1kn2xRJ3YhqBjbPa/7CZr4sPdlcOu5k45jtNOmMhtKfCjar6Z6lgWizYDpYOjVSmE8aThXltpFiVlMOJ+dBqa3UbLEAVQKajAlwDXoPDSS5zuuPwwFIekGgnucJWCFqiZl+1pqwI5kG9raVOVgoVnE5+4GL8ulI4UpnwLLJ2qcoY7fXpy97yEKGSOAh1iSvK5RhYphtMWnQwE8knsyQyj1HEGSPqMH9C3aqvyaTfXmaUy2IH185so/BcpQj+x3rhVZThO5rozlIhztc/MZIuNsH+/uRCo5F7LciK5FwtxmO0ESADudfzV/SUB7kGb3nXFk3raix6p8qeir8TrZLD3waRJW2HdWdfVyxXtBvobPsc3TUPfBlYXkMIjXxja35QHjA9XuGfZj18e08xeegjviM1bIMIwvq4iaDuOPRaTXN2E1SAgbM4pYaELznLprldAgb7jq/vggzr2rCa01wL22p99HczdTBUhAC293a9m51qIznGp+kswygMcdiT/lKHdSB8pX0njA4P7znKLab/K5maqybfShRNz7JrumUpM1peEGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(122000001)(2906002)(38100700002)(38070700005)(6506007)(186003)(26005)(55016003)(9686003)(86362001)(83380400001)(82960400001)(64756008)(66476007)(66446008)(66556008)(4326008)(6916009)(52536014)(76116006)(7416002)(8676002)(5660300002)(66946007)(41300700001)(7696005)(33656002)(71200400001)(966005)(8936002)(54906003)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFM5SEJRcFZWcWNnZzM1VVg0YS9uOWFJZWJnRHg3aUtLMFZNMmhQUVRQTFQz?=
 =?utf-8?B?clJtTnp0dmVZUXllME56c0kvemxGOWkyelV0SXpxYVZGeTZCTmFNLzQycmtM?=
 =?utf-8?B?WmRHOVJ0WktuemFqQm1QZEVXbTBkeFlIeEFwWktkMjNLanFGWmlPZ1NjTmVG?=
 =?utf-8?B?c1hGWnN1TldZY3RBZXIrZUppR2x6ZWdIY1hIZ2pBOTByTmh3dnVCY3BsMEJq?=
 =?utf-8?B?TzE5SUtJRytSSG9uZnZNQkNSR29OTmMrSXJBRXpEWFFwaFFvNWt2aTdMTTM0?=
 =?utf-8?B?M3VWR1kwVTZSbDd5WkdUZFB4bmlQL0RMQlZicTRpOWZ0bGdYdjhUeFdRM1ZT?=
 =?utf-8?B?bmczV1lrM3lHNTRpRjN2dDY1K3UrRE5uTE1qRE9PV2luZTV1VDNqUXdWcG8v?=
 =?utf-8?B?ajhZcnkyWExKaVBlV1RNdkJFT1B3eW9TcW56MkFJclc1NTNvRHpyN0V1Qkla?=
 =?utf-8?B?eTRWKzZlelVCRzFDQnhJMjFFcTdLbzRkTjQ4ekY0YU5PWGI2dlIvTnljMEFK?=
 =?utf-8?B?VGJsNkwzRk1sYU51Q2tVMUUzdkpNTDNXckNNbFR3NHU0QWpNUXhaKy92MEoy?=
 =?utf-8?B?VlFiSG1NdnpzWCtWYWU3ODBpNWVkS04yN3lIejd5cXg5cEVWdWZBS3lSaGQ3?=
 =?utf-8?B?U1lYbkQwU1VqVmhuTUh1NmNBNUxjTEZCN1FYb3U5aGpPUDZneVJFMnZwbU5S?=
 =?utf-8?B?Nmx2T2Z6L3MzendWWnJQUUhmOEI5cnVXMzRKZlppV3QvbkZwM3pBRTg3dGZk?=
 =?utf-8?B?ek1tTlAwWiszeExmcUxmanduQS9zMGRyeTl6b3dlMzdMSVRWbGZYZXBGM2x6?=
 =?utf-8?B?YTNXYWZ4K1NjbGdKSWFmYUlML1RyeDZhNzRyWDNIUXVaS0ZGZ2Z5MkZQWU4v?=
 =?utf-8?B?a2F0ckNoQkI4QWUwZmJjb2hqNWMrUmIrWVczUHJHcXpXSFllZVZ0bnRSZWZ4?=
 =?utf-8?B?YnFyUFUxd2Exblp5bFBNRWNGMVFlUHlCOVljN0IvYVhTVit3bFI3VitaSlk1?=
 =?utf-8?B?eFJ5MFJyT0h2Zk1rMFBIRHpzYzMrNmdUK3RHbGFqbEc1N1Y3SHdlVWUxWW9n?=
 =?utf-8?B?d2Q0eG9XM0s1d3NnYXVRWVZsb25MTysyWjA5VnQ0QTQwd29WR21tcUViVDZt?=
 =?utf-8?B?aUd1MGgyWTN3dEZqcURjdGFza0I5aHNkZVdMOEp6aU5qMXNFK0hpeWo0Q0F2?=
 =?utf-8?B?d0lBRExsZ0FDNi84aSttUVNINnNSeFlNRTB2Y1lzRDY2NDdIb05LUWJaM243?=
 =?utf-8?B?b3hPc2FKYURQZjRXTHpCSU1iaEpuaDZjaElkeWhlNTZJMzR1V21TVzlCM2h2?=
 =?utf-8?B?RmFvTXcycFh1Zld1VHgzZEJxdjFXNWlYaWk4UUN1K1lkZHFpVDNPdzd2ZFZk?=
 =?utf-8?B?ckhQR2M4TGlFVndwQWdOTGZ4cE11UDEyS21yU2NJOEE4VXBuRnRYSVBPY04r?=
 =?utf-8?B?QnpPSFhlNjl6WUJqRGRQb2ZEbGQwT01GWmpzaGI2NUM2dzk2b0R2eWtTU2ZL?=
 =?utf-8?B?aGZJeTRhMzN3OFZBRlQwRm1mME5QVnhITERMTllUdmV6b0MwS1FIUnBVV3R2?=
 =?utf-8?B?Vzd1Y1VsWkd4aUpYNVhaT1JrQmpLdmg0VUN2SVZuS1ZnL1FnczdQMC9WMXcz?=
 =?utf-8?B?eHRLK3A2d3loZVdrdFhLN09kek9aTUJTbGYyYk1RWnFTaVhneHpzTXBCMmp6?=
 =?utf-8?B?cGo4SFovT0taNjRBV0V3OHppU3Y4R3VtSHNvc0VaRFZuQ0lDOVlMWTBxRmhK?=
 =?utf-8?B?WU0wZSs2NW04QlNsYStiYXBpSkE4a0h0R1MzK1Q5OEVSeGNGeXR0aUJaVjdU?=
 =?utf-8?B?a09EOGVRdGFONEtHWVA5RU9KeUpMckFrWDdvSEJCYk04SUtPZE83ZEpBV1hO?=
 =?utf-8?B?RVpZVWlnenpsVVIzZEcycy9OUFBPdWVGN0ZrTHFLZThKYXBaYjdtVkhQRjFE?=
 =?utf-8?B?TFpBQS95bmNVY1h6TkR1RGxmTlJKUjRwRjNtcndTVWUyNnlPbWhNS3VIeFBH?=
 =?utf-8?B?ek16ZnZtM3FoaHBLbzFRdkFKZWlkUm1qREFDNUFvRXE2ZmFrMEdGTGVSdmNt?=
 =?utf-8?B?VUQ4bFA2MmIzU3Iwam9zcnZha0pMeENZTmlTVndJNmFZTy9JZTJFUXdlWVg2?=
 =?utf-8?Q?hWWXNyc0dUMNrA7G7Sy1dAhCw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc405798-20cc-4653-116f-08daffc58b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 17:48:33.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +K/VOBTpxcSLzsJwOyF6VMuUilUYu/YF57e53z8Q4IoJnLNCuu0hjueACTwdHKHCMy+6d2dFlyfHJQICXCwFCB5g9ELTJNmfTNxf6Dg1yFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5432
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ICogUmVzaGV0b3ZhLCBFbGVuYSAoZWxlbmEucmVzaGV0b3ZhQGludGVsLmNvbSkgd3JvdGU6
DQo+ID4gPiBPbiBXZWQsIEphbiAyNSwgMjAyMyBhdCAwMzoyOTowN1BNICswMDAwLCBSZXNoZXRv
dmEsIEVsZW5hIHdyb3RlOg0KPiA+ID4gPiBSZXBseWluZyBvbmx5IHRvIHRoZSBub3Qtc28tZmFy
IGFkZHJlc3NlZCBwb2ludHMuDQo+ID4gPiA+DQo+ID4gPiA+ID4gT24gV2VkLCBKYW4gMjUsIDIw
MjMgYXQgMTI6Mjg6MTNQTSArMDAwMCwgUmVzaGV0b3ZhLCBFbGVuYSB3cm90ZToNCj4gPiA+ID4g
PiA+IEhpIEdyZWcsDQo+ID4gPg0KPiA+ID4gPC4uLj4NCj4gPiA+DQo+ID4gPiA+ID4gPiAzKSBB
bGwgdGhlIHRvb2xzIGFyZSBvcGVuLXNvdXJjZSBhbmQgZXZlcnlvbmUgY2FuIHN0YXJ0IHVzaW5n
IHRoZW0gcmlnaHQNCj4gPiA+IGF3YXkNCj4gPiA+ID4gPiBldmVuDQo+ID4gPiA+ID4gPiB3aXRo
b3V0IGFueSBzcGVjaWFsIEhXIChyZWFkbWUgaGFzIGRlc2NyaXB0aW9uIG9mIHdoYXQgaXMgbmVl
ZGVkKS4NCj4gPiA+ID4gPiA+IFRvb2xzIGFuZCBkb2N1bWVudGF0aW9uIGlzIGhlcmU6DQo+ID4g
PiA+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvY2NjLWxpbnV4LWd1ZXN0LWhhcmRlbmlu
Zw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQWdhaW4sIGFzIG91ciBkb2N1bWVudGF0aW9uIHN0YXRl
cywgd2hlbiB5b3Ugc3VibWl0IHBhdGNoZXMgYmFzZWQgb24NCj4gPiA+ID4gPiB0aGVzZSB0b29s
cywgeW91IEhBVkUgVE8gZG9jdW1lbnQgdGhhdC4gIE90aGVyd2lzZSB3ZSB0aGluayB5b3UgYWxs
IGFyZQ0KPiA+ID4gPiA+IGNyYXp5IGFuZCB3aWxsIGdldCB5b3VyIHBhdGNoZXMgcmVqZWN0ZWQu
ICBZb3UgYWxsIGtub3cgdGhpcywgd2h5IGlnbm9yZQ0KPiA+ID4gPiA+IGl0Pw0KPiA+ID4gPg0K
PiA+ID4gPiBTb3JyeSwgSSBkaWRu4oCZdCBrbm93IHRoYXQgZm9yIGV2ZXJ5IGJ1ZyB0aGF0IGlz
IGZvdW5kIGluIGxpbnV4IGtlcm5lbCB3aGVuDQo+ID4gPiA+IHdlIGFyZSBzdWJtaXR0aW5nIGEg
Zml4IHRoYXQgd2UgaGF2ZSB0byBsaXN0IHRoZSB3YXkgaG93IGl0IGhhcyBiZWVuIGZvdW5kLg0K
PiA+ID4gPiBXZSB3aWxsIGZpeCB0aGlzIGluIHRoZSBmdXR1cmUgc3VibWlzc2lvbnMsIGJ1dCBz
b21lIGJ1Z3Mgd2UgaGF2ZSBhcmUgZm91bmQNCj4gYnkNCj4gPiA+ID4gcGxhaW4gY29kZSBhdWRp
dCwgc28gJ2h1bWFuJyBpcyB0aGUgdG9vbC4NCj4gPiA+DQo+ID4gPiBNeSBwcm9ibGVtIHdpdGgg
dGhhdCBzdGF0ZW1lbnQgaXMgdGhhdCBieSBhcHBseWluZyBkaWZmZXJlbnQgdGhyZWF0DQo+ID4g
PiBtb2RlbCB5b3UgImludmVudCIgYnVncyB3aGljaCBkaWRuJ3QgZXhpc3QgaW4gYSBmaXJzdCBw
bGFjZS4NCj4gPiA+DQo+ID4gPiBGb3IgZXhhbXBsZSwgaW4gdGhpcyBbMV0gbGF0ZXN0IHN1Ym1p
c3Npb24sIGF1dGhvcnMgbGFiZWxlZCBjb3JyZWN0DQo+ID4gPiBiZWhhdmlvdXIgYXMgImJ1ZyIu
DQo+ID4gPg0KPiA+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDExOTE3
MDYzMy40MDk0NC0xLQ0KPiA+ID4gYWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbS8N
Cj4gPg0KPiA+IEhtLi4gRG9lcyBldmVyeW9uZSB0aGluayB0aGF0IHdoZW4ga2VybmVsIGRpZXMg
d2l0aCB1bmhhbmRsZWQgcGFnZSBmYXVsdA0KPiA+IChzdWNoIGFzIGluIHRoYXQgY2FzZSkgb3Ig
ZGV0ZWN0aW9uIG9mIGEgS0FTQU4gb3V0IG9mIGJvdW5kcyB2aW9sYXRpb24gKGFzIGl0IGlzIGlu
DQo+IHNvbWUNCj4gPiBvdGhlciBjYXNlcyB3ZSBhbHJlYWR5IGhhdmUgZml4ZXMgb3IgaW52ZXN0
aWdhdGluZykgaXQgcmVwcmVzZW50cyBhIGNvcnJlY3QNCj4gYmVoYXZpb3IgZXZlbiBpZg0KPiA+
IHlvdSBleHBlY3QgdGhhdCBhbGwgeW91ciBwY2kgSFcgZGV2aWNlcyBhcmUgdHJ1c3RlZD8gV2hh
dCBhYm91dCBhbiBlcnJvciBpbg0KPiB0d28NCj4gPiBjb25zZXF1ZW50IHBjaSByZWFkcz8gV2hh
dCBhYm91dCBqdXN0IHNvbWUgZmFpbHVyZSB0aGF0IHJlc3VsdHMgaW4gZXJyb25lb3VzDQo+IGlu
cHV0Pw0KPiANCj4gSSdtIG5vdCBzdXJlIHlvdSdsbCBnZXQgZ2VuZXJhbCBhZ3JlZW1lbnQgb24g
dGhvc2UgYW5zd2VycyBmb3IgYWxsDQo+IGRldmljZXMgYW5kIHNpdHVhdGlvbnM7IEkgdGhpbmsg
Zm9yIG1vc3QgZGV2aWNlcyBmb3Igbm9uLUNvQ28NCj4gc2l0dWF0aW9ucywgdGhlbiBwZW9wbGUg
YXJlIGdlbmVyYWxseSBPSyB3aXRoIGEgbWlzYmVoYXZpbmcgUENJIGRldmljZQ0KPiBjYXVzaW5n
IGEga2VybmVsIGNyYXNoLCBzaW5jZSBtb3N0IHBlb3BsZSBhcmUgcnVubmluZyB3aXRob3V0IElP
TU1VDQo+IGFueXdheSwgYSBtaXNiZWhhdmluZyBkZXZpY2UgY2FuIGNhdXNlIG90aGVyd2lzZSB1
bmRldGVjdGFibGUgY2hhb3MuDQoNCk9rLCBpZiB0aGlzIGlzIGEgY29uc2Vuc3VzIHdpdGhpbiB0
aGUga2VybmVsIGNvbW11bml0eSwgdGhlbiB3ZSBjYW4gY29uc2lkZXINCnRoZSBmaXhlcyBzdHJp
Y3RseSBmcm9tIHRoZSBDb0NvIHRocmVhdCBtb2RlbCBwb2ludCBvZiB2aWV3LiANCg0KPiANCj4g
SSdkIHNheToNCj4gICBhKSBGb3IgQ29DbywgYSBndWVzdCAoZ3VhcmFudGVlZCkgY3Jhc2ggaXNu
J3QgYSBwcm9ibGVtIC0gQ29DbyBkb2Vzbid0DQo+ICAgZ3VhcmFudGVlIGZvcndhcmQgcHJvZ3Jl
c3Mgb3Igc3RvcCB0aGUgaHlwZXJ2aXNvciBkb2luZyBzb21ldGhpbmcNCj4gICB0cnVseSBzdHVw
aWQuDQoNClllcywgZGVuaWFsIG9mIHNlcnZpY2UgaXMgb3V0IG9mIHNjb3BlIGJ1dCBJIHdvdWxk
IG5vdCBwaWxlIGFsbCBjcmFzaGVzIGFzDQonc2FmZScgYXV0b21hdGljYWxseS4gRGVwZW5kaW5n
IG9uIHRoZSBjcmFzaCwgaXQgY2FuIGJlIHVzZWQgYXMgYQ0KcHJpbWl0aXZlIHRvIGxhdW5jaCBm
dXJ0aGVyIGF0dGFja3M6IHByaXZpbGVnZSBlc2NhbGF0aW9uLCBpbmZvcm1hdGlvbg0KZGlzY2xv
c3VyZSBhbmQgY29ycnVwdGlvbi4gSXQgaXMgZXNwZWNpYWxseSB0cnVlIGZvciBtZW1vcnkgY29y
cnVwdGlvbg0KaXNzdWVzLiANCg0KPiAgIGIpIEZvciBDb0NvLCBpbmZvcm1hdGlvbiBkaXNjbG9z
dXJlLCBvciBjb3JydXB0aW9uIElTIGEgcHJvYmxlbQ0KDQpBZ3JlZWQsIGJ1dCB0aGUgcGF0aCB0
byB0aGlzIGNhbiBpbmNvcnBvcmF0ZSBhIG51bWJlciBvZiBhdHRhY2sgDQpwcmltaXRpdmVzLCBh
cyB3ZWxsIGFzIGJ1ZyBjaGFpbmluZy4gU28sIGlmIHRoZSBidWcgaXMgZGV0ZWN0ZWQsIGFuZA0K
Zml4IGlzIGVhc3ksIGluc3RlYWQgb2YgdGhpbmtpbmcgYWJvdXQgcG9zc2libGUgaW1wbGljYXRp
b25zIGFuZCBpdHMgDQpwb3RlbnRpYWwgdXNhZ2UgaW4gZXhwbG9pdCB3cml0aW5nLCBzYWZlciB0
byBmaXggaXQuDQoNCj4gDQo+ICAgYykgRm9yIG5vbi1Db0NvIHNvbWUgcGVvcGxlIG1pZ2h0IGNh
cmUgYWJvdXQgcm9idXN0bmVzcyBvZiB0aGUga2VybmVsDQo+ICAgYWdhaW5zdCBhIGZhaWxpbmcg
UENJIGRldmljZSwgYnV0IGdlbmVyYWxseSBJIHRoaW5rIHRoZXkgd29ycnkgYWJvdXQNCj4gICBh
IGZhaXJseSBjbGVhbiBmYWlsdXJlLCBldmVuIGluIHRoZSB1bmV4cGVjdGVkLWhvdCB1bnBsdWcg
Y2FzZS4NCg0KT2suDQoNCj4gDQo+ICAgZCkgSXQncyBub3QgY2xlYXIgdG8gbWUgd2hhdCAndHJ1
c3QnIG1lYW5zIGluIHRlcm1zIG9mIENvQ28gZm9yIGEgUENJZQ0KPiAgIGRldmljZTsgaWYgaXQn
cyBhIGRldmljZSB0aGF0IGF0dGVzdHMgT0sgYW5kIHdlIHRydXN0IGl0IGlzIHRoZSBkZXZpY2UN
Cj4gICBpdCBzYXlzIGl0IGlzLCBkbyB3ZSBnaXZlIGl0IGZyZWVkb20gb3IgYXJlIHdlIHN0aWxs
IHdhcnk/DQoNCkkgd291bGQgc2F5IHRoYXQgYXR0ZXN0YXRpb24gYW5kIGVzdGFibGlzaGVkIHNl
Y3VyZSBjaGFubmVsIHRvIGFuIGVuZA0KZGV2aWNlIG1lYW5zIHRoYXQgd2UgZG9u4oCZdCBoYXZl
IHRvIGVtcGxveSBhZGRpdGlvbmFsIG1lYXN1cmVzIHRvDQpzZWN1cmUgZGF0YSB0cmFuc2Zlciwg
YXMgd2VsbCBhcyB3ZSAndHJ1c3QnIGEgZGV2aWNlIGF0IGxlYXN0IHRvIHNvbWUgZGVncmVlIHRv
DQprZWVwIG91ciBkYXRhIHByb3RlY3RlZCAoYm90aCBmcm9tIHVudHJ1c3RlZCBob3N0IGFuZCBm
cm9tIG90aGVyDQpDQyBndWVzdHMpLiBJIGRvbuKAmXQgdGhpbmsgdGhlcmUgaXMgYW55dGhpbmcg
ZWxzZSBiZWhpbmQgdGhpcyBjb25jZXB0LiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmENCg0KDQoN
Cg0K
