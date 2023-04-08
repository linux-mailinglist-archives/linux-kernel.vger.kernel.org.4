Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06F06DB992
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDHIPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDHIPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:15:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D410248
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 01:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG5mmV02AtuijFdnqXI/0eMsNxTQTjGmAOrpg6Ziirfq9ncdiRijPJuoazdZdRegIehvt12TvfO7FAOxM7aiGkYpYgdiJhUIrpscO/Wh9BxlYWHgu+UKeK7H2RcL0j9uE5quqSKbwKLaccN0R+oZl8RZp3ZA0F2wR9vMItQKfPc8Yo0ueoW+YqPckUerwC7gdFP1VY+M52qJLlGDqc+9B7MmZpJKUh5//d4B1MbV6S9GorPbzAG6QvjiIfgJofvpxMDc3iLcK0mQvimzbPXfcKq4ZjoDgE9+O9U3ruMnglJFlT9MkyUf53mfi2rmZoSXfxQojAQNmhIvSvpK9BtD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmqLpgtwx5Fb148kbmNDCVWaATvuYgwYRIZXPJZ7How=;
 b=K3kRXGaLob1hqYAxGardiWYZE1izfB6gg6paQydDUDhpk6vDYrpY2Hc9PsMMndLLUZ/PWWBegKp1xWQmP0M6vgFPN5jKF56CUjzBVy5Iium55eNc9jbYAMxYRtymC+3N/Z53GdVEtwPDG6o13gC4BT4celKN5nvbU77zg9mdv5ZBC51jnGLrySHajj7ljEos0XQB0CIaXvTfmOSeMv2+VAX98BPOkF/eDWAUSEqLfZfCFJscaPZghJnl63ZnGB5ItRVqM33jLmadyyXm2FOs7JSbYduDj8WYgbuiZfLHJdMmrtLjggx8NXegEqEQpd0oM9oBLozlNP2d395ArVTAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmqLpgtwx5Fb148kbmNDCVWaATvuYgwYRIZXPJZ7How=;
 b=sIoS1Qs4oVqi8Csu4jvf3hhzHd1Apt1T37Vh1svIpl26cuB9yZ4jCUhvmjhOT9DRNZioToviwdPXdq7EbtG9ln6PCpEElPLR6SE5/E7Z5OFc/ktavQxtUQBKE/y1/FjtfkpSAXCYTErzeyPU3xurkR2Q0SBuvbNr1qKe6+aD1N6mAUKYb8HfA0NVHYS7g1LrEclKQ3cGiXi+EhZt+Wev6XbWzCmtvnb4SnFyvDjrh2jYq6Bozz7CsPVgS43QhP2o255VeGylGEqik4UctDSigf/OCTJGmtpkcCH9OhMbLkF2xxMyITwUIKGgin+p1Pd0QOyQYMU90/Bnr1+v/LNgVA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Sat, 8 Apr
 2023 08:14:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6277.034; Sat, 8 Apr 2023
 08:14:46 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Lei Lei2 Yin <yinlei2@lenovo.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: Re: [PATCH v2] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Thread-Topic: [PATCH v2] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Thread-Index: Adlp7D0a6eHDJ2XCQ12f5YXOFDMnBAABHCCAAABgHQA=
Date:   Sat, 8 Apr 2023 08:14:46 +0000
Message-ID: <ce8d7dce-ac20-91d7-bbb5-db80997b0730@nvidia.com>
References: <PS1PR03MB49397BF066FA9BC5BC5EE72488979@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <a5cfe4e4-62b8-5cea-c4bc-06d905ffccf1@nvidia.com>
In-Reply-To: <a5cfe4e4-62b8-5cea-c4bc-06d905ffccf1@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA3PR12MB7949:EE_
x-ms-office365-filtering-correlation-id: d1f31ad1-fe57-4e81-9538-08db380950c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzj6hXEnBTK1TIAcyqZAkpUZcGZHVka3zLhSgfeNXCLJL9AakJqg7/4VXVqXNXshEdtdWH5h1oPNSw7URIqF4wCQtUW2K42OVJWieOcVhN4wXJzp9FzqGuZ2wj7kyi3SBXwuMjZm8urxufwmRLvqHxkJ+/LZUdof6s/UeIIAevEtTiSEF8hVe3KuWMTUlbMaVnw8v/dpc96zPrHPZkSxaN0qWMkJyMW5QVRfOt5X9PqE0W2cvIU2uli1Wl9MIuqCueyDzsP0QBoqP9+OyhQvejRdFwhdgVQfvOTA2nubfOAX+nAMka6mP0RggyMfSdDwfap1YZme/K75/weQGfSwS1VW8S97XyNoz/JhozBx082jlTdMGgE7Iiv+TDWCbYT6ER+6/IHXAGDc2Ao19oZksRcYi2Jcq2PCb2ath/hHplYzP8279LXqgYe1KJAm8tk6DRvB2kuEz6DY1gxBALNkZ4YpyAIAPMqhMLSSTO5HF2lJ8CdsooZjnJ9aqA0o4yiKJsi+zoxAWPxhy4foQDRcd5REBpooi85oV1kVtlnwe1k9GMqAM1bD034FttQS2enJJr5rSQaU/kTsLqP/ELXzTi92InjKEsOnvtXN4FJfak8aHu+7I/bkALV2F3XIzSrzF2Aju9us1g73VqzhWWspxd5FQDdZ8Ty7jMsx0cXPrxCszanaWT9+Nc7XVwgiigO9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(86362001)(31696002)(36756003)(91956017)(110136005)(316002)(41300700001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(6486002)(54906003)(478600001)(71200400001)(5660300002)(2906002)(8936002)(4744005)(38100700002)(38070700005)(186003)(122000001)(53546011)(6512007)(6506007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHFuOG11U3ltd1VwVGxEQSttY1grdENER2VQb0JDbG1ISWhWUmsrUFAvUHNE?=
 =?utf-8?B?cnQ0VUZ2OGNJdDRjYVoyMmh5OWpPWGlJTmlPck9GTHRoVG9DVWV3WXVGK0lK?=
 =?utf-8?B?RnZlRWN0UmxsQnk0dE0zQWZ0NnpDQXhrcHFlUk9IeDFhS1pjZ1VWMDhlVXdZ?=
 =?utf-8?B?RWtFc3MvZFhURGgyWHZDWDNJWjVlcFNvODRLVkhwdjVOVndIaTBwcFMyN1ly?=
 =?utf-8?B?TWQwQmRLTEpycVpQdlo4OVZTbUZvY3F3REpZcXJRSGR1UXVIZUc0cjY5bEV1?=
 =?utf-8?B?S2JjSHdlU0RzdU9MTWRNdjhaQ201dzg3UDg4ZnRhRVZsMjdubG1jZFFJUEZS?=
 =?utf-8?B?L293MmJaT2pNejBLbHp2anZkYW5xdlJpdm9oMG44ckREUGlTUDAwRVNnTThn?=
 =?utf-8?B?RWU3ZkJJTWE0anZXbjAvdkwrV2I2NDBBamx4TDFlRkFXZkJpUWJSemtVU0h2?=
 =?utf-8?B?YlpuZ3BiQk9ub2JtQWxQZVNGMUFxSkw5MjM3Z1BiOGFqaE1VMnNENUtPTUlt?=
 =?utf-8?B?eWRIWlduYis5WkNzd292NGJCRTFVdXQzb2dRWHJxMHVIVnRNZ3JBdjI3SW1i?=
 =?utf-8?B?emlmOTVNaWxReHJsaE5ReDhXRTNlVHY2dlVXSDZrTVQrV1pkZVFrQzVMN0xC?=
 =?utf-8?B?cVdJNlJxTTdYaWVWOHhhQkZ0M2dIaWVuSlpUdjlUaC9oT1VkcTBVa3hkeWo5?=
 =?utf-8?B?N3VDQitqUWxFU3k0TlJYS0xVaXRVTWhZVFY2bUtMWnNHazJlRlNDWXh2NEFZ?=
 =?utf-8?B?YnlrRjFSMytmeStham5nN1NJdHZuc3grR1NVY0thZnU3VXJCeW45Y2FvbjRB?=
 =?utf-8?B?RkJwVGo1N1BwemtMZXRJbU5yTHBKc2gxWkdzNThkSnFuQnpIanNpV2M4SHp2?=
 =?utf-8?B?NkRwb0tRUm13b09nYW9FZGt2ZUVaTy8wWTZJWTlDbEc1V1F4dnBKVUlYTjla?=
 =?utf-8?B?OHBSbEt5VnNtaHBoVmtwekk2eHRicFVtbnY5Z0xJVXZCWnl0QjVZZmQxOGQx?=
 =?utf-8?B?MTU2bTJJbVRHZ2p1cWhzck5iSjhxUTJlaVlndmkreGZqQWFPSlBOMEp0eEU4?=
 =?utf-8?B?ejRnckhjNC9laVYrUUx2VEVwMkZyaU04d1pUc0FOTThXZ0xxUmJkWkVDcisz?=
 =?utf-8?B?VjFtMEwwYlgydTExSkNNRzJJZTdHVUhnbytaM1I5WGt0M3VrTDE1NU9YZ1NX?=
 =?utf-8?B?aEFDeUdsK1FCYjJYdy9qWDJvWktVOTlJSGV0TUJzcFFzWkVLajJCVWNvbWZX?=
 =?utf-8?B?WGFMdUE3S2pKWVlmbWF4S0wxMHRPdE8rWlRxc3Z1dXJMUlFvazZMYldWRXhs?=
 =?utf-8?B?QXd4NUlyd2dNM1p4OHRUUmkxd0twdU9KNGplOG9US1ZIeGNUMzAwZ3JIMUVQ?=
 =?utf-8?B?cG50RG9xZnVaQVV0VDZ2YkJuOEZJaFNYZDljNmo1MGxYZytCMDBvUW9mVExJ?=
 =?utf-8?B?TCtXdFRGMDJsWDUrNGd2MjFXNi90d285ZVA0WW5SZHJPKzlMQkxkSWN2L3dz?=
 =?utf-8?B?WlJ5S3lacUFYdCtzdm9DSDRjendxUWxuekRFKzhYV2pMZXIwNW0yTVZTTXdl?=
 =?utf-8?B?TWR0VWc0MXZ3aU1zTnUxMEp5UmIxOWhnd0ZNTXFuU0dUMTMzK0NIM0tielB1?=
 =?utf-8?B?aXdMOTFtOTFZanVaR3RXWmFsSThPY01GM0tnaTBvcDJ3M3VwK3ZSbHEvakkv?=
 =?utf-8?B?Uk5EczB4OXcwalFXMGlMYW5mTmsrNDdkVk1lT293REVaRjZOUXR1Wlp0Yy9O?=
 =?utf-8?B?cUk5a3RSY2NNaXRZU0g0K2xJcEVxMEZXWmRXZGVaZG5hZWZxTnV5ajJHSXhN?=
 =?utf-8?B?WlltaytKdUFZSEJzUjlIcFczaG1wdVMzY2RiV1g3ZHZjSXNCM0ZLQ2lZR28w?=
 =?utf-8?B?Q2dUVTZXWksyRWVMbTd5NDlIMElBUmlxcXB0T3BJUXU1RnVqRlBtLy93QUtu?=
 =?utf-8?B?bE8yM0FZME0rMnlTWXZJb3ZFOHdTRTVkaWRRVlVaeFZ3WmJkNHZ4Y0hoY3lM?=
 =?utf-8?B?SEt4cXRiQ2NHYWxySWlNQVgydmlyNVlrZlBCM1NFbjZpemJ3Q0QyQzE4K0FK?=
 =?utf-8?B?OVc5ZURQc3JmdmtyTXlsbkN5MDZmdEtlbWhvWktmN2dORXZhYXEySktrTjh5?=
 =?utf-8?B?cTViSkFrUU95UkZnVFExSlRERzJ5V0FlZ2RIUHlCMjNiQ2lHMjdQVXVGVFlk?=
 =?utf-8?Q?IrAkRZlX3I0gF/BIL2kifZb9a4ePgVaT3MLSwn0T5eVW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF10D297CECAC14DB1BA437B906F6488@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f31ad1-fe57-4e81-9538-08db380950c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2023 08:14:46.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUQ5sTpsdvG63YqKqdQPsPfjTr8Mh7KCC5MRmKOexQCkF6mbDi9XaMfFdMulKebduIWPKGjRsGeIdLlsJ79UJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzIzIDAxOjA0LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+DQo+PiBbIDI3Nzcu
MjUzMDkxXSAgPFRBU0s+DQo+PiBbIDI3NzcuMjUzMTAyXSAgbnZtZV9mYWlsb3Zlcl9yZXErMHgx
MGEvMHgxMjAgW252bWVfY29yZV0NCj4+IFsgMjc3Ny4yNTUzMDJdICBibGtfY29tcGxldGVfcmVx
cysweDNlLzB4NjANCj4+IFsgMjc3Ny4yNTU3MjZdICBfX2RvX3NvZnRpcnErMHhiNi8weDJhZA0K
Pj4gWyAyNzc3LjI1NjEzOV0gID8gX19wZnhfc21wYm9vdF90aHJlYWRfZm4rMHgxMC8weDEwDQo+
PiBbIDI3NzcuMjU2NTU2XSAgcnVuX2tzb2Z0aXJxZCsweDI4LzB4NDANCj4+IFsgMjc3Ny4yNTY5
NzhdICBzbXBib290X3RocmVhZF9mbisweGRiLzB4MWQwDQo+PiBbIDI3NzcuMjU3Mzk5XSAga3Ro
cmVhZCsweGQ3LzB4MTAwDQo+PiBbIDI3NzcuMjU3ODI3XSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAv
MHgxMA0KPj4gWyAyNzc3LjI1ODI1M10gIHJldF9mcm9tX2ZvcmsrMHgyOS8weDUwDQo+PiBbIDI3
NzcuMjU4Njk1XSAgPC9UQVNLPg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExlaSBZaW4gPHlpbmxl
aTJAbGVub3ZvLmNvbT4NCj4+IC0tLQ0KPj4NCj4gQ2FuIHlvdSBwbGVhc2UgYWRkIGJsa3Rlc3Rz
IGZvciB0aGlzIGZpeCB1bmRlciBudm1lIGNhdGVnb3J5ID8NCj4NCj4NCg0KV2hlbiB5b3UgZG8g
cGxlYXNlIENDIG1lIGFuZCBTaGluaWNoaXJvIChzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20p
Lg0KDQotY2sNCg0KDQo=
