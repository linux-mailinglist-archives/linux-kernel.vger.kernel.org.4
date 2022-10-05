Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10D15F59EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJESdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJESdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:33:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF6780BD3;
        Wed,  5 Oct 2022 11:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWz3Vnks0yL2Hl15X/bz8vefY9lfxxRmBlZBgrc2D+qCuhX0ZazfyYOR4oAjs70pMl4QMbyJ7Y3hKqeVYFTtMaFTpoHoidIWrhEUArAcochmaKvILgz8LMc9zjtWHrdeOZE9CWcaPgFBWxCpaUlbmFZcKLbeskrjsMqrRD7yipyMSWsF1aO+b1sDl9xF2uazcN5TSLgNU0e1kWQ6f6z1t0IGQ65OGP8IJ7VyasqvMwk6o0ukaE0E5jxDOrcDezpwyUAKlgdnhd+s7Abz305t2LWkJNm+wJdvTq6KNlJin5I3JJNLywyKi6fp4KRMAcWebjduKQCasHW0Rc3pQVTsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLRPSWjnnNhaKZgHgaRA/ixBNnEQxFfgi2/Mb1gv7I8=;
 b=Q3BY6wx3R/PdB2NqjPiDsYOzMk90TGXZgNZ015G1OofgPeOIgiRnqEgLKHkJ0NyRQ5KWYLloc4COHE43rH2uxHJIkbOdo2DM6tT0GSL9gGOmR+hp7RioHF5fGPY64r56DiMBVXqotLlXZkMJLS9aV+DWv3dpBQtsmwHryEO9lYoyoMNHplBKNue8dxMjm8qix2xmBtSQtMG8318fdlYexjYuTZJwlAnIt415SRSpnXJe9wM9KQiUp6SrJN/KfZLLU3oQr054vIpcMvuwG5oM0yDZYMTGsLTt61mNYKnRvnfosoBZMu2OBU8AEXbqYQQBIvROkLiReXebuuL2IA6J5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLRPSWjnnNhaKZgHgaRA/ixBNnEQxFfgi2/Mb1gv7I8=;
 b=Z7v9K65cfVrkQIdrFgI5LzJe4mbkd2O1MedNBC3yFBGd8eyVE7yhnhSVXxYs7dZU1kVPv+gsf8LZ4nU6GepFeIjdfLcp5EDd3BrMVI613lntl+CbEv4YUdlI4GZIY+lkx8WO7L48mjFv/sPPywFp7jzUJz/w9NdnTriMW/bAqO68t6UEYgrLxKpcYz6zXNLOv9TsXr7vmieTJtCPVvkNtQFnmk9WlTpr91Lg8VkjKpP5l1rzjnOI+wfDfCHaeIiMx8x87AC50o8LG4Bx1HSBnHJFFpAZllTvjpLllV67kEkyayJpq9AFrJIZsi63j/TbLB6ekWMhVu8Z4HirPTB8RA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 18:33:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 18:33:38 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/6] null_blk: allow write zeores on non-membacked
Thread-Topic: [PATCH 1/6] null_blk: allow write zeores on non-membacked
Thread-Index: AQHY2Gj9Q2YMA7ydR06f/3Ds7ZY+vq3/PFkAgAAIQoCAANyLAA==
Date:   Wed, 5 Oct 2022 18:33:38 +0000
Message-ID: <41075ae7-6e01-540f-6a68-eac2b9390093@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-2-kch@nvidia.com>
 <66698df8-74ca-e802-2250-04aecafa1106@opensource.wdc.com>
 <2553fcde-43b0-04c0-5f62-9a2c1f9430a1@nvidia.com>
In-Reply-To: <2553fcde-43b0-04c0-5f62-9a2c1f9430a1@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4329:EE_
x-ms-office365-filtering-correlation-id: 76371b2c-ccba-4d83-964a-08daa7001ee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9y4dIpQwdB1lBQXHzwgfLNkldaRgFq6akkfqqW2YJqQR9Z1Ud2QO4/OWLkDrv8CD2LY3eidiiPEFy5ojjVzrrCARkgDzp3XU2pJAQ+zaunRbpHOnaVRnsyfFI61udxQmFeDgsizfwDWDk90W2cPTUr3QXNx8nVN5UagOlXDd6KqTFOOmJwWLwEejzJzz771aq2tKLz1lOMOGayM80vI/ipkywSeC/8TUpe7jD89mJ1ETs31GHAqjrpI//ghJlNW9ky2H/jLP+jj2o+WwLqHwUuSeVhecs+GT0mSc/g+lrb1DGr9w2M4u5bSykui0UmpvXIxDUZns430zVaQCyUgSOVZhgO5hKDdg+BEHXlaUuDv4al7adedE8gFa7WPklymh5Bh2IBRxzqG8Jdp7qbin5lbngcmpDF3vlkhN6t0Afg5sMuE4GV2bwdVL+hIl1UaUSOwBMng9s78F7rDtkUsRw/j95RZYNnrubfmGM1SfLaKFf/fNykZGclfeyjWv171lcAMce2e3dBg9gRMNAF3VTr4H7W06MT8P6q00iogMXab1RyZ5yNraJjaQQmZKMt89KyjqwgLLhp6fTwvbkTyLWA5BmmefmSrI0r6+45nUv7fxI09NHE/uNYapVdPlUMagwWvwzV3zPgSErFoEtsWyqOF5DFodRFJdsG17SriGmkH2YpXe1qF98+6Y2L+oZCSCKU3m4U2QWOUSXz2/a+LNCuM0B5WCAcz57MhBJizvDSuVUPsORc6myeRQjNRszG1AAPh56/iK5txnn4FRe1iUeAOkvBs5PqdPF6S35LPJ79+5v8jrlNn5NLyk4FJySDqUJRTm1mElnjoS0JteaPub1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(8676002)(66556008)(66446008)(64756008)(4326008)(66476007)(66946007)(91956017)(76116006)(316002)(110136005)(54906003)(186003)(86362001)(8936002)(478600001)(6486002)(5660300002)(38070700005)(71200400001)(7416002)(31696002)(41300700001)(38100700002)(2616005)(2906002)(122000001)(6512007)(31686004)(36756003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mkt4QmRXeGJ5TlZtMkR6ejgyNHJHQlZ3NXRCa0QyZVdBRnZkU054ZEFpSVBH?=
 =?utf-8?B?cHd5ZkVNQVpRU2tDRlQweElCTlJqWUxzUk5zK3pHa0hEa2YzQmd3MGtnQ01G?=
 =?utf-8?B?WVJTcXdhbktuL3c3dldyMjNKMS9KTEk4YitsTFhjZXhTZXZGSWFxTUhhUnlX?=
 =?utf-8?B?eklIRFQ5cWx2a1R4cCtkMUs1U1VwNGpGYkhMU2lYSHhuQ0ttdkdTUnRCcXRF?=
 =?utf-8?B?NnVOMm9vRXZNRnpQajVIcWVsS1pNOWpHWGpqSmNkdnpwREFGT0NDSTE3MkFu?=
 =?utf-8?B?VDZ0NGhRYTlqVkxtcFpUNFp2SVhLbStyQTN1bGYvMHpZYm5KQk5YQ2hNSWlj?=
 =?utf-8?B?ZmhOSjlZT1d3YWZ6VTFzV0RTbFpyTVZqWGhDWTB4M1ZZcmZWQys2K1phMWgx?=
 =?utf-8?B?NGJFcFNDVGg4M3Y0dGgxK0pMM09mWkloTjZNQmgrMXpQdkhBWEx5c3VaVVNE?=
 =?utf-8?B?VTJld0VZYXFpVlVPaWhqZFZTV3hOSkxWOFkrNEdZNGRKQzJkRlpSelBTYTUx?=
 =?utf-8?B?a3p6ank3emhZejZ1a1dwOU9uRVRKN1Mvc2Q4ajFDYzJwYUQwa2RCUEVEajBG?=
 =?utf-8?B?d0xZT0lZMzlCY1I4TXU4dW5jWFJrdW9VMi9TR2htU1FVVnFHQld3QkhXN1Fx?=
 =?utf-8?B?L245Mk9RL29nSUMwblU0TktSU3VzY3VuTmpSWnFKaTk5T3RwWHJOZFhwTDR5?=
 =?utf-8?B?SHZzdm1mZ2VCbUpJRUxqL0R6UWtNbHBjT0FlZ3hFdkkyYnBWbFlIK2pucGZB?=
 =?utf-8?B?eEgvNDlKUjNsRy9VNmswWEwxUzFNYm5zT3BoSUdOdTdXZHRoMDBrSjMyN0ZE?=
 =?utf-8?B?dUpOSUR3L2dYeXllZVdKeDdnbFhscXloZmVsMmdvM2xsLy9CU2pyTTc0eUlZ?=
 =?utf-8?B?TG56QjVnV0c2RXNyMmVyUXJUQ2JQSjNuczJXY1l6TldVRUo5WHljRlNvR0sy?=
 =?utf-8?B?SFBLWXllR1FST053RmpuY0VVUVAwQ3VMT0hKKzBxKzJid0JjSW9neGlzUGw2?=
 =?utf-8?B?bEhOb0t3QUdDZGVXM05YUFdzaVBoSk9heXpramwzYjNEaytLMWRxTmJ2azNX?=
 =?utf-8?B?eWVNRklLSS94Z0RXL3FLU2lOQUIrbnBJODJ2NkhpRFFkaXJlczllZ3BXV0ts?=
 =?utf-8?B?VUVZY1N0NCtQdnM3YU9HWHU3SGRrOUI3V0RYR1hXN1RleTZHcWlVUGw5WFlL?=
 =?utf-8?B?cThvOERjUFNIOEV6bzFobGFqYVBxYmVaUlJLQ2s1c2pxYmdBb1ZucU1PWFNv?=
 =?utf-8?B?bXQ1QnVHTXVXdElVclRYNStTVGhnditLTzljRy8rYnJQbzhaNjJqMEpSV1NW?=
 =?utf-8?B?TExKNDduMTFUNWJCUGEzV3hDRFcvcnMxTlZyNzkxUmtEeWJkUzBXNkc2bVFR?=
 =?utf-8?B?dlNRd3lCS1BmdDNjYzVUOUJjYkZ3OFU2bEhmNnQyeHl3UUN0THFLd2tTZDc2?=
 =?utf-8?B?blBISUNnbXc3b3U0WkxPVnB1RU5WUkYrN05tcGFiaGlTbjRSU2cvdC9VdTM1?=
 =?utf-8?B?TUJVdGNhMDZZNkNDQThGVlEyeE9zTUpTbjE5a2VUMzYydUdFWDZBMGZldEVx?=
 =?utf-8?B?ZWFyYzVaU09CMnFtNWFmN1c5Tkl2TEMwV1lJV3RNc3hxYnFaeHZqV3RTRDF4?=
 =?utf-8?B?LzdkYy9FS3QwUTcrbHU3RzJiL3lvOWowRzdtTDVYTENlbjE2dFRxbkE5d0FC?=
 =?utf-8?B?UHA3bk5DWmFMZE5yYTFoamIyNEw1aWNoTm5aUm01dUVaRGFkdXRsN3F1eTRm?=
 =?utf-8?B?R2Exb3h6RlJHbTdPR29lK1JzenhSUnhYR0lUM0F0aXBWMHp0Y0JxVmtOT1A0?=
 =?utf-8?B?UEZGd2dkRHk5cjdBNXpCTW4yWVBVZCsvQ0U2T3RxalNLbGhVcWZFcy9IemNp?=
 =?utf-8?B?MmN3QWtPb0llc05BdHRwOWZ4QVZCZUF1VDdKWEJ4Y1Z2eGNxbUhpVmZTUVpn?=
 =?utf-8?B?Zk9RS0pZdXZJSk1LKzM2VTN5R2EwcXRKTkV0cllFMVB2ZXFLY0F5R2ZUYkhK?=
 =?utf-8?B?SkpoRTRIQVhxNHZRcUc2VUVmZkxsTG9tTE4rWEFsNjNvOXc4VGYyOThSS1JO?=
 =?utf-8?B?M0dDaUV2eFYrN2NHM0NpV3FWbmhvekppSUVnRm1SQnVMbTVWSmREQitKK29s?=
 =?utf-8?B?Rnd0aUFtRW9vQWF6Tjh0MnZ0WndMYnZHU2VHZlBYVFFZMU1vbjdNK1NEdFpT?=
 =?utf-8?Q?LgmnyyPEY1zF/yA3hufezUS5tk5RfL8y/WTrdt6XYlxv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D6639360D80CA46B771C4A4CC45D75D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76371b2c-ccba-4d83-964a-08daa7001ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 18:33:38.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZN4GL7YVqVIbQuzCxgreoRi9JIU/kBGQuPqZCJiKPYbGgLPQmemufbgj67o6mnQ4fODGAnP+Yv2WPflRcYIXfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+ICtzdGF0aWMgYm9vbCBnX3dyaXRlX3plcm9lczsNCj4+PiArbW9kdWxlX3BhcmFtX25hbWVk
KHdyaXRlX3plcm9lcywgZ193cml0ZV96ZXJvZXMsIGJvb2wsIDA0NDQpOw0KPj4+ICtNT0RVTEVf
UEFSTV9ERVNDKHdyaXRlX3plcm9lcywgIlN1cHBvcnQgd3JpdGUtemVvcmVzIG9wZXJhdGlvbnMu
IERlZmF1bHQ6IGZhbHNlIik7DQo+Pg0KPj4gV2h5IG5vdCBtYWtlIHRoaXMgYSBudW1iZXIgb2Yg
c2VjdG9ycyByZXByZXNlbnRpbmcgdGhlIG1heGltdW0gc2l6ZSBvZiBhDQo+PiB3cml0ZSB6ZXJv
IGNvbW1hbmQgKGJsa19xdWV1ZV9tYXhfd3JpdGVfemVyb2VzX3NlY3RvcnMoKSkgPyBUaGF0IHdv
dWxkDQo+PiBhbGxvdyBleGVyY2lzaW5nIHNwbGl0IHdyaXRlIHplcm9zIEJJT3MuDQo+Pg0KPiAN
Cj4gSSBrZXB0IHRoZSBpbXBsZW1lbnRhdGlvbiBpZGVudGljYWwgdG8gdGhlIGdfZGlzY2FyZC4N
Cj4gDQo+IFBlcmhhcHMgaXQncyB0aW1lIHRvIGNoYW5nZSBpdCBzbyBSRVFfT1BfRElTQ0FSRCBh
bmQNCj4gUkVRX09QX1dSSVRFX1pFUk9FUyB3aWxsIGhhdmUgc2FtZSBpbXBsZW1lbnRhdGlvbi4N
Cj4gDQo+IEknbGwgYWRkIGEgZGlzY2FyZCBwYXRjaCB0byBtYXRjaCB5b3VyIHN1Z2dlc3RlZCB3
cml0ZS16ZXJvZXMNCj4gYmVoYXZpb3IuDQo+IA0KPiAtY2sNCj4gDQoNClJFUV9PUF9ESVNDQVJE
IGFuZCBSRVFfT1BfV1JJVEVfWkVPUkVTIG5lZWRzIHRvIGJlIGNvbnNpc3RlbnQNCndoZW4gaXQg
Y29tZXMgdG8gY29uZmlndXJhdGlvbiBpbnRlcmZhY2UuDQoNCkkgZGlkIHRoZSBjaGFuZ2UgeW91
IHN1Z2dlc3RlZCwgaXQgaXMgYnJlYWtpbmcgdGhlIGJhY2t3YXJkDQpjb21wYXRpYmlsaXR5IG9m
IGRpc2NhcmQgYW5kIGlmIHdlIGRvIGl0IG9ubHkgZm9yIHdyaXRlLXplcm9lcyBpdA0Kd2lsbCBi
ZSBpbmNvbnNpc3RlbnQgd2l0aCB0aGUgY3VycmVudCBnX2Rpc2NhcmQgYmVoYXZpb3IuDQoNCkxl
dCdzIGtlZXAgdGhlIG9yaWdpbmFsIGJlaGF2aW9yIGFuZCBub3QgYnJlYWsgdGhlIGJhY2t3YXJk
DQpjb21wYXRpYmlsaXR5ID8NCg0KLWNrDQoNCg==
