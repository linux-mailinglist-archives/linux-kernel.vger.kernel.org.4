Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304A66B9858
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCNOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCNOxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:53:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3162FCFE;
        Tue, 14 Mar 2023 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678805580; x=1710341580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ksLcaVD+ZVbIRf58Xl92905c5dgdJpL6M3la/uaLvzw=;
  b=eTrpBmfRG7tL/FYyw9b2hxyFtE0mkBz3juTwqSrdES9nJ0AZbP9H2Hrr
   D8QlzwKBJNcZfvXB3IFeBlIGeva2In3nGcA2iTm46hzNS9est7MFclYFo
   3DjBHBC+vzLM1KhMqNrAyF3upu65ympPjov28m3kfI2SpZAZ+8MvuPt3C
   60gzbxBOf6qTOvZep62tk022SI7tHGTwEmTQYVAcawsr3FfCkVqr61EDk
   GuQ9/u8NSsDF5f4HRxs+3yF47FD+BV76qWmNe5vHacqR3my5fufG20XxH
   KB16YY4j4GpPibYlGaiPyvR9V6XSaF67M/dOt5yOF4magpceEt7h9EP8T
   w==;
X-IronPort-AV: E=Sophos;i="5.98,260,1673938800"; 
   d="scan'208";a="205330665"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Mar 2023 07:52:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 07:52:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 14 Mar 2023 07:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtoYtR8TF49wubD3wtB33TGxDkFGeFnqx1i+4Pq31i14SNbQ3K4+xifIXEacZOn1QQ/GXAtiI+GEQFk9d5DcnJdz8dCz1PePtzoWhDl/hGNrBlehNw2dVg8fiGF5h3R7OERelTnb6K2t+StM3Ir6mzIL2qjAVy+pJ6QmePojXoFYBbbKOP5BiT+EAKBrcCufwMCtllHEtbt0o+H5f1wXgyBkQcHKIW1TQnH3BaAZa7kbw8BzAgSPiCA92D60dHIjuKEErtpe8woljz+yB7GY0c03I+TCkjoVkC+1YIEs+HM2fANDmNGz29aYWNBzMui6at/1giUFXi/qsdnFpMYz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksLcaVD+ZVbIRf58Xl92905c5dgdJpL6M3la/uaLvzw=;
 b=DG8d5Wh1jqzwJGmDrzssK0BdSZD7/Z5Jwxxqe/NBZa8hqu9vLFpQslUQt0B3s2DtQ6LrqGeDaqfMpUU5mBFJc9flGZBKzXdysFFr/ar454IDzsGat9sWD0KZMqFRSTHuXQLrgSZKlmJJhjWTMH8Ob5wp9RYphMx7M/oxPZoqXiCiRCsLGi+0FiE7j0PW6Ck4/SkXbkGCyX3L3pIyPvmkiKWdNYm6JqobCW0/swlfVJO5BiuKCHvnISMq4432WjJRqd0fLZIFmeZNcViKMpm2xo1jwh/hBIexPBzdymINDcPHhT1+GMC5eLRjTBjN99aciCQUYi8G+rKdTTSFLVOPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksLcaVD+ZVbIRf58Xl92905c5dgdJpL6M3la/uaLvzw=;
 b=J+FF6/5v5KdOpyUxht2Fn82i0AjmdZOiGT9GGkBN03hhKckSaF5DQ+sbNBvqHoRKmyOz4/7iZPpYaDakieG16zGYeMU/BP9djICrFKnv1hqCMytYRlDuZ+KWdRBnno+3UHX1H+n2nptd8Goy9YEaxJGepdHgPcSWkzwM8nQG0hU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB5770.namprd11.prod.outlook.com (2603:10b6:a03:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 14:52:44 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 14:52:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: microchip: Use of_property_read_bool() for boolean
 properties
Thread-Topic: [PATCH] clk: microchip: Use of_property_read_bool() for boolean
 properties
Thread-Index: AQHZVoSiqeBx9m+qbkSy2LCn2je2yw==
Date:   Tue, 14 Mar 2023 14:52:43 +0000
Message-ID: <e8bb4890-679c-4820-2620-680cdcafc848@microchip.com>
References: <20230310144701.1541573-1-robh@kernel.org>
In-Reply-To: <20230310144701.1541573-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SJ0PR11MB5770:EE_
x-ms-office365-filtering-correlation-id: 535d865b-e67f-4470-4e6c-08db249bc486
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5CkFqrj7DF8w7b4BtDgC8k9eODC4S+9CtXAM3MmTKyktSDvoXBBVnna8pf0oaH2nQfcgH5kUN4Yl05a1fLx1zp3OjVRqGXipXNeCCp8tLO/SuV2JoZ3uF53TBr5Jg3OlXdUkmB08m+CAXdkvuZ9w/bPlve80vsmnWsG25JFshkzUmSN1eJhZQ62yC9GTGAG7CSaxBkHExzj4Bq4S+JMNvcZ92q6FRc9fr5auyb1v55KZ2ejAfZ0Y2cZ0h6Wu7N4w5z/3CqO7OyZ9rVwifoTISRQbjevhyTFqMt9+FebPCeWnk/6MIL7r2WqFmwCPg+kjcFlKSp+xWPdbeDz1J9YPZ6dvL8wEDdqD+jrIwAocXKP0+5rZDqY8j3OIAJEJKX67Zw4sjYVD0O9S8f5Tv2nYPCKAwM3oJjmloeRh1mJswS8FINIbMAa6VFdAWkW185opbDfzsr7I9XDhEpIApfI/oUBGezx7HSdykn+MBoNyWLLIT2gh7b8YknKOFzTQ1Dah+3KnxnkQQGz0jK/boqvsKKhNhE03912GRXxEOXgDyqUZ/mTHCiXePCwC2Q8WYZrrUOefdfF5LBM0LqwJIbyPnVChGfHn3fVOUsffyem08gE0JvBhTO/4u2gbiFyg8hiNrTx2PqbkumCYDCZel9OZGPSLSwCvFNnaD5TbOqUnzzmDGBbrNoruEMmvB63bEwJOKX2L5YLQDLJa8GAQSWPp1+8KUtgE5/bS8m5ScRziJ8MA8A+UfW36PpuYSR8OUrHs6dfGUQhC2Oeh+ezt5dspw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199018)(6486002)(2906002)(31686004)(83380400001)(4744005)(5660300002)(53546011)(26005)(66446008)(6506007)(76116006)(8936002)(186003)(4326008)(86362001)(41300700001)(64756008)(91956017)(2616005)(38070700005)(6512007)(36756003)(31696002)(8676002)(66946007)(66476007)(66556008)(478600001)(122000001)(71200400001)(110136005)(38100700002)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2M1TEFOUk02UUhsTWN6anV0SVlUTVJGQnJlTXVXNllPUjFnbjBJenNWbkJi?=
 =?utf-8?B?dW5OeUs1L25yRGhWQWJlMUpWeTVyRy9SNWd5aTlVN3dQdkNQVzU5V1lFY3hW?=
 =?utf-8?B?cUV3Q09COTRUL3JYS1BzVHpvOTRMZ0ZGMVNldnpUS3dGZm54aHZHbTlWY1VC?=
 =?utf-8?B?eFhmcFRycmpOTVNjOEFwQzVZc3NrVkFWT29kSjhpMkJVWmROMVZPaHBkenFW?=
 =?utf-8?B?RTZoOGQyanFkSE04bWtQalFNdjhBMXdtNzEwbnBZUWgvb2hmRS9DWTZXTjgx?=
 =?utf-8?B?cVZ0K0NnelVtSVVtRCtsajRsQlVsbTRoaWhRL2U3VTg2REhyZ0Mrdko0akxz?=
 =?utf-8?B?OXVZcEwxUnJmMnNnQ01sQlVTdEtGUExBOG41c1pQOUN2cmgrOUorUFJZdDFu?=
 =?utf-8?B?bk9YazZnSHhYcTRQQkxObXN1Vk9lNS8xbndlUkd1eVRaS1BrRG8zSGdpQk9V?=
 =?utf-8?B?enFoMHdNUXJiRE9OdmlONUFNa2xFdStaWUlraDQzSkhXRUJnS1hNWmkyaW1B?=
 =?utf-8?B?M0FXbkU3K0V1SW0wWXZ0QWNDS3NVb1c2OWN5YktKeUMvSzNjYTV1NGk1L0N4?=
 =?utf-8?B?NWtzV1RSQmVrOVBieGhOWDF5RTZjRTZpZFRYUDVnV0JILzQ3b3dwQzFhdFd5?=
 =?utf-8?B?RVBhaVFYTm1wdlBmanRjL2tLMWpJMjBpU0JENnFWNmtyVml0NTFJUlZYb2tF?=
 =?utf-8?B?NXZhR2xOWk5pQ2ROekR0cGJMdHhUSVp5d3lCVnV4ei9sbGJaZnl3Z2gwTWF4?=
 =?utf-8?B?bVJ0WDVvbVNrM2xOL2EvYVZtd25rY0JjMHZWSjRJcXZhNU5ndGJoSGcrblFN?=
 =?utf-8?B?bVpMU29DM0VFS2V2WUpsS3RFSVR4YUs4Qll6dWpXcWJCc041RVJlY1ZNbERx?=
 =?utf-8?B?alBzb3hBZXU3Y1IwZlc5UFhnZ2N2TU9OaThvV1hFUEcxUUNiamVyUTNHcW9J?=
 =?utf-8?B?MzlObDROQ1ZEeTQwbm5LNjNNSVFMK1k5VlM3ZitkeWJIV3pRYTA5aGFpZ0Ju?=
 =?utf-8?B?SUFUREMyMmJTdEliazIrVlFhU3c4UXY5U1hjNzlVR0MzY1pVWU9NazJUWEZG?=
 =?utf-8?B?WHArckxJWWRCa2pJQVRPOHFCc0dGUXVkMlVaUytEZlFxZ29VSTJ6QjdSc3BW?=
 =?utf-8?B?WjRWdGVteUtCTW5PWE9rZ2praXV0YUREL2FOMFhib0RFZGg0MCs2aGs5MWdh?=
 =?utf-8?B?ZzRSLzVKYkZpZ2d6b2diR2RoT3JnWDYrQlczeE83S09KZDdZUmJpYlRUaitH?=
 =?utf-8?B?QUpCNWgzRnp2QU9EMEgwbUhOUFNZWUZZdnlzY2wzaEtPQTMvSnAyR1NJcmUw?=
 =?utf-8?B?SHdWdTdEZWR6RDdVUmZzdjJ3dXFVSllpVHVleWFZMmRrclJvR21FcG1OblBo?=
 =?utf-8?B?NGxFdW11VWNiTUpQeitUM29uVWZtVzJjNlJTMldaRjQ4akZPeUx4QmplU2VP?=
 =?utf-8?B?TEFBOWluV2t5MGtCelNBbUc3amtzcTdsT1NVUFFkeVFQR29HVkd5dlZUclVp?=
 =?utf-8?B?ZXJ4V3JLZXI5SzExazh3QTRicUE1NUwxbG9IY1ljaXN2VFZrSW40Y0M2OXVp?=
 =?utf-8?B?TXBaMWN6ZTNpM2wzR25XK1BoSjVaM25MMXVQRi95ZTFXaFJ0L1NGT1NWNkdp?=
 =?utf-8?B?eGhmVmpCNU81MCtyNTk5U3M2RFpVMnRqMzNtc0g4VG0yQ3FMWUNzQnlqL3hJ?=
 =?utf-8?B?b0VVUTg5MTJGaGt2VmVhSS9HR1p5ajBvVlJZamRqaExHQ002aUNjTS9ieDBQ?=
 =?utf-8?B?RkJrcVpBT21IZTZPT1V1NUErL08vY2ZzcC9iRjViU0tBUXgvQzg0cVRYRDN1?=
 =?utf-8?B?bWFubWNsN3drNm1UajdHd2V2Yi90TEc0dFgyb1p4dzhkNVQzOVlpQlZxUm5x?=
 =?utf-8?B?dnVjREZWcm5KaXBiT2ZsbzJPcXNtMk5lYzUvbFp5ZGZQdkYzWi9UV082bFZt?=
 =?utf-8?B?a0ZUa3psNk55QzlFYkg4UjJVczRMUi9tUEVDNGZNWmQ3ekM4N3lJaDV4N0Y1?=
 =?utf-8?B?d3EyREJVcTIxOHBsallkbW8rUTlPWkRFbnZjRXpab1M3dGRTZ2l4RnkvOGt4?=
 =?utf-8?B?OEZ6Vk1OdEIrYnN2aUwvckhpNi9kOVY2ai9FUkZTZVh0NGtLdnpSYVduK1lm?=
 =?utf-8?B?eWVEdzcxS1ZTdUM2azN1VjZEVlJENEJNWm1ZSldnb2lPZVRURjQ5VCtTanli?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CC457820E4B1F46B45136AB65E8F886@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535d865b-e67f-4470-4e6c-08db249bc486
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 14:52:43.8255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQmtQ+ata5b9t6ct4WVhuEND/7AJJ3Svbjypdpac6NTan+9uYlOsrtJohqVobyUKW3ZWcqWa7XJQnFuWDmDCo/jfCziNYCWB6c+l55YU1YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDMuMjAyMyAxNjo0NywgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSXQgaXMgcHJlZmVycmVkIHRvIHVzZSB0eXBlZCBw
cm9wZXJ0eSBhY2Nlc3MgZnVuY3Rpb25zIChpLmUuDQo+IG9mX3Byb3BlcnR5X3JlYWRfPHR5cGU+
IGZ1bmN0aW9ucykgcmF0aGVyIHRoYW4gbG93LWxldmVsDQo+IG9mX2dldF9wcm9wZXJ0eS9vZl9m
aW5kX3Byb3BlcnR5IGZ1bmN0aW9ucyBmb3IgcmVhZGluZyBwcm9wZXJ0aWVzLg0KPiBDb252ZXJ0
IHJlYWRpbmcgYm9vbGVhbiBwcm9wZXJ0aWVzIHRvIHRvIG9mX3Byb3BlcnR5X3JlYWRfYm9vbCgp
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCg0K
QXBwbGllZCB0byBhdDkxL2Nsay1taWNyb2NoaXAsIHRoYW5rcyENCg0K
