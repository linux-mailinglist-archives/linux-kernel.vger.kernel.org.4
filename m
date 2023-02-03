Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E45689847
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjBCMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjBCMIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:08:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAA39DEE0;
        Fri,  3 Feb 2023 04:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675426120; x=1706962120;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=FPJnI4zogoWkvpmyeo2pg+eWkiMuOYSblQ2cC7eSyP0=;
  b=nD8xXDdvVp583297Wpji9QIMLiOgj/cxSRmzXyQ9gEXgOT6GQMJmriSs
   /KuN/QFnkPxNbUAwiexEcVgjSnVmr3v2je7MXo8Sw/o5MrjKfrLlMbFNZ
   km9f2mhqbM3yl+5IXonUNe6j0NtfEzVTsrFNk5SCygN/B/SJcv0H+OIzL
   2C+farJnhRrfcoL/4MGZJ4q4p5DtYRyjHpl/3TWRxaohiHWwuSHa7h8Pw
   D9mTyfm/A+aErqcU5W8zkWO5d8Z1cZyyy4ymQOn195+Jb022K8qa1swB3
   rNt/Q3Jzis0tqPskzdz6kDPfmcxE4UocNoNI0hQ4o3R44xl+ssQD1tjAP
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669100400"; 
   d="scan'208";a="210467374"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2023 05:08:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 05:08:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 05:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjL3g+FXrf3NAU2K4nl1gZwMxPqZia+29mv8scuqspiixUu23CzRBIH6C+w8DndSSqSkXMMYkNkGKZX17MJZGunapLspjK1CB0TYwZbx4VLOPXfMRRNyd7V1SE6bodJX+tdkGaXmO5K/BTycyuMFp3HCQQtKve4CZizHlHhW5cfPab6MTKlhvhOGHyrFJuvOqLeSg8G4IqCG3UyZnFljiSSvybteeDhCKnxCNI7rQKaIJR6dW8xC+JxuDdENsQWwWuZbgPCfYoRqyAbU7zcmxBRY7j/IoaRfHgUxSK7Z97TlEbn1tP4Teyuel15D0gz4BKdGuBbc9+GKC7rkquD2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPJnI4zogoWkvpmyeo2pg+eWkiMuOYSblQ2cC7eSyP0=;
 b=nw85uQHMKs5N7TiqLRa7dpnvO5yPeqyQSqeoL9Vv/bhlTiiu1f6H57yzbmF7pCYt/ou2rj9W2dDA5gndWQLB9BBi4ZsgakR5thMkqPShg0N60+ik8zq1iXmOo43p3Vbo4SnaIy/dg+ckjVxYlKFxOLezzTx+IX3Pke8MJYJMT+aXg9j7xab0hqeXSD0kKyVI7/PDNGf4t7pSFxoeo7Gfk0yOsN45fDitGF/98wsdwNcNyQ2WWD1EB/fN8rxjFMbCmGV3qMNYDOVPbJNR15FrLGvQRN4hVO0d6RX8J7rbrqWfTvhDOkCLGdDozH4S4aEUIKGEj0wYXiirOn/SyXsXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPJnI4zogoWkvpmyeo2pg+eWkiMuOYSblQ2cC7eSyP0=;
 b=nEFD/a699y8ZFswVo+KXPCUmsbT/roxzZdCtzYtqeZ6ZZKWCNL1ExsGgAxh5SDQUrxMLbuQCb74XAepBfwqwlQ4JHqdGChOS5nOmXbh+gsfj0B8vS+mieZE8zXAvUJHU7K+96CRXljmWRZw2JZCbZi3xaWg/Ekp/bO6xUkgrUjM=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 12:08:37 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 12:08:37 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Manikandan.M@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Dharma.B@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Balakrishnan.S@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <Jerry.Ray@microchip.com>
Subject: Re: [PATCH v5 5/8] ARM: dts: at91: sam9x60: Add DMA bindings for the
 flexcom nodes
Thread-Topic: [PATCH v5 5/8] ARM: dts: at91: sam9x60: Add DMA bindings for the
 flexcom nodes
Thread-Index: AQHZN8g+J74tCSrVBUqxz9JJjEnbUA==
Date:   Fri, 3 Feb 2023 12:08:37 +0000
Message-ID: <74aa105e-e898-0755-436c-ec5ae3c1158f@microchip.com>
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
 <20230203034833.451461-6-durai.manickamkr@microchip.com>
In-Reply-To: <20230203034833.451461-6-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|IA1PR11MB6148:EE_
x-ms-office365-filtering-correlation-id: a2c29e01-a740-412c-16d4-08db05df615c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sQjNchNu9Zr+vwvC0TmMGMrOEv45k7H+ohdU1j8rXv8f9sWkpSODYDpFuPRZRaeKo+gIvySPEvvNmyIdwuDvGKJsc8C/NSBRZ0pTDmcPIMPsqbD+unHxAl9rg8pR2S6tOMQIcYtgIqaYOiDqLfIklmNswzmnaDs+XRCfR654zJ9YjX/9sQt+ZmPJqYY4euowTBV1ZyFRn8xFHIHgqfvcMmMIbe/tZHjdPNIPfTUvEX45xltzjJtKoTCpu/W8paeJcep5H9zrb7ZpPosTAU+UjqT2z8yFybP27t7xwaiq0ZfUrzN0MyqENJFluDwQRuZItT3dz96PW4BAjxHul8OrSkuV4ZvXw2zrcZLBH4OU+xsSX94HkmvdRuhbmeht0Bqw/eOAl9njItSuHuECoa7tQIFfIyu95FXidLkcZRvIEoaa6LCqftC7DmcV9BYbZlUXcb5DE0JO8nn5V4mm0mORSgWLxmewoO2Sa6SyNFWmHbZ2zKetU0JVqc7SkdTjTXs+TtCPpJv0Fxe+CWFmO4KBx96Ryt9N/OKa6WBt+sTKP9jGcWXvuaxps1IVJJpkdamlCB9rmx4T/wioE3flp+eP0UuGUGEvaPnnBMokBDctp2/tadsVFG91B+vnr3ACP1doQxDSUV0Y5sKGSe9QlqyaVdMue1r6xy2qaq2QYXCGM+dm3fWM6egkDm19ypEzfe2rxXn8fJuTRZ4drEfNXTnUF3He6L7AueOh4DxCBw5GJg3tWNKP9t2kB4iAlsTLowFRipiodP6gUudRPwotUYwFN6bHbEqnN35LGTaojOKBpik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(66946007)(76116006)(8676002)(6506007)(6636002)(6486002)(478600001)(26005)(110136005)(53546011)(6512007)(36756003)(316002)(186003)(5660300002)(86362001)(7416002)(2906002)(91956017)(41300700001)(66556008)(31696002)(66476007)(8936002)(64756008)(71200400001)(66446008)(2616005)(83380400001)(38070700005)(122000001)(921005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXZsZUwzc1dYNXVwNzhra0NNRlFhSVUvSzZXNXIrMy9nY2NkdEZJNmxSVC9y?=
 =?utf-8?B?bUdubVo2VXpiZUFGK3FSS1JLMjZ3S0NFeERHMm1Wck5kekVNYlhFUnRiTGJl?=
 =?utf-8?B?dHFxL3FhbVI2WWhvdlhvb0JNOFBhbEVxQlFlVHN6ZWZKTThzbVNuTGRHdFVO?=
 =?utf-8?B?VVFIVCs0dXJIUDRhOXZXUDl4UW5KYmYvS1VzQmFOUmxiK0JBcU1YczV5cXNP?=
 =?utf-8?B?dVF6UndGZWJTT1ZicFhPamorMWJ1dTJ1Yit0Zm1vb3cyT01nRlMzeWl1WTRy?=
 =?utf-8?B?RlBTSCtET1ExaXdvbXd5MVlQcHFWQnMrY2FLVDFlQk5VY3JWYno0ZkptMXVG?=
 =?utf-8?B?SGtub1pkTkdyRDl1S1F6ZkJyNzcvNDNXTTFDTjV2V01hNll4dkV5U0dmcWpl?=
 =?utf-8?B?T0Nod3hEbmNiVExZNmNYV010eThIdFA5RkdjTHBrVnNZdFU0bndhTkFEUWkv?=
 =?utf-8?B?cjcxMGVUZlQrUERkemFHcTdQREhraGJOUlcrVE1VWURSL09ZQlZxNkJjTkNh?=
 =?utf-8?B?R3ZOMVU4TzlWYytUUWEzSG1JM2RsMkMzUjBFVHQ4emNaMXpwMERtUkNWNlhn?=
 =?utf-8?B?azhsNGVWOVFSdWE1cTFZZXphVmpvdTZYbWE2a3krUWQvRHNXYmJIVHVaQm9L?=
 =?utf-8?B?UXdhNC9NWkxaT2sxdkMvYWc1T09DZ3hHd2pEdjFOQk5jc2Zka2prSDFxZ1FJ?=
 =?utf-8?B?dUM3dWZId3pDUVlyd281TVVHWXlKeUtCbnVleVVOZFZodFE4cjl0WHBvTnIv?=
 =?utf-8?B?ekV4QXdkRmFnR1QvTUYrUGtzd2hYQ3pvbUJvM3JSQ2h0b2VsUFJpSkEzSFFB?=
 =?utf-8?B?RHdyR1FjTVdjYzBFTC9lajFsT1BaREp0Ly9sYlJGRzRhSXVLZS9zMG9DSVRk?=
 =?utf-8?B?dkx5R1VmelVqNjA5a0Y3V2VMdzFIRlorRmlpTWhZK0lPU0RCOFlwTC9aSG1F?=
 =?utf-8?B?cGYrcVkyOXo4YkQwOVpoZzJpNDIrajFtcVp4YnlTcWtwOUJuZ2ZwT0xHcDZq?=
 =?utf-8?B?UDA0M1RkTStKRDAxZFVhVWVPbGgwdm5yQlpMSG94ZFU3MXlXMU9jNHIwM2My?=
 =?utf-8?B?SjlkeUdMc3RKeEhZMkdnREZ1cXNNMDZBL3ZmM0VGeHJ6UzhmbEhWVVMrQUVK?=
 =?utf-8?B?UU9CNThuTG8xZzdjYzhUMjk2dyszTjBXNVVCKzZZQmpCMHR6M04xeVhoY3ZL?=
 =?utf-8?B?RW9laVR4YTM2UVl4NlJsdFRrRmYrc0VWNSs0RU9wTnVWVlJCY2VkbjhaOEFL?=
 =?utf-8?B?MlhIV0xUSUdMYzFibjhGRkZxZ0MvWUxYTURpQlRCV2syU21nTG5JNEwrZnRW?=
 =?utf-8?B?VjZLR0V3cEtmSENjTDF0Uy80VFVQTFNwN2w4UWpXTC9ZSExqRElNdkU5d3Ew?=
 =?utf-8?B?cW5LOUJQWnlKY1dOdVhWSVdUVEdnc2ZGT0ZtVEdLV09OTHdzVUZSQU5YOWE0?=
 =?utf-8?B?dzJ6b01HTnBQN2NYODBNMTdPaThHbTJsMnl4NWduaDA1eENZQUpzeTN0MjR4?=
 =?utf-8?B?Y09LcGs2Q2ZjdUNlWjBYbndZTmo2cldtOW8veHZzNDRCZXdGZ3k5VFdhOHNR?=
 =?utf-8?B?VlZxM0JTOXd1TEpYYnRWQTN0RDNvZjZlYU5ybGNWYm5IVmFxSDdpL09Lc2Nt?=
 =?utf-8?B?NHVuS2RTbU83ODdEMEFlc3FMTHVIM1VOcUNwQ1N5SVFCMTVabkRoMTczRTRp?=
 =?utf-8?B?ZWJDSElHY2FyRTJkUVJsbWNTWlBwVlBJcThqSDdZK05IbVEwQnIwMWxscEsy?=
 =?utf-8?B?cW52aUNGcm9yMW4ycC8zQkRKMWZqN2lZOVNiRS9YbElLUHkxVmxrTkM1K3lp?=
 =?utf-8?B?UlV0N0ZkZGVNblZsR1hNeTh6NUQ2b0t4cjlDM3llYmJCWTVSaDdTV0U5TE51?=
 =?utf-8?B?Tll6NzhaSGR0K0RmeW9zRW9GVWZQMHl0MUF3bERmdzBFMUh5MElLMkVVK0F5?=
 =?utf-8?B?N1hYTDBEbU44QTdwaFNUUENoL3pvUEZMMmFJUnBueUcrbDlseVdnTURibVhF?=
 =?utf-8?B?MzNkK2p3K2NqSWhaamhjeCtSbk5rOUNuL0YyYS9VRVJ3d2lERkRKR1c0UCt5?=
 =?utf-8?B?Wm1xbm5zUzBRcFJ1bUtwcndTRng4b0ZuTFBHRmZQU2I5KzRvZkh6azVTbHJN?=
 =?utf-8?B?Uko3QUpEamh0bWF4ZkRwMER4bnFRVTllVFVPN2gwdmJtOXM3YW5ycWdzMnVt?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A55F714B02C49499772CE305700A9D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c29e01-a740-412c-16d4-08db05df615c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 12:08:37.1859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHc3Zmruo/15OPMfKecU+uhe7zNfI9vv8n6rkMmyayvXcB3UxaZb4s2hdQANFYmcmIA3gTrTkevYik1VplMCGhgif/naSueTrlAZy1xK6y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6148
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDIuMjAyMyAwNTo0OCwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEZyb206IE1h
bmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCj4gDQo+
IEFkZCBkbWEgYmluZGluZ3MgZm9yIGZsZXhjb20gbm9kZXMgaW4gdGhlIHNvYyBkdHNpIGZpbGUu
IFVzZXJzIHRob3NlIHdobw0KPiBkb24ndCB3aXNoIHRvIHVzZSB0aGUgRE1BIGZ1bmN0aW9uIGZv
ciB0aGVpciBmbGV4Y29tIGZ1bmN0aW9ucyBjYW4NCj4gb3ZlcndyaXRlIHRoZSBkbWEgYmluZGlu
Z3MgaW4gdGhlIGJvYXJkIGRldmljZSB0cmVlIGZpbGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
YW5pa2FuZGFuIE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+DQo+IFtk
dXJhaS5tYW5pY2thbWtyQG1pY3JvY2hpcC5jb206IGZpeGVkIGNvZGUgaW5kZW50YXRpb24gYW5k
IHVwZGF0ZWQgY29tbWl0IGxvZ10NCj4gU2lnbmVkLW9mZi1ieTogRHVyYWkgTWFuaWNrYW0gS1Ig
PGR1cmFpLm1hbmlja2Fta3JAbWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+ICBhcmNo
L2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMgfCAgMyArKysNCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL3NhbTl4NjAuZHRzaSAgICAgICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9k
dHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IGluZGV4IDZiNjM5MWQ1MDQxZS4uMTgwZTRiMWFhMmY2
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IEBAIC0yMDksNiAr
MjA5LDcgQEAgJmZseDAgew0KPiAgCWkyYzA6IGkyY0A2MDAgew0KPiAgCQkjYWRkcmVzcy1jZWxs
cyA9IDwxPjsNCj4gIAkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsJCWRtYXMgPSA8MD4sIDwwPjsN
Cj4gIAkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gIAkJcGluY3RybC0wID0gPCZwaW5j
dHJsX2ZseDBfZGVmYXVsdD47DQo+ICAJCWkyYy1hbmFsb2ctZmlsdGVyOw0KPiBAQCAtMjMwLDYg
KzIzMSw3IEBAICZmbHg0IHsNCj4gIAlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgDQo+ICAJc3Bp
NDogc3BpQDQwMCB7DQo+ICsJCWRtYXMgPSA8MD4sIDwwPjsNCj4gIAkJcGluY3RybC1uYW1lcyA9
ICJkZWZhdWx0IjsNCj4gIAkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZseDRfZGVmYXVsdD47DQo+
ICAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IEBAIC0yNTQsNiArMjU2LDcgQEAgJmZseDYgew0K
PiAgCWkyYzY6IGkyY0A2MDAgew0KPiAgCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJI3Np
emUtY2VsbHMgPSA8MD47DQo+ICsJCWRtYXMgPSA8MD4sIDwwPjsNCj4gIAkJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsNCj4gIAkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZseDZfZGVmYXVsdD47
DQo+ICAJCWkyYy1hbmFsb2ctZmlsdGVyOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvc2FtOXg2MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+IGluZGV4
IDFlNDAxYTkxOWY1Ni4uODQ0Mjk3MTQ1OGU0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290
L2R0cy9zYW05eDYwLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNp
DQo+IEBAIC0xNzcsNiArMTc3LDE1IEBAIHNwaTQ6IHNwaUA0MDAgew0KPiAgCQkJCQlpbnRlcnJ1
cHRzID0gPDEzIElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+ICAJCQkJCWNsb2NrcyA9IDwmcG1j
IFBNQ19UWVBFX1BFUklQSEVSQUwgMTM+Ow0KPiAgCQkJCQljbG9jay1uYW1lcyA9ICJzcGlfY2xr
IjsNCj4gKwkJCQkJZG1hcyA9IDwmZG1hMA0KPiArCQkJCQkJKEFUOTFfWERNQUNfRFRfTUVNX0lG
KDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+ICsJCQkJCQkgQVQ5
MV9YRE1BQ19EVF9QRVJJRCg4KSk+LA0KPiArCQkJCQkJPCZkbWEwDQo+ICsJCQkJCQkoQVQ5MV9Y
RE1BQ19EVF9NRU1fSUYoMCkgfA0KPiArCQkJCQkJIEFUOTFfWERNQUNfRFRfUEVSX0lGKDEpIHwN
Cj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUklEKDkpKT47DQo+ICsJCQkJCWRtYS1uYW1lcyA9
ICJ0eCIsICJyeCI7DQo+ICAJCQkJCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+ICAJCQkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJCQkJfTsNCj4gQEAgLTQxNyw2ICs0MjYsMTUgQEAgaTJj
NjogaTJjQDYwMCB7DQo+ICAJCQkJCXJlZyA9IDwweDYwMCAweDIwMD47DQo+ICAJCQkJCWludGVy
cnVwdHMgPSA8OSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiAgCQkJCQljbG9ja3MgPSA8JnBt
YyBQTUNfVFlQRV9QRVJJUEhFUkFMIDk+Ow0KPiArCQkJCQlkbWFzID0gPCZkbWEwDQo+ICsJCQkJ
CQkoQVQ5MV9YRE1BQ19EVF9NRU1fSUYoMCkgfA0KPiArCQkJCQkJIEFUOTFfWERNQUNfRFRfUEVS
X0lGKDEpIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUklEKDEyKSk+LA0KPiArCQkJCQkJ
PCZkbWEwDQo+ICsJCQkJCQkoQVQ5MV9YRE1BQ19EVF9NRU1fSUYoMCkgfA0KPiArCQkJCQkJIEFU
OTFfWERNQUNfRFRfUEVSX0lGKDEpIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUklEKDEz
KSk+Ow0KPiArCQkJCQlkbWEtbmFtZXMgPSAidHgiLCAicngiOw0KPiAgCQkJCQlhdG1lbCxmaWZv
LXNpemUgPSA8MTY+Ow0KPiAgCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgCQkJCX07DQo+
IEBAIC00NTYsNiArNDc0LDE1IEBAIGkyYzA6IGkyY0A2MDAgew0KPiAgCQkJCQlyZWcgPSA8MHg2
MDAgMHgyMDA+Ow0KPiAgCQkJCQlpbnRlcnJ1cHRzID0gPDUgSVJRX1RZUEVfTEVWRUxfSElHSCA3
PjsNCj4gIAkJCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA1PjsNCj4gKwkJ
CQkJZG1hcyA9IDwmZG1hMA0KPiArCQkJCQkJKEFUOTFfWERNQUNfRFRfTUVNX0lGKDApIHwNCj4g
KwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19E
VF9QRVJJRCgwKSk+LA0KPiArCQkJCQkJPCZkbWEwDQo+ICsJCQkJCQkoQVQ5MV9YRE1BQ19EVF9N
RU1fSUYoMCkgfA0KPiArCQkJCQkJIEFUOTFfWERNQUNfRFRfUEVSX0lGKDEpIHwNCj4gKwkJCQkJ
CSBBVDkxX1hETUFDX0RUX1BFUklEKDEpKT47DQo+ICsJCQkJCWRtYS1uYW1lcyA9ICJ0eCIsICJy
eCI7DQo+ICAJCQkJCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+ICAJCQkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ICAJCQkJfTsNCg0K
