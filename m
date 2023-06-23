Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C845D73B471
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjFWKEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjFWKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:04:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E82296D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687514642; x=1719050642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2b2OtIA+muAFjlaNqwwxxvx15Ih/L8OcJDoxWkH1XwU=;
  b=PLdXLSTzxPo0mUabjwX3zDC6MPLRp8RWE/5xcCV4CRImP3xpjiok5I8K
   IlY/wA5tUmMJlEpHMBEU7FFWoGqix4V8Yw9+bKwSD2gkb8skaArbtrXVr
   3QKRSZgcEHggP4VlGa31zlHms9EkXU7gqxRg4reXJFSx94XyxK8IEAIQt
   q4+CgKnYRDHc6V8hdfh3XGO/RHMSq/t2q8iYWtHp/+lLXAce39ylf9GXW
   MRg8wnmCYDpQ7RYpVzwku69oGwLMK4LbrPGVxjEAwO7Sm2XDBeRH4wHMj
   N6TncFm4VvX42yxMgcSTLqN/wHsl+ErNrEFqu+FXRjy9T6I8X/K/z2RC2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="341069949"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="341069949"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:04:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="889425803"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="889425803"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2023 03:04:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 03:04:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 03:04:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 03:04:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 03:04:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+JTj1xrBr20yQjSsd6Pj/9dc0KqheXrwS446VSyhMfBbhGxyQAt3mdRd4/QG4X2kZKKNhbIVxx4ex7IdEBb4+TcBPNDq4yJHLGeVHL/afIvTQziJxk8saH8qD2V7PviD+ANPID+plBjINeBrJCFf/B8Riip3hzJnJu42bSmdtkMoJKCk9W1SvVdp/RXJEhaiaoikDs5ij/IKRM8SEEiP+eZbinm33clg73UebuHu7k1PTs/ITNMQ+xDcSkjfGfqZbQhMyDlCXhNE+QeZGTC3nkW8pkmMiyHd80culi5NjNsDx/Z7+GMiEBHVtBLiAsvMAIaCLWxhjpeRH3uFuU2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b2OtIA+muAFjlaNqwwxxvx15Ih/L8OcJDoxWkH1XwU=;
 b=FJaarSlDnyatvNkI+ijsMkXwMLXQ5Sx5Hxh9T/FWg5Hbr49OQuO5knbQOQ6TOVlXRUWhnEznPel8Y4mV9Zk0ZhF1VdsYClcNNI8sJML/+iSgojfATFwXDKItoW9iGBtiTKVMQTwcesdJtQ5o3LwCcmMqj2dwG8ry0rurE3+NBCiw/PEAwBrKjOGTRd/Rud8Xh0c/XnKFcdI+Xqf0qktLeQ1r9xJS8jYaT2ZktbroRuq7GC5z3xJVxcdabyJfmOHWS6UwwmGxbRm9nAWpMJtLO+Ui0GX56BUakUoV0ZKx2gvTH85f+pCt85uC67/KAnjK5d/he7uWHlRLMrNA6lZ4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 10:03:58 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 10:03:57 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Thread-Topic: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Thread-Index: AQHZpOcz4yOfuGedVUe15UWfk8cDPK+WjIqAgAAxu4CAAAfJgIABXnCA
Date:   Fri, 23 Jun 2023 10:03:57 +0000
Message-ID: <PH0PR11MB5673A862187810E9986E3C8BCB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
 <20230622122114.592791-1-kah.jing.lee@intel.com>
 <25439c1e-c9ef-0dc6-8d91-883d7734d0fd@linaro.org>
In-Reply-To: <25439c1e-c9ef-0dc6-8d91-883d7734d0fd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|DS0PR11MB8206:EE_
x-ms-office365-filtering-correlation-id: 7d5260c8-cb7f-459d-c8b0-08db73d128de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c852+dfj48102sWEZ6XzgwIuyeQqES/ir0dJKCYNkl4Q3CPinFMj0JpKUuHx2h9QZbNOnRSNSwMBTul44+sPTMht82/ENAcIN77eelStfEQjjd5GbnPiDr9/3ULu0Qf6bVeXElVj+T2TTqKsK/iqFlHjAab2qgfSmKFmhtEBL+LTUGRBUSBgx8MoCvg+l1abNXdELaFHKII83xT4fOmscq2PJsVLJY7uWX3aWyk/lFTI0De23HI0tZVZEYrSPZYwb7VO299dfWylDmr5A7nrjWQy80+rtBZBfZ0cYUst/hl6PpXW1OxaMwxpz4vF/w4+LElQbLkNpQAC8F0ahYNKWJNnKMCEAuqI1k4D2LZfNbCHRAF+Glm+vCyg5m6qQXgpjDz2IvjnH/6HBlkCeAx5R6gw6A1vMQOnnZCgr+lU6Fv2fOsrWkgKixnkR1ZBpMKdW77bL+WenDxl5rxPXJ+bzX9U2a8aRHcwMu99hhjdS3Qrk67AIrZLvsG6e0TIJDsjgyGJXlOPGh3vu74TUBXCXDCGk4KqfqqLwxNIOsFJJ/h1n2aeftOiBUfE0M846hVeCnbUeH4FSRbbgp0NkS8FQGD4XRL4V21CicbCDlgEnTmVFAyEiB18nj88W0FKVe7e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(7696005)(86362001)(122000001)(82960400001)(38100700002)(38070700005)(33656002)(8676002)(52536014)(41300700001)(26005)(53546011)(8936002)(5660300002)(478600001)(6506007)(76116006)(55016003)(186003)(2906002)(83380400001)(316002)(110136005)(66556008)(71200400001)(4326008)(66476007)(66446008)(64756008)(9686003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OENXR09GWnhpRHNQYlpLV1FTTmFPYXBHNHMvWC8xZjUvUkRhV0R0WXlVWFJn?=
 =?utf-8?B?Y0VzUXBITWNtUEVCLzA3NmczN0lsUHFqeHZ4MWtZVG93TFgrdE5pSE5NU0N3?=
 =?utf-8?B?N0l1NlNuc2g2cEx5cnpicjdvaTQxdkRxYW9CcFBOSTNHMzBrUVkwbnZKZmhq?=
 =?utf-8?B?Wjh0aUhDTFU0Q2YyYlk4OVNlaGJIZVdqK1lUY1dJVmJrcjlsK2JieVhJemkx?=
 =?utf-8?B?VDhQMElaTWUzSTVXNVdoa2ZkQnlwaU9QdGMvczAycnA1VGRGTkM3V2ZSQVRZ?=
 =?utf-8?B?V2F4a3d3TTNEd1ZPNDE3eGppY2JnN3lFT0RhYjFYQ2JFMGJCb0tKS2h5clgx?=
 =?utf-8?B?LzY3RGVBeXFzWmR6K3ZKeDh1ZmhyVXZTeEJ3dzROZk55aTJrUXJwRndIdHVm?=
 =?utf-8?B?c254cGtBYVRjamhINlNoN3dDalJ0MzY4OHJ1RndjUVZkektLcjNJc0tLeDgy?=
 =?utf-8?B?V0hZSFJqUDRjY1dNWHIzYXlZRkZLQVQzSjVsS3JCMW1jK04xMncwUXI5a0tW?=
 =?utf-8?B?cjMvYVgvNUxBRjRwYU9wcC9hcjZKTjZKbklKRk9ISG1wS1hGcXc3bHZDUmJa?=
 =?utf-8?B?MVBJdzhFa1RXblJsUHZncklCN2pRdXRoVDdjbDZwQ3gyY0hJKzJvZ3pJM3do?=
 =?utf-8?B?WlBtUE1XUkJJTDdmUmRNS2IyRXhYc1htRHppN3Y1bDJOZXBpSnpzWk1ZVGxI?=
 =?utf-8?B?cVpZY21STUs4ZmxGcDlvME1GL2REMVlSZXQxdE5XQzIxQVFBTHNQc1p6M2VJ?=
 =?utf-8?B?ODZXVFRBZ1dvd0pONFJ4aVIwaStZMTVHRndWVXQzSjFvdzcyVHgxZGdMeTF4?=
 =?utf-8?B?Z1l4NVFoUFdhV2xFVHlRR1dzMzltVzk3OXVrcFZMeU1LZ2JXbzRFMU5YcC9n?=
 =?utf-8?B?MjdyZjFJUTREOGNEWVJ1Nk5sMkI4MnhpUE84R21FT28xTzhVNUN0VWI4cjVL?=
 =?utf-8?B?TnNXUlBmTjlvNkEzSmhaWERDWFlsb2JJM1VlYjAybG5tV05vczR4WG5rUmxu?=
 =?utf-8?B?SFV1KzI4NExaTnB3MEN4NWZoUk1lTS90V01PS2hkWlBQT2xOYm45N3k4OHVP?=
 =?utf-8?B?c2lxL0VLS2VWZnV2UHdSR1BidnUrNGlXcG54YWZlc01SUDBRaEVxSEg4ejBM?=
 =?utf-8?B?TzNGTkN2eFVtQ1c0OXZxVkN6bm52WjR3U1Y3T1JqaG5NejllMWRoZlRKVnFv?=
 =?utf-8?B?WE8zVjZvQXBHbTR6S25Jb2JiQ3dUVDZId0tDMDhmaDlmcFk5VC9ZVmdLajBN?=
 =?utf-8?B?QkhjMVkrNjBVSGpCaUpsdjhIY3NHVnFqUHI1dHB4RGpDaXdoK0hLT3ZpaE1H?=
 =?utf-8?B?Y1k4K2ROMURVRkZBb3g3T2xWNzFFN3ArQ0h2VUdRNzkxaHFxemVyekorSlNG?=
 =?utf-8?B?Y1J4b0xvYUZaTFlVMzVIUFBhbXRkZGhTVzgvTTdYQUJUTitYSnpDVExwWXM1?=
 =?utf-8?B?S3gveHcvT21jbytET05WemgrSi9HcWx4UzgrYWRYclRicmZpRDV1TUFtTXoy?=
 =?utf-8?B?blo4WTNadXpia3dnZkg1L1NXYitvQ3FJd3dsM3llWG9MVFVOTDh2RXkrMC9V?=
 =?utf-8?B?N0NwNDIvRng0a1Q3WSs0QnhxaWpTdkZ3SXpUUkdnMHpObGJLR3NVNHY2eXcv?=
 =?utf-8?B?Y1RWQ2hYZmN0ek5EMnV6ODZER1R0ZUdVV2wrY0toaTAvY1d4U0dpZWpnbzVG?=
 =?utf-8?B?YmNVZDRvY2RkV3NYNUNENGVoblNDdmE5VFJiVTBLdFkwUmM2TVZ3RkF1dXRZ?=
 =?utf-8?B?eFdqZDB2N2l6VDFYOW5CTGFFL1VuVXcva2t4RTZJRGNLb0pqTiswSCszWmJr?=
 =?utf-8?B?bmdNTHQrQ2dvM0pYc3FvU0ZEdjRMYitaZ0JvdFMzcEJzN1JpZm1xQUFyLzFo?=
 =?utf-8?B?anpYZXU1R05kRFdnYzBDbmZLWGJGeEc1MGRwQnF5b3k4NS9oeGRYZ1loRC9u?=
 =?utf-8?B?WEJENVNHaEVPeWljYXo3RHFXclFVK0ZRTEoyK3NvY2FnK0pEK0Fva3ZTY0VY?=
 =?utf-8?B?YXg4SHRyRVF3YnpxK21pYUpSZURqZUNtaGhjK2VmZERDZFlZTDRNeHBydnFY?=
 =?utf-8?B?U21UVFl1dVAxY1hQb25CRkpDVVQ3cXBCeGVvc3lIaG9KOElnNzFkcWYrRWQv?=
 =?utf-8?Q?6s4+kpF6yDGvENZyzm8oynyyr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5260c8-cb7f-459d-c8b0-08db73d128de
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 10:03:57.3826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbISHVXMkY0thTTyVyx/dsPWAzirUxdMN1qUbH9au4lE/BqKi1VnzgTpzPTO6OaQZbb1knsQdoLjLDI/0AXfyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCAyMiBK
dW5lLCAyMDIzIDg6NDkgUE0NCj4gVG86IExlZSwgS2FoIEppbmcgPGthaC5qaW5nLmxlZUBpbnRl
bC5jb20+OyBEaW5oIE5ndXllbg0KPiA8ZGluZ3V5ZW5Aa2VybmVsLm9yZz47IFJvYiBIZXJyaW5n
IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5l
bC5vcmc+OyBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsgV2lsbA0K
PiBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGFyY2g6IGFybTY0OiBjb25maWdzOiBF
bmFibGUgVUJJIGFuZCBVQklGUw0KPiANCj4gT24gMjIvMDYvMjAyMyAxNDoyMSwga2FoLmppbmcu
bGVlQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBMZWUsIEthaCBKaW5nIDxrYWguamluZy5s
ZWVAaW50ZWwuY29tPg0KPiA+DQo+ID4+DQo+IA0KPiBZb3UgbWlzc2VkIG15IHF1ZXN0aW9ucy4N
ClNvcnJ5LCB0aGUgcmVwbHkgZ290IHRydW5jYXRlZC4NCg0KPiA+IE9uIDIyLzA2LzIwMjMgMTA6
NTMsIGthaC5qaW5nLmxlZUBpbnRlbC5jb20gd3JvdGU6DQo+ID4gRnJvbTogQWxpZiBaYWt1YW4g
WXVzbGFpbWkgPGFsaWYuemFrdWFuLnl1c2xhaW1pQGludGVsLmNvbT4NCj4gPiANCj4gPiBUaGlz
IHBhdGNoIGlzIHRvIGVuYWJsZSBVQkkgYW5kIFVCSUZTIGluIExpbnV4IGRlZmNvbmZpZy4NCj4g
V2h5PyBXaGljaCBib2FyZCBuZWVkcyBpdD8gSXQncyBxdWl0ZSB1bnVzdWFsIHRvIGhhdmUgdGhp
cyBvbiBhcm02NC4uLg0KVGhlIHViaWZzIHNldHRpbmdzIGlzIGVuYWJsZWQgZm9yIEFnaWxleCBh
bmQgU3RyYXRpeDEwIHNvY2ZwZ2EgcGxhdGZvcm0gd2l0aCANCnJvb3RmcyBtb3VudGVkIGZyb20g
UVNQSSBOT1IuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQWxpZiBaYWt1YW4gWXVzbGFp
bWkgPGFsaWYuemFrdWFuLnl1c2xhaW1pQGludGVsLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6
IEthaCBKaW5nIExlZSA8a2FoLmppbmcubGVlQGludGVsLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4g
IGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgfCAyICsrDQo+ID4+PiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4+PiBiL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcg
aW5kZXggYTI0NjA5ZTE0ZDUwLi4yM2E2ZWJjYjFhOWUNCj4gPj4gMTAwNjQ0DQo+ID4+PiAtLS0g
YS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4+PiArKysgYi9hcmNoL2FybTY0L2Nv
bmZpZ3MvZGVmY29uZmlnDQo+ID4+PiBAQCAtNDcwLDYgKzQ3MCw4IEBAIENPTkZJR19JUE1JX0RF
VklDRV9JTlRFUkZBQ0U9bQ0KPiA+PiBDT05GSUdfSVBNSV9TST1tDQo+ID4+PiBDT05GSUdfSFdf
UkFORE9NPXkgIENPTkZJR19IV19SQU5ET01fVklSVElPPXkNCj4gPj4+ICtDT05GSUdfTVREX1VC
ST15DQo+ID4+PiArQ09ORklHX1VCSUZTX0ZTPXkNCj4gPj4NCj4gPj4gTm90IG1vZHVsZXM/DQo+
ID4gWWVzLCB3ZSBuZWVkIHRvIGJvb3Qgd2l0aCByb290ZnMgd2l0aCBVQklGUy4NCj4gDQo+IFNv
IHlvdSBtaXNzIGluaXQgcmFtZGlzay4NCkN1cnJlbnRseSB3ZSBhcmUgdXNpbmcgdGhlIGJvb3Rh
cmdzIHRvIG1vdW50IHRoZSByb290ZnMgZnJvbSBRU1BJIE5PUiBmbGFzaDoNClsgICAgMC4wMDAw
MDBdIEtlcm5lbCBjb21tYW5kIGxpbmU6IGVhcmx5Y29uIHBhbmljPS0xIHViaS5tdGQ9MSByb290
PXViaTA6cm9vdGZzIHJvb3Rmc3R5cGU9dWJpZnMgcncgcm9vdHdhaXQNCklzIGl0IHBvc3NpYmxl
IHRvIG1vdW50IHRoZSB1YmlmcyByb290ZnMgd2l0aCB0aGUgdWJpZnM9bSBjb25maWcgZHVyaW5n
IGJvb3Q/DQpUaGFua3MuDQo+IA0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQoNClRoYW5rcy4gDQoNClJlZ2FyZHMsIA0KTGVlLCBLYWggSmluZw0KDQoNCg0K
