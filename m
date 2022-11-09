Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECF56222A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiKIDfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKIDfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:35:12 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDD21DDCA;
        Tue,  8 Nov 2022 19:35:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2K/zhe+RgsfiWI2pri3n6z3ar2x/yGRTPI4VwnDCnW3ryCXK+ysyVBSOCj7ABpSEfgdOvJepzitOqLdnhFzDg8k1Yd6NpQTTGM9QQj2q2pyovMF6xhW9LMo3IFiy+DdCozW1y9XU0Kn1561pkvZkKZr/5Y3DJybHOX/ov+5PiMyG82fTOddT3uCmOXC1DNSZETQ1viLzKw+3zcC5FrY3VHKASyssVnDUbtCaqtDokr99aZFgcRZtqudW+Za4uasaDAWpeEzAz9dQSgK0zliTKFSctZFWIRkvgKU1KMv0z5e1bk4ckVSWzm7tZA83R/aPnXl/FFXKiyk8hGb8qXeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF6nb5cmILokaiyJvm7Ln9lIBkMVNbpPU4wL5rIwDjY=;
 b=nCYlrL6rr/3BA91XCZOr5bMtwB8qEjqIa1TPHlEA31avk5tL9/CRqdYICoZO+PM5Zpy3JI6J/93BA9UEzDy8RB/CXOoiN5hF3CI4vBYT4lo3F6Um8/jeJDFmvUVkjc5IkN34AHGvMoy/mmYyQPxSCsWIwPHRWhcyMYnxVCTOSS70mMRcHmM92nKibd5jQzCdFw3ftQe+X8YQPwzk+rmybw79U8KwqNRjG935xJC+D+IyBFIPv1bvap9jVdszhs0LBTZA2cpbqJaRm67HrpaacvMfVo4cPXsyAOSNe56uSZkpx2mpCmbDas32krbsXBmbBYwC8MDiIahldhr3Er5ckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF6nb5cmILokaiyJvm7Ln9lIBkMVNbpPU4wL5rIwDjY=;
 b=ftdv8Ngn+XY8KMtRdqCDLVbuJRGHOnjKpycxjqV++MOBiR78hsWWWoq96x4kgvZ79LQDSQlWJt6V4PJR2OrTwdLVPS2SnoQaCzH8cAUHWfzWOGoB9+3PxLbj/WP5qs1bxqNovlimnCxV6L1NJgsKyvAb75WnRRlzrmK7KQxCXrNgRibfSa4cq1fMQHpxRjh0Dn77NLcQebyoTvxdWPmn2Bb/u1r7p+UNThLDzp33GuOeP2Kg4ZQV5L1bYOKhqlHZT5E5CDCkn32mV3Spj6d2f+cz5Vt9930GN19TMFj4+20nUcalhrZNZx7LBPK9wpoY+pKdz51dli9p0uJh6ZhMWw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 03:35:08 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 03:35:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Liu Song <liusong@linux.alibaba.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up queued
 tags
Thread-Topic: [PATCH] sbitmap: Use single per-bitmap counting to wake up
 queued tags
Thread-Index: AQHY8Wvm+CZdxB4ohkivtu7W5Z+5TK41sLCAgAA8KyKAAAjUAA==
Date:   Wed, 9 Nov 2022 03:35:08 +0000
Message-ID: <1e9b8ff5-76ba-a8de-e8b9-bbdd07ebede8@nvidia.com>
References: <20221105231055.25953-1-krisman@suse.de>
 <f2d6dfd6-1234-2545-7955-07db078faa54@nvidia.com> <871qqcg77l.fsf@suse.de>
In-Reply-To: <871qqcg77l.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7492:EE_
x-ms-office365-filtering-correlation-id: c9ea7b11-ff06-4b59-1a90-08dac2036683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5JbjZ52U+lD0itq2qQG9NbZF2BuDq7o5cggW4mgUm+VaWaVcR8EYyqYZtjuVGZPoSTu/hqWOEbDAT13BZSU7DTQ/uLmeyEEbFnCZZrOhWVcS59+sdToW39SSpXEGN8fWKtE+2bXBACqVv6DGhCLy2jevHr8MNovgUk2on/AHXgt8DKARw4hpHW9VCzWMoDTZUt7xPgDsGTjUSkSVRnh7c1+62Rgug8JGxfL8/8angTlNrqpjoVkvndbMytmpp9PdeMo1bosvvSwIxblXFawsPHa9TyNmdU+5tgEV9KFtbVcdsCPiR0IkBZaoUEUOTWs2VIDiONYn/ihkp5drIXGt6WwFmp2/6AqgpeKOMGBREU+HbkR2XV2Rh7YIM8LvXVHLNTYwfFj2wUw9oqJ8uLMVqn4SUY5Fx4c6/10V2BEiygQRHBHSYFlt2sK/1kj2OBV3u756ogdL64FtjvlgGn/2Ny4WzflJYMynipxO45TSkss0jikwtVYfIK+mWIeDrck7R/FNQY6j8fXNFP1OeJYLm0TVuu+i+RRviIPDPyqFEWBfXCKkoW5U3YVKg70L46rlYeTuzWpWO8NltVfPBLd0owQs8LyXWATU4UxOZSLmpaxGPLbykErv3lFNmNXdqyeOKIBmgAbo/T0LazQwzMo8jhICtIlsCgoyfp1EYLW4pWetsNSoHrW4/MMW/1IS4p+HlTEcb2D+H9f9FogvbFty5vk+QKpCY5QmpWT1LKhuW2RkSwXHJ3N6ZPVP6ZOA+FD7eSwxX5gzFF5ArcZag0NUaaeCPhtJaXEYX7eNVMMfMiZPPZCXlzATEzBt+F81Kb/f0Dfdb3Zn/uQWKtCOdjWPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(316002)(54906003)(6916009)(2616005)(41300700001)(6512007)(8936002)(5660300002)(2906002)(186003)(53546011)(86362001)(31696002)(6506007)(8676002)(66946007)(76116006)(4326008)(66556008)(66476007)(91956017)(66446008)(36756003)(64756008)(83380400001)(31686004)(38100700002)(6486002)(478600001)(71200400001)(38070700005)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWt2WmlOek1rVGNvMDlkZ0hPZVRpU25JQnJoemdYaGlKL1Y5dzBRWVg2Tjhy?=
 =?utf-8?B?THZSamd1MFB1Q1hIcFhMVXlQeFE1Umw3VjJvaXFRbk5ySG04ZmhCY0ZuWGxw?=
 =?utf-8?B?VU1NL3lRQWZ1UTdJaFVySGtBTlhjV2VpN0xhQytyUWExMUw1WXhpK2g3TWRr?=
 =?utf-8?B?aDVMM0hUNGVNM3pDVlNPc09jUUlvc3hZbG1wNlE0SUdsNTdmZ1NpRThJa0M0?=
 =?utf-8?B?UWZJMjZGcnMyNTBrWTRKSS9wQXg1WGo2Yk9wS0VOUjF5RXVGditDY2paRFZp?=
 =?utf-8?B?S1FsUDF6WjNkTjhCZ3RVNHlIVjhHV21JaFhrUjUzK0hENXBVZlVaRDhmc2Y3?=
 =?utf-8?B?eUhiUWUzNlVSbHpya1dNRmFWNDRob1FITlZQY1ZaN1piaVlWTWp5M0V2SFFP?=
 =?utf-8?B?dThDdjZ6REZ6ejhQejZiVXBhRjZVTHVTY3J2ZzlqK3RDelNqcUtzWmFMMmVq?=
 =?utf-8?B?T1VJUm9VbTN3UjZOQjhoc3JLb2huUmhFM2RNTzN2RTJBTWUrTEh4QW9BdnZT?=
 =?utf-8?B?THEyNjB1b09mbHg5azEyck5DbDc2aU9ZL3RZVVE2UWFzV2d3NGRtUUJaV3Fm?=
 =?utf-8?B?dEgvMEZsa09FVnh2ZHdjVGVuT1lWQlFVaFkyTXNLZzZGdWxoSVkyRWhVNUI5?=
 =?utf-8?B?TnNyNXFZU0hnSkZhODJzRGFRZzRFczJEVHBTclUzQklRODYzNTlhVTNsUnpR?=
 =?utf-8?B?ZDNkcExYU3JYZ0NTa3BIZjVIekNiWXEvV2tIRGxrVUEzbWp2VlBqK2lFQkps?=
 =?utf-8?B?RXZPK2twaVMyQlNsNzVTR0dCcEo1Nkd2bWxRWmtaYXI0bkpqSUdxcGpCQm5T?=
 =?utf-8?B?Y1JqV1NKRjY1N3lTQlczYlhIS3JlNFpVdkt4WFJpWEkremorcmlxZnl4Ym5G?=
 =?utf-8?B?WGRWZURBL29pVlVyRnV6NTc1Ry9IU0FaV3M0SlVQRnhVS0ZRQ2JITjFXdU1h?=
 =?utf-8?B?RjhhOHFyZU5vYzNkWGlRc0MzZDU4L2ltbVg2S2RLeUhuMW5QWVRRWjc5U1pI?=
 =?utf-8?B?eUtydmkxNFI2eEd6cldXUU5CQWpkM25KdnIxdjBsZDFyVUtDYlloZW5zakZX?=
 =?utf-8?B?NUNEVWNaSElyTFpKRGt2TE11eXdFNlhoeTNQeGhDMzkyRDBzMllrN2l1WEF2?=
 =?utf-8?B?Qmt5TGxZd09ZS3Y1MVRUQmdvVTlnSzNpUEdROVJGMko2VVp1OUFMTlp4N252?=
 =?utf-8?B?Y1NNb0FydUZpMEh3bVJMU3dSeDRZMmNnRW5UQUVRU0QwMG42Q1FZdHpua2pL?=
 =?utf-8?B?RUhlcndDUlAwUmZhc05FWC9UclIxMmdkRWpoeEdwbnhhMTlwT0FmNEp4T2tr?=
 =?utf-8?B?ZitiRHoxWnkwaUd0NVhqd2lMQUI4YmZUbk0vcENPMkhjTThNUWQ0YTByeldm?=
 =?utf-8?B?V2hrZ3VLa2NyaTllaXVjRU5hcmdWSkk2RWNBN00zTTkyOFFiNDRXcHdzRWp5?=
 =?utf-8?B?a3FWaVNKVW5IT1ZKTEg2MHFzbWhqOFUvdzZmQlh2aE5weVRmQVJCZnVhcWY2?=
 =?utf-8?B?eUNCb1QyMEN5MzEzc2tDc2xKTTk3TTRMbE5hclVpM25mNHpJOS9FdXV0MUpT?=
 =?utf-8?B?MUxyKy9Fc1hFaWRTN2k5TmVOZ1lYSUlaa1JETHdsVFZlcjFYYkllempvRHFw?=
 =?utf-8?B?KzJtbmdWU0hDdDZuZzQrd09VakVmL3g2L2EzK2hiOVFPZStIZ1ZqUklMSnBO?=
 =?utf-8?B?NWNqd0djWXc5ODBGVkMrOUM2V0VYNWZUeUs0WXpta1d3OEZwQmZrbTFKdWV3?=
 =?utf-8?B?d2pDcE8ya21LcDNZMTFzVFJnZE83bU14K1h4ajNqQndFOWxydE5MdWVWc2o1?=
 =?utf-8?B?SitzUkVOYlJMMTM0RWNvWHUxbmxwZVpHNHRxZFdqWDlPczFiNlRiVDdqQlpH?=
 =?utf-8?B?NXgra2hkWFpEcVZvMEtLeCtUZTZHd3c0T0MxZ3RveG8yR0x4bkw3b3lidlIz?=
 =?utf-8?B?bVU2SGVKV3UzTUZXME9LV2UrNHhxcm1FNVcrcWpLMTJ6eHI1SGtKN2xMMWIw?=
 =?utf-8?B?akpYNzB5Zmp1V1czSmE4TjVmbU1FMEZiU3ZJYUkyOEZ2VXFsRDBtNjBhYzdK?=
 =?utf-8?B?SXBoSTBJY1duQ2RIRkJWZTZmZytGTVBuUTlXbGlPSzJhVVdrV3VGSkcyd25p?=
 =?utf-8?B?QlVPYXJRQTU0ZStvYndtNGpIT3oxdEltMldIWmdmeGdXNGVTZXlCN2JzN01W?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACCAF8E93DF1C24CAB3852AE1338F1C4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ea7b11-ff06-4b59-1a90-08dac2036683
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 03:35:08.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5RP5YF/WkcztUTRk2AZSApwkhatOKiPxKUx920b+oZSW0cDRYvMqCEMjgzyJOHYEcvgcokRzfRnZPGoQ17hRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvOC8yMiAxOTowMywgR2FicmllbCBLcmlzbWFuIEJlcnRhemkgd3JvdGU6DQo+IENoYWl0
YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlha0BudmlkaWEuY29tPiB3cml0ZXM6DQo+IA0KPj4+IEZv
ciBtb3JlIGludGVyZXN0aW5nIGNhc2VzLCB3aGVyZSB0aGVyZSBpcyBxdWV1ZWluZywgd2UgbmVl
ZCB0byB0YWtlDQo+Pj4gaW50byBhY2NvdW50IHRoZSBjcm9zcy1jb21tdW5pY2F0aW9uIG9mIHRo
ZSBhdG9taWMgb3BlcmF0aW9ucy4gIEkndmUNCj4+PiBiZWVuIGJlbmNobWFya2luZyBieSBydW5u
aW5nIHBhcmFsbGVsIGZpbyBqb2JzIGFnYWluc3QgYSBzaW5nbGUgaGN0eA0KPj4+IG51bGxiIGlu
IGRpZmZlcmVudCBoYXJkd2FyZSBxdWV1ZSBkZXB0aCBzY2VuYXJpb3MsIGFuZCB2ZXJpZnlpbmcg
Ym90aA0KPj4+IElPUFMgYW5kIHF1ZXVlaW5nLg0KPj4+DQo+Pj4gRWFjaCBleHBlcmltZW50IHdh
cyByZXBlYXRlZCA1IHRpbWVzIG9uIGEgMjAtQ1BVIGJveCwgd2l0aCAyMCBwYXJhbGxlbA0KPj4+
IGpvYnMuIGZpbyB3YXMgaXNzdWluZyBmaXhlZC1zaXplIHJhbmR3cml0ZXMgd2l0aCBxZD02NCBh
Z2FpbnN0IG51bGxiLA0KPj4+IHZhcnlpbmcgb25seSB0aGUgaGFyZHdhcmUgcXVldWUgbGVuZ3Ro
IHBlciB0ZXN0Lg0KPj4+DQo+Pj4gcXVldWUgc2l6ZSAyICAgICAgICAgICAgICAgICA0ICAgICAg
ICAgICAgICAgICA4ICAgICAgICAgICAgICAgICAxNiAgICAgICAgICAgICAgICAgMzIgICAgICAg
ICAgICAgICAgIDY0DQo+Pj4gNi4xLXJjMiAgICAxNjgxLjFLICgxLjZLKSAgICAyNjMzLjBLICgx
Mi43SykgICA2OTQwLjhLICgxNi4zSykgICA4MTcyLjNLICg2MTcuNUspICAgODM5MS43SyAoMzY3
LjFLKSAgIDg2MDYuMUsgKDM1MS4ySykNCj4+PiBwYXRjaGVkICAgIDE3MjEuOEsgKDE1LjFLKSAg
IDMwMTYuN0sgKDMuOEspICAgIDc1NDMuMEsgKDg5LjRLKSAgIDgxMzIuNUsgKDMwMy40SykgICA4
MzI0LjJLICgyMzAuNkspICAgODQwMS44SyAoMjg0LjdLKQ0KPj4NCj4+Pg0KPiANCj4gSGkgQ2hh
aXRhbnlhLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+IA0KPj4gU28gaWYgSSB1
bmRlcnN0YW5kIGNvcnJlY3RseQ0KPj4gUUQgMiw0LDggc2hvd3MgY2xlYXIgcGVyZm9ybWFuY2Ug
YmVuZWZpdCBmcm9tIHRoaXMgcGF0Y2ggd2hlcmVhcw0KPj4gUUQgMTYsIDMyLCA2NCBzaG93cyBk
cm9wIGluIHBlcmZvcm1hbmNlIGl0IHRoYXQgY29ycmVjdCA/DQo+Pg0KPj4gSWYgbXkgb2JzZXJ2
YXRpb24gaXMgY29ycmVjdCB0aGVuIGFwcGxpY2F0aW9ucyB3aXRoIGhpZ2ggUUQgd2lsbA0KPj4g
b2JzZXJ2ZSBkcm9wIGluIHRoZSBwZXJmb3JtYW5jZSA/DQo+IA0KPiBUbyBiZSBob25lc3QsIEkn
bSBub3Qgc3VyZS4gIEdpdmVuIHRoZSBvdmVybGFwIG9mIHRoZSBzdGFuZGFyZCB2YXJpYXRpb24N
Cj4gKGluIHBhcmVudGhlc2lzKSB3aXRoIHRoZSBtZWFuLCBJJ20gbm90IHN1cmUgdGhlIG9ic2Vy
dmVkIGRyb3AgaXMNCj4gc3RhdGlzdGljYWxseSBzaWduaWZpY2FudC4gSW4gbXkgcHJpb3IgYW5h
bHlzaXMsIEkgdGhvdWdodCBpdCB3YXNuJ3QuDQo+IA0KPiBJIGRvbid0IHNlZSB3aGVyZSBhIHNp
Z25pZmljYW50IGRpZmZlcmVuY2Ugd291bGQgY29tZSBmcm9tLCB0byBiZSBob25lc3QsDQo+IGJl
Y2F1c2UgdGhlIGhpZ2hlciB0aGUgUUQsIHRoZSBtb3JlIGxpa2VseSBpdCBpcyAgdG8gZ28gdGhy
b3VnaCB0aGUNCj4gbm90LWNvbnRlbmRlZCBwYXRoLCB3aGVyZSBzYnEtPndzX2FjdGl2ZSA9PSAw
LiAgVGhpcyBob3QgcGF0aCBpcw0KPiBpZGVudGljYWwgdG8gdGhlIGV4aXN0aW5nIGltcGxlbWVu
dGF0aW9uLg0KPiANCg0KVGhlIG51bWJlcnMgYXJlICB0YWtlbiBvbiB0aGUgbnVsbF9ibGssIHdp
dGggdGhlIGRyb3AgSSBjb3VsZCBzZWUgaGVyZQ0KbWF5IGVuZCB1cCBiZWluZyBkaWZmZXJlbnQg
b24gdGhlIHJlYWwgSC9XID8gYW5kIEkgY2Fubm90DQpjb21tZW50IG9uIHRoYXQgc2luY2Ugd2Ug
ZG9uJ3QgaGF2ZSB0aGF0IGRhdGEgLi4uDQoNCkRpZCB5b3UgcmVwZWF0IHRoZSBleHBlcmltZW50
IHdpdGggdGhlIHJlYWwgSC9XIGxpa2UgTlZNZSBTU0QgPw0KDQo+PiBBbHNvLCBwbGVhc2Ugc2hh
cmUgYSB0YWJsZSB3aXRoIGJsb2NrIHNpemUvSU9QUy9CVy9DUFUgKHN5c3RlbS91c2VyKQ0KPj4g
L0xBVC9TTEFUIHdpdGggJSBpbmNyZWFzZS9kZWNyZWFzZSBhbmQgZG9jdW1lbnQgdGhlIHJhdyBu
dW1iZXJzIGF0IHRoZQ0KPj4gZW5kIG9mIHRoZSBjb3Zlci1sZXR0ZXIgZm9yIGNvbXBsZXRlbmVz
cyBhbG9uZyB3aXRoIGZpbyBqb2IgdG8gb3RoZXJzDQo+PiBjYW4gcmVwZWF0IHRoZSBleHBlcmlt
ZW50Li4uDQo+IA0KPiBUaGlzIHdhcyBpc3N1ZWQgYWdhaW5zdCB0aGUgbnVsbGIgYW5kIHRoZSBJ
TyBzaXplIGlzIGZpeGVkLCBtYXRjaGluZyB0aGUNCj4gZGV2aWNlJ3MgYmxvY2sgc2l6ZSAoNTEy
YiksIHdoaWNoIGlzIHdoeSBJIGFtIG5vdCB0cmFja2luZyBCVywgb25seQ0KPiBJT1BTLiAgSSdt
IG5vdCBzdXJlIHRoZSBCVyBpcyBzdGlsbCByZWxldmFudCBpbiB0aGlzIHNjZW5hcmlvLg0KPiAN
Cj4gSSdsbCBkZWZpbml0ZWx5IGZvbGxvdyB1cCB3aXRoIENQVSB0aW1lIGFuZCBsYXRlbmNpZXMs
IGFuZCBzaGFyZSB0aGUNCj4gZmlvIGpvYi4gIEknbGwgYWxzbyB0YWtlIGFub3RoZXIgbG9vayBv
biB0aGUgc2lnbmlmaWNhbmNlIG9mIHRoZQ0KPiBtZWFzdXJlZCB2YWx1ZXMgZm9yIGhpZ2ggUUQu
DQo+IA0KDQpZZXMsIHBsZWFzZSBpZiBDUFUgdXNhZ2Ugd2F5IGhpZ2hlciB0aGVuIHdlIG5lZWQg
dG8ga25vdyB0aGF0IGFib3ZlDQpudW1iZXJzIGFyZSBhdCB0aGUgY29zdCBvZiB0aGUgaGlnaGVy
IENQVSwgaW4gdGhhdCBjYXNlIElPUHMgcGVyIGNvcmUNCkIvVyBwZXIgY29yZSBtYXRyaXggY2Fu
IGJlIHZlcnkgdXNlZnVsID8NCg0KLWNrDQoNCg==
