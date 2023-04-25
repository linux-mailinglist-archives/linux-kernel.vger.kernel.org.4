Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F56EDDC2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjDYINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjDYIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:13:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A24EED;
        Tue, 25 Apr 2023 01:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNDLmlD+H6Jhn9dGqETg/doRT5HpuDEgEJeufFhRKUOq/awySBvK6Bvvqh3OKCXYOZGLk8QFzOirrCqMme/5dORkXkBUXp0oRbTpClRQmo/ncPXvZOlR+EgkY6eGPo7CegeaoLer0bl3Ly0oz/n0QDIQ7rfZ6GDsWvkSd8vCqS+f4BxDVkcsh8ak/KcQ3AD1kmsQbM5wcaFwYzNbqrBs1j93CoUMAfRj2WeHBTmTok0ItJfyQH09vGQXtdlN2YTfslptdqZPFOo7M604ecqZTT860sKo8KxoolwD1vqKJ+SwXRiA8UK0efUdQpWQ6nrYkRA0Y7IBh0SN6YIMAmM3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xONG4PdXXNFagEhiOJysrBGyQcbas2YVIWKfVTtWcV4=;
 b=c0dsIuWU2Ng7lkuJHCtDL0vJ+YbEEVvW29ORH86Sba4qv9xYDU0dZZ+f/Ogps2I1bTMkvTFtpXhaOtpmaLXkJ6eCLWAFKO2piXVhPLEGklXJc7Q8ses9OMKTa/eq1Ocd2IPhMAhl1y8ZWB99PAMpWM0LxPITLtXf/KpJg3lU7c7D1efHy/0kolGQqocljGKPz7448vgVSuhlU0HyFUi5dsQ3tueonY3WNMUgeNmVKY85d/+uadwuThy6gim3gO+P0LNiGLSKkAGv03IIs5Gqu4BApJXt50YegchwQ7YqY6BmWnw1jd/PbmdHeO8nsU94aa++Al+SFiLbnbStJOgpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xONG4PdXXNFagEhiOJysrBGyQcbas2YVIWKfVTtWcV4=;
 b=ub0t5ZMQXcCMav1K4YoPyL9gZPAYW4jETVS8fTeUWwRLV5Jb7AHH9ZoDGiaiHfLng4hTZruYytEhz1AW+GdJdFN8erZWPGoxv1zG0zUyJKi7XSuSUeqFU2kMRleumKgHVfywBWWoHMhpDYiKNLyr9h884Ao8tFQOFYBE3sJR3jnwopptCHcWd1yw8vP4G4IKj5CS/9DkKLlMJwC8sJZlPbrqta+rh8H631raOefHuk4Akpl//s7KGTBNg1ZoUXRzK6n1/AVTPJT18wZYeUj3GuHzRhoOV7DcDjPtQAnH+ZXWrcE9Hm+JJoHsnTaSn6JBTcty8GEZ2PbsbKyxpPTOOQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 08:13:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%5]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 08:13:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Li Lingfeng <lilingfeng@huaweicloud.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH -next] block: don't allow a disk link holder to its
 ancestor
Thread-Topic: [PATCH -next] block: don't allow a disk link holder to its
 ancestor
Thread-Index: AQHZd0u02IE3eVCdDkam5FONer2fFq87rQIA
Date:   Tue, 25 Apr 2023 08:13:22 +0000
Message-ID: <2b466945-0ad1-43e9-5530-4bcd3d469e33@nvidia.com>
References: <20230425075558.3450970-1-lilingfeng@huaweicloud.com>
In-Reply-To: <20230425075558.3450970-1-lilingfeng@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5141:EE_
x-ms-office365-filtering-correlation-id: c1ad7fda-99d1-4f4f-d1c8-08db4564efda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LUAw8+k6yCLgKSZbwqZ3oitR9aUyqLmdgK4OXPKyWPCkeuMyf52NoiuQBVgRpCTe30gjyaeIf8JJiFNF4nvcf9xgzHl73hJ5B9Z7XLmOYlzlhK+ARLIiafNze5AM5i/ihSyQlrftZIwa41KaCEU/+kdsOlGFJ/HhWQY2VCp1ah0Ae89o2BTG2lFnODuig0Bi+kQynzRRlK3Z3AMLsOe4A1Bb2kM1TUMmdGdmuaxtHggmdT0hVrwslSS7Ih7zA+XGIcpVFkK+HDG8BaxujGBrwUvNdUoz94zzuG33nzzAaKVUnGrTiWXRfInMXxHsbC4AQw1cCXKo6qAW1wwHLbq0XbGe3bUul0VmDD7K896jV4pH0Y5nLlYpCozaMAZCkSvnF04rDmTwYazF/7uK4sFpG/Bxmp9WpeltCuLEhneuti6MQR9TA5sfcNBE6YmRi8uOAqeYfAwva4pcysYlCJFQ/ZuaFpLMNhnSsTKD0tWjDycfDxvFDNmwXth8nWviCMFlGacxObh66OKUmx3CaVJWrs3OJSyQpMzDP+lSFaMp99MReFZ+WM5Qg0fB4DrjyCjYMtZsaMZn2VWQ3U9D5QNPszMK28BzRLFPxHR/EAOcbYHAPcPzRQxe5VyBIkBEdBCYWrwA4p/Gptgk8weJoHJyMEp/bNKMTIoh1dfU41v+EWDzZCOJ9cD5yN8SS0Y9WPyM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(64756008)(66446008)(6916009)(4326008)(38100700002)(41300700001)(122000001)(5660300002)(8936002)(8676002)(36756003)(31696002)(86362001)(38070700005)(2906002)(4744005)(66476007)(66556008)(6486002)(71200400001)(53546011)(6512007)(6506007)(478600001)(2616005)(83380400001)(186003)(31686004)(54906003)(76116006)(91956017)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVlwY0lUODJEY3FTcFVRS205dXZvQytwRkNVYXJTS2dWN2wwK0pWQzFNRjNm?=
 =?utf-8?B?YVJrMno0bGFyMHZ5Qk5OdUlQSjhWSHdPWjduYStlaVBmYzVlRnJKVnlhNzNy?=
 =?utf-8?B?c3ZRY1VvVmJINDArMGJLeEQxRlgwK3cwMXVOS2o5VEdQaEoycUxhOGQxdlBR?=
 =?utf-8?B?MDY4QTV3TnlPR054ckxvcG00d3NUZmcxQUwvb09NVWs1dTFZTmorbWl1OFZ3?=
 =?utf-8?B?bnR5STlpMnVJZC9KNC92aE5seTY3NHBFdGRGVUdrRkNPdFBEaXZjd2dUOTRN?=
 =?utf-8?B?dWx5THhCdnhUbFhuWFpnZkkwZllCc3ZaUFUxKzkyZElRNzBXQ09pVnZGZ3R6?=
 =?utf-8?B?cWxpeUlob1l5MzFjN3FCMS82RzI0YXljejROa2RsVXNIeVdyMVpnbEZzUnJM?=
 =?utf-8?B?R0dkOU1xbU5kUVNsa1o4NzNoWEFwZGJGbnNja1JiVVZnRTJVVytzRDBWVk03?=
 =?utf-8?B?eTNTL1B4UU5QUDB0T2VYYUhqYkQ4RWZrZlpPM3BCQXhVRGFsNjBGaEJBNUVx?=
 =?utf-8?B?Vm4wV1ZwWitHUG0xV252OHl0Vk16VE5PeGVXRmcxbVBwek82SDY2ZUNkeVp5?=
 =?utf-8?B?WUFrWkg0T21URmZsQVFwbXlBWEhLbHR0MW1JMHBIZlZyS3diTTVnL3RMckI5?=
 =?utf-8?B?L3IxVndyVXBFaS9RbFpEQUQ0T08xWTltYi9ubGlzYkxJZU9NZEdpTUJQcElJ?=
 =?utf-8?B?eXEydE5qOHI4SEkzTWtYZ3U2T09EVUM1aEpZYmR1TkVZOURUeGh0OGc5bVQv?=
 =?utf-8?B?ZGFQMk4yanRuZjhJM1paOGVqbXZ2V2J3ck1KeHdKM2g0VDZaYzVzVE9RT0Nw?=
 =?utf-8?B?NHBuVFpnWmhMY1hzM3plL3dKUEl4ZUl0bGFpaFYvQVQ3MEUydmVOL1ZEZ0U3?=
 =?utf-8?B?WUJUY2tpdWFzcEJySE15aE9mcnJRdWNTZEV5Zk4zbEhDVzlZWGV3U0ljbVF3?=
 =?utf-8?B?TmwxWXA4MTRsL0FhNmNGd1VRTUN5MHlsVFgvQjlYQU5LZ05HUHRZUHpwVG55?=
 =?utf-8?B?U1NPWWZGQTI4enZYQTFrbkdHc3FwOU5JeFdPYklta240eks5M1FLRGs4YVhD?=
 =?utf-8?B?WEFlWnM0bGZ6SzZPbEJSc090ZHBQbTU4UktGNHVRN0t6L3NoTTRiY2lWVzBq?=
 =?utf-8?B?UlhOeDdOaDlNNjc2TVpUb0k2ZFQzNGlKZlJ6aTR0dEEzSDA3YWY5TDBCNEg5?=
 =?utf-8?B?b3RnL1JZUnJEQWRyV2Q2OGY2bVUwSzFkTE5oOUp4OFVNQlhoWTg1TXhSL1Zs?=
 =?utf-8?B?UjhCaDZZYWhndjZyNXRBL0JQNGFVRXRhMEtuMjBXU0hEcUQrd3lIeDNvVlhH?=
 =?utf-8?B?R1FWd0FLcWpzUGhGOFFlWkdNR2xjNUhLVVlnRFhhN25HVk1jc3RaRGtoV3NG?=
 =?utf-8?B?V2lWZTkwcUh3SDBRdDhwVDJ5L3djdzJwQ2pUUndBMUNzZ1U0cFQwYi9vejhR?=
 =?utf-8?B?WlBxbloraFVwWk41YjQ0T2lHVVRTTFgxNXZqSVI0V3EyUEZoNVBZNXZleE5Q?=
 =?utf-8?B?NzIrUVE5NmhNaEttNjd4QWpXY1pHSVNuN04rYk5DYkFsSmZlZE0vb0VyaDJB?=
 =?utf-8?B?bzRWejIvY1YvWjJaZlVReEtmNk1IbUZFVE9XdE9ob2NVNnozV0Zod1JhM3lm?=
 =?utf-8?B?Y1BiV1JaZ3p2ekN6cWJHNmt3QjkxK05MQ2VwWVRieGJhZFp5T01kQ1lBYU9r?=
 =?utf-8?B?MVQyTU5uL3RJWG05RGYxaE9lVThxZEFSZTE4eEdGSWdObUxpMnRHU1U0UGEy?=
 =?utf-8?B?U0hZc28rbFE5c2ZMOUY5V3gxSU0vdVpLQ0NVV2p1cDcwaTNQM0tVT2N5UkdT?=
 =?utf-8?B?dThha3NQU1BIU1lRTVVXVldxMURGQW4wQUNINWlOQTB4R2NGT211UWdOZC82?=
 =?utf-8?B?QnVlTTVRRGxGS3JxOWhOM2pQWWpnQ245ak1FNHY5U082bDVXc3ovb3VEckFO?=
 =?utf-8?B?a0s0NkZvbkJEVFVFQ1VjZlRsdEd0eGJDUFpsUkM4eDBuUDBIcUZYNnQ2Vk0z?=
 =?utf-8?B?UU12NTh3ZzhuMGtrbzJjNHBCNlhwbHdPc3p5azlBcFpmc1ZJaENta3hibkdp?=
 =?utf-8?B?K001TmxHQktRRWpxZ3pycTR4WUlUN3FwT3k0aEMzS3MzNXVHbFBKbTVQT2Rv?=
 =?utf-8?B?WForTlJNbmhKWHBiUVloZkkyaHRBbUQ5MjlORGlVazkwS2g5Rm5jeHgrdWx6?=
 =?utf-8?Q?3FgV8YmISiQdqgjKai+AFsKmKsLssSKoWYbIqQlZ5FuY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <215A1C1C04DD4145B7266E2F722CBAB2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ad7fda-99d1-4f4f-d1c8-08db4564efda
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 08:13:22.5960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+NKSPWrnFrwFtK/43R9e/erPfJ3tw/w4akWaY0B/3nqoOHOerwUCz5JIofMW0meYX6bRSGULysG0KFDahQpig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGksDQoNCk9uIDQvMjUvMjMgMDA6NTUsIExpIExpbmdmZW5nIHdyb3RlOg0KPiBGcm9tOiBMaSBM
aW5nZmVuZyA8bGlsaW5nZmVuZzNAaHVhd2VpLmNvbT4NCj4NCj4gUHJldmlvdXNseSBjb21taXQg
MDc3YTQwMzM1NDFmICgiYmxvY2s6IGRvbid0IGFsbG93IGEgZGlzayBsaW5rIGhvbGRlcg0KPiB0
byBpdHNlbGYiKSBwcmV2ZW50IHVzZXIgZnJvbSByZWxvYWRpbmcgZG0gd2l0aCBpdHNlbGYuIEhv
d2V2ZXIsIHVzZXINCj4gY2FuIHJlbG9hZCBkbSB3aXRoIGl0cyBhbmNlc3RvciB3aGljaCB3aWxs
IHRyaWdnZXIgZGVhZCBsb29wIGFuZCByZXN1bHQNCj4gaW4gb29tLg0KPg0KPiBUZXN0IHByb2Nl
ZHVyZXM6DQo+IDEpIGRtc2V0dXAgY3JlYXRlIHRlc3QgLS10YWJsZSAiMCAyMDk3MTUyMCBsaW5l
YXIgL2Rldi9zZGQgMCINCj4gMikgZG1zZXR1cCBjcmVhdGUgdGVzdDEgLS10YWJsZSAiMCAyMDk3
MTUyMCBsaW5lYXIgL2Rldi9zZGQgMjA5NzE1MjAiDQo+IDMpIGRtc2V0dXAgc3VzcGVuZCB0ZXN0
DQo+IDQpIGRtc2V0dXAgcmVsb2FkIHRlc3QgLS10YWJsZSAiMCAyMDQ4IGxpbmVhciAvZGV2L21h
cHBlci90ZXN0MSAwIg0KPiA1KSBkbXNldHVwIHJlc3VtZSB0ZXN0DQo+IDYpIGRtc2V0dXAgc3Vz
cGVuZCB0ZXN0MQ0KPiA3KSBkbXNldHVwIHJlbG9hZCB0ZXN0MSAtLXRhYmxlICIwIDIwNDggbGlu
ZWFyIC9kZXYvbWFwcGVyL3Rlc3QgMCINCj4gOCkgZG1zZXR1cCByZXN1bWUgdGVzdDENCj4NCg0K
Q2FuIHlvdSBwbGVhc2UgYWRkIGJsa3Rlc3QgZm9yIHRoaXMgb25lID8NCg0KLWNrDQoNCg0K
