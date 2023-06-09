Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875B77299B1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbjFIMWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbjFIMVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:21:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E001A2;
        Fri,  9 Jun 2023 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686313305; x=1717849305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9ncIcj3gd8i50zq5ykvQL7thPizmXDbbeMftATY9VLU=;
  b=RNuGqcDXU/uPRD531b42bVv3sz7IMKwG6Jrt+1TRsAWuzXghcCpsqdEK
   Rql/LobN55rHQITg73WPzrpNIlJFM24ELH7UvR42L68l4f/KJmQD8PZlD
   5EUz17qpGg+g1h5xIt45LwRdlpj90HUxVsFlZCz6a062bQifNp/pt436W
   cY6ddS3+DGCCanHLdzITMyAyz9hLJd6ZXN32o4madi7mAcOn3Fl3wwoll
   GG5vdb88Sq9TnAeyX6fOaaYm8gfA7XNiIjveKtUlTdAzzy2czNsy3FOlV
   S9IwJZlXW8n62g1DZFt5nyyvKtU+l1EZp2rU2AwQ/SY4yXMUE/Gmeq8P2
   A==;
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="215345311"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2023 05:21:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 9 Jun 2023 05:21:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 9 Jun 2023 05:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxoTud7pgPl5+EkNHVWn98j7CrPiEwpF5I9eRcGejlUZ9YNJ+3YeENAXPDVtSL955RBgcXRJbS2BsFQLdZLa+YglIF8UCKv4O3GUgc6BWP/P6BN3l79yJZ9iT9bauwIJNRaVCwzuXUJkf4tIP/JDVuRIXdr5tJEU1gWxVBpgJ0xdXD3+g6IhJqUwk7NeDoKctf/BPF15d32Mupi2ls2WnjJKpFQ45z7QJL9E/6g9eabdvHKy22u23k/OpKDgkmZaGgyfFOAxxT7A6iAyhp5SIAiPTHk6OOVoMMLsYI+uPoSvww/TbT3y0+mGQnibz4cqU6HnUw6GFlu8DtwooPfVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ncIcj3gd8i50zq5ykvQL7thPizmXDbbeMftATY9VLU=;
 b=nnhCWIweAjNxEcR+1ohgN7Bu3FFSVVbZ5Ca+uQ3LR3kMAWUC32zBZz4rRvxa8T5LbsiszUBafUlqxBVTgONZSK1ULLUqjeCJBoNqWLn+VvT7OqFNjqzCw1mBkwnRbx2bIVEVIk7hKz/q+9Jf4HuvdAWuj4NmUbDotmeF4IIReWyuTI0VN1tb1f4M7yJr5wMste57H+wR96iSEfmQjAkcZMlgdJPI88GTuOZ3p/cSAqMGmEExCBODDiMLwnTpGA9scgZDJ2wq91eJ0aFZosIxC8ySTVxLz7rozOYPz1KBXNVBZRZE5T4XA3+q7ZNFTmkPPnfhIWrr7DgucK5o8M340Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ncIcj3gd8i50zq5ykvQL7thPizmXDbbeMftATY9VLU=;
 b=s3Np7ZMN+jJm8PF0v7OL6T+ZVg/dBUPpJGkXmUuvzh10C/G5Zzr9zfKmobdvsSmBX11uKY5GLj2QSC/E4ilefV9zXZbDu9KI89tkWzb1Tw2KPVgP6mlO5cVd1wHfVvq8RXYlVV9LyeE+qJBwtrH6iYC07qJdBaOnC7TKEt7Diew=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Fri, 9 Jun
 2023 12:21:41 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.024; Fri, 9 Jun 2023
 12:21:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: timer: atmel,at91sam9260-pit: convert
 to yaml
Thread-Topic: [PATCH v3 1/3] dt-bindings: timer: atmel,at91sam9260-pit:
 convert to yaml
Thread-Index: AQHZmszyykfNH4nxck+KJ4qLkcT+5w==
Date:   Fri, 9 Jun 2023 12:21:41 +0000
Message-ID: <897b1a45-dadc-eaa8-eb7d-c604ff723c2c@microchip.com>
References: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
 <20230530090758.1652329-2-claudiu.beznea@microchip.com>
 <46eced08-5bf6-3e4b-7a91-ff4d16c7dab9@linaro.org>
 <e816a8c2-e4fb-a608-f8e0-232135243c8a@microchip.com>
 <9e4a0756-8b42-81a7-5b5c-60c0ebea0d7f@linaro.org>
 <e8fd0340-da21-0cf7-7ec3-a3f278716c15@microchip.com>
 <5fc609e0-a70f-03e6-6ac2-db96a2ff7747@linaro.org>
In-Reply-To: <5fc609e0-a70f-03e6-6ac2-db96a2ff7747@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|SJ0PR11MB5895:EE_
x-ms-office365-filtering-correlation-id: 4e0848d4-f1bc-41d6-9ff9-08db68e414c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFQT2snx0Qnhv2Y8Wc/Mdazibhg9hdVBDTTga9aC4d7RosH3qGOluL2VPcnNt2nYdr4TxdoEd8V/ofB5lzVrtGo+ZLGEE0LAveQVO8u4hK3icWkFJt4V8zmyQtAJ46uFMoUH9FtgRTfR1BccRaWbKOgvfN+pEyEdcUZ7mwdzH0203BOULGgwZFsy4cE9l2es3aEckO6rK7AlOJ+237oEAdLIp0CKkIOe2fhQ8csl2+eV2uD+jnCOxNK2vMDgjS/6EPgzjR/Y4GOKkNV3F7fdttEyxf0pGbIm2y++1l2CD+HtOQA/aJyL4TT1DL2334JAStHg5nUe4HAcKRQRX5URDJo7bW7sfrNXOeTMHS88pw9BOD2KOjIOr//aJLIcl0g1BctHGn4ElcEc1FGnltrSj+5Hr3CFXpGhcR7xcr+4vgULmXe5tL030F3Z/9NhLkojCIAA201K0JHKxWlc5cLKkS5IWkDCaBUHrCmGQ4k4cGLrS1EmVHDaV66wsydDGl2eVqg7HedUDasK/XL8k+70wo8gl1NzuDTH5YSG1xQAJDIHdUAB4CnyKKLBE9rI3XU2rnh/y4v3FSjxCHYP9zi8lciDAmUHpvXMsLJ/p+QYDID8UbLM3jIzL/h0oRGWAJ9C0GCXzBsmZ5LKnqrzZqvSByYP0a36jrzGpCm2p0Obz2OUJ6u4Wi+KVkHxZRotkxZbBOmsgEjwm3m9x3PowZdJ4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(478600001)(54906003)(110136005)(91956017)(8676002)(36756003)(8936002)(5660300002)(71200400001)(31686004)(4326008)(316002)(41300700001)(6486002)(38100700002)(53546011)(921005)(122000001)(186003)(6512007)(38070700005)(6506007)(26005)(7416002)(86362001)(31696002)(2616005)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emZkTld6REFEalhyNDJxOVF2N2NTZFRFRjkrTGZzWUoyUG5pK3IxNWRpTmNB?=
 =?utf-8?B?dXpLQ3BNNWJPeFVPcVJWbGk0V3ViWitUY0hkclc5NmFiWFpBZU95WkdQbk9q?=
 =?utf-8?B?M3g0WVRPY2pRYkZsWHBWNTZFWG1pM3Z6TUE2T2dZYnJ6bTVKMG51Z0FPL2R4?=
 =?utf-8?B?ZXlIMkFudlpVOEU1U0FlM1VCRkFIQURDSWhyeXF2cnVQYTJLRjdJd3BPOXBz?=
 =?utf-8?B?cGY2YmFHcDRYY1Jud09uOFBlMnNGOFMyUU5kL0FpMm5jTUgvQnc0SXhCMWNi?=
 =?utf-8?B?Qkw1RDZGNGdWazRiSWtCS3ZCNzVpZFRQK0FNdytpdkFHMWovTHdra2hTSVMx?=
 =?utf-8?B?cVVrSGhpb2RXLytjZHNYcUNjVUt6d2UrU1RYTlVTR0FsdmQ1SWpZTG1rSDhC?=
 =?utf-8?B?SmNFYmtqZlhLTlA2c0FVV2kxS3A3LzQ0Q3Byazl2Y3MyWnJ0dmpLWXI3SHd6?=
 =?utf-8?B?cmdHR1BJdHlyU3BldmsxNzhHTkh0SDNBTnIxajU0RlFVSUFGVTdLZVRhT2sx?=
 =?utf-8?B?S3pPV2dPaE5OR2hFdm8xcURMeE5WMHQ4dVpqeSs5YzVnTHZRRDVodXpMWWt2?=
 =?utf-8?B?NW12a0hIYTU0WFhwdC9ZZlRQMEdZQ1V2WVNHNS9HNnFseVc5SVlHcmZyQXhO?=
 =?utf-8?B?U1J6bzlHY3pNSVdCeFNYOUF1UzMvYXlVaGxxeUREZEl4UEpBRVRwMlJsMGJC?=
 =?utf-8?B?K1Y5Zldud0xIZjV0eHIybWpSVnEwMXpEL2pVMnV1Z0tXcWlqRjZ3U1hNc21v?=
 =?utf-8?B?akRZRGNWQkVXOU1paWxTd3BHSmc4UFgwYWNjNVRlVVBxSnBVbUIxem45aEsw?=
 =?utf-8?B?M0p1RCtRRy9VZWNuV3BtZW12LzUwYzBsYlFzSHJxTTFhN0dtb2Jkb05OMmMr?=
 =?utf-8?B?NCtncHpyS1cxRFQxQzVGU3VHQ3AzVDhHY1lPMlRmZXhyMEdXOWNMR3lvU3JN?=
 =?utf-8?B?R2tkL1JFRXRNMUp5dVV0akJCVG5BcXhLdnRBSnJ6TTlYUllPMlV1M0NDanVB?=
 =?utf-8?B?MHhZS2FFYVFNSjZDbThpYmI3NVU3eEV2ZDdXejdmVnNGVVBYT0R1WU9yeXc4?=
 =?utf-8?B?a2U4WXFiWDgzeXNVcmJjdkpJb1JxQzVNUXF0MUJlSE8xWDJqWlVMWm9jOXNx?=
 =?utf-8?B?YU1aZXBNcEwybEhEdm9tR1BTTVExMEhiZkJsOHdtejZidDhFcXI4MzA3Z1E2?=
 =?utf-8?B?WEIzSG9SamVHZ2NrdE5MUVc5Vm0wNTBLRGk2NDlIOU1vZGg5T21xUTREamtQ?=
 =?utf-8?B?aWduOEJYYkh1NzM4OUk3RHl0ZWdsTVVabjFvNXFVN1F0MjVoZExsWkVjV3Fa?=
 =?utf-8?B?NXdQck5ITXFzZFZIU01XTzRnQ2VsditDUWpoODBzeFpCeHhiVU9qTkRBYlRS?=
 =?utf-8?B?NWo4QWFBQlhMNTMyOHNWNy9xQUJtd1FiZWxNSnVKenc1SmZuQThUV3EvYnFu?=
 =?utf-8?B?eDJ6R2pueDRZRmVlMUNGblNZcHNySmdjdlNBc3hjc1E0bTlIUjMwdjh0eDll?=
 =?utf-8?B?TTJHamM0bXNoM1Z5RTlEeDBLRU12NStmd1JtSTc2NjVISW5VKzZ0cDV2MHh6?=
 =?utf-8?B?Ym9PVGhFS3hPTzFWSUZUcTBiZ2VEeC9BY2MrOEZTV0s2ZE5hN2k4S3RxdXpi?=
 =?utf-8?B?QkJ0RGNDWVF3bURMZTVpVkdvQ29oMDdYN3FkK2R1Yk1xeUhyb3pGZ3NmMmV6?=
 =?utf-8?B?VU42YlViYk1oRmhLenhJbmJJUklhMVY3ZzZkMUVjaU1wQk80eUdSaTROQk5x?=
 =?utf-8?B?QXhYUWpXVjBBb2JmSHU0WTI3bzQ2UFRuYVkzVzBPNEVrWkFzWU44QmJKWXR6?=
 =?utf-8?B?RjRKWFJQZkhNRHQ0aWtDMEcwa1VMNUpEdDg5YXNER1lDQnhETnA5QnhwalVh?=
 =?utf-8?B?SGdYTTlZMXlsYVZuSkJwVVVud25OUU4wd0tuOG43N1l0bGp4R0hOK25wQWVE?=
 =?utf-8?B?TkZpY3VjcUhSWEVuUVpFYU5iNVoxN3lHV2FRbUZ2dG1MSVZGNERLYU15UlJ2?=
 =?utf-8?B?Z2UrMlZxRjZPUUMyYUdnTjlRd0hEUVVkR29BYTRrRlNoRGdNZkJZUE1rTlFX?=
 =?utf-8?B?K1BlTUhSbkNCbThsQVlOS1QvM2FJQXVKWVo2TDcyWTIzcHEwL0ZFVi84VXdG?=
 =?utf-8?B?V1VqK08xWkNJZHZWckVvNHlFZGZEVG1BY3ZsZ2JvTDdaa3g0cmNJNmFwUkN6?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57F73C85590FA34995B966558C3B0210@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0848d4-f1bc-41d6-9ff9-08db68e414c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 12:21:41.2867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5pSDwvEh57meLvL2iMUFwcPNFHBQDec7Ab5tPazGLWR81a7gFzoqPd6bd4lklcLjnGHxWax4NRMw1Uy6+TTh2MVJHrMF5/l0iNTiHD8j6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDYuMjAyMyAxNToxOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwOS8wNi8yMDIzIDE0OjA5LCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IGludGVycnVw
dHM/IFRoZXkgYXJlIHN0aWxsIHJlcXVpcmVkLCBzbyB3aHkgbm8gZGVzY3JpcHRpb24gaGVyZT8N
Cj4+Pj4NCj4+Pj4gSXQgd2FzIGhlcmUgaW4gdGhlIHByZXZpb3VzIHZlcnNpb25zIGJ1dCBDb25v
ciBzdWdnZXN0ZWQgdG8gcmVtb3ZlIGl0IGFzIGl0DQo+Pj4+IHdhcyBub3RoaW5nIHNwZWNpZmlj
IGFib3V0IHRoaXMgZGVzY3JpcHRpb24uIEZvciB0aGUgaWYtdGhlbiBicmFuY2ggSSBrZXB0DQo+
Pj4+IGl0IHRvIHNwZWNpZnkgdGhhdCB0aGUgaW50ZXJydXB0IGlzIHNoYXJlIHdpdGggb3RoZXIg
ZGV2aWNlcy4gSW4gdGhpcw0KPj4+PiBicmFuY2ggdGhlIGludGVycnVwdCBpcyBvbmx5IGZvciB0
aGUgdGltZXIgaXRzZWxmLiBXaXRoIHRoaXMsIHdvdWxkIHlvdQ0KPj4+PiBzdGlsbCBwcmVmZXIg
dG8gYWRkIGl0IGJhY2s/DQo+Pj4NCj4+PiBJIGp1c3QgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgaW50
ZXJydXB0cyBhcmUgaW4gb25lIGFybSBvZiB0aGUgaWY6IGFuZCBub3QNCj4+PiBpbiB0aGUgb3Ro
ZXIuDQo+Pj4NCj4+DQo+PiBBcyBwcmV2aW91c2x5IG1lbnRpb25lZCwgQ29ub3Igc3VnZ2VzdGVk
IHRvIGhhdmUgaXQgbGlrZSB0aGlzLg0KPj4NCj4gDQo+IG9rDQoNCldvdWxkIHlvdSBzdGlsbCBw
cmVmZXIgdG8gYWRkIGJhY2sgaW50ZXJydXB0IGRlc2NyaXB0aW9uIG9uIGJvdGggYnJhbmNoZXMN
Cm9mIGlmPw0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0K
