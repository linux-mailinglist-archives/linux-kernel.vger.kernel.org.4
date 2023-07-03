Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9188745761
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGCId5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGCIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:33:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB18E41;
        Mon,  3 Jul 2023 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688373235; x=1719909235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xCUSjTIfUb6gg93ggCOBCULcT3110jId15J9bZGaEdY=;
  b=ky0KmUEyUId5JEK34435Gif85HAVWgZ7o9qW1ow4wb1zc8QUnHMBJvva
   XhL0roxHkW4HsAoJw5/dl5yixm+402mAI6gu/HkCFPIcudtVjXd7pnmpE
   y8P7k1s1+kQrcpPK+Dc6VHEV811UOeCKZ4KgaPZ6FQfgHYuPYG0t5ZCaL
   t5zG3HlAnJbqLau+u73FphMazOaRf+aH7EToZ2T+z6Lmg8jGofOWjnSek
   kBAMSXezmg2ewRYZb2ay7WSJSo4OuyCuQTTfR1GcsgISUCfuuaGRXdRGk
   QVObr3k7CNRyUXxOdiouYBXilEYbg/yGst7QF5ugUmvoOfiGNju/8Bnt0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="426508520"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="426508520"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="788447552"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="788447552"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2023 01:33:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 01:33:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 01:33:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 01:33:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 01:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB6FksA4pTVIuiVqE7PLqLDkVq9yd0GSjgFpBL/RcK6/7zdQ6qfHXhVAJFLBhxKYdDkXyhGCYUxMwAYP54vhcIvTBOMNxmP7GjSx8mSfA84BUPd6ZbO9sbu+9Uach8LFyLaZo2QgCdY/MECVLdgtYfFVZeAzqbHq0TX0N4oqOGB0W2ocVMqrJtNaWPAToPcY3a0fKuD4MfjIn8C1k5hr/Gngd0Tp+K7XWsvgx64Nx4bbJuvaXDfJMdDptuFRMXy3CTOnlrxYP2PoeX6WRU2hTqbxblSXfbQfbzN8TPBObfIrnlNPPYN9I8B8CXapvtUm2dqdijF6ie0fk2Cts2RkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCUSjTIfUb6gg93ggCOBCULcT3110jId15J9bZGaEdY=;
 b=hkbRisB6TgC0HMPaYAKMkxi0I3HKLCJ2H1Oh1rbgFfI/7G6Ipfr//Y3yJmcHna1ZetcLrn8bggVO6/f7wyNtNiVSPvMbt7SZyW9vkFhmbmnvO1rFTU9KdSJlEHBrWaFBDRLr54SbIuxj9gXDkCZkM3YG2kxhpQLo5+lIAMIMDmasp6QoNYfeNTqMpYIOugxIdkO+sfnnfKVfzknT5GjF1tXKXERnXJIglY2mNNfZPBufEPA7sDAJYTR+q+FMrzlcq8IOe4RSVazml8+n1qvpGJH54vUZmVPNKqdCSknR6vlqi+HbRO9EN9L+2CBSq4lhxzpFHaGH1p0wOZ2/RmLHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 08:33:40 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 08:33:40 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Will Deacon" <will@kernel.org>
Subject: RE: [PATCH v3] arm64: dts: agilex/stratix10: Updated QSPI Flash
 layout for UBIFS
Thread-Topic: [PATCH v3] arm64: dts: agilex/stratix10: Updated QSPI Flash
 layout for UBIFS
Thread-Index: AQHZrYVdNP+e9lhgtkeejawpTCW2OK+ntr3g
Date:   Mon, 3 Jul 2023 08:33:40 +0000
Message-ID: <PH0PR11MB5673A73B189C299BE161026DCB29A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <20230703063309.1342330-1-kah.jing.lee@intel.com>
 <20230703063832.1342543-1-kah.jing.lee@intel.com>
 <b5c88bac-ea21-3e2f-e59d-1128a0742ef2@web.de>
In-Reply-To: <b5c88bac-ea21-3e2f-e59d-1128a0742ef2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|SJ0PR11MB4974:EE_
x-ms-office365-filtering-correlation-id: f394b6f3-7d13-4e4c-e0a7-08db7ba03402
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9cjRtPs2eBnnkpm9T0hO8zHEbRFOyEPF/shASve7ViiYrNmFsuLeG3rT4Ocd3ov6KeWRr5xiHhC218MWgYCSO2f7BE97rKJD7mazSb+0hUxtY2FWYP3ZOLyIVaO0Ln/4giBNCVVURBTZznxGhca43Vl8VfVrDTpwo774yB0EFNh2qStQInIenbj6B9xLE01YnvBv5usIeioLzlVPM+GyE7PlXFONJkX8o+A0JPB/QT/cbz+2t/Sbs4xMvaTqoN8c0c7SI3TbkI/R/9U9pLQs0VWUyccjG7tusfW+nlKYZ402PpJKB29bWGG0OKCRkWtrTFx/lAmKE4eEP8u+lbLx6gtX3mi5DvRvIatAuyP//XYIo76bweuj91SAXqpVjZgcolHqWumBeb8yIjf2/q09xQStl2lcQzkqrBuHj4Yr3zCwmg/9UYIvF8wCy3Ve7VO1dFRN06N9FiFP/xz9HJDg/DvI1yQkrEpM5CQj8BINQCMrtONcQCyLQ76VvzyEuVC7wLJRrTGgIGUzzQJn2Coe1zMXPafC7TZQghhrFBh2j49wBoiH494O5SUrjgK74194TLgc51O7khw3Sus7/x55aFfryXbjdZAzIPjfz4hBylg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(26005)(82960400001)(478600001)(71200400001)(9686003)(966005)(6506007)(86362001)(186003)(38100700002)(54906003)(6636002)(64756008)(66446008)(66556008)(66946007)(4326008)(66476007)(83380400001)(110136005)(7696005)(76116006)(316002)(122000001)(5660300002)(8936002)(8676002)(52536014)(15650500001)(4744005)(38070700005)(41300700001)(2906002)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnN6TWFhd2RrTExlcG5Ta3dDZXVOb21KeGFhOFRqeVA3TDlCVXJwb2JoZzlp?=
 =?utf-8?B?MEJJZkRqMk5NRXZQMkkvM2JaWHFLbXhZRUJ4d3p4WVo4dFZLMWFIWGZkUGZr?=
 =?utf-8?B?SkdENkJuT2cvY1RCd2ExUm9vT2xYeDR1dVZnUHVOMUZHVG9KVDhBaXluRVpB?=
 =?utf-8?B?eTVxbW9Lc1d4aWRTTWlyZEQ2dHNVTFNTRUFsRlpDSXZLTlo2cWI4MDBFZDFY?=
 =?utf-8?B?UTN2VTJZMEMvNGp6ejNMVGhsWXRhODJvSXY3eVB3QXlyaG8zOTNzRm14eXVL?=
 =?utf-8?B?MWpaSjdIaDZDSHd3SlZpbFRUSXJnczh2eWVXcHA5U2w1bjZPWStJTXlobzkz?=
 =?utf-8?B?bW82ajBVcy9GNjU0VW9zK2NRYXdYczdGWWhlNjhRVUQrU1MyWEo4VCt0SkVU?=
 =?utf-8?B?OTcrN2lTOEtUYzhTUUhKUUIxb0dISmc0RmlaWTFGa2syWmtmRkh1M09oRHFw?=
 =?utf-8?B?b2Qwdm5uVEprRyttNnJpdkNlSkx6NDFPMkNwS2Y2M0RGQkZ6VnMxMEV2RlFR?=
 =?utf-8?B?dXVhZXFWVW9ERWlnVUZYbFdVUGM2ck5LbUpHeVIrYnQwN3VXQ0MvdmkvRkcw?=
 =?utf-8?B?ODdKbW1EdWQvTUhtTTlzdlQ1UGVYNzdVbnMrS2c2emJMbm5FeG4rVXBnVkFS?=
 =?utf-8?B?K3BtMEtaOVVIZ25IWnBJeGxGR05SbkZURU9OSktINmVGV0t5RVE5ck1XZUY5?=
 =?utf-8?B?N1FvcWJpWlU2Y1F5T1pkY09hK0FMdmVEUExNSFhwZVVZSVJmN0MwSVJXUnU5?=
 =?utf-8?B?VUp1ZXJKM2oyMUM1MU5aMXF3ZmVCVGx0dkhOZHE4dVUycUxSZEFmeE00SWlz?=
 =?utf-8?B?d09ITUR0MDl6SmV0YTFoV1UwYmNXVVdQWkttODlIc0Fpc0YxbEpBamNMSXJs?=
 =?utf-8?B?NlZWR3k3TEZDZlZYSFFLVTVISWM1N3BBdkpHWURnL3hDeDRkeVY4RlB2Skpn?=
 =?utf-8?B?RVM1c0ljcGEvdU9yNFc5Z2kzRjVrY1ZPR09FVEpBdi9aYS9XNW11Qlg3N2Iz?=
 =?utf-8?B?KzVpVGRHd2ppZ0RBM1RrRnJZMlgwUXh6V2M5SGZlOUtwOGlzTXFrTkxMZ1Zh?=
 =?utf-8?B?Qjh5dWdnRG85dU5Wb3U0T0xqK1lzd29OT0N2bWUxRWxIQzQrdG90OThTTGxa?=
 =?utf-8?B?bHFwUG5wenJUOVNOOWlUQTlvdFNkdEIrR1JHc0RBVFZMa1MwS0J2R1drbXdi?=
 =?utf-8?B?REl6TEQ0VkxZZzM3aG9NYlpXT0lKb2tWMnBwd3I5eEZidDFXQjJyc0kyRjB2?=
 =?utf-8?B?alp3cFRPMVpJSnN1KzBIV2hMY2FqWkJWZllRYU9vVzJvUXhzYWZEQXJEYVRv?=
 =?utf-8?B?TXdSalBLVGxnQ083OUlsN1BXU2lDY1U3Vmo4YTZOU0pITVBQUXpFOXo1Qk1v?=
 =?utf-8?B?dHVFaFRyTGprbWc3M245Wm9hVXNOaFpKNi9hQjdKMTVEQXd3Y29OV05ZY3Mz?=
 =?utf-8?B?Q0c2YVg1cnE4dTR0T3h2eTZkU1A1djBUS2U4SnVjWGZKbTk5TVJuWmI2K0x2?=
 =?utf-8?B?T0xhd2JYTC9EdCtnYUZydzlFSUE5N0U1UUlUUk9NN3c4SHoxVUtOVnBTL3JG?=
 =?utf-8?B?RHQ4WnhrM0JSck9PSGpJODh6ekRiMFpMRDlZZCtFWmNXVGlaRHFpbzJ0Z1Za?=
 =?utf-8?B?c2drejhjWGdrMzcyZytRNS8vU1NxNEhyMWdnbEpKd0RyMW11YkZidjc0VW5r?=
 =?utf-8?B?bkJVckdLazZpN2x3ZTBHZWtkZzVNNGFKeGovQjdkcGtVbWZsWWJBdXhyTk5k?=
 =?utf-8?B?WXRHV0pWeDlGclhKck5kRTR5OHhzN2tMS0NDK2tRdEg2YXluNDhRRm00V080?=
 =?utf-8?B?NXV0S3N1MkZqdVFrRTFveThpejM0M2xQUE9iS1d1aHlEMWM5TFV5YTU3eEsx?=
 =?utf-8?B?RDNzbHh5bDkwa0t3WjFpdnJFOG5JMElZUis1elo1b2NrME5BNm5CU2I1K3Yr?=
 =?utf-8?B?Q1FFMWxQSG9Kd3p4M05QN01lVloxcXZ6ZnlLY29wZFluOXhUZHE1clRFQmZV?=
 =?utf-8?B?NVB1TmVINnFUN2ZGWFc2RkE0V3NzNjBSU0tsdkpURmh0ME5sYXlqcVlCR2Mx?=
 =?utf-8?B?QUZ6RjZ3Zmd4YVVBY3hqaFo2VnZpMUNqcTFFR2xIcXlFVFc2ZEtRczdQb05Q?=
 =?utf-8?Q?kMU8Xu1wNQC1aKb1pLDKQaUwm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f394b6f3-7d13-4e4c-e0a7-08db7ba03402
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 08:33:40.0220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgZ07yu6e+sNn14txhVjE+GMRxMs6F0PdMUdDEylTYCCbc8jUnGMxVHNv6jAG4EHRoMDArrIi+V3tzEbVJXgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
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

PiA+IHYzOiBVcGRhdGUgY29tbWl0IG1lc3NhZ2VzDQo+ID4gLS0tDQo+IOKApg0KPiANCj4gSG93
IGRvIHlvdSB0aGluayBhYm91dCB0byBhdm9pZCBzdWNoIGEgbWlzcGxhY2VkIG1hcmtlciBsaW5l
IGluIHN1YnNlcXVlbnQNCj4gcGF0Y2hlcz8NCj4gDQo+IFNlZSBhbHNvOg0KPiBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
dHJlZS9Eb2N1DQo+IG1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Q/aD12
Ni40I242ODYNCj4NClVwZGF0ZWQgaW4gdjQuDQoNCj4gUmVnYXJkcywNCj4gTWFya3VzDQoNClJl
Z2FyZHMsIA0KTGVlLCBLYWggSmluZw0KDQoNCg==
