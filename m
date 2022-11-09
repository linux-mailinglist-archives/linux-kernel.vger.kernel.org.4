Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C796233E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiKITss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiKITsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:48:39 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66B263CB;
        Wed,  9 Nov 2022 11:48:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdAEij0XtnQvvKVgfZICIrRjYHV8+1GbWuT/eDYnzSFFG2Wo3xTvRtqgpK7nChUhgiaNUH8mvE85DYgJmwfPfYWOSSlY35VnyunqFLTBZA+mQBfhxNFPhMrxKWuqOw4SyMRxPFvs4sNdspto2S0gCHdEQa8A8dxWJ9YqW92r8g0f8AL4rWk7T1o4kBHUbibpQewz/xtJOE8bxmM9z7jArq8mxT5xU3XkUt7CS68ukM/GmQF2shOpT0heHvdfoffocGyNUV1dljx9QBem7riBcyRXgW4rn2PsJVtL9+8hcc1UVvS9rx8z7NA2j+txCkvDikG3dPVALOLb+la0cL+9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASGf0gbHYwGvyAfUQIECxra0nu+/exHlHPKhvp48l2w=;
 b=NRXl9Y32oWB4zKEXJ0jCQAdIJYBfYEgLF+wn+QMoFPvYdqRuWQKZHrUz1GK1cpxu81a52s8fXo89JHPk6W3GTYTz2DhVDYOiP9cZmRDXDlAQNdWjG3yO0BwuH3C29Yu19Rxt5fbdgBkEOXE5kU62zS5d41xjJgSY48+Qb5fcihzcSJFPiUx7T4MKXVKDXZOG/Q1EJSkaajDxHbwYlkJH4pTMv4juEKnu3gHRs+cBy0Pd1vWhnda8nyPcFGAevVQWjvEW8hJyScqUVdUBSJj8yHwHlBH76+2+tDFweOgi57ugoai1p3a6YHhd6iLAnVoBZmzCMQnRCTwbJ2Ujeu/Uiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASGf0gbHYwGvyAfUQIECxra0nu+/exHlHPKhvp48l2w=;
 b=ZaQ7PBBZCVzkfFWEobZBIfHC7lwanrWWlVE+dESudjdm6VR1KnSxnfTnJK1BTYeTX1jCi/zL4m8WVE+Srvb+O5mre1ko1RDuF9KqBj+U8SqO2yZWDP2fQSIajWyRw4uFAkK1BzL4VKh+P0YfjgvCw1fu9Fzw8Rzmbs9vKMTu39Lyz1U9Kjmnd/DIK/4HOALcotTL5wRw+RbnErV1k5JYCo5Vq0jgnan+QMwwSjOKpnU2mSyWJS7Ik29TCeR4I6CYV4DM7dAwWD5Au159ToJ+kqgDIej1WUPU72ZsZe3J7/k91TyKaBV+kwxBiKnu7gLdbSw8bmO1m6Z5l9lSEXOpGQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 19:48:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 19:48:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     =?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
CC:     "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: Re: [PATCH 1/3] drbd: use blk_queue_max_discard_sectors helper
Thread-Topic: [PATCH 1/3] drbd: use blk_queue_max_discard_sectors helper
Thread-Index: AQHY9EAZ1iFcSGv+SECyqWR7vK8NNa42//+A
Date:   Wed, 9 Nov 2022 19:48:33 +0000
Message-ID: <709b545c-71a3-4b2b-8fd1-30c738e61743@nvidia.com>
References: <20221109133453.51652-1-christoph.boehmwalder@linbit.com>
 <20221109133453.51652-2-christoph.boehmwalder@linbit.com>
In-Reply-To: <20221109133453.51652-2-christoph.boehmwalder@linbit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5143:EE_
x-ms-office365-filtering-correlation-id: 335a61ff-b2a5-4a1f-ef85-08dac28b62b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IlHfDD72MrjAc9yTcrwI/HrJ9pio63TzMeWPMtlGzsxEFdIbwMmsVN6XXb43UINFeBCTwirTuOTT3YCmp3tT2mpQLpP5ya4/75JEpHgdcyJBxPiP+YfoESvkADCBQSFIVs6P7Ju2MHosbNTLuZhLg0sbOnphXKQzCAmQnPVk6IykAp8saMMIhjjyGVxVN3+g6XYZdf3R/fyGOhZDa5LzmNsmd0wPuEVpuC1JNq9Zc+ykrtoP9ajE7/uze3vnxMFJK0f4SeV3qioagY0/2518p4yTiC46cQE2WBN5c41t75fqqv2L1t6ev5zq0mmsVr/WuWT/B9akOeMxBbhXkbTdxSgwTRuw37lo2xhAjLQxY6o6oK5WKEEbeE0ZaKmOD74DkJKgCJbcVDj2cch+kJvyJtAqIxOBMTz4QCxj4P7HrwU772xiLhQ/HNq2JqmjVV9g80OflxaTCpnn5NYF9ccreuhu64tk/pOY+eQz+Phus9ptME2oFEcapx7o5VWspasVTZgkdHocU3V5GTYC4WNklTghAGwLPriF7uuAY5UzA0wm21zPzjnrF1m4FYTUnEVSjj1BhzUUqzHhCNUp9szYr02P1OiGQS7bPNh/CrPdX2cC++IpD+wZZrq/kUnwjQPMcFh/1dS0WLOQSAB3I6nXQn3WdwBnjb3OEW2IONc8rjFEQttIrcaJG3lx3aM0cNanQ5bmMSFZn97nAb62QYI03ytYx8adfEXDCQVwRI8RlwWCpc2figEsBOmOfC9sZX1RjjelpLI40HaEXXxFgevmGjh4zdkgbxKl343lvu2Hv13x8R45gFsWL+M1dp3bwSIunWu1+yXbspjB+ziS4lHd+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(76116006)(4744005)(53546011)(6506007)(186003)(54906003)(4326008)(64756008)(91956017)(41300700001)(6512007)(36756003)(110136005)(5660300002)(8676002)(316002)(2616005)(66476007)(122000001)(38100700002)(83380400001)(2906002)(38070700005)(66574015)(66446008)(8936002)(66946007)(86362001)(66556008)(31696002)(6486002)(71200400001)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE80ZklLY2I3Q0I1R3hGQTRLb0xnWUc1cEhFeXRjcW93cmNzektZTE9qamtw?=
 =?utf-8?B?WlBwWE9GNkZITUc2VnIwVVhOQzZmZUJRU0N2bG1IenNYajViT3JMVklLZFZq?=
 =?utf-8?B?cjdNQXd3L0ZhL0I1RDRydWJtbVpWSnhqRnRMczdXQnlPUlFWK3pNN3RZOHpZ?=
 =?utf-8?B?ZlVFbFE4Skx1MmJNUVA3MjdFZTBXNFgzSnRyTjhMTHdoZGswQTdMeEpFZUxN?=
 =?utf-8?B?RGloelVUeWV0NkFCY0tJUUoxNStiSlB1dGlqRUpoWHJUREo1U0dSZi9TR3F3?=
 =?utf-8?B?YzRPWGJyMStyZXQ0MnVTQ1dPYW1OQ0lVV1V2OStyZGZJd3htQm1aUzlpZWF1?=
 =?utf-8?B?eHFUOWZFMUVnbXVRSWppbkhUKzgxL3BuMy82WElZaHRwR29zaDRCTDdUdkN3?=
 =?utf-8?B?OFdGRkJUb0JkNXZGaFV2R1BtTnZ3VjhwUlFPbVdnSXpsV2hWMmhKaVNPRkkv?=
 =?utf-8?B?bWt3bkpLQ3NwR0MwWUN5WjUvTzRYTTVINlQ2Z2VoQURHdDJqdnBCa082TGpy?=
 =?utf-8?B?UllzNVJLTTE4WnJXUzlPVjROVnMzbUNKNHRjalJUVVlObVY0OE1nZDNpWEQr?=
 =?utf-8?B?RVdJOFNLUDZHUy84KzY1Tnc5anVTWUIxWnlpNW5sSGFtdlpRR2p6WTZsRUtM?=
 =?utf-8?B?dkhWckZyVFlNd1Voc2Uva3h2VTdId2xXbHBHTGJPOTlvMDJQc09EQXFGcFdr?=
 =?utf-8?B?Um5GQUxrZ1VXWFBGb3lCaFQxZDd1aXVMK0EwdThxYTlLQjVkbWN1RW1NdUNO?=
 =?utf-8?B?SGpDZTczSjFyLzI5Y05GK3pYTURTZmx4U3dBTFFyVEd5Y0hqeHNoSHNKa2Ew?=
 =?utf-8?B?K215b3h3NGZSemRjVy9XaitBOVZGUjh3Q0dKbHowOTFIOFJXTFF0U0FjSHpy?=
 =?utf-8?B?RXFyRWk2cnN6N3VWL21nVi9oSmorOWxtRVB6NjViS0ZVSkZzcE1oTUo3d0E3?=
 =?utf-8?B?aTBKT0ZjUk1DWllOQzdQYW5pSlVHbmpyYU1CN0JKcitTVFg0aFZ1MUJPaWM2?=
 =?utf-8?B?WFRYNUx2dzdnWjZ0Q1pLMDN1ZGRveTBjN3ZUMzI2dDZQYTd5dFlSaEtPT2lh?=
 =?utf-8?B?WnVsY2xEdVNxcURqdGJjOWt2cHhwYjRxMG9MNThSRUFJL0FYTzEvK3F3Ynds?=
 =?utf-8?B?Z25Lb0l4aDFORnJzbTAzdXhSbDNUTG1YWDUwVUl4OWhLenpNRHhzRy9Vem0w?=
 =?utf-8?B?bzVaWTRzSXk2Q1d6OEdOQ2RJdS9jcHhnanlWN25mbnhDR0JVQk8rdEpiZVhL?=
 =?utf-8?B?eXZvdEVuWDMxd3FockV1OHhFdHkwMkhzM3NWbFZ5cUROZURCbzN1c2VoNUhG?=
 =?utf-8?B?NElDUTZha01pelViM1loMFBtVjdBeXZIa2JTQlR3NG1YV0U5S1N3cEpOUDNy?=
 =?utf-8?B?eCtHdFJvUkRtOTdoWkV5Q3p2cjBqVEhFNGx5Nm45K1JOOWdSK2RUZHlHbzRy?=
 =?utf-8?B?THVOaGUyK0RrRVJoNS8wazRyS1RJY0ZiMlNtbGU2cVhrS1kyMkZVenF5S3lo?=
 =?utf-8?B?K1BqZHJ1VzI0RUVuUmM4amJYbk1Za0FUNG14amVDandCVm5QOGU5YzYxNW0v?=
 =?utf-8?B?TDBTK2dKa3dGMXRQQk93eHExV0l0dHlaSEdreEM1TFpnVGVXbmdnSVFxdVg1?=
 =?utf-8?B?ZnF5VllWalJGWTVGazd3S2o1U2U0bWtqYys5c1I4ZkgxaWRHLzcwdkRPckQw?=
 =?utf-8?B?Q1AzVGRtTkRBaVNmdTRtb0IxMytHOXpWZjZGcUJmTzNTcExVTmtNTEpVUVBm?=
 =?utf-8?B?Qk01cmUyT1FkZ2hKQXpyaWhOZDNRUnNONUVaejI3b1EwZHcybFZEY0lDUXE4?=
 =?utf-8?B?VHVVYWJyTmovNnFRWjJGeUs0aEMvdFduU3JsMDhYWGdITi9KZHNRcTF4U0NT?=
 =?utf-8?B?QmZoVk9iU1hYU3JXZmZuenE0TmRPanY0THlHQkdUaE9SdDRjUWM4NjR5RTcz?=
 =?utf-8?B?MFhsOU1PRnFQNmNydU9LeGFiZVBNOHJrY2I3L1lkdzFHZWlJbGxyZUJRZkdX?=
 =?utf-8?B?U2FjRmtNeEJ4emxOZWVFT1pSSzkzMDA3d2JpcGNJZjRrd0oxR3l5WU96VUNl?=
 =?utf-8?B?NzdXMVhFRHp1L3Nib1pmc1pCV2JzZnQxczB2cHVRSEpaajBkWk9kSGZQQnVx?=
 =?utf-8?B?aUR3VEIvZzR5Snd0ZTlOejFSYW5hZWUxNkU2YnNJK2ZZNVUwSE5qY1k4WFQ4?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <933314C9AC091C44A4AC3A0DC03E55F4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335a61ff-b2a5-4a1f-ef85-08dac28b62b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 19:48:33.8236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94y1h70067zncEx2X8kA8lnHuer16cuWBEAijsk0WhJRw6f2rL+3qQ6dWUpuW0yNvJUwZt2mH/kOSwotEzaVIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvOS8yMiAwNTozNCwgQ2hyaXN0b3BoIELDtmhtd2FsZGVyIHdyb3RlOg0KPiBXZSBjdXJy
ZW50bHkgb25seSBzZXQgcS0+bGltaXRzLm1heF9kaXNjYXJkX3NlY3RvcnMsIGJ1dCB0aGF0IGlz
IG5vdA0KPiBlbm91Z2guIEFub3RoZXIgZmllbGQsIG1heF9od19kaXNjYXJkX3NlY3RvcnMsIHdh
cyBpbnRyb2R1Y2VkIGluDQo+IGNvbW1pdCAwMDM0YWYwMzY1NTQgKCJibG9jazogbWFrZSAvc3lz
L2Jsb2NrLzxkZXY+L3F1ZXVlL2Rpc2NhcmRfbWF4X2J5dGVzDQo+IHdyaXRlYWJsZSIpLg0KPiAN
Cj4gVGhlIGRpZmZlcmVuY2UgaXMgdGhhdCBtYXhfZGlzY2FyZF9zZWN0b3JzIGNhbiBiZSBjaGFu
Z2VkIGZyb20gdXNlcg0KPiBzcGFjZSB2aWEgc3lzZnMsIHdoaWxlIG1heF9od19kaXNjYXJkX3Nl
Y3RvcnMgaXMgdGhlICJoYXJkd2FyZSIgdXBwZXINCj4gbGltaXQuDQo+IA0KPiBTbyB1c2UgdGhp
cyBoZWxwZXIsIHdoaWNoIHNldHMgYm90aC4NCj4gDQo+IFRoaXMgaXMgYWxzbyBhIGZpeHVwIGZv
ciBjb21taXQgOTk4ZTljYmNkNjE1ICgiZHJiZDogY2xlYW51cA0KPiBkZWNpZGVfb25fZGlzY2Fy
ZF9zdXBwb3J0Iik6IGlmIGRpc2NhcmRzIGFyZSBub3Qgc3VwcG9ydGVkLCB0aGF0IGRvZXMNCj4g
bm90IG5lY2Vzc2FyaWx5IG1lYW4gd2UgYWxzbyB3YW50IHRvIGRpc2FibGUgd3JpdGVfemVyb2Vz
Lg0KPiANCj4gRml4ZXM6IDk5OGU5Y2JjZDYxNSAoImRyYmQ6IGNsZWFudXAgZGVjaWRlX29uX2Rp
c2NhcmRfc3VwcG9ydCIpDQo+IFJldmlld2VkLWJ5OiBKb2VsIENvbGxlZGdlIDxqb2VsLmNvbGxl
ZGdlQGxpbmJpdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBCw7ZobXdhbGRlciA8
Y2hyaXN0b3BoLmJvZWhtd2FsZGVyQGxpbmJpdC5jb20+DQo+IC0tLQ0KDQpVc2luZyBoZWxwZXIg
aXMgYWJzb2x1dGVseSByaWdodCB3YXkgb2Ygc2V0dGluZyB1cCBkaXNjYXJkDQp2YWx1ZXMuLi4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
