Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3006F063C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbjD0M4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbjD0M4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:56:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C131B0;
        Thu, 27 Apr 2023 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682600190; x=1714136190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bhDkNvfrf3MaMNGZFCGIp9SKmfp4X1C3KZ4PdzDg6m0=;
  b=Yz0c6uf2a1g1CALtmZyampoGhGTSkPRStFfijbEpzC8WAZkKlRpLTrBL
   SB0K8cA1B5T4bNmSNgn3nIxojv1dn3eOHyhSZCmbXMCIe8j+fvflCuHv1
   M0BQpXWRNu0fIxotUusXbikF+ulgXxWptN+QLRhLIqLzFThUuhTsebYPB
   SH6PgWvAfr2Me0ste13IAuSfm616sjwYjCR+YYgnzkS891Ax9Af8/eWz2
   z+rmeG3mTvJabbzdhmx8si+4bCxKxvZPdQI6qXbWKaafbljJoDhuf7Q7s
   r0Ut4GzYwhUsPLT/e1oYMbENRki+dtKyuUneKSCHtu+zv75yYLI4LWW5H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="331685535"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="331685535"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 05:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="688418223"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="688418223"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 27 Apr 2023 05:56:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 05:56:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 05:56:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 05:56:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 05:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAJwY6/LHb+J1r22q3dzYXhHE6aAerESDOTa+3SMT/7Yi39wPUs4v4S4VzxLlaVrQG4H08xfjZb4Blc6K4EHPFZrze0ND1P0iX1pJ8RJ+ntEXywjs4MH0eu4t8aqkLJ8HWh4TkuE9CrnRFHZQoiPepzHLjwTBEdFbGBQHyr0P9YWysVivqBBVvDDNC8jZALjDS+3gydXuH9SEC070yODIo8jSKmyFjiGcO69mclIGgGFEhaQbY2WpnyuocxEWaIV0iw5S/KtHe/2xrXTXCIB8tP2DFWdvW6nNyMJ2Jn42qVTh4iiDQzXuMOe0ph10eH4WHqLQCvNZVO2+GhuhczWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhDkNvfrf3MaMNGZFCGIp9SKmfp4X1C3KZ4PdzDg6m0=;
 b=OcPH/ZBHB7wmsk+uFyaozevyG5P5tl4AUIofR8SftS1UAs/q57l8NpaBmCqzjM4oImTCC5t0P8ogoFI3s0vWRlqspLBjNdXH4BfZ09i5U16lgDhzBxz6XY1FTHFcvRZYONKz52j/dakZJTgA7Vy8F7bxm+JtpoELTWsp0s7w8K7Q26p1u7YLj0X8IXS8MEXj7IxsIJy46+y0Cim3Gi5ThDQZ/IGeZG5nYrvCPDNWoBVlGcF3dP9hAsuz6baqJLOaRoe3jr1eE4SEa96bJWMrrVAKOGT4mrbXQvfoFt4qlZgkKeoNcQ4Scz+/oJBC9WgqW5UKmnY0yRYK69k/A5B68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Thu, 27 Apr 2023 12:56:25 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::65f0:6a4e:8aac:3e3e]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::65f0:6a4e:8aac:3e3e%2]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 12:56:25 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
Subject: RE: [PATCH] docs: security: Confidential computing intro and threat
 model
Thread-Topic: [PATCH] docs: security: Confidential computing intro and threat
 model
Thread-Index: AQHZYLcIL5h5EiW/WUeIdC3dxCgzQa88TIUAgAFu+xCAACeogIABZxaQ
Date:   Thu, 27 Apr 2023 12:56:25 +0000
Message-ID: <DM8PR11MB5750FBFC3635B12A70F35A7AE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
         <ZEfrjtgGgm1lpadq@google.com>
         <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <7502e1af0615c08167076ff452fc69ebf316c730.camel@linux.ibm.com>
In-Reply-To: <7502e1af0615c08167076ff452fc69ebf316c730.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DM8PR11MB5669:EE_
x-ms-office365-filtering-correlation-id: a58cd7b0-9a2b-41f7-14a8-08db471ecf4d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1kZ7TOatN7ip4x1rJqdNE5mWooKvpgnaubCmd6CyCyZCPrDLMBq6Ioefk6vo9rIEfc/qz1OYOJ6RBV5I8uV7cnaiJj/MF36u3sLaJYoaMzqTfPuFxpKyCaNtyxYhM2q53Sl26ystQauU/Xm11WpfpOcG5nQmI8vj4LX7IjAibvYAkJvcFnoj3wxTzGP8WQE9yFtGkkK6wP3gDLcsUuhQXiVad7Z8MrMV5RWe2htlxUF7rqO5SA/4ArCpdfRJ/r6q4+gFFJfZDG1wHMvvXkcUtNMr+zdm3j9e+FwiKtqz9rNIXUG1nl2jXLsK9lt0S/IM4X8EbuM9/zGgp3Mo9rDiCXZeaqw6lElC+6Zr9FpVUR4BhWthQuws26D9vgsuAc08m5O4aXHoihEn5VYhjIlSKH23OQzTw378XPaMYSUNNc8B6Ysmg0w11Zrb5JFrehzGAw84ZdkMqCcHqcjY9T6neoQPuwL4C4n4jnNxwaEcq2AYK1E4oxlyuTGMH/t8U5W+pfNOpcJtULo+vaCzjnXuFBzTafUYx4FMOHS4Q8/CKdjz8yUqNahA79nHnP+LrbSJmjfPDdVmpD4Z7bM8z50+TR0gpLWs1Vz07L3pToy5gbapmM+b1C9NxL3taHnOX1oo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(33656002)(86362001)(55016003)(54906003)(478600001)(71200400001)(110136005)(7696005)(8936002)(38100700002)(8676002)(41300700001)(122000001)(66446008)(66556008)(66946007)(76116006)(316002)(82960400001)(4326008)(83380400001)(186003)(66476007)(64756008)(7416002)(26005)(9686003)(2906002)(15650500001)(6506007)(38070700005)(7406005)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVliOVVTc3pMQjBTa2VXNy9SRVZXYkZteVc0QTNNSkZ5VFB2RDVTVVVuVTR4?=
 =?utf-8?B?clI4KzZaUURhb0thUlV6ZFdDQXcvZFlzTS9CbnR5OTVvUys5NWFaRndTTVl4?=
 =?utf-8?B?NXVHRTU5Q1lieUJJRWZIK3NIYkpBNGtOYjM4MTBmTFRqd0FUUHExQWMwK3gz?=
 =?utf-8?B?cEdib0V0NEdMd2pQMUd4WHF5a0d0cCthQ0d2L1EvbTlZY0VGd2JCcmZjVlV0?=
 =?utf-8?B?bjlidHdna1NsVTFjRi83NjJ2WGJvMGJta0kxWjY4YmZjRk1keE5rQ1lmWWgz?=
 =?utf-8?B?dkhkTjIrbkFKb1FqSDlVbGg1Rk1EOERmUHJqb3dCam42RjRmYUN5amNPSklY?=
 =?utf-8?B?Y0xBZG9kai93SDZhb3hlWlMxeE10cms3d3crb1hqMENaSmxTTUdGUEVBeCtH?=
 =?utf-8?B?cUxMMDllLzg2VTYzSTloVUhuYVFPWHFCM3pXMVdET1RJaFd2dGhaK3lqQ3R6?=
 =?utf-8?B?cnRTWURpQVk5Y0llb3V4d1RCQTVxSmVpTjBLbGs2cG1GZyt1WTc3aTNHdk5P?=
 =?utf-8?B?a2JwbEp5OVhXLzdvRXJteEFEZGszbkhKWldlSkRyVmIrMTJBZXhNZHdJNCtm?=
 =?utf-8?B?OHZMN2xTRzFOc2svZnBPc3Vqd3NST0xZd1JCU3AzcE1JWndlZ2kzVUwzQllj?=
 =?utf-8?B?SnpBdGJ0aHVkWXpiQzNXVlVXOXRkNlBqMEJKUTd4a0JxV1lBcHI2bUJpNVJO?=
 =?utf-8?B?YkRpQ3g0T0VUbld6c25aYlQ2Y2VtQk5oL2x5Vm9tb0N2aEYvc2pLRGpoLzlM?=
 =?utf-8?B?cFRrd045bW52aXNNdXZYTTVvZWk4Ylp4UXNNaHpiOGxoSDZicjJGQit2cW1j?=
 =?utf-8?B?OTcvTmRObm5TQWw1NWZnQlJLeks2Mmt0UzdMR0g3L0VuM3VEMVJsWFZuWENG?=
 =?utf-8?B?ZzVzczRQdEVnWVFYUHhldVF4U015Uno0TnFWUmF6UFYzN1pTRWNXaVRaOUhw?=
 =?utf-8?B?NlZoZG5vWHExdGVzZHJjOFdxSkg4c1dEVkRpbEVUc0RoMnFuTEVSYWxJTVgz?=
 =?utf-8?B?aUZhQzd6ZEdTTGF4Qzd5MDhiVzNDdXMrZ2prd2RGMkdNRlI4UWIxRTFaeEFR?=
 =?utf-8?B?b1hRNzR1SFY2RHFDTHBTMlZUVHg0L0NQMTBQZUtHRE14RkJkcWpXQ1RJY1I5?=
 =?utf-8?B?QWxvZjAyQzZGL0R0T1N5dGNjL0tzWFhqZEYrUjZ2a2YvYTJWblpqbC9PcG82?=
 =?utf-8?B?TVVoMVc1R05hNm1udXhadkd6L1oyMFNqcCtvWXMvQTd0QXBLaG10RHNwSXBj?=
 =?utf-8?B?WitZTVp4K0MvcU1FbTJXbmVUSkI5OU9VS09uQStXQmVLRi90S01yUzFhUlJY?=
 =?utf-8?B?RFhWaWRsRTRLYVdwV0l1Y3hIbFNXRnJSUmdYMWFsMmpta2kxQU9mT2JUL2sx?=
 =?utf-8?B?MzU2Nkt5am1odXBMbFBNbU1BQXExbnJuOFdEd1FVdVhkei9qNU44elJKQ1Vl?=
 =?utf-8?B?SnlXQ1BvWmdvNEY2S3ZpNTFERDBqQTZuZ1FVQ1phMUxIUTRXNk5pUEpCNVZu?=
 =?utf-8?B?azAzNUFqR21nWkpmS25FSmZEKzIxY0gzRG1qOEVEYnRHOWx3cVQwMmNZMG1m?=
 =?utf-8?B?c3BBKzRyaFo5SkJUM290WC9pZUFnMXVNcDluLytxRjVEUUo2RjlJSDk5aEcz?=
 =?utf-8?B?SGl4ZTRtbjZYSDlrV1k5aEEyUEhhOUVKSWo1VHdtLzBDaDhCSjYrUmRQZ05R?=
 =?utf-8?B?VU5lbUo0UytnbWw3Wm5qRDBxVUxtK0huNW40ejEwNXZ0bCt2cER6eTFDSzhO?=
 =?utf-8?B?MExBVmFXeEY5dTk1cmlLcVRqMFdycHJpN1VMRXJtRWlYQ0lKMmpVSVdKRFRs?=
 =?utf-8?B?cWJKY21JZUZ3SUhyajFUQmpkRmQvdkIrZFBZUHJrRUUrQ1JDWmkxbXZSY3ZX?=
 =?utf-8?B?WGpINTI5RzUrbU1laU9qYTlVaVFYZVdOaU85eVVRRWxpVll0VFQzYnhFdDVs?=
 =?utf-8?B?bFYzSE9WSUNZKzMwZTdmeDBDTDZxam80cHJyd1JDK21QeHRIYzM4dlk2eE5R?=
 =?utf-8?B?U0M5aUhoTVJSMFNKbU5rZEE1UGR2K0VtWW9jZ041MWlaa1Rtc29qOFZOSmtx?=
 =?utf-8?B?K1d2LzV3L3cyOHNwVU45MVRxVEF6VUtTejFKQmZMRFN4U1ROM2RmSVFFZWNX?=
 =?utf-8?Q?KuQB6N/LuB+M2EeIPP5iRRTu9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58cd7b0-9a2b-41f7-14a8-08db471ecf4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 12:56:25.5404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYL9gPtezNStLDovZ3qEOlWf4yIo3KdRRr3iSwLwQ9mQttcER6LUJp2kmSXyaA7LVkjRcsehQ1N7KJDu9Ry0Js4IWCSMI3NxwA4JmTMeJTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5669
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIFdlZCwgMjAyMy0wNC0yNiBhdCAxMzozMiArMDAwMCwgUmVzaGV0b3ZhLCBFbGVuYSB3
cm90ZToNCj4gPiA+IE9uIE1vbiwgTWFyIDI3LCAyMDIzLCBDYXJsb3MgQmlsYmFvIHdyb3RlOg0K
PiBbLi4uXQ0KPiA+ID4gPiArcHJvdmlkZSBzdHJvbmdlciBzZWN1cml0eSBndWFyYW50ZWVzIHRv
IHRoZWlyIGNsaWVudHMgKHVzdWFsbHkNCj4gPiA+ID4gcmVmZXJyZWQgdG8gK2FzIHRlbmFudHMp
IGJ5IGV4Y2x1ZGluZyBhbGwgdGhlIENTUCdzDQo+ID4gPiA+IGluZnJhc3RydWN0dXJlIGFuZCBT
VyBvdXQgb2YgdGhlICt0ZW5hbnQncyBUcnVzdGVkIENvbXB1dGluZyBCYXNlDQo+ID4gPiA+IChU
Q0IpLg0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgaW5hY2N1cmF0ZSwgdGhlIHByb3ZpZGVyIG1heSBz
dGlsbCBoYXZlIHNvZnR3YXJlIGFuZC9vcg0KPiA+ID4gaGFyZHdhcmUgaW4gdGhlIFRDQi4NCj4g
Pg0KPiA+IFdlbGwsIHRoaXMgaXMgdGhlIGVuZCBnb2FsIHdoZXJlIHdlIHdhbnQgdG8gYmUsIHRo
ZSBwcmFjdGljYWwNCj4gPiBkZXBsb3ltZW50IGNhbiBkaWZmZXIgb2YgY291cnNlLiBXZSBjYW4g
cmVwaHJhc2UgdGhhdCBpdCAiYWxsb3dzIHRvDQo+ID4gZXhjbHVkZSBhbGwgdGhlIENTUCdzIGlu
ZnJhc3RydWN0dXJlIGFuZCBTVyBvdXQgb2YgdGVuYW50J3MgVENCLiINCj4gDQo+IFRoYXQncyBn
ZXR0aW5nIGV2ZW4gbW9yZSBpbmFjY3VyYXRlLiAgVG8gcnVuICBpbiBhIENsb3VkIHdpdGggQ29D
byB5b3UNCj4gdXN1YWxseSBoYXZlIHRvIGluc2VydCBzb21lIHByb3ZpZGVkIGNvZGUsIGxpa2Ug
T1ZNRiBhbmQsIGZvciBBTUQsIHRoZQ0KPiBTVlNNLiAgVGhlc2UgYXJlIG9mdGVuIGN1c3RvbWl6
ZWQgYnkgdGhlIENTUCB0byBzdWl0IHRoZSBjbG91ZA0KPiBpbmZyYXN0cnVjdHVyZSwgc28geW91
J3JlIHJ1bm5pbmcgdGhlaXIgY29kZS4gIA0KDQpBZ3JlZSwgdGhpcyAqY2FuIGJlIHRoZSBjYXNl
IGluIHByYWN0aWNlKiwgYnV0IGl0IGRvZXNu4oCZdCBoYXZlIHRvIGJlIG9uZS4gTm90aGluZyBm
cm9tIHRoZQ0KQ29DbyB0ZWNobm9sb2d5IGl0c2VsZiBwcmV2ZW50cyB0ZW5hbnRzIGluIHRoaXMg
bW9kZWwgdG8gaGF2ZSB0aGVpciBvd24gdmlydHVhbCBGVy4NClRoZSBmYWN0IHRoYXQgQ1NQcyBp
bmZyYXN0cnVjdHVyZSBtaWdodCBub3Qgc3VwcG9ydCB0aGlzIGNhc2UgaXMgYSB0b3RhbGx5IGRp
ZmZlcmVudCBzdG9yeS4NCg0KVGhlIGdvYWwsIEkgdGhpbmssIGlzIHRvDQo+IG1ha2Ugc3VyZSB5
b3Ugb25seSBydW4gY29kZSB5b3UgdHJ1c3QgKHNvbWUgb2Ygd2hpY2ggbWF5IGNvbWUgZnJvbSB0
aGUNCj4gQ1NQKSBpbiB5b3VyIFRDQiwgd2hpY2ggaXMgdmVyeSBkaWZmZXJlbnQgZnJvbSB0aGUg
c3RhdGVtZW50IGFib3ZlLg0KDQpBdCB0aGUgZW5kIGl0IHdvdWxkIGdvIGRvd24gdG8gdGhlIGFn
cmVlbWVudCBiZXR3ZWVuIGEgQ1NQIGFuZCB0ZW5hbnQsIGkuZS4NCmhvdyBtdWNoIHRlbmFudHMg
YXJlIHdpbGxpbmcgdG8gdHJ1c3QgQ1NQIGFuZCBob3cgbXVjaCBvZiBDU1BzIGNvZGUgdGhleQ0K
d291bGQgdGFrZSBpbnRvIHRoZWlyIFRDQiAodXNpbmcgcHJvcGVyIG1lYW5zIG9mIGVzdGFibGlz
aGluZyBhIHRydXN0IGluIHRoZXNlDQpwaWVjZXMpLiAgVGhpcyBhZ3JlZW1lbnQgaXMgb3VyIG9m
IGFueW9uZSBjb250cm9sIGhlcmUgYW5kIHRoZSBvbmx5IHRoaW5nIHRoYXQgDQp0aGUgQ29DbyB0
ZWNobm9sb2dpZXMgYXJlIGFpbWluZyB0byBwcm92aWRlIGlzIHRvIGVuYWJsZSBhbGwgdGhlc2Ug
ZGlmZmVyZW50DQptb2RlbHMvYWdyZWVtZW50cywgaW5jbHVkaW5nIHRoZSB1bHRpbWF0ZSBjYXNl
IChpZiB3YW50ZWQpIHdoZW4gdGVuYW50cyBjb3VsZCBydW4NCndpdGhvdXQgYW55IENTUCBjb21w
b25lbnRzIGluIHRoZWlyIFRDQi4NCg0KU28sIGxldOKAmXMgZml4IHRoZSB3b3JkaW5nIGluIHRo
ZSBkb2N1bWVudCB0aGF0IGl0IGlzIGluZGVlZCBkb2VzbuKAmXQgcnVsZSBvdXQgYW55IG9mDQp0
aGUgYWdyZWVtZW50cyBzdHlsZXMsIGJ1dCB0aGUgZ29hbCBvZiB0aGlzIGRvY3VtZW50IGlzIG5v
dCB0byBkZXNjcmliZSBDb0NvDQp1c2UgY2FzZXMsIGJ1dCB0byB0YWxrIGFib3V0IHdoYXQgTGlu
dXgga2VybmVsIG5lZWRzIHRvIGRvIGFzc3VtaW5nIHRoZXJlIGFyZQ0KdGVuYW50cyB3aG8gd2Fu
dCB0byBtYWtlIHN1cmUgdGhleSBydW4ga2VybmVsIGluc2lkZSBhIENvQ28gVk0gdGhhdCBpcyBy
ZWFkeQ0KdG8gdGFrZSB0aGUgbmV3IHRocmVhdCBtb2RlbCBpbnRvIGFjY291bnQuDQoNCkJlc3Qg
UmVnYXJkcywNCkVsZW5hLg0K
