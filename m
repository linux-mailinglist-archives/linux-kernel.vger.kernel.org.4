Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3373E674BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjATFMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjATFMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:12:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F24CA04;
        Thu, 19 Jan 2023 20:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674190785; x=1705726785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e/Rd5VQPHzobJwkvAMq5Bj4aaBEw5gYvTnpC+RmXV0A=;
  b=MVWzXlvVbsnzE/1y3DhWqQUvvo0IPilBojXHA9ebq77b4oJ4Gngs1SMn
   05SSg2hIJ4kGtHfNRMUP/6kMAxdULlwGJrmlGU2AtQVZYG20NjHwiAj8Z
   eg9Gh+2xJ2taucoXr9lXkUlublwPLrPzpCy3eZ7WZx4MuUJa5YofK3ZDr
   jshwqhE/iqNaYhxQQ8Fm/Zvr7mmx4Vg8CulQ+5IfHsb83mQALJ0k+0WAI
   XFsxWTsRDenxUSdRBxHHQEEJX3+wrF3ddKKJfX9fWdhtFoy/qTzpWDUD6
   U0ZZxCsl2biKcvwZvfH/alU1iTpICzgnUJSKNWE1DgPPIarR+4L+5ANL0
   A==;
X-IronPort-AV: E=Sophos;i="5.97,231,1669100400"; 
   d="scan'208";a="208589452"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jan 2023 21:59:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 21:59:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 19 Jan 2023 21:59:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzm45DzEv2u1HEc+sQuWQX/WkxbbaefT/DuV++yBBh4Pp0OekTo5e0LcUFIGo0X9ec57r1BQ/djGulJyoaBNfsQ36LgYbA25Jk4wtKSINUGDSQDVc1ZTY33vDua6Rdtv2xQY3T/hO7tTLCe/RxMUbgBw5jrXUeDsflFCWLW2mHLiBRvX497lm84vxLsy398TJ8HB+TusJfW0YC9y8fVZR4QkLfTWPy8yu/tJNGyUKzXpp7tbd9qFxX+dsXeJMbI4txQhSRBWGHDOR5EkIWvKQ4ykv8nZ/NVPsMmEE88zESDPQ4886GdzRDoVBjvVUpH3evNYRs85A62Df6yoEZxQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/Rd5VQPHzobJwkvAMq5Bj4aaBEw5gYvTnpC+RmXV0A=;
 b=PUXCTXSjQLePmMuEUgLOHhe9/LXGC0uILniDzHIC7hKuKzR9C/8AB1RiZSLoIx6DIe78/GSfK/BPfeta2J+szgIodXl8anuP5QxlykqM4KCZF4qbeL1U+qbNCEmveEBfba4NEh+P0Qhm+AO4HtnBNxEc2dZDnvuH+BlqFLDn8070KLI35sdH5+qu/AmAUFBWxrjrzzbCw0JilCLZylPbABnTtf7QLkE+lNPjU6qcmLtwSQ87qBBpYED6ArX080rLdI9O3uDE32mX4B/NwcZ7O2pH/FWcmUXNklCZ8xcOx5qkNtaflPeXdaRiVyDtip0G9tAk7Pj5wfp71UlLLQ+8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/Rd5VQPHzobJwkvAMq5Bj4aaBEw5gYvTnpC+RmXV0A=;
 b=b7SLrD5q8aKcpZeSKW1OGKy9eraTUx9JZggvY3NDn0nRMrVsG69G1kHVX3RWmHdmoXQc3T+TqqRIaYD0WLLJGMyPX0i3aYwwNUS5fVpOVA1+MD3aLWwMfeW9E3mxALhtScyklyECalOEndmzhuRlnSZtqh1e4GrViTMTwlqhLoY=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 04:59:13 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7%6]) with mapi id 15.20.5986.023; Fri, 20 Jan 2023
 04:59:13 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <krzk@kernel.org>, <paul.j.murphy@intel.com>,
        <daniele.alessandrelli@intel.com>, <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sakari.ailus@iki.fi>
Subject: RE: [PATCH v10 4/5] dt-bindings: media: i2c: imx334 add new link_freq
Thread-Topic: [PATCH v10 4/5] dt-bindings: media: i2c: imx334 add new
 link_freq
Thread-Index: AQHZK/lYcgpkPgR/pkmkFolTYuHNEq6lqomAgAER/ZA=
Date:   Fri, 20 Jan 2023 04:59:13 +0000
Message-ID: <PH0PR11MB56117AF4A3FC0AE8FB4D05D781C59@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230119112848.3523273-1-shravan.chippa@microchip.com>
 <20230119112848.3523273-5-shravan.chippa@microchip.com>
 <dd96a81a-84c1-fa82-627b-894cae5f7bdd@kernel.org>
In-Reply-To: <dd96a81a-84c1-fa82-627b-894cae5f7bdd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|MW3PR11MB4522:EE_
x-ms-office365-filtering-correlation-id: 213616b6-77f3-4043-021a-08dafaa312f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Erg9HR3OV2CxTaMN1UnoV6nq9s39MxfXgq7bcx3BGosxnAjsckScRJAwi5EKZBmYVIWlNtjqKZUILKNvurxZvfTyr3jF3qAW9d50frL5p2hugtjlkSS/wpTpRRSuJ3lGgFC0SIMIFbRdiV5z6ug/0DIZmkxPpJZbJSuC5pVRcheCG91OmZ3Enn2KtL/MX/Djx8O/TrMzPJFPC19uAHpYDHt3xG3+iwfBEngZlQ/G2Xez5kMRm3Gj85uyn0zD31RZSdhaByzqP4rpscI7LOjmI9lOtzYjsYzMx0s6pPiOq4an/gidGT4B+ds60IXb2kfZs5xylXki65/X9JxNoMMqNuyxuIE1zQpPE1bdwWVsl8Zvt9i9VPWxeunOlQJHJvU/42FyrxEytseexoFdaU5FrpvVXThh+kfam9/T2ZD3co46Q9GV9upTZhcTmhfXndWNDSQ4me6xbJLxP/KpuvnBNBu3o2JSNou56MsiMJS1LVug+AukBhQReZQq6lngwjh/4654w5hELQWt80P5QxH/noHO2Wc/S+b6nymMhDtMzuMxJE7t/9bDRkCtZzx8ZV+bsKI4o3ntfYlhm9B5f1+LkamammnkztdEmxA/StFU/nsd7unQKzLll+kEzZVnf+LN3faNT+jbh5gVXLz/oq5p8sU+2kFL0o8OfBpCSxShkiOOBUcsJrGhIxlDxdSB+ck4mZDe8Yj5DELh9c9cScAAWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(5660300002)(52536014)(8936002)(4326008)(8676002)(76116006)(66446008)(66476007)(66556008)(66946007)(26005)(186003)(9686003)(38100700002)(38070700005)(122000001)(64756008)(86362001)(2906002)(83380400001)(55016003)(33656002)(508600001)(6506007)(110136005)(7696005)(54906003)(71200400001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWJyR1BHTDJIdUJkS2NIZWNRRmFxc01ZUEFMRjN4dytXQjFpV1J2Q3hZbko2?=
 =?utf-8?B?eFh5WUt5WTJwTHhNTDJTalhiV2hHUUlKWmJ4eFpDeWpMeWhmWXBtL1M3ckJO?=
 =?utf-8?B?MnhWZnV2VUpOKzB1NmhRZ2hSWkFVM2hsYUVWb2pSKzZ1dmE2NnRYNnhVTmFB?=
 =?utf-8?B?WXhiQmVwSWpuVjlVN1hZVm5aQ0Z2V0xHeTBIZWQ3cXprZGtuYmxrN1gyb0lj?=
 =?utf-8?B?KzNpaDdVSWFtUU9ncVlpWVJoeTFYcVJHejVoSUVoME9zMnZNdVVrRU5Dc1F5?=
 =?utf-8?B?bU9qdkdPajZPYzZHayt6d3VUenFKSmpEeXFYRTFWSGYzbGgvSWpaRUlLU0to?=
 =?utf-8?B?WVUzclhSWGVIZDkxazRSWWl2Q29wNTFvN0xsZjA0OTl0cUNTMjdhc1pNbjZQ?=
 =?utf-8?B?WWZNUERjUHM0ZTg0ZVRVZUFLZUM3dkxhMzRCVEpBSUNNc0ZnZGt1dFFCSk1v?=
 =?utf-8?B?dGpqanBpejJuMmFFSFpOdWdrT1ViQm92STZXd29DaVRZdkU2eDBseThkaDZz?=
 =?utf-8?B?dmFOTlZvSHFvUkN0YjhwNU85YUVXZ1Z2WmRGOFo1Nk11bTR0V24zNTZqc3Qv?=
 =?utf-8?B?YkdTSmVuazNwQ1Z0RGplWis1RFYzSjhmTC9xRnZBSkJwWTU0ZjVsSDJZeDE4?=
 =?utf-8?B?VXoyU1pwbUJndm9aaW04YlVhdmFJNTBWZXVoT1p0di9hbTRDTFdGSERjK1NM?=
 =?utf-8?B?VmgyT245aTc3T0VWMEM4all0Z2h6UVhOc1RFVnZJaWFsdWlKdXBrbldaUWll?=
 =?utf-8?B?ckIyY0dlaFNua1BoRFpEUzhxYWo1OGE2NjVrT2NiWU4ybHd6aVpuVUg1SXhv?=
 =?utf-8?B?TkhLTFlhaytGWnl0bDBxeGVyZjJyK2ZDa0M1elNSYlBkMDJEVWg3Y2pMdHZ5?=
 =?utf-8?B?bkI3ZXVGVzhwVnhIWTZTNzhVb0tIUEFib1J2emFHRm9LWUZROU5xem5qT0Nh?=
 =?utf-8?B?WGQ5VjhPdHBjaGc4UWJCNkJZSHR4UDAzQXJxZkNYYmxJamlVYVQ3RlNkTUpj?=
 =?utf-8?B?V3hiUzRTN21GNDRSSEhEUVlzNWtacGRwT0NJVEo1NUZ6WE90bmN0TmgvUkZy?=
 =?utf-8?B?TFY3MmppZjJDZURibGFwRm1sd0xraE9uRUo3YURKYVJ1T0Y5MFdtc3gwQ1pE?=
 =?utf-8?B?WVUxSFJWek0xQmZoUjR1cXdIWlNoZ3hFTlBBUFpQaHU1T0dXeENIcnhEdHBq?=
 =?utf-8?B?dFBVU1ZIQ1dtdGZ0QWwyRi8wdkp4YWxGNDhxa0l5ZlFBWTlhd1lLYTJJSFQx?=
 =?utf-8?B?K3FNbG9sQ1RKOWJ4eGxDSVRaMSs2azR3cFR5RXZybmtFcUxzVERZNVFHVGhL?=
 =?utf-8?B?OU5lNlh0bUlJK3dkZ21aK1ZIZ1hXL0MyeDVTd0F1dG5oMzdWU2haaU8xMXg5?=
 =?utf-8?B?c1BZUlhQV3Q2RjFkRUxlaUY4eEpPZlFadEcxalMvYjAwTzdCMlE1Y2FRUDVk?=
 =?utf-8?B?dldmQXhtRit1ZUZRZTN3U3BmNm1WZjB5QVRveSttSkh6RWFGWjVsd2lZN2s0?=
 =?utf-8?B?b2pUYzNnbFNtcGhiMDNHV2ZlZnhGM0huTmhCcEYzU1VRNDVHay9hRVdkbzJY?=
 =?utf-8?B?L0FSQngrblRjTEc2U0UvWjhiRVlVVDhJL0I0bnRLUjRXczhza2tKa2R4dWcw?=
 =?utf-8?B?MEdsbkx1SnJ5OU1DZENVYXNsSitNZmVDdTBOTG9BWHlBNlFJekozL2JqaEEr?=
 =?utf-8?B?ZWZ3N3IwOWszL215bnlpQmJUY3BSNVRISUZadGJ0K3JXYXRlTnRVOWRiQ0Jy?=
 =?utf-8?B?aStPMVFTV2QxNXp1YUg3NTNQdUp1cVo5Y1hac3dzU3VGTGRNUVBYSXVkRC85?=
 =?utf-8?B?RDFseWt3RWUrM25OaDg3L1ZUYU14aFZKOWFyLzRyTXY5RUFieGJDbEhMNENJ?=
 =?utf-8?B?TDFTMjdHSTlWYUhHU3FpSGdWbGk5TXNidkcybTk1TDUzZ3lOcStIN2dNYmRo?=
 =?utf-8?B?RDY1Ky9BT2U4b0x5WCtWeEdoSkMzU0pGYkM5bW1SMGFldU4vb0N1RW54SlZi?=
 =?utf-8?B?L1o5eW9zaWUwdjZsWHdLSEpod3dNR0dzMDJ2Rk9qR3RoNEVVdm5uU3R6YTRU?=
 =?utf-8?B?T3MwbmFReW5WRHlEQkhUTDdCNTJhNnJ5YnAvK3g3emNIWU51S1RmMDF5U2ZO?=
 =?utf-8?B?REZBWGUxWmpkOUI3bDVwZ1puNStRSW1PdC9QV2JtVFZBWkZPU3Exb0hFa1Jq?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213616b6-77f3-4043-021a-08dafaa312f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 04:59:13.1047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vlBcxQJSsRk/m3ani8KSFwcNyaQDNnD8wKhprNQ3AOl1tgKMvVLemIneiliDdE9z+sKW5Td05g5wswlKyZ8jGrOXjeJ2vdxiOAzloSuUhOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS296bG93c2tpLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAxOSBKYW51YXJ5
IDIwMjMgMDU6NTYgUE0NCj4gVG86IHNocmF2YW4gQ2hpcHBhIC0gSTM1MDg4IDxTaHJhdmFuLkNo
aXBwYUBtaWNyb2NoaXAuY29tPjsNCj4gcGF1bC5qLm11cnBoeUBpbnRlbC5jb207IGRhbmllbGUu
YWxlc3NhbmRyZWxsaUBpbnRlbC5jb207DQo+IG1jaGVoYWJAa2VybmVsLm9yZw0KPiBDYzogbGlu
dXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBT
YWthcmkgQWlsdXMNCj4gPHNha2FyaS5haWx1c0Bpa2kuZmk+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjEwIDQvNV0gZHQtYmluZGluZ3M6IG1lZGlhOiBpMmM6IGlteDMzNCBhZGQgbmV3IGxpbmtf
ZnJlcQ0KPiANCj4gT24gMTkvMDEvMjAyMyAxMjoyOCwgc2hyYXZhbiBrdW1hciB3cm90ZToNCj4g
PiBGcm9tOiBTaHJhdmFuIENoaXBwYSA8c2hyYXZhbi5jaGlwcGFAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IFBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwgdG8gZ2V0IGEgbGlzdCBv
ZiBuZWNlc3NhcnkgcGVvcGxlIGFuZCBsaXN0cw0KPiB0byBDQy4gIEl0IG1pZ2h0IGhhcHBlbiwg
dGhhdCBjb21tYW5kIHdoZW4gcnVuIG9uIGFuIG9sZGVyIGtlcm5lbCwgZ2l2ZXMgeW91DQo+IG91
dGRhdGVkIGVudHJpZXMuICBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUgeW91IGJhc2UgeW91ciBw
YXRjaGVzIG9uIHJlY2VudA0KPiBMaW51eCBrZXJuZWwuDQo+IA0KPiBZb3Ugc2tpcHBlZCBzZXZl
cmFsIG9mIHBlb3BsZS9saXN0cywgc28gcGxlYXNlIHJlc2VuZC4NClRoYW5rcyBmb3IgcmV2aWV3
LCBJIHdpbGwgcnVuIHRoZSBzY3JpcHQgYW5kIEkgd2lsbCBzZW5kIHBhdGNoLg0KDQo+IA0KPiA+
DQo+ID4gYWRkIG5ldyBzdXBwb3J0ZWQgbGluayBmcmVxdWVuY3kgaW4gZHQgZXhhbXBsZQ0KPiAN
Cj4gU3RhcnQgd2l0aCBjYXBpdGFsIGxldHRlci4gRmluaXNoIHdpdGggZnVsbCBzdG9wLg0KDQpJ
IHdpbGwgdXBkYXRlLg0KDQpUaGFua3MsDQpTaHJhdmFuDQo+IA0KPiA+DQo+ID4gU3VnZ2VzdGVk
LWJ5OiBTYWthcmkgQWlsdXMgPHNha2FyaS5haWx1c0Bpa2kuZmk+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2hyYXZhbiBDaGlwcGEgPHNocmF2YW4uY2hpcHBhQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0t
DQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9pMmMvc29ueSxp
bXgzMzQueWFtbCB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVkaWEvaTJjL3NvbnksaW14MzM0LnlhbWwNCj4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9pMmMvc29ueSxpbXgzMzQueWFtbA0K
PiA+IGluZGV4IGY1MDU1YjlkYjY5My4uMDk1MzM0OTZiMjBjIDEwMDY0NA0KPiA+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9pMmMvc29ueSxpbXgzMzQueWFt
bA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9pMmMv
c29ueSxpbXgzMzQueWFtbA0KPiA+IEBAIC04Miw3ICs4Miw3IEBAIGV4YW1wbGVzOg0KPiA+ICAg
ICAgICAgICAgICAgICAgaW14MzM0OiBlbmRwb2ludCB7DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgcmVtb3RlLWVuZHBvaW50ID0gPCZjYW0+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgIGRh
dGEtbGFuZXMgPSA8MSAyIDMgND47DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgbGluay1mcmVx
dWVuY2llcyA9IC9iaXRzLyA2NCA8ODkxMDAwMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICBsaW5rLWZyZXF1ZW5jaWVzID0gL2JpdHMvIDY0IDw4OTEwMDAwMDANCj4gPiArIDQ0NTUwMDAw
MD47DQo+ID4gICAgICAgICAgICAgICAgICB9Ow0KPiA+ICAgICAgICAgICAgICB9Ow0KPiA+ICAg
ICAgICAgIH07DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
