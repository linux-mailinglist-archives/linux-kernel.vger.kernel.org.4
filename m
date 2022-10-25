Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95F760C0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiJYBVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiJYBVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:21:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E387399FB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXJMER7acEQgusXUaPkcn9sqY+4U4TArtprvK6IVTXjaINK/uOYra/1tgJzfzTMOdX8qp4MQxgJntOfcN/4H3rSzRc3J9OT1rx7zX5ILnwZ1exYSZ8aqaBQPA86jl7zuHo85kcjlXjru+Vg9P1qZwcDNW31VXoP8PMplRLaaMvZirAsRHF42aJht38ba8LiE1MV2V1/Nq5DHuBV5JBz0bpqsMAPOETUdQpBgN2DJo6zgpFw8DuZcVHw/P7TgXGB0Y8D4IJN6MjJt80F/1U82shGCJjSXXxI9nEgf7Pb/0Cy7JiLX0Xo+aOVmwCDnEd9wC2d4VZ0RIb+y28Op1ZVr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtKRrglAO0XVHyaBZBMN34e+o/hhcbvV7ahdvsVXwx4=;
 b=Nj1vTDg6dskiykpiozlGbTFwurgGTFGGS/hS7b/A1YuYfsBKeWC1cNJsgVVO3mANdMQ1xP7vA03/z/PXFA9wswsKyef5SGgTOxepfOeO9rQ9LDIu3WmueUmrLZibJhEX9sjLY3ZRRTKoyzkoWuF6Jz4iYHBR4FPCpxSfWpt3omRbs1zFpS73fvL4cbfWWrHB1rkrqGpd2i4OsrmiriETw1SPqsbtVxHdyVrPenPPd2HArk+6xVsrk1dGwlqPc1YC2Bjbb50HV6fMazWWgZTETVbW9R80oL4BzqkpjoGVr/74VXz/8fG0YqZ6Uu4kwtKg5Ljot4O1+bffzsukFO/0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtKRrglAO0XVHyaBZBMN34e+o/hhcbvV7ahdvsVXwx4=;
 b=kKKJoKEruPP4JcB/BErbqznQQ0GyYVp9i96S9LK5g0urQX5JjTKJqr0isGAgSbQJEAldZm8ErQ0E3CF3bm15L19tAqvvpdTdRNXnouqAUs1S0/ODlsdJp0pewY/ZPo+AhfFnA5FaBUPgDCLLIGEg1+kzGRQDYV/zOWLQkd2PPWSkz6zTWOAFdfnjSVnCsJMhNIAXvPXMZQPUGQkZUe43PhTH4hfnBEEu01Qx4HJ1JZAYhk95S4VwS7jVlPrObUNfNlHm786IFLHIIa1OsyT1bWAZnXR+MIaQUEO0qZEHie9S1oF/reah5K9lq3HTBuCh1BPTdDZzaT7wcciLal0KwA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 00:47:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 00:47:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Uros Bizjak <ubizjak@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] nvmet: use try_cmpxchg in nvmet_update_sq_head
Thread-Topic: [PATCH] nvmet: use try_cmpxchg in nvmet_update_sq_head
Thread-Index: AQHY5JmlCOaOfNku4EOJZyAiHOl3464eTWeA
Date:   Tue, 25 Oct 2022 00:47:05 +0000
Message-ID: <220dabe6-dac1-8ca7-0134-e6e89c923d81@nvidia.com>
References: <20221020153540.8226-1-ubizjak@gmail.com>
In-Reply-To: <20221020153540.8226-1-ubizjak@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6649:EE_
x-ms-office365-filtering-correlation-id: a8a3dbd4-1837-421e-8630-08dab6227077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONJfwDFLbEtb/VoZj3lphAqtLTMLhoJ7OTTUGxtcY/UP+lqGd2TzJD0Y2vybf/gsrVFgWdKTscffMJwifFoN6QP4z4Wt/Y4eOl+cAwUc2mCsLyhK2KMcYdk7sLi1nlJ4mJAJVerwEVIR46qJuyP2UnGIekk3j1enZ1B9SqRq+m3kAwmlLrjm5S3mEASDOD/AaUnSX1Pn2JtgaXKRz7pi+cI2lh8fIsTwoa5FoOlpcZl2rDtneQ5QzhIqbOLGICWwbd5wa7BIlrmoGFT87EXFGOfmGqFBGRD1FtIE6oMIE+BNYffzjNplOZGa3T3svle58zKn/SQcpmPJ4SC+3zuGzfCIfm4yhqQpDVMTbWQLGk7e5XdhPaV76LlhyEFmfgh3RVRegMNBQQMdTv3Y5YSlrjiNMa74mHNmiIKmT9g1/ZjDtH4o7i04gWMnhwexsk5qPvyT6n8Er5/7ppDxySnL6SO0vFYf4BHDeIC7BkvrpecES7Ub0UpCB7c0XQjkv6yOgOOUwbpZ8UZFvoGHvo3X9gq21p43AkJYPadb1teChxqCbsYF3Yn2R8cBF+DOYCt7MDFArnbCvbNqU1TlwupzG3/uVqCSPH+1c+Uf7rT4t39M2bR7avFMuiwrd+VgpjJUGP7rzU2NXtJI2VuUnLDvlj/1z/tx5Ak9+o3EiUuXcHgSEUa7UnVZE5letUNe78gDfzT2+Ul6mwxKS6Dt3YtgyUBmkFf0GZE/pyvDFew5Tj+qqTZW4NB2R47omBxLo12AN4om9RasYGfvsptoTLFc0pGa9iQx4iM2fDejjOQ2W5HEbovbUkNR+pvNTsTPQqT9RKDpBKCGaXvLqGRg0tomcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199015)(2906002)(31686004)(36756003)(38070700005)(110136005)(66556008)(66446008)(5660300002)(6512007)(8936002)(41300700001)(316002)(76116006)(66476007)(8676002)(4326008)(91956017)(66946007)(4744005)(54906003)(64756008)(53546011)(6506007)(83380400001)(2616005)(31696002)(86362001)(38100700002)(6486002)(71200400001)(122000001)(186003)(478600001)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlRURW5tMmFKTlBYWWV3M2pjR2hJRGhHODdrb01hQ0dvdyt1Wkd6WkNtdmZk?=
 =?utf-8?B?UmlqTGJNcEViR0Q1eTU3amM5SnR1dEpJV2RWK0IzTFlJQ2RwRGM0VXpDU09W?=
 =?utf-8?B?Y3doaFZwWFF3UlNHbWI4TkdBdkFaa2taWUJBR3lzRzN5M2V1UmdjdmZMcTJp?=
 =?utf-8?B?WTZxZk9rRVY0a0Z4NW1GZ2hHVnpCOGNBZUp2NWd0T0VjeC9NOFljYUpvQm13?=
 =?utf-8?B?eXYyVHVXN01RU21SN2NIQ1JLWk91M1J0M3FxVmVhWnN3ZVd6bkU0djExL2k5?=
 =?utf-8?B?VjdHZUVteVZkSWlHS2VPa2JiMzVoRkFnTmRkemRESi8vUEJMUUFLRWdQOW5V?=
 =?utf-8?B?bkg2NElMR1NpUmMwclA5MDc2ZDdKQmJzV2UrY1gzRTBMMUZRTkgvSDRKZ212?=
 =?utf-8?B?RFlGcXBJeUJ2cGlzSG1rczE2WExDdyt1R2x5dWk1cVg3Y2QyWEhrbVc5RXFO?=
 =?utf-8?B?ejNIdTYxMnBGZ0tEdEIrc1pUVE5ySHgwVG1DYnhWaVdEdW5saXdWanZka09T?=
 =?utf-8?B?TE14aDltWnJxOXlyOGFyOGFPWnE5UVRJWEFXMWxoNXArVW1HeGtOL1N5VkJW?=
 =?utf-8?B?S0t4dGxINW9HVXNSL2tQbE9Xazc0dVM0NDM3bGIxYURxbGJVK3hRQ3RzbVFN?=
 =?utf-8?B?MmlrcVZPYk5BaXhZdWZidGZ6QzUxUHlmbHJIZ2Z0Y3JMdlI3MlN5aEdlRnJ2?=
 =?utf-8?B?UERZQ2Q5R0ZaQWpGK29LVi9lM0wwbTZqTVh4dHA4V1IwMkpBYkIrUmdtN25D?=
 =?utf-8?B?bEpWckE5SURPdlFvalIvNExjclFwN3kwenNMNFJsMXJ1UnFSWldRcnlObDlx?=
 =?utf-8?B?RDFwSFg3dlhCV1JlSU02eFgveTZSNEJHbE5QUmZGNWxLdkQwZWhWb0JjZGs0?=
 =?utf-8?B?T0hSb2lueStaZjhMeXZuYmFIMjJ1L1llS1VjWmViVDhmZEIvSlN3ZzN2SDZn?=
 =?utf-8?B?aitQdzdLVnlTeTdNSkxneHNrYmZibHdkV2crRUV1ekVLR0gyV09tTVBpSWlN?=
 =?utf-8?B?czMzYng3NFRLU2NWZFMyZlZGS0lzSEZpQmk1MWRUQUdFaTRmTW83SlAvYzYy?=
 =?utf-8?B?WEdmNkNqK2dpNDNjSis5UXl1eFVLYjJmWlo0bEtGWkNwaXNmZ1gzQ2hlU0Mv?=
 =?utf-8?B?cW5kdWpNZE8rTGdGa2I3S213NkZrb2psRTFOYjZld293MjZ1WUpJclU4a1F1?=
 =?utf-8?B?UURtNUsyaVczTEhKUVAxa2tjaHFneVh1dXBTNm5lQ1Y3VHpKQjlWZk0ySzYz?=
 =?utf-8?B?Z3JjaFNsdHhCN2ZKYUM4TG1BVjJCcmQveW51Wnc0SWZRV1JvbHQ5cDZJdXFY?=
 =?utf-8?B?U09iM3AveXNMT0FvSktxaFRNZGVUS1ptbVZKaHd4NHhDbW0xb1NlbjdnOCsw?=
 =?utf-8?B?eHEyY2Ryb0JIbnNSNUI1cFZieG5CWGNLRXRNY29RYldtQWg4Ym02SUFmWU1X?=
 =?utf-8?B?Z2tDWVRVWlBlbFdMd01yT2paOGh4MndCNUJmZGpha3ZwbUd4aHB4eU9SMk5F?=
 =?utf-8?B?d1NMSmdzVlhJZGlUQWp3RnVEL2MyZjF3VDV5TjBSSG1kVjViN1V4N2QrdnR0?=
 =?utf-8?B?azVyYnFhbWwwNS8yS245bjNUaUFZSkRXNFNwM0N4SmxWb2hzRmhsb0w2SUgw?=
 =?utf-8?B?SnYzMlhpelNSU2t4K2ZZZWZYdUhQQjdJTm5taFNINTFWcWY5eUJEaWo5M0Nl?=
 =?utf-8?B?NitQWW5RaHRmZkdkL2tnUjEyNlZNRitpczJJOWxFM3JJNG1XVUJEeWc4bSs2?=
 =?utf-8?B?RzhId0FxMGZ0Q0NnNjhzK2phYXRXazZNcGRIUjIwOS9QUkxldFZ6WUZCcXBi?=
 =?utf-8?B?VTVIOEZ3UVJhVmtsM3EzUkFrdDNhSHNITkE5aUw2UjV5Y1hGak5lUG1KTmxR?=
 =?utf-8?B?ajhicE5jU2VpaUlPWm1pZzI3bENIajZ4OHZXVDZ3eG8xdm1oVEhOVVhKM0Nu?=
 =?utf-8?B?WGtubCt1cXp0UkovQWlOR1N3YzdOVUhDenF1NHR4OWZJM014VXd6ZjRYajVI?=
 =?utf-8?B?NVhGZTZVUGhQYlhaR1lHN1FFNnBPdk5oK3FjeW1sY29rNDFjcUd2bHhCb0pO?=
 =?utf-8?B?NlJsNjZQREhWTDlvWU1JVGVwNmFuMFBpMklZNVVBQlBOdDhhRmIxc2IyUm5N?=
 =?utf-8?B?alEwV3BXV3B4Q0JXWWF5akt5dkZXU1RBdHZOczNkdWdRS1g4bk0rN1Awc01F?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F06B2DA4D0FA464E8464FBDB458E5105@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a3dbd4-1837-421e-8630-08dab6227077
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 00:47:05.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiLV9wg1vgUbWO0bieGyWJqIhtBdkd5RbNtgS4vrXc1pbYBiMWJGaTiiKDXzOCGNRR4/W5qXSZTJBrF3cV8tVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjAvMjIgMDg6MzUsIFVyb3MgQml6amFrIHdyb3RlOg0KPiBVc2UgdHJ5X2NtcHhjaGcg
aW5zdGVhZCBvZiBjbXB4Y2hnICgqcHRyLCBvbGQsIG5ldykgPT0gb2xkIGluDQo+IG52bWV0X3Vw
ZGF0ZV9zcV9oZWFkLiAgeDg2IENNUFhDSEcgaW5zdHJ1Y3Rpb24gcmV0dXJucyBzdWNjZXNzIGlu
IFpGIGZsYWcsIHNvDQo+IHRoaXMgY2hhbmdlIHNhdmVzIGEgY29tcGFyZSBhZnRlciBjbXB4Y2hn
IChhbmQgcmVsYXRlZCBtb3ZlIGluc3RydWN0aW9uIGluDQo+IGZyb250IG9mIGNtcHhjaGcpLg0K
PiANCg0KSXMgaXQgd29ydGggYSBzaGFyZSBkZWx0cyBvZiBhc3NlbWJseSBpbnN0cnVjdGlvbnMg
b2YgdGhlIGNoYW5nZXMgYWJvdmU/DQphcyBkZXZlbG9wZXJzIG9uIGJsb2NrIG1haWxpbmcgbGlz
dCBhcmUgc2hhcmluZyB0aGUgZGVsdGEgYmV0d2VlbiBiZWZvcmUNCmFuZCBhZnRlciBwYXRjaCBp
bmNsdWRpbmcgdGhlIGFzc2VtYmx5Lg0KDQpJIGFsc28gaG9wZSB0aGF0IHlvdSBoYXZlIHRlc3Rl
ZCB0aGlzIGNoYW5nZSB3aXRoIGJsa3Rlc3RzIG52bWUuDQoNCkVpdGhlciB3YXk6LQ0KDQpSZXZp
ZXdlZC1ieTogQ2hhSXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
