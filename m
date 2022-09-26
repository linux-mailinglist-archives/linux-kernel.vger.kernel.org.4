Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DC15EB474
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiIZWSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiIZWR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:17:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B296DFA1;
        Mon, 26 Sep 2022 15:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee/BTiDfIIUZ0cuyxnOpDRBZs3s7FJcr6WrPsnPnorWVll8mfLWHQ5NTGW8MSP236fMQ5yzKTPBWQuKPYNXPvr0fcES1CmfIYW6ZhqqLcUbenwHvh7HjH/H1ymfeL2A2Vkh+TsmDSsLd+HRyWUpLmLTUC1IWA9BZaq6TdjajDHtLQYiulXVj9K//vBe115+Wb4nEY/yImTZYhlRsahZlMvv9Ud1nVsqQau8o7q9TRkhLQswGy1S4jq4xxmk2FuzPJGZKRHl/j09c+pMVw/nLDH8JMhS5L3+MYNHQnzEA5DcdTmWQQ7YyyzFVRqy6qvUBTBujf4QDNTZvlKMvRcL+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty2W4IsFy4ZNYtuHUp+OLOWv6xbTHSAoBwmFr4JD9dY=;
 b=c8tKvT20+nwI83ZYLX1yeanWv27uNXV91JNEYEJIfgBtecPCwKUN/LpAOy875XECsenRX4f71qGw6HQytv326bMdxkMgtpVGHf7ZFFZ3QKzaMPz7hF82cJ8znxRjtUSCdrwsFF8c4XkxNuSRnMzoKMMoMMVEx9uEHhQBenAwdB0dfX/1ovb3ZnE+VJDIH+8rGZE2g690kf9IG4NeAYQQVVZRpDZMJ9Yb8/pxhSlZbYTRZ4wWeLI6iYonS8+aB+gm0sIqlZp7wBum3W5jfAqzQOjJQ5VPiYbJCBambqFhHxmiX0ijY+Im8nO92fnUISU5e+H4xG4kYRydFCZ/7BnXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty2W4IsFy4ZNYtuHUp+OLOWv6xbTHSAoBwmFr4JD9dY=;
 b=lAnfUJWuxuv/7+XzFNq8uP50uV11/+TJSxbhZVYFvEahF28X7Z84V+BDpxcJZleLOVe77gdMyuyR5rAtxVwU2WdmOk2tzZJyBrQ3J6pBxNmgJBczE1krXYOkqrCe56+la+aHwpZpU4r6p9ueKmJzTNa+39+37sJMhJHjmd32cq3K90KabWrEo/B7GqxcPJ+F6Gc+coBoefjIsXr81v3rDg+R1wR3p60GQIwGu26cVBAo2eYS8hrdLVJzC2ArwRNQAt7B4K/aIu/tCry8NHAxBgrLkY2FBBMpo3J3rAAZ2Aa1jHgIxw2zeCzp74gKK3wW/oQhy0yGQ8/mbbi/zXT5Og==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 22:16:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 22:16:14 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Khazhismel Kumykov <khazhy@chromium.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH] block: allow specifying default iosched in config
Thread-Topic: [PATCH] block: allow specifying default iosched in config
Thread-Index: AQHY0fOexLoGwiiZvkeQ5ABDaQqst63yR0cA
Date:   Mon, 26 Sep 2022 22:16:14 +0000
Message-ID: <3362d316-0c86-ecaf-4422-d12ee115a2eb@nvidia.com>
References: <20220926220134.2633692-1-khazhy@google.com>
In-Reply-To: <20220926220134.2633692-1-khazhy@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6639:EE_
x-ms-office365-filtering-correlation-id: f09b8422-bccf-4605-3fca-08daa00cb9de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qCer7Hc6UFAgvdlD3b4wLDpUEW9/WP71PO+0COrl7fINAx3jjJ72JinhNaY4d48HYfjCEBy1z5sUmdNivwB2ioE2e7bOnbhNzRY3L12JbNZKIW8ilvXVIYHhIqCmcDvJvfohs1gMTXZoHLoEUsgp0fQ9+pxg7s9xB0OK8Olqu/YmHsZNd8zpKdrpvn2xDCf6f2ATfI07rBrhMzJvruqrnElCyuaFjfSnkJWqdOqVKxNTJtcU8Tsj+C1/Cdqbk4FKfrnF9ix7VYhsxNa48Mz4wXOZQGYykNj5hMID6G+6zBY8ZBbZ4csBFPeHEjBsKuvO/FcpRZ0edqqn1R4MwPEPc4iy5tyktZ9DFA8YozsKk5Fa1e6AwzopnGJPwK+DytVA100AkjBc0apIkgATr9ihBWaW1uXXlZQsPTIKMJnuRvoozNVV/8e9LyDSrmyFpC/99mhjUKdGB3PaRuN61LJRqqiRA8ULAS6Ehda6NzL1pmIeYOU4KSlt2wQMjq4MXRUFQjIF94BtgEW5G6FsSc7mGJ9WUJjVX8DpKvECBx6wBjAHMN7QWbIyMoB/RauXZXnjUXAUD0uoSb7L9CfXZn7NAnIhY/biENY69vBjvY5PHeRr8j0CDnygzlg7fp2yvi0Oe4FvoArUbNHihFRUQFxEBFRGJ2e+6tunIKS3GE4s0XBMYpugHv7IJe0btV6vjEBx/4WZYoWZzzjDKfnWD/58BS2CWuRmS7dZmGWVmuVScbKy13rflg0gd8GuxnTTiZjFGHIF9Bo8kIFvv5qprPAsGv6yofWA0Bw4hRG487W5qzj2eZFspQuXOxGRLp/6FKshdafPyrOnitzgccaabER/sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199015)(71200400001)(38070700005)(186003)(2616005)(2906002)(31686004)(91956017)(478600001)(316002)(6486002)(36756003)(86362001)(6512007)(6916009)(54906003)(64756008)(8676002)(4326008)(41300700001)(66446008)(66476007)(66556008)(66946007)(76116006)(31696002)(8936002)(53546011)(4744005)(6506007)(122000001)(5660300002)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2JGOHBpdlJjbFNDMG1QVEtQRnhVdUJ6TU5PTUZMNXBJYjVNQUJnL2E0OUE3?=
 =?utf-8?B?QmI4YlYyMTNjN2ppLzVyMHkyZWVhc2VHT1dsbmdlTlo2Q0w4bXg5aENScHQ2?=
 =?utf-8?B?aEVqaldMQ3JmQklLVHN4NzZSTHFmMktLN2ZlVzNJZUZPMjhoWGh0bCtCaEV5?=
 =?utf-8?B?b2lrSWw3aWt3OWNzdXFmMjMyLzFtOWFtWmlDeXR1MHp0RGhmR25idXpaK2Vi?=
 =?utf-8?B?Zm5iSEl5SjlJVkpwRW1TUlBTTVNBbExiTFBXajdkOVVwdUNsa2IwRmtsbnpa?=
 =?utf-8?B?eUZTekpGZ21MV3lpOWIvbFdGZDBMZmJ5eXAzTjZ1QjlhTS85OHAyNlRqdVZF?=
 =?utf-8?B?MjBtdXpETHhyYnhYMlc5ekkyK0VrVlQ5V2dBdTdIUUc0aHEvZjhkRWJDczc0?=
 =?utf-8?B?OFhiUVZ0KzhaTnAvWVNpQTI0d2F6MFdQUWtiNnNCWHc1bnJmUlJsd1JOSVdG?=
 =?utf-8?B?OHJuVXdrQllONk92cDR0dUZ6cmRZSUdxN1B2KzF2bFB0TGZLQitGNkNYbUx0?=
 =?utf-8?B?b3UwRmlIdGd3d0ZISGtVUmgxNlVjTXdaMGdwTzRpZ1dqUkZXZy9ERUdDUUF5?=
 =?utf-8?B?TjIvODhta2RZd2J6M1dTKzQyRE42MEdSMEtmYXpJUHlJU1dOUlluM3pzbnVm?=
 =?utf-8?B?cWxralFoeHdITE5OdVRSSU1VbzIwVVU1N3gxUlUzbUpVeTMwSnRTbXRLbk9o?=
 =?utf-8?B?NmhqVGJBbHFzYTdNTW1IZ1BXOGZlVDZyaGJUdmJyOCtwZGRvMDBMdGs1R0Fp?=
 =?utf-8?B?Mjg0MDVlTUNJYXNlanR3anl2TDdra0l6ZEJYRW5maE5Za3pGdksxNHpRWTc3?=
 =?utf-8?B?dHJhVkhQa2t3bUFQTFQ0eFFLT2dJOGNSNEhRdlo3Q0VmeDMwcm15R0drajFD?=
 =?utf-8?B?WlppNjF6RzNidEdmcTVkcjErMlkwK2E3ZkoySWgwRmw1bjZ1WWJRU1BXQVor?=
 =?utf-8?B?VUtNeVFoeVEwM1ZtYzFySkd3U1YyblQyZjUyMmNDTTVLbDJJeHVBZjNVVWIz?=
 =?utf-8?B?T2xsZDhVNEZyaXc3NVlLL01ud3owamxmcDhWNWxVQ0JRN2ptL29McDJQOGVT?=
 =?utf-8?B?Y3hBeVBVT2E4dWRQUGlEejQ3VnlNTUp4NkdWeS9DYmRtV1dsQk9PQko3NUdq?=
 =?utf-8?B?ZmdvZHBmbGR0MGdoaDFNMzc1L0xMSEtpNHgwZlFMZjg2aVBBMkd4YmtpUzYy?=
 =?utf-8?B?dEJMVG14ZDV1MTBlbUV4QTlpTEhvU29STHB6Q2l2Y1VXaFJoU1VzNkdKU0V4?=
 =?utf-8?B?UG02RmVPQTBNOHg5L0E1anZZUUZkMENkcFNJVTY1KzdOVk1mN1c2c0k0MUZ5?=
 =?utf-8?B?SjRFQmtrSkQwMEF6a3VxVTQwWno5bVZZR2lPU2NFdmRDaDFnVUowUVNheDli?=
 =?utf-8?B?YXFQYm1weUc1U252MXN3L2FLTGVhMWJZU3VERVFSc3JlUTFPZnh2cjArTzc1?=
 =?utf-8?B?OVZkNVoxblE4bW1GcWtic1RhVThWcWRZZi9LM040VXJpaHNQNWJCQW56aGh2?=
 =?utf-8?B?bDAwRzhJNUxuOWcweDI1aUxzL0loNEw3MzJrUERSY1hVN2w1b004bUh2OWVa?=
 =?utf-8?B?cys4ZmdQcU45dHhWc05PNXJjdzlOL21CWnkxUTc5WmhydkdRc01FQWVyZ29U?=
 =?utf-8?B?WW5qQlZ2NE1TbnEzUVhHa09oL29ZWlFyTFYrMTdQbEg1Y0ZjdThmc3Q0NGVH?=
 =?utf-8?B?NzFydExQczBtUVI0U3VoMlMyN1FUV2s3YWVZekVSTGZpcmsyVDNPSFFvMUhC?=
 =?utf-8?B?NGxSenRzbVZwK2RaVFZ6MnpQbkFNUXFqTHEwTGJCWGJWQ1JNUHhpZ3lFV2ZK?=
 =?utf-8?B?eWtNeVVaWlpmRzhhVEg3SENqOEVwbXZ3WURQS2pVT29HRmpGV2xRTjZmWG1h?=
 =?utf-8?B?K21UczlkdmlPMnRhb05OT1VYdFMrOFR6RmJTNml3R0xuaHFWQVZ3V1hWaTdj?=
 =?utf-8?B?M29IZUlpa1hRaE5qZGI1aTVkdERiWHhOTnVPc1N1MXQ0bDRKUVVMT2s4ZjI4?=
 =?utf-8?B?bk1YckJrSGpvRTJxcXJHU251K3JVK3htREp5YkRFU2gxSmtEZHhzOWdiV3dE?=
 =?utf-8?B?U3BiZktFMTFweG4xZTU5TkR4SXluK2xyYWdPU0R6a0RhQ1JtTzN4WE1TUkMx?=
 =?utf-8?B?TnQxMVBIVFd0d3B0L3ErczhRUXV0Sm1CSXlpYzdQbFpkNStOR3FIMkhkZzdy?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <055D8234F77F1048BA32936C36EF13BA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09b8422-bccf-4605-3fca-08daa00cb9de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 22:16:14.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMgHnZWk0C9PLqGxcdMdGROkX/KzCHz36jXPDE+gUD1HSfzhhIxTgKd1VLFcvseR3+3grfdZcbLhd4tnztD6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yNi8yMiAxNTowMSwgS2hhemhpc21lbCBLdW15a292IHdyb3RlOg0KPiBTZXR0aW5nIElP
IHNjaGVkdWxlciBhdCBkZXZpY2UgaW5pdCB0aW1lIGluIGtlcm5lbCBpcyB1c2VmdWwsIGFuZCBt
b3ZpbmcNCj4gdGhpcyBvcHRpb24gaW50byBrZXJuZWwgY29uZmlnIG1ha2VzIGl0IHBvc3NpYmxl
IHRvIGJ1aWxkIGRpZmZlcmVudA0KPiBrZXJuZWxzIHdpdGggZGlmZmVyZW50IGRlZmF1bHQgc2No
ZWR1bGVycyBmcm9tIHRoZSBzYW1lIHRyZWUuDQo+IA0KPiBPcmRlciBkZWFkbGluZS0+bm9uZS0+
cmVzdCB0byByZXRhaW4gY3VycmVudCBiZWhhdmlvciBvZiB1c2luZyAibm9uZSIgYnkNCj4gZGVm
YXVsdCBpZiBtcS1kZWFkbGluZSBpcyBub3QgZW5hYmxlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEtoYXpoaXNtZWwgS3VteWtvdiA8a2hhemh5QGdvb2dsZS5jb20+DQo+IC0tLQ0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
