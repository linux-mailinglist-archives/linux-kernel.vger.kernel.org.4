Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3567E32E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjA0L0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjA0L0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:26:14 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC56E80011
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674818703; x=1706354703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UEoPqwv0XILFGnV3LNR7ws//TdmdrZpRWKmrkS+NKbQ=;
  b=djW/v7wT9BySzB4qIw+Mx0IeHkj8YjPidwF17jllB9i0NqD9yx45Jh30
   ZBbnizxjzHxjAXQDc8ZckOBWOOl4NBitAPFP17DIhfzTCRqgRGffgVzbt
   gtEOSTAIdJCrG7sRAHPyH2u5lr7FnPc7cDWGspbsxgJ75yCQv4qNumw4T
   opCMBsemHPg1OvJrNNezlZSlZzy4bYVBsg/B8i6Lt0s6hVjahCpAd24Rl
   EqvnL2zqr5B07+142qSCgS6QT9cPw9A5P7woNJW7ksiyFqqn3ng7lAFCN
   PLCcgkEN44zvv4EkfCBQoPOGC5osvBDbPETnNXobhgwqj+q3221pPkrN6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="389441321"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="389441321"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 03:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="837080413"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="837080413"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2023 03:24:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 03:24:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 03:24:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 03:24:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 03:24:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWIeK+iTyLGDcgZaAi8/LKTix9/561X97m985IylFjmCf2QnavmZQjOfh1ADBdBPp08v6ZYyDvegKPd1EE/MBgY+f0Dbe+0ScM7rz0K56UWeMgIFH1b18ADYAaVWBLR+sDf8f2oGPNyPI0eR22Hr0ZNznNr/2JgP8mOqzuP3wItCTUqV6j06qA0a9bFl48w/Mn+ovSqK1yz/DPclyaWTahfAbapy41xhHZe26wHC009q49Dn5YLg98tNs9LCmAsOHc3n3WQ9Hjtisw1PmcY80WykEiOF+1Rbuf3pMH0UGaA3pivDZVFtWEPG4Tmqy8XK0MzTgWmz/TAx+9zNTOkQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEoPqwv0XILFGnV3LNR7ws//TdmdrZpRWKmrkS+NKbQ=;
 b=XMQEWTvyKUuyjGmEgBuNpPHEQGxsFpmddaHyBOH3Sq3gBt/nUo0Nh7Wzmu3TW0kkL5N5kp8xSKb3dkbKmMvCdYm4CvSSPSJC5HvvxO+jhiNDiSRwlf6dE15UB4V9zaabnXIVGqp6FA2GGRrjUQFdpXYZ2XyS2LOP5aprAsAGHOsyA4oRUDNik+PBG/GTDSgpT9d1iezh45B6j2OYyM/+IZiNjRwSQ7vatJoBsxUichKzql7KlV6/SMo/qMvMDXLo6ydIbu5snsAXqGQP4Gb91H0xsykW6m4V6HzHMxOELZwDYZ7vhlHLnScv08kTpbiEKrJtvK96QQFZxakdApixCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 11:23:54 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 11:23:54 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
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
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAIPWoAAARG8AAAypJsAACbWn0A=
Date:   Fri, 27 Jan 2023 11:23:54 +0000
Message-ID: <DM8PR11MB57504DFB207175BD31E9F15AE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com> <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E5Cg7mreDx737N@redhat.com>
 <CAFLxGvwHRK3vyXiCv5ELvrDSEkcDgV5c6pNnWgWhcATfp1dedA@mail.gmail.com>
In-Reply-To: <CAFLxGvwHRK3vyXiCv5ELvrDSEkcDgV5c6pNnWgWhcATfp1dedA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|SN7PR11MB6776:EE_
x-ms-office365-filtering-correlation-id: f59fe3ac-b98e-4edc-3b1d-08db0058f954
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ht4TCem4WdYszBOA3m/1lHC2c3zwnKLvCFFJV0eWyNBv8PintP5f17cbDUyb7oGV9jJ7cAqfXEixR8/LpTh6NH7+819fD7Krzpuabyj4rsh5Br/TiGbXO4Cmh43sV2FciDbVZ5iEt8crTDEFv3emhoOwgtTUMOwXblWUzfjnxygqhmfku9QoMBM/xAiEZ+vItb5fshzPwiACjPAe2tcVHa6IOzxycCqWGvpJ//LXruxrnPkptu3ineQQo0DnGhCrfM33WnZ3VenOqDSzXm9j7DEBgFVyOMmqkXtu2yP4AGv6b/ed5esq8TDVn3kcuDIx1HjfKNvNAQ4t/1EnlsHppFY8Y+lCOmi4ssBTH9UJOntK3WBJcnjqmpP7UKmPFdflOIt9tD5c2VsyZ9Z/sdP6xUNWkbvrCdAHsU5FpLXzQ5j4P+i/cEb6U0ZeC5hyZ7pfOVMBTo4PcO//JMjct7Entx10M7oeEwotDo2ZFKOHH8clFhpw0V2gmUQjQS41h2cs7E7nGEWXhSGv0XFh2fakFPt+Fx9rQG9DLvzp8qf1gSAvfaW8ZkRyVYOh/JZfGOd+8g9Bay3wJh/m/sme8szyhnSMQotk1MLBC4em3VhCgpLlyL3oXuFDsMYOwQdV87E0syJ/x183xz5/R/TqKOITofJGvQHT0O3WMn0njFNPq4Zoi6b8rmGQfJFB+4yulKeBDEq7nGQmss6KEkBCYngJ+xaJPOIL6ZgR5mCcyxSnpdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199018)(83380400001)(41300700001)(86362001)(54906003)(110136005)(316002)(478600001)(7696005)(966005)(33656002)(53546011)(26005)(186003)(9686003)(6506007)(71200400001)(4326008)(76116006)(8676002)(64756008)(66446008)(66476007)(66946007)(66556008)(82960400001)(38100700002)(2906002)(38070700005)(8936002)(52536014)(55016003)(122000001)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3RJUG0wQUZGVld4Ui9sQ2tuZjgzM2VaU1gvRU9LWFFWbmNTeU1maVc2bXNm?=
 =?utf-8?B?akNtR2tsRHVkWm0vZGdBRmtvYjNzRzZiclkxNFdPbEhVVGE0OWZMaXUyWUpv?=
 =?utf-8?B?QndjVnNkZFV4RHB2TEFrbkFzcXh0dDB1UGF3Z0l3L0syb0hQVEd6Y0tJL2tv?=
 =?utf-8?B?ZXpMcFRGWVhZeWoxNUNpRVYrc1J4NGx1dnIxQjFMU2ZJbW5halFOK3Vjd1pm?=
 =?utf-8?B?Q2xaYjNyZlBNR0pVS05rZnZtNVJ3VGNWaGl5VWk5N1F1SmpNUHVJY0MyUDk0?=
 =?utf-8?B?NDBPalFhWVVPTUpPYytWQkZYWmdQa1N5ekludnZTeWFicXcxbGF5cEsrYWFr?=
 =?utf-8?B?MXJRZ3FDZVpzbm9kU1JtUE9NcFFCb2Q3Y1VQZDN3RzFDSVRKaEo1c2V1Sks4?=
 =?utf-8?B?VGh6WlZ0bGtvdFF2WnU3YVh5UzdzZjdvMkVIYnFIamRZZktOaEZ5dE1VRnZ0?=
 =?utf-8?B?SlBCR0cxZ1NOMERiTHhWT3VHRWY1Zk9RUjV5Q1VIdlRNb0h3L1N2N090Z2Vv?=
 =?utf-8?B?eit5OVpzL2luTE9uT09hZTd5ZG1zRVh5dDM4dWhKSjBTWkpxcllGVFNERUs2?=
 =?utf-8?B?TnhPTUZlSjdyMkR3NUxRM1lKK0xEZkVxZWJrcmxBZFBjcGJLdVYyOWdwZVZx?=
 =?utf-8?B?SU5NVFhkZFg4bDNib1grQm8rZlk4T2hJb29EdEtJdFZSUS8xUUJ4YU00VjFk?=
 =?utf-8?B?aDNib0c5R0ZKejdIdEdLNjM4SFZsN3dRNGxNV2g1WmZEMExxa3ZnUGhGNnFH?=
 =?utf-8?B?RUdUM2UzUjBST210b2RjSVhQS1lSUkZBMWJRZkxldEFWR1hiTmRrWVdVRzlW?=
 =?utf-8?B?c3hoUllIanpJcXdmT1E4bFhUMmNseHVZMHNqNUg3SmZwS1U0N21ZVHBkdjcy?=
 =?utf-8?B?R3NHNHQreFdUem0zZmxSSFpqR0VkTGlBSURIQm9uVWxOeFg3Nzlkeks2OVN6?=
 =?utf-8?B?OUNYWmF6M3ptczg3SFJGRmROSTkyRk9zdC8yS0EwTUpha2wzVlFiVHhUdWtp?=
 =?utf-8?B?ZStMMVh0aWd4bkNGaHdwNWNIL3hTVzd2UXdVUUd3dTJqdkFHODVPek52eTBj?=
 =?utf-8?B?eUF4MzZFYzRHeFJHeUs3WEpUZU5Vem1pR2tnUkxaV2U4L1pDZkwwMm01THdv?=
 =?utf-8?B?ZVd5Q0drYzNBWFVSdURTSysxSFpQbS9pNFlndkJwZFQxaVRmOWdiSUE1Tldi?=
 =?utf-8?B?NVlHQjFQUmFDYmdoSHBuTWxhcXdIUy9nd1hBQk1wSmVmR2NuZmx6S1lDL244?=
 =?utf-8?B?Z0cxdko4R1JuL3lqWlRUUnUxNVU0WFdKZy96c3Q4aFZrK2lFWEc5NWJJZXgx?=
 =?utf-8?B?T2t1ZWJuckJ3cjVDYktVSVdqcm5UTVBQbkxyK0xzOEVRQURXY09QdTgrTlFF?=
 =?utf-8?B?UHkzSFFhb25rcmsyaVhWN253M0hqMnpXMFZWa0ErZmZqd2dicXYvcW84Rm5H?=
 =?utf-8?B?cTlTMkttWmZIbG41SlYvOVh2M3ZRMG5zNVhqN245MnIrNC9PQjB0M0Q1ZTds?=
 =?utf-8?B?Vk1xV3lOY3lxeDJrQWlZbW54NWJzR2syc0NEODFYeFJZbFQ4ZUk0ZWs2WU1a?=
 =?utf-8?B?TmUydlhlSFpyRW1LWG1wZFBjblJUTkJjMEZtdEx0SitlcWQxWDE0Y0FCRE83?=
 =?utf-8?B?UHFOeS9uSjZoRGkrV0xRTGsrdzE3T3ZFdU9aV1ZqbmJLVlIyc25NbS9aUVlW?=
 =?utf-8?B?bUNMOUJpSG5rSE5EMTJOSW9mNzNSenNnTGx3eXhiMkI2TGY3a2FpZFdQUW9T?=
 =?utf-8?B?RDNzYVJSUStiVjRTZ081RG1Bc1RLeXE1a2RoblVORXBSbmNWazZ1THN4VzQw?=
 =?utf-8?B?VnNjekJ3YUt3SGdhSkpkaWhwVlVTUzZvYitsbFZCeHFUcnp5dElpTkcwaWlV?=
 =?utf-8?B?bmdRdlNvYitZcHl0WXk0VGtGMVB2Y1g2dFNxTG15Zk10SDdCa2JlUzRYeUVV?=
 =?utf-8?B?K3pLcmhjeGtiOVUwajk0TDNHTjBTYW9lSi82RWJaaldmOHNnYVdzN1Q5Um1p?=
 =?utf-8?B?L2g3cm8vUUs5T0E0SFduSVNLL21JY0JQTDU1V0toY3BzRTFsbG00YTRna3NL?=
 =?utf-8?B?cXV1S0dMWDNtOU1qQ1A0OHdDd25uWHNmVEJ3aXljWk5RMmlUejN0R3B2eDcv?=
 =?utf-8?Q?SzmUujbjts/v8AYYvlX8j5560?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59fe3ac-b98e-4edc-3b1d-08db0058f954
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 11:23:54.2745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SELsuo4eQMioO9SVaSRjN3Ly2nU3hlpr5E06RO5+AEOyhV26eaZzQBfJqZmdH1xEV4v+rnh1cZNmaIAEQwklEP/cGAMBBoUKlB/5HpxFivk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6776
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIEphbiAyNSwgMjAyMyBhdCAzOjIyIFBNIERhbmllbCBQLiBCZXJyYW5nw6kgPGJl
cnJhbmdlQHJlZGhhdC5jb20+DQo+IHdyb3RlOg0KPiA+IEFueSB2aXJ0dWFsIGRldmljZSBleHBv
c2VkIHRvIHRoZSBndWVzdCB0aGF0IGNhbiB0cmFuc2ZlciBwb3RlbnRpYWxseQ0KPiA+IHNlbnNp
dGl2ZSBkYXRhIG5lZWRzIHRvIGhhdmUgc29tZSBmb3JtIG9mIGd1ZXN0IGNvbnRyb2xsZWQgZW5j
cnlwdGlvbg0KPiA+IGFwcGxpZWQuIEZvciBkaXNrcyB0aGlzIGlzIGVhc3kgd2l0aCBGREUgbGlr
ZSBMVUtTLCBmb3IgTklDcyB0aGlzIGlzDQo+ID4gYWxyZWFkeSBiZXN0IHByYWN0aWNlIGZvciBz
ZXJ2aWNlcyBieSB1c2luZyBUTFMuIE90aGVyIGRldmljZXMgbWF5IG5vdA0KPiA+IGhhdmUgZ29v
ZCBleGlzdGluZyBvcHRpb25zIGZvciBhcHBseWluZyBlbmNyeXB0aW9uLg0KPiANCj4gSSBkaXNh
Z3JlZSB3cnQuIExVS1MuIFRoZSBjcnlwdG9ncmFwaHkgYmVoaW5kIExVS1MgcHJvdGVjdHMgcGVy
c2lzdGVudCBkYXRhDQo+IGJ1dCBub3QgdHJhbnNwb3J0LiBJZiBhbiBhdHRhY2tlciBjYW4gb2Jz
ZXJ2ZSBhbGwgSU8geW91IGJldHRlcg0KPiBjb25zdWx0IGEgY3J5cHRvZ3JhcGhlci4NCj4gTFVL
UyBoYXMgbm8gY29uY2VwdCBvZiBzZXNzaW9uIGtleXMgb3Igc3VjaCwgc28gdGhlIHNhbWUgZGlz
ayBzZWN0b3Igd2lsbA0KPiBhbHdheXMgZ2V0IGVuY3J5cHRlZCB3aXRoIHRoZSB2ZXJ5IHNhbWUg
a2V5L2l2Lg0KDQpJIGd1ZXNzIHlvdSBhcmUgcmVmZXJyaW5nIHRvIHRoZSBhZXMteHRzLXBsYWlu
NjQgbW9kZSBvZiBMVUtTIG9wZXJhdGlvbiBvcg0KdG8gTFVLUyBpbiBnZW5lcmFsPyBEaWZmZXJl
bnQgbW9kZXMgb2Ygb3BlcmF0aW9uIChpbmNsdWRpbmcgQUVBRCBtb2RlcykNCmNhbiBwcm92aWRl
IGRpZmZlcmVudCBsZXZlbHMgb2YgcHJvdGVjdGlvbiwgc28gSSB3b3VsZCBub3Qgc3RhdGUgaXQg
c28gZ2VuZXJhbGx5Lg0KQnV0IHRoZSBwb2ludCB5b3UgcmFpc2VkIGlzIGdvb2QgdG8gZGlzY3Vz
cyB0aHJvdWdoOiBYVFMgZm9yIGV4YW1wbGUgaXMgYSBjb25maWRlbnRpYWxpdHkgbW9kZSwNCmJh
c2VkIG9uIGEgY29uY2VwdCBvZiB0d2Vha2FibGUgYmxvY2tjaXBoZXIsIGRlc2lnbmVkIGFzIHlv
dSBwb2ludGVkIG91dA0Kd2l0aCBkaXNrIGVuY3J5cHRpb24gdXNlIGNhc2UgaW4gbWluZC4gSXQg
ZG9lcyBoYXZlIGEgYnVuY2ggb2YgbGltaXRhdGlvbnMvDQp3ZWFrbmVzc2VzIHRoYXQgYXJlIGtu
b3duIChnb29kIGNsYXNzaWNhbCByZWZlcmVuY2UgSSBjYW4gc3VnZ2VzdCBvbiB0aGlzIGlzIFsx
XSksDQpidXQgYXMgYW55IGJsb2NrY2lwaGVyIG1vZGUgaXRzIGNvbmZpZGVudGlhbGl0eSBndWFy
YW50ZWVzIGFyZSBldmFsdWF0ZWQgaW4gdGVybXMNCm9mIHNlY3VyaXR5IGFnYWluc3QgYSBjaG9z
ZW4gY2lwaGVydGV4dCBhdHRhY2sgKENDQSkgd2hlcmUgYW4gYWR2ZXJzYXJ5IGhhcyBhbiBhY2Nl
c3MgdG8gYm90aA0KZW5jcnlwdGlvbiBhbmQgZGVjcnlwdGlvbiBvcmFjbGUgKGhlIGNhbiBwZXJm
b3JtIGVuY3J5cHRpb25zIGFuZCBkZWNyeXB0aW9ucw0Kb2YgcGxhaW50ZXh0cy9jeXBoZXJ0ZXh0
cyBvZiBoaXMgbGlraW5nIHVwIHRvIHRoZSBhbGxvd2VkIG51bWJlciBvZiBxdWVyaWVzKS4gDQpU
aGlzIGlzIGEgdmVyeSBwb3dlcmZ1bCBhdHRhY2sgbW9kZWwgd2hpY2ggdG8gbWUgc2VlbXMgdG8g
Y292ZXIgdGhlIG1vZGVsDQpvZiB1bnRydXN0ZWQgaG9zdC9WTU0gYmVpbmcgYWJsZSB0byBvYnNl
cnZlIGRpc2sgcmVhZHMvd3JpdGVzLg0KDQpBbHNvLCBpZiBJIHJlbWVtYmVyIHJpZ2h0LCB0aGUg
ZGlzayBlbmNyeXB0aW9uIGFsc28gYXNzdW1lcyB0aGF0IHRoZSBkaXNrIG9wZXJhdGlvbnMgYXJl
IGZ1bGx5IHZpc2libGUNCnRvIHRoZSBhdHRhY2tlciwgaS5lLiBoZSBjYW4gc2VlIGFsbCBlbmNy
eXB0ZWQgZGF0YSBvbiB0aGUgZGlzaywgb2JzZXJ2ZSBob3cgaXQgY2hhbmdlcw0Kd2hlbiBhIG5l
dyBibG9jayBpcyB3cml0dGVuLCBldGMuIFNvLCB3aGVyZSBkbyB3ZSBoYXZlIGEgY2hhbmdlIGlu
IGFuIGF0dGFja2VyIG1vZGVsIGhlcmU/IA0KV2hhdCBhbSBJIG1pc3Npbmc/IA0KDQpXaGF0IEFF
UyBYVFMgd2FzIG5ldmVyIGRlc2lnbmVkIHRvIGRvIGlzIGFuIGludGVncml0eSBwcm90ZWN0aW9u
IChvbmx5IHNvbWUgdmVyeSBsaW1pdGVkIA0KbWFsbGVhYmlsaXR5KTogaXQgaXMgbm90IEFFQUQg
bW9kZSwgaXQgZG9lc27igJl0IGFsc28gcHJvdmlkZSBhIHJlcGxheSBwcm90ZWN0aW9uLiBTbywg
dGhlIHNhbWUNCmxpbWl0YXRpb25zIGFyZSBnb2luZyB0byBhcHBseSBpbiBvdXIgY2FzZSBhbHNv
LiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQoNClsxXSBDaGFwdGVyIDYuIFhUUyBtb2RlLCBo
dHRwczovL3dlYi5jcy51Y2RhdmlzLmVkdS9+cm9nYXdheS9wYXBlcnMvbW9kZXMucGRmDQoNCg==
