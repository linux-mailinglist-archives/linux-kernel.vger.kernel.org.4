Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A916F10D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 05:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbjD1Dfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 23:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345179AbjD1DfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 23:35:25 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013003.outbound.protection.outlook.com [52.101.54.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC3D2D5A;
        Thu, 27 Apr 2023 20:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTihsSTDDoHfqbGxWaGPrQterxpLfqLWelquELW2nHhIyqj2DYvI0ACGYqPG3610PUBjBd2N7Vzn/TGQ7s4bbVNcEfCRL+WrO20ZSW8zI1Eqho3puwU9uQKV9Lww5n/xqQJSvOYfIHxcMUzhSZQwxJNYcObF20PFk41iEm5hEZiTH/7uiXvijturm0vv1YBJv1/oHxD63Kw+wbWLfBHTIfoLUhs7N+oZxuRfO43AHSDOiD4MJFOXmzzow2Jak1AmJNotTalLPkhGhv/ZGYBq7P9nYltj8eqfecnNUk4VgBsPZF+fWMZWlGYUr/kM6Bvs9OiqEVcXtVcDTqWDWZY5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67f4iTbv8t5wjaym57RgQI1MHe3OhXunPPuKC8rfhec=;
 b=O1Z1T3UXE3teiEVHsA9gZ/ixHCrJES9iWr+q2WwUSwn5gvzqcxX9EiQRvpmVUYPiOS9e+K7sTS/oFlZzA1PGhEdABoV0HHFGNOXIcqh1pypfoR30tELKwsautqLPkQqsin9y/ghdsJYoysTDr6dfwV+YPE9vqSLDoktJYrSttpJ+vBKtk6KINrClpKxw0igrSleFucEfbx1+WdxJPD792hEF1y4xBqWwUJ6d+VUiUdorF4JTwwXVIZugSWXMUXsTWg2uImWi/90MZxzWVHBOGJt3HV/EZLDzFli0sKXIH/dVGqUse7AU9Xs/Z5MT8moxs/Ig//sIMBI7grXRpHN07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67f4iTbv8t5wjaym57RgQI1MHe3OhXunPPuKC8rfhec=;
 b=dczBYVW//hWYuBMXicKhWCW0CRgmUGUtTq3ER1X9lDSG7cPPdCR2PW6CiIanPm2TaB0wevMuK7t9wdW7g5yfnvXALdZ0xZPKZFI0j6TrPTAQK9dREz7xnrRBBFK5oEjNARCSK1jFsI097wV11np8wne5pfz5aNmTAmueFQNluXo=
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 (2603:10b6:610:155::10) by CO6PR05MB7665.namprd05.prod.outlook.com
 (2603:10b6:5:350::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 03:35:21 +0000
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::b4c3:9441:f0:efb8]) by CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::b4c3:9441:f0:efb8%7]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 03:35:20 +0000
From:   Zack Rusin <zackr@vmware.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "zhouzongmin@kylinos.cn" <zhouzongmin@kylinos.cn>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] Input: vmmouse - add macros to enable vmmouse
 relative mode
Thread-Topic: Re: [PATCH] Input: vmmouse - add macros to enable vmmouse
 relative mode
Thread-Index: AQHZcyp1IdFMBR96qUWRHyEheNCnDq9ADY2AgAARBoA=
Date:   Fri, 28 Apr 2023 03:35:20 +0000
Message-ID: <c0a986aaf5acf10af3a6a3a0220791d18d18df0e.camel@vmware.com>
References: 59df37cf089230dc6d2d62f2ee539ee90f72388b.camel@vmware.com
 <rk3ip31xbz-rk4smwgz5s@nsmail7.0.0--kylin--1>
         <9d739de8fec7683c3a71bc1be3229818325ade0b.camel@kylinos.cn>
In-Reply-To: <9d739de8fec7683c3a71bc1be3229818325ade0b.camel@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR05MB10206:EE_|CO6PR05MB7665:EE_
x-ms-office365-filtering-correlation-id: e46eb2e6-8c64-4ccc-fdbc-08db479997ea
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4pob5zFKIESD1gsbVGrc0oh59BAS9JKSuDh1PxgQjFnj3YWsi0Il+c3p0u3y8ETVn58nuTci7xe4EZ2DegrbpYRTgol5irIEu+Ryk+8F3sX6pYkARmF3NTse+S/b3IsNn8e2HN1jroT4teUuFOtVEY5jx4jNJW8KwtqX7exhAn59F4/MTYaOdg4SBcKkCcqCj+H/thTvwExr9/kmOcKqVoCmRydQJwJz6kZHeyM/cgvCUyfyilG6lQlFMJ/PvlvnxnDKWu44rfDWRJ6OLdWH/UE/336rMascsD5At8yayS7RGeBIsGEEIqZNF3xVsBfeNOpGJ3OLvqbGEYfrWyue4H1CV7RH5UE3yKHd0Y6pvsdGNLBzYKOZm7R7Z+d0SPvfzBZFswvyslTn35q0ikD5qgF0vFfzkdOy2YDJ9bnkGtnIExTq9kjQ0OT+wPZ4BSGr0XX8/Y75z0JiCluX4wqvStzuYsV+IhKE8qugorMumUKW+B/Ze+emYrExLov1YrhvThUJNtXfUbtuXxwk3uHCkxnWkkdA3kzBXJrMRNLv8t29NtAvLM874PwCmKjKEmftj3S26fMpFGY9s6PLl9IgZD7OprhFtRZN7aegwHZCVJzVg+tHrfOmQ0GSjimDCecKp0U6uEYzF5ea1qIwQQlLHNlO0qvf9V6XBrGViOC4gE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR05MB10206.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(45080400002)(71200400001)(83380400001)(478600001)(54906003)(6486002)(110136005)(186003)(38100700002)(2616005)(66946007)(91956017)(76116006)(66556008)(66476007)(316002)(6636002)(64756008)(4326008)(66446008)(41300700001)(6512007)(6506007)(26005)(86362001)(36756003)(8676002)(8936002)(122000001)(38070700005)(2906002)(66574015)(966005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGo2N2pnOThCV1hOTHliU1QwM3YzQTBBdnpDazZnSnIyVnNiSEMrOHltOTlh?=
 =?utf-8?B?ZXpib3BXdW5jS1h3dHBRVXBXOVFtSVppVjdPYkM2NTBLcEdNV0xKb3NpNzdS?=
 =?utf-8?B?bHltc2orMFV0dXZnRDNYa3A0dzNJV1pRWTVmUEVnVWs0WUdOdW5zQWVIZ1Bz?=
 =?utf-8?B?VUxhYi9lMEIxR0wwdis4V3RQMTQzQTVoQU52NHBwZDMyNzR2bUNlNE5RTW91?=
 =?utf-8?B?aFVOY1duV0pVbjlPbEZXOXgxb0xDRHZKaFdzQUhHQmk1M2tiSkNRNUdNN1Qv?=
 =?utf-8?B?VFdyeWczOC80dDg5by9qd0JIOHVRRmduaDE0UDM1WGVmc0x5MTd6Q0ZNWFRr?=
 =?utf-8?B?NHJUanpoSlJTc0U1Tzg4YnNkWFdXZ3dLZUpPRzVCZVp2NzF1TFZJZXNvS1hP?=
 =?utf-8?B?d1hvSnlzUFJjMzk5QkJzcWk5SEQ3OGZzWGpjV0N2bzJESnY3NVE4dml4MnBz?=
 =?utf-8?B?L21XOE9oeFdmaW5HQ1FqaXY4QzBvMFVBV0MxNFBxN2h5eGt0VzZoV3dkNzVt?=
 =?utf-8?B?Zldzc3ZnWWgyTFEzam0xTkJDL2U4K0gvMTBPdWhNR2cyNDNCcVE1bUZ5a2lZ?=
 =?utf-8?B?bEk2eUgrYUhML1ROVG0wNjlFcWcwNVJqZklKbTFQQWorVkpHdFBEaSthTFlo?=
 =?utf-8?B?eXV4dHBLUm5tU0haRjhHWUZVN2NVMEpXOU03TmFuT2k0ZkR2SkJxT0JxemFt?=
 =?utf-8?B?eVYxN3NLd3FrR0JuaEE4TGlyKy8yK3gzTHNCbkRoL1pvVGxldTcrT1gxL1pV?=
 =?utf-8?B?WVYrV21XeGhtMDJMSi9aMG1TNU84QVpTWmtKbTI2VzMyY3BsYW83MUJxOXp1?=
 =?utf-8?B?ZHkwSXA2cWw3MEJVR0FHZW9FOFcwc2FwVEUvV1RhN25jSWlRL1hRenJPMHds?=
 =?utf-8?B?MHhtRXBROE0xdHBITFNVU1QzdkYzaStBVUNyUXpUUHdERSswSHpyT1R4U0ZL?=
 =?utf-8?B?RnhDcy8yQ3R3ODIxc1Rybm9FZGhkSWwrOFByK1pNREJlN2pKNGphL1RNUkJ1?=
 =?utf-8?B?cGVheHN6STV3R0VUemhScHh0amlIckplMnpON3FkN2VUaHBCMHM2cDZsZ1NU?=
 =?utf-8?B?QjJNcld5NWJHRmk5WndrS0w1YVJ4MFV2amZZNkR1UGkxME51WUVKR3RjVEl3?=
 =?utf-8?B?bG93ZHV3emx2TkVIY3A0eGUvd1ZGRFFFMkRWaThRZjMzcUtQV09zREpuNGww?=
 =?utf-8?B?RnVZczFaQ1JnV2xYZC9jMjdNamt4eWorNysxVkdacjF0Uk51dkhtekx4eFJp?=
 =?utf-8?B?MDI1Z2hIaFgrYkphNS9RZC9sd0dkZ1BzWG9nY0lkaTN1R1pTcnlybVA0RSt3?=
 =?utf-8?B?SVpwaE1TeXE2U2JxaUZGSkZGb2RzbXlXdWJXZ01SS3hBMW9ya2FWNGJWT3Va?=
 =?utf-8?B?a3ZPNlRpWTFVaDN2TXFGTnVYUVFJQ3lCcjhIM3dUb2pUZFNhQzJsWXFlQ3Bn?=
 =?utf-8?B?bkNCMCtraVpxVUdFQkFrY09ZR3M0NWxJWjFJWTdiaTJPSm5jbGFJMTc0eUxD?=
 =?utf-8?B?NjNLd3V0Q1p0Q05Vbm9WRzFhMXBvN3pxSEVuelFVMnhSTlMrc3pReXFnTnU3?=
 =?utf-8?B?YjdNYnRKL1dXTkE3NDlvR3BpN3o3Mmo5aUp4UWVHcURwcW81VWtTc3I2cmlM?=
 =?utf-8?B?SEY3cDJwMnBhQU1pUG1zYVBIdjdaMDUrZzNsdHRrVll0SkpLbGlvV3N5R2Y0?=
 =?utf-8?B?MVYyMDN4WGU2NzEwdHdlNXRIOTFtMkRBdGNMRFA1N0R5dmgvQVZqWWgvYlI3?=
 =?utf-8?B?QVROQ3UvRGFISE16N3JIRllVV3VSYmV1ckZkSVNGQUVZb0xJVS85bzRQQjFH?=
 =?utf-8?B?K0F5YXBUbTNyWjhNays3VmdMWkdUaGVRN1VjdUk2U3RwdFgwVE16NFplUzF2?=
 =?utf-8?B?TlplbVJkTi9PNFFLTTkzUXJTUHJuYW5RWGdhVm5ZU2JXamhSdU05YkxFcVpV?=
 =?utf-8?B?aGdqelVEc3dCMStvQU9USk1DNktGdE1rK25xL2dNb3N4N1FORE9BK285Qndv?=
 =?utf-8?B?M2U5MS9FMXFaNmZTUUh0bDRsaFdaVkwwMkpWb1JjVHloRGlqK2dPWUFmSWtp?=
 =?utf-8?B?cmhualNsOHQrN3FpdUV1c0YxN3MrUFlzbk9XemdZQlc4RmRsaDkwcU5uYkFw?=
 =?utf-8?Q?LkEuwSIUDSdkOJqlB2aJSFq+O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E28D11032126D44999C3E9ECCA9E58C6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR05MB10206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46eb2e6-8c64-4ccc-fdbc-08db479997ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 03:35:20.6819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZvKCRq1GyY2QGnURFaIhm+/tTMhA+VbxzsAmuWyFYfPm0NCDaRXiQrblDw7i/DnyyChYhCpD6VKA908olw3Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7665
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDEwOjM0ICswODAwLCB6b25nbWluIHpob3Ugd3JvdGU6DQo+
IE9uIFRodSwgMjAyMy0wNC0yMCBhdCAwOTo0OSArMDgwMCwg5ZGo5a6X5pWPIHdyb3RlOg0KPiA+
ID4gRGVhciB6YWNrOg0KPiA+ID4NCj4gPiA+IEFzIGZhciBhcyBJIGtub3csIEkgdGhpbmsgaW4g
dGhlIGN1cnJlbnQgZGVzaWduIGZvciB2bW1vdXNlIGRldmljZSwNCj4gPiA+IHRoZSBtb3VzZSBt
b2RlIGNhbiBvbmx5IGNob29zZSBvbmUsY2FuJ3QgcmVxdWVzdCBib3RoIHR3byBtb2RlLg0KPiA+
ID4NCj4gPiA+IFRoZSBmbG93Y2hhcnQgZm9yIHZtbW91c2UgZGV2aWNlIGJldHdlZW4gaG9zdCBh
bmQgZ3Vlc3Qgcm91Z2hseSBhcw0KPiA+ID4gPiBmb2xsb3dz77yaDQo+IHBpY3R1cmUgbGluazoN
Cj4gaHR0cHM6Ly9pbWdzLndpa2kvaW1ncy8yMDIzLzA0LzI4LzE4OThiMDQyOGVjYjM2NmEucG5n
DQo+DQo+ID4gPiBRRU1VIFZNTW91c2UgZW11bGF0aW9uIGNvZGUgZGVmaW5lZCB2YXJpYWJsZXMg
b2YgJ3MtPmFic29sdXRlJw0KPiA+ID4gdG8gaWRlbnRpZnkgdGhlIG1vdXNlIG1vZGUgcmVxdWVz
dGVkIGJ5IHRoZSBndWVzdCBkcml2ZXIuDQo+ID4gPiBCYXNlZCBvbiB0aGUgdmFsdWUgb2YgJ3Mt
PmFic29sdXRlJyxxZW11IHdpbGwgYWRkIGRpZmZlcmVudCA+DQo+ID4gPiBzcGljZS1pbnB1dCBW
RC1JbnRlcmZhY2UsDQo+ID4gPiBzcGljZS1zZXJ2ZXIgd2lsbCBub3RpZnkgY2xpZW50IHRvIHVz
ZSB0aGUgY29ycmVjdCBtb3VzZSBtb2RlLA0KPiA+ID4gYW5kIHRoZW4gc3BpY2UgY2xpZW50IHdp
bGwgdXBkYXRlIG1vdXNlIG1vdGlvbi9wb3NpdGlvbiBiYXNlZCBvbg0KPiA+ID4gdGhlID4gbW91
c2UgbW9kZS4NCj4gPiA+DQo+ID4gPiBBYm91dCB0aGUgVk1NT1VTRV9SRUxBVElWRV9QQUNLRVQg
ZXZlbnRzLEkgZ3Vlc3MgdGhhdCBkZXNpZ25lciBtYXkNCj4gPiA+ID4gd2FudCB1c2UgaXQNCj4g
PiA+IHRvIGRpc3Rpbmd1aXNoIHJlbGF0aXZlIGZyb20gYWJzb2x1dGUgb2YgdGhlIHByb2Nlc3Mg
ZXZlbnRzLkJ1dCA+DQo+ID4gPiBkb2Vzbid0IG1hcmsgdGhlbSBhcyBzdWNoDQo+ID4gPiBvbiBR
RU1VJ3Mgdm1tb3VzZSBkZXZpY2UgY29kZS5JbiBmYWN0LCB0aGUgc3RhdHVzIGNvcnJlc3BvbmRz
IHRvDQo+ID4gPiB0aGUgPiBmb2xsb3dpbmcgYnV0dG9ucyB2YWx1ZSBvbiBRRU1V77yaDQo+IGxp
bms6DQo+IGh0dHBzOi8vaW1ncy53aWtpL2ltZ3MvMjAyMy8wNC8yOC8yYzZhOTJjMzNlMjUzN2Rk
LnBuZw0KPiA+ID4NCj4gPiA+IEZyb20gdGhlIHNjcmVlbnNob3Qgd2UgY2FuIGtub3cgaXQgZGlk
bid0IG1hcmsgdGhlIG1vdXNlIG1vZGUNCj4gPiA+IHN0YXR1cyA+IG9uIG9yaWdpbmFsIGRlc2ln
biwNCj4gPiA+IG9ubHkgc2V0IHRoZSBhY3R1YWwgYnV0dG9uIHN0YXRlLiBTbyBJIHRoaW5rIGhh
dmUgdG8gbWFyayBpdCBoZXJlID4NCj4gPiA+IGFjY29yZGluZyB0byB0aGUgdmFsdWUgb2YgJ3Mt
PmFic29sdXRlJy4NCj4gPiA+DQo+IERlYXIgemFjazoNCj4NCj4gSSBndWVzcyB0aGUgbGFzdCBt
YWlsIHNlbnQgdG8geW91IG1heSBoYXMgYmVlbiBsb3N0DQo+IGFzIEkgZG9uJ3Qgc2VlIGl0IGlu
IGxvcmUua2VybmVsLm9yZy5KdXN0IHJlc2VuZGluZyBpdC4NCg0KRG8geW91IG1lYW4gdGhlIG9u
ZSBJIHJlcGxpZWQgdG8geWVzdGVyZGF5PyBNeSByZXBseSB0byBpdCBpcyBoZXJlDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzNhNGYyN2FkMjEyMmZlMDQ1N2RjMmE0MWEzYjFiMjRhYzU1
NmQyNmMuY2FtZWxAdm13YXJlLmNvbS8NCihhbmQgc3VyZWx5IHNvbWV3aGVyZSBpbiB5b3VyIGlu
Ym94IGFzIHdlbGwpDQoNCnoNCg0K
