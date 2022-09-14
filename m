Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6FC5B8DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiINRSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiINRR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:17:56 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912180362;
        Wed, 14 Sep 2022 10:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1o/crZZ36DnTm3Q/CWnojfRxb2r0xzpmbHGmsplV978Q2vVFhiHVs0jZTGXpcB5Zg2CfTgY22V+YgfiWFOnhP1QjMy7qtkQquHjyL8GY2fj5ksz0GpbPOrp6WKh9w1uZi5UhZZBINHRrH47Od1eWwDbeqpMIe41P6QNmnT1ICHQ1BN6xT/VbPg7Y/+AzfeJberlPvjY1sSG7CFKAVD/FcRQdMd4zI8tjGcW5w0ZxX4hQ8oPKHsrf7F42K6YN97/rtVsaj4Y5VOre5ReQMJAHNk1NqiSNFnU3iPbQt0YiwpXmyvpROjyvIcim/hMGONDbs/4dKQEdAuwCQghtsApmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCubr7AZt1qjSZQyDDHPOhhn35o14OVqM1FakT6r0o4=;
 b=eijYCvIex5nphQNiWGhKQ22tDPo97cyFfj9822EElIdTFZBUcArWP1lSnE8kERsG2y4q7LpFo9DCn1XSaNVxDBMTW9MSLXLgI/eCc4ccfX9o3Ruk0b0hDu3aNhla2NIvhXi3suljjXPw23rcUghgjR2IYxX494cy+bLVrmMSQCiM+tqmjA5xdm4mXWBWa/YeeJKeAu45pDLEKGmp7l6+Ld1DEs9J+RxSHL7mlEwK8D63LPziusis/2W2rQ8TTAzpgRKvm9/JsfxEI5e0xwd+gsLOFrI6xTus0JVapCnCmMLX7tMQCwulMlIGV3n3/UlS43cYAa0lHXlqh7IX2AoUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCubr7AZt1qjSZQyDDHPOhhn35o14OVqM1FakT6r0o4=;
 b=JcL7w7DUSC6Up+ulx1r13X2jWo1TA1P7yZClBKRTGGsmHsFTJ6drKJ5+fGKXjy/CzpRnnhpkz7OnAAOlFgiVGeVNDC5VApUxrc/VcgThlMsmeWzQLXMEUWmlZEJT6z4EYkPuSeu6SDgeubJfhd+q3AyimYeDrGGQIsjpO6oO3wODVSD4KceRdXwjKK+tuC3ME4paTlvi2LM+XGj+WhPY3nLWA1Iyqkc4u748VaW92xGhNiLn4gT3OdgvcECRKq7g1mvpRkIDnOsfMPoMh4e50ajCIX4qO4ov/pwaiU6Y+u0s+R4tMQ8WsEPnw9Kj7I+nLQw2zUbikSl8HKBDc44grw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 17:17:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:17:52 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "agk@redhat.com" <agk@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v13 06/13] null_blk: allow zoned devices with non
 power-of-2 zone sizes
Thread-Topic: [PATCH v13 06/13] null_blk: allow zoned devices with non
 power-of-2 zone sizes
Thread-Index: AQHYxoDljeMHl4DWM0+B1R9OJeeu1q3fLtUA
Date:   Wed, 14 Sep 2022 17:17:52 +0000
Message-ID: <516fff59-8465-f36e-1399-e08b22e340af@nvidia.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082212eucas1p1032064dd2ac1638d7d18be7e6fe5344e@eucas1p1.samsung.com>
 <20220912082204.51189-7-p.raghav@samsung.com>
In-Reply-To: <20220912082204.51189-7-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4052:EE_
x-ms-office365-filtering-correlation-id: 6aceb55b-160d-4713-0972-08da96750eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XexZQC5MhL3jwgno5hJrUDctY88JAD82C8TEaiEpx6ZcfJZRvatQK8vsPM33gtxNOXdldtYT/3Sbp2iHZDbVxkaK93FelWjYrfxx+LAb3Ov5Du07pxfUTWUipVSYodJF8TbvG+Jgn+F3We4FI23TJ0Fje+7fjlClzo+QsSgEKSfwcqYcY18eelmc9PLdidzIqsKLdHhYjEZWY2Tao4crPj+iwBsEjgrt5peFS+Vn8w0uuYmgT3HJbnDSOzD9HTdMaECDsh6ACZIGohA60m+u4XoI+RygaLTLmbMMD+IwayVMwKtWzgxUVCMTNPyOvRsgeTNy6gKySEGcFq+U5MxRSehxTtc705DjdODKZPAp4/XsN0i5vpPNEFzNNlSmTaWgWucN1nHvHaRPge4lzRQPrBv1bZalzQNCDAZdZWGOofJkA40kwOnTimfXxD1ztR90rkHzn+HBN1L9htZ2D/etNVU4lhGUOCN8YITeXrUqDE0TN7B0c0FXOYTD03//RxQVxGMPHcueKjfX0vNF0Tdkq262r3HRPhvtcfj0Lyp8ntML96UFZnhF+nSTRj5nMJ8fQVVqJBWujtrk0YlAcS7tL4qBFq31qvyeftcxgRk4H2prmBgWlkTKx/8Or6pHb1Q6XFnr//ccB+b7MMk9jtjGj6Vz+Z75xkRnAzTTW8exhkDcJWn+4Lau1/Fdov7WNfCEG3/FeXoGtn7in+m+jJyrLvZBRn/4B4lNp877pNUlrGMFRGjuO2i9fAB8gWEOraycG7feVrkQB6lvO3W7uqxMrcRevr3hfLud7wDGbpX+TYiW3jszPpBxiRuUQNUbVp38p5T4pTD/VI24co+aWYzkYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(8936002)(71200400001)(110136005)(6512007)(38100700002)(8676002)(26005)(31696002)(38070700005)(478600001)(66946007)(6506007)(4326008)(86362001)(7416002)(66476007)(66446008)(64756008)(186003)(76116006)(66556008)(6486002)(53546011)(5660300002)(91956017)(2616005)(4744005)(54906003)(36756003)(122000001)(31686004)(2906002)(316002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkVMZVV1RUJnUDJ1Wkg3R1NSV3JyVjdwVHFFUmxTTFc1QVlMbVdYdFkxSWVQ?=
 =?utf-8?B?Uy95MjdEa2swLytJcnpYbzZSNTR1NFhUeGZYT211SGdaNkY1b2pWQ3FxM2Zt?=
 =?utf-8?B?cjlBeUVWaFpyZUFQaVUzOUJORkl2ejRiRnlXbWQrZEVFSEd0MVZZY3FJdkY3?=
 =?utf-8?B?RVN6L3A1b0M3L01OSzRtU1NsUEloQjE4bkxGTGFMb01pY1ZMajJWTU10Z0Yy?=
 =?utf-8?B?enZLbzBmYTMraHplSklHUnNKV3hvZDRzTjdYbWI4N0V4NWlpaU1qSGVPZXRi?=
 =?utf-8?B?Nk5lVXkvZDk4cTlpU0psUlF4azllUTNOREltQnRuUVRaVGcyWEpZSDV3QnJY?=
 =?utf-8?B?QUc5YlE5cDJodzVnSzYxTVVOR1JFNS9WUXRjZTlMOG5TMFhMOXFIR20yOVhV?=
 =?utf-8?B?TEpKVXZ3MmlKc3M0TVpMQ21NSEZiYXlSdStBazYvN0FDWENGOFpzN3VDMnpv?=
 =?utf-8?B?WE96TWxKN1FsWVNEZmdnSnpsN3RxbjZEdWdNUHpKQmZwcFlGOGxDcnlUUWRP?=
 =?utf-8?B?Y2tUd3lmWnA3ZVhwNGdtc291czM0WG9uNlBwdUVhcnZraXdEdWlMcHVHcVJn?=
 =?utf-8?B?ZWNybzBLZS8rby9FUjk2TUVCVktKU3BRV1lHaFVIaWJGZmJCWmtJYW5BMWF1?=
 =?utf-8?B?Q09vNXRsdE9IdUp1RXY3Q3FYWW5QUW5tVUw0amdFZnlHR1JrUGtacUVFYkVI?=
 =?utf-8?B?RVp4emxPV2FMb05pMjU1NERjd25IcjR4SUZNSlBzL2Z0QnlJTHJXRnhZVVhq?=
 =?utf-8?B?UEU0N0lSOVRTM1dOeE1TNmlqMHByV0tlbU5uWUR4bS9VT0dnaUdodmEvL01I?=
 =?utf-8?B?MTU2Q2hSVENqMmhQYlNOYjdydENEaC9vWVMrS1RSaVlQQjFsNk9TUkdpNGdz?=
 =?utf-8?B?Q0pMRHM2SWo3bitZWEg0bjUyRjZtVURLcFpCLzErdStFWUQxc1hHUjZaWFNk?=
 =?utf-8?B?SjRyYnNzZkt5a1JDZGVqQjNzVi9Yb1ZqWktmUUJjVU1mOVVjSzJpTG5wYy9M?=
 =?utf-8?B?VFZhQ2l4eUg5RHRjVkU0YUJYa0p4dHBFV3ZZUG1nQTF4NDNlN1lKdHFDOUFZ?=
 =?utf-8?B?dHZVd0R0ZWdZY1ArMzkwL3B1TlZ2aWMyY2ZscmplWlFKUFhkK0hSMUU5eVdY?=
 =?utf-8?B?a2xDWkxMeFh0TXl2QkI2ZzRpS1RGamFKaVFQQkk2OGtiaGxxVGxCb3J0bXhX?=
 =?utf-8?B?emc4MGNOMGt2NTloazBKaEpaRDBkWkM5Vk4wZE9LVm9EVUthUVM5MytialJ1?=
 =?utf-8?B?b2tnd05FMk1pYU9FNEJMSkFlRitRV1I0aElYcDV5N3Z6S1YzZ2FkOEZmYmZL?=
 =?utf-8?B?VDg5ZkpVWW9OT1ZOTzROb21weEpYR3R2WURKOSsxRGJMckJuVUxNSE1aK3RS?=
 =?utf-8?B?dXV2VGR4SmhUOG9kelZFK3NvZHdXTkszYlJYZi9VcGhaMmd6VmdxU1IwV3gy?=
 =?utf-8?B?KzJCNzR6SkZCM2h4REtpcjA2TnNjcmY3enIyR0FUeGdEM0c3L0dKV04xZjJ6?=
 =?utf-8?B?NDVCV3l2TWhaelk3Ui95a1ZGYS9VUlhBaGVva3ZrQjlMcStZK20yZGhUY0V0?=
 =?utf-8?B?YS9QQXRPdS9QVWxpZ1liZmN5Vnc3VHpUNGVlTVQzU0VybkFOZWR3bnhnQXlw?=
 =?utf-8?B?SitoZGpWVXZtVDlIdVRBS1NJc3RQdmN0WUVwS2RzdUZkTVN4NktseCsreHE5?=
 =?utf-8?B?TU93cFVvaUhqaTVHQ1FTL0xmTXRxbm1vMk1WSVVqZWF2VG1LVjJEWEgxMEJR?=
 =?utf-8?B?TU4xcHJvWGJJR2gxdnlKK2g4bm11eWdPSFQ0QkJ0b1BYcUt0WHd2cldEZHpH?=
 =?utf-8?B?dTQrVE9aRUVaajVPWDJIeFJQMDh4dWdwSU5uOThUb3VmY2JPM2xGbHVXVFFh?=
 =?utf-8?B?bVVQaHdZTXk4N2Fha2txWkJVNGxCc1V6M3VRRlBiNnRzQWg4cjFNanMyMks4?=
 =?utf-8?B?QVJjRGFUYStvOVFIaVRQcDVmc09IY0RObFB0Qk9OWkJIYzlrMnJKQlRZM1Zm?=
 =?utf-8?B?Tko4SWU2NHU2TmFPMVpwN2NLelJFak5XdHNWSUhPOWZmM3YydUJuZmRSTWZM?=
 =?utf-8?B?dm81Y0gwK0tNMlJLTFBLaDFPYy9DcklDZmJSQ2s2UWlqNHBOQlpiZ0pnZGh6?=
 =?utf-8?Q?SB/hCgLYewUFLVGQk4UNBtXGT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <905C81B2EA36A647A43E1AE39E595122@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aceb55b-160d-4713-0972-08da96750eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 17:17:52.7570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DU1UWSe/FbGpDcE91wJxvfLyimaNj31RDtFfxHH/I2rHxKPkTTcs7hmTpO6cuZOysmfgVIna2U41bcBUDUhJ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMi8yMDIyIDE6MjEgQU0sIFBhbmthaiBSYWdoYXYgd3JvdGU6DQo+IENvbnZlcnQgdGhl
IHBvd2VyLW9mLTIocG8yKSBiYXNlZCBjYWxjdWxhdGlvbiB3aXRoIHpvbmUgc2l6ZSB0byBiZSBn
ZW5lcmljDQo+IGluIG51bGxfem9uZV9ubyB3aXRoIG9wdGltaXphdGlvbiBmb3IgcG8yIHpvbmUg
c2l6ZXMuDQo+IA0KPiBUaGUgbnJfem9uZXMgY2FsY3VsYXRpb24gaW4gbnVsbF9pbml0X3pvbmVk
X2RldiBoYXMgYmVlbiByZXBsYWNlZCB3aXRoIGENCj4gZGl2aXNpb24gd2l0aG91dCBzcGVjaWFs
IGhhbmRsaW5nIGZvciBwbzIgem9uZSBzaXplcyBhcyB0aGlzIGZ1bmN0aW9uIGlzDQo+IGNhbGxl
ZCBvbmx5IGR1cmluZyB0aGUgaW5pdGlhbGl6YXRpb24gYW5kIHdpbGwgbm90IGJlIGludm9rZWQg
aW4gdGhlIGhvdA0KPiBwYXRoLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEx1aXMgQ2hhbWJlcmxhaW4g
PG1jZ3JvZkBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZCBieTogQWRhbSBNYW56YW5hcmVzIDxhLm1h
bnphbmFyZXNAc2Ftc3VuZy5jb20+DQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhh
cmVAc3VzZS5kZT4NCj4gUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBh
Y20ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYW5rYWogUmFnaGF2IDxwLnJhZ2hhdkBzYW1zdW5n
LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K
