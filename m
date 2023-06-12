Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00B772BF35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFLKgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjFLKgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:36:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A559229C7;
        Mon, 12 Jun 2023 03:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqRROqBwBbydtP230psJrqNe9v0KR958Nv4f7djD6ZEpsHhXzbLXXGy0uSu5sDmyHL3wdEbjJFjm9xCR7DYmMlaUb5CZDOSpZz5aQR5KewRUc0KTkxYtO4Wfk3FL46eA4RRIM9dJi83QOutyRF12E580usyBJpNXJzqc6wRjZKdskeLJtAYxW3CZU1m2H75JbzRFIsYchpIrA5/IOYZgBfz6QaGrd5pGixMa9uN1Y+lbbqtaZ3MITvwNzuNq95a2q/nKaApK1uLoe6AjtMdECRHYF01Kh9C8A1rw7B47LlaKf1mREsCaTk0iXZHrfa6lOpl/8tfxwuGld5eEEh7dAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OhU3IDInUAhDXXfCtCwcqhPgehLtTbBpd9ASiSuy+k=;
 b=Bkchljfb71B0osEFU9xIjKs+6wrF1nEfA1h7lnIcELegdFAcwfafn6NtvXvY7+bK4v+ojbGkl+AdWTdpSus2PKhBRSUBGXujW/oIRHA1Ij9hxWwMuT5Ql7D1ETUEGRvrHF1GjZehEb2QyYBOW/9K12VKomrcwWWCh4tRzFnm5kR+monEgJzmiUXnc/3AqaW7NHt3M3gQoZZXl592wyFxBnEIeKKzIxUFVyGU951zyRcZCF8kgxz8PtNgrtwNWMkpONDjjr/dAONaf/dZ3k9Er2ioyHy2Sm44a+sax0coYjjLz+0Ws7vXWqUUHF9Kzb1LYckpxbPsIUYfsWZ3FgXYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OhU3IDInUAhDXXfCtCwcqhPgehLtTbBpd9ASiSuy+k=;
 b=uFQa3YGw58OshQUa+7u2fXKUQzwpcuJzHYJbtZMkjeYO1hTLG0yr20BE9WlF/vDU7/Ap0tiuFvfRJg0m/59G/H1pPjI5PhMgkIkU9xgsg+C2IVKQZIYE9xjqmNg/L6M1FG3koYlHhb8cheLRiMKsWEsKRSzqE6/lOXozXWadSB8lhrIg8sgJOO8az2MXGTpwBzTX8WYVOqXeb0av5AIrbkQoZeXUF03ZgccVGwGk6QzGKaes3UOSHmnVyTmkbFoVophO2qVQE/LSSfvJtfB4xBDQoaJpWkHYReuq3UqQTCXJXP+V8ywe2ZCnIYzzTFJm2oIx6PIV6s8pAhwzXuyQhA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 10:04:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 10:04:28 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Lu Hongfei <luhongfei@vivo.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:SCSI TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:SCSI TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH] drivers: target: Fix the conversion to bool in
 iblock_execute_pr_out
Thread-Topic: [PATCH] drivers: target: Fix the conversion to bool in
 iblock_execute_pr_out
Thread-Index: AQHZnQVYnqEsqy1sVkGTpagMvzc+ha+G8IEA
Date:   Mon, 12 Jun 2023 10:04:28 +0000
Message-ID: <53382bf3-69eb-b297-70ea-22571b877a2f@nvidia.com>
References: <20230612081006.40821-1-luhongfei@vivo.com>
In-Reply-To: <20230612081006.40821-1-luhongfei@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH3PR12MB7668:EE_
x-ms-office365-filtering-correlation-id: 64d7b3da-3ef3-4345-0a60-08db6b2c6911
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yCy09LLG2GqxUCpJoAs1ECpPuSCfLbAH62En98A2F4TLUYf+gBdOUyA5wkscLGceq3N26vzqD0PqYKG6aJw4tFAH3MDPSH20AqqgslvNBHHJTyBF7Bg2TDXJokty8aAaPYjFzunFiuVTi9CI5nwy9HJjPL2Go4265rqwNTigih/Dc6J9hkhuAGb+XeiIeXGhYMezOoKvyWJfoNLRu2KLBG9B47bpOjwOSrNi2c013GtF7F08LLEiJm4s+4TMfuPQH1PE6mhlT9K2jEb2CmmDTTOGnetxXwEP4owjxnZQ+zVi8A+d/JOfi7AgVAES/HCnnmyeQDoMQd5NCBxDiMgs/UBbC1vioCV5eT6IDj7w6c3k0dIDcyvXoSWDX1r5eFozzWpe4rU0t0whpdaL5HXRVAWBHFYHVM2ZwSWhPk8pUp/qZ/7kYxKiuL2bJBnxJhs3uXsXkynsDSBX5bbgbUk+1kneIIm8TICSlOm+88pYP9l/4TAshohdbK8eJLz2OjkX2PCtNLYKBxJxI1Y5uqc17mohVrYuCCttBWyuEZBOiEu3iKZPZEKykDcgrKY5iumQrj2T1dkFyIMumba2EfP0IVSFq2aU1IuYkSuJALV9neoMfHJ1mwXrQqtv8vaBPfu1MMv1DJg3ppVh3nyHRgzI53/thh/yXsPGLYK2CAIPYePseXutvYtSvwBPEgSqHyRZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(110136005)(5660300002)(31686004)(4326008)(66946007)(66556008)(8936002)(8676002)(41300700001)(316002)(4744005)(186003)(2906002)(66446008)(71200400001)(64756008)(478600001)(76116006)(91956017)(66476007)(6486002)(6512007)(6506007)(53546011)(122000001)(83380400001)(36756003)(38070700005)(86362001)(2616005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0gyM0U5YVh6d1ZTWmlSS25MdzhPbjVMcjJCS0Q4dm9uUXcxMC9lNnZEZDFF?=
 =?utf-8?B?YjJlR0pBSlhGYkFKdkREdkVwN3k5dXdvSmY5QjQyS0RudHBYYVhpYmtJOTFY?=
 =?utf-8?B?Zk5FbVdTMGtHMi8xL0UrVHN1MTVlQitMTEx4OTduV3IzTjdMT1B0a3FaMkhL?=
 =?utf-8?B?WE5KeWM2WnFJdXpNRy9rSkp5OUhVS05uZFJObHNhM3ZYSWtJU2s2akQ1WXIz?=
 =?utf-8?B?OVRHM2grZjlQdHpMeW1uTkdVMWs0L2dONGJBdUFHOHpYRWsyOEtJdXpnMytL?=
 =?utf-8?B?eUJDQVowcGhrc2xMTzJYWS9HQ2pxaGYyNnRJbjZOT1g5RDRqdU5yemoremtF?=
 =?utf-8?B?SHFFVlR4cVNYUHNpZ3FlU1VONGFkOW1CUEQzYmJ1eEhieGRVZDYvbHhPM04z?=
 =?utf-8?B?dGlwN1VsQjA3L01ST2kzS1NsNnRlS1kyZi85MnZrV1FhWDBsYjFRRS94ZnMw?=
 =?utf-8?B?S2x4Nktzd3VDOUlyUDJBSlN1UmQ4eGtCcUwxYlRCVnZoY2FpMjgxZHFzRWNo?=
 =?utf-8?B?SGdKQlMwaCtHZ0lJY2NTTXRZWW5EaUhyNS82SEYwRjhSOG5MRmhYNFJHVEx5?=
 =?utf-8?B?QU5ZRU9kc0UyUStSK3ZpV3dpajYxSFVpNDhrbDdWSTNkbjZrOGg5ZEtpcUlv?=
 =?utf-8?B?ekhXbWRMdnlHTGQ2VTNsekE2WGV5ZHl6N0NnRU5qMG8wWURtbjl1Rm9nRlhh?=
 =?utf-8?B?RXEwdEpvNDBNVThrODV2WG1memYyclRjOVlCcFR4ekVnZ2NhQ0xrNzYyMEJ5?=
 =?utf-8?B?NXYvUUYyU3liRHdnN1pkSk10eFowNnpLWENyb3Ixcmt5ZlBhcld4aERvTmVj?=
 =?utf-8?B?cHVsRStoaXM5QnhweEtyVHVQalp1RTRIUFRzcGhKR2lVUEsyTEVxV2NBRHJP?=
 =?utf-8?B?bDhZaGdsOHRRLzRoMmhGbDZJVEg0SG4wYUhDdGdEVk5FQUJNaTBjeDJIdlRW?=
 =?utf-8?B?aE1LOGRPY1hpSzdkcXVWblczWG9SL21jdDBLSXRpTnRCN2phVElPSEJLaDhw?=
 =?utf-8?B?WTcvbW9VSVNvQjZFSHkwbjZ0L3l4MTl6V1VrNjBlU05ycG12ZUR4aU1MSDFZ?=
 =?utf-8?B?OGkxT2h4VFZldFFtWll5UGxBdnV0elVHRDNZV0hTK2pMa1lmVi9MVm02VGZR?=
 =?utf-8?B?NE91V0c5RDJGUGdoSmdNemtCaG9LOGZYQTljNkZtNnl4bE1zUjRnclJNdTRv?=
 =?utf-8?B?VytEL0xJS3VxUFlkVXpsOCs5ZWw4SVQwczR2R3cyZzg4aXVLRHptY0tubFUv?=
 =?utf-8?B?SEtlNUlDS3hNSFlScm9WNXFzRVZrZDc2RXhkTm9xd2ZnUlBldjFlNVZua24x?=
 =?utf-8?B?Y0J0Mzg5OVAyU0l5ODBuWUthY3B6YmpnOUVLZmVySUR5TlFWS2d5b29wc21W?=
 =?utf-8?B?YytkNzY3WjcrSTdBbGY3cmIxd045azMvb3ZlYnBvVVl0bUNaZ3VLZmh6cXJZ?=
 =?utf-8?B?OERhVWNMNjNKM3Bsc2xTTHZ1U2VGL0RGTUJCb0x5aTJDbCtEYmhDa0NvenhB?=
 =?utf-8?B?Zk84NGp4ajJFN0hKU0Q3R0Q2V2d5WGoxK012amsveXkySnpVZER1bE1EcTZu?=
 =?utf-8?B?Y24yeWxYZ2ZJY1NWQUFmVHZaSkFEV2k5UDNodkx2MHFmMU8vbzBmZk9xSlBO?=
 =?utf-8?B?VWFYaW1SQWNHUDRwQkM0SEZJUjNpZEtTRUlzM29tUVRBbm5MRm5oVEh3bEty?=
 =?utf-8?B?Vlg5ZDNDZVRxbzFBVmpXOEtZem9ITGdoVGFuR25LaHNPS2I5cXhSSGU1dENW?=
 =?utf-8?B?Tm9PTndRMWJtR3d2blJQY2xMeU5RT3pjVjByNGJMZWJFZ3doOEVXQTc3VjMx?=
 =?utf-8?B?WG1lMy9QcXluNTNTQXlodjQ3OUU2UzhBSUFmNVp5SVk3Y2NvSzJIQk55Vklw?=
 =?utf-8?B?d2d6eEo0b2NxeXhLSGg2cHlSdng1bVRLZ2lEckdUMHFkWThpWXBBaml2VUgr?=
 =?utf-8?B?Z2NaeHlnSUdoWHgwWVJ0SE14VUl2VUtlZEg0QTdqNnBzQmNDc25aODhuQitk?=
 =?utf-8?B?MHZPVDRERHZhZjdrTVFIZFBkM2ZTQzhXWHVTOUhMNGhrdlY2dVVMaFYwZmZi?=
 =?utf-8?B?NkUrQmZIaDBzZ3JLcnpkUFlIY2FGclBta0hoOHlCeE1BQmhQU3BlZ2Z4SDly?=
 =?utf-8?B?elUvVnFyNnN6Y0pPVm54ZFUzMmlFY29xTzJzM0lnNWVnVXRqSHJtNUtuZ3Fi?=
 =?utf-8?Q?n6P1kneZ4vgKDhAMg1cfW20DARnI8z3+iPaK4Jrs/S8N?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E2570CD356989449FA5C37A8F942108@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d7b3da-3ef3-4345-0a60-08db6b2c6911
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 10:04:28.8493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WpEnaS57zo4MbktlpEjEtKt+uTbGtFZv6BEbXMCO91noOYLhdY/X7YKi1H4u3+yG4oDJyRVvU4Z0JkaABYTvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xMi8yMyAwMToxMCwgTHUgSG9uZ2ZlaSB3cm90ZToNCj4gVGhlIHJldHVybiB2YWx1ZSBv
ZiB0aGUgJz09JyBvciAnIT0nIG9wZXJhdG9yIGFyZSBib29sLCBzbyB0aGVyZSdzDQo+IG5vIG5l
ZWQgdG8gY29udmVydCBpdCB0byBib29sIGFnYWluIGluIGlibG9ja19leGVjdXRlX3ByX291dC4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogTHUgSG9uZ2ZlaSA8bHVob25nZmVpQHZpdm8uY29tPg0KPiAt
LS0NCj4gICBkcml2ZXJzL3RhcmdldC90YXJnZXRfY29yZV9pYmxvY2suYyB8IDIgKy0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdGFyZ2V0L3RhcmdldF9jb3JlX2libG9jay5jIGIvZHJpdmVycy90YXJn
ZXQvdGFyZ2V0X2NvcmVfaWJsb2NrLmMNCj4gaW5kZXggMjU0YzMzYzk3ODhlLi5lYTQyY2I1ZDA2
ZDQNCj4gLS0tIGEvZHJpdmVycy90YXJnZXQvdGFyZ2V0X2NvcmVfaWJsb2NrLmMNCj4gKysrIGIv
ZHJpdmVycy90YXJnZXQvdGFyZ2V0X2NvcmVfaWJsb2NrLmMNCj4gQEAgLTg4OSw3ICs4ODksNyBA
QCBzdGF0aWMgc2Vuc2VfcmVhc29uX3QgaWJsb2NrX2V4ZWN1dGVfcHJfb3V0KHN0cnVjdCBzZV9j
bWQgKmNtZCwgdTggc2EsIHU2NCBrZXksDQo+ICAgDQo+ICAgCQlyZXQgPSBvcHMtPnByX3ByZWVt
cHQoYmRldiwga2V5LCBzYV9rZXksDQo+ICAgCQkJCSAgICAgIHNjc2lfcHJfdHlwZV90b19ibG9j
ayh0eXBlKSwNCj4gLQkJCQkgICAgICBzYSA9PSBQUk9fUFJFRU1QVCA/IGZhbHNlIDogdHJ1ZSk7
DQo+ICsJCQkJICAgICAgc2EgIT0gUFJPX1BSRUVNUFQpOw0KPiAgIAkJYnJlYWs7DQo+ICAgCWNh
c2UgUFJPX1JFTEVBU0U6DQo+ICAgCQlpZiAoIW9wcy0+cHJfY2xlYXIpIHsNCg0KdGhpcyBub3Qg
YSBmaXggYXMgY3VycmVudCBjb2RlIGlzIG5vdCBicm9rZW4gLi4NCg0KLWNrDQoNCg0K
