Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F0567CC2A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjAZN3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjAZN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:28:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5936A57
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674739703; x=1706275703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QMZoErfyC+e/7CMDuR5fEeg4evQf7dLFcE1ExakYo4w=;
  b=JtXE74IhsYagk6MfMXSERhu9l45BE9fa7jxuuS9S+aCh4vGJUmMUr8El
   KWEFhHGRepXAo3Pots0dNGEPg+qIPjeutivl36XQ/wl9DM7e/MUmUFObD
   JFstbz0pTQVASuD78YYVwV0OHiAmCNzuK68MRUjFsLS2ryRonIuDyduyS
   YKoQZB3NN/qjQ3Mp/gbaqqPJVpOTjuZZ6RSYT70dnvGrmTXVXXIXp+kKQ
   07xn3nhT7UKcojMySiyTcK1mZM8XCrgVXfRNmJ7RS6A4E73JpunAqD6qu
   w451jt3cpksB+AfaT+xaoO2Su1QQNSCz5aSVkySGpUIw+Y0A0gasaciwA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="413037643"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="413037643"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 05:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="771136249"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="771136249"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2023 05:28:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 05:28:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 05:28:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 05:28:20 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 05:28:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnaPaJ+8YZr7ToXe7wDSK83MctrnlyGnEPgW/Bs+rTVhOR/DMUpyi3ZdDrqsg/s6sDbdrJ/ScsOELbu6wcM/TqsPyx3OKuKJabsfNMBB5ieb3LP8GIyLjfBPjaS34u7O/hdgrV2c7EBioX+TfmueWZREC98d3jQPHcBI4ZKqG1LWCWd1q319Wnw+L9o9EJZjmE1NpkdUMSTzum14AkOgZzaaNP/xjy6lM34hZNU62vqHZAxGQP3q5IIv8lU19PADE4qppUAekratiIOTmCOEQJlwS+95EPZIpRz5UPv7fN1+VWV5a8lzRrrO1wYBSTO9TwpUMkBsYSnnt355UMeg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMZoErfyC+e/7CMDuR5fEeg4evQf7dLFcE1ExakYo4w=;
 b=UaifEKqH0f3w0PKPkxAW4FcmmWve9UNAwQAxl8I6SDROxbwsKrT0IeAHz9mM/DTmtrrktxM5ezZN+shG7ZAAfh6Iip9CoP28ib5fAk4sZifwosIkt8jakh74W0cPhX1SZqfWcQeUeu28jMoi8kxghOrzmjrUSomg0ZgNjS/k3RH8J3H93FE9JVuBHWkZjbqvGfyplunedHWdB7CnRSutVwKkeq0horNKf+Wiu3b9+GsJuiMI4o67krdgPfgM7/+9gP2GSDFWQPCSHPaPVgBEwZlCIS3wmTmMxqaISLNfaknL/oqykzxUSLys2JelmQmV6BC3DQEWii4iQiW9cLgySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Thu, 26 Jan 2023 13:28:16 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 13:28:16 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
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
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067AAKubQgAAALAEwAAJJbIAAAYhDQA==
Date:   Thu, 26 Jan 2023 13:28:15 +0000
Message-ID: <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9Jh2x9XJE1KEUg6@unreal>
 <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9JyW5bUqV7gWmU8@unreal>
In-Reply-To: <Y9JyW5bUqV7gWmU8@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DS0PR11MB6469:EE_
x-ms-office365-filtering-correlation-id: 26e35421-f5e7-4f40-edd4-08daffa12e57
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: htuLbgTTpNNeZODWm1sIVKyc9QE70bC6kdrcdMQathg7qmEgv1YTz0cvSVU2veEG8OPLWKXGbBxS3uo7iv+dvm5Jk6mTz6vUbgTEiRHVxMyRxFYmtknZuEA69DrcGHUqE86vJfYPLvmpfmXfO60wSfzIhb5VbP6wtJRUDxkYtQM/yWCXepoTjqsb+/D29mVXxTrYjU+2qgxxHZaORpppphU6cc7v9xmuEUCtSk2pQ39EIFciPHxfOYwVyp/Q+BDU+aRz5t/imEnyxNR0Hqy+VR3jbQaSytIC74KdnoFwue8jy6kgV/HjybFuTjATQRYT4aGKQzM0TRO+s7SdIeLr5C8r/CaAiRH47AhyFaTh5mNiCofm6++6vyJOES6I5RMVm51Em2XJ7onwkVsuYpHWcEQILnYvR/xE17nOSkn0N5M5nHic9U8hyphL4oz1pGR/NMD/rddaQQRutuNEE0+MMoe1EnrMgx6OL4BzFfKymJRC2pTAwJw4gEhJhFJ4S70cKakJdX9OyXJNfal3F+UxdFqbMJLRlc0zTyU/PyCdAUupleHDKoUPfDg4tZJZEffsldPmQumfBz/hcFGi2DxfLCXeFzOyj9xszxmMLnq+k/uTALE2FsAM23tFJ3vmho/CcwjGN8ZR14mLhmDqHHwTTfsNOWztzA2I+BZq5CSqqsbPKLzvpj4lEbZY6WEVE1G+7WN2NyQhmNeOP8IHjvyFAowOlDH+865gsyIN7gYs8rZQEgF6HRPoVoz9/oCIm7lZomFGzNJvca75cnFxUsnpbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199018)(64756008)(316002)(54906003)(122000001)(38100700002)(41300700001)(8676002)(76116006)(66556008)(4326008)(66946007)(66476007)(6916009)(5660300002)(7416002)(86362001)(8936002)(38070700005)(52536014)(55016003)(2906002)(33656002)(82960400001)(6506007)(66446008)(9686003)(26005)(186003)(966005)(478600001)(7696005)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1l5dFJDZ09JeFVLd1QzcWxGZDVXT2VEWVV2SVVPcTlkN3BzNCtCWiszZ3dF?=
 =?utf-8?B?VThRM0N4ckl4VFVGL1dOcmZERk1sVVZzK1llNnk1QkFnYlRtV3FFVnJjMU4x?=
 =?utf-8?B?RHl0UytiQjZySVVvaEp4YnBXOVdZVFh0d1RLejJpRklHbTRRaFgwUVBDcFRP?=
 =?utf-8?B?UjZDSVoxM0VqcUFoT2RrOUFyUFk5SENTNmRvazFzMmdkeXllelEwVmJVUlln?=
 =?utf-8?B?ZUFqS3ZEaFZUc3U0QTg1aDdRMU1kcTJCazBMQzYzUlNwcGhiVHBlUzhJcEtm?=
 =?utf-8?B?UzFVa3V2bElxeUZZc3k3UE5QTVFGOEJFSE5KMkphNnBuRE5JMTNhaWF4Wk9m?=
 =?utf-8?B?WDNKcU96QUkyTXpjb2cyZEF1aUU4WmVJTU5VdGpBMDhOclpaY0VLUmVIQytn?=
 =?utf-8?B?WmRJemd4ck9zY3JMWTcwMlhXR0lZdmpqQmxZeWl5NCtCRjhZQWN0MXhlck8y?=
 =?utf-8?B?Y1o4Ymdia1RLSmpJdEcxcEs1RklGc3Z5Y2lHQkV3aDZUdVFtYklxeVEvdjJY?=
 =?utf-8?B?YXZBZnRUYVVQQkJjZ1pZZzBzVTI2SjZHUWdCTDFFN1VPNEpJWnBBZDNmd0Mv?=
 =?utf-8?B?VFFTcXVkd3ROb013SC9HcERGcXdPK1Y5UkQ3NG54YXA5cGs2Q2F5TXVwWU5w?=
 =?utf-8?B?RTlEdzdISlZMa2tWcjhsNFJ5K3hwL3hmTVQ5bitSWG95WnBXa3FIb3V2ekZM?=
 =?utf-8?B?WFN1dk5aZUxkZGg0MGV0NFdFUEJ5Y0FHMEpmaWtST3FneWdqVk43YTFhZ3Fo?=
 =?utf-8?B?NWRWeGxXYnhBTXFMQ1piWFlJeEJwb3p5emtRdnlqbFhXM3ViNmJNdHFVOFV1?=
 =?utf-8?B?VE5Rb0pCNmhNT1N2WXU2ZmEvWHRLcGl3S25ReEE4MkF0NW9XOUN3Mk9scVlH?=
 =?utf-8?B?M3JDamM4cjVFU1lhc2NocmoxVFpGbmU2VDF1VHdETVlST3E2QzRnR3Iwc09r?=
 =?utf-8?B?eEszYytQYWxydVI2TU9iak8zUnMzdmU1dmViYkdVbkhLN3lYdkNGTWtWelhJ?=
 =?utf-8?B?emxnZlRuaFYxSXVwWVU3YTBnNnkyOVJjNll6a0JzVnVHWVpDRVJmd25lT0hj?=
 =?utf-8?B?ZURGbE9PcXVRenovU00yZDNRbWZrODhJS2Z5c2pMRnZsUUZET2piaFREWjdR?=
 =?utf-8?B?VEF1bDV1bU4vZlNxQy9GVzdyVktvblZrQzlnWFlrQXcvYU51U2tZT1NzMEVW?=
 =?utf-8?B?bC9YcHM5MHdoeWloWEg1NDBKVlhyK3V5NmJGRjdUdFJBajhBUkpIdEdlV1F0?=
 =?utf-8?B?aTdHSXZwN0ptWFVDeGdndG5RcE1BZUxmdXJwZzFjeGhZeE5NdS9xVlUwVU5k?=
 =?utf-8?B?YjF0NlJEd2tzWUNNRW5mUmtCc3B5aUtyNEwraElGdmxHUjZmalJlZkQzdDZk?=
 =?utf-8?B?czZrVHZYTzNaZHRkVzZNdHM5VU9WcFkzTmc2SW1GZEV5eVByL0hwR0NDYXdo?=
 =?utf-8?B?dUsybmU2cmlWaklRNjR2RmNscDNWZXcwLytXL1VxRCtmNVZkRzFvTW5rOVJT?=
 =?utf-8?B?S0RpVk13Q2FQbVl0UGZxZHJITzliVXlEVVdaeCtmWjYrTE5IckxYWnJRdWd3?=
 =?utf-8?B?S2drOHRZeXdHMTJHQ2E0V29ybmtRSEhEYmZTVWYxZ2toM2hrcENhaUlXT2FZ?=
 =?utf-8?B?SllhT252enVNZDlFMXZ5cFRvQkxaSFJNRWMybDl6QVFqQlFEajFmTW4xUm9i?=
 =?utf-8?B?QjJIRVdJSlVCL1pCZkhuYXJ2QkVCMzBRaVFFRm5vUi9EUWdTNUg4cWhCUFl0?=
 =?utf-8?B?WVhJd3lHNSsvUG5RVjUvTjE0cGdJb2tDbEFWVGpGZ096a0EwVWwwRnYzZ0M3?=
 =?utf-8?B?S0pvT2didGczUVFRemI1ZkthVWkvalVpbnFYbGxpaDdSenV3ejJrMmZTeURh?=
 =?utf-8?B?SytSNVc2TUJlOHZwV0UveWVFVGRLYXJQZStHL2VZTTJkdGRJWnA0QitoYmxE?=
 =?utf-8?B?VytaeDR1c3NiRUZ2b1JzZW9FRGdna1phSHFsMi8vSkpINUJ5NUpBVjFLNVZa?=
 =?utf-8?B?bERMZ1Vpdk5kS2hxZzZZNUVoMVRTZVdmbE9SMGFjSFRZbFczRGdCQ0VWYTN4?=
 =?utf-8?B?Q0V2clcyVHdxOFRyRnBOL0Fsb2lWTEkycGFxaXVNUUdZeXVpM3Uzdk0wcTRa?=
 =?utf-8?Q?qqACWaJBZ7rOU1IevPTSNFXfU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e35421-f5e7-4f40-edd4-08daffa12e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 13:28:15.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r93/mkCjSTunVDsUkyosFXVzveTOq+qyF0jyPwqmHqCrtNbqB1uq5e2sPCoAeaKBLHIclCn/E3nQ4xYsWpfDLpiLtd9RnVU9PulONadPIlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIEphbiAyNiwgMjAyMyBhdCAxMToyOToyMEFNICswMDAwLCBSZXNoZXRvdmEsIEVs
ZW5hIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBKYW4gMjUsIDIwMjMgYXQgMDM6Mjk6MDdQTSArMDAw
MCwgUmVzaGV0b3ZhLCBFbGVuYSB3cm90ZToNCj4gPiA+ID4gUmVwbHlpbmcgb25seSB0byB0aGUg
bm90LXNvLWZhciBhZGRyZXNzZWQgcG9pbnRzLg0KPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFdlZCwg
SmFuIDI1LCAyMDIzIGF0IDEyOjI4OjEzUE0gKzAwMDAsIFJlc2hldG92YSwgRWxlbmEgd3JvdGU6
DQo+ID4gPiA+ID4gPiBIaSBHcmVnLA0KPiA+ID4NCj4gPiA+IDwuLi4+DQo+ID4gPg0KPiA+ID4g
PiA+ID4gMykgQWxsIHRoZSB0b29scyBhcmUgb3Blbi1zb3VyY2UgYW5kIGV2ZXJ5b25lIGNhbiBz
dGFydCB1c2luZyB0aGVtIHJpZ2h0DQo+ID4gPiBhd2F5DQo+ID4gPiA+ID4gZXZlbg0KPiA+ID4g
PiA+ID4gd2l0aG91dCBhbnkgc3BlY2lhbCBIVyAocmVhZG1lIGhhcyBkZXNjcmlwdGlvbiBvZiB3
aGF0IGlzIG5lZWRlZCkuDQo+ID4gPiA+ID4gPiBUb29scyBhbmQgZG9jdW1lbnRhdGlvbiBpcyBo
ZXJlOg0KPiA+ID4gPiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2NjYy1saW51eC1ndWVz
dC1oYXJkZW5pbmcNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFnYWluLCBhcyBvdXIgZG9jdW1lbnRh
dGlvbiBzdGF0ZXMsIHdoZW4geW91IHN1Ym1pdCBwYXRjaGVzIGJhc2VkIG9uDQo+ID4gPiA+ID4g
dGhlc2UgdG9vbHMsIHlvdSBIQVZFIFRPIGRvY3VtZW50IHRoYXQuICBPdGhlcndpc2Ugd2UgdGhp
bmsgeW91IGFsbCBhcmUNCj4gPiA+ID4gPiBjcmF6eSBhbmQgd2lsbCBnZXQgeW91ciBwYXRjaGVz
IHJlamVjdGVkLiAgWW91IGFsbCBrbm93IHRoaXMsIHdoeSBpZ25vcmUNCj4gPiA+ID4gPiBpdD8N
Cj4gPiA+ID4NCj4gPiA+ID4gU29ycnksIEkgZGlkbuKAmXQga25vdyB0aGF0IGZvciBldmVyeSBi
dWcgdGhhdCBpcyBmb3VuZCBpbiBsaW51eCBrZXJuZWwgd2hlbg0KPiA+ID4gPiB3ZSBhcmUgc3Vi
bWl0dGluZyBhIGZpeCB0aGF0IHdlIGhhdmUgdG8gbGlzdCB0aGUgd2F5IGhvdyBpdCBoYXMgYmVl
biBmb3VuZC4NCj4gPiA+ID4gV2Ugd2lsbCBmaXggdGhpcyBpbiB0aGUgZnV0dXJlIHN1Ym1pc3Np
b25zLCBidXQgc29tZSBidWdzIHdlIGhhdmUgYXJlIGZvdW5kDQo+IGJ5DQo+ID4gPiA+IHBsYWlu
IGNvZGUgYXVkaXQsIHNvICdodW1hbicgaXMgdGhlIHRvb2wuDQo+ID4gPg0KPiA+ID4gTXkgcHJv
YmxlbSB3aXRoIHRoYXQgc3RhdGVtZW50IGlzIHRoYXQgYnkgYXBwbHlpbmcgZGlmZmVyZW50IHRo
cmVhdA0KPiA+ID4gbW9kZWwgeW91ICJpbnZlbnQiIGJ1Z3Mgd2hpY2ggZGlkbid0IGV4aXN0IGlu
IGEgZmlyc3QgcGxhY2UuDQo+ID4gPg0KPiA+ID4gRm9yIGV4YW1wbGUsIGluIHRoaXMgWzFdIGxh
dGVzdCBzdWJtaXNzaW9uLCBhdXRob3JzIGxhYmVsZWQgY29ycmVjdA0KPiA+ID4gYmVoYXZpb3Vy
IGFzICJidWciLg0KPiA+ID4NCj4gPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyMzAxMTkxNzA2MzMuNDA5NDQtMS0NCj4gPiA+IGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5p
bnRlbC5jb20vDQo+ID4NCj4gPiBIbS4uIERvZXMgZXZlcnlvbmUgdGhpbmsgdGhhdCB3aGVuIGtl
cm5lbCBkaWVzIHdpdGggdW5oYW5kbGVkIHBhZ2UgZmF1bHQNCj4gPiAoc3VjaCBhcyBpbiB0aGF0
IGNhc2UpIG9yIGRldGVjdGlvbiBvZiBhIEtBU0FOIG91dCBvZiBib3VuZHMgdmlvbGF0aW9uIChh
cyBpdCBpcyBpbg0KPiBzb21lDQo+ID4gb3RoZXIgY2FzZXMgd2UgYWxyZWFkeSBoYXZlIGZpeGVz
IG9yIGludmVzdGlnYXRpbmcpIGl0IHJlcHJlc2VudHMgYSBjb3JyZWN0DQo+IGJlaGF2aW9yIGV2
ZW4gaWYNCj4gPiB5b3UgZXhwZWN0IHRoYXQgYWxsIHlvdXIgcGNpIEhXIGRldmljZXMgYXJlIHRy
dXN0ZWQ/DQo+IA0KPiBUaGlzIGlzIGV4YWN0bHkgd2hhdCBJIHNhaWQuIFlvdSBwcmVzZW50ZWQg
bWUgdGhlIGNhc2VzIHdoaWNoIGV4aXN0IGluDQo+IHlvdXIgaW52ZW50ZWQgd29ybGQuIE1lbnRp
b25lZCB1bmhhbmRsZWQgcGFnZSBmYXVsdCBkb2Vzbid0IGV4aXN0IGluIHJlYWwNCj4gd29ybGQu
IElmIFBDSSBkZXZpY2UgZG9lc24ndCB3b3JrLCBpdCBuZWVkcyB0byBiZSByZXBsYWNlZC9ibG9j
a2VkIGFuZCBub3QNCj4gbGVmdCB0byBiZSBvcGVyYWJsZSBhbmQgYWNjZXNzaWJsZSBmcm9tIHRo
ZSBrZXJuZWwvdXNlci4NCg0KQ2FuIHdlIHJlYWxseSBhc3N1cmUgY29ycmVjdCBvcGVyYXRpb24g
b2YgKmFsbCogcGNpIGRldmljZXMgb3V0IHRoZXJlPyANCkhvdyB3b3VsZCBzdWNoIGFuIGF1ZGl0
IGJlIHBlcmZvcm1lZCBnaXZlbiBhIGh1Z2Ugc2V0IG9mIHRoZW0gYXZhaWxhYmxlPyANCklzbnQg
aXQgYmV0dGVyIGluc3RlYWQgdG8gbWFrZSBhIHNtYWxsIGZpeCBpbiB0aGUga2VybmVsIGJlaGF2
aW9yIHRoYXQgd291bGQgZ3VhcmQNCnVzIGZyb20gc3VjaCBwb3RlbnRpYWxseSBub3QgY29ycmVj
dGx5IG9wZXJhdGluZyBkZXZpY2VzPyANCg0KDQo+IA0KPiA+IFdoYXQgYWJvdXQgYW4gZXJyb3Ig
aW4gdHdvIGNvbnNlcXVlbnQgcGNpIHJlYWRzPyBXaGF0IGFib3V0IGp1c3Qgc29tZQ0KPiA+IGZh
aWx1cmUgdGhhdCByZXN1bHRzIGluIGVycm9uZW91cyBpbnB1dD8NCj4gDQo+IFllcywgc29tZSBi
dWdzIG5lZWQgdG8gYmUgZml4ZWQsIGJ1dCB0aGV5IGFyZSBub3QgcmVsYXRlZCB0byB0cnVzdC9u
b3QtdHJ1c3QNCj4gZGlzY3Vzc2lvbiBhbmQgUENJIHNwZWMgdmlvbGF0aW9ucy4NCg0KTGV0J3Mg
Zm9yZ2V0IHRoZSB0cnVzdCBhbmdsZSBoZXJlIChpdCBvbmx5IGFwcGxpZXMgdG8gdGhlIENvbmZp
ZGVudGlhbCBDb21wdXRpbmcgDQp0aHJlYXQgbW9kZWwgYW5kIHlvdSBjbGVhcmx5IGltcGx5aW5n
IHRoZSBleGlzdGluZyB0aHJlYXQgbW9kZWwgaW5zdGVhZCkgYW5kIHN0aWNrIGp1c3QgdG8NCnRo
ZSBub3QtY29ycmVjdGx5IG9wZXJhdGluZyBkZXZpY2UuIFdoYXQgeW91IGFyZSBwcm9wb3Npbmcg
aXMgdG8gZml4ICp1bmtub3duKiBidWdzDQppbiBtdWx0aXR1ZGUgb2YgcGNpIGRldmljZXMgdGhh
dCAoaW4gY2FzZSBvZiB0aGlzIHBhcnRpY3VsYXIgTVNJIGJ1ZykgY2FuDQpsZWFkIHRvIHR3byBk
aWZmZXJlbnQgdmFsdWVzIGJlaW5nIHJlYWQgZnJvbSB0aGUgY29uZmlnIHNwYWNlIGFuZCBrZXJu
ZWwgaW5jb3JyZWN0bHkNCmhhbmRpbmcgdGhpcyBzaXR1YXRpb24uIElzbid0IGl0IGJldHRlciB0
byBkbyB0aGUgY2xlYXIgZml4IGluIG9uZSBwbGFjZSB0byBlbnN1cmUgc3VjaA0Kc2l0dWF0aW9u
ICh0d28gc3Vic2VxdWVudCByZWFkcyB3aXRoIGRpZmZlcmVudCB2YWx1ZXMpIGNhbm5vdCBldmVu
IGhhcHBlbiBpbiB0aGVvcnk/DQpJbiBzZWN1cml0eSB3ZSBoYXZlIGEgc2F5aW5nIHRoYXQgZml4
aW5nIGEgcm9vdCBjYXVzZSBvZiB0aGUgcHJvYmxlbSBpcyB0aGUgbW9zdCBlZmZpY2llbnQNCndh
eSB0byBtaXRpZ2F0ZSB0aGUgcHJvYmxlbS4gVGhlIHJvb3QgY2F1c2UgaGVyZSBpcyBhIGRvdWJs
ZS1yZWFkIHdpdGggZGlmZmVyZW50IHZhbHVlcywNCnNvIGlmIGl0IGNhbiBiZSBzdWJzdGl0dXRl
ZCB3aXRoIGFuIGVhc3kgYW5kIGNsZWFyIHBhdGNoIHRoYXQgcHJvYmFibHkgZXZlbiBpbXByb3Zl
cw0KcGVyZm9ybWFuY2UgYXMgd2UgZG8gb25lIGxlc3MgcGNpIHJlYWQgYW5kIHVzZSBjYWNoZWQg
dmFsdWUgaW5zdGVhZCwgd2hlcmUgaXMgdGhlDQpwcm9ibGVtIGluIHRoaXMgcGFydGljdWxhciBj
YXNlPyBJZiB0aGVyZSBhcmUgdGVjaG5pY2FsIGlzc3VlcyB3aXRoIHRoZSBwYXRjaCwgb2YgY291
cnNlIHdlIA0KbmVlZCB0byBkaXNjdXNzIGl0L2ZpeCBpdCwgYnV0IGl0IHNlZW1zIHdlIGFyZSBh
cmd1aW5nIGhlcmUgYWJvdXQgd2hlbmV2ZXIgb3Igbm90IHdlIHdhbnQNCnRvIGJlIGZpeGluZyBr
ZXJuZWwgY29kZSB3aGVuIHdlIG5vdGljZSBzdWNoIGNhc2VzLi4uIA0KDQpCZXN0IFJlZ2FyZHMs
DQpFbGVuYQ0KIA0KIA0K
