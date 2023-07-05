Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE50F747AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 02:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGEAaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 20:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGEAau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 20:30:50 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7597FEA;
        Tue,  4 Jul 2023 17:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoYVf/XaFLG5CrObQhWHpuh7gsj7VQZpPXfMZgTxoYeXMLzuHT9p17gW9jPKNzWhBoP/2ZiFvLwUREYXr2rleb5yYQxV4gF47bBoV6Wz90tDVq5Cwe84YaNKGTmSjxfjBaUqXivbIss2NuYUC6r3KsQksHHM3uayDC3m0G0hkcD3LITz6YFV8iBQmg7TKXOtI412ACZWaHnebHQr4At6eBTmN5q56Gg1Ll/HQ+Qfu4F9H7scd11JhcvttopTD5RWftX7AUG9BEpVfHPo044UMLjxC1vrB27rayXE61cYf72aDfIflHLKzRro6XcXZgsBnNcuO4iZcYvKNzSP9C+h4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q41OPzPdAQ7mteti7Fr0OUn8FctlTmD4eeQVJJgu3oE=;
 b=NqK9pIYYFmyJqbm+ubhEUlsVgFNlzVpo/uA+KzB9BptOTZV3utIxMuFcgrE40P4+y9A8zqvdnak9GucDVMNaFSwkCsybDWIV4pUflsLdgD1V1pi5HYFt+cvzNIhotVpmdvMscDH26yxLNg0vnl4GUrDuMLcrFl1oZBK+4edFgSmTCJt3aHhSpty+Sg1A8zbFgcO9evsqukJJlxPIv2Tr43yb9ber0k2CLRvE09ZvvkEhxXaYCeuSWZRJenIi0l3LUTrqzBP6LbSrfdiIBR+9yVXac3E0Q0itHBF4rheZufTwnIV5YzW78T/9FVjmUqgXAMvj/hNHHCucaGQ4PIcR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q41OPzPdAQ7mteti7Fr0OUn8FctlTmD4eeQVJJgu3oE=;
 b=dPaNYIjyyb2SLIrPRUHU/fqxpavz3Bpfy09hne0u18+3swg3oNSye8BrSj/kf9DnDNjbDpEH6j5AMTHc3gE71tQpqa7LTNhyJ4rDudWvg3HoDyaMTY345cXJ5FRRaUlOq6zW5aF6C2ar5UcgkvRFxIX1vVB0ELjNuVn2qFOS+ec=
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by SEYPR02MB5775.apcprd02.prod.outlook.com (2603:1096:101:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 00:30:46 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::2e7:47a3:69c4:9e8e]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::2e7:47a3:69c4:9e8e%3]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 00:30:46 +0000
From:   =?utf-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?utf-8?B?6YOt5YGl?= <guojian@oppo.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGJsb2NrOiBtcS1kZWFkbGluZTogcmVuYW1lIHNv?=
 =?utf-8?B?cnRfbGlzdCB0byBzb3J0X3Ji?=
Thread-Topic: [PATCH] block: mq-deadline: rename sort_list to sort_rb
Thread-Index: AQHZri0DsaJtii+IQUasqZzqxbUUA6+ppwGAgACquBA=
Date:   Wed, 5 Jul 2023 00:30:46 +0000
Message-ID: <TYZPR02MB55955F57A8CCC819054338BFC62FA@TYZPR02MB5595.apcprd02.prod.outlook.com>
References: <20230704040626.24899-1-lipeifeng@oppo.com>
 <32dad510-1508-f0dc-ab49-60d56ed2c2d6@acm.org>
In-Reply-To: <32dad510-1508-f0dc-ab49-60d56ed2c2d6@acm.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR02MB5595:EE_|SEYPR02MB5775:EE_
x-ms-office365-filtering-correlation-id: e93a045a-0cfa-4adc-2573-08db7cef1302
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ke5jBxFjxxw4CbjsK3vWrV8L69LyaJt3WATxcps+5D8uGx8pW3o9bNnrf3n4M+nXx1TDGWHwJdkFFmEdc2HnF3OYroEH7Z3JpxP/hV7JzurTW5WREKvRo7wJjCh4BHZf0WZodQCmbFxCGBgtyeNMhLLDaPzQLs228t2AR0YEkq8Ql/ljyff6ZPG/YYBvvWwsBQavc66fZYNngyBlW4xx0OGVBwgY8G/Fr02ejHM58XQ5EPP8skMaRIVrS4tiY0iQTFyry2tzFP1kK1xA3Kl0L5HryVqJ2GKbF3nRV0hmP/KI5MNvIvnMIVJbfe0ZesptEzHw+NsNxHC8DkB+qVLsNcmApy6pHsz44S6GQwLgjEs2gcUg66sRPiwstAFuK00+BP/1F6js6VUOJ+sko2gisyxIgbixMuo/607EShVwm1tZRb5TAnNAvQJyThJQCAphClziWKRio7SEzVUjuPQ5qIwAnbzOtSluEWAGMuVsDnnZWTWVSJwiSJpAMhrx+8T4nnHvtsZahJQX1Y7o9UAIAD7r96kOdeuCpHPdvsdHji8gaW+k3lVPmPpvmCwZd1Sc4QKiuSXAVsqn/o5h2FrafvNlnv0T/ljp9ZKu6sS7HNQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(38070700005)(186003)(122000001)(38100700002)(76116006)(71200400001)(107886003)(9686003)(66946007)(224303003)(7696005)(85182001)(2906002)(86362001)(66476007)(110136005)(54906003)(4326008)(64756008)(316002)(66556008)(66446008)(478600001)(26005)(53546011)(6506007)(55016003)(83380400001)(41300700001)(4744005)(5660300002)(8936002)(33656002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjVnWkJTT1V0VWVac0tRWVlXNTNFQ1ZvN2ZhKzhXVUxuR1U2NHhBVTd1dmgy?=
 =?utf-8?B?YW82Zm9UZTFjQkZiK1dLUE9HL2JTem5VdURwczhuZ1UwSlpRMWZLMWxpQ1dj?=
 =?utf-8?B?bjlCZ041WGFxaUR6c0JpOE1OOEZ1L1J5dHBkcHc5emxNYUN4cGcrcmFzRlhT?=
 =?utf-8?B?THRyZFY2RWtvY05lVWd1aEFBZWJrUDRzY0RVOHJBaEV6WC9md3JkRVVEZ01B?=
 =?utf-8?B?NzJxL1BxWkJvc1cxWlI1c0YvTGN3K3gybVFQaEFKS1FBYzJDQUxPSVdJNCtN?=
 =?utf-8?B?cHR1bExLV3I5Q2lNMW5uclVEanNlREt4SEZ0L3BhWndWeHVqNlhsdHVKQ0ZB?=
 =?utf-8?B?VmZJVk5KNTJCZVJhUW4vQTA2Tjd5V1JkdVAvbi9FWDlUbmQ2cWtYdTdDQ04v?=
 =?utf-8?B?VjZ5K3FxN3VHc2dGYkxYVVhEZ2FvaEtNdGtyaUEvKzkrMS9ZTVZKaXp2a3lS?=
 =?utf-8?B?RWF0eXg1MUVQdFpxdVFUai9sVUIrckpTYndkMkRRSWQyVDhzc2xHRktVY2o1?=
 =?utf-8?B?cUtxemYvS2J6NG9lRUtVOHlZUEQyN2RwUHA3QmdCZkcyM0FycmkyTGNINHpL?=
 =?utf-8?B?MStwWEhFTzA2cDZWSDd1S1h3Sjh3VDRWRmJURmNwek95UUg3MnB2U1VuVzZT?=
 =?utf-8?B?TWNUU2JyQXRsQnpOWHhMK3dPRjd3VWpWUnhUbjZsYy9ZUXFXSHlDQkFUWkps?=
 =?utf-8?B?R3N4OC9QTFhheitpcWd5SWx2NzJaQXM5MGlhMTJjR0Q1bjdNOTR4UkhCWkxa?=
 =?utf-8?B?bVozYXdZbW1NdDlmMzMyYkRKc1BQWVRwTVc1RE9Jc1FTUFgyRCsxYmk3YVpM?=
 =?utf-8?B?a1NENXZsMkJQTDlRVDFreVplZTUyTjEzdUtJZ2xYZzFsalZtbkdNbXZvVXpO?=
 =?utf-8?B?ZlVPOUg0dVBpRk5MRGxnTndIUWlGRmZDUFdlRk16Q2s1OFFCczBUNU5ZMXcw?=
 =?utf-8?B?TmZlWU5YSFlnalFjd2ZRRjJPRGdYZTFQMERVQnhhS3Z4UTE5MTJsUm5kSytp?=
 =?utf-8?B?YlR2S3NSaDJabE5mT0lKM1F1MFVjMHZHVVIvRUE3Wi9Ob3JBV2ZMQnZsd2p1?=
 =?utf-8?B?L1dNQVh4OTFRdlM2TnVtOGVZNDY4a3RFQlJILzFQUE9nYkNYUWJMTXlOUHdU?=
 =?utf-8?B?QmdBSTBVUEFHMU9OZXVHd2F1Q0dJczgwSHAvb0VLQjVGZlluL1BPNVp5YWtm?=
 =?utf-8?B?bkxiT051K2RJaVZ5WUFReWVEajRTODZkOXJTUURGdGJTNW9rMXlNQXdHNllv?=
 =?utf-8?B?UWQ2ZVhid0FHaWpPd3ZNeVBmWlZkRXE5R08zYllHOHB6SE1TMDMrZ1ZjejJx?=
 =?utf-8?B?TEhUSUlJMkkwSHZ0WEt6RzJSYVloMTcweU5TaFJ4a2ppV1R5aThvd1RJL25x?=
 =?utf-8?B?U2owa3hFSUZidWhBVU9HNUJtVjdoVGx0bklWTWNPUlpYWkZ0UnRScm9sWDRE?=
 =?utf-8?B?cTRMM3dIODFzUlpnWEhUbkUybU5RcExqelNzRytEa0dyOGxKZURJVVJZbEVK?=
 =?utf-8?B?ZTFIN2drQWR2YWhwQnY4U3Q5b29NUENqQWZJV250ZDhIL1FsVlZoSE1jMkxO?=
 =?utf-8?B?SnRaNHQ0dmlJK0Yzc3ArcWwxbnAzeGNPU3ppbnZZeFNna3FMeTdndTZxUm1v?=
 =?utf-8?B?SlFzQ2V1c2FLOUhMT0xmU0FLQkFDaVhkakwybmFxZHUvelVuVE01Qmh2dHd6?=
 =?utf-8?B?RjQzSzhUV3dIMUN1d1phZVdHTURxcURKZysxZXROcnlydmJmKzlTK3hxeDZQ?=
 =?utf-8?B?SG5iUHFqKzZrNzB6V2JTMzNnTVRzc1NFalhUZHNvQWFHUWs0ZmQxUlRFYVAw?=
 =?utf-8?B?NW1pRkJYNVl5bVFIcGpreTNOcVBaK1RKTnMyWG84QjMzbHpEVjJqUzVRMVBw?=
 =?utf-8?B?R0hRQlpRT09DWFEwdDM5YjVFd3JGMmdnS1lpOGdySjNLemVDYUxFWmhKMlVQ?=
 =?utf-8?B?Q1NwWEtvUUNPMFd4YitTNldtK29rQ3RRRlRGTWJ0bFlyd3J2VHRDQ3ZiOS9H?=
 =?utf-8?B?QnFIZmQ5TkQxVjdhTE9acmJ1V1BhNHBuQmRjUFowQmRoUDA5ZlNieVNwWVVt?=
 =?utf-8?B?cStaSWFBYlZ1aW9qL0VtU1g5QnhKQkVkd1gwamRpWnpvemNGdTdTWFF3dHhz?=
 =?utf-8?Q?xxWamT9vP0ygeHfurJbA6L5xd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93a045a-0cfa-4adc-2573-08db7cef1302
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 00:30:46.0715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hd0SSBkIN5yJ+Y2eZyTMsGJ82aj4ZRJqmYVsVyMIqAj2c9BFIkcTAOV4Cx9y3ZXpF5qv8luIdv245cGnU/osDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gTXEtZGVhZGxpbmUgd291bGQgc3RvcmUgcmVxdWVzdCBpbiBsaXN0OmZpZm9fbGlzdCBhbmQg
DQo+PiByYl90cmVlOnNvcnRfbGlzdCwgYW5kIHNvcnRfbGlzdCBzaG91bGQgYmUgcmVuYW1lZCB0
byBzb3J0X3JiIHdoaWNoIGlzIA0KPj4gYmVuZWZpY2lhbCBmb3IgdW5kZXJzdGFuZGluZy4NCg0K
Pkh1aD8gSSB0aGluayB0aGlzIHBhdGNoIG1ha2VzIHRoZSBjb2RlIGxlc3MgcmVhZGFibGUgaW5z
dGVhZCBvZiBtb3JlIHJlYWRhYmxlIC4uLg0KDQpIdWg/IE1heWJlIHdlIGhhZCBkaWZmZXJlbnQg
b3BpbmlvbnMgYWJvdXQgaXQsIEkgdGhpbmtzIHRoZSBlc3NlbmNlIG9mIHRoaXMgd29yZCBpcyAn
c29ydCcNClNvIHRoYXQgcmVhZGVyIGNhbiBnZXQgdGhlIG1lYW5pbmcgb2YgaXQgZWFzaWx5LiBB
bmQgaW4gbXkgbWluZCwgKl9yYiBpcyBtb3JlIHJlYXNvbmFibGUNCmZvciByYl9yb290IHJhdGhl
cnRoYW4gKl9saXN0IGZvciByZWFkZXIuDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7
tuS6ujogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+IA0K5Y+R6YCB5pe26Ze0
OiAyMDIz5bm0N+aciDTml6UgMjI6MTMNCuaUtuS7tuS6ujog5p2O5Z+56ZSLKHdpbmspIDxsaXBl
aWZlbmdAb3Bwby5jb20+OyBheGJvZUBrZXJuZWwuZGsNCuaKhOmAgTogbGludXgtYmxvY2tAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyDlvKDor5fmmI4oU2lt
b24gWmhhbmcpIDx6aGFuZ3NoaW1pbmdAb3Bwby5jb20+OyDpg63lgaUgPGd1b2ppYW5Ab3Bwby5j
b20+DQrkuLvpopg6IFJlOiBbUEFUQ0hdIGJsb2NrOiBtcS1kZWFkbGluZTogcmVuYW1lIHNvcnRf
bGlzdCB0byBzb3J0X3JiDQoNCk9uIDcvMy8yMyAyMTowNiwgbGlwZWlmZW5nQG9wcG8uY29tIHdy
b3RlOg0KPiBNcS1kZWFkbGluZSB3b3VsZCBzdG9yZSByZXF1ZXN0IGluIGxpc3Q6Zmlmb19saXN0
IGFuZCANCj4gcmJfdHJlZTpzb3J0X2xpc3QsIGFuZCBzb3J0X2xpc3Qgc2hvdWxkIGJlIHJlbmFt
ZWQgdG8gc29ydF9yYiB3aGljaCBpcyANCj4gYmVuZWZpY2lhbCBmb3IgdW5kZXJzdGFuZGluZy4N
Cg0KSHVoPyBJIHRoaW5rIHRoaXMgcGF0Y2ggbWFrZXMgdGhlIGNvZGUgbGVzcyByZWFkYWJsZSBp
bnN0ZWFkIG9mIG1vcmUgcmVhZGFibGUgLi4uDQoNCkJhcnQuDQo=
