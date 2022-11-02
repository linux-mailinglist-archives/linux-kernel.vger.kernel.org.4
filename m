Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE5615C00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKBFwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKBFwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:52:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4FA1F2C6;
        Tue,  1 Nov 2022 22:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0UjsJg7XwiNSTmKlYvPMFnI02rZYNDjkWA+A09Sdv1z95iTGYtXRW3i5ZmrwVM2TRefwhbu2ZPMGGuhE6jexlnlrVVrnw65jhhT+l43NaryyuHR8deYBaoYPr7R1JNZ+XnEwEn51NkhLZFY162A1qpgEYEZBOWCkDyryNWS+C051bXLyKpcdktGYkL0UpnnICzAWj7+lpy+w4XgrDh6S505ZXSmXWyIswgwbM9X5hljg3mzbrN08faHVnbASgi/yxyVsgfDm2VYhA6R47hB+na+PF667ouQ2gm+4Y7CcjHO6BD9ikKYFCavWIQBQgf77hQ+Pml7xf6Ynfq4zvVywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGF3MkshTCzxrEZdxtvGz2BjVbFUsFOzAjodg3+47b8=;
 b=g1BsRMQoyhsjn35dIBh6GOD5BRk6bwvlquMLf6rNDRkef0zYrTFtdhXQbtxi+MB1Pn41oq0VRzLVO5wy66+doYKs7LcId0rr/xmDydLLubifGpkoS2hCEIKAwOoijDWuU54r2vY4yZTCnnexM+PTfPNw96mBTO8cJOFM1d3f2UmEeWiH38aQiyjmDxoB4ApHThqlcCxhhS/N5EM2olDCx3KqISiHGbBIKQijF4ZewTAf06WOG5PVjyl7k2TDCLL9KxUB8mNcCc2JKkVEYzfsW2+u0JGNSV2IPV3H2GTakORB1N/K4ifh9N6ab7FpJdgi28cbLsoLbAZjHNLg28tuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGF3MkshTCzxrEZdxtvGz2BjVbFUsFOzAjodg3+47b8=;
 b=hZAejlVHaD3ou+EtColkfYFaqwX+pu2/7iA4muO1fRS4SKxAN1fVljL7M5X/BOfbqJ69eo88OaCwt+xx+ABn//JOs8lGMsZUxtG1C3F3lfHlb3XsTR6A0CzcFwZN4YEpsVWL9AO9aNmd87SEVNDX41ykXLTW6LkV9PbHIGRNz3UGF7EtjYKdWN+8Hyvvd+DaUYR8jkIWZblQfpx+974q32zsCpCY/1tYPn4iIEyBqrPdbAjKB9Ef4cvsOc0UUBz3vHuuO+kkIBw/HoJlv44kQY++HlbhJ5A/yH8FAV/JKUWYU9E/oxwZAIXr+YLCNayCID/jFYKlVGD68DABalzmkw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:52:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:52:31 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 06/30] nvme: Use kstrtobool() instead of strtobool()
Thread-Topic: [PATCH 06/30] nvme: Use kstrtobool() instead of strtobool()
Thread-Index: AQHY7jcIEN4O/nCM1EeRkLbRQ350Lq4rIimA
Date:   Wed, 2 Nov 2022 05:52:31 +0000
Message-ID: <c207c205-b3c5-3025-691d-8bc98fd611ed@nvidia.com>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7947:EE_
x-ms-office365-filtering-correlation-id: 24a67944-27bd-4e2c-f056-08dabc966ed3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxejPDpqBpfNb1hB3KZVYvts8hOqUHR9grbjuUsiLd4YOD7OFJogOBoB/wLo6n/QTP5N/l2UKwP2PIzOYWYHzoxU4z6cWPOgtiYpjLL00INZLAFT4YrQO/B8Jvjq+Qsh0cjsSEyA2hzphkMpmYQDIvTr0z4qgj7YBI/8Mm7cX/2lKo4CjPA/2ztV0Ac1ktOuhIVY5TGQ0StJrE5r9wLt98Fcw34co/Y8dNmHH6+3NDiJ92Iqcz+dOBooL5YmrdeYWgfdfWj/9lAvfeEFi4vRs/5gyCKTlfVQ2vVZH+BP7+cJhV6WoKt+pcdgkxdjnhquovj6UhhAD5XoBJaLqYGXftTI6rwFOmPRwuKpG5EpQ3cyI4nmZxbXJSkp+/Oj158ppRO/QDL6lb9VLP8d1wnH4MC/4v2tprAb9M1S+tUJN5hZO9vD5rcK9pqzL7MkBPGoOlE78/BRqPAMJ/ZzW5p2ilK22QF/StclAfJUYDUqpK1jBDUmM/00f7KEo1CvYZ3DCFLKlFwKuxiNmhwAFZxTvxpEezSN2bRG/4QUhFOnNFfLkcvq/W9OngYmmXRm3BpfBk8dphtuWTZnmUUL8vgBywj3mDtwdwaa55YrUOj+LYYi5Zfz/ngnNOIQB6aX3nUPAnBRvamES56kQuphkQldGiCpDjEFqzTtzF6ISyJDz7uGCHX5ZqUp33mbmw/KFVArfv929YOKaf8ringqFj+kQn56Nq8yi6HUmOO33tvmxl/m7AB45XP7GCd2Mut3kD+Vuto6ceJisQFkdfPnDREKbmTGvPlsn5iR2GbArpn5u3oPTERbbCGayVMt6x9nMCLHsOfYnYp//7UQq28djuRuWu6fLbHjkEtwKyRKbJvq01W/cnKI3yYNB7CCEr1CP9dOssPbbWmeGoPexiZvXe6MlqtTF52RIkStksK8hhzvEpY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199015)(86362001)(31696002)(83380400001)(38070700005)(122000001)(38100700002)(4744005)(2906002)(5660300002)(8676002)(66946007)(41300700001)(76116006)(66556008)(8936002)(66476007)(66446008)(64756008)(4326008)(6506007)(6486002)(186003)(6512007)(478600001)(54906003)(110136005)(2616005)(53546011)(966005)(316002)(91956017)(31686004)(36756003)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVpuakdZaE04Q2E3dWM4dHdxY2RPbGhBR1ZYUGxMWXlscFZzSEs5TmQ2a2FX?=
 =?utf-8?B?M1pqTmhVS1p0dXczTzVpbnJJbFBWYnZ4SDlUWEFwSEU0NDhZWXowYmcwbG9j?=
 =?utf-8?B?NUt4Z2xsTlhIZTkvL3RCRy8ySFZIaVo2YUxhQWkyM3ZVazU5L29rNS81ZUZI?=
 =?utf-8?B?ZXhpT3lrZzdJY1ZnT0ZHNi92UHFrUXIxWmVMSml2SGtTYWhad2I1RFl0dGcx?=
 =?utf-8?B?dGdvQXIwQ1Z1b1YrV1ZrZXkvdk1jdENlNXBtb3psK0hYbnZKdkZ2UVN0eVJ2?=
 =?utf-8?B?dlpiSDJGQjRxT1JQNlNSTFBnSVFnTnVycDBpd3hQa0U3ZDQ2Skw1WHFUWC9M?=
 =?utf-8?B?dHJaMm8vUWxpQTFTT0txbUQyanBPVEpJYi9LZGcrSkFmaXBKRVJJSVlYeVNW?=
 =?utf-8?B?NkhLcjZKb25yL3d3UmRtTUNWY3V1c0dXbytFYWZFUm5JcFBubWhuVGgrK3px?=
 =?utf-8?B?WWRQaGx5MW4ydzJVMy9oVDQ5dHBJVEZieXMvRDB5UzJKSUlmTVliTDlteVFu?=
 =?utf-8?B?WWhlVmhtZ0FqT1pmekt3UWhQRzRzWVFJLzFkSFdHeEdmbVJSZXRzQXVqVkNv?=
 =?utf-8?B?am5wd1JMRGxRTnhXdlZLR09iS3M0S3U1UGY0WmcrOGgvSnBpRHp5NTlyenVJ?=
 =?utf-8?B?Sng2emlMd1pyQlpGL3RhU1lHMkhEUm5BdHV3RVpvTUdQSWtuVE1WblY0QmVD?=
 =?utf-8?B?eWdERW5NRjNnRVlNQzloNTNWOSs1ZVU1RUc3aWh3SFd6aEZZN0Vqa0EzbU1h?=
 =?utf-8?B?eWozWVFra1o3K1lTZWVLc3Zia2R0MEtHTFFnUTFBQllaUzhSWDB5U09kZmJ0?=
 =?utf-8?B?bEVZQ21MM3kyUWRTcFloSlFSSjZaczU3Z3I2aWZxNUlZaURlS1FRVkVtMVRi?=
 =?utf-8?B?RXVTOHNBM2c1TFZOUE9Pc096TjhSQ0hBaFhBdlpKTFRaQ2lEUlh1Wmw1ak05?=
 =?utf-8?B?cE9GVUxHKzlzeW50ZUNRaWcvTnBYckpQblhLZ0VYdlBjMTl1cWllb0ZsYUFv?=
 =?utf-8?B?NHNwZCt0bXlVY3NGR2pscy9CUXBsc1VOZlRVVlp3M3pma3huc1JXQldya3BP?=
 =?utf-8?B?dUFLUmFtd2Mrd1dRU3JjemNCUk9DbzNkOFBNRUVobVBkblZrdjFTUERaeENo?=
 =?utf-8?B?TmtZNmhYa2RWQThiNDBybWg5YlBkVjIrQndocTJYK0g1UHRydklZZ0N4U2Y0?=
 =?utf-8?B?c2dCOVZpdTVTZ05CNllseUNDUGVQRVlob2c3cWNwSlV6UHhSMDN0UzdDK3Uy?=
 =?utf-8?B?Y1ZUYkxOT3g3bHNRbWZzU1JHYXhHU1NkdzBvaWtaaHZTZHhKNzRwZGd5eERT?=
 =?utf-8?B?ZFVwTVo3dEtNYWpkMVYwSHp6VjlwYVUzVm5ZaUtCYWhrZXRNNlRWR3VkUHFK?=
 =?utf-8?B?cWx3bGVQK2wwZDExTzZ0M25kTnBzL0M1V0JiSzNQM05jRm9XVmFRZVJyVWE5?=
 =?utf-8?B?ampGUlZQUzB3SFg2b1FJeHRqNktuY25GU3dKelQrbVhxSWJpYUxLVW40dGll?=
 =?utf-8?B?eVlqa1hXcVhKbFBxRGsrcTJCY2hDMGJ2OGhaU0dmbmFVbnJRalNPOXlLUlV6?=
 =?utf-8?B?MVNNS1lyNU9TZGpqZjV1b1kxOENrU0s4Vk5KWHVNMlBYamRTQk1BbmJBWG05?=
 =?utf-8?B?NU5rVloyNzY2WEJscVAzcjBXUXcwZDZzNDBjN0tnYk8rSTFCT2d6TnI3bklq?=
 =?utf-8?B?TTFvQ3FXdUllcnU4RjhUdGtVSThXbktXbEVaSDlhSVNGbC9ScGNkZEx3WVh2?=
 =?utf-8?B?WHJTeXYvQXd3RHdMejlqb1NOeWhDSUpvVnhOaldsL01rT3ZhMGdWT1FpVUE1?=
 =?utf-8?B?M2g1bkNtTlBWdTRyamtFSDQ1bE9Vd2JXNVpuaE1WRTUxL0ZqSFBVR2VDSHRB?=
 =?utf-8?B?OEpERjNMSnZtelB3cHFETlZ0KzRzankrR2luU2ZZSHh1SmFqZUpqZkRjV1o0?=
 =?utf-8?B?WDNZSnNjQ1RoMjdha2VpYmw5MXNIWndFWjZKZ2lxUnk1c1h3eS8zVm1USVNH?=
 =?utf-8?B?dkdMMkl1S05PWGp6UW11MGVDK0tMVU1sNkZFV1VqdUVOUU9YQ00veXhzckdq?=
 =?utf-8?B?Q3dYeitodnJSaXpENjVCWkxGeUh3ZjFDWVd5YVdFck13OUlCM0ZMZWNjcXMz?=
 =?utf-8?B?SUVoWi9uMW5WdlF1a3lZQVRFL3k1ZURPcFN2b3d6R2pSdlV3eWtKTUExSTl6?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B5DCE6C21D2024AAA46011496202603@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a67944-27bd-4e2c-f056-08dabc966ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:52:31.6533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVT5r8Gy0L3uqH4lF/d5zOxokbY04W/l5OzemgUqzhvN4NeIlY4PtO1VImZ3WPY/l+1w3rl0F/zutDYVaqR+5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMS8yMiAxNDoxMywgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBzdHJ0b2Jvb2wo
KSBpcyB0aGUgc2FtZSBhcyBrc3RydG9ib29sKCkuDQo+IEhvd2V2ZXIsIHRoZSBsYXR0ZXIgaXMg
bW9yZSB1c2VkIHdpdGhpbiB0aGUga2VybmVsLg0KPiANCj4gSW4gb3JkZXIgdG8gcmVtb3ZlIHN0
cnRvYm9vbCgpIGFuZCBzbGlnaHRseSBzaW1wbGlmeSBrc3RydG94LmgsIHN3aXRjaCB0bw0KPiB0
aGUgb3RoZXIgZnVuY3Rpb24gbmFtZS4NCj4gDQo+IFdoaWxlIGF0IGl0LCBpbmNsdWRlIHRoZSBj
b3JyZXNwb25kaW5nIGhlYWRlciBmaWxlICg8bGludXgva3N0cnRveC5oPikNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28u
ZnI+DQo+IC0tLQ0KPiBUaGlzIHBhdGNoIGlzIHBhcnQgb2YgYSBzZXJpZSB0aGF0IGF4ZXMgYWxs
IHVzYWdlcyBvZiBzdHJ0b2Jvb2woKS4NCj4gRWFjaCBwYXRjaCBjYW4gYmUgYXBwbGllZCBpbmRl
cGVuZGVudGx5IGZyb20gdGhlIG90aGVyIG9uZXMuDQo+IA0KPiBUaGUgbGFzdCBwYXRjaCBvZiB0
aGUgc2VyaWUgcmVtb3ZlcyB0aGUgZGVmaW5pdGlvbiBvZiBzdHJ0b2Jvb2woKS4NCj4gDQo+IFlv
dSBtYXkgbm90IGJlIGluIGNvcHkgb2YgdGhlIGNvdmVyIGxldHRlci4gU28sIGlmIG5lZWRlZCwg
aXQgaXMgYXZhaWxhYmxlDQo+IGF0IFsxXS4NCj4gDQo+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL2NvdmVyLjE2NjczMzYwOTUuZ2l0LmNocmlzdG9waGUuamFpbGxldEB3YW5hZG9v
LmZyLw0KPiAtLS0NCg0KSSBiZWxpZXZlIHlvdSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoIHRob3Jv
dWdobHksIHdpdGggdGhhdCwNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
