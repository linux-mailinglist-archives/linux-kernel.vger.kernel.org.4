Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F045A6156E1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 02:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKBBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 21:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBBQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 21:16:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401ABF55;
        Tue,  1 Nov 2022 18:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg4u4yYRlOwW2WY96wyiEWHuq9upz5oe3AP4EhKnp+WFI5NBph++d77AWw6ggZtkdikSTiEwsxwu/WDcOyJqDQzDST02w692wbdXFI7vl4fmrI7tTbMGyZjV5oWghT9yuWynuBRoBWYfvFZjVbmInq1Luu0gol3Fm9opB5obNK5YunLm3u7I8/kTk4UcpENXPBebJr5afD6/FLyr+xvP8fUubjs/hxG1eiGYlfaq2T3rpt3jp2vHQPWMIAaK1MFTQhuSzEMiZfDcCoG3eW9BCPgkMiv3u04bHUYxxBGAyv28tN5luCUck+62BWuo1kZI/8CkQaqQd4INZTS1SenScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSnjYsZGXBsJgN/EGwwh8mCGwUBT9AjehpQ7xwipOXE=;
 b=ZRzr4EeiCp1PV927+DdddzzdED+gEQume2eSqPpYxMV+9CbcYnNaFWfblFQpqNcF69Cjv9SZxZJpeSCe33CqBK26CSFaC/p9Ohct38dnvR4OzBIughIR9OhL/JEVVv+/x1XGUT+FFFq9xN/uTvTGWcAccLINQM9sTfUN61SkVcknExyzccA86p+orYsfYZ7qJ7i8SKNeqaRNgAirXHhtaGHaKFATeFLCRfE1XBGeOA/OEJ5IS3L1IrRPlfOxQp2iHNk7PlZqyS4Wb/3GZ0Y14geAxCP7rA6OeLBgYWYyNfXrhX9bTmDeSq/n0kbGkRCA+MQGtpHEQMSxqPi9C4ouHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSnjYsZGXBsJgN/EGwwh8mCGwUBT9AjehpQ7xwipOXE=;
 b=jl9UxXBjw7iCpG7VQaPaNwomVMqhYckSvQUUwBaxCHjIG941K1I4XsmE+yQxAnX3XhMvMAR6DlMooqwhTiuofwFRBEIkT0Q5QFNr5ZfkQdpsGazndwtk8Bz9OZ6Hio5cw9aa/R2ooLIV0QGlggi17IsJEk9fcfw6vz75LalrBonKpOAXQWCEPBXoh5D2tcuvp0JPqEvrC1ZlP8UIRA9UPiEK1q5yz7DEZaVe/tPHE8J2e6bzlVAFT4RKlUKAf1KoRSwsJ1yxxnVirsgEGZqjSJknJQ/u0Xbv9jqTjhtmvGFpkRLMxu7HbowzT2ZwLdMYvcFEehUV03Re161chkgarA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:16:08 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:16:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] blk-mq: improve readability of blk_mq_alloc_request()
Thread-Topic: [PATCH 4/4] blk-mq: improve readability of
 blk_mq_alloc_request()
Thread-Index: AQHY7gTNrYFdeypx20C3xRVdLC/TX64qVS6AgACAJwA=
Date:   Wed, 2 Nov 2022 01:16:08 +0000
Message-ID: <074cfae7-982d-5273-e63e-8db4fa22db14@nvidia.com>
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
 <81fcbc046c9ea96cdfd8e20d1edc8e64c4d08153.1667314759.git.nickyc975@zju.edu.cn>
 <20221101173727.GC20690@lst.de>
In-Reply-To: <20221101173727.GC20690@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6529:EE_
x-ms-office365-filtering-correlation-id: ac1876da-0a9a-4334-d171-08dabc6fd299
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgOAs/Snxv5f7BS7EHvvKfNoy0zV/dzeWQUq/UJfNY7WmrW1Xw2NXobaytUUOpIvBKfq6M6c81X+/yxcsXipzmpl++cHEWRYI8prEdW5uwcab1LzhXIW2I+2g8sL/sciGCO+B/Z2oB1LvEECPgMZWZAnX36KxPbubxvWrCEjng6/SoOjx6iWdxsnGnpqFJw0dTmq5jKn0Fk+zmFrcNzeTpI+ftDZmbS6UC9ZBdlqhaMMOgvh3+BvKrmBERmwqaPE63vCUe73GMpbDyG8+g3EHgsWFJasXF4nFtSftz8w5vSRXysMibP+HuKmz595xdf6pzCbjI7noaK9DkIB49QdDngNbxl9/kF87R8Lx5kQTKQFxPMclUaj2afSxHnMOO85iGb/ViTw9YTZrZLd5A7cO1ZCXM4oo/FV5RlrCdKww1zgmao/gghVh8GGGZLTjYlf9fCoWmi11nlna/W5VdNfeWOOj48rd+scA5YCzMyzahQHvuNmvz+RfMpSqRtewWsGNaw4EWO3t0/E5gWlYxq30AKJ+uFU2xfQXxMD12Y7H5tLZfrYG03nxArgD4BWTBtPG4K86OGVyZXpDlY/HMB7vfW5Q7dOK0n7D2CjBvtZ06VEFS/k4WG+BUcpTtSX8Pd1CGYbvB3hpZSAotryHEnYBrglkCbcBRU9r0d20nYfxsbSfvOOEyWp1mk8gvD11GwdmPs0seahj743LAoOu2+mhtbOh5/8VrhbyWLDKxBq/c6q4RDibSMelZwmaTM1cN22NA7BIrt3bWraj62cfrpWtWoPnz81S5vwzWfR+CdLAiNZx2swkLXj9nQf0475nylvOExFfize8MXwjcHsLtlU5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(31686004)(36756003)(6916009)(38100700002)(5660300002)(2906002)(4744005)(122000001)(83380400001)(31696002)(86362001)(38070700005)(6512007)(316002)(54906003)(478600001)(186003)(2616005)(71200400001)(41300700001)(91956017)(6486002)(64756008)(8936002)(66556008)(66476007)(66446008)(4326008)(66946007)(76116006)(8676002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d09uNjB6VTNPb1F5U1J2a1grOFBlMk1ua2hySk1kWUFFMEV6OHhFN0ZNL1BS?=
 =?utf-8?B?bHNPeTB0dEwyNlQ5ZkJJb3ZTdnJlbFY2eHlIRnZwSEsvdndBTDVKU0RDMWJF?=
 =?utf-8?B?UWtvYUk4ckZTd1htRU52clFOZ0ZLcjRrc0xkdCtSRms1bVJJV2tMSkRYZkp4?=
 =?utf-8?B?UkF1S2pHeHhFMjdUOEwyNm51TklKYllMMmxnWkZJclpkQnU1ZzlwaW5ua0Vp?=
 =?utf-8?B?bHlUZFJCM25sbWszUk9sbjNnaGgwTGJBd3hRaElmVDBRUVcwRmwwWlF0dHMv?=
 =?utf-8?B?K3hXVmFsM1ZMS2NGdFdHNk56UDc4Tnh6dEFLcHgydG8rWk5DZ3BrSG14V2JO?=
 =?utf-8?B?QlduaFF4WFpRbDF5eFVwa2hmbEpsbGQwL1ZEUTJtZVk4Y21WcEhPY1NpMkYw?=
 =?utf-8?B?QlZIbUhxUkkzN2p6KzFQVDZrV2IvYkdhYmZoREVDNkY4OWtoY0hHOXF4WjdR?=
 =?utf-8?B?OUE1WXJEbndJMVozY0k0VnNQVFFscnFoU3Y2UzAwQnExR3d4RWRTd1dKemZs?=
 =?utf-8?B?c3gzUFNwVUs0Y2hQRUFuSVBRRXBrT2tKcnk3RjBiSGE0SHJoWGZtYXhEVGta?=
 =?utf-8?B?Y1ZpTjRSK2ptNzdxalhvNkZ2bHQycXYzY2FHVGVUYXB6WGd2QXZ2ZHZVRWRT?=
 =?utf-8?B?c2dxbnpBY1orL1ZuMVM2cnhIT2hqaGRKNzZnRWk3eUhtc1J6K1JCbjZnbXFs?=
 =?utf-8?B?U08xdHdDc2NjcENjZkN1WVNvdmt1Y20rK2UzMjhrM21DVGtlOTNtaWVmbUZT?=
 =?utf-8?B?ZGx5bjJXQXRWUkU4ZXE5SlZIaVNqNjZkeEJiZ0NPWFM5V21uVm1ubEpMaWdT?=
 =?utf-8?B?UDlOWWI1MmVEbGlIMVQ4bTcyRXJSNTVCOU5KYUFFMkhmU0dGMW5oRnY2TEx3?=
 =?utf-8?B?T0NHRU9wbllUM3BRYzZXUTBURE9yd0tZK1dVcjdlcTlKcWV4a1NBSml0OXAx?=
 =?utf-8?B?SkpsYUR2MU9KQi9MZmcwV05vQ3YyZTJXUWQ1dkU1N2FtU1U2TElYTGI1T09I?=
 =?utf-8?B?NHhYNjFjV0Z2U2ROUW82WnlvbnN3cnpzblJmOXMyUUpERi9ndmVNaDRnNlpL?=
 =?utf-8?B?bEYvcXM1STFlUVB1QlhiejdMR0s5UkpaVXYzQzEzUTNTRmdIVjA4Y1MvK0ts?=
 =?utf-8?B?UEZjVEdHUG55K2haVnJZcFZNSk9WdkJuRmtkWjhRbWNvOFNsdVljSnNkZGha?=
 =?utf-8?B?c29KemJJYjBKWkowT2N2dERZZnhVRWlkcnUrV3dZRk1zS3ZqR0RybjkxN2M2?=
 =?utf-8?B?c2dPdCtLNjFxeXZyRDhKbERGS0hXeFJnSjREM0lLMWV3WjVKaENTbFZpSU9z?=
 =?utf-8?B?WVRnRlVxTVdzL1VFTDk0aVhnL2tHSEdaUHZ3WU1hdmhFOVJFSG9SSTN3YlFD?=
 =?utf-8?B?R0FudFFjNVQreGd5K0NVb3lrT3M2aTFGSWFzaFk5NmYzSmtnTGRNc21sUm01?=
 =?utf-8?B?T1hMVVZpRjllOWhvZHNoSk84OWZxOElURzRuaDNEMU5EcGtveG1JVXBWbjNu?=
 =?utf-8?B?SHAvMjlBb0RobzVnQ21kOGx6bFdMVkp0UXNwOUgvdDEyajRQa2pGRTFOR1FH?=
 =?utf-8?B?VWNYOCtkQkIvd0FzaXY4elQ1Uk85RjRQRlhYMVpoU002R1gvb3Qxa2VSL1Z1?=
 =?utf-8?B?ejhyZmpPcVFlN0lEUElOWTB1eExuNWJZRzNMVTU5NGk4RXIvMzRYYUp3VGQz?=
 =?utf-8?B?ZGRtQmdLY3B4c1NDWmg0dkI2WnZXc051NjZ3RjQ1VDZKMGRWNEozRUl4NlFO?=
 =?utf-8?B?bllyUzRSa0RQaGJNUE5wMkFVb0EwODJjZE5nQlViU0l1NVJsMWNHNCsrVjVW?=
 =?utf-8?B?QjJWZlcrclhYUjIxUVpuQ0w1eHlHM2paUHZoV2xnNnhEOXNBNWpRcEZnand6?=
 =?utf-8?B?TVpkRlNNbEg4Q1JLUnN1UktIUGJGSFhTZTZEU0pQZW55VXUrQVczV2djVjZ1?=
 =?utf-8?B?MVFqZExlQmJxcitVYWNIZHk3cGV0VFQxRUJrcysxWEZQVmx2enpMRWJtWWMw?=
 =?utf-8?B?UkNtNG9uclU5a0psZ3IrOHlEUkNHVTFtTTJzVnhVZ0YxalVDQktaMjdJa2dX?=
 =?utf-8?B?SG5kVTB3K25hOHNvNlZjNWZ0emtCZjJKck1xOW1mSkZVUVhFazdtRzlxODNP?=
 =?utf-8?B?UmNDOTFNcGpzbU9ySTZLMnc4ZnNNY2swRlFBNm5OKzdkRFlGR21XYlUyY3Rv?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D62B78B7B7D95649926795F6953DFE91@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1876da-0a9a-4334-d171-08dabc6fd299
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:16:08.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+uoo77gmUvm0u/+WIeFjTNk28ADoth/lkqKC4RA/T7bt4nzpkl76OAGsSm27HGvSD3Rb8SA0Bnd2UiNp4xHYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiArc3RhdGljIHN0cnVjdCByZXF1ZXN0ICpibGtfbXFfYWxsb2NfcmVxdWVzdF9ub2NhY2hl
KHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLA0KPj4gKwkJYmxrX29wZl90IG9wZiwgYmxrX21xX3Jl
cV9mbGFnc190IGZsYWdzKQ0KPiANCj4gVGhlIG5hbWUgaXMgYSBiaXQgb2RkLCBidXQgSSBjYW4n
dCB0aGluayBvZmYgYSBiZXR0ZXIgb25lLg0KPiANCj4+ICsJc3RydWN0IGJsa19tcV9hbGxvY19k
YXRhIGRhdGEgPSB7DQo+PiAgIAkJCS5xCQk9IHEsDQo+PiAgIAkJCS5mbGFncwkJPSBmbGFncywN
Cj4+ICAgCQkJLmNtZF9mbGFncwk9IG9wZiwNCj4+ICAgCQkJLm5yX3RhZ3MJPSAxLA0KPj4gICAJ
CX07DQo+IA0KPiBBbmQgdGhpcyBub3cgaGFzIHN1cGVyZmxvdXMgaW5kZW5hdGlvbi4gIE92ZXJh
bGwsIHdoaWxlIHRoZSBzZXBhcmF0ZQ0KPiBoZWxwZXIgbG9va3MgbWFyZ2luYWxseSBuaWNlciwg
SSdtIG5vdCByZWFsbHkgc3VyZSBpdCBpcyB3b3J0aCB0aGUNCj4gY2h1cm4uDQoNCmV4aXN0aW5n
IGNvZGUgaXMgZmluZSBoZXJlIHRoYW4gYWRkaW5nIHRoaXMgaW5kZW50YXRpb24gd2hpY2gNCmlz
IG5vdCB3b3J0aCBhIGNodXJuLi4uDQoNCi1jaw0KDQo=
