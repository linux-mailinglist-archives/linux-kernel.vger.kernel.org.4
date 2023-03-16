Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421596BC6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCPHVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCPHVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:21:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2063.outbound.protection.outlook.com [40.107.114.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA39740E7;
        Thu, 16 Mar 2023 00:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUtxQ00G5VHM4+8wLe4De7vPmK7J43aEljLXZMy30aIeXGNZBSKXVYC36PusZgmdn8G+yN8BNe4lVcQjhUd9XcLu4wax3o0NSHLIo3ojZGULdWLMwktvmr1xQZ6HxzEC7wGU1rjkpVYB0M5nrJQrCg4wINIzqy5qmaFYwi7+n8F5s6p7jyIXUfQcETuDvrJBYlCm0dcoVGuY2kgpUGb9hKjwmWwRs9j08KRsPJVzUxZZpFhkc/1KVoP9Urbzw3M11628Rl/XCUnwEhz1V3+tnVRYPxoFcGGqsV8QgN1uaPU3rJ8J+zF0AayoCKVkueWW6vQGQyN8cg6fBEGBBRa4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQR9Q6q46WQK9vGzZOuZezv67W3uEUZ1OJA3+p5t+rE=;
 b=njzmnDx09kraH8gMRxlA8faslnUsihwMSXTG5YSvbvwfIjKgTwFY4Kr5t7cLltFwMdohZmdrqGhrfkUggf2eR170ZrXO2SWB6+/1C02NWgYJKHrHsPp8na7eoZ3GdIBuAo1TxjkaifltLE2EOg1eV1njDH7f6r0DLsE0rOkFoqlQTbwoCRbDGyccw8GKuo1SwUy+B7inxncwT0phc+4RGVyQIq7kufjSyopUqodqe9XfMVJrkutL39FcLXGdJb5X3uRdjZhTQzjGk7EfNK0C4rD/fsk/aNIFTiifySIjh85lAmkPFoDnAm4fNd7/+Oy+Mh69YImAWD8SJjAgqM9eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQR9Q6q46WQK9vGzZOuZezv67W3uEUZ1OJA3+p5t+rE=;
 b=RgWESLqEoEsdSSFs2g3wXC2lydEDXjdye+9v1dyfohlwHVx18lazZWhhsnTP2OC/3FSh/ZJYpHPN2lzoLXeZJOaPidFvGJTnZmTU37C2ISNFAHNJa8BtfSHZcC8qucDyZ8+7NDNjunWJI/0oX536jSdqamYGJ+dBFT2NHg99KyQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB11968.jpnprd01.prod.outlook.com (2603:1096:400:405::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30; Thu, 16 Mar
 2023 07:21:16 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0%9]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 07:21:16 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "lvying6@huawei.com" <lvying6@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cuibixuan@linux.alibaba.com" <cuibixuan@linux.alibaba.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
Thread-Topic: [PATCH v2 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
Thread-Index: AQHZSmjZ5IFv2Y0IgUO3jKYnw2jrJ679GsOA
Date:   Thu, 16 Mar 2023 07:21:16 +0000
Message-ID: <20230316072031.GA354196@hori.linux.bs1.fc.nec.co.jp>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230227050315.5670-2-xueshuai@linux.alibaba.com>
In-Reply-To: <20230227050315.5670-2-xueshuai@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TY3PR01MB11968:EE_
x-ms-office365-filtering-correlation-id: 61ba2ebd-642a-44dc-c391-08db25ef07d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v40rVGCi6Efaql275P6LII6U6HZCrFVqsOZXTibAhXJ4XPE4Veeylxql7AzTJJICT4XObWNTLtX/GrJadT3vDED8172Xx2cui4FZHU8kpPDfxGrnqoVC3DMOfrdHni4DvM4SBlCmOfTAJb/hv1gfaDHTJKDhRwbnTEW5vCjfD6Al7NfvpLgMyJZYbIbFQXx8pCK3TjkdEhkqqidOarIYIf/zL7XEE+GBbfswJo8RxrpTHyOB9ijLICFYAoaZHy0SOfbgOG1x9HaYdOVtE2Tn+w3pv4EwDyS9/Xkf2abF1qme0j4/8Iab7q0TLQgY9FehS+3nqzjZmefcwLidf7T12OX7Vp4mbgjC9ikxWUpphbEuZW7ERJ0dkUQJBl7wIo6qI208yZtqhU2LCsnqOPV5Dt1MmwqQyuGh+wVWpFgQic3jhuymqbt6ZuELXwoK/Ri5jqxCYV2TrOnFbxWR5MGNGfq4HlBaTG0KfH3ISwHmILnMRev2uqjEmTX8eBW8ynm6iuctlWcMkgCU8SE2vKAdgBYWXs0uLtjJXBMcjn542I/byv7hOZ9utcq9/a0HQcV0FvEKFROIafh97bjsE2uQqyWOkAm2ia1YqEhXfFIduMigkHHwrG+sg0BT89eJzXxHL8OGK/bM94qrZ3DuLca4DsLwb7AYfFIc/Ij/hrbP4oDE1iq8UmygKjUV866ydzb0E8smFbTsMWkXyEH8KoUFuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199018)(85182001)(38070700005)(82960400001)(86362001)(33656002)(122000001)(38100700002)(2906002)(41300700001)(7416002)(8936002)(5660300002)(66556008)(9686003)(6506007)(26005)(6512007)(1076003)(186003)(4326008)(316002)(83380400001)(54906003)(66946007)(64756008)(8676002)(76116006)(6486002)(478600001)(66446008)(71200400001)(66476007)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXloVTZ6QW05emgwOFNjd2V2d0ZBUS96QnlldFRPVDA2TlhISldXTDBrcmlt?=
 =?utf-8?B?YWRIdjM1TnhzaVVKTG8xdzR1VTUzaXorWEJUcFpXRkpQWEFKcW9lSlVOelkv?=
 =?utf-8?B?Q3l2OWtVSzRBYlNWQWh0UU5Db3NLWXFodVluZk5YWStBWlJQSUhQdmlvSCtj?=
 =?utf-8?B?YWtybElNTUNGNlRoZjM1NjYxQmR4WTVIVHdIKzdkMWhqcHVBaEZBN0U4RUh1?=
 =?utf-8?B?ODRsazJnK3JkRTBUc1c0bGIzM0h6OUhFWUw5OTE4ZmdtK0lDSmd4cTMwT2Qy?=
 =?utf-8?B?dWdmUGh3QTZHSS95SVJXQ3VEdG1PYXRCREsvdGFOcnMwb2RZcmVwVjBmWDh3?=
 =?utf-8?B?R1dSUWFFNDlPaUVvcEdEbE9sLzk4cktOamQva21uZ3EzSWkzNFZrOFhoVG01?=
 =?utf-8?B?VVJOdTFtMnR3ZHE2VnROdmRzSjF2VlhTNGlHb1hza2JoTGdEN2VUeWg1NUZZ?=
 =?utf-8?B?V0FPUjNySmVackNuR3RYemk3YUNxcTdnU1pia0IwZ0R0VEFDQytyZFNQS2U5?=
 =?utf-8?B?S1gydzBOV0ZjYS9BNWNnUmpyYWhXSTFBenhBNEw4V2tDR0FtL3hzUzBYVlBS?=
 =?utf-8?B?dmVWSTMraitQTzkyY29abmM2WVRiQkYzVzhhUWNSOHQ5ZnFqKzIwbHhTS0s2?=
 =?utf-8?B?S3JNOTR4cnBhY09tOHM4VC8wRFU1TnVIclcwaW1yZ2xJSzVUSGFRby9YZFRt?=
 =?utf-8?B?eGRtTHF3bVJxWVM2Y0ZMOHo5aTh0cmdSZDJ4S1JHcGxhTTRFekttN2p3SU1Z?=
 =?utf-8?B?aXUvQWxybDJvTWRJUzlmaldIdlFTMVpsN0RGbHhKMytSQ3Z4dW10RGwzNFdL?=
 =?utf-8?B?NW1OamN3dGx2ZU5XeDhOZ01BNTVRMFBwSjVjNDlHTThaTVBqVzloQXFld1dH?=
 =?utf-8?B?NDVtL0FBNXdGL0VuOGdqS2FpZEEyMVhjVGhyM083M0NZRldzcDVpMVF2cTlJ?=
 =?utf-8?B?Qkw5VWw0WDNVcVBRbDd1VStacVJmYkJkcDRnaWsrdHhQNGRGenNESUJsZis2?=
 =?utf-8?B?dXRmTXpEVGVmRnFVcCtmR3hjN1AxK1lOTUc0cTNLVldwYXNYUDJNcU1Fc3Yr?=
 =?utf-8?B?eDJBQnNuNitCczlSdG90blhoNDgyRXUrK3ZLZHBEQjB2RGxkaFBGMVFQMjJu?=
 =?utf-8?B?MWRZbFRYRjNVK1RRSTVyblpvWjdOUnBRUTFEb0FrOFFxNUdycG5iUnlDOVBx?=
 =?utf-8?B?djN2dlNPUlIrUVQ2YThFbE5YU1dRWmIyT2hZNktKdm9sTHJQbEtoUmVzWlND?=
 =?utf-8?B?SGRReEdBQlBPZUxMNUN3Ky8xNXZENlA4Y1A5MzRQMFFFR0gzSDJ2dldaMTg2?=
 =?utf-8?B?VEdhK2pJaTZGc1BjcTFHbUJDaHF5YWVVa2pMSHduRW9UZlozWkJvbDExaVdp?=
 =?utf-8?B?bElVSUtLb2ZyRlZkSmg2UnNoYmVLeXllWlZCcWt1cWxGZWg4TGZqMVZMQkx0?=
 =?utf-8?B?UnFkbCtyN25sdkZsNHZlSXdqYUxpZ2xyMHg3eDdLZThnQ0x5TTJvSE9XK054?=
 =?utf-8?B?YmNMZUdBak5QbStha0M2MS9EV1hlWmZmSURqUlpLL1c5aFhhUHdxUnJwb0kr?=
 =?utf-8?B?UzZsdWVmRVpNY2M4RTVFbm1RMG53dWxDcFM4RGJzcVBLV3dsVkhmd1dLTjZs?=
 =?utf-8?B?bk42SGNianIybmUyY2dZYmRRU01JTHRTNVdWcE4rcGVVQUlCcHl3NDZ0RWFh?=
 =?utf-8?B?UEdndmszVXFwMTJWQ2Z6NG5zMDRDc2NDeTYrUjhVWlJSZFdSR1g4QWk2SDhD?=
 =?utf-8?B?S0dyTUdhVC9panU0WDBZZWlRMHlDZUZWMkJZWmVucVIxRkVsdm8yQW1lek1m?=
 =?utf-8?B?RXJQWU5YRGJWM3dKZE5DeCtWaGRLT3dzSEt4TW45TzRRSzBLeFVJWWFGdldF?=
 =?utf-8?B?SjU0bkJqTUNKcFhGUlg2bkY1NWtFWDZTdXVSWkJCTWgzM0l1UWxaNlNOQVFR?=
 =?utf-8?B?amtDY0VLbnpES2dka2hXSUFva2JGeTlpS0UzMUVEbjhHdkU3WXNpOG5tYmR5?=
 =?utf-8?B?OXA4K2F1ajBhanFkMlB0SlNwNGE0ZGIvTFZzQ3FkZFJlN2w5bnV3UUpkTitG?=
 =?utf-8?B?OVFOelJkbVR1Y0d4N3I0Q2FTa1dsVlRZYnIveGwvYU9lYmt2MVJRTnVjM05V?=
 =?utf-8?B?STkrbGU2TG0xdUN6aTNybkpNMUxTVS8wWDhLWlo2ZUZlMlEwQUhnaFVNQ1Mr?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4B642B6EB74B04B9F69E0A97E327B1C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ba2ebd-642a-44dc-c391-08db25ef07d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:21:16.1565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qlmQNXHNj6SaLtpKO/mTFXQGmgRlqYo2tR0aJzRBkAjYQB9YkzYcRQL8lt9qz/A3Tzo5FM7Ri9n0BNIPoZznw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMjcsIDIwMjMgYXQgMDE6MDM6MTRQTSArMDgwMCwgU2h1YWkgWHVlIHdyb3Rl
Og0KPiBUaGVyZSBhcmUgdHdvIG1ham9yIHR5cGVzIG9mIHVuY29ycmVjdGVkIHJlY292ZXJhYmxl
IChVQ1IpIGVycm9ycyA6DQo+IA0KPiAtIEFjdGlvbiBSZXF1aXJlZCAoQVIpOiBUaGUgZXJyb3Ig
aXMgZGV0ZWN0ZWQgYW5kIHRoZSBwcm9jZXNzb3IgYWxyZWFkeQ0KPiAgIGNvbnN1bWVzIHRoZSBt
ZW1vcnkuIE9TIHJlcXVpcmVzIHRvIHRha2UgYWN0aW9uIChmb3IgZXhhbXBsZSwgb2ZmbGluZQ0K
PiAgIGZhaWx1cmUgcGFnZS9raWxsIGZhaWx1cmUgdGhyZWFkKSB0byByZWNvdmVyIHRoaXMgdW5j
b3JyZWN0YWJsZSBlcnJvci4NCj4gDQo+IC0gQWN0aW9uIE9wdGlvbmFsIChBTyk6IFRoZSBlcnJv
ciBpcyBkZXRlY3RlZCBvdXQgb2YgcHJvY2Vzc29yIGV4ZWN1dGlvbg0KPiAgIGNvbnRleHQuIFNv
bWUgZGF0YSBpbiB0aGUgbWVtb3J5IGFyZSBjb3JydXB0ZWQuIEJ1dCB0aGUgZGF0YSBoYXZlIG5v
dA0KPiAgIGJlZW4gY29uc3VtZWQuIE9TIGlzIG9wdGlvbmFsIHRvIHRha2UgYWN0aW9uIHRvIHJl
Y292ZXIgdGhpcw0KPiAgIHVuY29ycmVjdGFibGUgZXJyb3IuDQo+IA0KPiBUaGUgZXNzZW50aWFs
IGRpZmZlcmVuY2UgYmV0d2VlbiBBUiBhbmQgQU8gZXJyb3JzIGlzIHRoYXQgQVIgaXMgYQ0KPiBz
eW5jaHJvbm91cyBldmVudCwgd2hpbGUgQU8gaXMgYW4gYXN5bmNocm9ub3VzIGV2ZW50LiBUaGUg
aGFyZHdhcmUgd2lsbA0KPiBzaWduYWwgYSBzeW5jaHJvbm91cyBleGNlcHRpb24gKE1hY2hpbmUg
Q2hlY2sgRXhjZXB0aW9uIG9uIFg4NiBhbmQNCj4gU3luY2hyb25vdXMgRXh0ZXJuYWwgQWJvcnQg
b24gQXJtNjQpIHdoZW4gYW4gZXJyb3IgaXMgZGV0ZWN0ZWQgYW5kIHRoZQ0KPiBtZW1vcnkgYWNj
ZXNzIGhhcyBiZWVuIGFyY2hpdGVjdHVyYWxseSBleGVjdXRlZC4NCj4gDQo+IFdoZW4gQVBFSSBm
aXJtd2FyZSBmaXJzdCBpcyBlbmFibGVkLCBhIHBsYXRmb3JtIG1heSBkZXNjcmliZSBvbmUgZXJy
b3INCj4gc291cmNlIGZvciB0aGUgaGFuZGxpbmcgb2Ygc3luY2hyb25vdXMgZXJyb3JzIChlLmcu
IE1DRSBvciBTRUEgbm90aWZpY2F0aW9uDQo+ICksIG9yIGZvciBoYW5kbGluZyBhc3luY2hyb25v
dXMgZXJyb3JzIChlLmcuIFNDSSBvciBFeHRlcm5hbCBJbnRlcnJ1cHQNCj4gbm90aWZpY2F0aW9u
KS4gSW4gb3RoZXIgd29yZHMsIHdlIGNhbiBkaXN0aW5ndWlzaCBzeW5jaHJvbm91cyBlcnJvcnMg
YnkNCj4gQVBFSSBub3RpZmljYXRpb24uIEZvciBBUiBlcnJvcnMsIGtlcm5lbCB3aWxsIGtpbGwg
Y3VycmVudCBwcm9jZXNzDQo+IGFjY2Vzc2luZyB0aGUgcG9pc29uZWQgcGFnZSBieSBzZW5kaW5n
IFNJR0JVUyB3aXRoIEJVU19NQ0VFUlJfQVIuIEluDQo+IGFkZGl0aW9uLCBmb3IgQU8gZXJyb3Jz
LCBrZXJuZWwgd2lsbCBub3RpZnkgdGhlIHByb2Nlc3Mgd2hvIG93bnMgdGhlDQo+IHBvaXNvbmVk
IHBhZ2UgYnkgc2VuZGluZyBTSUdCVVMgd2l0aCBCVVNfTUNFRVJSX0FPIGluIGVhcmx5IGtpbGwg
bW9kZS4NCj4gSG93ZXZlciwgdGhlIEdIRVMgZHJpdmVyIGFsd2F5cyBzZXRzIG1mX2ZsYWdzIHRv
IDAgc28gdGhhdCBhbGwgVUNSIGVycm9ycw0KPiBhcmUgaGFuZGxlZCBhcyBBTyBlcnJvcnMgaW4g
bWVtb3J5IGZhaWx1cmUuDQo+IA0KPiBUbyB0aGlzIGVuZCwgc2V0IG1lbW9yeSBmYWlsdXJlIGZs
YWdzIGFzIE1GX0FDVElPTl9SRVFVSVJFRCBvbiBzeW5jaHJvbm91cw0KPiBldmVudHMuDQo+IA0K
PiBGaXhlczogYmE2MWNhNGFhYjQ3ICgiQUNQSSwgQVBFSSwgR0hFUzogQWRkIGhhcmR3YXJlIG1l
bW9yeSBlcnJvciByZWNvdmVyeSBzdXBwb3J0IiknDQo+IFNpZ25lZC1vZmYtYnk6IFNodWFpIFh1
ZSA8eHVlc2h1YWlAbGludXguYWxpYmFiYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9hY3BpL2Fw
ZWkvZ2hlcy5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jIGIvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jDQo+
IGluZGV4IDM0YWQwNzFhNjRlOS4uNWQzN2ZiNGJjYTY3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2FjcGkvYXBlaS9naGVzLmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jDQo+IEBA
IC0xMDEsNiArMTAxLDE5IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19oZXN0X3R5cGVfZ2VuZXJp
Y192MihzdHJ1Y3QgZ2hlcyAqZ2hlcykNCj4gIAlyZXR1cm4gZ2hlcy0+Z2VuZXJpYy0+aGVhZGVy
LnR5cGUgPT0gQUNQSV9IRVNUX1RZUEVfR0VORVJJQ19FUlJPUl9WMjsNCj4gIH0NCj4gIA0KPiAr
LyoNCj4gKyAqIEEgcGxhdGZvcm0gbWF5IGRlc2NyaWJlIG9uZSBlcnJvciBzb3VyY2UgZm9yIHRo
ZSBoYW5kbGluZyBvZiBzeW5jaHJvbm91cw0KPiArICogZXJyb3JzIChlLmcuIE1DRSBvciBTRUEp
LCBvciBmb3IgaGFuZGxpbmcgYXN5bmNocm9ub3VzIGVycm9ycyAoZS5nLiBTQ0kNCj4gKyAqIG9y
IEV4dGVybmFsIEludGVycnVwdCkuDQo+ICsgKi8NCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBpc19o
ZXN0X3N5bmNfbm90aWZ5KHN0cnVjdCBnaGVzICpnaGVzKQ0KPiArew0KPiArCWludCBub3RpZnlf
dHlwZSA9IGdoZXMtPmdlbmVyaWMtPm5vdGlmeS50eXBlOw0KPiArDQo+ICsJcmV0dXJuIG5vdGlm
eV90eXBlID09IEFDUElfSEVTVF9OT1RJRllfU0VBIHx8DQo+ICsJICAgICAgIG5vdGlmeV90eXBl
ID09IEFDUElfSEVTVF9OT1RJRllfTUNFOw0KPiArfQ0KDQpUaGlzIGNvZGUgc2VlbXMgdG8gcmVh
ZCB0aGF0IGFsbCBNQ0VzIGFyZSBzeW5jaHJvbm91cywgd2hpY2ggSSB0aGluayBpcw0Kbm90IGNv
cnJlY3QuICBUaGUgc2NlbmFyaW8gSSdtIHdvcnJ5aW5nIGFib3V0IGlzIHRoYXQgaXNfaGVzdF9z
eW5jX25vdGlmeSgpDQpyZXR1cm5zIHRydWUgd2hlbiB0aGlzIGNvZGUgaXMgY2FsbGVkIGZvciBB
TyBNQ0UgKHNvIGFzeW5jaHJvbm91cyBvbmUpLg0KVGhlbiwgZ2hlc19kb19tZW1vcnlfZmFpbHVy
ZSgpICh1cGRhdGVkIGJ5IHlvdXIgcGF0Y2ggMi8yKSB3aWxsIGNob29zZSB0bw0KdXNlIHRhc2tf
d29yayBpbnN0ZWFkIG9mIG1lbW9yeV9mYWlsdXJlX3F1ZXVlKCkuICBUaGlzIHNob3VsZCBub3Qg
YmUgZXhwZWN0ZWQuDQpPciBkb2VzIHRoYXQgbmV2ZXIgaGFwcGVuPw0KDQotIE5hb3lhIEhvcmln
dWNoaQ0KDQo+ICsNCj4gIC8qDQo+ICAgKiBUaGlzIGRyaXZlciBpc24ndCByZWFsbHkgbW9kdWxh
ciwgaG93ZXZlciBmb3IgdGhlIHRpbWUgYmVpbmcsDQo+ICAgKiBjb250aW51aW5nIHRvIHVzZSBt
b2R1bGVfcGFyYW0gaXMgdGhlIGVhc2llc3Qgd2F5IHRvIHJlbWFpbg0KPiBAQCAtNDc3LDcgKzQ5
MCw3IEBAIHN0YXRpYyBib29sIGdoZXNfZG9fbWVtb3J5X2ZhaWx1cmUodTY0IHBoeXNpY2FsX2Fk
ZHIsIGludCBmbGFncykNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGJvb2wgZ2hlc19oYW5kbGVfbWVt
b3J5X2ZhaWx1cmUoc3RydWN0IGFjcGlfaGVzdF9nZW5lcmljX2RhdGEgKmdkYXRhLA0KPiAtCQkJ
CSAgICAgICBpbnQgc2V2KQ0KPiArCQkJCSAgICAgICBpbnQgc2V2LCBib29sIHN5bmMpDQo+ICB7
DQo+ICAJaW50IGZsYWdzID0gLTE7DQo+ICAJaW50IHNlY19zZXYgPSBnaGVzX3NldmVyaXR5KGdk
YXRhLT5lcnJvcl9zZXZlcml0eSk7DQo+IEBAIC00OTEsNyArNTA0LDcgQEAgc3RhdGljIGJvb2wg
Z2hlc19oYW5kbGVfbWVtb3J5X2ZhaWx1cmUoc3RydWN0IGFjcGlfaGVzdF9nZW5lcmljX2RhdGEg
KmdkYXRhLA0KPiAgCSAgICAoZ2RhdGEtPmZsYWdzICYgQ1BFUl9TRUNfRVJST1JfVEhSRVNIT0xE
X0VYQ0VFREVEKSkNCj4gIAkJZmxhZ3MgPSBNRl9TT0ZUX09GRkxJTkU7DQo+ICAJaWYgKHNldiA9
PSBHSEVTX1NFVl9SRUNPVkVSQUJMRSAmJiBzZWNfc2V2ID09IEdIRVNfU0VWX1JFQ09WRVJBQkxF
KQ0KPiAtCQlmbGFncyA9IDA7DQo+ICsJCWZsYWdzID0gc3luYyA/IE1GX0FDVElPTl9SRVFVSVJF
RCA6IDA7DQo+ICANCj4gIAlpZiAoZmxhZ3MgIT0gLTEpDQo+ICAJCXJldHVybiBnaGVzX2RvX21l
bW9yeV9mYWlsdXJlKG1lbV9lcnItPnBoeXNpY2FsX2FkZHIsIGZsYWdzKTsNCj4gQEAgLTQ5OSwx
MiArNTEyLDE0IEBAIHN0YXRpYyBib29sIGdoZXNfaGFuZGxlX21lbW9yeV9mYWlsdXJlKHN0cnVj
dCBhY3BpX2hlc3RfZ2VuZXJpY19kYXRhICpnZGF0YSwNCj4gIAlyZXR1cm4gZmFsc2U7DQo+ICB9
DQo+ICANCj4gLXN0YXRpYyBib29sIGdoZXNfaGFuZGxlX2FybV9od19lcnJvcihzdHJ1Y3QgYWNw
aV9oZXN0X2dlbmVyaWNfZGF0YSAqZ2RhdGEsIGludCBzZXYpDQo+ICtzdGF0aWMgYm9vbCBnaGVz
X2hhbmRsZV9hcm1faHdfZXJyb3Ioc3RydWN0IGFjcGlfaGVzdF9nZW5lcmljX2RhdGEgKmdkYXRh
LA0KPiArCQkJCSAgICAgICBpbnQgc2V2LCBib29sIHN5bmMpDQo+ICB7DQo+ICAJc3RydWN0IGNw
ZXJfc2VjX3Byb2NfYXJtICplcnIgPSBhY3BpX2hlc3RfZ2V0X3BheWxvYWQoZ2RhdGEpOw0KPiAg
CWJvb2wgcXVldWVkID0gZmFsc2U7DQo+ICAJaW50IHNlY19zZXYsIGk7DQo+ICAJY2hhciAqcDsN
Cj4gKwlpbnQgZmxhZ3MgPSBzeW5jID8gTUZfQUNUSU9OX1JFUVVJUkVEIDogMDsNCj4gIA0KPiAg
CWxvZ19hcm1faHdfZXJyb3IoZXJyKTsNCj4gIA0KPiBAQCAtNTI2LDcgKzU0MSw3IEBAIHN0YXRp
YyBib29sIGdoZXNfaGFuZGxlX2FybV9od19lcnJvcihzdHJ1Y3QgYWNwaV9oZXN0X2dlbmVyaWNf
ZGF0YSAqZ2RhdGEsIGludCBzDQo+ICAJCSAqIGFuZCBkb24ndCBmaWx0ZXIgb3V0ICdjb3JyZWN0
ZWQnIGVycm9yIGhlcmUuDQo+ICAJCSAqLw0KPiAgCQlpZiAoaXNfY2FjaGUgJiYgaGFzX3BhKSB7
DQo+IC0JCQlxdWV1ZWQgPSBnaGVzX2RvX21lbW9yeV9mYWlsdXJlKGVycl9pbmZvLT5waHlzaWNh
bF9mYXVsdF9hZGRyLCAwKTsNCj4gKwkJCXF1ZXVlZCA9IGdoZXNfZG9fbWVtb3J5X2ZhaWx1cmUo
ZXJyX2luZm8tPnBoeXNpY2FsX2ZhdWx0X2FkZHIsIGZsYWdzKTsNCj4gIAkJCXAgKz0gZXJyX2lu
Zm8tPmxlbmd0aDsNCj4gIAkJCWNvbnRpbnVlOw0KPiAgCQl9DQo+IEBAIC02NDcsNiArNjYyLDcg
QEAgc3RhdGljIGJvb2wgZ2hlc19kb19wcm9jKHN0cnVjdCBnaGVzICpnaGVzLA0KPiAgCWNvbnN0
IGd1aWRfdCAqZnJ1X2lkID0gJmd1aWRfbnVsbDsNCj4gIAljaGFyICpmcnVfdGV4dCA9ICIiOw0K
PiAgCWJvb2wgcXVldWVkID0gZmFsc2U7DQo+ICsJYm9vbCBzeW5jID0gaXNfaGVzdF9zeW5jX25v
dGlmeShnaGVzKTsNCj4gIA0KPiAgCXNldiA9IGdoZXNfc2V2ZXJpdHkoZXN0YXR1cy0+ZXJyb3Jf
c2V2ZXJpdHkpOw0KPiAgCWFwZWlfZXN0YXR1c19mb3JfZWFjaF9zZWN0aW9uKGVzdGF0dXMsIGdk
YXRhKSB7DQo+IEBAIC02NjQsMTMgKzY4MCwxMyBAQCBzdGF0aWMgYm9vbCBnaGVzX2RvX3Byb2Mo
c3RydWN0IGdoZXMgKmdoZXMsDQo+ICAJCQlhdG9taWNfbm90aWZpZXJfY2FsbF9jaGFpbigmZ2hl
c19yZXBvcnRfY2hhaW4sIHNldiwgbWVtX2Vycik7DQo+ICANCj4gIAkJCWFyY2hfYXBlaV9yZXBv
cnRfbWVtX2Vycm9yKHNldiwgbWVtX2Vycik7DQo+IC0JCQlxdWV1ZWQgPSBnaGVzX2hhbmRsZV9t
ZW1vcnlfZmFpbHVyZShnZGF0YSwgc2V2KTsNCj4gKwkJCXF1ZXVlZCA9IGdoZXNfaGFuZGxlX21l
bW9yeV9mYWlsdXJlKGdkYXRhLCBzZXYsIHN5bmMpOw0KPiAgCQl9DQo+ICAJCWVsc2UgaWYgKGd1
aWRfZXF1YWwoc2VjX3R5cGUsICZDUEVSX1NFQ19QQ0lFKSkgew0KPiAgCQkJZ2hlc19oYW5kbGVf
YWVyKGdkYXRhKTsNCj4gIAkJfQ0KPiAgCQllbHNlIGlmIChndWlkX2VxdWFsKHNlY190eXBlLCAm
Q1BFUl9TRUNfUFJPQ19BUk0pKSB7DQo+IC0JCQlxdWV1ZWQgPSBnaGVzX2hhbmRsZV9hcm1faHdf
ZXJyb3IoZ2RhdGEsIHNldik7DQo+ICsJCQlxdWV1ZWQgPSBnaGVzX2hhbmRsZV9hcm1faHdfZXJy
b3IoZ2RhdGEsIHNldiwgc3luYyk7DQo+ICAJCX0gZWxzZSB7DQo+ICAJCQl2b2lkICplcnIgPSBh
Y3BpX2hlc3RfZ2V0X3BheWxvYWQoZ2RhdGEpOw0KPiAgDQo+IC0tIA0KPiAyLjIwLjEuMTIuZzcy
Nzg4ZmRi
