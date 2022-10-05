Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5545F5917
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJERYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJERY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:24:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1EB7D785;
        Wed,  5 Oct 2022 10:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6BjE1eOubhSUK9Sc/0jmQZA1Tuaria6c4kdux8eBRyvVg7xKyjxAkWknX4LqRqybYsoQrMakl3J9k1KMrdQW0+L3titcB49aPTxthC/+XTzu3/HaLL9W4Dy5USXNYb2mUUuz3i90qI33bNAF0JDONpFtaEffdfsJRlIgGCCcsTt/6dfXhkJIyhFR0wRoLMD+gsOIABEXzUQxljsCVChOUkmdGTwVK/MOhT0+3Zt7JUq5Dm34TQkunCPXzBMG2AsgqZdDa07N/r+a6RDHzT+qE1rgELS2uirMRQGbtcNzH3GU0zQ5f9AyMS/sSPMmg7qcR1Jo4IyNzUQu/8b58jYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzcgaJirpEkuBcxGm2rUhD5N/PV5cICTvdp996ZPewg=;
 b=VT3cnr69EM3wGbxOllfZ0Z2wY30udir7oBqTpxSNK+6ik05+4Vqz+zi7I7eR1ioLEXadP/cvAGxNptLu8+ag17xNiqMlLhQ7vUQ+acVigWZJTVHJAR+Mb+O7ZEwOcb94/iVH+v3uM/T/EojH0ABzuoA1+jGZG8d2I9+m4U9xoEkw2v3nMqmGY8OU8kuxiISCQN2IK2k0XlvRUXlTLmxRokfHWFpFj7L4qPNwLy4lE4w9vitG9xrsVJ2nHMe46xiui0DqRm1vqYETyvM8TxI9AbQ7WpWXd3Px/D8NJHnEGMeq77wJlDqmNo/86jbfkKdhlmXH4PDpfaB1+2kx9SMBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzcgaJirpEkuBcxGm2rUhD5N/PV5cICTvdp996ZPewg=;
 b=OGF5OidVGqsiHcH5OLWxnGdqYu5qxJKRWTyTBMijLamibUVLDtRKjRdqMt6u8he1eBacJmWsJ8Vi17wExf05v4tI1B4ra1ZfZgjrWXwk5k8XZ6zp+A5X79OPeJppMG8c50Nxa/w4cqc36UmTR8QsyEL/FFiKAt6rrHoyTAam9pe2B+VNHjs/70mKEZm17jG1VcjACtUUtstBduTfh+39G4cat5MLaz5IM9NBVTUEGpgjV75ifCR1nuSHgJ2kJET4Uhuqf1xi/bSujY9H/l2LFvuZREHGPga0ZPBPNrayQHAZCj1713KNluJsZ40hhtsT+5/z7HIot8KkPeqrIM7Z1w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Wed, 5 Oct
 2022 17:24:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 17:24:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     =?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?= 
        <christoph.boehmwalder@linbit.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "ogeert@linux-m68k.org" <ogeert@linux-m68k.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
        "lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
        "efremov@linux.com" <efremov@linux.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "tim@cyberelk.net" <tim@cyberelk.net>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [RFC PATCH 05/18] drbd: use init disk helper
Thread-Topic: [RFC PATCH 05/18] drbd: use init disk helper
Thread-Index: AQHY2HeQezp2ej+qC02v2lxKPd/Sr63/lCOAgAB5ioA=
Date:   Wed, 5 Oct 2022 17:24:22 +0000
Message-ID: <1e2cbfd0-6136-df9e-58fb-60f1375b2e79@nvidia.com>
References: <20221005050027.39591-1-kch@nvidia.com>
 <20221005050027.39591-6-kch@nvidia.com>
 <e23e94f8-13ad-4a10-62de-33e63a62831f@linbit.com>
In-Reply-To: <e23e94f8-13ad-4a10-62de-33e63a62831f@linbit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB7543:EE_
x-ms-office365-filtering-correlation-id: 2e103ab3-0995-41ef-f45a-08daa6f67171
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNsgKS1KrAK4rDKnODQmw4lT8LX1x64ANj7qz4N7d8l46tKAdYOBOip6oR2oG9MhbwD+nFQYSePCdem/TdJXYDqazIV5ihMp1ISGU/U/Tqf4dCIePjXEgQPS0ZOkLjl15+5CDO+2ZSYNoQoY4OpjudDsVJt2upcSw+VDjBs1bYr6YIPDkqgSIqXtmhDwf9Uxd6ao6KiAblZLO74amvxaxmFe5mbuorwlhSK3n4W35dCAIL9ZIpCRyWoRZNjB7TXBfV0WSBOQlUUYKLzais+jv1cG44yS1ot4NBGCVLygsZxEeHryJeillXT9tsjkxB4m0F+DHmZehnnOaReBLawDjaqPhVDCWTk3vS+pD3AY2jvRpJgTAkE5LtuP17Byu7kd+M48dUuLcqnaFN+9P9zBnzF+4DNh4yaZwjZtwcC3DXjHPIskQO/6GR/Z8HdSygogYCtbIXABXuHnC8cG52hBb+7swWnLY0663lku1okxhXjL8cInBOCAB5SR7hvBTaqDc/4XxDZVvXf48xSEIz7ryGZ4Ry4319MAYqfo9SdaRjDL4ImjoCA3GoTJ4YnJUJfDg1VdldI5S1H+sU9Wc+kWBBNM+XDn58G74fjiA9QFmCuVKCJz+t6O8uyRlwQ0tMjsj/CZxXl141BGTqe9/7tf3ImyCb+HfSb9zxDe1AzPUAJFGRRlCvwKq3L8eN+sIYSSvLQrspj6wXeRygOi9CKb1BBZjs3Yp6qxY2r6JVCwKcQw+KbhwINvu7CVycQiOSFYdDk1onjBpjzEzVGv3Hv9vdk3acXUTNjam2rG06ZgFmfIY5UYKqSzI9S40N/bn67q52JKua6En25JofgMnz9u/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(31686004)(66476007)(66946007)(64756008)(8676002)(4326008)(66556008)(66446008)(54906003)(6486002)(86362001)(38070700005)(31696002)(7416002)(2906002)(38100700002)(110136005)(5660300002)(71200400001)(122000001)(6506007)(186003)(91956017)(2616005)(316002)(8936002)(76116006)(6512007)(36756003)(41300700001)(83380400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW50NEcrbHR3UXNCQ2RyY0Z6N2FMZGlmakRwV3JGQzgvR051NThWY1NsUFJy?=
 =?utf-8?B?RC94c0FNdVkyRDhGWVQwUmR6YWNkT3VQcHF0UXJsSWlxNkRFdk44eEIyU2pG?=
 =?utf-8?B?VnVDVS9EdThUek00YTdtemNnOUpzNGJjbVVlV1dlODBXc2Z6cm83eTRzcnNt?=
 =?utf-8?B?TVFXd1UwUklpU25Jem9KZzdkekNUVVZDZHVKNjJYY0VORmhrYWo1QVBSMHhF?=
 =?utf-8?B?Q251Ky9UcGdQTmZ2L2NUNGxjZVhKRlNubWJ4NGNJYUN5VEc1VVdLbmRXMmR6?=
 =?utf-8?B?ZzlXRVVPMGEvTS9pT24wbzZHalVCa05iR3lSVVZ3Y0F2Q2VENkpKNVhUSFN2?=
 =?utf-8?B?L3hMZVRxYlJ1UjRRN0ptRklxWWQ2dnJjVUdTL2RNOTd3K3ZSQmwweUJWY29t?=
 =?utf-8?B?bVZuQ3hGdWY5UzFWZGEzbXVWTHBwK3hNSStpNkphaHU3YWpLeVFZbk4yQ1BV?=
 =?utf-8?B?aG82SVFvaVEyQXg3cllPY1RpTjlubHFLNW9MYWlIY2xoZlExWWw4ZDVFQ2pT?=
 =?utf-8?B?Zmt3SXdqRFFHWjhETnRYUEVPZzlpT2NCclZ0UVI3dXZ0c1pYV2srNGd4UTVr?=
 =?utf-8?B?NzR1S1FITDdKU3VFQnk2NWR1VGNZUHpGSHk1NGFEWXYzVjNTYnBSL05OYy9W?=
 =?utf-8?B?bGJNdjRMczNOUmZ5NWhkeGJzTFljMUN4ejlXZXZEb09UbnUyaVhjWUFUOFJh?=
 =?utf-8?B?ZmpUOTNhamxTNjlzSWR4SStQeHp2RjBMd0FVMmtZbnRaTUY0UHB3MWNJclhC?=
 =?utf-8?B?bE5DTTc5aCtWMVpyTzZIYks4SGwyUUdLclVFVEo2VXVubGM0cSt4dHhjM3BL?=
 =?utf-8?B?NGRlVGJaZWNSQ2hQUDRReG42V09QQ0R5OWRVNlU4Z2RYZGNCSmxxS1pMTjV0?=
 =?utf-8?B?dVJpQUVGbEVxMWx0QlFMdWU3YUxrZDZoTDYvWmFneXFxR1pFYVR0UXgrTFJ2?=
 =?utf-8?B?eDE0TzBYeWkvODB6eFdFcXhUYU5EVCtGN0RWMUNzQW1YN3dSVDl5bE1oVi9G?=
 =?utf-8?B?RFFMZVNSTXArbk5mMjFMeEgxQjhYTnc1SG5oeExBVTB5NVFjRjlITTlxWTZT?=
 =?utf-8?B?L1VacTQzTWNkb1o2K3J0eitjQ1R3Y3BPWmZOd3ROakRCYVhUOGxmMnFCSEJN?=
 =?utf-8?B?ajBFd1BhZTY2MWdqN0RXeldOUUJ3MVcxMk9yZE5ta0oyTkVGY3pUSDdiZFh2?=
 =?utf-8?B?US96MVc1UzRNanFXZHhwcWlmYVp3UURGakt3VkNlcjIwZC9XaTMrdGtjVEQ0?=
 =?utf-8?B?c3lwNFdrRXZvemYyRHNJR3lzZkZEUENXcmJBdGpPc016d1hBcGIwd1BmTzlK?=
 =?utf-8?B?bWhXL2ZabTlXNkp2bUF5czNKOStWNjZLOGMwMkQzQjN4emZpZlZOSUJQSHVk?=
 =?utf-8?B?VUFlaldiWE5sR3dVZHBMcXFlaVZvM014bmxxUGtUVmw5N2lDNC9OVE4wU3ZP?=
 =?utf-8?B?a2R0eU9LWk1VdStkcFBtSjlBZ2FUUXRzYnlOQTVMaWY0SFpMMFlGVGRXTjZl?=
 =?utf-8?B?UytwTW8vNXVFUkdIeWJTQ08rTERnd25nSytTZEp4K3dLc1FHT01ncG5LY3NJ?=
 =?utf-8?B?dDlkdUtYYldXKzBvcklwSGVCOE91MVNGaWduQU8vOVpyWTkzdjBueU51Z2hs?=
 =?utf-8?B?cDMvb2F1VXRhU3RYM0hzejFwWGtlY0NLQjEwa0RDWEhzRGpPaWRaT3kvY0xr?=
 =?utf-8?B?cUlBYldmaHJzdG1oamU0TFdRQjVHZVl5T0JxMW1SdG81YXZ0bzVBMTQ3RVBK?=
 =?utf-8?B?ODg0ckJKNVNpaVoxdUMyK2JWUVBTaHdZTVBqdFQ2RHJvdExyNXZzd2NsTFRH?=
 =?utf-8?B?YVVxSzRsNUNsaEZGMTE3V0dYQnRVeFdsRSt3UHh1d0VyK21rZnJ0MHMzQzhH?=
 =?utf-8?B?MU01OS9zS2RyNVJnQks5UzN2NmQzSDJXU2ZsQUJEQzhWMjVMazZMa2p1Y28v?=
 =?utf-8?B?dlVzS05heTFXSUoyMUttdTVWdXZKN0JDOVBnblo2NnlncFJPazVLRUdkWDh2?=
 =?utf-8?B?c0E4TGt6ZTc5YWxOeXEyRWQ0TDg0eFdJcTFKeGhhUERVekVGM25scnczR3R5?=
 =?utf-8?B?a2FoYmxuVStMb0hGWk9jZFE3OEs3S2dwMkpZNDI4WEFQY25Xa0RaeTJwY2Yz?=
 =?utf-8?B?aWQyU0lFWjdWV2VlWFVvRFRNZjNyTTRyUVVrYlV0ZkZDNGltT3p1UEtuUHlE?=
 =?utf-8?Q?02FkTo/MXZW32y5k5qlVV42s7EeFWGwizzHwHiuwlUIi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FBCCCB66932BD4F8A146135657B57AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e103ab3-0995-41ef-f45a-08daa6f67171
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 17:24:22.1493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/PFNki8YtMyBByxfRyE4R2EXbUvoH51Je6G4lvlPqx9oufb7MhOUX8yPbPSYaP0zhtvnyz1BmTLifFh7sqfwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfbWFpbi5jIGIvZHJpdmVy
cy9ibG9jay9kcmJkL2RyYmRfbWFpbi5jDQo+PiBpbmRleCBmM2U0ZGIxNmZkMDcuLjU4ZmFlMTIy
ZGUxNiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmxvY2svZHJiZC9kcmJkX21haW4uYw0KPj4g
KysrIGIvZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfbWFpbi5jDQo+PiBAQCAtMjcwNiwxMyArMjcw
Niw5IEBAIGVudW0gZHJiZF9yZXRfY29kZSBkcmJkX2NyZWF0ZV9kZXZpY2Uoc3RydWN0IGRyYmRf
Y29uZmlnX2NvbnRleHQgKmFkbV9jdHgsIHVuc2lnDQo+PiAgIA0KPj4gICAJc2V0X2Rpc2tfcm8o
ZGlzaywgdHJ1ZSk7DQo+PiAgIA0KPj4gLQlkaXNrLT5tYWpvciA9IERSQkRfTUFKT1I7DQo+PiAt
CWRpc2stPmZpcnN0X21pbm9yID0gbWlub3I7DQo+PiAtCWRpc2stPm1pbm9ycyA9IDE7DQo+PiAt
CWRpc2stPmZvcHMgPSAmZHJiZF9vcHM7DQo+PiAgIAlkaXNrLT5mbGFncyB8PSBHRU5IRF9GTF9O
T19QQVJUOw0KPj4gICAJc3ByaW50ZihkaXNrLT5kaXNrX25hbWUsICJkcmJkJWQiLCBtaW5vcik7
DQo+PiAtCWRpc2stPnByaXZhdGVfZGF0YSA9IGRldmljZTsNCj4+ICsJaW5pdF9kaXNrKGRpc2ss
IERSQkRfTUFKT1IsIG1pbm9yLCAxLCAwLCBkZXZpY2UsICZkcmJkX29wcyk7DQo+PiAgIA0KPj4g
ICAJYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdfU1RBQkxFX1dSSVRFUywgZGlzay0+cXVl
dWUpOw0KPj4gICAJYmxrX3F1ZXVlX3dyaXRlX2NhY2hlKGRpc2stPnF1ZXVlLCB0cnVlLCB0cnVl
KTsNCj4gDQo+IFRoaXMgbm93IGRvZXMgYSBzZXRfY2FwYWNpdHkoLi4uLCAwKSwgd2hpY2ggaXQg
ZGlkIG5vdCBkbyBiZWZvcmUuDQo+IEknbSBndWVzc2luZyB0aGlzIGRvZXMgbm90IGhhdmUgYW55
IHNpZGUgZWZmZWN0cyBhcyB0aGUgY2FwYWNpdHkgc2hvdWxkDQo+IGFscmVhZHkgYmUgaW5pdGlh
bGl6ZWQgdG8gMD8gRG8geW91IGtub3cgdGhpcyBmb3Igc3VyZT8NCj4gDQoNCkkgdGhpbmsgSSds
bCBtb3ZlICB0aGUgY2FsbCB0byBzZXRfY2FwY2l0eSBvdXQgb2YgdGhlIGNhbGxlciwNCldpbGwg
cmVzZW5kIHRoZSBzZXJpZXMgc2hvcnRseS4NCg0KLWNrDQoNCg==
