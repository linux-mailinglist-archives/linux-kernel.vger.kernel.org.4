Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AB85B8DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiINRRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiINRRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:17:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6468053B;
        Wed, 14 Sep 2022 10:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcmtYRMg+llgTNunrgyGK+n/CoCsxnpyymI3jEVxvK9Vb36cAz3qQ+HfIOGid9mXlLHAriPk5BLFFvzOIj/t4EROekX8cN5CF2iP4lWJFeQCpzCQwPmFAglSlPL373QcLBeO/vYl0oGpWz0AOGwu5xknbkvtGk0nBVHv6shFPdtOdoNW/KMlnE3ut8TYzkrxxnVCUENmW7SeK1rNuQ1sawUqFnPehMBuAqY6dlNXYoOs7gxkxDADAf292l+TjAsCRexgeWQVyUdfl/9wsSKomQgyfhSg0QRRCNKm0aGhakDODOdM0ATFhBbIu0dH0roqlaC1wTghgjsbYfqmGX2hOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFRNol2yFiwd4fbIgMQ0IWtKeiQq1EcehcCOa4nsncA=;
 b=YbEDyZNwJlfEvzVIUGRqMFPSGJ7ZErcAzioD0FWfBElOMbjUQZvMcQLGLSgGVBhGoA74f0uaa1P9eObieC676nNx4eWI8WzoJftGPl1+Pe8qi3oTuY8A5I1wTYgkwOaxxu1cSC5p6KUW/3b2qwTcO4FNUVNFaNaEnS4Pg+x110dr2H4etPkXSfqUSA/hqRe7bDIMSa/3lYcgpz/sFoPm17MlvgY6MKBq75N32zDnJJUJWJoodekqSNFIIZO1W8YWRoYnsTJQUHSAak3yczVUn1a/6SKG4i2WldxH9IAjIWhRL5aFOb5vcPzdkWkNX7OMU0cUHKP224fvFbNwKLcskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFRNol2yFiwd4fbIgMQ0IWtKeiQq1EcehcCOa4nsncA=;
 b=oqnMo0zGbrlTCu1jWuymn8pcaUlmnWPboqsHqd42VOrcSQEghNeTbJrJzKe4ozBi/6rzgMBBRNOgeAyDstvBEmXGCmIGF74gADGSI86DZ0v4isSdt6clPwWCS/Lq5I68fI2/yTbwSjELQowlz0HNGaEkJFRSVmsqhRLYUdencWa74HXksCGsDBsSdeSWZsUQbG3U1ICB7b6q2NwEaW8sJE0bvHMDdSCzmfGBq1Ln7wiFcKAaMHU/PXcuokAWz50euO3c1h9sHtld4wIKYo26AhSSYbJlbjM1nLyRKFaI+tuYZ4rBSazyiSsmIw/xiGIdZl1x8QEsN5bF2Sj17wUrsQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 17:17:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:17:27 +0000
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
Subject: Re: [PATCH v13 07/13] zonefs: allow non power of 2 zoned devices
Thread-Topic: [PATCH v13 07/13] zonefs: allow non power of 2 zoned devices
Thread-Index: AQHYxoDuZVRHGaI6eUyTaRXyz0v6063fLreA
Date:   Wed, 14 Sep 2022 17:17:27 +0000
Message-ID: <9595fdee-44b3-e210-a650-3c67875bef22@nvidia.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082213eucas1p239d6095dab9b042f05efd3a6e82bac9c@eucas1p2.samsung.com>
 <20220912082204.51189-8-p.raghav@samsung.com>
In-Reply-To: <20220912082204.51189-8-p.raghav@samsung.com>
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
x-ms-office365-filtering-correlation-id: 1f955e0b-61be-47e2-3401-08da9674ff69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /DIpJ4IKipyx537WFEgKvaX7Lrv1v6EAafAhVp4D0j+YtDUcq40aUaY+qIQuf8IlucE1jZKCtxNzSl1mImpZ8D5XGrSHoPjh3uwkC/4lhskCvjkP4nV0946PR5aPRvtW5O4TbXpI7MLMP+I9Ce8nJCL2LGGPxUZG8V9t83FvOia5pasfexiLJlollhgWUTPz3gs1GDBiVEinIRJpFCsShRE3apm8JEibvpEmdRHGDa/lduz9QeSfZ+Xnkn7KZ6TYwnp/WUr4CFV2XpLePQjW8sBAVPWxvyWyaCOzmPLYVn2mu4LuFFmHWHs6fd6Rmd0AC+GZq1u5Xe4i8bcpYuYFba22Y7uSnhS7orLRwbzSQzAKfV14RmHgefVDS7aQldzPHw+ufcVNL91KKx4DtnRDMIT0PnUXWks8K8z+22QphQfF19qY1vVSzCD/BhVG6eVZbC350Unhbv8OQuLVfve1N3mfQZDndXu0t5pIrfXE3bXy6+Ebm6rAkSZrajubYnsp31r7ngcwvQHGnn+iHcR8ikXAjvoD7bZQgrMsjUt9Yx8h3XTkrycz7V6ha4r0Gu7MMjRR+akxnr3l4IE1lRE+Ymc30/Q1ahum2MNTC3/JlOu7Yv+eON7bTUtCddRPYBzbzgq+12En0pty/dYNf98EY0yMHHZBpvXS1rlj0Ym7qhWh/r0CY5WBxKGgtMgicrSnNnGvNRhvH4bILNwxQk7+IaavpanRDARiTB7RZdnM/TQZ7bl8y4VOpOhY2xVxRLVG9WLzhQ426cayYjDEBtPtS25xypccHOx9hQ6LimM2q3ax4o5hNcYpK2cfCP3uPCzRpcM3z7pBouzjWK/LyjQXVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(8936002)(71200400001)(110136005)(6512007)(83380400001)(38100700002)(8676002)(26005)(31696002)(38070700005)(478600001)(66946007)(6506007)(4326008)(86362001)(7416002)(66476007)(66446008)(64756008)(186003)(76116006)(66556008)(6486002)(53546011)(5660300002)(91956017)(2616005)(4744005)(54906003)(36756003)(122000001)(31686004)(2906002)(316002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjVlWFNZVXEzQktOL0lNV0l4WTRQNzM4SHBLQXhoWWx3cm5ib3FUeUFaNUtn?=
 =?utf-8?B?NnREV2FBV2E4eERrQmhyTDNCUE1tZndtelV1a2QwczZCeUdlR21pRHpseFlZ?=
 =?utf-8?B?cE50U1V3M2ozRVRYRXhNTUVob0wyekNHZlRxeWNKZnVQZnVLZEdiSGx1VU9S?=
 =?utf-8?B?MGZPU0pPVldPU1JrdWZTTmtRNlhxOWsrYlZRRlI1ZDlOS3VaYm4yczcyaFE1?=
 =?utf-8?B?UlNlYk8zaXJocWsxNGo2Q2Jhc3puNDF2K29tcEo1ZkFDRlE1cUNhUThkdVU5?=
 =?utf-8?B?Y28wUTRZK0UwcllTODA5cHJuTEYxN0RBa0xQVFArYWdrMkxxaTc0Q2tnbnZq?=
 =?utf-8?B?bnl6N2F5TytBdEN4VmZUVExOdG5kTGFsaXZSTkZTSXY4Y0VTbWlRS1lTTVhp?=
 =?utf-8?B?ODE3eDN3clJiV2hMZTBDdE1PbEY2R3A5c0crSmo1alJmRytEVGV2ODQ5OU92?=
 =?utf-8?B?N2lHV3FuRGYyem9UeklxWC9SNG0yNldKQ2RmQjVDQm9NVzMwQWpRdXRNdnpN?=
 =?utf-8?B?N1ZLdTZ4SzNHN3dsdDVZajJUd3c0ZFBJSkUzMmpYUnVtTklKblg4WUc2M0Yr?=
 =?utf-8?B?K21vaEo4a0hPbHFtS2YvSllGNTQ3RlhoancrQm9JOG1BcTZPd0h5Zml1bkVv?=
 =?utf-8?B?N2U0anA3ak1Lc3pHV2EwSVIzU2UzWlJOckhWcVZYTkhSRFZ6eEIyT29TRVJt?=
 =?utf-8?B?QTkzOGlkUkZUeXc1eVVDVUp4T3F0NGZDTmRsaHV0YWJHdlhYQmhVQndSTnJl?=
 =?utf-8?B?MytLUXRhckw4SUlYbkFrMXltV3FGOFk2YlQxWCtSRVNoVWJRRHNuUnNsZmVt?=
 =?utf-8?B?Z1ZISUtnaS9XTVU3emcyWUxBeXZRZ0VVdGZWckZLaTdRSUkvOHBEWG44Zjd6?=
 =?utf-8?B?UUQyeUhXYWJuclZqRFdRSXMySE53TlNkVVVtc0xxa0lsRzNXdGh4MUoxNng5?=
 =?utf-8?B?QllzWTFvRTh1OXRIN05ub0FSRkdWVnF2b0FpS2dUSCtaRHZaRG5ocEpqQ3Ju?=
 =?utf-8?B?b0ExQTl1cG5wZDNoSnJiVXFTZnpTdHVVVmFDYmJLM09sbjd4dzZOUkxpcW4z?=
 =?utf-8?B?VlVSZnhqcnlkczVGdDRwdTNvd2kyWWRFQzBqajQzWnQ4UWQrVjBQUU1ydUcz?=
 =?utf-8?B?Z3hSTTlCNVRpbmwzUXRqZnJuWk5ZQ1VFMEs3YWZIMDdtRjF3T0lmc3ZydkEz?=
 =?utf-8?B?OVF6aVRjNEVIRTRyWTZ4aWtIQmEyczNWcTVSNWlQNXNOZlBodWFPT0tXWHVP?=
 =?utf-8?B?V3ZjU2NJTlgyVlYrcEZDN2U1WjA4d0xUVTZLY0FVUnJVSmFZRDBwcmdXNFh3?=
 =?utf-8?B?OEVRMEdyczBneEd0Q2gyNkpyY2RMcUVOTTZvUnhhUzkxbUlKbmhEQWRmeDNY?=
 =?utf-8?B?T3gzUWxzT0dXTlVXcVNKNzhuUFdCT2w0R1BOaGMvbEVnc1JOc0tLWUMrTlhx?=
 =?utf-8?B?NXVNNXNPZzFoZEZxeVpvT1FqNWliVXp3MEJnYWd3ekdaU0l1clNCS0xZaXZ4?=
 =?utf-8?B?SkprTEEyMDJDN3BFaEdQN2xVbStoY1BpcFd6NjB6a053ZWxEeXdOOCtkV1E2?=
 =?utf-8?B?bEllcDAvTzBrdDJLbWF3c21oSTgxdWVXaEpwaU11cHBLREM5bFk0T2tiVWlN?=
 =?utf-8?B?MTByOGoyMWw3NjBJdnlPelNodi9GMHdpNElCT3hxL0tJeFNMa1FqUExhY3FE?=
 =?utf-8?B?RGpaWWJwYkZLT21lTTk3UThYbkEreFpsWkxISFF2QjlNakxhWnVuakJHemtl?=
 =?utf-8?B?c2t4ZGpIczRqUVNPdWFsMmh0VllpeDZQTE83QVJCV0l1aVlSNXFxNHZZdmZu?=
 =?utf-8?B?RS90UGNYb0V1WExMbTRWZ25Pd2xQdmlYRWNka202MzI3Vnk2emV6ZW1yN1JW?=
 =?utf-8?B?aGhTd3ZFNm5XcGhuM1RFdnhTNnN6VmtZN2ZxcWd2a0F0SU1JMXJ3ckI0M1dw?=
 =?utf-8?B?TmZxaHN2QkszcERZRGF2T1BwcVRiWlNNZEtnWW9kdE01eDRDWElvN1RUQ05p?=
 =?utf-8?B?RGJXSjVid0cwajdVWm9yUU9Ha3hQVVdkNlV0a0JsWmxCOWkveE5uaXJDUktY?=
 =?utf-8?B?OFM0S3NJWHUxd09jWUlGRnBiWjZYU1gwMUVIczFvQWJYNEVPdGNoeXFQSk9w?=
 =?utf-8?Q?iKe9nXh6i0iu96TlvPpMocIfp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10D92307C87A7146AC0BF8425E524B65@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f955e0b-61be-47e2-3401-08da9674ff69
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 17:17:27.1647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InJVXHJfeu7sT4VKzdHR75F2C4umdHPKQQlTCHCzaM6RTgwTaSChBvtkX9SnkhcM4qfuof5zTdwxYMws0cGAHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMi8yMDIyIDE6MjEgQU0sIFBhbmthaiBSYWdoYXYgd3JvdGU6DQo+IFRoZSB6b25lIHNp
emUgc2hpZnQgdmFyaWFibGUgaXMgdXNlZnVsIG9ubHkgaWYgdGhlIHpvbmUgc2l6ZXMgYXJlIGtu
b3duDQo+IHRvIGJlIHBvd2VyIG9mIDIuIFJlbW92ZSB0aGF0IHZhcmlhYmxlIGFuZCB1c2UgZ2Vu
ZXJpYyBoZWxwZXJzIGZyb20NCj4gYmxvY2sgbGF5ZXIgdG8gY2FsY3VsYXRlIHpvbmUgaW5kZXgg
aW4gem9uZWZzLg0KPiANCj4gQWNrZWQtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2Fs
QG9wZW5zb3VyY2Uud2RjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEx1aXMgQ2hhbWJlcmxhaW4gPG1j
Z3JvZkBrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYW5rYWogUmFnaGF2IDxwLnJhZ2hh
dkBzYW1zdW5nLmNvbT4NCj4gLS0tDQoNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
