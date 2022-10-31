Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAEE613395
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJaK1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJaK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:27:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D6DDF79;
        Mon, 31 Oct 2022 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667212038; x=1698748038;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=EAiCCff/2HSrIIpgdziyFt0AyFEJzW6VitMkDtLoVu0=;
  b=GSd87OK/i+ujJk1ZFF7EHFbVisbjMBGezG9tnj2w2DFcLQnIsNRHHVoo
   OadTJhcSN/YPH5ox2eHS3vK8Sv1SWESjV3AFJWCENvVwpLkYgO2XX2+VI
   0WklfipXuT7QuxAZc2+QFPVIDSuJym23ZcAXKiFj3Qx0FdM94pLMCXw9q
   jF/84EzMRvtT5dggIkhUpz5lw8fzrEYIHYb+zYxDM95vPv1pm7E6CpsxJ
   AR77lA8q4SU3LQvzkZUEfjI9OEVXFo0Tdkf8LAekn1EkT12eBpKPt/1QX
   LuvnRTiD2El5PUjUPlA75TGg0Oambpbyj8LPeu+u8KCKkLHsbpCGFv3Uj
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="184616991"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2022 03:27:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 31 Oct 2022 03:27:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 31 Oct 2022 03:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FinFeLF3+/72gj+dv4iU2yOio/I8Hbv14mx+2lQow6TiCPVLELPKSY0a6f1V03VFFGDa6pg1B0UzHwuQ2sJdfI3cGzu/Je19ZTvUROMEY1wPq6GCakqMYW28tnY931bnEZlR0qOhQoyixf5uFY3nxiX3BU6j1p7hNETaloAUWuwRo71avZjtw9t01wW1DTRQN6Np3UImakPlOK25XKIzbMChD3QpMboV5ro8v/bVR5V1dP182yXiRc/ssNlk1Od0/kuOA4Xgyr7V2BqDtlGF4eZ2Q+ZNL/1nBseHCDtv/0J1kPMBRwcOwQ3bpAq/60SIkCji1ISRrYoXKw7i/OGflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAiCCff/2HSrIIpgdziyFt0AyFEJzW6VitMkDtLoVu0=;
 b=e8CoS6Oyd4+xIkPKJ6boU+c/05WqL0EHPJpSRfHjo233t1Fu9xn3zwTWZkATPpl7KwX1gYhH3CZwxZtIYIwWHplI2gJiEBrMeABBila0XtcsxOi4gcphU8yitk4O1s/svkxyUhZILuzmwRpmljtP82T1guXCva6acNBzacU0qo0+HIXn1VtNBEmJXm4/jzE/I/PalACkKSiBxDzSo/PmkiD/0pseNoT6XBwkZARr4P2gDWYxQlH4vlHmWvrfOQx5bY6Ako0FLpiugRXf0gGtvFGKiIKBBrxsCQBa1Ho9r7ODlcDun2qSaym8PtZwINhDNK3nl+wFLFVEf8KxlUSEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAiCCff/2HSrIIpgdziyFt0AyFEJzW6VitMkDtLoVu0=;
 b=J9Rv1JeK72BIE+4Hhs3L60XX5Jhh7TGjbl2SgBPWZSTk4/I9ocMDmW1t32pqTL5Pu6eG8vLwcXs4X/CdlxchkFMkW1iNvPSEJqWOYXM2OFk+57CJ8xZJxTMtdGkCVrp+mF0G0kVqqqLNiDGTr/EawUPbGGYivuOSuiVoPlHorRk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH0PR11MB5506.namprd11.prod.outlook.com (2603:10b6:610:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 10:27:15 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 10:27:15 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Manikandan.M@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCHv1 3/8] ARM: dts: at91: sam9x60: Add flexcom definitions
Thread-Topic: [PATCHv1 3/8] ARM: dts: at91: sam9x60: Add flexcom definitions
Thread-Index: AQHY7RNXLed/a3SkiUKcAhOclc49kw==
Date:   Mon, 31 Oct 2022 10:27:15 +0000
Message-ID: <e3876fd8-e5e0-d7af-252c-8bba5ec9e7e0@microchip.com>
References: <20221031033653.43269-1-durai.manickamkr@microchip.com>
 <20221031033653.43269-4-durai.manickamkr@microchip.com>
In-Reply-To: <20221031033653.43269-4-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CH0PR11MB5506:EE_
x-ms-office365-filtering-correlation-id: 0a1f1b86-1c35-41ae-be83-08dabb2a7af8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qeci3iqN6phRLiWHQdkxz7XQOh8LIbb0cAQEaIpsU8bKitqtMhEj5yDLLd8h2zPBhtjhbbFnD0e1yLTcezlDHJyxCOF1N6+Brom3YwOia0NZoDS48/M7aOEzgviYxFiT0WPt+bqS7/eBEWI8P6cWCaRuAyhetS/ayoB4DU+QzMYFvnHm1KswwequUiPQWdiZtaCZbkSCL+RcjWBor+bM2vr9a2pLxUS17punIPJXbkXgCyJvYQeBQEI6P9Kuona/nWiw2Yn8RqYmzdY8kmYNzWqkMkXClH427xHGBXWodND35TeQ+g12U1/CODMSt1Geqp11b7YZ+nB2IXN5IKJqvtOnrOwYzthKvmCq2IZVCzn5DBoMm+9figb5HvKbaIHYkmSM72XfExUPMspy27nw9jwvwi1pHlJtVhKTJg5I4eojxxqppTuD9evCnZNkGKG+gz7REldxC6uleqo+ZyWoaaEY+dOxc47KtboXFhINy/HnyyQfeNI2wn2sQgk1D0UJ3If3cBtQqrGbASLWpnqYrXZqKEbPVP1IWMoPPEKpoSVhbspsfaDbu9NQVx6mtYw5SGk3OUqrZO8vRpqdpWO3pHEpS01okBGNWAtyKluqDozWR9stOF5Z8yWKcocO6cEUjroelPaJJlmltCVwTrEZ2Lb7R57uR5UjXvX0owe3zeuCg8P4TmHIiLD5WufAiZIet4FqVM/1ZNO5KOHFlCy1GSlbcFKR83VVequZdejxtZFCKRUHVSKXJ+bFWqCOoXXNH28445f7JCqfIuI1+Dy2m07xiH6Es5innwj9dh/q5rEtjYxDzPvXC0U064PDOtQN3bLnmbKc3mY2uv1zMZXYuDzeVC7jhaBlC/jHVzsaXY4exGwsm3e5+MBMXHgJ4FCC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(921005)(38070700005)(31696002)(86362001)(36756003)(41300700001)(6512007)(26005)(53546011)(8676002)(6506007)(64756008)(2616005)(8936002)(5660300002)(66556008)(66476007)(66446008)(6486002)(186003)(966005)(71200400001)(478600001)(66946007)(6636002)(91956017)(76116006)(316002)(110136005)(122000001)(38100700002)(2906002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmx0UC9ydUVlbENYa0haWWx5dldKeXdydnVtYzQwUUUrbmxiUDBFTkozNTRk?=
 =?utf-8?B?eXV2OVFqQTk5enIxSUJtcXFLbnRmcUxIRlhTcGxWY0VTUitjVGpiS0Via1Ns?=
 =?utf-8?B?OHBibWh0Y2lRWW43NWJ5aFB0QnFLOEF3YTIySlArVzdLeUR0MW9xZFFEa3hR?=
 =?utf-8?B?cTAxN0JiYVlkR3RSK3BUQUd3RGZqRlRzb29DYXRkL0VNN2YydEY3WGl5d0Mw?=
 =?utf-8?B?ZFkzdFlENW5sRTEwZ3RSRzVIK2t3UVg0NFVVd2NyUEk0RjJEd1lDeS9LM01j?=
 =?utf-8?B?RzIydmtEVnUrZW52MHBPWHBOWDcvd21PRm04MFhpeE5tTmRoSjlQV3hIaDBa?=
 =?utf-8?B?Qk01OVkvSXpYemJoSjg2SjhQMU54UVpWaERNcDgzS1lsL0NCMTFyWnQ5NXZ5?=
 =?utf-8?B?Z2dLSFdiUndaRmlqRUY1ZGpVWG9NUjlEU1QwZlZaZ2NEYmRRT1lEczFCRzZy?=
 =?utf-8?B?dWFKUjdsZ2Nycis0SjB5eFk4bDdiTnQ0Vkl2a3lhZ05RODA3UXo4Z3R0U0VO?=
 =?utf-8?B?NjU5WTRKeG9uYnQyM0pma0h3THlXVVRadTJNaWRHOVp4Y1hTZzNpM3VZRWN2?=
 =?utf-8?B?UzdqWml3WEExMEZ2WWh6T3BvSEU3RDFFTUZ6UTV3Vk0rZnZqaGxmcWN1YzNZ?=
 =?utf-8?B?a2ZBb2NDVHlMU3N2TVJkcDZoRlA4Y21qcC9rTnowYVplcGNtcmhTcjREYXhx?=
 =?utf-8?B?eG1STE5qdVdydDBXRDdVMEIzdEtSSkxhdlQveUVvNHlYd2F2ZnNmOTU5TW5n?=
 =?utf-8?B?dGxjUSsvYjhvUTRaYzRFMUlmcEc2Z1JJS1NSS05JeU9vTjUwUnc5WjJ3Tkhu?=
 =?utf-8?B?bmhNVE1xTmFLRXJscElVV3k1YXBuK2UzYkFHb1FyYTZvYTVGUjZlbGhLWHhh?=
 =?utf-8?B?UnRuMmE4RWxha2hLY1ZCb3ZtN2ozT3NuUW1UYW4vWFZMZ0lKclorWkNUTktw?=
 =?utf-8?B?NmN0N3MrdGc1clNNMWhnQ3liQTFvd0RhN1kwRjgrU2ZzQkNjN2Rxb0Y1Wmxh?=
 =?utf-8?B?eTc5dGlYY0VYTm9uVGFmVTFoU1F1dTFaWXcwUUpPSDNYWGtHSGMrVkJ6ZXVz?=
 =?utf-8?B?Wk1iRVQvVWVqd1hmRllHVm5nK0VKSEhsekVMcFpIRVl5Y1ZoV2lEbXdoMHdX?=
 =?utf-8?B?OTMwcFRsbStFbHczNkErWkdObTBGNURWVW9BMGkzUlFrWGtBa0xLWVRUMTlN?=
 =?utf-8?B?SWFoQWUxeDdDRFN1Uzl1R2MrWm93ZW5sWVVSeFBMcUp4bnVBbEhUZGZpdVZI?=
 =?utf-8?B?eWloQlg5NlJ4blRRUmh4VUY1bXAxL3o0QzVvSkdNTW5RRmRpZC9Bd2xjWVNT?=
 =?utf-8?B?TndsZTNmVDgza2JNYjdWck1LYVMzR08xZVVKYkhadHA3SDNlQ2oyOUxsb1VK?=
 =?utf-8?B?VFQ1Z2xEZmdyTDVvbXdPQ21BeGZlalhDRE40dmpoNTR0L3lzaU8zRHl2dWVo?=
 =?utf-8?B?VTFDS3BNNzh5Zm1YR1pkSmJPeDFta1VqcWF1WlZsanR3a0VkQ01LQVlod1Uy?=
 =?utf-8?B?SWh3UHRLd3hUUndORVNPb0g2RjZCUm5sSlRhclpCSXRhaHpIRXZJRGNvSXN4?=
 =?utf-8?B?a0xTOVduN2diQVB5cEkwYWx1UDBxR0Y4UXlZb25UUlpZejRNRnNjS09IeG5Y?=
 =?utf-8?B?cnRpR1VXS2MyWGIyTHZDN3NBR3Q5RTl2Wm1tZElPRVhvY2JmL2RyUWxVUkdW?=
 =?utf-8?B?WU9ZdXJJdmJOYjgrYUowcXZNQXpQZkZHdGlPTUlsNnJoNE9kTWVKMGhXekhM?=
 =?utf-8?B?M0RSa0diVWQ3OUowTDJDYXpHazdxdXJicGFpRzhha2hOOWlxYkRia25sMVZB?=
 =?utf-8?B?bkROaEtzMkxIbXJ3Q0swNFgxRERMc25uSzJtZUVqZFdqb20xdUxoUy82VklO?=
 =?utf-8?B?TGZKcTFaQmtoN2x1Mks3NVpmdjN6UmU5Mk8vanJZajQrTjhOQ2FkU1FMSW5t?=
 =?utf-8?B?S1NBNjVHazgybmY1SElIcVRnK3hhMFdZamFydk9FZElIMmtmWHVwSnYrUkp1?=
 =?utf-8?B?N0lmOU9vaUV2MXV6dGIwTEJjb1F0NVhPTmRoZm9qSDRpclNXOGJiMjhrSCsr?=
 =?utf-8?B?cE11Ky9KdGV2MmpBeFZ6RnRkbHp2OE51YjV3T0VrWnI2eGdKa2M0dHlla2RS?=
 =?utf-8?B?YTVOdGFLUXkydGluN2kza1ZWamd6SDlpK09FeHRIdExHMDhHSjdmYURtTnFW?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55B70BF025D82447A007C10661C9C736@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1f1b86-1c35-41ae-be83-08dabb2a7af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 10:27:15.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrqR+OjTRR7QsGUOJ5m942xx85uOONk9w/hbxO5X5rGrTnEE0uQu0oASVJceBy9W7EhIwGRKt5+mkIQSr0YunuxHhDm9/9NZAsFChTGtZj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5506
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMTAuMjAyMiAwNTozNiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEFkZCB0aGUg
ZmxleGNvbSBkZWZpbml0aW9ucyB0byB0aGUgU29DIHNwZWNpZmMgRFRTSSBmaWxlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRHVyYWkgTWFuaWNrYW0gS1IgPGR1cmFpLm1hbmlja2Fta3JAbWljcm9j
aGlwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFyaSBQcmFzYXRoIDxIYXJpLlByYXNhdGhHRUBt
aWNyb2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FuZGFuIE0gPG1hbmlrYW5kYW4u
bUBtaWNyb2NoaXAuY29tPg0KDQpGb3IgYSBjbGVhbmVyIHZpZXcgeW91IGNhbiB1c2UgW10gdG8g
c3BlY2lmeSBlYWNoIG9uZXMgY29udHJpYnV0aW9uLiBTZWUNCmh0dHBzOi8vd3d3Lmtlcm5lbC5v
cmcvZG9jL2h0bWwvdjQuMTIvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbCNkZXZlbG9w
ZXItcy1jZXJ0aWZpY2F0ZS1vZi1vcmlnaW4tMS0xDQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290
L2R0cy9zYW05eDYwLmR0c2kgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zYW05eDYwLmR0c2kgYi9hcmNoL2Fy
bS9ib290L2R0cy9zYW05eDYwLmR0c2kNCj4gaW5kZXggZWYwN2QyODFhM2RiLi5mZDRmNWQ0M2Y3
YmIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaQ0KPiArKysg
Yi9hcmNoL2FybS9ib290L2R0cy9zYW05eDYwLmR0c2kNCj4gQEAgLTE3MCw2ICsxNzAsMTYgQEAg
Zmx4NDogZmxleGNvbUBmMDAwMDAwMCB7DQo+ICAJCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICAJ
CQkJcmFuZ2VzID0gPDB4MCAweGYwMDAwMDAwIDB4ODAwPjsNCj4gIAkJCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KPiArDQo+ICsJCQkJc3BpNDogc3BpQDQwMCB7DQo+ICsJCQkJCWNvbXBhdGlibGUg
PSAibWljcm9jaGlwLHNhbTl4NjAtc3BpIiwgImF0bWVsLGF0OTFybTkyMDAtc3BpIjsNCj4gKwkJ
CQkJcmVnID0gPDB4NDAwIDB4MjAwPjsNCj4gKwkJCQkJaW50ZXJydXB0cyA9IDwxMyBJUlFfVFlQ
RV9MRVZFTF9ISUdIIDc+Ow0KPiArCQkJCQljbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhF
UkFMIDEzPjsNCj4gKwkJCQkJY2xvY2stbmFtZXMgPSAic3BpX2NsayI7DQo+ICsJCQkJCWF0bWVs
LGZpZm8tc2l6ZSA9IDwxNj47DQo+ICsJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsJCQkJ
fTsNCj4gIAkJCX07DQo+ICANCj4gIAkJCWZseDU6IGZsZXhjb21AZjAwMDQwMDAgew0KPiBAQCAt
MTgwLDYgKzE5MCwyNiBAQCBmbHg1OiBmbGV4Y29tQGYwMDA0MDAwIHsNCj4gIAkJCQkjc2l6ZS1j
ZWxscyA9IDwxPjsNCj4gIAkJCQlyYW5nZXMgPSA8MHgwIDB4ZjAwMDQwMDAgMHg4MDA+Ow0KPiAg
CQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJCQl1YXJ0NTogc2VyaWFsQDIwMCB7
DQo+ICsJCQkJCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtdXNhcnQiLCAiYXRtZWws
YXQ5MXNhbTkyNjAtdXNhcnQiOw0KPiArCQkJCQlyZWcgPSA8MHgyMDAgMHgyMDA+Ow0KPiArCQkJ
CQlpbnRlcnJ1cHRzID0gPDE0IElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+ICsJCQkJCWRtYXMg
PSA8JmRtYTANCj4gKwkJCQkJCShBVDkxX1hETUFDX0RUX01FTV9JRigwKSB8DQo+ICsJCQkJCQkg
QVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPiArCQkJCQkJIEFUOTFfWERNQUNfRFRfUEVSSUQo
MTApKT4sDQo+ICsJCQkJCQk8JmRtYTANCj4gKwkJCQkJCShBVDkxX1hETUFDX0RUX01FTV9JRigw
KSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPiArCQkJCQkJIEFUOTFf
WERNQUNfRFRfUEVSSUQoMTEpKT47DQo+ICsJCQkJCWRtYS1uYW1lcyA9ICJ0eCIsICJyeCI7DQo+
ICsJCQkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgMTQ+Ow0KPiArCQkJCQlj
bG9jay1uYW1lcyA9ICJ1c2FydCI7DQo+ICsJCQkJCWF0bWVsLHVzZS1kbWEtcng7DQo+ICsJCQkJ
CWF0bWVsLHVzZS1kbWEtdHg7DQo+ICsJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsJCQkJ
fTsNCj4gIAkJCX07DQo+ICANCj4gIAkJCWRtYTA6IGRtYS1jb250cm9sbGVyQGYwMDA4MDAwIHsN
Cj4gQEAgLTM5MCw2ICs0MjAsMTUgQEAgZmx4NjogZmxleGNvbUBmODAxMDAwMCB7DQo+ICAJCQkJ
I3NpemUtY2VsbHMgPSA8MT47DQo+ICAJCQkJcmFuZ2VzID0gPDB4MCAweGY4MDEwMDAwIDB4ODAw
PjsNCj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArDQo+ICsJCQkJaTJjNjogaTJjQDYw
MCB7DQo+ICsJCQkJCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtaTJjIjsNCj4gKwkJ
CQkJcmVnID0gPDB4NjAwIDB4MjAwPjsNCj4gKwkJCQkJaW50ZXJydXB0cyA9IDw5IElSUV9UWVBF
X0xFVkVMX0hJR0ggNz47DQo+ICsJCQkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVS
QUwgOT47DQo+ICsJCQkJCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+ICsJCQkJCXN0YXR1cyA9
ICJkaXNhYmxlZCI7DQo+ICsJCQkJfTsNCj4gIAkJCX07DQo+ICANCj4gIAkJCWZseDc6IGZsZXhj
b21AZjgwMTQwMDAgew0KPiBAQCAtNDE2LDEwICs0NTUsMTkgQEAgZmx4MDogZmxleGNvbUBmODAx
YzAwMCB7DQo+ICAJCQkJY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLWZsZXhjb20iOw0KPiAg
CQkJCXJlZyA9IDwweGY4MDFjMDAwIDB4MjAwPjsNCj4gIAkJCQljbG9ja3MgPSA8JnBtYyBQTUNf
VFlQRV9QRVJJUEhFUkFMIDU+Ow0KPiAtCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAtCQkJ
CSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJCXJhbmdlcyA9IDwweDAgMHhmODAxYzAwMCAweDgw
MD47DQo+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKw0KPiArCQkJCWkyYzA6IGkyY0A2
MDAgew0KPiArCQkJCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLWkyYyI7DQo+ICsJ
CQkJCXJlZyA9IDwweDYwMCAweDIwMD47DQo+ICsJCQkJCWludGVycnVwdHMgPSA8NSBJUlFfVFlQ
RV9MRVZFTF9ISUdIIDc+Ow0KPiArCQkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJCQkJ
I3NpemUtY2VsbHMgPSA8MD47DQo+ICsJCQkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQ
SEVSQUwgNT47DQo+ICsJCQkJCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+ICsJCQkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ICsJCQkJfTsNCj4gIAkJCX07DQo+ICANCj4gIAkJCWZseDE6IGZs
ZXhjb21AZjgwMjAwMDAgew0KDQo=
