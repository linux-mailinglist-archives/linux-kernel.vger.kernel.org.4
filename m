Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03D163E57F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiK3Xc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiK3Xcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:32:36 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C9C862F7;
        Wed, 30 Nov 2022 15:29:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ84dWe/f5TxidKGNp+oFPl7UwOfecrIl+dV+9W1PcVlewriyBYh/boTHk6BTr5WoSI5utxKiUNU0mr9gN1tXl9pG5a9oI2VJn2d6FrVU5tO6ZjolP5YRnKn5vwdq6Dg6PFU/0I4HCraTJl7wm07J7SA4RvAxHNXtb92cmY246rgAFLDp45DD5be1CIK+CNJjs5aWQTK/8PdYjye8dlwMydacBqBkbweOYWez/AMqmt4zVg8Z2uKoPZxlz0kvF/0yXR8Ktz+HaGfzPc55p0+px+CPdffdQ59jq/jlDtOjKH96edeXEojZeygokyF2LBDfwX2jSzaiCQIsxQyGhITow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z47RPPGnxzd+D5ETlytqTtR2XTJaI17SBE9wex6SFug=;
 b=RBt1YCxzWW/AS0VkQO5caipihVeiFG3wc/4ew3SLb5zTVaa4rQNtiIjp9lr+0ZonKbgzkfVqhnUJZBKaD8JmRiaxMv0e6vMVMw+dQXHVozr7Mn+nzkEvqhEfjZb0ymol8dCdR0b6opRDC8LngsiaLqqRBIfTc8SeAkzmUB1V9i1efGt1MmpDAEyiv/dofY5QOq22tkaw6O9cLJWxzSPjIwIU6k7qkaMqb8pA+SoRAgRGgtpNp8ujzzo4sGTh2Ngtv+g1ao4aeAmAtWKIJSC6ijcbJWRRZA7zHlQwRvmJzY5ce95M1wJkBUZ/umZyIT54EqBjeBD19UhvoJTBhJqoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z47RPPGnxzd+D5ETlytqTtR2XTJaI17SBE9wex6SFug=;
 b=d8H5El+d+T6iCCCinlpnNb3gZMeIxTSOJhKxXkcyxG9bFE/P/IL6BPv/M25hLF2YIYEaxOp5bRvUlcmxgCWjCDcWGYyoJ9PwczHwf9JoP4qGVBdiCgL90OJ0GAOf5XEiE+LGGu/p1jt9eTUhE1pV+IATBZZRkxz+KVFlX6O1AL3n2VSVbBQzbba9Qwumal5WrJO2F3EKGovyZRaSIpUXeS8BWOCtMnwmvapxFcf8m1sLTEUuCYKvV2n1jJPnyW63Fd9Im31agrBIc/e9f3QvycGR95ietZvAy6W7UBwfqH4vU1SyOwkIVoRjP6HyixDyXS0utrbdXb6J8Jz3tO7luQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 23:29:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 23:29:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [PATCH V4 1/8] null_blk: allow REQ_OP_WRITE_ZEROES
Thread-Topic: [PATCH V4 1/8] null_blk: allow REQ_OP_WRITE_ZEROES
Thread-Index: AQHZBEpTLGKBSAeKCE6T0fXerJPm765XGscAgAEDsAA=
Date:   Wed, 30 Nov 2022 23:29:00 +0000
Message-ID: <bebfa1a2-1bf6-b515-00fb-4a7be7eeeae5@nvidia.com>
References: <20221129232813.37968-1-kch@nvidia.com>
 <20221129232813.37968-2-kch@nvidia.com>
 <20221130075932.nfbxiixykfpxrweh@shindev>
In-Reply-To: <20221130075932.nfbxiixykfpxrweh@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6288:EE_
x-ms-office365-filtering-correlation-id: 39652f14-0751-4d57-71af-08dad32aa914
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Tr+EXRMHHxFG5VqKhR4Lh4EmfwaDWtRqNA5B/DKaujkEqWIK+oWrObNItiyfBRatxn5m4v9iP6yEcF5BjYB6hBZMo4530eeXeDV1mqj4uAAZi6gJr7Frr6jp7XYuuWURI+v0SVzH8AboB9/9NEnhD1e4SCTnaSssyMKWSa5PyKuOkxwP5wrnVo97o5XPProM/Dc3U5dH1DiiQOlv2r+YDrT41uEVtKG9yC7zEBwKO9DL626leUfUQqkGMZVNngscRdJRVgptkhWD/muEU2n4j+ggxr3Ep2IojZYVqRSPxv219v2c7rrD5QTPENUKG6A0+BQcc1Eaem9B8nIVhPYnEyMhb5ZanRQKCuct/FxF/tO2Z0lMJEWp0CSvXyS1piH/+DLuZUhoprFCq7ecRRsT7kVFDwQFtlMfghxW6AR1ZD3XIKYBYg2RoWxyLj+9cWxEJ9uInwE+QL1+lDMfUa8WC/hZNVQpC08CtlCwW6Kahhp36wJ/L0yOj6Qpx8T7PCHiHKTSavffNQL4cdymip3TpACTiyEGqUjH3/afsqlsL81KnbI3I8CkzGzdvP9fl4VzRFYxEXX/UIV/9BKW8M4y0t46WmlumTCRUl2ih78RUYEx+XSz0Apsc5r9VRvPdxEh2OuGV4J6AYXzi+Fz/3aUeQ8NnDAFFYfUQvW9FDCJPWVVSqxwXvkNflrDJK/9Chv2X6Dkfmjwww7NYnGiMa0wXwr2xhIxJ3n6la/i+eSQ3+IBSS1DHq+ruVEGK0XZAXAl3EQVq7OZ5U39T4ap4z3XA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(38070700005)(36756003)(86362001)(31696002)(54906003)(316002)(6486002)(110136005)(71200400001)(122000001)(91956017)(66476007)(41300700001)(64756008)(8676002)(66946007)(5660300002)(4326008)(76116006)(478600001)(66556008)(2906002)(8936002)(66446008)(38100700002)(6512007)(6506007)(186003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFdDamdEaXE4dGlNZTVjTTNoYXRVeGhtYUpHb2hRNkJOY1FwNlJYK3V4RG1Z?=
 =?utf-8?B?bEE1aDdjNlhZQWdyYy9hdERKL2twVEZhSlVIUGMzZEFwbDQ2dzFyR09qZnl6?=
 =?utf-8?B?TkQ2eG9yVEN1amc4OGhwS3JFUVF4aitxdStkQityR3hkV1ZtdVl2KzVyem9S?=
 =?utf-8?B?bmgrWHd2cmltekVsQVFlM3IzVnRLOVdpSDA2RjQ2Yk5RQTJvNE0vZitQMi9M?=
 =?utf-8?B?eXU5bnJIRHFmaGRSY0kwSzhUbGlDU2FCWERHd3NyRjFtNW94TE1Lb240WU9R?=
 =?utf-8?B?MkxnZTZDUU0rSXBqNFRjOVhmaU5JTVpYL0REdmVEYVJMSi95WkxvQTAvcHRJ?=
 =?utf-8?B?YlplYUNrMENqWFRnbiszMS8vbEthZUZkZ0FBMmhJMkg1K2hFNG1RQnQvdWNM?=
 =?utf-8?B?c25SZDd1NjBiZVJzRmRkL3NzRnFBNXErT21tay9hOXpWMWRWQ1hlUDhUZGo0?=
 =?utf-8?B?TWxiNVFBWUszM1UvYjBSUmFtV001NUVhWUR3bWZXSmd0MHFWbVV3NHdqR2NG?=
 =?utf-8?B?K0VqVE0zSi94SnJXczVQK2pmL1lWL2pqR0FpWlpNbFpTU2ZZcVlRZVpSQlRU?=
 =?utf-8?B?NUtOYk55K1JZemY5aGsxZ0xHZUZTS1dNRmE4Yk5sUGV6aG0rZFVESG9DT2Q5?=
 =?utf-8?B?Q1EreGFvRTM2MTA0eTJKMHp3SWlHaW1qL1p6djcwSDczNHEvOFdKbWp4Sko5?=
 =?utf-8?B?ZVdnWUpvWGptd1ZXRC9oL1c0aWRQZ2ZZdHdnalZsWkNpZlZVK1JTWXZWSXR6?=
 =?utf-8?B?QStTOFlvVy9qRktOSCt0dFYrOEZjdVY2QVJ1a1oweGRjZDk3ZFA2MGZKTUlM?=
 =?utf-8?B?YSs2KzNuKzljeXEvbVVDQ0o3c0c0S1h5U0ZzcWhZbzhhYS8wcXpYZ0pNVHZ5?=
 =?utf-8?B?QWhTQ2hUOXR6SlRPS0srdTNuWWxFVkhPQURramZINWlHQXNlVE1VbVhFSVZJ?=
 =?utf-8?B?cXpWWXBCSmlHWnZ6SUMrUlN5R1l3d1N6aEkyYk5zcHNKcElhUWwyZlhvM1lr?=
 =?utf-8?B?RERYeU50M1BkVG4zZmU0QVdHWFljM1FxSEVkQTFVdGRjUFM1SjRScUxrOGVO?=
 =?utf-8?B?MkN0WmJXVUNQMFd1SFNnOEVlK1gzK2hTTFdYYXFsTC9qUlVGczVwMVdqWW1h?=
 =?utf-8?B?d2hCczJidnpsTVoxMkNjWFMySHhWWnhZWXRwMzBaRDJWWFFaWW54L3h3dzhm?=
 =?utf-8?B?V2VYYUwybllKdFpkai8rT0QyTHp5MWc1RnNWbXZqT3l6SC9UWTEzcE4rYkFy?=
 =?utf-8?B?dEgwZkJWdVhPaFdpOUwyWEZIN2pBRTFaYTVzRGdwcndvLzBrMjNYRkVFZGFI?=
 =?utf-8?B?SklaaDRRbHU4a0lPMm11TnRUaVZFcEdFRkpVNldtTllGQ0l4QStySHgrMmlm?=
 =?utf-8?B?d1kvMkFDbC8yTC9OTzNWejRMVHl2WFFIdWpqMnNQa01mSGRRTG5aeTRTRXp3?=
 =?utf-8?B?bWxCRTlEL1ZkRzdqN0xNWk40NWdQbkJDQlZiaS94aTVTYjlOaTFodDlvMTF6?=
 =?utf-8?B?STBZcjZQZDdSYnZIcjBzelVyUXFqK0p3WDg4Mjh6c1cxaGwxV3BwdlJDVDAx?=
 =?utf-8?B?aTZSMjVTNHFNNW5vNm94NEtUTkxUWE9kU0pCQ1lBdHkzanBSSzdmanNYWmRu?=
 =?utf-8?B?Zi8zclp5QXFXSndmcllzNkh1d3lRWFJjRkFENkgzeGFmZDRMMUs2ci9MSmR0?=
 =?utf-8?B?a3gzM0llZkNLRVRvcTZQaWJGNDV3aDZyRnpsS1ozelA3QUY2Q0p2dytnRkpY?=
 =?utf-8?B?cTFJMFE0ZU1oZzhaY3RYVXE5YjlldlVDM2NMdDU0V2tTbmZPNlZWZ1FZWS9y?=
 =?utf-8?B?cmJBcC8rTjl2ZzRIRTY1ZlI1SU0zWXBGNUJhM0hVcy82cDh1dGVYdVg2dE5n?=
 =?utf-8?B?WHV4dXkxMm5xRERYTVlFV2hRMVlxOTh5N0tiQkdwd0wrWGpyd0x4d0hWT1FD?=
 =?utf-8?B?YU9RVkNMWkE4Y0didTBiem5PZnJ6NlF0SXJXeUxBNmFJbTRVcXRGVUpZbkZo?=
 =?utf-8?B?Q2ZXSlNQVWJjM3FkYWdGNkltb0NNcmM4VUhJMklXeVFXeHVPZnliV0MxdEhL?=
 =?utf-8?B?dVNtbEl0YTV6c2d0Vm8vVzFEd2VMQmtESThHUkovb1VpWG93Q0c5cGRuWkty?=
 =?utf-8?B?OEpFM29iejBlNTNkd2o5UXhJcVdiU1FybWEydmF6Z0VjbkN1ZUpwaVhxeDQ4?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A091E02DAD4BF74DBDFD5185BAEE0886@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39652f14-0751-4d57-71af-08dad32aa914
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 23:29:00.4654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuAOrpWEtm80vWekpoHpE1DydUrz+OUvbmrTE9ZuqWAzCVAswm7RVJUKneq2WrUcmGrhhRbhVE85IN57wJcQXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4g
DQo+IFRoaXMgbW90aXZhdGlvbiBzb3VuZHMgZ29vZC4gSSB0cmllZCB0aGlzIHBhdGNoLiBXaXRo
IGEgcXVpY2sgdGVzdCBpdCBsb29rcw0KPiB3b3JraW5nIGdvb2QgZm9yIG1lLiBQbGVhc2UgZmlu
ZCBtaW5vciBjb21tZW50cyBpbiBsaW5lLg0KPiANCj4gWy4uLl0NCj4gDQo+PiArc3RhdGljIHZv
aWQgbnVsbF96ZXJvX3NlY3RvcihzdHJ1Y3QgbnVsbGJfZGV2aWNlICpkLCBzZWN0b3JfdCBzZWN0
LA0KPj4gKwkJCSAgICAgc2VjdG9yX3QgbnJfc2VjdHMsIGJvb2wgY2FjaGUpDQo+PiArew0KPj4g
KwlzdHJ1Y3QgcmFkaXhfdHJlZV9yb290ICpyb290ID0gY2FjaGUgPyAmZC0+Y2FjaGUgOiAmZC0+
ZGF0YTsNCj4+ICsJc3RydWN0IG51bGxiX3BhZ2UgKnRfcGFnZTsNCj4+ICsJdW5zaWduZWQgaW50
IG9mZnNldDsNCj4+ICsJdm9pZCAqZGVzdDsNCj4+ICsNCj4+ICsJdF9wYWdlID0gcmFkaXhfdHJl
ZV9sb29rdXAocm9vdCwgc2VjdCA+PiBQQUdFX1NFQ1RPUlNfU0hJRlQpOw0KPj4gKwlpZiAoIXRf
cGFnZSkNCj4+ICsJCXJldHVybjsNCj4+ICsNCj4+ICsJb2Zmc2V0ID0gKHNlY3QgJiBTRUNUT1Jf
TUFTSykgPDwgU0VDVE9SX1NISUZUOw0KPj4gKwlkZXN0ID0ga21hcF9hdG9taWModF9wYWdlLT5w
YWdlKTsNCj4+ICsJbWVtc2V0KGRlc3QgKyBvZmZzZXQsIDAsIFNFQ1RPUl9TSVpFICogbnJfc2Vj
dHMpOw0KPj4gKwlrdW5tYXBfYXRvbWljKGRlc3QpOw0KPj4gK30NCj4gDQo+IERpZCB5b3UgY29u
c2lkZXIgdG8gY2FsbCBudWxsX2xvb2t1cF9wYWdlKCkgZm9yIF9fbnVsbF9sb29rdXBfcGFnZSgp
IGZyb20NCj4gbnVsbF96ZXJvX3NlY3RvcigpPyBJdCBtYXkgc2ltcGxpZnkgdGhpcyBmdW5jdGlv
biBhIGJpdC4NCj4gDQoNCkkgZm91bmQgdGhpcyBjbGVhciBhbmQgZWFzeSB0aGFuIGdvaW5nIG92
ZXIgY2FsbCBjaGFpbiB3aGVuDQpkZWJ1Z2dpbmcuDQoNCj4+ICsNCj4+ICAgc3RhdGljIHN0cnVj
dCBudWxsYl9wYWdlICpudWxsX3JhZGl4X3RyZWVfaW5zZXJ0KHN0cnVjdCBudWxsYiAqbnVsbGIs
IHU2NCBpZHgsDQoNClsuLi5dDQoNCj4+ICAgDQo+PiArc3RhdGljIHZvaWQgbnVsbF9jb25maWdf
d3JpdGVfemVyb2VzKHN0cnVjdCBudWxsYiAqbnVsbGIpDQo+PiArew0KPj4gKwlpZiAoIW51bGxi
LT5kZXYtPndyaXRlX3plcm9lcykNCj4+ICsJCXJldHVybjsNCj4+ICsJYmxrX3F1ZXVlX21heF93
cml0ZV96ZXJvZXNfc2VjdG9ycyhudWxsYi0+cSwgVUlOVF9NQVggPj4gOSk7DQo+IA0KPiBKdXN0
IGNvbW1lbnQ6IHRoaXMgdmFsdWUgVUlOVF9NQVggPj4gOSBzb3VuZHMgYSBiaXQgd2VpcmQsIGJ1
dCBwcm9iYWJseSBvay4gVGhpcw0KPiB2YWx1ZSB3YXMgaW50cm9kdWNlZCBieSBjb21taXQgMzA2
ZWI2YjRhZDRmICgibnVsbGI6IHN1cHBvcnQgZGlzY2FyZCIpIHRvIGNhbGwNCj4gYmxrX3F1ZXVl
X21heF9kaXNjYXJkX3NlY3RvcnMoKS4gSSBndWVzcyB5b3UgY2hvc2UgdGhlIHNhbWUgdmFsdWUg
Zm9yIHdyaXRlDQo+IHplcm9lcy4NCj4gDQoNClllcyBpbmRlZWQsIHBseiBoYXZlIGEgbG9vayBl
bmQgcGF0Y2hlcyB0byBhbGxvdyB1c2VyIHRvIHNldCB0aGlzIHZhbHVlLg0KDQotY2sNCg0K
