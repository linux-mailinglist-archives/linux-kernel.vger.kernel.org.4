Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512D8666E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbjALJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjALJ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:26:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E2C55AD;
        Thu, 12 Jan 2023 01:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673515085; x=1705051085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=657C+ClIQFJBaZQjiv8WRavwnGvfS0BOcc/D9e328JA=;
  b=DIvhngoC+O31piKNmN4eRYuIMKtG4GIZOb6tkJ8WgYoY0fTcvHpyxwEo
   WT6ZB0JSJD1EdkpYmGlYmkLtqRgmFdVYz4+6tHVV+yQLzyRFlJFkUsAYT
   ipPhjzYyfWTtI+u7+Qp9LZCVUCSHnn+WgYVAzcYoQG+5CrxV/32UHGq7a
   o0bO1jLdmAFRperTysIFDOa37B/CyAuO+9/CLnloG8lT4dSJ2SOAtHTqR
   6v0Cj5xbNgvjbvrY7A+hJf+QDMX6wbmAea2P/wT3i+Oyz2949SGa8MsaL
   W8qHE+eskR6xX0KYhJq8zyCdEQqJIodkyE9qQuPTolN21un81qc3d/TWn
   A==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="191890891"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 02:18:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 02:18:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 02:18:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJJIh3ryp/QzLI6kenpBK+Z578iy/T93P27zLVZ6VEP9mJ54FBlWOU57Q4OF1vU30EspGWRElgkQybW4bPPEYBekl9Xpk++CsFJZBsywK+movLus6vnbVzE4HmEGPxP91X2LIOMmH28+WDQNaqPc/iZPnbPZG/x15E3HjATRlSk8TI9zjk6gbQkptm+dGwkx3vdIfD4hA7L8ehxHx+52qqJVYEaJHBgFUrPxuDqoxkNAz+JCengo6PcsAO/pxPg7vFHDyguRlPALb/Pnb4F9cePXMiiUSGmmuYHVSYUv575SleG9XoZEK6WR7Lg6eiK125FNsbxC8N09JHu9pv5cjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=657C+ClIQFJBaZQjiv8WRavwnGvfS0BOcc/D9e328JA=;
 b=B9RQwtp6Inmyv5DVgR3ZLKVZ2Xv1Tj6vKwExbHYqdcxWM0yagkWGpzdsu9uiPDHlpxQv9ogFk/VPp4CddzKmp6Z66TLJaYrJWcRIGjiPW8vrfvvG9tzNCpl520WIEMIcSBvkU+B74j6tcZqFVRkfb9ZQa53pIi8VehK5d0NpfRfhv3Lz1OZOw120sQcsGcnklYySfBSZvCF7dmJoNy+/W+pE4tR2IzgK6LioduQdXmIHZUcFS02PtaZxxr6uPwV2Y6esvIhZvD8DybRBttOMXL1bFDAcsFze2O8O5e3tWYgu4lL5MiXTU0+gZYmVlZE7b+u8DPQlNktivoPFOt8IJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=657C+ClIQFJBaZQjiv8WRavwnGvfS0BOcc/D9e328JA=;
 b=vPJEqTk/dXSLOvUVa6gIMhfG2PMMPF0trFOiVXjrvbbFw8OJaoyIKVVAprevlxAkUEG5eWZjty7Ua78tNLPTP+VBTc4WBDC4GXgLVaQvPLi+Z1pZGVlBPJO/wpz49BDg40YaXvCl6VzDILuGm2/2EbiL7E6CKJo3qDPSqFC4k0k=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by IA1PR11MB7247.namprd11.prod.outlook.com (2603:10b6:208:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 09:18:02 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 09:18:01 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Eugen.Hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>, <jacopo@jmondi.org>
Subject: Re: [PATCH v10 3/5] ARM: dts: at91: sama7g5: add nodes for video
 capture
Thread-Topic: [PATCH v10 3/5] ARM: dts: at91: sama7g5: add nodes for video
 capture
Thread-Index: AQHZJmbExX7S01vfT0m/5kJPsjAaVg==
Date:   Thu, 12 Jan 2023 09:18:01 +0000
Message-ID: <f4cbb6ad-36de-bd9c-cd76-37d13e43ba0f@microchip.com>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
 <20220503095127.48710-4-eugen.hristev@microchip.com>
In-Reply-To: <20220503095127.48710-4-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|IA1PR11MB7247:EE_
x-ms-office365-filtering-correlation-id: 685084d9-b8c8-41a2-3aca-08daf47de784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MARm6qrYkx0GcUnoPOGRmUuNaj7mFgWwj9bZe8nBWB9B0Krn5kORgF82V1rb7W0ZHCzMcdm0eXZMl3dNAhBTBghECYjy+n5xwVBdhtQSPn5DuJKqB1FBvBbhlxL+CTDuU/ys5WefjEBTMYjyywAp+ANW78AyBgjcrs96o61OAvC4XmLLchoQIRlgz+O5bd2pn+zVtRp0aA/sBbLHZyFzjLArqEB35aVQEvdukjrbySVaCyC8+ZPuU3RvfVROeWX5d+kEripMdCAhB+2MA+N+68vWauBdDqvDeZ5iUSOByM7wfUThsxrG0BfiK53uVNq+DrZUsdqOMdRm3EiUBWUPzYLLtgnAIdWKlYB+Zk1D+eLLxC5jyYyMua65LJmpSlbMk82qpa+HlcnfuM5Z88RLdOqaGC7CQ3oisl5Vcn40WEPK3idpWHRjik1Z5VRrzSFiiQlAO71mA+zwoaau0uTYp3qDlhZvI3pBP88u1WxRTiFvlFfgEl+X6lZfj2v/7OU8W0dONeHvbipkoQEjci549gjLydBbBH6TUdkonuTYFMmQOs+R7buFJpPg2uGlr80h6frF8llJK9egWoxwYZcFu5AXex++KF6OA5oA39LgztOvrHEGD18Hfi7TMv8ez0RiBAb5PP/lRq/qwQzK0foPBUSFvdwW63NuVFgy1YYkVUznij78H2aFHkoI+VF+Cm/mZNuqz5TiszKbUCFbLEJfztxhDzAb+mjGFtL2Q5Z3U3gtJqjZauqtqtzATVXAxM7Dmg1vlaGV9acSc7AJ5xVohg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(8936002)(26005)(5660300002)(2906002)(71200400001)(41300700001)(66446008)(66556008)(4326008)(316002)(91956017)(8676002)(76116006)(64756008)(66946007)(66476007)(110136005)(54906003)(38070700005)(6512007)(122000001)(38100700002)(2616005)(31686004)(86362001)(186003)(31696002)(83380400001)(53546011)(36756003)(6506007)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1FkYU52Q0hSeEFGTm1GMUtweStpdm1hWWlTZWV5WkJKcG5yMTNZc3FRM2sr?=
 =?utf-8?B?bWdmN2ZtTGs3UG1LdFNzb2tPSElmc3RIcTJQKzNVOE1iWnZvQ0RxNFFrMzFr?=
 =?utf-8?B?am9Uc1hLVjROb3JEdDdzd2c0ZUNTdEhqQXc3N1dKaHBieWVWa3JQa2tsaURH?=
 =?utf-8?B?bCs3VFUwK0tBQVVkWVZhckZSNzBSUDkxV1RjNEtLKzZjNEUyQyt4RUs5NWlS?=
 =?utf-8?B?SHVUKzNJSExoblV4bmphVm12emJWdTNWZEtlZzBBT2xWaUN3clFtQldNU2dN?=
 =?utf-8?B?WjZ4cTd3T0wrejFidE9TTTJyYmxGQ1lZTzVNY1lWSDhXS0FLQUhoUlZpTkdx?=
 =?utf-8?B?VlJLdHJaZi9hR0NjMkNKRkpBVGE0MTM5K2E0RVlZb1htdEN3cHAxSGlteEow?=
 =?utf-8?B?ZGlIR2dNTTZEWThXeElkbHo1RE5iUW81T1ovSjNvdWJpNWcxcnhlVXJaRk1H?=
 =?utf-8?B?bytPdHVYMWs2VDdZU2NoNHpGSXllelAwSENuSXZ6QVhiNXFpRFdJYnJhK3o1?=
 =?utf-8?B?bDRSOHhSZWp2ZXlnUDRJRk9PeTNldkw1YkNIcUdOdXBucDdSdWc0QkswVk1H?=
 =?utf-8?B?UjV3YXB3b2xuS01GS2xVaUF3UFlaRm1HWjhZWkh3a0hHVTZ0QURlMXFuSnpw?=
 =?utf-8?B?M0prZTZ4bHlyUzl0bTc2RTV4ZDlOb2wrWUp6blhEMVJLanBMMG5XY2NGZktx?=
 =?utf-8?B?UmM3UXFleUoyK3BsWTVIM3BlYVc0SlVoaERubFEwQkNNc0lkVzltc3VPUnZl?=
 =?utf-8?B?VGF0NTlPb3A4eHUxcHI0NzhOZVJnMVdPZzFkcU1zZ3dLSC9SbWlFblNmZnE5?=
 =?utf-8?B?L2hadGQrZk8wR2gvNEpNVTRrZmM5MGNteHFhbi9XYy9sNUVZK25TYnNzd0tJ?=
 =?utf-8?B?QWh3THNoYjEyYjV2YjJBdVdFNCt3bUwzZ00rNUdWZUIyNXNWVlg2Y1BTVFJu?=
 =?utf-8?B?d2xCaXMwUkVhcmRtL1o1Tm9vbVowOXZHcW1PWWpZVm0yNWJ1SHpvZzFPM3JO?=
 =?utf-8?B?Sy9vY3I2UWZUaTE4ZGEvbHN6Z1pPbTNBZk9QRkYxTnBiSU9QN1FFcnZHVFJI?=
 =?utf-8?B?MlJKMHF0S0pJd2dHQUZzL1FRYXA5NzNMYThFOFFYb054aU1NMTB0VjRJUFFv?=
 =?utf-8?B?QUVaTUIyUlFlK3ZzczM0QklSR2U2NjNSemZvbHU1WnR6R24xY242L01FU00z?=
 =?utf-8?B?RjdWZHpVejVrbktFODcyMkRjbFpkY01MeGhnbVlsdWJhd2pXYXpvT0ZZZ2I0?=
 =?utf-8?B?TG5Rby9HUkUzWURRTEQ2TDlXS2xZaENDZExhWk1rWUlFbjBKUmpGL1h1V2wv?=
 =?utf-8?B?a2R0Y2NybFZ2L1pCZUNaSUNLTU9rZFlsZ2gxd2JoYjMwbktobmNIdzFOc28r?=
 =?utf-8?B?bSt6WDNnckJWTW1WMWZyd1UwV0JuSTJWYUlSTDZqRW5OYmlNVmlObDByTnJM?=
 =?utf-8?B?N1VJR3BMbTRIOFJpR3F6Rk4ySVR3M2JpYW1ScVg4TGRHVEh5VGNvZTg1MGxX?=
 =?utf-8?B?TjlGVEZBcmRrR2p3V3h5cXM1SHBvNk0wRUpGVytmZjVtZHpsZktkSzczcjZ6?=
 =?utf-8?B?SE9rRHRKdlVWeG5UWjk2amQxYjdJTGxDNU5oNGJScG9TUmdTYUZLbE9HcDVL?=
 =?utf-8?B?TVp2MmM2VTRtU0IyVWZON1ZGZkRoYW1CdFdRVFF3NDVxTlJURHNuNVhYOWIv?=
 =?utf-8?B?N2xmb1RJNHA5cUswYWdzUjRobjdqQXNjYXdOYU1mdVAxenhHTzFpalJiUG84?=
 =?utf-8?B?ZkkyUWVWUHNFK2I3OUNDb0pMV2FuOVJzb1V2eEFpb2JQT0liUjMyU0RES29M?=
 =?utf-8?B?eDRxNWxpMnpxTWJwQ05IaEVlZ1F2ME5sK1o5ckF3YWM1R3RYZ3NlL1hjdUNL?=
 =?utf-8?B?dUpTYWpNTlkwd1owUm56R2lkSno5OWh3TDA4QWYxOXdhUkJ3UlpNRG5UaEJS?=
 =?utf-8?B?SmYwUFY5ZHNyNHBCRnBoWmNmQnFBUmdTN1JuamhLUFMvM0lWaWJsWFJWcHRJ?=
 =?utf-8?B?Ukdya2MxNE40NXVYTEZFTEs5U2RkUFVlWFg4RTNlb3NBOThCRWVmYWZTYnRj?=
 =?utf-8?B?Q0syc0FEazhlbE5ZU0RVUGphaktoalZkcjcvSU54SjhDeGNSMWowVDJYUU11?=
 =?utf-8?B?THhKUExTbFkzaCtEYVB0d3FHaHdMVjJiUGc1MVVvaDQvSjBTVzUvT1kwMzZu?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B11EC8FC1809845B063F46081143FE1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685084d9-b8c8-41a2-3aca-08daf47de784
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 09:18:01.8326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNfQ5xtlksmxHjMFcpPCj9H7cHLT/wpCO1+cvbfqhTq7dohuLxQovks9xPT5/eN5ZcyfcwhlTstACyWvdBqxI7IwMtMT61OQjIU7lB/V3V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7247
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDUuMjAyMiAxMjo1MSwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gQWRkIG5vZGUgZm9y
IHRoZSBYSVNDIChlWHRlbmRlZCBJbWFnZSBTZW5zb3IgQ29udHJvbGxlcikgYW5kIENTSTJEQw0K
PiAoY3NpMiBkZW11eCBjb250cm9sbGVyKS4NCj4gVGhlc2Ugbm9kZXMgcmVwcmVzZW50IHRoZSB0
b3AgbGV2ZWwgb2YgdGhlIHZpZGVvIGNhcHR1cmUgaGFyZHdhcmUgcGlwZWxpbmUNCj4gYW5kIGFy
ZSBkaXJlY3RseSBjb25uZWN0ZWQgaW4gaGFyZHdhcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBF
dWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQoNCkFwcGxpZWQgdG8g
YXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYxMDoNCj4gLSBub2RlcyBk
aXNhYmxlZCBieSBkZWZhdWx0DQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5kdHNp
IHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDUxIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9zYW1hN2c1LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kNCj4gaW5kZXgg
NGRlY2QzYTkxYTc2Li5mZTljNmRmOTgxOWIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL3NhbWE3ZzUuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kN
Cj4gQEAgLTQ1NCw2ICs0NTQsNTcgQEAgc2RtbWMyOiBtbWNAZTEyMGMwMDAgew0KPiAgCQkJc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gIAkJfTsNCj4gIA0KPiArCQljc2kyZGM6IGNzaTJkY0BlMTQw
NDAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW1hN2c1LWNzaTJkYyI7DQo+
ICsJCQlyZWcgPSA8MHhlMTQwNDAwMCAweDUwMD47DQo+ICsJCQljbG9ja3MgPSA8JnBtYyBQTUNf
VFlQRV9QRVJJUEhFUkFMIDM0PiwgPCZ4aXNjPjsNCj4gKwkJCWNsb2NrLW5hbWVzID0gInBjbGsi
LCAic2NjayI7DQo+ICsJCQlhc3NpZ25lZC1jbG9ja3MgPSA8Jnhpc2M+Ow0KPiArCQkJYXNzaWdu
ZWQtY2xvY2stcmF0ZXMgPSA8MjY2MDAwMDAwPjsNCj4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
DQo+ICsNCj4gKwkJCXBvcnRzIHsNCj4gKwkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJ
CQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKwkJCQlwb3J0QDAgew0KPiArCQkJCQlyZWcgPSA8MD47
DQo+ICsJCQkJCWNzaTJkY19pbjogZW5kcG9pbnQgew0KPiArCQkJCQl9Ow0KPiArCQkJCX07DQo+
ICsNCj4gKwkJCQlwb3J0QDEgew0KPiArCQkJCQlyZWcgPSA8MT47DQo+ICsJCQkJCWNzaTJkY19v
dXQ6IGVuZHBvaW50IHsNCj4gKwkJCQkJCWJ1cy13aWR0aCA9IDwxND47DQo+ICsJCQkJCQloc3lu
Yy1hY3RpdmUgPSA8MT47DQo+ICsJCQkJCQl2c3luYy1hY3RpdmUgPSA8MT47DQo+ICsJCQkJCQly
ZW1vdGUtZW5kcG9pbnQgPSA8Jnhpc2NfaW4+Ow0KPiArCQkJCQl9Ow0KPiArCQkJCX07DQo+ICsJ
CQl9Ow0KPiArCQl9Ow0KPiArDQo+ICsJCXhpc2M6IHhpc2NAZTE0MDgwMDAgew0KPiArCQkJY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtYTdnNS1pc2MiOw0KPiArCQkJcmVnID0gPDB4ZTE0MDgw
MDAgMHgyMDAwPjsNCj4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA1NiBJUlFfVFlQRV9MRVZF
TF9ISUdIPjsNCj4gKwkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgNTY+Ow0K
PiArCQkJY2xvY2stbmFtZXMgPSAiaGNsb2NrIjsNCj4gKwkJCSNjbG9jay1jZWxscyA9IDwwPjsN
Cj4gKwkJCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJpc2MtbWNrIjsNCj4gKwkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ICsNCj4gKwkJCXBvcnQgew0KPiArCQkJCXhpc2NfaW46IGVuZHBvaW50IHsN
Cj4gKwkJCQkJYnVzLXR5cGUgPSA8NT47IC8qIFBhcmFsbGVsICovDQo+ICsJCQkJCWJ1cy13aWR0
aCA9IDwxND47DQo+ICsJCQkJCWhzeW5jLWFjdGl2ZSA9IDwxPjsNCj4gKwkJCQkJdnN5bmMtYWN0
aXZlID0gPDE+Ow0KPiArCQkJCQlyZW1vdGUtZW5kcG9pbnQgPSA8JmNzaTJkY19vdXQ+Ow0KPiAr
CQkJCX07DQo+ICsJCQl9Ow0KPiArCQl9Ow0KPiArDQo+ICAJCXB3bTogcHdtQGUxNjA0MDAwIHsN
Cj4gIAkJCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbWE3ZzUtcHdtIiwgImF0bWVsLHNhbWE1
ZDItcHdtIjsNCj4gIAkJCXJlZyA9IDwweGUxNjA0MDAwIDB4NDAwMD47DQoNCg==
