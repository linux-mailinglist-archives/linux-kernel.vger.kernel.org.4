Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607B96A5DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjB1RKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjB1RKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:10:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8FA2332E;
        Tue, 28 Feb 2023 09:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677604208; x=1709140208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qm+V3TM8mLwwkPo5+mjUS8mZxXie+Xm8YfakIKsszWk=;
  b=HwBslJcu30h4lDc7eH1ZrcrVnqvH4S7hmA/IbqKFeedddM5TY6ZpTeZ1
   qPxWqxI9gSUy6UTERsLAhY0fJ0N1/Z1SE6i3B8OdcR8f10FOEccWIh3Wx
   20GpBbA1OphkjCX9KMoaHFun4twEt+1DcuQBNywbn+XEyZB1qRbB5VlVm
   uyjHFPEh60k6eyj/JAR4tFIcyqJDxKDassFq1iyg1i5JdLsgVQQajfQVj
   1O/EKwFG3ogtdyvIHgYNRGXeUOzhNm/PLSPqoFblUJkejiyR1Zi0ZNxEP
   ZUGxQTXeefusZrFUDFb0xhzyAYNsZruBN2uiWRrPBMixj/C48VrWy/m5y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="313864676"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="313864676"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 09:05:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="848317547"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="848317547"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2023 09:05:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 09:05:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 09:05:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 09:05:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 09:05:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0lo6/f6iiE4SitAl2C16CgctYXuBr0jmG8VySem4bOIK3xJ7Zd2UdPMUL4262ehjXB/53xiI5WFt2Qr3nUYOWGJk6SjDy4D4dHPNK1CRf4LIkOGhUfnTYSKSL7SvkeI/DpsFFup3vq2zbT+fjGlqVKSZuIU4a/xq5KhFlDjHSyVmelRzgWVxxLDpWioGAdhX9unzS0ABoAEE6H2MbfO2PHtKK37CzXekbY5Vun6dxmAE2HqWhFFzH/OOmcr3SlLDSPzeTMWTULjYJKQy9l7EjyXIl6FCDlud71N7tudV4+gkqEvUdJqLSjKsMCuCCVzARBfgmMrLfMqKDZymK68FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm+V3TM8mLwwkPo5+mjUS8mZxXie+Xm8YfakIKsszWk=;
 b=Lb8FjtxXdIbZrViEY3Ms4/ONvtQHt+iLe3iDr47oY/y4wdgV9eNuGetEoMcuQcUP7Nr5DhLRwvjbcziQPZOIJYxNVI8QUqDmWRMg389AMggcf4lKxEdtNWq1MUcOjZAp6OOI28tCdQIPY+9e4cIQlar5hLy0APb50s7462IMIe2q30uPIMo/ElHgvS8hweYjq15zYzrFp1Jg+QVyaGsR5XUjBcyVk20d8zhOtrCPNjnSkDQJHDwmZZLvhdjR8xGCKWlpuOD0zrbjVKXr/BF1Whl28o1TVnFiP9yEs4kgjTXouzgrsCr7EcDINZTTANLDT17yQdhbA02CnIGjduUA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 17:05:26 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 17:05:25 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Moger, Babu" <bmoger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Topic: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Index: AQHZMbXmEMfKBNwkSEml6dDHhSj5la7kniMAgAAqrTA=
Date:   Tue, 28 Feb 2023 17:05:25 +0000
Message-ID: <SJ1PR11MB6083EDF3CDD7C231CA05C0EAFCAC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-4-tony.luck@intel.com>
 <82013563-f652-2dc3-c90e-89b19fea6b1d@amd.com>
In-Reply-To: <82013563-f652-2dc3-c90e-89b19fea6b1d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB5626:EE_
x-ms-office365-filtering-correlation-id: efce3753-6c4a-465a-8c27-08db19adfc49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fUD8Z8hkEQDWi61jllLGCrAjV1cHA0EUYmhkITYfd5wAhFjZQBfLZ05KsQ+qKtB2irB/1/UT1s06dg4b3nlnO+yureLe8T6IdNdbDBxgP8/2aF+GHlsLOS+vSFYHYkrmxg2GxPVaXRCnyssiJiAQ5P2XuXMXf4njTucINwXmJeUgzNlPxJfZpjuNK72VorQVs6TczY5nAd/dyBKvP3KsTtrro3tRJ37FKGPmRDKBuQxkZ/Y1oC+zXjngv1HAz9UaRyehP3VQ0zp8ETHC92/XMdsln32e9vcvz4BXaTVEKgQXywHkEZ06xRbG5BFpz9DWZKyy+KANvKkbzn435Y2eMxZKsQ3T219Hoo5FQvt/L2dw4SZbU+wGmDn1IAKsDzFZpoF+zaumPmJulqs5JJO4T317slGhIIwxWWQ5uKvM3QN9r/aoJpwYr8TsVMCpUn05IXEaRI1rUXE09GFKh9+eUwd+Tcf81FSxr9VOqy1vS0F4zZx0L1iRpxGNQ9zys6PpjWx4hQEhE7Re9dD7iQ2vXJGaYXucVvTa6twNizaOgNaTGVjJ8bsWDLCBZ622dCnwnq6dFAAXMnyHAOUUUBBCbMk0R+NZ8A39YODH88DVfNm7JGIoBZCZLB6U0fYdr571UJitPXi5wduzsDVoihqAItDbDQ3oZQzUoOcj/zvGaqC2fDqaJWAGRWuAxp1RUAQ7evKJfv/X3EjjZL0C8gw8bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199018)(122000001)(82960400001)(38100700002)(52536014)(5660300002)(38070700005)(33656002)(86362001)(2906002)(4744005)(7416002)(41300700001)(8676002)(55016003)(66476007)(66556008)(66446008)(64756008)(66946007)(8936002)(4326008)(76116006)(26005)(9686003)(186003)(6506007)(110136005)(478600001)(316002)(54906003)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUlVREViUmhNWC84WjdjTmp0aDNZU29aQ1krbkdBdHdxS1pqbUo4TndvRU1y?=
 =?utf-8?B?bStxR3BBakUzUHlGNU5lZmJHNFJHZENpRlozNWVBMTVqZ0haOHlpc2hNZVhw?=
 =?utf-8?B?ZmxmWVVTSDd5djhXZEprV1lpUUZsWDZZemFaME1mbXkwZVN1KzM0dldIQm9q?=
 =?utf-8?B?TUhSNHNScVNNc2g3Y1pOZ2sxZEcwd0pwekRWMzIzajkwTFkrMXBaZk1mMm5x?=
 =?utf-8?B?dFl2YlVUVjcwSDhTTG8rVWVqcFJjVzN2U3pZc3hJdEdBWjc4aVhZem5aT3NT?=
 =?utf-8?B?S2o4akhlRFlpOGZIdjljVkJZbmJCMnVSWUFwSzFFRVBGQ3NJQ0tmZDVnbDN3?=
 =?utf-8?B?NVh4aGs4UFhKSzhNdmNUWTE0dU5BcFdwUVlyZjZOWkNTTzF2ckhIelFYWjlF?=
 =?utf-8?B?UHdwbEt1SFlMY0xhTHNZeDNmZEd1NUI3cmJpbnBGbWhKZ2JWcVJWSDhONEJn?=
 =?utf-8?B?SEwzcGR6NzhKblNSejllWXQ3QWUzRFhyZTdFY3IvWGlIODZaL20vRmtIYmZw?=
 =?utf-8?B?MHFqTWpLOGdGRXgwRGZLTDdsVTZCSTJ4Zm9Fd2dzclNsZWdNa3FvUk9Idm1Z?=
 =?utf-8?B?TGQraHMzK3dRUTZOeGh4dlI1OVV4bTEySHFEWWNKWU54bUpOMkF4MzQxazFi?=
 =?utf-8?B?Mm5rVG05Unk2OFMwQSs4a1dCSEdlVGQ2b0l1NEQ4TnR2alZjMExNZGJKTjgv?=
 =?utf-8?B?aHVLWmhxdXQ5SUNHYVhJSVhkQjBQVFB4RGptSGhua0M0MzVtZEFpZ2JZNkp5?=
 =?utf-8?B?U3NHZXNreW52OW1jNGNvT1crV3FscFMrQVhIQUZPM0NnclN3ZWozTEh5Ukxu?=
 =?utf-8?B?c0hxNTE2WE1YVnpOcmZmbC9VMUZaR1FKN1pjY2xPL1F4MmtLS0I0bkVraVpL?=
 =?utf-8?B?eWt2VGtyYjh6bHlSdVpOSGVtQzZ6YVhkNE1mSWs1RmhtdXQzN2s5NU1WVWlQ?=
 =?utf-8?B?a3JGeWJEOXg0Mll6RVV5MUZtRFA1V3lLbS9rM2xOSHg4cUNWN1pTdDhaa3FR?=
 =?utf-8?B?RzZnZGxFbUxwSEF1TFJPSkkzWTRZOGl2R2FLNnM5QVd4LzFQdlJlS3orVCs3?=
 =?utf-8?B?ak1KY3l6ZjBlUUczNkhQa3hHWk5mU3B4cGJWVnFSbDhXWG9iRE44MmVtQ1FT?=
 =?utf-8?B?ajNBem5GdWRsMGV3WDNzWXMrbklEcHJ4bERaaXpoN2laa0hlRHdzbEYvSUpB?=
 =?utf-8?B?QWpPT2szU095eGs1OXFLczJONno5MlZESXd3dEFwTUZkSVB4djhTei9LN1A1?=
 =?utf-8?B?TmF3WVZFai94Z2E1bW5KM1dRQ3ZZd2lDV3NvWCtxaGRuRU9CQkE2SU1QZktV?=
 =?utf-8?B?cE55ek45M3lQY3RTV0dyNTUxVU9HMXEvSjhxamY2cm1WWHhqbGFTaUZTYm9y?=
 =?utf-8?B?Q2NVVlVIL2Ixb1RQdThYQm4rQnBqR3NneTV6cCt0ZFBVZkR3d1ZWbS9IZXE2?=
 =?utf-8?B?VWhaNzNPb3VlQUFnamJnUFRiNzBiS2Y4NEhoK1VVL05qRVh4ZTBLZTVTMjZy?=
 =?utf-8?B?WnE3eTNYWXlIS0FqdS9Pb0EzZHpaUThEOHhDZHdpcXhxK2pGSjdMOTVNSFlu?=
 =?utf-8?B?OW9laVVNNndSeXNrNkdUNmFjSlFJa0xYU1pMWVpBOEpUb05zSGFjMlNLV3pH?=
 =?utf-8?B?QU5JYitkV09ubUZ0SCtzYWJZSFMwbjVJS0J1SE05cG16RWxFc3pqSXoyejBp?=
 =?utf-8?B?NTJWQVRhbktHMXUyMFFpcE9FTTRuOWFmUXF0TGVhYkw2SzJ5NEIydFpVR3NR?=
 =?utf-8?B?UWRXMkl1YittWllBMlNzWE01VlFhUUh2K3Q4bWpaT3ExQlpXTFp0bFVzU2pC?=
 =?utf-8?B?bnlwRmxQNjNhbE1rZ1Q1MUhvZnZkM0xCYUkra2dQL0JVUTJKWWxGd3FDejlD?=
 =?utf-8?B?elFjL0JjRkNOdm1JbkVPWWMzU0NrUHVHRWhNQzNRZDZ4d3pxVWcrdGlBeXpD?=
 =?utf-8?B?bUVpSnM2WStIQUtoM3Ivcy9VK3J4dy9QTGxHbUNIblJqclNmRy9QY25aNTFm?=
 =?utf-8?B?eGFiUitVTHhEK1hLMnMyRFNrcFBlWG5Ca244ejlHNzF1aS9ZZzZPZnlXWFc2?=
 =?utf-8?B?WDRNNUFOS3l4WmNPKzlObENZRTgwOGlMT1pRcUd6MlAyNlBDSjBlRlJVRFJN?=
 =?utf-8?Q?3Ea3sM7b7+WEqPE/f2AVXzWvi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efce3753-6c4a-465a-8c27-08db19adfc49
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 17:05:25.5303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdgpbEvAAjojw9/jdkpMfnf4b09Vgs8G3scs61cnEhW0BYNgWTVnsao+KiO35VDjXRYvMRRJSbzIx6gBwZ9Bbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5626
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QmFidSwNCg0KVGhhbmtzIGZvciBsb29raW5nIGF0IG15IHBhdGNoZXMuDQoNCj4gRG8geW91IHJl
YWxseSBuZWVkIGEgbmV3IHJlc291cmNlIFtSRFRfUkVTT1VSQ0VfTk9ERV0gdG8gaGFuZGxlIHRo
aXMgDQo+IGZlYXR1cmU/DQoNClllcy4gV2hlbiBzdWItbnVtYSBjbHVzdGVyIG1vZGUgaXMgZW5h
YmxlZCwgdGhlcmUgYXJlIHNlcGFyYXRlIGNvdW50cyBmb3INCmVhY2ggIm5vZGUiIG9uIHRoZSBz
b2NrZXQuIFRoaXMgbmV3IHJlc291cmNlIGlzIHRoZSBrZXkgdG8gY3JlYXRpbmcgZXh0cmENCmRp
cmVjdG9yaWVzIGluIHRoZSAvc3lzL2ZzL3Jlc2N0cmwvbW9uX2RhdGEvIGFyZWEgc28gdGhhdCB0
aGUgbWVtb3J5IGJhbmR3aWR0aA0KYW5kIGNhY2hlIG9jY3VwYW5jeSBjYW4gYmUgcmVhZCBmb3Ig
ZWFjaCBub2RlLCBpbnN0ZWFkIG9mIGp1c3QgZm9yIGVhY2ggc29ja2V0Lg0KDQpCdXQgdGhlcmUg
YXJlIHNvbWUgb3RoZXIgaXNzdWVzIHdpdGggdGhpcyBwYXRjaCBzZXJpZXMuIE5ldyB2ZXJzaW9u
IHdpbGwgYmUgcG9zdGVkDQpvbmNlIHRoZXkgYXJlIGZpeGVkIHVwLg0KDQotVG9ueQ0K
