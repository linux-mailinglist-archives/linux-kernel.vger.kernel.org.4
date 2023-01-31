Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482D46829F3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjAaKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAaKH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:07:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6394B8A2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675159647; x=1706695647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ed9akHRwMqEmrZagKa/Cro5NN9zf3iT8cSkF2v4nERs=;
  b=JJuuBAIVI/G3Xz0XJrO4d30CcJr1S3KIjmuhRStkOQBOqe+WKsw97NYN
   +DYJw9n0IseqmpLi8howN3Hpg2LO9sScucy+ZKdvlTiiE/VSADd0pgIYV
   8QeYcU7S7MGvQI2IFxwNw1KVyj1NuC20jaJY4KKGTrHkCvthiiKxmpYd5
   BcdNz2xZZEjyjfOTUAr7CyICSk/TIjXRfxsgTQIDDGW8GXHShW/fmBj/o
   HqHKnfWn15qLI2wNzasVVds5jPigc5FAQImvK6Tv9xmNF8k/xmCBtrDFt
   BxM6doleM3OaB4kwgWhX4P1T13dRiYilcbTDiiNSCcG52JsHtR4LuUIMD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327817169"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="327817169"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 02:06:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="788387706"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="788387706"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2023 02:06:50 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 02:06:49 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 02:06:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 02:06:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 02:06:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kI5pgmY+WhBS/LbpsAacYHsgG9iaEtyyf6rrg8pbSJyWilArYJbJJPFUwBMsCYTg/fV6upOglZz8j1WlMPRrTTmYqzjMaWQsGxefh8ukaE1gA+0OxqQ+GiTXPGyGRABAXtov5cVtFU4tFwFBwE8vdSyWYay4s1r6d/50XnX7hFAjEq4RNDnnFN+2MeQKVRB+rH/PZdSc/u9IYgsPXl6SrNXJDZ3G3bYfERVFVBPZTKHSLcY05siHpG8RwLEcMtDiP9j8i/1lSdhsomnr4lqZ9cTtAaKfs5QvHCasuj1TCxgkiIADk3q3aiUNlLg6JDHfZrJZaUZrfGTOJ2UFTIet+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed9akHRwMqEmrZagKa/Cro5NN9zf3iT8cSkF2v4nERs=;
 b=jbYTgZ7H7i0dFNDgMi0NSuMKPUXDrdcGiAeKZ85ksdRHp5W7bUo+aq0iDq4y6/6nvq8obkre3bmoF5WZ3xcCEF6UTXw36Rm/cqyT8i9nT9nOGimQP+oPlfZqPcT8U/AYpsH+lbt8U8msMjum4UpilLeGhMo+mdfy/c34vwuODnANgPLk30gjWzLxF/PzQbMuR9PY8h3Ga48y2yMAuPnwmKu1rlnEU32WQwsovk2+HalWdtOKXD6RYCFXyO/tPRgJL60jVdc7mklvkWSTTSCwz+prPXdL9Sk3jX0oROxA1+GYZ5TclqzsIsM/jL5MuKrVcOkoX00Uw/CTEvEnXpNlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 10:06:43 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 10:06:43 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Christophe de Dinechin <dinechin@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwD7aSoAAC3pmnA=
Date:   Tue, 31 Jan 2023 10:06:42 +0000
Message-ID: <DM8PR11MB57504761DE92CE1213549C27E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <m2pmaw5jv4.fsf@redhat.com>
In-Reply-To: <m2pmaw5jv4.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|IA0PR11MB7257:EE_
x-ms-office365-filtering-correlation-id: f685cf2b-958e-48c8-a8b6-08db0372da6a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zg90Rr8ScPJDu/N77Lzj8h2F2EVNiQ+hpKML02opNR+j7fPZx3TQ0fL9vvhkMjRygQqn2lpzeC3upPbW3/8XRJJUV3+/Gzge+xH5Jsuzf81oe+tqO3O+5MyaP2pINGkLxMOPgRhR+07RPKxgn93me53GV5Vug/IgWw/hroqRiN3JFI5FpXrAaT61zap/bWeX3TKX+HAEObYUOFClxZu6BbUtARiYCLS+TrbwX2/icbzpHD9DRzN23wyBV8/1S65GUN2w+1X63aJE9DKK/th+HCaoAwmn9bSF2GzUOMaLZB1INVmTjXH4K1X8AfL42IvwyPF3vL/7cHHZfPwJaNYyNdnO8Sv8JoK4CzEabQycZn/uHygG6Cq1vdyLunNNmJRnAKvVVp4AhbmSM4iUqKAwCmfjO4lHLPZ/7LDa53j4ikvNKp0qwx2uiJpi/MuBR1rKVGYT9ozoOWv8glNUJtu3SmXCwBqIlIUIiBL/tEWCfJEoCmuDVt3JzCeXHk1VBAQyoim7HU/r3DZxXC9ayeHhQey/115b4w6GClgC/Z1TeOZj5oVomQ+o/lTsxnCVYkAz9SWjvjWwpBWO7vDr6IFolagSDmMlDwF1DPXk5a6oFIlz1GY5R1DY+qUl1BDTzn0FbzcbIRA8Ly2Em9PmNw4ByM+KylKkBrYTSSXG1s5M5EYh3BVh8A79QKLzeqHoWPnpNNjSr/AlhtWygOBDaFNXklvJ/741q9ec2RPhActPY5DX6zEN2fN0/y1MGydKv3HDlYLxhadmlXhIQRIYyVskQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(6506007)(71200400001)(83380400001)(2906002)(33656002)(7416002)(7696005)(38100700002)(82960400001)(122000001)(76116006)(66446008)(66556008)(9686003)(66476007)(86362001)(55016003)(66946007)(64756008)(26005)(966005)(186003)(38070700005)(478600001)(5660300002)(4326008)(54906003)(316002)(6916009)(8936002)(8676002)(41300700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEJXbVBKT2hWa3NnbDBrMUlOL3U2VE9ubGExUmJaVmQ4eUEyZDdTTGpEa2Fh?=
 =?utf-8?B?bEFtV2Z4Si81cmtiaklQRnl4bnJoaDRKT2gzYjdJaFNkVXdMVU9FWjEza0xI?=
 =?utf-8?B?bUpBZWo3TUxkbWFaaThBZEJ5OEJoeVg4bWE1Q1BJdlRmeFZ1bzBYYnBYZTdr?=
 =?utf-8?B?Yk9vSzJQRDVjUi8waUlIOTd6QWR5Y1BYdFJneEg0ZE8vRXdKNnp6VHY3dFpV?=
 =?utf-8?B?MzdYeUJZek9ENHlTSzNDVUt0NG9uc05UTjNiT3lPR0duTHhnZTlxWnN5TGwx?=
 =?utf-8?B?MGhhNVFxYVdIOVpqdFN4STgveEcrejFFVklhMWNzemZHZXQ0VTFSdEU3enUr?=
 =?utf-8?B?eFlOZ1ZGVmk3ZXZQRDdoU3FwMUpIUVVmZlFzQUxDY1c3RFVEaFFkWTFjeTEv?=
 =?utf-8?B?MklkTndVMVdRVi9NRGFnM21qb29NYVRTWnNJZWc4VDVscGl0bDdYWXBQU21Q?=
 =?utf-8?B?MThHRzU2K2d1aTVXN0VNY0h4bTN4ckhVZm0xZktSa2xtZ2ZYZWZVc05qazND?=
 =?utf-8?B?cHRMcisrM1IwTUN6aHJCeDRhUTdLbDYvUWIzQytpbDV3ek1TclRvYmdzVGhF?=
 =?utf-8?B?Y00wUG1ydk14UWFYWndMTkNIYkdSalhUMWVlUElQTE0yWS9nclQ2c0FFMkZm?=
 =?utf-8?B?T3dqaS96eWsrb1drdFIvZFVHRndyL2RWQUR5WmhwNkJ0ZlBidWpGaSsyVkVE?=
 =?utf-8?B?cFJvb3JNQ0VnTVdDQ3daRlJDS3N4M1hoY0g2dUdkVFBjSkdiYWdrclB4OG1C?=
 =?utf-8?B?eHdzRUFEK2RoZFdUaGxPS05VSldZaFNjZCtaVy82VGNrNjZ5VElWRFEvSHVU?=
 =?utf-8?B?Y1d5QlRzVDhXV2dFbWdlbG9qalE1N0lMTGRLd0lZZWlpWVcwWG4xcjhUWVhW?=
 =?utf-8?B?b0R1R0xDK2tFclJ0dE0ySU9pKzhTZW9wMS9NTXp6cHFtU2xteTcyUnJtZXc4?=
 =?utf-8?B?KzhKb1hvSUlmcUFvNTE5bWV6SVNwZ09Od0lyWStBWEZ5bmppZWY0cFpNS2Rq?=
 =?utf-8?B?T0FSYjcrZ1JaK0NiVXYray8rRGp5OWJjRjhYQ01ic1ZTNXJhSFZOblpQVzNo?=
 =?utf-8?B?RC9JaEhieWhpdm1TbkhMTFhyL05XWHlRMWdjWEpEc0wxRzBua1VMZG5yVHlt?=
 =?utf-8?B?dmZUWGdIT2pMcnJZMjdjcnN0M2hhNXlnb1lpalM0dVFSUHlINUtPMWdYWWNy?=
 =?utf-8?B?WWFiQjJVQkJjQ3pBdlFDeUNUL3QvZlRtRlRock5XbDZTY0NRU1k3bnF5MEsv?=
 =?utf-8?B?UDZFdGJpYkVWbmVCcUttTDVydUE1NEI0a0hqRVZvd3FTRUovdlJnSTVOOUNE?=
 =?utf-8?B?clJrOUcxTm9DU2FFQVdmS1FuaWFOVzdyUTgzMWZac3p0MDB6QXBIeXJBWHN2?=
 =?utf-8?B?Nkw2RnVDbG5PVlA5TXg0dFByMHc3Z01GLzVqd01KYktMcEhxSGI3N2JTNnhR?=
 =?utf-8?B?OW9jcENGV3dHdFR0TjBDczI5WGNPKzlQZVVxbjNuSU4wMnViQWdHM3FqZ2Jo?=
 =?utf-8?B?SVhTSWNzRnlxVmlYU1o4aktzZktkTHF4RWRTNWhlSFJOYWxXTHEwNUxlR0RK?=
 =?utf-8?B?YmRJUnoyeVhHNjE0VXdFOWRPenozWTZIOVZ4YWpMK2l3ZUc2NEkzcFF1M1pF?=
 =?utf-8?B?cDVzZW5hNktHNjNxaGZ2Lzg1WmhMekUzREZ6YVBpVm5CSThKRmRDU3BOWWNR?=
 =?utf-8?B?VkI1aU9DcllIeTBxR204YjIyQW1nd1M1RnZTTC9RUTNiWmRnelQwRlROMU0r?=
 =?utf-8?B?bUZ5YklWeDdaOTV3OVBPOUZRMEtCeTZHcVUxYW5PMitScmxQVEV1a2xnb3pq?=
 =?utf-8?B?SjQvSFB1WkEwTXJ6Z2RTTmVsOVVSOGE0QmhFQ2JsUm1IaVVCdDMrUXBXdlo1?=
 =?utf-8?B?T3lCK0hLcHBUeHBwTzRJQmdsRi9XQ3ROY2szWUNrNjF2dE14Y0dpYmVGRXA4?=
 =?utf-8?B?UldTT0FrNUh0OUExalJXSTRWdCtWTHRHejVzdFpqQm5CSWdaaUMxVlNSQi90?=
 =?utf-8?B?aHR6dm9WV0JIN1QzRGFmbnNUM21aR2NEbUVzNXZTY0NGeUJzdjlCaVM3aG5k?=
 =?utf-8?B?RjF0a1JGN0ppa0NBNVJYNjZjZCt3QlF1VVhsRXlYUVUrNUlvR0F1MkthY3ky?=
 =?utf-8?Q?WCwL8FGygNeBcxDUORta2c2oR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f685cf2b-958e-48c8-a8b6-08db0372da6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 10:06:42.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IELP+t7R+W6Yic5rhstSQFYkrCtNbGgvvZ/nvP4a6TsCK2wQqzf/Ntbm9NPmRAEUgBeQ889emAaqZHbS8TCpghfOR6xIn4TFAkrw51BgS/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGluZWNoaW4sDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgcmV2aWV3ISBQbGVh
c2UgZmluZCB0aGUgcmVwbGllcyBpbmxpbmUuIA0KDQo+IA0KPiBIaSBFbGVuYSwNCj4gDQo+IE9u
IDIwMjMtMDEtMjUgYXQgMTI6MjggVVRDLCAiUmVzaGV0b3ZhLCBFbGVuYSIgPGVsZW5hLnJlc2hl
dG92YUBpbnRlbC5jb20+DQo+IHdyb3RlLi4uDQo+ID4gSGkgR3JlZywNCj4gPg0KPiA+IFlvdSBt
ZW50aW9uZWQgY291cGxlIG9mIHRpbWVzIChsYXN0IHRpbWUgaW4gdGhpcyByZWNlbnQgdGhyZWFk
Og0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9ZODBXdHVqbk83a2ZkdUFaQGtyb2Fo
LmNvbS8pIHRoYXQgd2Ugb3VnaHQgdG8NCj4gc3RhcnQNCj4gPiBkaXNjdXNzaW5nIHRoZSB1cGRh
dGVkIHRocmVhdCBtb2RlbCBmb3Iga2VybmVsLCBzbyB0aGlzIGVtYWlsIGlzIGEgc3RhcnQgaW4g
dGhpcw0KPiBkaXJlY3Rpb24uDQo+ID4NCj4gPiAoTm90ZTogSSB0cmllZCB0byBpbmNsdWRlIHJl
bGV2YW50IHBlb3BsZSBmcm9tIGRpZmZlcmVudCBjb21wYW5pZXMsIGFzIHdlbGwgYXMNCj4gbGlu
dXgtY29jbw0KPiA+IG1haWxpbmcgbGlzdCwgYnV0IEkgaG9wZSBldmVyeW9uZSBjYW4gaGVscCBi
eSBpbmNsdWRpbmcgYWRkaXRpb25hbCBwZW9wbGUgYXMNCj4gbmVlZGVkKS4NCj4gPg0KPiA+IEFz
IHdlIGhhdmUgc2hhcmVkIGJlZm9yZSBpbiB2YXJpb3VzIGxrbWwgdGhyZWFkcy9jb25mZXJlbmNl
IHByZXNlbnRhdGlvbnMNCj4gPiAoWzFdLCBbMl0sIFszXSBhbmQgbWFueSBvdGhlcnMpLCBmb3Ig
dGhlIENvbmZpZGVudGlhbCBDb21wdXRpbmcgZ3Vlc3Qga2VybmVsLCB3ZQ0KPiBoYXZlIGENCj4g
PiBjaGFuZ2UgaW4gdGhlIHRocmVhdCBtb2RlbCB3aGVyZSBndWVzdCBrZXJuZWwgZG9lc27igJl0
IGFueW1vcmUgdHJ1c3QgdGhlDQo+IGh5cGVydmlzb3IuDQo+ID4gVGhpcyBpcyBhIGJpZyBjaGFu
Z2UgaW4gdGhlIHRocmVhdCBtb2RlbCBhbmQgcmVxdWlyZXMgYm90aCBjYXJlZnVsIGFzc2Vzc21l
bnQgb2YNCj4gdGhlDQo+ID4gbmV3IChoeXBlcnZpc29yIDwtPiBndWVzdCBrZXJuZWwpIGF0dGFj
ayBzdXJmYWNlLCBhcyB3ZWxsIGFzIGNhcmVmdWwgZGVzaWduIG9mDQo+IG1pdGlnYXRpb25zDQo+
ID4gYW5kIHNlY3VyaXR5IHZhbGlkYXRpb24gdGVjaG5pcXVlcy4gVGhpcyBpcyB0aGUgYWN0aXZp
dHkgdGhhdCB3ZSBoYXZlIHN0YXJ0ZWQgYmFjaw0KPiBhdCBJbnRlbA0KPiA+IGFuZCB0aGUgY3Vy
cmVudCBzdGF0dXMgY2FuIGJlIGZvdW5kIGluDQo+ID4NCj4gPiAxKSBUaHJlYXQgbW9kZWwgYW5k
IHBvdGVudGlhbCBtaXRpZ2F0aW9uczoNCj4gPiBodHRwczovL2ludGVsLmdpdGh1Yi5pby9jY2Mt
bGludXgtZ3Vlc3QtaGFyZGVuaW5nLWRvY3Mvc2VjdXJpdHktc3BlYy5odG1sDQo+IA0KPiBJIG9u
bHkgbG9va2VkIGF0IHRoaXMgb25lIHNvIGZhci4gSGVyZSBhcmUgYSBmZXcgcXVpY2sgbm90ZXM6
DQo+IA0KPiBEb1MgYXR0YWNrcyBhcmUgb3V0IG9mIHNjb3BlLiBXaGF0IGFib3V0IHRpbWluZyBh
dHRhY2tzLCB3aGljaCB3ZXJlIHRoZQ0KPiBiYXNpcyBvZiBzb21lIG9mIHRoZSBtb3N0IHN1Y2Nl
c3NmdWwgYXR0YWNrcyBpbiB0aGUgcGFzdCB5ZWFycz8gTXkNCj4gdW5kZXJzdGFuZGluZyBpcyB0
aGF0IFREWCByZWxpZXMgb24gZXhpc3RpbmcgbWl0aWdhdGlvbnMsIGFuZCBkb2VzIG5vdA0KPiBp
bnRyb2R1Y2UgYW55dGhpZ24gbmV3IGluIHRoYXQgc3BhY2UuIFdvcnRoIG1lbnRpb25pbmcgaW4g
dGhhdCAib3V0IG9mDQo+IHNjb3BlIiBzZWN0aW9uIElNTy4NCg0KSXQgaXMgbm90IG91dCBvZiB0
aGUgc2NvcGUgYmVjYXVzZSBURCBndWVzdCBTVyBoYXMgdG8gdGhpbmsgYWJvdXQgdGhlc2UNCm1h
dHRlcnMgYW5kIHByb3RlY3QgYWRlcXVhdGVseS4gV2UgaGF2ZSBhIHNlY3Rpb24gbG93ZXIgb24g
IiBUcmFuc2llbnQgRXhlY3V0aW9uIGF0dGFja3MNCm1pdGlnYXRpb24iIGh0dHBzOi8vaW50ZWwu
Z2l0aHViLmlvL2NjYy1saW51eC1ndWVzdC1oYXJkZW5pbmctZG9jcy9zZWN1cml0eS1zcGVjLmh0
bWwjdHJhbnNpZW50LWV4ZWN1dGlvbi1hdHRhY2tzLWFuZC10aGVpci1taXRpZ2F0aW9uDQpidXQg
SSBhZ3JlZSBpdCBpcyB3b3J0aCBwb2ludGluZyB0byB0aGlzIChhbmQgZ2VuZXJpYyBzaWRlLWNo
YW5uZWwgYXR0YWNrcykgYWxyZWFkeQ0KaW4gdGhlIHNjb3BpbmcuIEkgd2lsbCBtYWtlIGFuIHVw
ZGF0ZS4gDQoNCj4gDQo+IFdoeSBhcmUgVERWTUNBTEwgaHlwZXJjYWxscyBsaXN0ZWQgYXMgYW4g
ImV4aXN0aW5nIiBjb21tdW5pY2F0aW9uIGludGVyZmFjZT8NCj4gVGhhdCBzZWVtcyB0byBleGNs
dWRlIHRoZSBURFggbW9kdWxlIGZyb20gdGhlIFRDQi4NCg0KSSBiZWxpZXZlIHRoaXMgaXMganVz
dCBhbWJpZ3VvdXMgd29yZGluZywgSSBuZWVkIHRvIGZpbmQgYSBiZXR0ZXIgb25lLiANClREVk1D
QUxMIGlzIGluZGVlZCBhICpuZXcqIFREWCBzcGVjaWZpYyBjb21tdW5pY2F0aW9uIGludGVyZmFj
ZSwgYnV0IGl0IGlzDQpvbmx5IGEgdHJhbnNwb3J0IGluIHRoaXMgY2FzZSBmb3IgdGhlIGFjdHVh
bCAqZXhpc3RpbmcqIGxlZ2FjeSBjb21tdW5pY2F0aW9uIGludGVyZmFjZXMNCmJldHdlZW4gdGhl
IFZNIGd1ZXN0IGFuZCBob3N0L2h5cGVydmlzb3IgKHJlYWQvd3JpdGUgTVNScywgcGNpIGNvbmZp
ZyBzcGFjZQ0KYWNjZXNzLCBwb3J0IElPIGFuZCBNTUlPLCBldGMpLiANCg0KQWxzbywgInNoYXJl
ZCBtZW1vcnkgZm9yDQo+IEkvT3MiIHNlZW1zIHVubmVjZXNzYXJpbHkgcmVzdHJpY3RpdmUsIHNp
bmNlIGl0IGV4Y2x1ZGVzIGludGVycnVwdHMsIHRpbWluZw0KPiBhdHRhY2tzLCBuZXR3b3JrIG9y
IHN0b3JhZ2UgYXR0YWNrcywgb3IgZGV2aWNlcyBwYXNzZWQgdGhyb3VnaCB0byB0aGUgZ3Vlc3Qu
DQo+IFRoZSBsYXR0ZXIgY2F0ZWdvcnkgc2VlbXMgaW1wb3J0YW50IHRvIGxpc3QsIHNpbmNlIHRo
ZXJlIGFyZSBzZXBhcmF0ZQ0KPiBlZmZvcnRzIHRvIHByb3ZpZGUgY29uZmlkZW50aWFsIGNvbXB1
dGluZyBjYXBhYmlsaXRpZXMgZS5nLiB0byBQQ0kgZGV2aWNlcywNCj4gd2hpY2ggd2VyZSBkaXNj
dXNzZWQgZWxzZXdoZXJlIGluIHRoaXMgdGhyZWFkLg0KDQpUaGUgc2Vjb25kIGJ1bGxldCBtZWFu
dCB0byBzYXkgdGhhdCB3ZSBhbHNvIGhhdmUgYW5vdGhlciBpbnRlcmZhY2UgaG93IENvQ28gZ3Vl
c3QNCmFuZCBob3N0L1ZNTSBjYW4gY29tbXVuaWNhdGUgYW5kIGl0IGlzIGRvbmUgdmlhIHNoYXJl
ZCBwYWdlcyAodnMgcHJpdmF0ZSBwYWdlcyB0aGF0DQphcmUgb25seSBhY2Nlc3NpYmxlIHRvIGNv
bmZpZGVudGlhbCBjb21wdXRpbmcgZ3Vlc3QpLiBNYXliZSBJIHNob3VsZCBkcm9wIHRoZSAiSU8i
IHBhcnQgb2YNCnRoaXMgYW5kIGl0IHdvdWxkIGF2b2lkIGNvbmZ1c2lvbi4gVGhlIG90aGVyIG1l
YW5zIChzb21lIGFyZSBoaWdoZXItbGV2ZWwgYWJzdHJhY3Rpb25zDQpsaWtlIGRpc2sgb3BlcmF0
aW9ucyB0aGF0IGhhcHBlbiBvdmVyIGJvdW5jZSBidWZmZXIgaW4gc2hhcmVkIG1lbW9yeSksIGxp
a2UgaW50ZXJydXB0cywgZGlzaywgZXRjLA0Kd2UgZG8gY292ZXIgYmVsb3cgaW4gc2VwYXJhdGUg
c2VjdGlvbnMgb2YgdGhlIGRvYyB3aXRoIGV4Y2VwdGlvbiBvZiBjb3ZlcmluZyANCkNvQ28tZW5h
YmxlZCBkZXZpY2VzLiBUaGlzIGlzIHNtdGggd2UgY2FuIGJyaWVmbHkgbWVudGlvbiBhcyBhbiBh
ZGRpdGlvbiwgYnV0IHNpbmNlDQp3ZSBkb27igJl0IGhhdmUgdGhlc2UgZGV2aWNlcyB5ZXQsIGFu
ZCBuZWl0aGVyIHdlIGhhdmUgbGludXggaW1wbGVtZW50YXRpb24gdGhhdA0KY2FuIHNlY3VyZWx5
IGFkZCB0aGVtIHRvIHRoZSBDb0NvIGd1ZXN0LCBJIGZpbmQgaXQgcHJlbGltaW5hcnkgdG8gZGlz
Y3VzcyBkZXRhaWxzIGF0IHRoaXMgcG9pbnQuIA0KDQogDQo+IEkgc3VzcGVjdCB0aGF0IG15IHF1
ZXN0aW9uIGFib3ZlIGlzIGR1ZSB0byBhbWJpZ3VvdXMgd29yZGluZy4gV2hhdCBJDQo+IGluaXRp
YWxseSByZWFkIGFzICJ0aGlzIGlzIG91dCBvZiBzY29wZSBmb3IgVERYIiBtb3JwaHMgaW4gdGhl
IG5leHQNCj4gcGFyYWdyYXBoIGludG8gIndlIGFyZSBnb2luZyB0byBleHBsYWluIGhvdyB0byBt
aXRpZ2F0ZSBhdHRhY2tzIHRocm91Z2gNCj4gVERWTUNBTExTIGFuZCBzaGFyZWQgbWVtb3J5IGZv
ciBJL08iLiBDb25zaWRlciByZXdvcmRpbmcgdG8gY2xhcmlmeSB0aGUNCj4gaW50ZW50IG9mIHRo
ZXNlIHBhcmFncmFwaHMuDQo+IA0KDQpTdXJlLCBzb3JyeSBmb3IgYW1iaWd1b3VzIHdvcmRpbmcs
IHdpbGwgdHJ5IHRvIGNsYXJpZnkuIA0KDQo+IE5pdDogSSBzdWdnZXN0IGFkZGluZyBidWxsZXRz
IHRvIHRoZSBpdGVtcyBiZWxvdyAiYmV0d2VlbiBob3N0L1ZNTSBhbmQgdGhlDQo+IGd1ZXN0Ig0K
DQpZZXMsIGl0IHVzZWQgdG8gaGF2ZSBpdCBhY3R1YWxseSwgaGF2ZSB0byBzZWUgd2hhdCBoYXBw
ZW5lZCB3aXRoIHJlY2VudCBkb2NzIHVwZGF0ZS4gDQoNCj4gDQo+IFlvdSBjb3VsZCBjb3VudCB0
aGUgInVuaXF1ZSBjb2RlIGxvY2F0aW9ucyIgdGhhdCBjYW4gY29uc3VtZSBtYWxpY2lvdXMgaW5w
dXQNCj4gaW4gZHJpdmVycywgd2h5IG5vdCBpbiBjb3JlIGtlcm5lbD8gSSB0aGluayB5b3Ugd3Jp
dGUgZWxzZXdoZXJlIHRoYXQgdGhlDQo+IGRyaXZlcnMgYWNjb3VudCBmb3IgdGhlIHZhc3QgbWFq
b3JpdHksIHNvIEkgc3VzcGVjdCB5b3UgaGF2ZSB0aGUgbnVtYmVycy4NCg0KSSBkb27igJl0IGhh
dmUgdGhlIHJlYWR5IG51bWJlcnMgZm9yIGNvcmUga2VybmVsLCBidXQgaWYgcmVhbGx5IG5lZWRl
ZCwgSSBjYW4gY2FsY3VsYXRlIHRoZW0uIA0KSGVyZSBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwv
Y2NjLWxpbnV4LWd1ZXN0LWhhcmRlbmluZy90cmVlL21hc3Rlci9ia2MvYXVkaXQvc2FtcGxlX291
dHB1dC82LjAtcmMyDQp5b3UgY2FuIGZpbmQgdGhlIHB1YmxpYyBmaWxlcyB0aGF0IHdvdWxkIHBy
b2R1Y2UgdGhpcyBkYXRhOg0KDQpodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvY2NjLWxpbnV4LWd1
ZXN0LWhhcmRlbmluZy9ibG9iL21hc3Rlci9ia2MvYXVkaXQvc2FtcGxlX291dHB1dC82LjAtcmMy
L3NtYXRjaF93YXJuc182LjBfdGR4X2FsbHllc2NvbmZpZw0KaXMgYWxsIGhpdHMgKHdpdGggdGFp
bnQgcHJvcGFnYXRpb24pIGZvciB0aGUgd2hvbGUgYWxseWVzY29uZmlnICh4ODYgYnVpbGQsIENP
TkZJR19DT01QSUxFX1RFU1QgaXMgb2ZmKS4NCmh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9jY2Mt
bGludXgtZ3Vlc3QtaGFyZGVuaW5nL2Jsb2IvbWFzdGVyL2JrYy9hdWRpdC9zYW1wbGVfb3V0cHV0
LzYuMC1yYzIvc21hdGNoX3dhcm5zXzYuMF90ZHhfYWxseWVzY29uZmlnX2ZpbHRlcmVkDQppcyB0
aGUgc2FtZSBidXQgd2l0aCBtb3N0IG9mIHRoZSBkcml2ZXJzIGRyb3BwZWQuDQoNCg0KPiANCj4g
IlRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgI1ZFIGhhbmRsZXIgaXMgc2ltcGxlIGFuZCBkb2Vz
IG5vdCByZXF1aXJlIGFuDQo+IGluLWRlcHRoIHNlY3VyaXR5IGF1ZGl0IG9yIGZ1enppbmcgc2lu
Y2UgaXQgaXMgbm90IHRoZSBhY3R1YWwgY29uc3VtZXIgb2YNCj4gdGhlIGhvc3QvVk1NIHN1cHBs
aWVkIHVudHJ1c3RlZCBkYXRhIjogVGhlIGFzc3VtcHRpb24gdGhlcmUgc2VlbXMgdG8gYmUgdGhh
dA0KPiB0aGUgaG9zdCB3aWxsIG5ldmVyIGJlIGFibGUgdG8gc3VwcGx5IGRhdGEgKGUuZy4gdGhy
b3VnaCBhIGJvdW5jZSBidWZmZXIpDQo+IHRoYXQgaXQgY2FuIHRyaWNrIHRoZSBndWVzdCBpbnRv
IGV4ZWN1dGluZy4gSWYgdGhhdCBpcyBpbmRlZWQgdGhlDQo+IGFzc3VtcHRpb24sIGl0IGlzIHdv
cnRoIG1lbnRpb25pbmcgZXhwbGljaXRseS4gSSBzdXNwZWN0IGl0IGlzIGEgYml0IHdlYWssDQo+
IHNpbmNlIG1hbnkgZWFybGllciBhdHRhY2tzIHdlcmUgYmFzZWQgb24gZXhlY3V0aW5nIHRoZSB3
cm9uZyBjb2RlLiBOb3RhYmx5LA0KPiBpdCBpcyB3b3J0aCBwb2ludGluZyBvdXQgdGhhdCBJL08g
YnVmZmVycyBhcmUgX25vdF8gZW5jcnlwdGVkIHdpdGggdGhlIENQVQ0KPiBrZXkgKGFzIG9wcG9z
ZWQgdG8gYW55IGRldmljZSBrZXkgZS5nLiBmb3IgUENJIGVuY3J5cHRpb24pIGluIGVpdGhlcg0K
PiBURFggb3IgU0VWLiBJcyB0aGVyZSBmb3IgZXhhbXBsZSBhbnl0aGluZyB0aGF0IHByZWNsdWRl
cyBURFggb3IgU0VWIGZyb20NCj4gZXhlY3V0aW5nIGNvZGUgaW4gdGhlIGJvdW5jZSBidWZmZXJz
Pw0KDQpUaGlzIHdhcyBhbHJlYWR5IHJlcGxpZWQgYnkgS2lyaWxsLCBhbnkgY29kZSBleGVjdXRp
b24gb3V0IG9mIHNoYXJlZCBtZW1vcnkgZ2VuZXJhdGVzIA0KYSAjR1AuIA0KDQo+IA0KPiAiV2Ug
b25seSBjYXJlIGFib3V0IHVzZXJzIHRoYXQgcmVhZCBmcm9tIE1NSU8iOiBXaHk/IE15IGd1ZXNz
IGlzIHRoYXQgdGhpcw0KPiBpcyB0aGUgb25seSB3YXkgYmFkIGRhdGEgY291bGQgYmUgZmVkIHRv
IHRoZSBndWVzdC4gQnV0IHdoYXQgaWYgYSBiYWQgTU1JTw0KPiB3cml0ZSBkdWUgdG8gcG9pc29u
ZWQgZGF0YSBpbmplY3RlZCBlYXJsaWVyIHdhcyBhIG5lY2Vzc2FyeSBzdGVwIHRvIG9wZW4gdGhl
DQo+IGRvb3IgdG8gYSBzdWNjZXNzZnVsIGF0dGFjaz8NCg0KVGhlIGVudHJ5IHBvaW50IG9mIHRo
ZSBhdHRhY2sgaXMgc3RpbGwgYSAicmVhZCIuIFRoZSBzaXR1YXRpb24geW91IGRlc2NyaWJlIGNh
biBoYXBwZW4sDQpidXQgdGhlIHJvb3QgY2F1c2Ugd291bGQgYmUgc3RpbGwgYW4gaW5jb3JyZWN0
bHkgaGFuZGxlZCBNTUlPIHJlYWQgYW5kIHRoaXMgaXMgd2hhdA0Kd2UgdHJ5IHRvIGNoZWNrIHdp
dGggYm90aCBmdXp6aW5nIGFuZCBhdWRpdGluZyB0aGUgJ3JlYWQnIGVudHJ5IHBvaW50cy4gIA0K
DQpUaGFuayB5b3UgYWdhaW4gZm9yIHRoZSByZXZpZXchDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5h
Lg0KDQoNCg0KDQo=
