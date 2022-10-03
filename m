Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC955F2E9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJCKGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJCKGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:06:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6249B63;
        Mon,  3 Oct 2022 03:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ukj35v4rolU8sjQ/CugQT6cMMfhKJVLfs0SeprgYLAs/ugNdluhuQtpRUy06zzweJSt8+Zn3PLjfm1XDbVKLONSG+UF6cf0Dkkg/YohhmWEFU5tT4rB61Q1HvOWw1BmeGvscrTun7xLXIEQ14QnkAzjdCslwZtSIh0cDqhyZQXGky1NgL9cTy9bqlkjkF5rdShTa8+gyuVDTNQxvRuot3y3BXXE7l5yFJQZHOzWUjaIFWPI5raGlhEQjApUZHJFWooV8x8+OxcOwYmJboBo/GT2fhrezegNwzV+ISKXt+GKCOcj/mxB8PdQayZ9M5PZwZAiX1YdPjUG5ETvLDJXlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waeXO+UVaDSw3x34f/v0De4Ru/N1+gQUwIWG4Euai+w=;
 b=fGo8+4AypIji79WrtB+cyGcag7Os/J0l6yYLEMdqq9ynFu23CNRyjwwgmIeED/oppjPi1ivqgwSk3cibx7CYpE8aI5JV68Jz2Rfp5jqvcYCywzbZvWnB6eV3bqez29vApvOPI5QPh65ZJJw6u5hQwRSZf3lzXmtJwKwGWMHaOKonU9j0slbVwQmYa2Ek5nAhfAXIyIPH/ygrCHy1aYBTxgid6B/hnFfIFdoGvqOHHGAf1ab2KOXxB4Pu9mvxSGYa/sHmw85Aft78+Ma+msI6j+Oz+orPL2X7n55S6dichhuZyB2SpDw+v3pIfvFLAkgOzyd7L0OdSXk76OHzOrHkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waeXO+UVaDSw3x34f/v0De4Ru/N1+gQUwIWG4Euai+w=;
 b=i68Mx8xM3673IC4MrnjiY1mrYWQTiZKa8sukAupxpxjm3nfPo09Npq5nkKq4nttmMO/bUIY5VBFKXAYOyiyi4YttaGHa9ftRbF/PfHE0cqC7e9lmPSjqXesJMKJD3B+I+9I2XMmEzDc3mLIArhnCaKDQ24Rw8S06ilwQBluT8Yc=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 10:06:18 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::b9dc:4a95:7144:2b3c]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::b9dc:4a95:7144:2b3c%3]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 10:06:18 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3 2/2] mtd: spi-nor: Add support for flash reset
Thread-Topic: [PATCH v3 2/2] mtd: spi-nor: Add support for flash reset
Thread-Index: AQHYw07vjkMZ5QQzXUimaba/7AEwIa38kn8AgAAD7EA=
Date:   Mon, 3 Oct 2022 10:06:18 +0000
Message-ID: <BY5PR12MB4258E91B51E4F7836828744EDB5B9@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
 <20220908064428.2962-3-sai.krishna.potthuri@amd.com>
 <7777b2fc-8c22-22dd-1ffd-dfe8a21ea0d4@microchip.com>
In-Reply-To: <7777b2fc-8c22-22dd-1ffd-dfe8a21ea0d4@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|PH7PR12MB5926:EE_
x-ms-office365-filtering-correlation-id: cf44dd09-d972-4aa9-7821-08daa526ea67
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: keDcsp3D19ION763BhfBvUwnQSaZFjP5pJNqLQHCW7EprHRj6AilUP0xpfDFyHua5vjBzO9bLq2ACEnLqMZ6tmDQyBNWB1RVWv2RBsZXUIH9qOkpxh+Fai1B/ubIYhduCnWuRYkf2w+RziTUrcyGWZ8Zj2Pe7OGneI6L9h3oSfMw7MHVxqD+I1POAoMuzNEU0GqFCyfNdWwVHGKc14QE9zQ6t7Zv14y4jbUY+MOqpbisoMig7ApWb//9I3FaYXf+bF4fZH7iRNBvzhefsmyj3nYMYeMWkt74n6Xl+/ZWGPZ+8DAUq+KrK4EJceLLtAHzaFoNeZN3BcQcnzjZYMePtm2Qp0Mc3BpE9WX7q2Nuzs+YB+6sRxovSOWG+2lXwrHn048aMW1fzwmgUW66ITZZN+7XySZxfEbuo999EyIkcbIOXcffr53K1kryjSCqUkqD9kWntcOMTc/cDDkUuNMDAzw8AfIsEP89bahb9PNwTSC37uuhOknasbJkY8FXemnStxJAvZjwXZG5nW1eGJ5nUc9D6uCGfLyRBH++bv6TFUDh5Ql/OrvdwJHRv6PIzNphCWxZVYUlV1CVShu8jxmh5pfnDoLQ84MAv03LIsGMhdQumbRdg8ECDgygPhBRCDw3fX//aj5rgIWyabtLXeN/0S+5pBSFgM6Ec/+guUl5/YLlqS+IVI6rCNBFUtx0vZdDlrlLaozx5+bKlUo9u/Q1F44ms++T8xBnmR2OqHgabBw93OwSNf7C87Yn+ChxmWwWYdTNzrNh0k9zXmYw2iHZFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(33656002)(38070700005)(55016003)(122000001)(38100700002)(54906003)(86362001)(110136005)(316002)(8676002)(71200400001)(7416002)(5660300002)(52536014)(8936002)(66476007)(66446008)(64756008)(66946007)(478600001)(66556008)(76116006)(2906002)(41300700001)(83380400001)(4326008)(7696005)(6506007)(53546011)(186003)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGtxdW56ZHpJQ3NOcFYvWW5tUUxoUkg5MHVqbTlGcFJLSE92dEI2MFVod2s0?=
 =?utf-8?B?c1lGRW9yZitZc1VXQ2FtTkNiaEl3NTE0bi9kbGlFb0h6WWdNWUdsMVhSc0Zn?=
 =?utf-8?B?NGxFUjRPREs5UmU1MUpZSjRHZHYrMEJPOVAwUXkvVy82cHNLQk9pNklqT0FV?=
 =?utf-8?B?czNUOWJkNG13NjN1NE5lQzk4ZDl5VDY5WmNCODVGUDBqSUhqUEJSaWdRZFpH?=
 =?utf-8?B?OGU5WGxsTXJEQVgrQUxCMW0xa2tpMDZUbFIrT1VQQno0dUxDMDNzU2tsR3dG?=
 =?utf-8?B?SHZ6dmR5VGRacjhCOHFBcWZ1c0ZocUFCVk55eFQxbWVGU3lNUjRPSVFpTCto?=
 =?utf-8?B?MFdYaVZ1alZGUVRnMGhHSW1jdDFCSHh1UzEwTlR6VWJMcUo4N0JlZWNzVE94?=
 =?utf-8?B?L1FHZk1CTEpMU0lXUHlZbGlDNHdualRhSnp4MjlIbllCNFdNN2tvL2RDK0Fl?=
 =?utf-8?B?YmpaWXJsWFJNb0Z2d3hYUXRXZzI5NjVCSkx3d1hlbTRWV2IvaVljbGxDTEJs?=
 =?utf-8?B?Q0xLR014REx6bGVZZlJqbk5JT2NwSUtNOUU3emNoZ3hENCtqeEZ5cndKcVhv?=
 =?utf-8?B?YW1DTGs5TTZ5OUYzN1NWVkdZNUQ5NGtZU0dlakdEbVlBVXErb2ZHZzkzMTFH?=
 =?utf-8?B?bEMxS0dWcjY1cm0rVzlCbUVSMUlkL3N2Ty92cTVVN0V3Q3ZhQ0VrSWhwNGVH?=
 =?utf-8?B?eGdXSllhY25BNXQzVk5BSWM0aTdaenY0NnQwM0RhLzk3dm5TVzhrdXdGaGtQ?=
 =?utf-8?B?SGtQd3pvOXRnWDU0UVhEemNhVWFqSHFWQ1VlaGVLbVdkNkRLUTNCVzAzbnJ6?=
 =?utf-8?B?RjVLWm0rcjJSUHd3b0tYSWxnZGEzSlI3WmdPeEpBRVV0SWpBb0l4bXpUYk1h?=
 =?utf-8?B?YUFFSHcvTlYwc1o4MGJXMlRZYVNKb0k2VFBkbFd1NVhISHp5K1hGNHpid3dh?=
 =?utf-8?B?eG9XYXJibnIrNlIrYlFDWWtDT1FKaHpuWXZKZHlmTU5Od0FaL084K1h2dUpv?=
 =?utf-8?B?aTRXWTJIWXRJKzRXTU9WZWFwZ3pMQ1krZitBaURLTHNUY2x2VGc0Mmo5MVhB?=
 =?utf-8?B?Y1FCdWc3TnF5ZVRYVFIwQlFpRHc4Sm1oQXBITVMyVmN1T0pZMlpsQkFHeUhI?=
 =?utf-8?B?MTcxNDJ0dXNpdnlzMFM2RWJDNk1xazBqdVdPeFU4Y1lhOCtjeU5JR2NhcWRw?=
 =?utf-8?B?eFJ0YU1LQUU5YnZzUkxoT21hWXZYbnZFUE5XUzRFTnd6RE8xalZub2JxQUt2?=
 =?utf-8?B?cjY5T28zb0dEYnhmcWZzMFIwM09nWFMxTndrTHc1Nnp5a1NnbVZPM2RmS3RR?=
 =?utf-8?B?ZERZVGJlQmNrUmV0ODF0M0xMOHFKc2YyTjVkQ1p6dHF0Ujhrc2drTzJ6Mlh3?=
 =?utf-8?B?Z2ZJK200bjdRYmx1Y0tRTW51Y0VBV01hc2dTb2I5c29WcVN2YTVxMDFpbUNH?=
 =?utf-8?B?QUNjemdJUU1NRURwQlBiRFdJRG90Nlh4VDVwWjNaMmFWdmF0bkJWbVF6RWkx?=
 =?utf-8?B?cE5Bb0Z6Y3ZHaHFldmRtTnVYc1UxWUkxZTFnRWh5TERGejZkaWswd3loY3F4?=
 =?utf-8?B?UGtRY04vankveDdXTGJxM2YzZU8zclpYbms1Y1U2VTZqYkdKeFEzUW9rWW42?=
 =?utf-8?B?MHRDYTNHV3F5VFh3bFoxdi95c2x4dytoaGlpVkFRV2tmdUh1bVoyUWdPSGMw?=
 =?utf-8?B?NUkwWmtzU2o0TzlSVTRBNUp3NlVXY2QrL2V6MmpKbWY5aWlETlF0L2Zud3dr?=
 =?utf-8?B?ZUtXcVdXNWdzZDdaYlhSeXVqM0JJR1dCMGNQL05aeldWZXVISGVnTUR0cmV6?=
 =?utf-8?B?Rml4VHoyZ2R3VC9BR2hmODQySC9kUjRkc3R5TDlUR2hJUVdrNXdiZXNkWENF?=
 =?utf-8?B?SU13STh0ZUs4S2lyTmtIbzk5V0ZnWUdlaFRGTSthQ1Q3Y295WmRqMDhIcDJw?=
 =?utf-8?B?eTlHdzdyMDNvN0o2bFlxYURsaG85Y1hndzNMWTBFOTlIb2hsS3BaZXdXQlhY?=
 =?utf-8?B?b0lrZ1c1ZzYyZkJPZUVYY3h6bUplTFJIYnZWS08ybjBHRUszaTVjSGFwNUhM?=
 =?utf-8?B?cTkrL1M5ZjRJTE9iZmhOQ0k1c2Q5UXFoZEUzTXRLbUh3SEI1WXpHU3J4Q1Zz?=
 =?utf-8?Q?Ohbo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf44dd09-d972-4aa9-7821-08daa526ea67
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 10:06:18.5711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsEEQvEtlZFI6pUa5pjH2FCIf5mM4erWQYypuYc5kGRBtMYoYbwRU1rFUI783rNY8Iy9Dl0WZ9+RCzJpbeYY9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IgQW1iYXJ1cywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gPFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNv
bT4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDMsIDIwMjIgMzoxMyBQTQ0KPiBUbzogUG90dGh1
cmksIFNhaSBLcmlzaG5hIDxzYWkua3Jpc2huYS5wb3R0aHVyaUBhbWQuY29tPjsNCj4gcHJhdHl1
c2hAa2VybmVsLm9yZzsgbWljaGFlbEB3YWxsZS5jYzsgbWlxdWVsLnJheW5hbEBib290bGluLmNv
bTsNCj4gcmljaGFyZEBub2QuYXQ7IHZpZ25lc2hyQHRpLmNvbTsgcm9iaCtkdEBrZXJuZWwub3Jn
Ow0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmcNCj4gQ2M6IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHNhaWtyaXNobmExMjQ2OEBnbWFpbC5jb207IGdpdCAo
QU1ELVhpbGlueCkNCj4gPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIv
Ml0gbXRkOiBzcGktbm9yOiBBZGQgc3VwcG9ydCBmb3IgZmxhc2ggcmVzZXQNCj4gDQo+IE9uIDkv
OC8yMiAwOTo0NCwgU2FpIEtyaXNobmEgUG90dGh1cmkgd3JvdGU6DQo+ID4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dw0KPiA+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gPg0KPiA+IEFkZCBzdXBwb3J0IGZvciBzcGkt
bm9yIGZsYXNoIHJlc2V0IHZpYSBHUElPIGNvbnRyb2xsZXIgYnkgcmVhZGluZyB0aGUNCj4gPiBy
ZXNldC1ncGlvIHByb3BlcnR5LiBJZiB0aGVyZSBpcyBhIHZhbGlkIEdQSU8gc3BlY2lmaWVyIHRo
ZW4gcmVzZXQNCj4gPiB3aWxsIGJlIHBlcmZvcm1lZCBieSBhc3NlcnRpbmcgYW5kIGRlYXNzZXJ0
aW5nIHRoZSBHUElPIHVzaW5nIGdwaW9kDQo+ID4gQVBJcyBvdGhlcndpc2UgaXQgd2lsbCBub3Qg
cGVyZm9ybSBhbnkgb3BlcmF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNo
bmEgUG90dGh1cmkgPHNhaS5rcmlzaG5hLnBvdHRodXJpQGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvbXRkL3NwaS1ub3IvY29yZS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMN
Cj4gPiBpbmRleCBmMmM2NDAwNmY4ZDcuLmE3OGFiOWJhZTJiZSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jDQo+ID4gQEAgLTI5MzMsNiArMjkzMywyNyBAQCBzdGF0aWMgdm9pZCBzcGlfbm9yX3Nl
dF9tdGRfaW5mbyhzdHJ1Y3Qgc3BpX25vcg0KPiAqbm9yKQ0KPiA+ICAgICAgICAgbXRkLT5fcHV0
X2RldmljZSA9IHNwaV9ub3JfcHV0X2RldmljZTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IHNw
aV9ub3JfaHdfcmVzZXQoc3RydWN0IHNwaV9ub3IgKm5vcikgew0KPiA+ICsgICAgICAgc3RydWN0
IGdwaW9fZGVzYyAqcmVzZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgcmVzZXQgPSBkZXZtX2dwaW9k
X2dldF9vcHRpb25hbChub3ItPmRldiwgInJlc2V0IiwNCj4gR1BJT0RfT1VUX0xPVyk7DQo+ID4g
KyAgICAgICBpZiAoSVNfRVJSX09SX05VTEwocmVzZXQpKQ0KPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gUFRSX0VSUl9PUl9aRVJPKHJlc2V0KTsNCj4gPiArDQo+ID4gKyAgICAgICAvKg0KPiA+
ICsgICAgICAgICogRXhwZXJpbWVudGFsIGRlbGF5IHZhbHVlcyBieSBsb29raW5nIGF0IGRpZmZl
cmVudCBmbGFzaCBkZXZpY2UNCj4gPiArICAgICAgICAqIHZlbmRvcnMgZGF0YXNoZWV0cy4NCj4g
PiArICAgICAgICAqLw0KPiA+ICsgICAgICAgdXNsZWVwX3JhbmdlKDEsIDUpOw0KPiA+ICsgICAg
ICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJlc2V0LCAxKTsNCj4gPiArICAgICAgIHVzbGVl
cF9yYW5nZSgxMDAsIDE1MCk7DQo+ID4gKyAgICAgICBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAo
cmVzZXQsIDApOw0KPiA+ICsgICAgICAgdXNsZWVwX3JhbmdlKDEwMDAsIDEyMDApOw0KPiA+ICsN
Cj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBpbnQgc3BpX25vcl9z
Y2FuKHN0cnVjdCBzcGlfbm9yICpub3IsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ID4gICAgICAgICAg
ICAgICAgICBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9od2NhcHMgKmh3Y2FwcykgIHsgQEAgLTI5NjUs
Ng0KPiA+ICsyOTg2LDEwIEBAIGludCBzcGlfbm9yX3NjYW4oc3RydWN0IHNwaV9ub3IgKm5vciwg
Y29uc3QgY2hhciAqbmFtZSwNCj4gPiAgICAgICAgIGlmICghbm9yLT5ib3VuY2VidWYpDQo+ID4g
ICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+DQo+ID4gKyAgICAgICByZXQgPSBz
cGlfbm9yX2h3X3Jlc2V0KG5vcik7DQo+IA0KPiBTaG91bGQgd2UgY29uZGl0aW9uIHRoZSBjYWxs
aW5nIG9mIHRoaXMgbWV0aG9kIGJ5IHRoZSBhYnNlbmNlIG9mIHRoZQ0KPiAiYnJva2VuLWZsYXNo
LXJlc2V0Ig0KPiBkdCBwcm9wPw0KVGhpcyBpcyB0aGUgc3VnZ2VzdGlvbiBmcm9tIE1pY2hhZWwg
b24gdG9wIG9mIG15IGluaXRpYWwgc2VyaWVzIGZvciB3aGljaA0KaSBhbHNvIGFncmVlZCB0byBo
YXZlIHRoaXMgY2FsbCB1bmNvbmRpdGlvbmFsbHkuIElmIGRldmljZSB0cmVlIGlzIGhhdmluZyB0
aGlzDQpyZXNldCBwcm9wZXJ0eSB0aGVuIHdlIGNhbiBkbyB0aGUgcmVzZXQgaW4gYW55IGNhc2Uu
DQoNClJlZ2FyZHMNClNhaSBLcmlzaG5hDQoNCg==
