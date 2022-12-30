Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF7365965F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiL3Ik6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiL3Ikz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:40:55 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2099.outbound.protection.outlook.com [40.107.247.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45180DE87;
        Fri, 30 Dec 2022 00:40:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLyAdIEURutOOF5tJuKXPhPXy4v3vWuvP1v9kgsSEQf17rT5cLhZlPoVjgaE9XQVRRUZP175Lp2trfHO3ddpwXJx+gh8pP8LmOhC6D3GxWr6toVyepPnCKeNmaqHdt4zzqjU5mtncnvBls8gr7xdabC49QxX76gKq82Y6W/6AxbkGtd0nf+YGmw6wgBpetlpfxr4L3LRoMkHX8hLk4yH4xTxwA1nnjZH5AcoKg8RT/IGi+dG5k1rRkvUX0Y19wMVf+wOGQvLf54/3dNiKZdRigLn/nVQBARwSzCDWYztyjjoX/pTxQ6/bFCQNfY7FyBHAn/O5/R387Jx3wMLTB1CLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6IwOAGsOxGaG6taHnFFHPR/Cv4vwznJ1MW2Uct1wJU=;
 b=Cri82vhcP24TNVP+0zXAiivrVLPDFOlgI1DuqpVH6ClItaQ+gfMsJPZkQk7lhtmo6vBbbid28NTSGHIlZjmRz4/uyw6C5+VLYIltjkiSad/jAP1AKjKvhgZD1tb4gJyL5bjucTFN626AiA0wbcYpbw8pV/y4Vs3NOmSZCOTaMKDIVEHY6CoMWxFEeqgy3Ibjs7HxkfRQa/lGCQ2t+jy12EeQqK3SXXaWgmG0TTEiuxeuBgcPGm9mOyOruvjHFYDrmB86Dwwa+Jg8qXAvtFuHzIcoc7G7oFtzd6HfmtDflTGJ/SxjbPpRDDhNsrAJkxyltAqNsGAy4UDD42IQIZl3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6IwOAGsOxGaG6taHnFFHPR/Cv4vwznJ1MW2Uct1wJU=;
 b=D9TQB4QFjQqAqyJnYQr0+coEeq2YTmHqQlSjTauiJS2XPFNFEJ8CTaXki3cvWar81HfYQBEu3CKeHE2OzfHVPyppFKwhOnZQ72hGpfiAQsGvELQ9SdFTUuPagcB0oJWVwXL/Zk4b0AI67UkANARxirD1VGwLBpDlLzUE/HF/1xVZBSfVzuCTkUtkScKNJ3maCY9vtD4rocfVC7q2knjyk/ACBHvm2Br+9d0vyT+lAO6br8S9cW/CFyTWTnb/p37gpELxVy2uiS8PQBqdvb3FRBYgB1px0iqW6RePW0C2kuaZrwluz0NxXubuaxhKDgI1Hkd0y/UH9eSzKZ7nKWVCfQ==
Received: from VI1PR0701MB6829.eurprd07.prod.outlook.com
 (2603:10a6:800:194::19) by DB5PR07MB9513.eurprd07.prod.outlook.com
 (2603:10a6:10:48c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 08:40:51 +0000
Received: from VI1PR0701MB6829.eurprd07.prod.outlook.com
 ([fe80::49ef:2e4b:231d:9068]) by VI1PR0701MB6829.eurprd07.prod.outlook.com
 ([fe80::49ef:2e4b:231d:9068%9]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 08:40:51 +0000
From:   "Ankit 16. Kumar (Nokia)" <ankit.16.kumar@nokia.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] of: overlay: fix warning being reported as error in
 add_changeset_property
Thread-Topic: [PATCH] of: overlay: fix warning being reported as error in
 add_changeset_property
Thread-Index: AQHZEU6/hGSamWILd0mUYbTEl3Pjga6GMbZw
Date:   Fri, 30 Dec 2022 08:40:50 +0000
Message-ID: <VI1PR0701MB68298749C8133A7D69CFDBBFC9F09@VI1PR0701MB6829.eurprd07.prod.outlook.com>
References: <1671195782-23078-1-git-send-email-ankit.16.kumar@nokia.com>
In-Reply-To: <1671195782-23078-1-git-send-email-ankit.16.kumar@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR0701MB6829:EE_|DB5PR07MB9513:EE_
x-ms-office365-filtering-correlation-id: 3be6eda4-5e0e-4e80-9b70-08daea418e7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D+boumpRYrEXLQUw5NfThGe71wfUISnFGpJNe9lHOD3WuaHX9VA4BBfW5CJspt99rF+zKCFtPhVoQrgQ6K2ipqsSYl5CRpZ4RyfKzRanNg+JJIZ8wg2pjmNkyxr/g/94KVhBg7P/50m2cmv9mNU16CGjVlQ16nRHyseX9i0IOu2DXLI9sKn43QjtqBOzb9TT5AsE8hutxTDDmAiqmBGd0BBQNFzOBBFEikMaaQMc8k8EoJNKI/sgWZ8yQeLQqp7Pd5IPCsDz3mVZV/t6/5Q3LN3CzMImnl6uz3v8lKVT7nM1OBkvyDejZxPOpNS2v/PFud47chL4faknTepV39ZfkEKBOWsfS7r98LcXG5FmNDg+goCU7Vrh9anQeL2mnSPNEWKPpUkOHPeQBCjdMFT9Mbs9wTNZfN54cNCY4y1AQ+5EcCGhrEuk9QMNCyZDgmOc7niNrhKsrTbro3iTK6C85u765BquXBYZEEqtpIg9LIYUtq+gyEIv0FP9m6VWn8J5H6S8mjPzu4UuyFqqwy5G+mRKnd8pTB+Ke+tPs9zJQFW7UYzZB6PEnwdYAFg7jWhyiBAbdoWFtd6EC+4C0+VswP+p9EMr85IYLlcq1/3NJu7zussxYBz+uxBuk/lndYEdAvjHy5YjzejCNJohPKmP6kLF/2FCUxpM0MEIiEjfq7Ph6VdCLcuHGu13o455zHQ4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0701MB6829.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(316002)(478600001)(7696005)(83380400001)(38100700002)(6506007)(122000001)(110136005)(5660300002)(82960400001)(8936002)(2906002)(38070700005)(26005)(186003)(9686003)(71200400001)(55016003)(4744005)(8676002)(33656002)(41300700001)(86362001)(52536014)(66556008)(64756008)(76116006)(66946007)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek5SS05DOGl3M3N3VVJMZW52QjBUZ0hqNVRmY0grVXhwalIzTGJlSVdzbEI5?=
 =?utf-8?B?YzFjUnFYTm5jUE81Q2hnWXgzRU90T2s3MU01ZUxTbGh1LzQ1dlBETlU2Mkx0?=
 =?utf-8?B?a2RGZVh3b0oxZkx3QjVubUVVNEgvcUdEak16Smw3K294ckRnY20rTGc2d3Z0?=
 =?utf-8?B?eTVsOGdnTGxGa0o0VTRGTVB5S1JYNnlaTnRab1plSlRaVlhmODAwMUVpL1pW?=
 =?utf-8?B?d3lPN1VUVTRpWlpUY1NEU2ZzaXBvNXBiMHB4VTRVL210all0RmJjZVJ4blR2?=
 =?utf-8?B?UXI0VVVlUXk5L1ZrTVVUUGNJWW02RUdTRUpCZEVSVldQRUczekpseUtNQXR3?=
 =?utf-8?B?ckdSaCtiRmRZY2FFQ2dKVU44bENHSzh5UXltUHNlN2FadWVhSWp2QkM1bHA0?=
 =?utf-8?B?L0NDeVl5dGRCcFE5M28ybExQdTIvMnpvTTVtT2pTTm1uZEZZNnN6YXlhYnBv?=
 =?utf-8?B?RWhBRnBMQVBUQmxFeEtHZkxvUWhpbityWTN6YTBmQmpJOG9vdmZCMFIwaENL?=
 =?utf-8?B?N2VCUWJ3Y2tmODVrc0FkUDkrYXBtZDNNYWlHR1IvRFdqWCsrd1hvSnBWYkNj?=
 =?utf-8?B?L25vbzJzT3NzaEczc3paelI2UFJReDhhamZKVjY4cjlUTHY2OVhkdmFLU2lH?=
 =?utf-8?B?WktWVFZPUzdPN2tnK25ISVdBdWQ5RTAvejlrY1FHME9VZW1YR1FRVEJxT1FX?=
 =?utf-8?B?VkNiaDVEQndtVXYzQ05GSCtwRVlmNHY1cGxTWXhDL2JLRjBLTys5YjZTcEdM?=
 =?utf-8?B?aDVFZVVXNW14bG5aMTNFb0ZjV2ZacWs2NUZ0Mml2VmQyTlpxQWV1ZnViWkhE?=
 =?utf-8?B?VjBOR1pkMEVSRnhuTmZtWDBzdUt3Y09nT0N6Z1RuTEpYWDNTM3JDL0w3UTJ0?=
 =?utf-8?B?bkJzMGJjWnlSS2l5WGgrazhJVldsRzY3Mmc3U3NOUTBSNnhEWEd6QSsyZElI?=
 =?utf-8?B?cDZuRnJrcEVnWUYxV0V0QzhzQTZ4KytWWWRYSlRNRmJlaTZWSWZVNHEwR1BI?=
 =?utf-8?B?ZEVGZE4rUkxkS2VReHpLeGVYQnByV0pqd3A2RytQNTZLbk4vcnNheSs4cmh4?=
 =?utf-8?B?RWRzMFg5cGtaYjhacW53Z0plZURmQUJzYU5QelU5SCtXREJRVHNscnZucnBS?=
 =?utf-8?B?RWJNWjFRZCs2YlpQb1NtK2prWEs1UEFvTVFHZDlrNVN1UHB4VFozd2EyaThY?=
 =?utf-8?B?ajJVcnE0UHJXanM2NlR6N053Ry9QQjROdkZOeUFiVzVUVHA1R0ZzeU9tU3d2?=
 =?utf-8?B?aGs5U1Ixbmh6WGlQd3U4c2x5QmJZdys0ZERCVnB0ZkFSMitJTjVoYU1NL25U?=
 =?utf-8?B?UTlCQjZqd0tiWnIremlSVlVBdGM5dUJ4VkxSb0pMZDZITUhWYWNiUmNkL0pr?=
 =?utf-8?B?aEo5U3V3ZFc2ZmpNcHZEREd3VmdqYkYrTkFsQXduS0NNS1pPelhodmUvTUhH?=
 =?utf-8?B?cWJ2M3J5bFdkcy83TFZHaCtjNVRrZFZIbWJNT2tCUlZHNkJwMHNuV1M4dURG?=
 =?utf-8?B?RmU3TUVLOTVnYldpOE0vNUU4RFdjRU1LMkZtb0pnbU1ha3VNTHkvcmM1U2FW?=
 =?utf-8?B?bFg2UjVXaTNHMDdMUHZMQmFTTmpkOTR5WEwwNGc0MklPV2FKN2FIaU5Iekhl?=
 =?utf-8?B?dnE4TVR4UC96VUYzckdkS2tsNFpiT0dPckJ5aWNpN1B4eTNiTDVTNUVuVkU4?=
 =?utf-8?B?d3ZBUUl6QzFkRWZJb0NyQ2hqQ1dZS3RHZ0JEdUpNKzVBTTRpK3BCNThzT1Uv?=
 =?utf-8?B?bmpRNXY4d2tZV08wMS9uNUdOeXZuWWFFQXpSZHRteFpSVzQ2U2xaRnVJUndI?=
 =?utf-8?B?QTJ2YUphYU9IandDb2tadG92bmlJR053djk1ckYwYlJWVnNOZDdHbXZTVFVX?=
 =?utf-8?B?NjRyS01HSlEzUDJKaTZXbC96bzN3d2RkS3I2MksxY2hNelZxdlBUUWwrb2Vz?=
 =?utf-8?B?OTIwVlcvRzRGY1I4RWlHTnR3QlpUYnJMNWt1dWpMNm9iODhNV0tEaFBQd0dj?=
 =?utf-8?B?MW42ZVFLeGwxWEtTT01NaW9XT05uN0dkNTduOG50aUpud1p1MXlYT3h0RUJh?=
 =?utf-8?B?dFJZTkh6Y0loVzY1UzA3UmdjRVIySE9QL1ZpMGovQ0ZlMjZGdHludko0VTQ0?=
 =?utf-8?Q?28nsw7+UACAEbfotKc06cBieI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0701MB6829.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be6eda4-5e0e-4e80-9b70-08daea418e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 08:40:51.0051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtYANVA8DBeTQmNwNjW+Ok8K6CoB/HTcFQBzymqYqZi3nhbW3t1pmgQC0+X3pb5jWDoqgboSH6yZfs4LDJns9ae7ElWhwsqnd2f/hJ0VMmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9513
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGUgcHJpbnQgY2F1c2VzIGZhbHNlIHJlcG9ydGluZyBvZiB0aGUgaXNzdWUgd2hpY2ggYWN0
dWFsbHkgaXMgYSB3YXJuaW5nDQpGaXhlczogMmZlMGU4NzY5ZGY5ICgib2Y6IG92ZXJsYXk6IGNo
ZWNrIHByZXZlbnRzIG11bHRpcGxlIGZyYWdtZW50cyB0b3VjaGluZyBzYW1lIHByb3BlcnR5IikN
Cg0KU2lnbmVkLW9mZi1ieTogQW5raXQgS3VtYXIgPGFua2l0LjE2Lmt1bWFyQG5va2lhLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvb2Yvb3ZlcmxheS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9vZi9vdmVy
bGF5LmMgYi9kcml2ZXJzL29mL292ZXJsYXkuYyBpbmRleCBlZDRlNmMxNDRhNjguLjBkYTM5Yjg0
NjFlNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvb2Yvb3ZlcmxheS5jDQorKysgYi9kcml2ZXJzL29m
L292ZXJsYXkuYw0KQEAgLTM1OCw3ICszNTgsNyBAQCBzdGF0aWMgaW50IGFkZF9jaGFuZ2VzZXRf
cHJvcGVydHkoc3RydWN0IG92ZXJsYXlfY2hhbmdlc2V0ICpvdmNzLA0KIAl9DQogDQogCWlmICgh
b2Zfbm9kZV9jaGVja19mbGFnKHRhcmdldC0+bnAsIE9GX09WRVJMQVkpKQ0KLQkJcHJfZXJyKCJX
QVJOSU5HOiBtZW1vcnkgbGVhayB3aWxsIG9jY3VyIGlmIG92ZXJsYXkgcmVtb3ZlZCwgcHJvcGVy
dHk6ICVwT0YvJXNcbiIsDQorCQlwcl93YXJuKCJXQVJOSU5HOiBtZW1vcnkgbGVhayB3aWxsIG9j
Y3VyIGlmIG92ZXJsYXkgcmVtb3ZlZCwgDQorcHJvcGVydHk6ICVwT0YvJXNcbiIsDQogCQkgICAg
ICAgdGFyZ2V0LT5ucCwgbmV3X3Byb3AtPm5hbWUpOw0KIA0KIAlpZiAocmV0KSB7DQotLQ0KMi4z
MC4xDQoNCg==
