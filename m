Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B95B6ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiIMJfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiIMJfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:35:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC15717ABF;
        Tue, 13 Sep 2022 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663061733; x=1694597733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6ubq+Nbr3qtwMAhkoqmZ0wYKd6J3dRuuusxNhyhXPNs=;
  b=Hliegv7cy3qomQoJglFbtNr8W+odDsuAkJ/3QvL4HOJW50VtmUuQuK46
   CDdPetGUUoWJo952Ou4mjoPSwZuPBFwIRk456dKnAbVwTwVjM7Chfkzah
   oYws+2KdwdnVxeKs7dzBFw4GDl8OTyJNlxz/OX0+KfKCsukqrolNWBB+e
   G/yit1H5jNUKy5FunRO+R1UZK5UwsjgrPf8PlK1RS5qt40/v8HoJxfWO9
   qmqMc5z/BJZPkT8X9lJR80s3e5I2ASsdaZ/W2bISSVC8P6yIcRS7lz4sT
   vVVyKTGC4mI7zR5UjjFX4e0hJSmKcp8finx5duYHyKdMgmdzrmUk59YX4
   A==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="180264256"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 02:35:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 02:35:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 13 Sep 2022 02:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeOozOhZnhvOBER+ghRl1juh+0VbuE6Y0pB3l6HxABmi3XYMx2yyp+6tIzRhm9gcedUZ3JUvLBRwimUx+0qYqsjyBYnlHpcfrDcFO6aFOl3JzydPZ69vc2pzdyOGgY2bR7ofPtZjDv95bnonU9e/eoQiPOEX/Ej3V4PkCpoV9QKa/e2u3xjeZGh2lbsRJC0E4GycuLM7l8a11/Tnfvo7O59bmV8OPlectwDbq7iHbgPv29caF6ETlsCRs07J/qJN07V75pdSeGpoO6orI8RJLlCjzIS0W5U2kwKegvR+e6Fzdt74/ocKZ4IE6aHBzMonJTFtb1u1FCTW68oC6QF/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ubq+Nbr3qtwMAhkoqmZ0wYKd6J3dRuuusxNhyhXPNs=;
 b=oFkLI/ZPstwHgMcwBTADXmiPmBQi6LSt98guT8K3XUfGPL5js/tRfqOqh7G6kVOOuBc8hljXsVJoilqxGaiX9F5Z+g9BnOWBbtQ1myXu3X7rdL5NJrIRVNZlgs7gU8Z4CLoKSMD98SCSK8qMoqSlFP4e6LswJNm0hEyO5EetbCt6NSMR8wpCUtjjpOjMAK1i9G3pGSM1FpsfZ8GqTCcoazRSiaxH9+lEsK8HhQjBleULzEW26Q1BuITM7AOcAyk0r71de0+FUroR4x65i0WfULBPk5nbz15Fwj2sbb4MbJL346UfSi4NkfIskFXhJvA8dh7ZKTCKcvYAEL7pJT00LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ubq+Nbr3qtwMAhkoqmZ0wYKd6J3dRuuusxNhyhXPNs=;
 b=co14MTtj6IthUW0QrGPnpAJ/XrDNovj4nKoOC8uUtudT47XjM1rDKrYQj90WgGXUTpdtiEhyOurSTZT/XztnoOZBnbG4zNnh6/NhhA+wSlZB0X+SxSNbS0O6bwT27kUL2C7/CqF65/AVLJn5V1GszSQDbqTvVUKsCCIHGDK3rrk=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by MW4PR11MB5871.namprd11.prod.outlook.com (2603:10b6:303:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 09:35:28 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::e8ff:82ac:b76d:c61c]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::e8ff:82ac:b76d:c61c%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:35:28 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>
CC:     <lee@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <richard.genoud@gmail.com>,
        <radu_nicolae.pirea@upb.ro>, <gregkh@linuxfoundation.org>,
        <broonie@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Thread-Topic: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Thread-Index: AQHYwfjCQbG755VmlEGUqK2TrhMH7a3VeaSAgAAuKICAAK1+AIAFHfCAgAAyC4CAACijAIABTCEAgAAF4YCAAAMZAIAAAVuA
Date:   Tue, 13 Sep 2022 09:35:27 +0000
Message-ID: <bf1d7b3e-c542-fbe1-d904-e11f1d1d5ec2@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-7-sergiu.moga@microchip.com>
 <9aa29d74-b1fc-d00e-dee4-57f277a366ab@linaro.org>
 <c30cc112-0fb8-01e6-1bb8-eed7db0b9049@microchip.com>
 <20220909013644.GA3731620-robh@kernel.org>
 <b6b044f6-de87-e85b-0b51-e957b90622ab@microchip.com>
 <aa6d8c7d-1723-7674-2142-a5aafe30e570@linaro.org>
 <77d38e3f-6d8c-dbb1-2e66-c768d95b5e35@microchip.com>
 <5f8ca612-5a89-db3a-42f3-a0613c192a87@linaro.org>
 <888b8ab9-f8cb-2e1f-465c-3cb97187fce0@microchip.com>
 <f9e03913-b3dd-c82e-8c63-d912c0bbf443@linaro.org>
In-Reply-To: <f9e03913-b3dd-c82e-8c63-d912c0bbf443@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|MW4PR11MB5871:EE_
x-ms-office365-filtering-correlation-id: 3d3e9886-25aa-4525-7421-08da956b4b10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8iNt661UGAwEpBAqTSxAAHjUdwwgDKIkz95a4wYNcKSLXK5/X8KOXDDLi5mF9Ke0iFlnMs37CrQ9WZseKqPhuYqCTjOJgBut4urrVZCinwosJLXHDEsOsnjze2SaDxQ7oHml31T83/IONNRiqLt3ZAIuC6kJpOB/esS2AXKhG5dBnFXOHhvasghVASbpyRqg3uJLutN8nPNZ1yXlTuLTTiCOZAbHezRm4XSpipjGcII7SpfH5at7kMJbVvpUgNbtYdbIrExKFjel4QDTwDch4b4/As2OxFVh17KRVkgCW/LxkF+qJBEXfmurTLw+wAaWWV8BeOi901xaPlgDup41ZdE+pyLWGMUG6awBwSO3Nw8HjBdlcIlsYbR0Yn9BVDBAXipsnwJ8DSVD4tI+tm19dW2nc3v5dOSMIEgI9K2bpVpwbiPR8V8BkFzJr8aQNXzr3aNV3Ja73zBgFppAhXJoDnl/J4Noe0+OImLgq9L99aH2U4heEwKqDlosYwfhBq9+5NCX568WbuDRWJOWcu9AjrYkplDXWGMK8zVWWWfJIZWXq735ky2pMYrIu+qyDh8nWZBb+S+BSf8Npl7HaSBPFKrqugFAMcdRH4DamDr/nDG8gXKMOX+A3uRNbm7/pLxvh8Id0CalZUDjN1sf3bEBTijJjyhtQf44BmVt7rrsZ2E/tZswRx5zkugdJRgfETtfZwU2AznKPWazt9S9eeEi+WnJcveSpUrwHxgCTapbZnUtZlyvNTuiY0RtPtiXVpsyEFUiDIaoITa48YjPFA2qwCfmvBOHO5U+DR97BjX5i14=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(4326008)(31686004)(71200400001)(122000001)(478600001)(6486002)(38100700002)(8936002)(5660300002)(6512007)(66476007)(186003)(66946007)(64756008)(26005)(66556008)(2616005)(110136005)(6506007)(7416002)(76116006)(38070700005)(53546011)(41300700001)(86362001)(31696002)(83380400001)(36756003)(8676002)(66446008)(91956017)(54906003)(2906002)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnhZVnlZRk5UeUZDSm1JTmxXRFZsUEtkNnR1Z3pnSm16QnJocE9sVFF6VndU?=
 =?utf-8?B?QTlDWlE2Mlk4ZXR6bFlzMW96V2JKd1ByY2tFWld0K29iQ3pNSElSTlJpbG9r?=
 =?utf-8?B?U1JFblBhSFpKVXQ5cTc5S3l2bC8zelZldzhsaWpTSXRabDlOcGorWkVndU9H?=
 =?utf-8?B?Y3BxNk9TZ0NzMEVxZDlnejROaUNqczNiTXlEa29CRDR5NmpyN2x0aTUva3Ey?=
 =?utf-8?B?RFQxTk9QQlNEN0NuOWRUOE5QQlVVZG1pN2IycVBDRkZMcjhYNTFhVEJ2RjdJ?=
 =?utf-8?B?MWJ3WXR3L2l4ZHNPZE0zVWNEb1BTQlpVa3FCaXRFYmlST2NBM0xzVXd4Z0Ni?=
 =?utf-8?B?MHRGVEJWaG5rdU1NbVRvK0NEYnlhczgvMVltdFlIVTA5U0M1bnFEWDY3amRH?=
 =?utf-8?B?ZUFzRUl5b0NMS3Btams1Q29vazJnR0hadkVOQzZUZmxibWM5Mm5sdjhRaVdz?=
 =?utf-8?B?YzBMY3Q4eXl3cFpwNGpUd3lOcWVsWjl3Rlc3SHk5cUMwVzNGSXpDN3JXWlRy?=
 =?utf-8?B?OFozTUJWMVZSSkhXT3dLa2szR3kzcXpQTk9EY2c0TXhHaXE3VmE5aFkvSnJJ?=
 =?utf-8?B?bThUeFZ0VGh5Nm9rbDkzekx2cFQraDBvZ05lOUZYUjh2S1dhSUtVSGJoZ0xp?=
 =?utf-8?B?ZElkUVNDK3RXVnpWeXRSZEZzaGwrNStnVnBDRnd4OGU4c0RFS0NWQjV0K244?=
 =?utf-8?B?eTR1ZzNEUnN3Q2VzdlZUcGE0Zm1WZU5NRWdqaG1WSGttQldrdFpJRDFFWDd1?=
 =?utf-8?B?WXlJNHVtdjZqR29vQVF5cWJnOHlaVHR0Rmg4S2lHMG1vYjVTWmJZR2VwL1pT?=
 =?utf-8?B?cXlDd2ppTFNINEszeG1ZSWN6RzllVWwyYjFtQ0V3anhtK3dUZXFyTUFPQnR5?=
 =?utf-8?B?anZjcGZoNW1LY09pbFRBVVh2UXdOSnF1WFhwYm01MjBEVGpQcG1rK1B5OC8z?=
 =?utf-8?B?Njg3QU1iUUJMNlVyZEFSUmNITkpKQ0k0WTV6NnZEaGFac2U3d0pHeE94UHQv?=
 =?utf-8?B?MThFWmhJVkZsZ2ZXdXlPL2hNaHVzbVREWE9NTE1Fa3F0ZTVzS25ZaE5keFhW?=
 =?utf-8?B?ZmFRM0U4ZHRaQWhjUjZmejd6eWZ1Wm52eGpLb09KKy96SXdNRUgzZkFaNnJq?=
 =?utf-8?B?Q2F3RzZXWnVVODVJZjVkTmRWWE9oNGk2TkV5YkVBVTRDTVlkSXhDUHFPTldu?=
 =?utf-8?B?OXFsSjUyZjhJMm4ycWdZNkJjOENOc3VYZmsrdE9qUGJZVktvb3RoOTZYcWhT?=
 =?utf-8?B?SGRoY21POU1Va0lJNS9DTktDRDdoV3hzSzZBNW5CbG9iYzZ4UnhXaGVQWENF?=
 =?utf-8?B?blNVZnQzSHFJdkZEcHVNamRJSC82Q1FTUHVjQ21Ed2tmM0Y2dkhyMHB2dlpW?=
 =?utf-8?B?aFdBRFJucGhURTB6U2c1dUh3d3JFVE16TUYrOWlZUllUMVlhcFNoQThzTXdD?=
 =?utf-8?B?Mm91Nk1xdStzd1kxVjVWVTlNZEF0a05QWkNBU1k1Q1lnNkJCL3FaOWRXWDNm?=
 =?utf-8?B?VVdhdWw3Y1hxUTRXMTB1WFVSVTFRVFNrNVJxSURtQlpVdytmY05oVU5YbXdR?=
 =?utf-8?B?c0FBVGduU0dUcXVNbWlNZW9tbFZ3ZVhOUzFOK05TOTI1T2dxVHB3RmgvOEpo?=
 =?utf-8?B?SDY2clZKaEs3dFc1RHhtUm9kbnE5cEJnZFFtQldJSUJpcDdUYUc5TTZ0QVZD?=
 =?utf-8?B?cEhPV1htMFkvdzVjcFNoNlRDQ3lEN3JBbWRMdFdUUmhEc2NOT2VKTGhqYzJk?=
 =?utf-8?B?aFBYZmkxZ21XZnpWcHhJWERLOUlyMWVILzRiVmgxc3hTcXpDMG5QbmNPZmtH?=
 =?utf-8?B?Umt4RlVrdTlESThEbXIyVE9hMUVnQlBIY1poTDZKTlFiZVk0eXFid29ZSGpp?=
 =?utf-8?B?V1N6UHViNlpNMUI0MCtpTnZlMjlUckJxMDNhZWRkMHpmNnRlZ0ROdHdWRm5p?=
 =?utf-8?B?VDZWanVJdnY5S3l6eld3N3Azb01ocTRQNWNDbUtQbVpGeU5CcHVLN211b0tu?=
 =?utf-8?B?aHVhbUJyMjFnMi8wdi9PWEFxSjJ1MFl0OERlT3NrK0d5Y1d0SFJvV1BFWWhT?=
 =?utf-8?B?dVlZaDJISDI5VmpBR0tKVVJPU3BGK2JhNi9kbmJqWUJndUo4MHF6L1FlbHNi?=
 =?utf-8?Q?UZ2L8/hpEazmkjeXYyJkRupeA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E0DE51AB51E024085C466D33B77780C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3e9886-25aa-4525-7421-08da956b4b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 09:35:27.9286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxWwZPGVbyjZvGG2sh8UahuhUnv8xxQJah/j067zbTkcPngBs59lQEjCIa1XhzTSnTEp7sPK1qS5eqOGsQxQ8qnEQVSAOFNAiO39nMOLsDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5871
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDkuMjAyMiAxMjozMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTMv
MDkvMjAyMiAxMToxOSwgU2VyZ2l1Lk1vZ2FAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pg0KPj4+
IExldCBtZSByZXBocmFzZSBpdDoNCj4+Pg0KPj4+IFdoYXQgeW91ciBjb21taXQgaXMgZG9pbmcg
aXMgcmVxdWlyaW5nIGFkZGl0aW9uYWwgZmFsbGJhY2sgY29tcGF0aWJsZXMuDQo+Pj4gVGhlcmVm
b3JlIHRoZSBjb21taXQgbXNnIHNob3VsZCBhbnN3ZXIgLSB3aHkgZG8geW91IHJlcXVpcmUgYWRk
aXRpb25hbA0KPj4+IGZhbGxiYWNrIGNvbXBhdGlibGVzPw0KPj4+DQo+Pg0KPj4NCj4+IFRoZSBh
ZGRpdGlvbmFsIGZhbGxiYWNrIGNvbXBhdGlibGVzIGFyZSByZXF1aXJlZCBiZWNhdXNlIHRoZSBk
cml2ZXIgaW4NCj4+IHF1ZXN0aW9uIG9ubHkga25vd3MgYWJvdXQgdGhlIGF0bWVsLGF0OTFzYW05
MjYwLXVzYXJ0IGNvbXBhdGlibGUuDQo+PiBGdXJ0aGVybW9yZSwgaXQgaXMgYWxzbyBhIGJldHRl
ciByZXByZXNlbnRhdGlvbiBvZiB0aGUgZmFjdCB0aGF0IHRoZQ0KPj4gc2VyaWFsIElQIG9mIDl4
NjAgaXMgYW4gaW1wcm92ZW1lbnQgb3ZlciB0aGUgc2VyaWFsIElQIG9mIDkyNjAgKGl0DQo+PiBj
b250YWlucyBtb3JlIGhhcmR3YXJlIGZlYXR1cmVzIG5vdCB5ZXQgaW1wbGVtZW50ZWQgaW4gdGhl
IGRyaXZlcikuDQo+Pg0KPj4NCj4+PiBJbmNyZW1lbnRhbCBjaGFyYWN0ZXJpc3RpY3Mgc291bmQg
dG8gbWUgb3B0aW9uYWwuIEkgY2FuIGluY3JlbWVudA0KPj4+IHNhbTl4NjAgd2l0aCBzb21ldGhp
bmcgb3IgSSBjYW4gc2tpcCBpdC4gQnV0IHlvdSBhcmUgbm90IGRvaW5nIGl0Li4uDQo+Pj4gc2Ft
OXg2MCB3YXMgYWxyZWFkeSB0aGVyZSBhbmQgbm93IHlvdSByZXF1aXJlIGEgZmFsbGJhY2suDQo+
Pj4NCj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4gS3J6eXN6dG9mDQo+Pg0KPj4gU28sIHdoYXQgaXMg
eW91ciBvcGluaW9uIG9uIHRoZSBmb2xsb3dpbmcgY29tbWl0IG1lc3NhZ2U6DQo+Pg0KPj4gIkZp
eCBzYW05eDYwIGNvbXBhdGlibGUgbGlzdCBieSBhZGRpbmcgdGhlIHNhbTkyNjAgY29tcGF0aWJs
ZXMgYXMNCj4+IGZhbGxiYWNrLCBzaW5jZSB0aGUgYXRtZWxfc2VyaWFsIGRyaXZlciBvbmx5IGtu
b3dzIG9mIHRoZSBsYXR0ZXIncw0KPj4gY29tcGF0aWJsZS4gVGhlIGF0bWVsX3NlcmlhbCBkcml2
ZXIgb25seSBoYXMga25vd2xlZGdlIG9mIHRoZSBzYW05MjYwDQo+PiBjb21wYXRpYmxlIGJlY2F1
c2UgaXQgZG9lcyBub3QgaGF2ZSB0aGUgc2FtOXg2MCdzIHNlcmlhbCBJUCBzcGVjaWZpYw0KPj4g
ZmVhdHVyZXMgaW1wbGVtZW50ZWQgeWV0IGFuZCBhZGRpbmcgYW4gZW1wdHkgY29tcGF0aWJsZSB3
aXRob3V0IGFkZGluZw0KPj4gc3VwcG9ydCBzcGVjaWZpYyB0byB0aGF0IGNvbXBhdGlibGUgd291
bGQgYmUgbWlzbGVhZGluZy4gVGh1cyBwcmVmZXIgdGhlDQo+PiBmYWxsYmFjayBtZWNoYW5pc20g
aW4gdGhlIGRldHJpbWVudCBvZiBhZGRpbmcgYW4gZW1wdHkgY29tcGF0aWJsZSBpbiB0aGUNCj4+
IGRyaXZlci4iDQo+IA0KPiBJdCdzIGZpbmUuIEFsc28gY291bGQgd29yazoNCj4gDQo+ICJSZXF1
aXJlIHNhbTkyNjAgZmFsbGJhY2sgY29tcGF0aWJsZSBmb3Igc2FtOXg2MCwgYmVjYXVzZSBzYW05
eDYwIGlzDQo+IGZ1bGx5IGNvbXBhdGlibGUgd2l0aCBzYW05MjYwIGFuZCBMaW51eCBkcml2ZXIg
cmVxdWlyZXMgdGhlIGxhdHRlci4iDQo+IA0KDQoNClRoaXMgdmVyc2lvbiBsb29rcyBiZXR0ZXIg
aW5kZWVkLiBTdW1zIGl0IGFsbCB1cCBhbmQgaXMgb25seSAyIGxpbmVzIDopLiANClRoYW5rIHlv
dSB2ZXJ5IG11Y2ggZm9yIHRoZSBzdWdnZXN0aW9uIGl0IGlzIGdyZWF0bHkgYXBwZWNpYXRlZC4N
Cg0KDQo+IElmIGl0IGZpeGVzIGFueSBvYnNlcnZhYmxlIGlzc3VlIGxpa2UgbGFjayBvZiBkcml2
ZXIgYmluZGluZyB0byBEVFMsIHlvdQ0KPiBjYW4gYWxzbyBtZW50aW9uIHRoYXQuDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQoNClRoYW5rcywNCglTZXJnaXUNCg==
