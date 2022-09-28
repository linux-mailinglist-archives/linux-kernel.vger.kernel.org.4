Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29B85EDF01
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiI1OmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiI1OmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:42:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A200861FC;
        Wed, 28 Sep 2022 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664376132; x=1695912132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aL71AxyZIbftSLQuDd4oGBOObIK8ZZ9CNeNrSWGP/lo=;
  b=ddmLJrBrvQUsh+5flEWi/3H891wJwMoSrc2cLanryZ9yWDg8g82KJQx2
   nsA+gUcua8udVyCrEdQAWnh3k3jKUEmwzDxfVDzML19QIrKZre9dJbA46
   DirNHgmu7dz+JNgCEBr5YAMfrsbfzCwJ7SABRw8ql6aOjdbzvXlB7Sv3U
   rRf3iq9bdKWOfEOYziPsmlm8b4DwVpVM/SM+r9HVgNnpQZO2u/NgxoMxR
   +2lCPt1FqjlE++raB4gvyrwYQtwJ4S0AlFKAICx60kV5i4PKgPkqyOB2m
   dBYKheElZYO/h6oO5gL3xBn1IbIPo7GnWK+8KZFHCjfGczmzVgaP5gbXQ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,352,1654531200"; 
   d="scan'208";a="217673521"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 22:42:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfh8b64TFjeEPugVG3tNmE5eMA5HCsk6XVKqAeebw5sK3rldgk6UInm/oWW1Cn7WNegaaOCevdig8H5gwmHd2hgqElw28R7iyIw8VOrtXOVBBu2FQcOIhQjvVq+HabgA9ADMr4KSFho42xBimJSf3kl+owi2TwndcvhnQRysqWnovkXS44SYSZMC8dbLlAOryUc/dHq8b2xB6zzhOKx7De8Uy8EeOsQTbjeFOKliej2ynFPG8Qj9MhfVUBe/Tw/DNF+9GZbZ/P+ZsGHBjWPJ5VDJuQu+tpEzmUfbBmXuemxMNSx3fi7D7KUctHyi0Yv831VF4XPJwEcEOE+W4ZCYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL71AxyZIbftSLQuDd4oGBOObIK8ZZ9CNeNrSWGP/lo=;
 b=A5iG75qIwXOWWOeDXCLIZECrncz4LUDwbwZSt5EoCbpxbu0viy6on/YwVKiU0MLaR3xRaQSKCsOoqnMGEooZNDQ8CzZ0QWUHdQ8KpdfrKoFp5THLnh62CCetp51z8/M1W138Kh4ymFzLgZqqomIP7/44BlXyZsuk/wSqLAMJ2iT8MLRlvVmfvTVMMRRohNoOv8m97BIuLkK9vS4SMNnlq1PKDw9kUQlYqpIygjJx6vq4CGeUBLD62m5jlT8W1V1wILjnGgv0svruw4Jq7kZDxXFPohsLphe10ah05QGiwQya24ASxj87CjewuVzZl0N0//EB56Ta4uKR51LSYGt+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL71AxyZIbftSLQuDd4oGBOObIK8ZZ9CNeNrSWGP/lo=;
 b=laBaJeLE5vaROLMUG/oF+tED+AA+uNOcGSS1GzB4C/O1gLQnt/vGip1WVqResRvYsMlaw9UWGRllcwxJ8NdWUbrhfrhXw0bfz9XNatWyrlhifJK+SX9vQWAMJu8/9GK2vrHHP7IYM4vRZx5XglVFF+z7Kd/F0tbeDctpU5Uni6U=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by DM6PR04MB7051.namprd04.prod.outlook.com (2603:10b6:5:244::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 14:42:07 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7%2]) with mapi id 15.20.5676.018; Wed, 28 Sep 2022
 14:42:07 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniil Lunev <dlunev@chromium.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>
Subject: RE: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Topic: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Index: AQHYhKDynvKkVtaQm0SrWhB5D1T9dq3ooC4AgAGVWkCACuorUIAAI1gAgABD8GA=
Date:   Wed, 28 Sep 2022 14:42:07 +0000
Message-ID: <BY5PR04MB6327294F1E861DD13771EAAAED549@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
         <87e6fdb49d9d76c468712e1b42cbc130273b5635.camel@gmail.com>
         <BY5PR04MB6327B8C5001E315009E3AC6EED4F9@BY5PR04MB6327.namprd04.prod.outlook.com>
         <BY5PR04MB6327ED5C6D91CBD3A024F709ED549@BY5PR04MB6327.namprd04.prod.outlook.com>
 <0e2334ebc4ba0ba137e83c60a090fde536be7f26.camel@gmail.com>
In-Reply-To: <0e2334ebc4ba0ba137e83c60a090fde536be7f26.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|DM6PR04MB7051:EE_
x-ms-office365-filtering-correlation-id: ab917493-2780-4aab-e164-08daa15f9e15
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9r6/LZikye9AAssldGimQXypX897XQPlj9riQ5eZNs81e86fpJ5hynIeRL/cTXMTzwS5go0nZvtF79z0VYcVyRyVBC1UQqDpC3E0RU05BSwE4jupDrB8MSBs+fif0MJcP9YucAzOy7BGHWr9rkI+wr5Gr80fRMM0LkjAtToV8yOXyXbI/NmImroAXmvcOW7TdRn7g+9DYbalt2GA8Ui+OP2598LKZub4fGVF4du7uNQDry8PVZriGbjBlVqHsHECrEEJwA9bwNqi5kK5G+coGX3sVwV2QeICkjE53l39aBSbuxSWd2PlNRbl2nHlObqGQgEuQzwFDGSwbJB/4zXjsl51YfQ0Wh9c0t3nbPN505x08Gvrdu1CZ/WCDg2Oxze53trWOq9uUMAptC3mfTR5kH5ZpaLUylCdolJmqCJaRT4S3+49VpRfWsYusjQi9BVE2YhJ6iEl/NuvTNIkSq5chD1iIji2AF6wpu7iBC5MUM8EvmxxojcR/vhO9cm+15ITninjukGDuACObZ45BD5idVpqU9/05Wk+PMjFFhVmCtUxhma5O23LEh3pgzbsIKK3m7LaRpiJBPSCk1ArCBkxPoUovutgL3z3+/5SZDAsSy9/meySCdKgjqcs+UxptGIFdr3rdXTyl6fSDsQecmNKdYHHwjeGBmE8UTmcEbiF4u9oKLFNWgIbn6MUQJ30osali5shRcfBROPsawmlEEede7swgvK8+43uO6LWdPo1rMj/Qgkjr0z7NEKYacK+BvlxZ+1WjE/mX9cOlHj++dBAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(86362001)(66556008)(66946007)(8936002)(52536014)(64756008)(33656002)(66476007)(2906002)(41300700001)(66446008)(8676002)(76116006)(4326008)(55016003)(316002)(54906003)(110136005)(5660300002)(82960400001)(38070700005)(83380400001)(122000001)(38100700002)(186003)(71200400001)(9686003)(26005)(53546011)(7696005)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yy9FcENERkE1NDA3c3lTMWgwUVRBd0o5TWt0ejJPdFdmQkF1QW1WbWJiYlNN?=
 =?utf-8?B?K05PZlRuYmlKV3luaE9oeG1SSlM5L2hPRHd5QU1XaGVUTDF1aloySlFCSXlY?=
 =?utf-8?B?TndMcVArWjNJUGRWZUFOMldROWRwcFhpOW9MZ2UrV2FlWlVNV05GS3BIYzBx?=
 =?utf-8?B?NmtkNFkrcWVwUlA2OFppNzMrWUIzcWhwVUZ3L3JuL1g5d0VZcUJSMnAxUW9X?=
 =?utf-8?B?Y3BsMmFvOGRrVkhid2Y3MjlMY2MrTDdjb2ZuL3VYaVlINktCT2pWekx5VjdD?=
 =?utf-8?B?Rm9JOVFPOGliKzZyN1JYSllacUhFbnZEaVc3WHd1a0ZETDBycDhmOVN6VW91?=
 =?utf-8?B?UmlGQ1RSTFlURWNvVmJJK2xYQmJFQXJMSEo5T1lLZnNOaExJRVpibTI3YlBM?=
 =?utf-8?B?MC9IQktwTTlNM0hXOEc5VCtvNmxLZjkyZ0pKTGN3bzIyL3NLODYzTmd1NW5P?=
 =?utf-8?B?WGFwa0lxVVEyWThCTmk0aTduUFFoMnlneHpaZmJ4SHFrdXRQaVNhZUlSQ3lM?=
 =?utf-8?B?Zko3c1VSM1pwSGw1U2Q5bVF0L25DUm5abVlEb1NYMnB6Yko0ZEtEcldPWGx6?=
 =?utf-8?B?VHZ2Tkd5N3V2OEZ1bCtJSHdJK3NGZXllWDl2a1J1MHd4ZlI3UUNLZ285bi95?=
 =?utf-8?B?V1FrYm0xTFduVnhTUHRvNHJMenhnWk1GYTZFZ3pVVzBkUWhnSzU5bnRhREJa?=
 =?utf-8?B?enBpWmM1bXdsbng0OW9mZURrVlBiTFdHNTUvOC9sN0VXVHJtbitVVDQ3RjBr?=
 =?utf-8?B?Ky9EditFMjR3TWhoKzQvQysycXpyVTNrQTdtWHphSld5ZjRKTEI1bUIyWmdy?=
 =?utf-8?B?OVpwSHVpbk5rc0JIa2NHajNCVjY2ZXBsVFZuRFVvei9WUHd5REMyekVObG4v?=
 =?utf-8?B?S2VwWElPb1FYWFdnSE9vN2Z1V2Nkbis0MUNMS25HS1c5NkQ5azhzNWUwSXJI?=
 =?utf-8?B?RmlrVGNVNUUxaUh3UDlSV0NxU1BiNFJBMmdXWkhvdTkwR1pHSEdGWW9ydlBW?=
 =?utf-8?B?K1h0emxxM3Z4THhmVWxFcmMyTEJaRFU3QnZMSTNrT0l6TU1iQzJkSEkvUkpr?=
 =?utf-8?B?eng1OS9aS20raWpxaGFMYmlqZnhTd002THplMjUyL3NEMHdTUU5VemtsRVVN?=
 =?utf-8?B?K2RBMmxrR2drdVpnekR6aXFuMUtEOGNuUUd2YVU4TlRQZmJXb3MyYjFHZkZF?=
 =?utf-8?B?a1BxMXVteXRoSXlNb0k5U1RDVUt4MUpKcDhlbFUzYjVsNmpBVkh6SjlseGl5?=
 =?utf-8?B?ZzFjZWJiVStVVGlkamxvTXpvc1VMN0twck5VQnJ3R1k1ZEo2WEQ4MzRtRkhE?=
 =?utf-8?B?OEdWTXRzbTVxWkQvOXROZ1NRU2dGc245dnRKOGt1aFpHTFB2dHF2cVJDNHBp?=
 =?utf-8?B?TlRIMEIrN0RvQXE4TUZBdTA3QytRbzJFM0R2QzhSc1I4Tjc2cHZvV3V4eG5W?=
 =?utf-8?B?eTFyeVVUTHpsNHd4QXRyZjFhNUE2b3h4WEx2blltZ0pzb2xiRFlYNzQwZmFr?=
 =?utf-8?B?RlIwcHErVjZMUGhMQVFORklMZ21oeGVMRUdkR0dQV0ZheWZXclZwc3Z6Y21I?=
 =?utf-8?B?ajd3clhxSXB0N0pNZFR4cmM3S0krdys1ZWNuVk9YRU1PaDdUQmw1Z2dUMUN6?=
 =?utf-8?B?UlRxR2ZrWmhhT0dSbXE0UXpLQjRZdFJXVWNIRlhKQnF3S29jRFY2Z1BXNmNT?=
 =?utf-8?B?NllmUlQ2SDBIN3ZhcXpxVkVabmlxM3U0OFhpbGd2N291QjhvdmJybjhEYm5h?=
 =?utf-8?B?aW40SFlpUlVtNXZTZ1dVeFhsa05FM1dBTE5GSzlYSE12d3JJUlZkRTVoQ3Qr?=
 =?utf-8?B?eTFVaVJaWU5IRkxzTzQ3ang3UFRvRURrbW0zbDVvdERCMlY2S1Q5Z3lKdGhL?=
 =?utf-8?B?akYzMVpIRVgxbHh1VFQyWXozUWhjM0dRN1pkZjYwUnd6a2YwODlZWGlIL3BD?=
 =?utf-8?B?OFBFUHZteVJOUkFZaVk1RVNVQ05paWlvQ1hldWRQUXZLRUVtNWcvOUxVSTJN?=
 =?utf-8?B?RDkyZWtZTE9NYXJBVEdIOC9HdXpIbEYwaE8wOWMxZlJrT0pYNE5TdnMzcnYw?=
 =?utf-8?B?akREUWlDWUd0NFQ1VEhLSGQxNXgzR3EyS2l2YVVxb3NVb2hYcUw2L1dJd0Ir?=
 =?utf-8?Q?SRQ8xUrTl61FphqEwHeHqNZcN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab917493-2780-4aab-e164-08daa15f9e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 14:42:07.2390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwzgtuFJuzG9PmBARUurVLJkFLSZJNy/WwrUQS0mYG+g+TYuqMq4NQu36PQdsdvSgcv3/MU6RsBhV7qr+MiBsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7051
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWdyZWUgd2l0aCB5b3UuIFdpbGwgY2hhbmdlICYgc2VuZCB0aGUgcGF0Y2guDQoNClJlZ2FyZHMN
CkFydGh1cg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJlYW4gSHVv
IDxodW9iZWFuQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjgsIDIw
MjIgMTozNiBQTQ0KPiBUbzogQXJ0aHVyIFNpbWNoYWV2IDxBcnRodXIuU2ltY2hhZXZAd2RjLmNv
bT47DQo+IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOyBiZWFuaHVvQG1pY3Jvbi5jb20NCj4g
Q2M6IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBEYW5paWwgTHVuZXYNCj4gPGRsdW5ldkBjaHJvbWl1bS5vcmc+OyBBdnJpIEFsdG1hbiA8
QXZyaS5BbHRtYW5Ad2RjLmNvbT47IEF2aQ0KPiBTaGNoaXNsb3dza2kgPEF2aS5TaGNoaXNsb3dz
a2lAd2RjLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc2NzaTogdWZzLWJzZzogUmVtb3Zl
IHVmc19ic2dfZ2V0X3F1ZXJ5X2Rlc2Nfc2l6ZQ0KPiBmdW5jdGlvbg0KPiANCj4gQ0FVVElPTjog
VGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBXZXN0ZXJuIERpZ2l0YWwuIERv
IG5vdCBjbGljaw0KPiBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVj
b2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhhdA0KPiB0aGUgY29udGVudCBpcyBzYWZlLg0K
PiANCj4gDQo+IE9uIFdlZCwgMjAyMi0wOS0yOCBhdCAwODozMyArMDAwMCwgQXJ0aHVyIFNpbWNo
YWV2IHdyb3RlOg0KPiA+IEhpIEJlYW4NCj4gPg0KPiA+IEluIGNhc2UgeW91IGRvbid0IGhhdmUg
YW55IGNvbW1lbnRzIEkgd2lsbCBhcHByZWNpYXRlIGlmIHlvdSB3aWxsIGFkZA0KPiA+ICJyZXZp
ZXdlZCBieSIgdG8gdGhlIHBhdGNoLg0KPiA+DQo+ID4gUmVnYXJkcw0KPiA+IEFydGh1cg0KPiAN
Cj4gDQo+IEhpIEFydGh1ciwNCj4gDQo+IEknbSB0aGlua2luZyB3ZSBzaG91bGQgcmVtb3ZlIHRo
ZSBkZXNjIHNpemUgY2hlY2sgaW4gdWZzaGNkLmMgZW50aXJlbHkuDQo+IEp1c3QgcmVhZCBhbnkg
ZGVzY3JpcHRvciB3aXRoIGEgbWF4aW11bSBzaXplIG9mIFFVRVJZX0RFU0NfTUFYX1NJWkUgLg0K
PiBGb3IgdXNlciBzcGFjZSBxdWVyaWVzLCB1ZnNfYnNnIHJlYWRzIGRhdGEgb2YgdGhlIG1heGlt
dW0gbGVuZ3RoIGFuZA0KPiByZXR1cm5zIHRoZSByZXF1ZXN0ZWQgbGVuZ3RoIGRhdGEuIFRodXMg
Y2FuIGltcHJvdmUgY29kZSByZWFkYWJpbGl0eQ0KPiBhbmQgc2F2ZSBDUFUgY3ljbGVzLCBhbHNv
IGNhbiBmaXggeW91ciBjb25jZXJuLg0KPiANCj4gSSBkb24ndCBrbm93IGhvdyBhYm91dCBvdGhl
cnMnIG9waW5pb24/DQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IEJlYW4NCj4gDQo+IA0KDQo=
