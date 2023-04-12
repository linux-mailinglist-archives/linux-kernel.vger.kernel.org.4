Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D076DEB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDLFq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDLFq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:46:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310FF114
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4A/fh4KBY9omkyl1Yn00CnBAu6UqKry3if1Wu0VdQnPWAPaJS1DV9mTMzWiQLkQNHSxBCc5yuAScDMUVaNek7be7QrWxyQaVxufICfoFH6HqFxTw22PWZKEp+a41n+ik4bH5XHOKvY5xnEjlg+/JVlpEf1nGemze2ugiwagXqHhrTRFiz/CR8hX5cht4U4FGRH4BXxXfYyDZC6/RSMksajEDrEPdDejJ3Qt+xG9ZTVSjLV5+qUbUkpVknDucwgYdTiwLJU4BLo1mj3STBUqTjooT0yz8gKG0vy79qTRzkxx9gDMrGlQlQQ508bYG0czp8+XZHX7wCHyPefJbIJYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HnUs72owPfqaQATeiSiqbT1zokRqYrlWjRbwD7tVOQ=;
 b=l/nFz9Rzn6v0Y07JyHwN5aOZq+OocAzmX5hDGHIhz56KZkh6VEPJUK05jM9+T8vnXufOHmzFc4732HKkPKiF9GslP5ZczXBxa5iJOVbdFOE47wkj7DqrLuhVrIu2yx27ikrETpB8r/UlEPdtGrLREzixrmFwcR/jsVEF1TPETxNeZOuYGIl9Q4835KV0zX0GIIc8i22x/OVK2E+MxyXqPtjxIbibsVMLesU+I24BCUMWrNUncooT6NWEbqxscwOBou3uqt7HodN/lMXa2upn8xp7t0IZ+9yUUEEllJ/1rZsdaqbrgDC3ro+LiP6AFp2vknlfPvs4Z9UkYSxyXwEIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HnUs72owPfqaQATeiSiqbT1zokRqYrlWjRbwD7tVOQ=;
 b=JFg93+AMrYGbF5ZR2nxMgSy+nj9LNrpdvWtH6EIbtglXUGUfAo0rGnqyjpa8l09l76x+JpvZqxzBg/w3FtPlb+jN2ar7zebU4wVPtfRyD900vnRJtsBfpSjfBnge5HYnekLFiHeBe/6UecE9aeC8o2BLKfI7LOGUS5gk3JeTisLhq7qFL2IN27CPCPkngZMD3kOa4GSL1yFczej1hhbYGqXf1Oiy3XYt7WzLiNQmK0b1rp0fbXaevtYf0KHpE28tZ4lPrDroZOlTj+h+6e3UH3iCX9oPnCrA/G5gAq3KE7saYUdG8iYcyy1WDCxOvaoGCsoj3hzCUEG8PcnHQgUGiA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 05:41:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 05:41:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "j-young.choi@samsung.com" <j-young.choi@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-integrity: add rq_integrity_payload_size helper
Thread-Topic: [PATCH 1/2] blk-integrity: add rq_integrity_payload_size helper
Thread-Index: AQHZbP7Co8vLUQDJDkye1nvZzRpZ2K8nKMiA
Date:   Wed, 12 Apr 2023 05:41:11 +0000
Message-ID: <91df2b07-02a2-d034-bd8b-a67c13ca085a@nvidia.com>
References: <CGME20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
 <20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
In-Reply-To: <20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL0PR12MB4865:EE_
x-ms-office365-filtering-correlation-id: a560b8c5-29ee-412c-3f5d-08db3b18863a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJNaH/+2mcAK1lmCXhL4k0HT6y+EYWF/nCTvmuLdWMtGQL/0nTAIt7KjIQloPe9F8g4suCJPZ2oEew6336+/9D3yhTcOSmDSB0iBTWU91U/CMigieKQeCvOOPYiqJvM5HoBfJfNkcRFOVwwDSeqmdznw/CD/jLy+nNW3wd9vDITFktIviWFgmnQZWHUO1LvBOF8XaJs7ewsuzV5R82ZhZtjAMvSMWkJok9q8e0OyVX2+v7YZNiOtcK2r8HV44tt/aoDDOn5lz9bzaV1i51LKK+3csWdABO3PKH5eNArbKjp/RV87+5I2FvNsYAiIVK86k9n+1My/UfxiRso4a2fS5fwY4CCGkKo4xv0jJjSocrVF7wMe6roIEZO5b+uA7/hn9xcJR3Nt79Kz7pTt4wr0C4DyfYhpgYY2DtMGaceKNpKoleEI7qGnrviZIOcdOQnSfxa/kfMGuYdT4bSE8jNq40hxvaEi0aUT7j+a2irkgy7pVHYNd+2K/ZXX1jGoCVvAW2ofYPbb6mnTxnLKR+FBFuUHTC38fw/Iy0A6w1dLFGZ/v2Z8vhwmxfCRREIs0wre+FlYibhKSBXd1FgkFezxqEdhsds+7NT4EUId83cYGP39pbAqpQC5zfV6jSLx+Ml9oNbrU0b5rpu5IXkGgdJcbueW7JnHqiaZBKWMCqpyBCmKz8X84HE0Hn842HVt0OXg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(316002)(41300700001)(6506007)(6512007)(53546011)(122000001)(38100700002)(186003)(31696002)(86362001)(6486002)(71200400001)(38070700005)(2616005)(83380400001)(66446008)(66476007)(66556008)(64756008)(66946007)(110136005)(36756003)(478600001)(91956017)(76116006)(8676002)(8936002)(5660300002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnY5WkU1K3RKeElCTUNOWGlEMmZSMU5pYVRMbWs1aHgyNVV5aW5rSEVPRkVw?=
 =?utf-8?B?UlFvcHViSGE0MTNEbHRHKzNJM1BkUjl6M0dRMFZkSENWVmV5NzlrOHV2U1Yr?=
 =?utf-8?B?UnBVeEIvUnlLUi8xTGx0aDRzR0lnVHlyaXlQY0Z2UElsYWcrTjVhWGVTQkZ0?=
 =?utf-8?B?bkNjc1d5b0ViQytKUEN5MlhwTUtQdUttRFhMOE40WWpiN24yVWpRcmx2U0Rl?=
 =?utf-8?B?a2NiUnpWYkpmZ09Mdlg5THVXZWNYSmJEVnJKSW5QTVB0Nm9zVWVSenpvK2o5?=
 =?utf-8?B?Z2VvVkR6clJ1a1A4Y2NHS21DVCthWHFZMDVHaDJ2ejNTcVJNZ2hlbjFNclZP?=
 =?utf-8?B?VmMvUjBtTHJ3OWkrcmUwR3V5VG5oOEJqYWJqUWtYNG1LTWZOLzBLamtzVHBk?=
 =?utf-8?B?QVRzNVVMcUdrTXVtaDRhRVdwSm0zM200OE1TaDhCY3k5QnRPSFJPTHJSUmtD?=
 =?utf-8?B?ZkpoRzlBbVRNMW04cldEZ1lKb1RRdXEwSWYybm5JOTB6QndNM2d0ZTcvYjQ0?=
 =?utf-8?B?aHR5enJ0a0lPSzErTXN3RDM4REdsMzhBNmFOamZDeHZtM01IaVozM2V2SUU4?=
 =?utf-8?B?WGpGOGs5Tk53dmNVdVRIWExCc1dMZXYveDBiRklKNWxCWEVxeVQxMXFOQ0tx?=
 =?utf-8?B?Uk5xVUJ6WkNFWGMyZXFKWHhvUG1ndlc5eDc5UmphWHgraEFDS3J4REFpc1o4?=
 =?utf-8?B?djdYeTRnR2h1bEJtTmVJS0o4YUIwSDlSTjhBZjRGSWNubFplTnFpbmZsNkk0?=
 =?utf-8?B?cUhyNFZKVjBKaUZRSWtjNThsRjc4ZjhvVCtwYkJFZWdrZEcrRnZZMmZoWnZx?=
 =?utf-8?B?UTRXUXBlUHEvVzRaVlZVdkVTWTlKempkNlJCK0U3L21JbVR3bDJOVmRKNkNp?=
 =?utf-8?B?YnFiNGh0aWNiK3hKRnBsQzRjejQ5Z2k4ejFRaHBsNHM4YWt1Uys5ZUMrSHVQ?=
 =?utf-8?B?cHpyL21KM3NYSUlYM0hhMVFWRHRWeVhYWjloeDF1SHc0QW9OQ1NsRVovVy9X?=
 =?utf-8?B?OG1qbVVXdnNTNlFhc0VhSHRsWnoxK2dYT1l0cCtDTHZDMUtjdEN1NEhoQk9x?=
 =?utf-8?B?aVRjMUVaSS94YzR2V0hPZWExenZBVk9XWnViYWRqSkV2SXBNVlFteWhTV2o0?=
 =?utf-8?B?cEptQTRZbFpzYXI5VTJ3eHI1QUV6OEw2RllSZ1YrZmZPVjYvbGozTWdyd0xO?=
 =?utf-8?B?UmlWYnlySUxDenkwd2pYelNBT3hwZS9PeWdNYXJ6d2g2VFlkaVdlaTZNdWhI?=
 =?utf-8?B?SUhTaU1yU0dkSXpqUUZieWp5K0l0SzJZZEdRdGR6L1dGOEc2WGhaVjVNR1Yx?=
 =?utf-8?B?V3JKcVcwcjBrblZEL01jdWtYcU1rNjk2bVowV3hKQk1kT3RLMEw2bE02RlFF?=
 =?utf-8?B?Q1lCSmNoTmtldFlYUndLNW5CK3dFSDBPK2lObFh3NmpUOVhidk1VaGdiYW0w?=
 =?utf-8?B?bnZyK05aZ3JMYVV0THk0V2dpNlJxWDhBdFRXQzE2QXZzRE41OGtva3BjS3Qx?=
 =?utf-8?B?WFJwaU5OcGkwZmdIQzVwMXNuaklyNXFwSzJXbjNvVUVvek9MWldUWmtuWFps?=
 =?utf-8?B?Qlg0TTIwZ2tYcXQwNUYzRXJGZ1BlU09lQzBjWFk0T0k4b0w2WjU1L05kNUNi?=
 =?utf-8?B?OUVXT2svS1I2K3RMaDkxc0h5bnN4eFZxTFRGVjU3ekZrcE5Bc2tGVmdmK3Vz?=
 =?utf-8?B?S3pjd2lVZktrUEMrWjN6a256WXdSZHM4SGNOd0JHd3NnVlNuR1dqcWpVd3VJ?=
 =?utf-8?B?ZnhWR091VkoyTFU3SmZzYWh5TXY3S0xUS2s4MXE5TEthL3pJVUh0eGJ6Yi84?=
 =?utf-8?B?TVN6QUZNVXQ3Z2xSK3Nhc2ZsWnd5bE1iZkZwa2tuOStmL25BdXZCMFdXblFn?=
 =?utf-8?B?UXhIb00xSEdWSHFlRDNyMnp6NCtNM09YV29zcVY3eU9IdzZJcm1uNmk1Ym8z?=
 =?utf-8?B?VVliTzBDN1ZRWWlpRndYQUw4a2lwQ3RpeG5ueFpXKzNScEhvcTFQNWRrd3hw?=
 =?utf-8?B?TGZuS1VJMXNpMTJ1Q01RTTEybElRMTZSbFZyaDJ5YWUrUmk2d24xR3hCVWZi?=
 =?utf-8?B?Qzd1a0VzbFk5dlJGK2FNZTZwZ3BOVWxnYnhZcE1Za2s4dXBNRXJkc2o1ZkJT?=
 =?utf-8?B?MWlWMEZyT0N1MWRXNjlRYVhmaCtlMWRaSUZyZGNiNGs1bDM3Y3pPL0FCQzJU?=
 =?utf-8?Q?U67ThxnQORauXucSG/Mh0VtaW6/H2yDUSuIQmi5poVtY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEEADA6D4708414BA490064EC172F07E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a560b8c5-29ee-412c-3f5d-08db3b18863a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 05:41:11.9732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7IFEeOHcSUh6vUqF3YDH9nNWGsWxBM9xm8glAnV+EI7BSLCZ9r/RRCNt3mnZTOjc7Zy45vYZSeJbxeNK+2dPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xMS8yMyAyMjoyMSwgSmlueW91bmcgQ0hPSSB3cm90ZToNCj4gVGhpcyBwcm92aWRlcyBh
IG5pY2Ugc2hvcnRjdXQgdG8gZ2V0IHRoZSBzaXplIG9mIHRoZSBpbnRlZ3JpdHkgZGF0YQ0KPiBm
b3IgdGhlIGRyaXZlciBsaWtlIE5WTWUgdGhhdCBvbmx5IHN1cHBvcnQgYSBzaW5nbGUgaW50ZWdy
aXR5IHNlZ21lbnQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEppbnlvdW5nIENob2kgPGoteW91bmcu
Y2hvaUBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9saW51eC9ibGstaW50ZWdyaXR5
LmggfCA3ICsrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+DQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsay1pbnRlZ3JpdHkuaCBiL2luY2x1ZGUvbGlu
dXgvYmxrLWludGVncml0eS5oDQo+IGluZGV4IDM3OGIyNDU5ZWZlMi4uYWJmMTkyM2Y0YWE1IDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Jsay1pbnRlZ3JpdHkuaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L2Jsay1pbnRlZ3JpdHkuaA0KPiBAQCAtMTE0LDYgKzExNCwxMyBAQCBzdGF0aWMg
aW5saW5lIHN0cnVjdCBiaW9fdmVjICpycV9pbnRlZ3JpdHlfdmVjKHN0cnVjdCByZXF1ZXN0ICpy
cSkNCj4gICAJCXJldHVybiBOVUxMOw0KPiAgIAlyZXR1cm4gcnEtPmJpby0+YmlfaW50ZWdyaXR5
LT5iaXBfdmVjOw0KPiAgIH0NCj4gKw0KPiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgcnFf
aW50ZWdyaXR5X3BheWxvYWRfc2l6ZShzdHJ1Y3QgcmVxdWVzdCAqcnEpDQo+ICt7DQo+ICsJaWYg
KFdBUk5fT05fT05DRShxdWV1ZV9tYXhfaW50ZWdyaXR5X3NlZ21lbnRzKHJxLT5xKSA+IDEpKQ0K
PiArCQlyZXR1cm4gMDsNCj4gKwlyZXR1cm4gcnEtPmJpby0+YmlfaW50ZWdyaXR5LT5iaXBfaXRl
ci5iaV9zaXplOw0KPiArfQ0KPiAgICNlbHNlIC8qIENPTkZJR19CTEtfREVWX0lOVEVHUklUWSAq
Lw0KPiAgIHN0YXRpYyBpbmxpbmUgaW50IGJsa19ycV9jb3VudF9pbnRlZ3JpdHlfc2coc3RydWN0
IHJlcXVlc3RfcXVldWUgKnEsDQo+ICAgCQkJCQkgICAgc3RydWN0IGJpbyAqYikNCg0KZnJvbSB0
aGUgY29tbWVudHMgdGhhdCBJIGdvdCBpbiB0aGUgcGFzdCwgeW91IHNob3VsZCBvbmx5IGJlIGFk
ZGluZw0KYSBoZWxwZXIgaW4gdGhlIHBhdGNoIHRoYXQgaXMgYWN0dWFsbHkgdXNpbmcgaXQuDQoN
Ci1jaw0KDQoNCg==
