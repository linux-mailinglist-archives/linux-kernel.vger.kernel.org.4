Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DCE70D2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjEWD6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjEWD6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:58:40 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9014799;
        Mon, 22 May 2023 20:58:38 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKliKq002068;
        Mon, 22 May 2023 20:58:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=NcWSyEkCAA+3TS4Dn+vH7YdBu2qbgPo4CCGMHQI8JnQ=;
 b=TbCiW3A4Euow1L4VLjUClpI2YWY+fUUYJCFyGkB8mnM1UKynLOJYrOtQCPCQuQQhr17l
 gVps2KV5IMpCFoO5yZ3yh4W6/5SDsgwK45CcO/aIA2tcy4IGhpAb6ShLW5LbinB0r5aX
 RfQNXh0br/0Q8pzc5vSGznyCnXzasmbNGCQclcqv9BgN88oJis7NmsqpI/wJDdK9Injr
 Li5J6yZz1MOFLVWeX1fMKrSjLjuin5a/iXbZfUtFpuNrhk9vI049kLBQFcZhbwPDRsbG
 u/tD753jk7h9yQbk/daiqd8KjhjZJ6QNvfjxwaZqmb2KggC+BmT6Gv/FBj7RjEvmfonw hg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qpvaf575u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 20:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMJvEPuk9jzvPes9rzG7KksX79J4H3Y0HCGeWzzrdPtHm0xBL43PhVWova5tZ19ytSj/Jut7pwKaZapOQRjJkF67zHxGLizME0etCZ2g0Wyu31YED81aVZihAEt8hwDZfcwrdXg3y5lfVit1CW/gwyPL7A/bMVDEKVM8jlDXbx6JeQ2P1yKOAA0TXN97vFKF7OsouskvfNCXWvUmfEBXxIpgHp+Z1BmHxjqpabN8KYBLfXnqTo1XOcGGr81YEv0kplCTguSkRi9V/yGg0z5hMc5vDTIk1GmMk8Xu/fyEna23kfAVwZxcvlpkql75+8xd9nnTikWrExUEfX0KrsbpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcWSyEkCAA+3TS4Dn+vH7YdBu2qbgPo4CCGMHQI8JnQ=;
 b=jc035oP8zt4BQDg2lLlwfZaG8YaHAQZqq3NuyTqdFIvID2N8rKyngQPEcljz0W+vysqhELpdknCx9zX3vFcrdj8H9XX2WEirVrT0uAHCOoXsnjrrMs+3Xfr5Dcjl6Rg5eCwVczcXloU/jYPGHuHGWCCaRRSWi/EKctEz1pD1ysr+eCwFyndRFoFSuFRezzeqJTMLE0LpZs5NavNXxcPO8fSekQDkS4EepDxJFWEyxKdpJXi6Ga0Rm8Em65SKcTwP26jgC4IRwVctt4zQF8td8NSUEGsi2yI9GEKGJ5LLVKDnJlAnkCPsIz3XlA3KB1esCZnviR4UZiz/Ncq2f6zRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcWSyEkCAA+3TS4Dn+vH7YdBu2qbgPo4CCGMHQI8JnQ=;
 b=EuMQLx5hnqyiML/kBoJM4ZEh6reKlJ0tRFNLhgqygMSqUz3UisLmbK6cO3EwIWxafsy09/OGh0MLyvYVU1oyO0XBDry2lmx0IC9vZ5VOL6aBITzUZyU74sEL3wrVkc9v/tKawu/VEzUv4O+w1PCYcW5FkMe+HsLVy96zP/51JNHF4ua2c20+NvGaztyHFqC8qlSOJWrVgvUTul5JCgyx5qouetrtDwFkeatkPPC281yx8GeP2tlZC5RNfI3IYXY9bQkTGXzbR0mjiBm+u6nyMFqUCIcYBb2zFabHY8QuDDCLKp/JKTOQAnBSJl4xf3zYPE45vSJgOvCK8jkU+1hFhQ==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SJ0PR02MB7199.namprd02.prod.outlook.com (2603:10b6:a03:294::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 03:58:30 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 03:58:30 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] audit: do not use exclusive wait in
 audit_receive()
Thread-Topic: [PATCH v2 5/5] audit: do not use exclusive wait in
 audit_receive()
Thread-Index: AQHZg8hzC3laSlFeP0CRyEYk44U9Aa9iILKAgAOn0wCAAYWIgA==
Date:   Tue, 23 May 2023 03:58:30 +0000
Message-ID: <F900B719-7760-4E22-82A2-933ED775AA19@nutanix.com>
References: <20230511052116.19452-6-eiichi.tsukata@nutanix.com>
 <e9edf9db340cbf753fce43772abdef4e.paul@paul-moore.com>
 <CB4B209E-8931-4FEC-A967-F3D50C0D7B1C@nutanix.com>
In-Reply-To: <CB4B209E-8931-4FEC-A967-F3D50C0D7B1C@nutanix.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|SJ0PR02MB7199:EE_
x-ms-office365-filtering-correlation-id: ee533b70-d49e-4986-8465-08db5b41f868
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EC5uMjekqC/jvX7ztfiH+Xs+2jzN2sjFpslNdNJfNK+SahUBkCoUJ0+IMUX8AyZIC/6hNUvG7rixzXvRxfrbYE+oOz7hqzOXL6C02bkppbtCHtwIts5hKuJSByXFzf2EdJFUzxY+KJyzbpBBb4/qeOJMenoAYise8L+gM7dISxtJbyWP9qyy2qfLjM70RQMmLcJG1I+DByY9uha4yMcrlba05D629WF+91XduJyA/DGIEwSVyFgm5NWhwMnToF8ms/pQhpV/OzgZ033MmEco8+8uyqODNKL6ek1oN/KekSax3gy6WqHln8sZ5E1LcZqLyxmpAfoamMr9Ifiu/MfDmYezHnMyG8qRthRJ6B7dmdjubnH6t5Vx/XyXjULrXRYvCevpCw7sOQG67o6gD3vKLzKnVrsFqupy73+dQt+B7Fj4YvsbsiM61wzvgqmw/gBmktPQcNg3672Y3vU/70LffE4VAil3CmhOLkHKAfjLpAsAS8ICkkzsO3TpUNfH7po11Ej3avA+n7hdtXKPnsaUGP39gqQd3AlHQkzSHEPPz7bAlpUNPMUyKt9CxVWW+h7/583xh2sFo8g9i3nSp4l10UuM34p2sRn1HE+mkiaPq89lmG93UyhbqeSgbcAF/EP0oaAUGpL5KK0ghXyhEBoPFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(5660300002)(6506007)(8676002)(54906003)(8936002)(44832011)(33656002)(316002)(6916009)(4326008)(26005)(186003)(36756003)(64756008)(66946007)(76116006)(66446008)(66556008)(66476007)(91956017)(41300700001)(122000001)(53546011)(6512007)(71200400001)(38070700005)(6486002)(83380400001)(38100700002)(86362001)(2616005)(478600001)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1d5WWNCaC9VVW9FdUxKSCtiY1JMMS92bk5MMnlHdzlWU3l4Y3k5YnYyMEd6?=
 =?utf-8?B?WlQ4eVlEZExDQzEzWVlJT0MwZzdtV2hURkZFTnZpREk5YklaTFhQdHNrL01R?=
 =?utf-8?B?RzNlVXNYekZmenNwRVJrM0YxQzRMdWVCeityelJoZUNSZ1l5ZTl2KzJIMkI0?=
 =?utf-8?B?UEUweUt1TVNVL0dhSE4zaVhzd0MvYkV5cXkxZThoay9QaEE2QllzNmdsZDl4?=
 =?utf-8?B?ZGhvQk54YUw3dmhVdURXNHdEajFUME1wTklaRytmWThWZDNlSG9XQXU0dUZz?=
 =?utf-8?B?RVc5TFpQRXh5SHpIYmttSGJiem9LS0IyU05vVVNzY2R6QU9aR1EyU2RCTXFw?=
 =?utf-8?B?QURwdnRWeVIxRzkzeWV6MDF0UmgxaFhYeFVRTmlmc2o4QUc2WDNqSnYzV1JD?=
 =?utf-8?B?V3hpM3QrVHlvMGpnbGJiaHN2S290RFBheHFNMHYvZzI4VnQ2WE5zR3c4c0VC?=
 =?utf-8?B?cGVoTHRaYlFQamVFdlhoZlNkVHZ2aFZJWnpvWmphQWNZNmc2UzNkQ1pZYlVt?=
 =?utf-8?B?ZkpTeXJrTVhWWjltNlBGcit0cG1zVTY3bFlySDZWcUF1QTRycnBsenBLcFQ5?=
 =?utf-8?B?d2VhYnhRSmtYVUNncVBUREt6b252Yjgva2RJTEpuaWhtWloyWTd4RzdkSjZ0?=
 =?utf-8?B?citqZmRkbWNMOVlxaEMrT3hMMWt2SC94K29MWE9POS9RbE9DVVhYMHBnL0hT?=
 =?utf-8?B?TlZ3bnRRTkEyODlxRG55RjJvS2Y4UGNnQzNDNEN2aDgvdjBwam5uV1o3ODg2?=
 =?utf-8?B?ZDJPZ2VSby81V2ZoQWNUdTBBdlRTQlJLUWFCQzQvUEp3SE9qRjVYTHMwcmdk?=
 =?utf-8?B?Z1llUDhITy9TanJ2YjgwR0taelpwZk8yL2xTdmJoZDBtMXBhNFVScS9COGlk?=
 =?utf-8?B?cVg0QnNjWUZxUDF1Zk8wK2hOQ1ZHN2VvZXdpY1VYMDRaK3pab1MzQUk0UjRT?=
 =?utf-8?B?MC80ekpLdXkxZGVJT1kwa2pENjliOGZjNmFmNkRLRWM4VVFTMW5PYitQRGNI?=
 =?utf-8?B?UHdydGRxR3FWUElwTXNUVitoemJvVzdrTHQrTGgrRno5QnFJY1lKcHdLeHMy?=
 =?utf-8?B?eWFBWkN2S20wT0w5L0g1VjJ2andsSERTbDhWZWFMRHIxSjQyS0pXWkNacjF1?=
 =?utf-8?B?WjJqbytwRzNpWENVbFZWUkxqREhzWTdySTJCeTh5M3dtV1UzZUR2VktuVUND?=
 =?utf-8?B?NjZLcXRjcWhYaitVNmhOZHR1eGhMUlBvU1BicURrRnJIYXdBU2lvazI0RVBj?=
 =?utf-8?B?OW0ybC85L3UrUjNwZUx2N2xWZlBLTG1NaE5mcnlmTnVZbFgwUnYzOXhnK2Y4?=
 =?utf-8?B?YTNsSHpKRU4vMytoRlJucENUbFpzTi9QNVlWSWNoNENqcE1LRDVmcHRsd09R?=
 =?utf-8?B?RlNlblc5NVNMOWRYUjFWK1BVWmhrYytwMGl3LzFtbUY0S1FhRXh0MGd0ZW1O?=
 =?utf-8?B?Mm4zbkN1dURaWVRKelQwTlJZVitQWllvR0llZ05HU2xpOHAxczdETFcxSUdQ?=
 =?utf-8?B?TjJ1UlI5RzJPRkhyWXE0RTBHbGVydGtleFVneTArcmlIMG00eHBQd3dBVmR2?=
 =?utf-8?B?N1AvZXFEL0RWTU1Oanl5MUUra3lrYXRtdjFEZHpQend4TGtUYitvdGVYWVVn?=
 =?utf-8?B?RHBvOWtiby9JY29vc0hXYm5GeTNEcmhUS3RSQjlSeER6N0tBd1MwTTYxZVl5?=
 =?utf-8?B?SG45d2JUckpmdXZxa1JXTDl3Y1hzbnVnRHFFTUVlQWxBM2l3TkVIQkErWVlW?=
 =?utf-8?B?YldTRXE5by9qRndPemR5NlBOdkk5VVFVS0Flc00zdFBQT0JWWkQ0c3FUTU1k?=
 =?utf-8?B?OWsrNWIxbG9sSHhiSys5Vy82QjU3WXU5a1lVZktLbCtPMmx5enVMdUxRaFdE?=
 =?utf-8?B?SFVqanp5TURlamJzRzZrcEgzQmx2NVpiSWROVXErWHh3OWtPVlJKTm9JV0Nm?=
 =?utf-8?B?NFJzNjdZaDF3SHRjVzRiRW9DNGtTRHZHei9UeWN5ek95eXlEUUpFQzRzSUlD?=
 =?utf-8?B?dzBkMytkTzA2Tldtd21LVUszUkEwcEJxZ1VkbnBLaDI1UUVUc2FwWEk2YlFl?=
 =?utf-8?B?U1VGSmVIYktzcjBaeXM1eFhaT3hRMFpMRy95bHdITTAzY0tOL3ZPeE5tbjlZ?=
 =?utf-8?B?RXVjSzhOeXV3ZVkyb2VodGNWL0p6cC9SQ2hNTmxZbUROZDRkT05JdGcyTTYz?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D472E705F8E572418D4EF7E3BB6662C0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee533b70-d49e-4986-8465-08db5b41f868
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 03:58:30.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOc1byPyB/Ws2uBPy1MbR+Mlr2218ij1jDteSMNV4S1K0df3YX36cC82QoSDYKaZB74PU65L7mKuLttD9L9guYp5OsVvbqDcIzBl546i6jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7199
X-Proofpoint-GUID: bbYYxUhfsiKBPGb4ysShlVuB1TajS_ft
X-Proofpoint-ORIG-GUID: bbYYxUhfsiKBPGb4ysShlVuB1TajS_ft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_01,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWF5IDIyLCAyMDIzLCBhdCAxMzo0NCwgRWlpY2hpIFRzdWthdGEgPGVpaWNoaS50
c3VrYXRhQG51dGFuaXguY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIE1heSAyMCwgMjAy
MywgYXQgNTo1NCwgUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4gd3JvdGU6DQo+PiAN
Cj4+IE9uIE1heSAxMSwgMjAyMyBFaWljaGkgVHN1a2F0YSA8ZWlpY2hpLnRzdWthdGFAbnV0YW5p
eC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IGthdWRpdGQgdGhyZWFkIGlzc3VlcyB3YWtlX3VwKCkg
YmVmb3JlIGl0IGdvZXMgdG8gc2xlZXAuIFRoZSB3YWtlX3VwKCkNCj4+PiBjYWxsIHdha2VzIHVw
IG9ubHkgb25lIHByb2Nlc3MgYXMgd2FpdGVyIHNpZGUgdXNlcyBleGNsdXNpdmUgd2FpdC4NCj4+
PiBUaGlzIGNhbiBiZSBwcm9ibGVtYXRpYyB3aGVuIHRoZXJlIGFyZSBtdWx0aXBsZSBwcm9jZXNz
ZXMgKG9uZSBpcyBpbg0KPj4+IGF1ZGl0X3JlY2VpdmUoKSBhbmQgb3RoZXJzIGFyZSBpbiBhdWRp
dF9sb2dfc3RhcnQoKSkgd2FpdGluZyBvbg0KPj4+IGF1ZGl0X2JhY2tsb2dfd2FpdCBxdWV1ZS4N
Cj4+PiANCj4+PiBGb3IgZXhhbXBsZSwgaWYgdGhlcmUgYXJlIHR3byBwcm9jZXNzZXMgd2FpdGlu
ZzoNCj4+PiANCj4+PiBQcm9jZXNzIChBKTogaW4gYXVkaXRfcmVjZWl2ZSgpDQo+Pj4gUHJvY2Vz
cyAoQik6IGluIGF1ZGl0X2xvZ19zdGFydCgpDQo+Pj4gDQo+Pj4gQW5kIChBKSBpcyBhdCB0aGUg
aGVhZCBvZiB0aGUgd2FpdCBxdWV1ZS4gVGhlbiBrYXVkaXRkJ3Mgd2FrZV91cCgpIG9ubHkNCj4+
PiB3YWtlcyB1cCAoQSkgbGVhdmluZyAoQikgYXMgaXQgaXMgZXZlbiBpZiBAYXVkaXRfcXVldWUg
aXMgZHJhaW5lZC4gQXMgYQ0KPj4+IHJlc3VsdCwgKEIpIGNhbiBiZSBibG9ja2VkIGZvciB1cCB0
byBiYWNrbG9nX3dhaXRfdGltZS4NCj4+PiANCj4+PiBUbyBwcmV2ZW50IHRoZSBpc3N1ZSwgdXNl
IG5vbi1leGNsdXNpdmUgd2FpdCBpbiBhdWRpdF9yZWNlaXZlKCkgc28gdGhhdA0KPj4+IGthdWRp
dGQgY2FuIHdha2UgdXAgYWxsIHdhaXRlcnMgaW4gYXVkaXRfcmVjZWl2ZSgpLg0KPj4+IA0KPj4+
IEZpeGVzOiA4ZjExMGY1MzA2MzUgKCJhdWRpdDogZW5zdXJlIHVzZXJzcGFjZSBpcyBwZW5hbGl6
ZWQgdGhlIHNhbWUgYXMgdGhlIGtlcm5lbCB3aGVuIHVuZGVyIHByZXNzdXJlIikNCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBFaWljaGkgVHN1a2F0YSA8ZWlpY2hpLnRzdWthdGFAbnV0YW5peC5jb20+DQo+
Pj4gLS0tDQo+Pj4ga2VybmVsL2F1ZGl0LmMgfCAxNyArKysrKysrKysrKy0tLS0tLQ0KPj4+IDEg
ZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBU
aGlzIHdhcyBhbHNvIGRpc2N1c3NlZCBpbiB0aGUgbGFzdCBwYXRjaHNldC4NCj4+IA0KPj4gDQo+
IA0KPiBUaGlzIGJ1ZyBpcyBtdWNoIGVhc2lseSByZXByb2R1Y2libGUgb24gcmVhbCBlbnZpcm9u
bWVudHMgYW5kIGNhbiBjYXVzZSBwcm9ibGVtYXRpYw0KPiB1c2VyIHNwYWNlIGZhaWx1cmUgbGlr
ZSBTU0ggY29ubmVjdGlvbiB0aW1lb3V0Lg0KPiBMZXTigJlzIG5vdCBrZWVwIHRoZSBidWcgdW5m
aXhlZC4NCj4gKE9mIGNvdXJzZSB3ZeKAmXZlIGFscmVhZHkgY2FyZWZ1bGx5IHR1bmVkIGF1ZGl0
IHJlbGF0ZWQgcGFyYW1zIGFuZCB1c2VyIHNwYWNlIGF1ZGl0ZCBjb25maWcgc28gdGhhdCBvdXIg
cHJvZHVjdCB3b27igJl0IGhpdCBiYWNrbG9nIGZ1bGwuKQ0KPiANCj4gT3RoZXIgaWRlYXMgaW4g
bXkgbWluZHMgYXJlOg0KPiANCj4gKDEpIFVzZSBkaWZmZXJlbnQgd2FpdCBxdWV1ZXMgaW4gYXVk
aXRfcmVjZWl2ZSgpIGFuZCBhdWRpdF9sb2dfc3RhcnQoKSB0byBndWFyYW50ZWUga2F1dGlkIA0K
PiAgd2FrZV91cCgpIHRyaWVzIHRvIHdha2UgdXAgYSB3YWl0ZXIgaW4gYXVkaXRfbG9nX3N0YXJ0
KCkuDQo+IA0KPiAoMikgUGVyaW9kaWNhbGx5IChzYXkgaW4gZXZlcnkgMSBzZWMpIGNoZWNrIGlm
IEBhdWRpdF9xdWV1ZSBpcyBmdWxsIGluIGF1ZGl0X3JlY2VpdmUoKSB0byBwcmV2ZW50IA0KPiAg
YXVkaXRfcmVjZWl2ZSgpIGZyb20gdW5uZWNlc3NhcmlseSB3YWl0aW5nIGZvciBzbyBsb25nIHRp
bWUuIA0KPiANCj4gQlRXLCB0aGUgZGVmYXVsdCBiYWNrbG9nX3dhaXRfdGltZSBpcyA2MCAqIEha
IHdoaWNoIHNlZW1zIHByZXR0eSBsYXJnZS4NCj4gSeKAmWQgYXBwcmVjaWF0ZSBpZiB5b3UgY291
bGQgdGVsbCBtZSB0aGUgcmVhc29uIGJlaGluZCB0aGF0IHZhbHVlLg0KPiANCj4gRWlpY2hpDQoN
CkkgY2FtZSB1cCB3aXRoIGEgYmV0dGVyIGlkZWE6DQoNCigzKSBNb3ZlIHdhaXRfZm9yX2thdWRp
dGQoKSBpbiBhdWRpdF9yZWNlaXZlKCkgKmJlZm9yZSogYXVkaXRfY3RsX2xvY2soKSANCiBhbmQg
cmVzdHJpY3QgcGVuYWx0eSBvbmx5IGZvciBtc2dfdHlwZSB3aGljaCBjYW4gcXVldWUgYSBuZXcg
YXVkaXQgcmVjb3JkLiAoQVVESVRfVVNFUiwgQVVESVRfVFJJTSwgQVVESVRfTUFLRV9FUVVJViwg
Li4pDQoNCk9yaWdpbmFsbHksIGl04oCZcyBub3QgcmVhc29uYWJsZSB0byBnaXZlIHBlbmFsdHkg
Zm9yIGlubm9jZW50IG9wZXJhdGlvbg0KbGlrZSBBVURJVF9HRVQuDQpUaGlzIGFwcHJvYWNoIG1h
a2VzIHN1Y2Nlc3NpdmUgYXVkaXRfbG9nX2VuZCgpIHdha2UgdXAga2F1ZGl0ZC4NCkFsc28gaXQg
cHJldmVudHMgYXVkaXRfbG9nX2VuZCgpIGZyb20gcXVldWVpbmcgc2tiIGlnbm9yaW5nIGJhY2ts
b2dfbGltaXQuDQoNCkVpaWNoaSANCg0K
