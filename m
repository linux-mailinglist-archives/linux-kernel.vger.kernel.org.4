Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D74697D11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjBONXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjBONXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:23:07 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C68AD05
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:22:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1iy4QqtLhKc2F/nyG8+UdTc8yD9yvFZSLI3bDpPKFaY/zGyite58TgIN+pod9PaEDrGAtsFvSzQIugR4fSlFe4oHgTnInSM0eBTgk7nZvKBhWk2eCuJwjkLzBR7RjHAABqoCDPSa3OCt2ahUCq12kSEfybc2riUKKNbvQ9M3Wv3hecAiSaLGIgyOLrOf60Xekvfd9XVe7f1oIegRrILQlrrqRD0EowqMzfTEezuU5mm0kshIxBMTSEiP1yRKvNilXbOzL4I4A5WxGYjPd9/5iJcsK9uu44blIXG1/z3KaT63CX2P6uUcnljtcQAuSDbl8xl3cwIlZEFJDAB7X2HPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixnyI4LJMibIS6FJFI7BeG7vFDSm0ifyXMvFTJeuOjg=;
 b=RMjnEIQSj2/hnHtyVJA1/mb4aXjttUZaQFxsUBz9IblQLef8Im3OsWQM+O1mShfBzxbNR0w2TS3B7jSYuJWdQ02bQ8QDqfMOFSNuBo/rL5H/716iKDdtMvZgbZxVQxjmxoAV9N6gvgfupBXI4oFaO7dZlaO30BOhnf16a7OjP853NfABgL4v934o0PgcOvIrxFQJlTYof8LZcgzJbmktTBEEb2c42bRlo5od6scuI4Ebdn/1OMjTpLredcwTeVfHBS8seWjEVTYPpYvq39keFJL5pXLP5iRXP0borf2nN5DBf4wrHdv51aE4dmTbQgY8UlvvGFwOHOjMMz89/CTgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=gmail.com smtp.mailfrom=zeku.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=zeku.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixnyI4LJMibIS6FJFI7BeG7vFDSm0ifyXMvFTJeuOjg=;
 b=fe3lAT8Q8mLV39jxDrY7epNWyRB+WsDBGgNeHzHot9igmHTZaqCaXG/6A9O+Wl2W4s3Mg7ZIXJ49/BrgzIzTqBHS8AwD5Jnn3r+yoOGmf8quGR5mRfq2I6SLwhKaAmq5CYq8El0qRECgLlyLUCAQQ3hdEBEHhc+qXLmIe40r+ZKPPLPavlfAktp4N6Y3CfD9HQl9BiKBuWZSuhGcfP3/xRPSxaCLwMmPClMXu44pbm8NHsFWM6LK7kfRhBJZQxRSn5a9e85w21ECDG3hGXjiDQM1GxV6iZSwUQu1jgMJivn6vZ3FtYR/idOCDpCznhv7tUanqCK5wTbsSVYSl3gRvw==
Received: from SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18) by
 TYZPR02MB4879.apcprd02.prod.outlook.com (2603:1096:400:50::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Wed, 15 Feb 2023 13:22:51 +0000
Received: from SG2APC01FT0006.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:c6:cafe::19) by SG2P153CA0049.outlook.office365.com
 (2603:1096:4:c6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6 via Frontend
 Transport; Wed, 15 Feb 2023 13:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 SG2APC01FT0006.mail.protection.outlook.com (10.13.37.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 13:22:50 +0000
Received: from sh-exhtc4.internal.zeku.com (10.123.154.251) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Wed, 15 Feb 2023 21:22:50 +0800
Received: from sh-exhtc4.internal.zeku.com ([fe80::b447:eb25:37fd:3fd8]) by
 sh-exhtc4.internal.zeku.com ([fe80::b447:eb25:37fd:3fd8%3]) with mapi id
 15.02.0986.005; Wed, 15 Feb 2023 21:22:50 +0800
From:   =?utf-8?B?6KKB5biFKFNodWFpIFl1YW4p?= <yuanshuai@zeku.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     =?utf-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        =?utf-8?B?5Lu756uL6bmPKFBlbmcgUmVuKQ==?= <renlipeng@zeku.com>
Subject: RE: [PATCH v2] kasan: fix deadlock in start_report()
Thread-Topic: [PATCH v2] kasan: fix deadlock in start_report()
Thread-Index: AQHZPDZzScKWhyj5L0eV70o/eMb/rq7FygeAgACH4+D//5aGAIAAy+8AgAC6aDCACH5tEA==
Date:   Wed, 15 Feb 2023 13:22:50 +0000
Message-ID: <2b57491a9fab4ce9a643bd0922e03e73@zeku.com>
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
 <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
 <93b94f59016145adbb1e01311a1103f8@zeku.com>
 <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
 <CA+fCnZf3k-rsaOeti0Q7rqkmvsqDb2XxgxOq6V5Gqp6FGLH7Yg@mail.gmail.com>
 <b058a424e46d4f94a1f2fdc61292606b@zeku.com>
In-Reply-To: <b058a424e46d4f94a1f2fdc61292606b@zeku.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.122.89.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0006:EE_|TYZPR02MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afc5847-753f-40d8-3845-08db0f57bd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FVuDwCMAIkcZQRuXFVuAbmFyPL9b+AcOkYHSKdcfXNxy2RV7kd6YPBZtJDrUWKehS6ZL6FEsHQdxvyuNCRKKccO7705smO2fIC7s9uCLLeyF1Xkyx7zjl/eZQYM65Xq4qx4eHE3CU/W6XbW6TLAW3F3szecOxJqP8uWOMBBeWXMzq47gZi9y8AAWJgFxDH/++SnPi07kHBL3SgK/o9IofPXiuaqq+sXCKsytmWniTwM1vyytHXZgJv7Qfd5UDs7i4ApIoGCcr+xfAYY3XBIfzb2LbosIAf56os0qj/Ij4yLSSzlnnv/bKsS4e2h8Pp7XsygHqECjI9L4x596Np2I0/336KXMdJzCWTOuZXGxuaBJK4CrEVzcatgWWJrQ01rxEaJhdGtRj9QOp4T/qnkkD3Lt+9R1ib3r1R9IkkQq9ngUKwxVZBZ2Qu2SVUHR5ChNb4SBisOW2+B/sltfal7ydX7LkgzUgoIhkJ9foj8WmdHssRhAg76JfEpu60V0wk0z3K8Y4tGgsJIcE15G/lWzUhypupQtzzFaGl+C6Qyc1WW56zKao+AnP5ZTR9w/JIbvU0lYetzZpeidAaxQ8s1rh5Qg+LMJO36zG4r93lzZq9gfhoFVZ6Q9aPjjypHA+6rg4186OCnYqlNZsyrEsQMDeREfmCBc3nl02R0rZgjm9o55MKbpNoAs7qngFTN+ZlN
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39850400004)(396003)(451199018)(36840700001)(46966006)(7416002)(81166007)(316002)(356005)(8676002)(4326008)(36860700001)(41300700001)(8936002)(82740400003)(2906002)(70206006)(966005)(70586007)(107886003)(478600001)(5660300002)(336012)(26005)(2616005)(24736004)(53546011)(108616005)(86362001)(83380400001)(110136005)(82310400005)(54906003)(36756003)(7696005)(426003)(40480700001)(47076005)(85182001)(186003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 13:22:50.9720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afc5847-753f-40d8-3845-08db0f57bd09
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0006.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB4879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGcmlkYXksIEZlYnJ1YXJ5IDEwLCAyMDIzIGF0IDY6NTQgQU0gQW5kcmV5IEtvbm92YWxv
dg0KPiA8YW5kcmV5a252bEBnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+IE9uIFRodSwgRmViIDks
IDIwMjMgYXQgMTE6NDQgQU0gRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPiA+
IHdyb3RlOg0KPiA+ID4NCj4gPiA+ICBPbiBUaHUsIDkgRmViIDIwMjMgYXQgMTA6MTksIOiigeW4
hShTaHVhaSBZdWFuKSA8eXVhbnNodWFpQHpla3UuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4gPg0K
PiA+ID4gPiBIaSBEbWl0cnkgVnl1a292DQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcywgSSBzZWUg
dGhhdCB5b3VyIG1lYW5zLg0KPiA+ID4gPg0KPiA+ID4gPiBDdXJyZW50bHksIHJlcG9ydF9zdXBw
cmVzc2VkKCkgc2VlbSBub3Qgd29yayBpbiBLYXNhbi1IVyBtb2RlLCBpdA0KPiA+IGFsd2F5cyBy
ZXR1cm4gZmFsc2UuDQo+ID4gPiA+IERvIHlvdSB0aGluayBzaG91bGQgY2hhbmdlIHRoZSByZXBv
cnRfc3VwcHJlc3NlZCBmdW5jdGlvbj8NCj4gPiA+ID4gSSBkb24ndCBrbm93IHdoeSBDT05GSUdf
S0FTQU5fSFdfVEFHUyB3YXMgYmxvY2tlZCBzZXBhcmF0ZWx5DQo+ID4gYmVmb3JlLg0KPiA+ID4N
Cj4gPiA+IFRoYXQgbG9naWMgd2FzIGFkZGVkIGJ5IEFuZHJleSBpbjoNCj4gPiA+IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC9jDQo+ID4gPiBvbQ0KPiA+ID4gbWl0Lz9pZD1jMDY4NjY0Yzk3YzdjZg0KPiA+ID4NCj4gPiA+
IEFuZHJleSwgY2FuIHdlIG1ha2UgcmVwb3J0X2VuYWJsZWQoKSBjaGVjayBjdXJyZW50LT5rYXNh
bl9kZXB0aCBhbmQNCj4gPiA+IHJlbW92ZSByZXBvcnRfc3VwcHJlc3NlZCgpPw0KPiA+DQo+ID4g
SSBkZWNpZGVkIHRvIG5vdCB1c2Uga2FzYW5fZGVwdGggZm9yIEhXX1RBR1MsIGFzIHdlIGNhbiBh
bHdheXMgdXNlIGENCj4gPiBtYXRjaC1hbGwgdGFnIHRvIG1ha2UgImludmFsaWQiIG1lbW9yeSBh
Y2Nlc3Nlcy4NCj4gPg0KPiA+IEkgdGhpbmsgd2UgY2FuIGZpeCB0aGUgcmVwb3J0aW5nIGNvZGUg
dG8gZG8gZXhhY3RseSB0aGF0IHNvIHRoYXQgaXQNCj4gPiBkb2Vzbid0IGNhdXNlIE1URSBmYXVs
dHMuDQo+ID4NCj4gPiBTaHVhaSwgY291bGQgeW91IGNsYXJpZnksIGF0IHdoaWNoIHBvaW50IGR1
ZSBrYXNhbl9yZXBvcnRfaW52YWxpZF9mcmVlDQo+ID4gYW4gTVRFIGV4Y2VwdGlvbiBpcyByYWlz
ZWQgaW4geW91ciB0ZXN0cz8NCj4NCj4gWWVzLCBJIG5lZWQgc29tZSB0aW1lIHRvIGNsYXJpZnkg
dGhpcyBwcm9ibGVtIHdpdGggYSBjbGVhciBsb2cgYnkgdGVzdC4NCj4NCg0KSGkgQW5kcmV5IGFu
ZCBEbWl0cnkNCg0KSSBoYXZlIGdvdCB2YWxpZCBpbmZvcm1hdGlvbiB0byBjbGFyaWZ5IHRoZSBw
cm9ibGVtIGFuZCBzb2x1dGlvbnMuIEkgbWFkZQ0KYSBmZXcgY2hhbmdlcyB0byB0aGUgY29kZSB0
byBkbyB0aGlzLg0KDQphKSBJIHdhcyB0ZXN0aW5nIG9uIGEgZGV2aWNlIHRoYXQgaGFkIGhhcmR3
YXJlIGlzc3VlcyB3aXRoIE1URSwNCiAgICBhbmQgdGhlIG1lbW9yeSB0YWcgc29tZXRpbWVzIGNo
YW5nZWQgcmFuZG9tbHkuDQoNCmIpIEkgZGlkIHRoaXMgdGVzdCBvbiBrZXJuZWwgdmVyc2lvbiA1
LjE1LCBidXQgdGhpcyBwcm9ibGVtIHNob3VsZA0KICAgIGV4aXN0IG9uIHRoZSBsYXRlc3Qga2Vy
bmVsIHZlcnNpb24gZnJvbSBhIGNvZGUgcGVyc3BlY3RpdmUuDQoNCmMpIFJ1biB0aGUga2VybmVs
IHdpdGggYSBzaW5nbGUgY29yZSBieSAibWF4Y3B1cz0xIi4NCg0KZCkgQ29kZSBtb2RpZnksDQog
ICAgKDEpIENhbGwgZHVtcF9zdGFja19sdmwoS0VSTl9FUlIpIHdoZW4gc3RhcnRfcmVwb3J0KCkg
cmV0dXJucyBmYWxzZSwNCiAgICB0aGlzIGlzIGRvbmUgYmFzZWQgb24gdGhlIGN1cnJlbnQgcGF0
Y2ggdjIuDQoNCiAgICAoMikgQWRkIHNvbWUgbG9nIGluIHByaW50X2FkZHJlc3NfZGVzY3JpcHRp
b24oKSB0byBzaG93IGttZW1fY2FjaGUgYWRkcmVzcw0KICAgIGFuZCBtZW1vcnkgdGFnLg0KICAg
IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE1Ljk0L3NvdXJjZS9tbS9rYXNh
bi9yZXBvcnQuYyNMMjUyDQogICBAQCAtMjU1LDI0ICsyNjAsMjUgQEAgc3RhdGljIHZvaWQgcHJp
bnRfYWRkcmVzc19kZXNjcmlwdGlvbih2b2lkICphZGRyLCB1OCB0YWcpDQoNCiBkdW1wX3N0YWNr
X2x2bChLRVJOX0VSUik7DQogcHJfZXJyKCJcbiIpOw0KICAtDQogICtwcl9lcnIoInlzOjFcbiIp
Ow0KIGlmIChwYWdlICYmIFBhZ2VTbGFiKHBhZ2UpKSB7DQogc3RydWN0IGttZW1fY2FjaGUgICAg
KmNhY2hlID0gcGFnZS0+c2xhYl9jYWNoZTsNCiAgLXZvaWQgKm9iamVjdCA9IG5lYXJlc3Rfb2Jq
KGNhY2hlLCBwYWdlLGFkZHIpOw0KICArdm9pZCAqb2JqZWN0ID0gTlVMTDsNCiAgK3ByX2Vycigi
eXM6Y2FjaGUgc3RhcnQgJWxseCwgbXRhZzoleCwgcGFnZV9hZGRyZXNzOiVsbHhcbiIsDQogICtj
YWNoZSwgaHdfZ2V0X21lbV90YWcoY2FjaGUpLCBwYWdlX2FkZHJlc3MocGFnZSkpOw0KICArb2Jq
ZWN0ID0gbmVhcmVzdF9vYmooY2FjaGUsIHBhZ2UsIGFkZHIpOw0KICArICAgICAgICAgICAgICAg
ICAgICAgICAgIHByX2VycigieXM6Y2FjaGUgZW5kICVsbHgsIG9iamVjdCAlbGx4LCBwYWdlX2Fk
ZHJlc3M6JWxseFxuIiwNCiAgKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjYWNoZSwgb2JqZWN0LCBwYWdlX2FkZHJlc3MocGFnZSkpOw0KZGVzY3JpYmVfb2JqZWN0KGNh
Y2hlLCBvYmplY3QsIGFkZHIsIHRhZyk7DQogfQ0KDQogICAgKDMpIEFkZCBrYXNhbl9lbmFibGVf
dGFnZ2luZygpIHRvIEtVTklUX0VYUEVDVF9LQVNBTl9GQUlMIGluDQogICAgaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTUuOTQvc291cmNlL2xpYi90ZXN0X2thc2FuLmMjTDk0
DQogICAgVGhpcyBlbnN1cmVzIHRoYXQga3VuaXQgaXMgdGVzdGVkIG9uIHRoaXMgdW5zdGFibGUg
ZGV2aWNlLg0KDQplKSBXaXRoIHRoZSBhYm92ZSBtb2RpZmljYXRpb24gd2UgY2FuIGdldCB0aGUg
YmFja3RyYWNlOg0KeXM6MQ0KeXM6Y2FjaGUgc3RhcnQgZjRmZmZmODE0MDAwNTM4MCwgbXRhZzpm
ZSwgcGFnZV9hZGRyZXNzOmZmZmZmZjgxNDAzMjgwMDANCnlzOmNhY2hlIGNoYW5nZSBmNGZmZmY4
MTQwMDA1MzgwLCBtdGFnOmZlLCBwYWdlX2FkZHJlc3M6ZmZmZmZmODE0MDMyODAwMA0KeXM6IGVy
cm9yIGFkZHJlc3M6ZjRmZmZmODE0MDAwNTM5OA0KUG9pbnRlciB0YWc6IFtmNF0sIG1lbW9yeSB0
YWc6IFtmZV0NCkNQVTogMCBQSUQ6IDEwMCBDb21tOiBrdW5pdF90cnlfY2F0Y2ggVGFpbnRlZDoN
CkNhbGwgdHJhY2U6DQpkdW1wX2JhY2t0cmFjZS5jZmlfanQrMHgwLzB4OA0KIHNob3dfc3RhY2sr
MHgyOC8weDM4DQogZHVtcF9zdGFja19sdmwrMHg2OC8weDk4DQogX19rYXNhbl9yZXBvcnQrMHgx
MTAvMHgyOWMNCmthc2FuX3JlcG9ydCsweDQwLzB4OGMNCiBfX2RvX2tlcm5lbF9mYXVsdCsweGQ0
LzB4MmM0DQogZG9fYmFkX2FyZWErMHg0MC8weDEwMA0KIGRvX3RhZ19jaGVja19mYXVsdCsweDJj
LzB4NDANCiBkb19tZW1fYWJvcnQrMHg3NC8weDEzOA0KZWwxX2Fib3J0KzB4NDAvMHg2NA0KIGVs
MWhfNjRfc3luY19oYW5kbGVyKzB4NjAvMHhhMA0KIGVsMWhfNjRfc3luYysweDdjLzB4ODANCiBw
cmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uKzB4MTU0LzB4MmU4DQogX19rYXNhbl9yZXBvcnQrMHgy
MDAvMHgyOWMNCmthc2FuX3JlcG9ydCsweDQwLzB4OGMNCiBfX2RvX2tlcm5lbF9mYXVsdCsweGQ0
LzB4MmM0DQogZG9fYmFkX2FyZWErMHg0MC8weDEwMA0KIGRvX3RhZ19jaGVja19mYXVsdCsweDJj
LzB4NDANCiBkb19tZW1fYWJvcnQrMHg3NC8weDEzOA0KZWwxX2Fib3J0KzB4NDAvMHg2NA0KIGVs
MWhfNjRfc3luY19oYW5kbGVyKzB4NjAvMHhhMA0KIGVsMWhfNjRfc3luYysweDdjLzB4ODANCiBl
bnF1ZXVlX2VudGl0eSsweDIzYy8weDRiOA0KZW5xdWV1ZV90YXNrX2ZhaXIrMHgxM2MvMHg0OGMN
CiBlbnF1ZXVlX3Rhc2subGx2bS4xNjg0MDQyODg3Nzc0Nzc0NDI4KzB4ZDAvMHgyNTANCiBfX2Rv
X3NldF9jcHVzX2FsbG93ZWQrMHgxYWMvMHgzMDQNCiBfX3NldF9jcHVzX2FsbG93ZWRfcHRyX2xv
Y2tlZCsweDE2OC8weDI4Yw0KIG1pZ3JhdGVfZW5hYmxlKzB4ZjAvMHgxN2MNCmthc2FuX3N0cmlu
Z3MrMHg1OWMvMHg3MmMNCmt1bml0X3RyeV9ydW5fY2FzZSsweDg0LzB4MTI4DQprdW5pdF9nZW5l
cmljX3J1bl90aHJlYWRmbl9hZGFwdGVyKzB4NDgvMHg4MA0Ka3RocmVhZCsweDE3Yy8weDFlOA0K
cmV0X2Zyb21fZm9yaysweDEwLzB4MjANCnlzOmNhY2hlIGVuZCBmNGZmZmY4MTQwMDA1MzgwLCBv
YmplY3QgZmZmZmZmODE0MDMyY2EwMCwgcGFnZV9hZGRyZXNzOmZmZmZmZjgxNDAzMjgwMDANCg0K
ZikgRnJvbSB0aGUgYWJvdmUgbG9nLCB5b3UgY2FuIHNlZSB0aGF0IHRoZSBzeXN0ZW0gdHJpZWQg
dG8gY2FsbCBrYXNhbl9yZXBvcnQoKSB0d2ljZSwNCiAgIGJlY2F1c2Ugd2UgdmlzaXQgdGFnIGFk
ZHJlc3MgYnkga21lbV9jYWNoZSBhbmQgdGhpcyB0YWcgaGF2ZSBjaGFuZ2UuLg0KICAgTm9ybWFs
bHkgdGhpcyBkb2Vzbid0IGhhcHBlbiBlYXNpbHkuIFNvIEkgdGhpbmsgd2UgY2FuIGFkZCBrYXNh
bl9yZXNldF90YWcoKSB0byBoYW5kbGUNCiAgIHRoZSBrbWVtX2NhY2hlIGFkZHJlc3MuDQoNCiAg
IEZvciBleGFtcGxlLCB0aGUgZm9sbG93aW5nIGNoYW5nZXMgYXJlIHVzZWQgZm9yIHRoZSBsYXRl
c3Qga2VybmVsIHZlcnNpb24uDQpkaWZmIC0tZ2l0IGEvbW0va2FzYW4vcmVwb3J0LmMgYi9tbS9r
YXNhbi9yZXBvcnQuYw0KLS0tIGEvbW0va2FzYW4vcmVwb3J0LmMNCisrKyBiL21tL2thc2FuL3Jl
cG9ydC5jDQpAQCAtNDEyLDcgKzQxMiw3IEBAIHN0YXRpYyB2b2lkIGNvbXBsZXRlX3JlcG9ydF9p
bmZvKHN0cnVjdCBrYXNhbl9yZXBvcnRfaW5mbyAqaW5mbykNCiAgICAgICAgc2xhYiA9IGthc2Fu
X2FkZHJfdG9fc2xhYihhZGRyKTsNCiAgICAgICAgaWYgKHNsYWIpIHsNCi0gICAgICAgICAgICAg
ICBpbmZvLT5jYWNoZSA9IHNsYWItPnNsYWJfY2FjaGU7DQorICAgICAgICAgICAgICAgaW5mby0+
Y2FjaGUgPSBrYXNhbl9yZXNldF90YWcoc2xhYi0+c2xhYl9jYWNoZSk7DQogICAgICAgICAgICAg
ICAgaW5mby0+b2JqZWN0ID0gbmVhcmVzdF9vYmooaW5mby0+Y2FjaGUsIHNsYWIsIGFkZHIpOw0K
DQogICBJIGhhdmUgdGVzdGVkIEtlcm5lbDUuMTUgdXNpbmcgYSBzaW1pbGFyIGFwcHJvYWNoIGFu
ZCBpdCBzZWVtcyB0byB3b3JrLg0KICAgT24gdGhlIG90aGVyIGhhbmQsIEkgdGhpbmsgdGhlcmUg
c2hvdWxkIGJlIG90aGVyIHNvbHV0aW9ucyBhbmQgaG9wZSB0byBnZXQgeW91ciBmZWVkYmFjay4N
CiAgIFRoYW5rcyBhIGxvdC4NCg0KPiA+ID4gVGhlbiB3ZSBjYW4gYWxzbyByZW1vdmUgdGhlIGNv
bW1lbnQgaW4ga2FzYW5fcmVwb3J0X2ludmFsaWRfZnJlZSgpLg0KPiA+ID4NCj4gPiA+IEl0IGxv
b2tzIGxpa2Uga2FzYW5fZGlzYWJsZV9jdXJyZW50KCkgaW4ga21lbWxlYWsgbmVlZHMgdG8gYWZm
ZWN0DQo+ID4gPiBIV19UQUdTIG1vZGUgYXMgd2VsbDoNCj4gPiA+IGh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L3Y2LjItcmM3L3NvdXJjZS9tbS9rbWVtbGVhay5jI0wzMDENCj4gPg0K
PiA+IEl0IHVzZXMga2FzYW5fcmVzZXRfdGFnLCBzbyBpdCBzaG91bGQgd29yayBwcm9wZXJseSB3
aXRoIEhXX1RBR1MuDQpaRUtVDQrkv6Hmga/lronlhajlo7DmmI7vvJrmnKzpgq7ku7bljIXlkKvk
v6Hmga/lvZLlj5Hku7bkurrmiYDlnKjnu4Tnu4daRUtV5omA5pyJ44CCIOemgeatouS7u+S9leS6
uuWcqOacque7j+aOiOadg+eahOaDheWGteS4i+S7peS7u+S9leW9ouW8j++8iOWMheaLrOS9huS4
jemZkOS6juWFqOmDqOaIlumDqOWIhuaKq+mcsuOAgeWkjeWItuaIluS8oOaSre+8ieS9v+eUqOWM
heWQq+eahOS/oeaBr+OAguiLpeaCqOmUmeaUtuS6huacrOmCruS7tu+8jOivt+eri+WNs+eUteiv
neaIlumCruS7tumAmuefpeWPkeS7tuS6uu+8jOW5tuWIoOmZpOacrOmCruS7tuWPiumZhOS7tuOA
gg0KSW5mb3JtYXRpb24gU2VjdXJpdHkgTm90aWNlOiBUaGUgaW5mb3JtYXRpb24gY29udGFpbmVk
IGluIHRoaXMgbWFpbCBpcyBzb2xlbHkgcHJvcGVydHkgb2YgdGhlIHNlbmRlcidzIG9yZ2FuaXph
dGlvbiBaRUtVLiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGlu
IGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFs
IGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBv
dGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91
IHJlY2VpdmUgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5
IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQuDQo=
