Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8F708FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 08:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjESGXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 02:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESGXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 02:23:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2056.outbound.protection.outlook.com [40.107.255.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2D21A6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 23:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuMrLdqXPsBIY6xT/rkze8h8MX7OVRbl7IjsY/hDGK2fAZOJYobP2gRpBN0uGHggJ7PS1MhRbK5hwC+EyIG4m66q8WtVV0CuO8u9Rv23/mgO1RshqDDLuqVFg+7wZNukBVJf7xp2GyDQtnY/YJe5RNUK0EcqNDk18DoeydHv97PvoR+UyJ9/PBGE2T9Y5dilXphmhLC0bKGB3wsRYr1ODEkv2eiS+fmqoAsArL8YwzSA6Mzl1dKSufy4Bpz13Khok42bH/6Wma/QIJJrvCKFdcAWVVvCOpNkuNdvSfvs0ySbeuC+L1MhTAwMStEIKlIdUqh/Mphj64DsTMvx8g+VhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdNPuXnpUcCMVIOlw82piWY5gTBAX7L9eMsi404rws4=;
 b=a1DpfrQcA1ryBjozEic7+haLBnES91l9h3LI/xtEfP1MiOLA7dv6cc/WnIa6pvTM11hq38wABaC6BihLKJANJkH5O0gTCtt3n6Hu1W+FYM18btPet70hv5w/DpqdePXulQzuJkP4ykacJz634EM20GReMDD67dq49dx+CiWR2Rx1yt6mesLr5FBKeTQhlgOpMAgu8pPMynyiQBHVMF+L4+p9gCcna1vpXmC8RXxu48rNfQcJSQ3Wp39IkyvQd1vYcMKasMTGmhytfvk+XKp8+qTSaWbbsXGODebhK0drYM9y7kIs7bRz66ZjGSxJ+saTWYBuahxiea1/nzg4YQ+iYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdNPuXnpUcCMVIOlw82piWY5gTBAX7L9eMsi404rws4=;
 b=n1RmfydpjepwYKtJIy+usAFSbYPCrF3S6F48iLpAjsknFmczBf692QSlp4A3Ytt4+u1Mb/+dBzHJ68u7/pfco1crdFRRpKhZuJn2fssS8VkglX9SHRgy9WdErGASIoIgqH5PgGU0zS0uxbQ/mCBD5vDkxFBVV0JmJEimQ0bWdKWd9q6cplPTkKszljID4AhQc4/emjDctIKvuo4mImgE2kq9ZMi/UtyJ+otksLuTaqfeBO0MP1FJvTKv6TUU8/j6+k9z1alyFXn2c6MkXmhxc178TaZm+91K8l9A4JgbuNLQquE3xKhyZb9axx40ZlJWpvxb2IXkohIC/2Yug8bJcA==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR06MB6018.apcprd06.prod.outlook.com (2603:1096:820:d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 06:23:23 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::60d6:4281:7511:78f7]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::60d6:4281:7511:78f7%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 06:23:23 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH] init: Add bdev fs printk if mount_block_root failed
Thread-Topic: [PATCH] init: Add bdev fs printk if mount_block_root failed
Thread-Index: AQHZiTxYACHcmK7CiEuq3+U+9CSzEa9gdNaAgACormA=
Date:   Fri, 19 May 2023 06:23:22 +0000
Message-ID: <TY2PR06MB342418A1256A1342EE27F474857C9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230518035321.1672-1-angus.chen@jaguarmicro.com>
 <20230518130221.81e8e1f474cfbfd6c93712c5@linux-foundation.org>
In-Reply-To: <20230518130221.81e8e1f474cfbfd6c93712c5@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|KL1PR06MB6018:EE_
x-ms-office365-filtering-correlation-id: 4b062d79-f4ca-4dad-6231-08db58318c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHK56+SEE7Yz+VjsRyqZodYHafUVPJaR/zvUxxwb9UIv0klYgvCVeEGJ3qDtXPhyTyGrji0Beu9YQlqbrtqChW9ICshOsbQ9yo57zVrf3DBiMz97EQTQeUiQcgAT/IGKQ0fH5fsP2VkIRWUd3E8ipSgA3VJOZPGnbaTbJNuZ1roMuGXJ0OugYJp9oDALu64b02d+l2x/xHEEw17A+9vY+kaY6thKV0XoWAAAZwpW4zS0Wf4PG+7tiqLPSuM+Jrh0lPkfXRrgWufwO2+3usZ3M41U6B5Z1CMRqsYmYYhOpm6+Dz+PDJGEhHfglO8hhvreLRCFdRFMcAuk7kj4PUePAFf7d6wF7JWXLGSHoJiuJ5g2cVLv4uJyIKKj0QUxsPvj6vxKOFUbk7bb+6NPdc/tQ4ht8VPLDvjqDi0zKTvK7La2S1L++8/Sv2KMGsA59+0wjp+h71R4mE/LBa+0T5VxtBh4w855gUjhREdyNITW4oam32M7J4JPivHVS4Pibk1U/NXMFTq4csF6A9PiH2YENiICHhS1/OoXh7UZtkR/b4N2EFXST3CpNaFWcAm8wbdSYjs9jocBWYyqHzg1UhCGbSFNeCq2oCLQTXt771wPMlidVXd301kHMJ9O5fbU01kc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(396003)(346002)(366004)(376002)(136003)(451199021)(7696005)(71200400001)(41300700001)(9686003)(53546011)(38100700002)(44832011)(26005)(6506007)(52536014)(5660300002)(83380400001)(186003)(38070700005)(2906002)(33656002)(86362001)(122000001)(8676002)(8936002)(55016003)(478600001)(76116006)(66446008)(6916009)(4326008)(64756008)(66946007)(66556008)(54906003)(66476007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1JmcVBXbnNGZzE1WlpvVWUwb1pOY2xlNW0rSzJwdVBTQ1NYcXRRRUYwSEtC?=
 =?utf-8?B?WnREQmVYWFhNb25QaWRXaFI2azVLaGxPRm1YSEpMNXNDV1lWaFNhK2I5VDlu?=
 =?utf-8?B?UjQ2dzFSUE85RlgwWkVXaEt4b0VaSDlWUDY1TlEwbTkzSUI0MzAzRXhTQk1i?=
 =?utf-8?B?UitzZWgxaUFkZzN3Z21PenNhYlZqc2lST2VUd0tCSi84WFVYNmNsNGlGZ1JS?=
 =?utf-8?B?bTV5MWR6b2liYitTcnVXczk2dU1JRUVqbDlGZVFLNDJqSUEyaTZLbGgzN3Vy?=
 =?utf-8?B?K3JqUGl0ZG5Wc2dzdGRXNmFZQlNWdHFLYU5VcjVpSmFHSGVjYnBuVGJnSDE0?=
 =?utf-8?B?NTBscHNYM3JlMm1rMXdKS3ZMZlJiUGpWZml1aTNsTGlUb2c3UThVSE8zeUhL?=
 =?utf-8?B?Qm9VdkZuM0tzMkRiTDlTcnJnVjBTSkJZaTdvVkVySmlaVUVZaGtHbkozYkVt?=
 =?utf-8?B?a0JyenpFNU9abUNCc2xtSkZDcDlLTGlNUUtFNkU4T2U4SCtVL2JyUVcyRVRK?=
 =?utf-8?B?ZWY0RXFxbmNIVzVkd295dFkweGp1M2VRMXltQ3BXZmllUDdkaDdZSk9uYlZ6?=
 =?utf-8?B?UnFWelVXWUpkUzdxVUVTT0QzS0ZRc0FwWU9mVjRrcUdDVU9rT3lXM0FUcVBL?=
 =?utf-8?B?VlJTTzJnaGcwZFRFdUZuWm9rVHBCRDFDbHB6WE16VHlSS1FuYkhTSzBFSnd4?=
 =?utf-8?B?Vm42dk05QzJyMGM4K2JpVnc2VTNVNXZTRWlQTU1QRG8rZkVJcnZpUWxYT2RZ?=
 =?utf-8?B?SXErYlRLZkhXcElVWW1sRllzTSsyQzNGbFhqMHdIc0dpMTc0NTg4YmxBRWRK?=
 =?utf-8?B?OHJaam4xNkRYZGpUN2tKbnBDZUMrL2l2U3JLZm1TUzZJNlgxblNCTXlVQmY3?=
 =?utf-8?B?MEwyclpoaTdDdXg3Mmw3ZnE3QmtqNVhIN29PcGdQemhnQmV5T2VScDlBRnpn?=
 =?utf-8?B?VHpXR216ZXoxMW9pT3dnK0hnN3UrS1VHbEhyVytiVGJUbFk0NEJsQ2E4Vm1H?=
 =?utf-8?B?MjNnY3VYZmxIampFNFN2d0tQM0JFY0dLdDJXWW1RaHgyTkQ2OG1qb2FuWmtz?=
 =?utf-8?B?QTFTVExTelY0dU5waTdqb2Erako4a1Y0cWF5Uld4b05EeWd4Yzd2bStYKzZX?=
 =?utf-8?B?Kzk2K2w3QmhxQmNSQTUvVmtoVDNGc2lwZ0pvSTdtM2pCQkZGN2V0eitlTEpp?=
 =?utf-8?B?a3dDSmxNd1BoRGl0T3hTQjJuWFd3c0JvcEIvekZDNi92ZFdYZEEwZDNuOThz?=
 =?utf-8?B?ZVdTU0duZGRnWTJKK3g3S2ViaGxVc3FXcWpwTk5hcHE0SWt6aXZaVUpsQzJD?=
 =?utf-8?B?d1NWOXJBUmFuKzlabEdqVjVBWHl0MUNjMUV5RjJaaXBvTW1YTVlzNnFsSGd6?=
 =?utf-8?B?ZGkvTE5kZTBtZmZ5M2VLK29haVFndzFlUmlvQzRYS05zMHVROVZBOGV1ZjFN?=
 =?utf-8?B?bHJZbHNJZkdRZVVnM0FzVDB1NDVrTDFLOGZLcWdHSGRLNi80SU8rb3hDTm1q?=
 =?utf-8?B?cURENlJiMmJPUDE3eG5MeDJrcHc0MVdOV2FQUHBiM00wb0Y2YVlWcE83bFA0?=
 =?utf-8?B?KzNMTVg4UVZZVHNtWFVqZll4RUxVMjBFalh2K09VQ0tCU0o3cllKd0ZFTDV4?=
 =?utf-8?B?U3BZVmRXNDUvYTRINHVYNURtSVhkbUE2Qnp1UTJvRDZ6OThLQWRxZGx6bXB3?=
 =?utf-8?B?Sy9wa0E3dWJPY3hpbkxFQjF6NWFsYUQ3RXJTK1pRM3ZwSTBzVzFnZVJpakYw?=
 =?utf-8?B?TWRNeFNNSmlsWnJNc1dVTEpxQ3NTYnhHTnlUSTVJc0VOMCtsMitsYXBqS1FR?=
 =?utf-8?B?b2NYTi8xaDJLTFpKMzFZa3ZIa1FDN0hWUnl1eFIxcVJ0ZGxuSGFocG1sRGxp?=
 =?utf-8?B?UG5jSEtLQks5UXRPMDlJeHVoTGN1SkRQMmJveksyMmtqS3RKTVRrdGhDSmZu?=
 =?utf-8?B?SmxxT1JSMDFqUDhleVMwME5oSGhUWVNDTXlJbW8vMFd2bW9wdE9GZ3JHblp3?=
 =?utf-8?B?UmFFQzlsYjVFN0tkZkUwYkN0bEdkMS9WSmZoN1FoUTRtNjhvSWJubHB6UDB0?=
 =?utf-8?B?NVNDNTdBcnZZWUNJcWNqY1NrNWxCUE55bndkaE9NNUlFZ0RQMWJlLzN5QjVh?=
 =?utf-8?Q?jXwiPtmOTDw//IjVmAweKkMd8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b062d79-f4ca-4dad-6231-08db58318c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 06:23:22.9606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sk0iVcjKFiT98eZZd8GHeH2JnvFdKjQhVHqzHXxqfPT426vt39ecsQtTKexp+zK96mVcvi0Zw2qQ7u45MH8p5eVf0ocKLiWHbSuAjdT2kAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IE1vcnRvbiA8
YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTksIDIwMjMg
NDowMiBBTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+
IENjOiBtYXNhaGlyb3lAa2VybmVsLm9yZzsgdmJhYmthQHN1c2UuY3o7IHBldGVyekBpbmZyYWRl
YWQub3JnOw0KPiBuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbTsgcGF1bG1ja0BrZXJuZWwub3JnOyBy
cHB0QGtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFsIFZpcm8g
PHZpcm9AemVuaXYubGludXgub3JnLnVrPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpbml0OiBB
ZGQgYmRldiBmcyBwcmludGsgaWYgbW91bnRfYmxvY2tfcm9vdCBmYWlsZWQNCj4gDQo+IE9uIFRo
dSwgMTggTWF5IDIwMjMgMTE6NTM6MjEgKzA4MDAgQW5ndXMgQ2hlbg0KPiA8YW5ndXMuY2hlbkBq
YWd1YXJtaWNyby5jb20+IHdyb3RlOg0KPiANCj4gPiBBdHRlbXB0IHRvIHByaW50ayBhbGwgYmRl
diBmc3R5cGUgYXMgcm9vdCBnaXZlcyB0aGUgZm9sbG93aW5nIGtlcm5lbCBwYW5pYzoNCj4gPg0K
PiA+IFsgICAgMS43MjkwMDZdIFZGUzogQ2Fubm90IG9wZW4gcm9vdCBkZXZpY2UgInZkYSIgb3Ig
dW5rbm93bi1ibG9jaygyNTMsMCk6DQo+IGVycm9yIC0xOQ0KPiA+IFsgICAgMS43MzA2MDNdIFBs
ZWFzZSBhcHBlbmQgYSBjb3JyZWN0ICJyb290PSIgYm9vdCBvcHRpb247IGhlcmUgYXJlIHRoZQ0K
PiBhdmFpbGFibGUgcGFydGl0aW9uczoNCj4gPiBbICAgIDEuNzMyMzIzXSBmZDAwICAgICAgICAg
IDI1NjAwMCB2ZGENCj4gPiBbICAgIDEuNzMyMzI5XSAgZHJpdmVyOiB2aXJ0aW9fYmxrDQo+ID4g
WyAgICAxLjczNDE5NF0gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IFZGUzogVW5hYmxlIHRv
IG1vdW50IHJvb3QgZnMgb24NCj4gdW5rbm93bi1ibG9jaygyNTMsMCkNCj4gPiBbICAgIDEuNzM0
NzcxXSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA2LjQuMC1yYzIr
ICM1Mw0KPiA+IFsgICAgMS43MzUxOTRdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMg
KFEzNSArIElDSDksIDIwMDkpLA0KPiBCSU9TIDEuMTAuMi0xdWJ1bnR1MSAwNC8wMS8yMDE0DQo+
ID4gWyAgICAxLjczNTc3Ml0gQ2FsbCBUcmFjZToNCj4gPiBbICAgIDEuNzM1OTUwXSAgPFRBU0s+
DQo+ID4gWyAgICAxLjczNjExM10gIGR1bXBfc3RhY2tfbHZsKzB4MzIvMHg1MA0KPiA+IFsgICAg
MS43MzYzNjddICBwYW5pYysweDEwOC8weDMxMA0KPiA+IFsgICAgMS43MzY1NzBdICBtb3VudF9i
bG9ja19yb290KzB4MTYxLzB4MzEwDQo+ID4gWyAgICAxLjczNjg0OV0gID8gcmRpbml0X3NldHVw
KzB4NDAvMHg0MA0KPiA+IFsgICAgMS43MzcwODhdICBwcmVwYXJlX25hbWVzcGFjZSsweDEwYy8w
eDE4MA0KPiA+IFsgICAgMS43MzczOTNdICBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDM1NC8weDQ1
MA0KPiA+IFsgICAgMS43Mzc3MDddICA/IHJlc3RfaW5pdCsweGQwLzB4ZDANCj4gPiBbICAgIDEu
NzM3OTQ1XSAga2VybmVsX2luaXQrMHgxNi8weDEzMA0KPiA+IFsgICAgMS43MzgxOTZdICByZXRf
ZnJvbV9mb3JrKzB4MWYvMHgzMA0KPiA+DQo+ID4gUUVNVSBjb21tYW5kIGxpbmU6DQo+ID4gInFl
bXUtc3lzdGVtLXg4Nl82NCAtYXBwZW5kIHJvb3Q9L2Rldi92ZGEgcm9vdGZzdHlwZT1leHQ0IC4u
LiINCj4gPg0KPiA+IFRoaXMgZXJyb3IgaXMgYmVjYXVzZSBleHQ0IGlzIG5vdCBidWlsZGluIGFu
ZCByZXF1ZXN0IGV4dDQgbW9kdWxlIGZhaWwuDQo+ID4NCj4gPiBBcyBhIGhpbnQsIHByaW50ayBh
bGwgdGhlIGJkZXYgZnN0eXBlIGF2YWlsYWJsZSBmb3IgcHJvbXB0cy4NCj4gPg0KPiANCj4gU2Vl
bXMgcmVhc29uYWJsZS4gIEkgcmV3b3JkZWQgdGhlIGNoYW5nZWxvZyBhIGJpdDoNCj4gDQo+IDog
Qm9vdGluZyB3aXRoIHRoZSBRRU1VIGNvbW1hbmQgbGluZToNCj4gOiAicWVtdS1zeXN0ZW0teDg2
XzY0IC1hcHBlbmQgcm9vdD0vZGV2L3ZkYSByb290ZnN0eXBlPWV4dDQgLi4uIg0KPiA6IHdpbGwg
cGFuaWMgaWYgZXh0NCBpcyBub3QgYnVpbHRpbiBhbmQgYSByZXF1ZXN0IHRvIGxvYWQgdGhlIGV4
dDQgbW9kdWxlDQo+IDogZmFpbHMuDQo+IDoNCj4gOiBbICAgIDEuNzI5MDA2XSBWRlM6IENhbm5v
dCBvcGVuIHJvb3QgZGV2aWNlICJ2ZGEiIG9yIHVua25vd24tYmxvY2soMjUzLDApOg0KPiBlcnJv
ciAtMTkNCj4gOiBbICAgIDEuNzMwNjAzXSBQbGVhc2UgYXBwZW5kIGEgY29ycmVjdCAicm9vdD0i
IGJvb3Qgb3B0aW9uOyBoZXJlIGFyZSB0aGUNCj4gYXZhaWxhYmxlIHBhcnRpdGlvbnM6DQo+IDog
WyAgICAxLjczMjMyM10gZmQwMCAgICAgICAgICAyNTYwMDAgdmRhDQo+IDogWyAgICAxLjczMjMy
OV0gIGRyaXZlcjogdmlydGlvX2Jsaw0KPiA6IFsgICAgMS43MzQxOTRdIEtlcm5lbCBwYW5pYyAt
IG5vdCBzeW5jaW5nOiBWRlM6IFVuYWJsZSB0byBtb3VudCByb290IGZzIG9uDQo+IHVua25vd24t
YmxvY2soMjUzLDApDQo+IDogWyAgICAxLjczNDc3MV0gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2Fw
cGVyLzAgTm90IHRhaW50ZWQgNi40LjAtcmMyKyAjNTMNCj4gOiBbICAgIDEuNzM1MTk0XSBIYXJk
d2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUw0KPiAx
LjEwLjItMXVidW50dTEgMDQvMDEvMjAxNA0KPiA6IFsgICAgMS43MzU3NzJdIENhbGwgVHJhY2U6
DQo+IDogWyAgICAxLjczNTk1MF0gIDxUQVNLPg0KPiA6IFsgICAgMS43MzYxMTNdICBkdW1wX3N0
YWNrX2x2bCsweDMyLzB4NTANCj4gOiBbICAgIDEuNzM2MzY3XSAgcGFuaWMrMHgxMDgvMHgzMTAN
Cj4gOiBbICAgIDEuNzM2NTcwXSAgbW91bnRfYmxvY2tfcm9vdCsweDE2MS8weDMxMA0KPiA6IFsg
ICAgMS43MzY4NDldICA/IHJkaW5pdF9zZXR1cCsweDQwLzB4NDANCj4gOiBbICAgIDEuNzM3MDg4
XSAgcHJlcGFyZV9uYW1lc3BhY2UrMHgxMGMvMHgxODANCj4gOiBbICAgIDEuNzM3MzkzXSAga2Vy
bmVsX2luaXRfZnJlZWFibGUrMHgzNTQvMHg0NTANCj4gOiBbICAgIDEuNzM3NzA3XSAgPyByZXN0
X2luaXQrMHhkMC8weGQwDQo+IDogWyAgICAxLjczNzk0NV0gIGtlcm5lbF9pbml0KzB4MTYvMHgx
MzANCj4gOiBbICAgIDEuNzM4MTk2XSAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzANCj4gOg0KPiA6
IEFzIGEgaGludCwgcHJpbnQgYWxsIHRoZSBiZGV2IGZzdHlwZXMgd2hpY2ggYXJlIGF2YWlsYWJs
ZS4NClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4gbW9yZSByZWFkYWJsZSBub3cuDQo+IA0KPiA+
IC0tLSBhL2luaXQvZG9fbW91bnRzLmMNCj4gPiArKysgYi9pbml0L2RvX21vdW50cy5jDQo+ID4g
QEAgLTQyNyw4ICs0MjcsMTkgQEAgdm9pZCBfX2luaXQgbW91bnRfYmxvY2tfcm9vdChjaGFyICpu
YW1lLCBpbnQgZmxhZ3MpDQo+ID4gIAkJcHJpbnRrKCJWRlM6IENhbm5vdCBvcGVuIHJvb3QgZGV2
aWNlIFwiJXNcIiBvciAlczogZXJyb3IgJWRcbiIsDQo+ID4gIAkJCQlyb290X2RldmljZV9uYW1l
LCBiLCBlcnIpOw0KPiA+ICAJCXByaW50aygiUGxlYXNlIGFwcGVuZCBhIGNvcnJlY3QgXCJyb290
PVwiIGJvb3Qgb3B0aW9uOyBoZXJlIGFyZSB0aGUNCj4gYXZhaWxhYmxlIHBhcnRpdGlvbnM6XG4i
KTsNCj4gPiAtDQo+ID4gIAkJcHJpbnRrX2FsbF9wYXJ0aXRpb25zKCk7DQo+ID4gKw0KPiA+ICsJ
CWlmIChyb290X2ZzX25hbWVzKQ0KPiA+ICsJCQludW1fZnMgPSBsaXN0X2JkZXZfZnNfbmFtZXMo
ZnNfbmFtZXMsIFBBR0VfU0laRSk7DQo+ID4gKwkJaWYgKCFudW1fZnMpDQo+ID4gKwkJCXByX2Vy
cigiQ2FuJ3QgZmluZCBhbnkgYmRldiBmaWxlc3lzdGVtIHRvIGJlIHVzZWQgZm9yIG1vdW50IVxu
Iik7DQo+ID4gKwkJZWxzZSB7DQo+ID4gKwkJCXByX2VycigiTGlzdCBvZiBhbGwgYmRldiBmaWxl
c3lzdGVtOlxuIik7DQo+ID4gKwkJCWZvciAoaSA9IDAsIHAgPSBmc19uYW1lczsgaSA8IG51bV9m
czsgaSsrLCBwICs9IHN0cmxlbihwKSsxKQ0KPiA+ICsJCQkJcHJfZXJyKCIgJXMiLCBwKTsNCj4g
PiArCQkJcHJfZXJyKCJcbiIpOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gIAkJcGFuaWMoIlZGUzog
VW5hYmxlIHRvIG1vdW50IHJvb3QgZnMgb24gJXMiLCBiKTsNCj4gPiAgCX0NCj4gPiAgCWlmICgh
KGZsYWdzICYgU0JfUkRPTkxZKSkgew0KPiANCj4gQW5kIEkgYWRkZWQgYSBsaXR0bGUgZml4Lg0K
PiANCj4gLS0tIGEvaW5pdC9kb19tb3VudHMuY35pbml0LWFkZC1iZGV2LWZzLXByaW50ay1pZi1t
b3VudF9ibG9ja19yb290LWZhaWxlZC1maXgNCj4gKysrIGEvaW5pdC9kb19tb3VudHMuYw0KPiBA
QCAtNDM0LDcgKzQzNCw3IEBAIHJldHJ5Og0KPiAgCQlpZiAoIW51bV9mcykNCj4gIAkJCXByX2Vy
cigiQ2FuJ3QgZmluZCBhbnkgYmRldiBmaWxlc3lzdGVtIHRvIGJlIHVzZWQgZm9yIG1vdW50IVxu
Iik7DQo+ICAJCWVsc2Ugew0KPiAtCQkJcHJfZXJyKCJMaXN0IG9mIGFsbCBiZGV2IGZpbGVzeXN0
ZW06XG4iKTsNCj4gKwkJCXByX2VycigiTGlzdCBvZiBhbGwgYmRldiBmaWxlc3lzdGVtczpcbiIp
Ow0KPiAgCQkJZm9yIChpID0gMCwgcCA9IGZzX25hbWVzOyBpIDwgbnVtX2ZzOyBpKyssIHAgKz0g
c3RybGVuKHApKzEpDQo+ICAJCQkJcHJfZXJyKCIgJXMiLCBwKTsNCj4gIAkJCXByX2VycigiXG4i
KTsNCj4gXw0KPiANCj4gDQo+IFRoaXMgZnVuY3Rpb24gbm93IHVzZXMgYSBqdW1ibGUgb2YgcHJp
bnRrKCkgYW5kIHByX2VycigpLiAgUGVyaGFwcw0KPiBzb21lb25lIHdpbGwgZ28gdGhyb3VnaCBh
bmQgcmF0aW9uYWxpemUgYWxsIG9mIHRoaXMgc29tZXRpbWUuDQpZZXMsIEkgdG9vayB0aGUgcHJp
bnRrIGZpcnN0IGJ1dCBnb3QgYSB3YXJuaW5nIGZyb20gY2hlY2twYXRjaC5wbC4NClRoYW5rcy4N
Cg==
