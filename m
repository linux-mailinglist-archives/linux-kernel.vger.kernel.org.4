Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331806ADDAF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCGLk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCGLjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:39:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640AB4A1D4;
        Tue,  7 Mar 2023 03:38:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEXsdzoOzIpQz5Js9iSIeXo0X/nMtVICGQ7ENsJXX2ba2rdQ4mrVZUiNfmU5n5FHRXGdTGf9sQ5AkFrsJAZ34AG5lyjbSkuTeDRJHPrU+qkM3++7jEVYTCzVJNEJnlN3BpLrxGGmptV8Nj5rK9l5S85i/5nIPZIefysxkOLJmHZ6guDW+caGjZ/2wJ5OHitcypkPb0lPdCV4LISxw05bilcaI29w2LKNnOMizb0VsA2i7pcM5J7jsUlp38qxyuVVlUqf1XJlipauMzckT3AFhKdT5BlKPBwaveEpX/YgoGLAoO0U8LWNtvVOyPntYY2sqZ/p6EPWSVGgKRtJXvCTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYXmsxRwWTBT+5paHXLNVCnq2ilkEtGNb5B6XBWo/vQ=;
 b=fT9G+WBGk8Tm/CwRBc7TGl8lo9XRUhz4zxqz3nI7ClFU4UM67iZXszTI8AaAi9K5M69/wnrKXDusLxWcwBD2Dn1u0ChWFOut8opFoi3KP6gaiB1+npo/YBz4OWiLZZxGXJ5W87elyo1idNgZGs2gZCLk3+Qd0AZ2eh2WHjtaZt6Bvomn4czaHP/lkQTNPSc6BgSABPLh5Zus8veskcnHBMVcxyGKOCKlZ+rvebS920xoPNiwlrCkJywRKCbpNpDW+8ThLBskdOnLWyffp033R1jubSnzTKjBEH3T7xJoiCf7xaxdGgFR9TgWk33U/DVkHkfy5wxwvwVdAbyVO+QpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYXmsxRwWTBT+5paHXLNVCnq2ilkEtGNb5B6XBWo/vQ=;
 b=mrEy+RcZey2CoKxeDakWuLY1dMszdICrIfIeg9woA2NguVpfS7Z3niH0aNJTc3MwOQqRx2118AStAVAqbTuCM7BFyPTq5/JL68ug68edU7D+k2ld5IU+7bP9Zs+9ZdA1NMa2uztqwsv/hoQtcHL75kwywLJ202SaTwMnCj8sipo=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 11:37:50 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::96c6:f419:e49a:1785]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::96c6:f419:e49a:1785%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 11:37:50 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5 09/15] spi: Add stacked and parallel memories support
 in SPI core
Thread-Topic: [PATCH V5 09/15] spi: Add stacked and parallel memories support
 in SPI core
Thread-Index: AQHZUFDgolfpAHzRAEiHg/XQpMwU3q7ut9sAgAB0ZjA=
Date:   Tue, 7 Mar 2023 11:37:50 +0000
Message-ID: <BN7PR12MB2802992D71DDA252B008AFDADCB79@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20230306172109.595464-1-amit.kumar-mahapatra@amd.com>
 <20230306172109.595464-10-amit.kumar-mahapatra@amd.com>
 <1bbda9e6-37fb-195b-fd62-0e437847c636@linaro.org>
In-Reply-To: <1bbda9e6-37fb-195b-fd62-0e437847c636@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|CYYPR12MB8654:EE_
x-ms-office365-filtering-correlation-id: 3ac2d3e6-97fc-4b37-8929-08db1f006200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dvsDufmI8s378BKO51mQltpPTtlvW/DdY8EqjvHt+3guol9msRVsDUQR83/t8ySGIliQJalxJzj6T5xyJa+j3ydmDmuALnzSuldcyMVs6oWyMieY4mkQ1XZIMUYYWtq+rVAPTRN0ccahRt/dhUIeif4LjpsHzdtAOBGqkgl/Fg7zX9t894nLiGdK4BRFunE9fgXfsN8yVHGnMv23AICy9sMLtB7gp/I8MUtitHm0/zIFm/x/B8XQ3XJYriIIrN4BGwnSq9QxXqySiAuOOfsITWuYsH82y6kPRq5HqI8ms+qnxY8SDAHgIALQEvVAu+FONqwfCIGnb18N3SS7asiJqN/u9AVteGClBMDik73dmGS9V8utOXMAUUfb+Ihd+97ToYlwV77kXbCPehPB19JGAknm3dD7bv85DA5X4HFeJW+gNiXJDY7ym1jFGEoN5aK2oG6wwVKg8SBW8ElrsPRpIRXbRnBKa15AHkUHTAqpGFMgDz87w7kclKQxZCfbbvsKdX1NHX1+OI4A0pUxyecQL3oNBR/vEr7A+MQGu1ClS6lCp1wWOneVSE7z8EezRG3gkAlvAT6EG5D7uB1DWPVNHqFKRToxDX4DMwuZ3m8MxHDOdLZNfjMNgDKCnwsjc5TBxWLWiRsciLpnNlAdy3oUYRAi+cgEqQL6yc8Gx+Yk1zKCo+VpQxzYI5ZpFREK1DUX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199018)(7416002)(45080400002)(76116006)(8936002)(5660300002)(52536014)(66476007)(66446008)(66556008)(66946007)(4326008)(2906002)(8676002)(64756008)(54906003)(110136005)(316002)(478600001)(7696005)(71200400001)(6506007)(966005)(53546011)(26005)(41300700001)(55016003)(122000001)(33656002)(86362001)(38070700005)(83380400001)(38100700002)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG5vWG5oaUlxZXNkQWZ5THY4QVc0Sm12TkJ5czlHMmNRS0liRXZvTUZrTXJD?=
 =?utf-8?B?Z3E3ZzJ4SWprZEhBSm9TL2ZjRGNEYTU0S1NtMGdBRHRTUmRkWVlZZTdLNXdR?=
 =?utf-8?B?cDJ6V0pCUTh3WWNWMTUzNnJzUng3MjZ6N1NGdTdEVkRkQmNVVmd3bVVlenVF?=
 =?utf-8?B?NTFKenZaNElOZmpON0RsOXlzZUtXWnlnWTVqMjRjcTZRcHVMUStzN1Y5SGZu?=
 =?utf-8?B?TzJmVWZEYy9GT2NHRUNGYVA1RWdsZWw4b1l2LzA4Tk44bUFFT2pmZlVEK2d4?=
 =?utf-8?B?VlROUlg0SUVsUmk2R1h2WmFObUhNNnhHZm56TWZ1TS9BdHNFYjROOXBEQWxQ?=
 =?utf-8?B?a0VLSFR1SnpzWU9wVVhGNVhBSUpTVWlxUWc3Q1dFbG1pM1AzMlRaMXUvL3Na?=
 =?utf-8?B?ZG1IRS9KeU9kZGNSRGVFL1hhU2Y5cHFnemlzSVoxY1J2OEVRMlV1STV0ZS9R?=
 =?utf-8?B?Qm5ndm1WMmszUmUzL0dxcy9jVjBjeWJlbG8wd0twOVhNdXhmVk1GckgxdW5z?=
 =?utf-8?B?Nk8ydEZaQUZQLzNDa0FaaC9xdlZCSEdwaVZRMCtUdGlUd1p6OWZhakhYcUVj?=
 =?utf-8?B?SkhHVXRjNDJnM1RLb0dwZ0J2Y3RSM28zSmxLRnEwd0VwN2p6cHU3Q1BTcWYw?=
 =?utf-8?B?N0NvN2pDOUpHOCtQUlBMWmJ6UEc3b0lQbUNyV0RGRy9jZ0oxbUJWOXQxdGlU?=
 =?utf-8?B?bXJxbVdNbmlKZzRwa2ZBUytLUTJvSVQ3NlkwUzJpM29RMURvYzg3bmoveVlD?=
 =?utf-8?B?L0V5NDVicS92TzByNnBSVUVMZXZ0MnZjZVNlQnZuR01uWDhQajZhUUJOYW41?=
 =?utf-8?B?cG44eWE3MGE1bVB1YWVCbGgwL2R4R0JNWkdkbjlJREVDVnFFejh5TFBVYm0r?=
 =?utf-8?B?TVB2Ly9vdUtYeS9KRVlWOGxPYjB5SVFsNGRqZGlEbStKVUhabENuNmkxOS90?=
 =?utf-8?B?QW1NMlhxTXlVb2RGWWN2TXhScHJKdGwyNW9NS21VejFjNDFzQ3NyellJdVBG?=
 =?utf-8?B?WGt6VjdEWSs4UzY2bkZqRlpJZzRhSkgyQTZoQkJmZWlFSVR5eHV6M3RXNEo1?=
 =?utf-8?B?VERJR1VLY1Mxc3ZwZ1JxZEc1VVdzUVVoYUhTMzJQd01wOTJYRldIbXhhRWFj?=
 =?utf-8?B?TzFqMGYyV3kwejFkbEM4SndINUdtWEZjbVBKYXpDQVhpL3JudXdvRHo0amYv?=
 =?utf-8?B?cHBWTmczb0Zuc2gxSm9nRmdRTk8zcFc4d1FoeDBkckkrMkZJZDMxZFBETW90?=
 =?utf-8?B?YVFtVU1LaCtyb29xYkVWMXNwQXFHV01VS2J5S3Fhb2JHSjRmUXNIRndOUkN2?=
 =?utf-8?B?OThoajRXcm1lREVZNjNYcHJmdUgxQlhuWjRuTU1DcmVMUnNOSXFEZ0Y2UjI1?=
 =?utf-8?B?VzMwVlJWVmd1cmEzb21jc3lLZU1vTVJaK0lVZDA4bXQ4S2R2WU5GMCtnK3JD?=
 =?utf-8?B?ZllQaWZCd1JzWHN6OUo2QXVtZzdJdGR5dEJ6d0JGOVRBOEFGQzE0cGJDRTJo?=
 =?utf-8?B?aTdiWG5XRSs4anNGeDRjc25yZnlxdWVZbkNoWTAyUmhuRzc4Nk41elBiSXdM?=
 =?utf-8?B?K1U0bHhIRkdYYnpBOXpjMWhaVU0xQnJvZDRrZ2NES2xwSGdEWWdYTVRseWs4?=
 =?utf-8?B?Ujh3clE5MTQ1RklvSW9FWlRXaUpWM2xXRlcrNWo4N3RmRCtnSUtRWUdyNzZV?=
 =?utf-8?B?RHh3Uk1QOXl1OFhXWTFSTS9OSzBYTU90R1Y2RXhDZ0F1NnM1KzVJZzluVnNW?=
 =?utf-8?B?ZVFlQUZXUmxPWEpNdWZVNzVScXoycFlkaUZ0eDA1dnlNRUY1Um9oYVhkbTNY?=
 =?utf-8?B?d0NxeDR3bytKdytwbFJUN29tdTlxOFNTQ1hhVkdPTWpsdDZRa3gvM0tIU3Bt?=
 =?utf-8?B?TWRCRFFoaHNXYkpRbEhuaG1XRmdDVU0ra3QweEhYZXZKTjFibFFzYkdGdkpr?=
 =?utf-8?B?R3o5cHZOM0NFWjJPcFFteUVVellpOXhRY2dOMDBGT3FLNmhuNm9yeHpNVjhP?=
 =?utf-8?B?UnNnNUovVFR0bXg1ZDJhM3ZuQmRDQzd6RmUxeUpHTzZQY3ZGaHVQemNEeDIw?=
 =?utf-8?B?U0g5NGZRU0l4bE1wSnVsaTJLTW1SUTkvQ1Z0YkltVC9qR0hpSEtnWnRibjB2?=
 =?utf-8?Q?nLYQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac2d3e6-97fc-4b37-8929-08db1f006200
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 11:37:50.7564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8WpByhjsqpBzqVJ++6LE0+Ydp5+3VTxj/9ROKASCSeh2ofD7fOmauOP7WBOHQbI9oIkMzuWlmyc8jEILzEJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCA3LCAyMDIz
IDk6NTEgQU0NCj4gVG86IE1haGFwYXRyYSwgQW1pdCBLdW1hciA8YW1pdC5rdW1hci1tYWhhcGF0
cmFAYW1kLmNvbT47DQo+IGJyb29uaWVAa2VybmVsLm9yZzsgbWlxdWVsLnJheW5hbEBib290bGlu
LmNvbTsgcmljaGFyZEBub2QuYXQ7DQo+IHZpZ25lc2hyQHRpLmNvbTsgamljMjNAa2VybmVsLm9y
ZzsgcHJhdHl1c2hAa2VybmVsLm9yZw0KPiBDYzogbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsg
bGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUgMDkvMTVdIHNwaTogQWRkIHN0YWNrZWQg
YW5kIHBhcmFsbGVsIG1lbW9yaWVzDQo+IHN1cHBvcnQgaW4gU1BJIGNvcmUNCj4gDQo+IFRoZXJl
IHdlcmUgdG9vIG1hbnkgcmVjaXBpZW50cyBpbiBUbyBhbmQgQ2MgYW5kIEkgY291bGRuJ3QgcmVw
bHkgdG8gdGhlDQo+IGVtYWlsLiBJIHdoaXBwZWQgb2ZmIHRoZSBDYyBmaWxlZCBhbmQgbW9zdCBv
ZiB0aGUgcGVvcGxlIGZyb20gVG8gYW5kIGFkZGVkDQo+IHRoZSBsaXN0cyBpbiBDYy4NCj4gDQo+
IE9uIDMvNi8yMyAxNzoyMSwgQW1pdCBLdW1hciBNYWhhcGF0cmEgd3JvdGU6CQ0KPiA+IE11bHRp
IENTIHN1cHBvcnQgdXNpbmcgR1BJTyBpcyBub3QgdGVzdGVkIGR1ZSB0byB1bmF2YWlsYWJpbGl0
eSBvZg0KPiA+IG5lY2Vzc2FyeSBoYXJkd2FyZSBzZXR1cC4NCj4gDQo+IFBsZWFzZSBkb24ndCBh
ZGQgY29kZSB0aGF0IGlzIG5vdCB1c2VkIG9yIHRlc3RlZC4NCg0KRHVyaW5nIG91ciBkaXNjdXNz
aW9uIG9uIHRoZSBSRkMsIE1hcmsgaGFkIHN1Z2dlc3RlZCB0byBhZGQgbXVsdGktY3Mgc3VwcG9y
dCANCnZpYSBHUElPIGFzIHdlbGwuIFdlIGhhZCBhZ3JlZWQgdG8gYWRkIG11bHRpLWNzIHN1cHBv
cnQgdmlhIEdQSU8sIGJ1dCBoYWQgYWxzbyANCm1lbnRpb25lZCB0aGF0IHdlIGRvbid0IGhhdmUg
YSBoYXJkd2FyZSBzZXR1cCB0byB0ZXN0IHRoZSBDUyBHUElPIHVzZSBjYXNlLg0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC9CTjdQUjEyTUIyODAyRTJBOTA3OUU1MDU5
MzI4MzIyNzBEQzk3OUBCTjdQUjEyTUIyODAyLm5hbXByZDEyLnByb2Qub3V0bG9vay5jb20vDQoN
ClJlZ2FyZHMsDQpBbWl0DQoNCj4gDQo+IENoZWVycywNCj4gdGENCg==
