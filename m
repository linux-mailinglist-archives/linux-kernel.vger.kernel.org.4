Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A525B8E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiINRTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiINRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:19:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA5483F26;
        Wed, 14 Sep 2022 10:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0pcceXdSMJzNKY/PJZQsNKzvKUCQlDE6x4ROV6PzOBbDIKUc2ca/ITHFBpYfapBTfpScbckjEfzQYJCAWZ3W/NZ9Njlap5t0M9GkUXjKdycXh7DQVkko3VhISsRDEuphNTiOanVcEOOZF6QkfxLbzNzYS7N7pi7+bHvhzkHA6slPYT6Abbh+Pd/jmJWNVthGNbDw/Gh+04Gz+xZadgBWUxzC9Wfizs7OgJZtaDvor5zTXJfBsN8m56tCkgd5zanHlBCcLu1fuBRjHq5J7yV4VtH+K2JNR9xFoHtLm6qOHChr3l/ji2mKjMqr3CGFHJ4VDnhR9OeyfGHuB+T7IXPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0zC9WOMqxhltlBxEs0hIGYi38u2ak6wO3S8FhjI6ik=;
 b=mTlBvIb4Fttc0jd3L1HrR92yO4Aaxsex5k/8bVOxhzB+J6LB4NhvhYSkLTPofaAXDCAAsk+IpmrfqCvJdQz83PbvmKTWylj033XoRk7J0+KmPjJ/fEcd1C9HljbiIPu4c2fGjaXs8BeVEGQKc5KZvGIYKqKF97DaxHVUw7gI8pILsIQIumpHbGU5XygvHHGPMkmxQFGV3Af6xMeiV8RMpE+HkcVSSIUiIw9r5eq4rtf2PnnqX5/UFvtQ7aoohmSkEgOjSC/gnyeKSGrKzMGdInQxWzhrMHfMs1fu/cmoyGhsigZdr4RFRXRjH2+EAKT1S5q1OXdw9yk2ZxYN3hgabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0zC9WOMqxhltlBxEs0hIGYi38u2ak6wO3S8FhjI6ik=;
 b=i9Oa9+4u1DSMJziAn3W3Nn629vSWWFcMvXhdbbgsVbA13vnCel9H491lJZxRII/jgNwOf4KJ7gbBtYKtd69qyLWovMX5yikwcebpUSqSBzmsdqeKxTZhf2P2c04zJqarUyKoxUYW/9x6EEmWXlM/VBdJFcmM9y3pSPKWI7yR6K0VCHa7LTg3ZKCLQ4bXdhw/YZ+zM42theQsFm9K83vGo0fM6Mmdt9+i/5xTFl9m88V+VG5GNsfrUgozjQg/KhgunyeOwdGTaO9irmBOqBQL7VT8WfKddwwmMCob+NaIlFFVQEhJPnxTaxnjdJNS0iv48SaNRtiR3WL1iLMTvcqlLA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 17:19:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:19:10 +0000
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
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Subject: Re: [PATCH v13 02/13] block: rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helper in blkdev.h
Thread-Topic: [PATCH v13 02/13] block: rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helper in blkdev.h
Thread-Index: AQHYxoDj8lt8KCHqYkOsN5anCqHqtK3fLzIA
Date:   Wed, 14 Sep 2022 17:19:10 +0000
Message-ID: <b0eee029-4e9e-e522-ddf9-295782d2f934@nvidia.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082207eucas1p14b1bcefc6045a0a835e83db8ed810d5e@eucas1p1.samsung.com>
 <20220912082204.51189-3-p.raghav@samsung.com>
In-Reply-To: <20220912082204.51189-3-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4142:EE_
x-ms-office365-filtering-correlation-id: 212a8f5a-090c-4370-350e-08da96753cee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTYZaXZEok6uxgSkJAzEVVAWZ426PB4huM4l6NWJcO1sKl4sdG7xoQqZYqMx978n9LsYNKzeqEQXu/9gIEZK+zPHQvU1HtBmsfWykKe4md33ws0SwzqSrjtCWIWHk0q1BIL2RkIVpIVdw0QQMdNYokqbPOiYZBICJ6KLmMzxC+x7SfJ8u6bTjmFNkzbH4XJY8/H20sJt/by7CliDEEr8NvIQ5MkBpIXCuXv1G3L1eseN9yjs93VViU9OhgQQTSCs/hkXVCcZdoOVoqBXgNFU54DBeyKCneJCi/jBFMmITGO59ihOyYyUAOTSeYGHNePZAeU+QTqp0FYke2YZMJGGsLay7JJ/o4HcBdGRr52JdwWCGVCRM0EgJOwT2WL04hkvKHeEoIKwa7rNcQoiudWK/tDvULRh91IYiNh7FFdstQmFLT+O4L19p4S9T6+Jujn6ypDREsuLUE5qvXcAcZb7wWDOwrw0KRsJF4VMDfvW5x00XrKkXO+1iV3P6BQ3Pbct4xuPzyWOJap+m5AYgi75sXXxskeQZ69UDH/e5F1dVs2AcM9C0s2m256N/Q1Z2PPOukTOCXSqIyRn+FEE8t912d259fj0qEBTn3TQ3Rwfsn1LDKGY6sjnLNqVfyWBi+xfF9cHiDnD71VrnvFLhyL1Jkmes8QU3WaFqAq5xNcdBmDmENZy/pl2jSNXq4xlAC4Cwq2twS4oXJx4onTbXxnlSjfARHVbIZciUzkJol7xHEBGAQ3g9V4nSyNviKFJcCIO8k2Am8rHgKHifQzJJS3qTAPZLY1AnTaPaH0ZoUmUEbhBfhYu229YwS0/wkuPD22I8DLHo+1FkqDMpDBupDrX3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(6512007)(2616005)(38070700005)(66476007)(4744005)(4326008)(31696002)(41300700001)(76116006)(66946007)(316002)(26005)(8936002)(2906002)(36756003)(110136005)(71200400001)(54906003)(86362001)(53546011)(38100700002)(5660300002)(91956017)(6486002)(122000001)(186003)(66556008)(7416002)(6506007)(478600001)(83380400001)(31686004)(66446008)(64756008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wmh0dGxKbkYxVnF6NFBBQTdxendSTkJCMWFaQmZGTjlKcUhXYUpYR09OYUQ0?=
 =?utf-8?B?MWtwZnM2Zit4U1R6bmZOSWJnQklsOEpvb1hzWFRmMmpoVko5OVFxSUo5MWNC?=
 =?utf-8?B?QVRFTjNxYUMyRkY4Mkk0elNxNWlNQ2hPSWpUMjZwclR6a1RReEVkTEJNMjF3?=
 =?utf-8?B?SmR5YUs4SUFlRTk3SytsNlpBNHlTZVR1UDNqeVJGcWFzQ1NjU0RPRWJ2cTVx?=
 =?utf-8?B?WkttRlNMQyticDhTRE9wRFRiamVOdFc5aGl5M1lHNEhrSFp4VVNpdFhWNlBX?=
 =?utf-8?B?cW5wUzNGZ0x1cUd3QjRGQWZtaTdCV2NFSlM3ZXBkWWVxamNZUk43TUtyRW1V?=
 =?utf-8?B?RWpBb05Pc3BFVHpzSlM2bHQyWUg0QzN4QmV3T05saFdGeE5XK09IcnBrRGRD?=
 =?utf-8?B?MHFjaHNHT2FBUFZoSC8zQ3VpNmVDRGgvbkw2RnA1cDcvY2hrTVNTeVE4UVFR?=
 =?utf-8?B?MCtnMDZRRFIvS2VLcXA2UjhXMkdwTENrMjUwVXBlVmJGcDFvNWFDOTJPUnVw?=
 =?utf-8?B?dWNaWG9xRzdmY3ZwWnhqcmlFblQyY2hMTDlkOHAwN0p1QlVhZk9SSUVjcDc5?=
 =?utf-8?B?WlFxN29mandnTE83ZTczSlhjNnJqSERzdWRMdzRoSm9mOWNqbzJmdFpMVERB?=
 =?utf-8?B?MERoQ3pQTE9CVFNlejVteFF6dnBQWE1rc2VZYUczWmd6WHhHY2NXcG03OExr?=
 =?utf-8?B?UEJrUGh4dThOTDRydGVlcENsTCtmVU1laS9PSFNDRkpjWlphUklTM3ZUTFRX?=
 =?utf-8?B?YTFTUVNJZmprSXljZWtJbEIxU3Vqb0FaWDhoSEtieEhpWWdlUzRERmN2Vnl5?=
 =?utf-8?B?K0h4WnBmYytSV0dYa2tPQ0YvdGJRZVVVVTRHbWcybXFGUDY4NC9PNEV4RUpY?=
 =?utf-8?B?SnNqUkNyMlgrMEhQSS9YbzZJYm1JaXlGU3JIMytCVGg3VGFMZU04OHpaYXAv?=
 =?utf-8?B?Q2hoR0k5UU9WdXZrMjM5Wmx2YVcxSHVBVlg1VGJFVk92Yml0WGhXZUNLZkVi?=
 =?utf-8?B?Y1hUQXRHbHlnLzdhNVMwR0NKTjNEOFVJQmxRc1N1b2tsUS9GTElub25HZGVl?=
 =?utf-8?B?VjZDMW5YRGlaZUQ3VmVaa0xacC91ZVo5K05TQXdhMGtEeE05azVhMnM0dTkr?=
 =?utf-8?B?RU53VXlRRjdJMEw3SW5nMzZoa2tPcmszR3RSNVdjWFZ3TU81ditVSDU2RmJj?=
 =?utf-8?B?RXVOMnhQbTloUE9yODVxOVdBbXk3d3hnbER6amQ5UktqQW1uTUtHYzVKOTNa?=
 =?utf-8?B?ZS9iYjdXQVcxSXZ2cmlPdEw3Qk5FVlBkVzJLenJuaDdJMVk4QjhING5RdDFx?=
 =?utf-8?B?TFpySXp1b3ZPODFMQU5VQUZ1U2JmbDc4WjVCQlNvZi92UzNLdXBPVlJ5VmFh?=
 =?utf-8?B?cXFrL3kzQmgwbFVpWC9nWWZ4QVBlVzV2T29TT3BSQlRkdys2NGhDeGt5TFZt?=
 =?utf-8?B?SHBhZjMvNCtuOWlINjJ3alFvODVTRGhvT29MaE9tY0lkQ3lzK0tuYmlnemt6?=
 =?utf-8?B?dWdjb2dpZ0ZlRFNmdzFnaGFaK1E1b09kdzVrSXNYakR1MnlHVjNPT1Nib2xv?=
 =?utf-8?B?dDN3ZXE4c200OUNpSUFvd3VVcU85ZFhVMzNNcElIdlBvamo2TkZJS1o2WjJo?=
 =?utf-8?B?cEhFT0NkQnBpWGdnVGU0ZUxBOE1MditIK2YxWjVjTUFOaEtHMlIyb1NsMVp3?=
 =?utf-8?B?ZWgvRVFJZ1dmaFE0bGdpQ1AzOXMyNEVxWlZWN0JGSUZGbnBxRFU5SmdyLytV?=
 =?utf-8?B?WXZDM0RzUGZ0RWJtRzZ1Um5vV0F4V3ZqQURudTMzU3dLaHdENGo5WXkvZFpN?=
 =?utf-8?B?b3VoazlVUWhJeGJvZXRmcnR4R1VnNUFaSnkxa003UGszN1dxVXE2Zm15WWNY?=
 =?utf-8?B?WFdBeHhUSjJDbU93a3AzTURhYkFuVmFROCtJNmNielNZL0V5MEVOSDNVa2Jv?=
 =?utf-8?B?QmlQem1pNXpEL2hNdkpmeFhMUEM4RjFFSEdEK01OQ3RrUjNxNThpNTNYTUtF?=
 =?utf-8?B?NnNjanBFSnNpY0ZEYTdRaU1PK0lHVVFJS2pTaFhvZkY1a1ZzMkg1dnpqRFc5?=
 =?utf-8?B?S1o1UXo1b096azBtd25BSnFpczNQTTQydmFTc3ZEUEx5UGltSXpDQVhFZmMy?=
 =?utf-8?Q?bsy4WK2kxd/g0Hcg/GmJhxb8V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7C952F745BFA542AA1DA88456448300@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212a8f5a-090c-4370-350e-08da96753cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 17:19:10.3618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxbvtSmyVx79lnH+l9nujttOpvj04yV6Fnzbpv+ch3skPceCaE+NSxoFVsKv+tVHpVwBFkbRDdFo+FNMaDI7WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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

T24gOS8xMi8yMDIyIDE6MjEgQU0sIFBhbmthaiBSYWdoYXYgd3JvdGU6DQo+IERlZmluZSBiZGV2
X2lzX3pvbmVkKCksIGJkZXZfem9uZV9zZWN0b3JzKCkgYW5kIGJkZXZfZ2V0X3F1ZXVlKCkgZWFy
bGllcg0KPiBpbiB0aGUgYmxrZGV2LmggaW5jbHVkZSBmaWxlLiBTaW1wbGlmeSBiZGV2X2lzX3pv
bmVkKCkgYnkgcmVtb3ZpbmcgdGhlDQo+IHN1cGVyZmx1b3VzIE5VTEwgY2hlY2sgZm9yIHJlcXVl
c3QgcXVldWUgd2hpbGUgd2UgYXJlIGF0IGl0Lg0KPiANCj4gVGhpcyBjb21taXQgaGFzIG5vIGZ1
bmN0aW9uYWwgY2hhbmdlLCBhbmQgaXQgaXMgYSBwcmVwIHBhdGNoIGZvciBhbGxvd2luZw0KPiB6
b25lZCBkZXZpY2VzIHdpdGggbm9uLXBvd2VyLW9mLTIgem9uZSBzaXplcyBpbiB0aGUgYmxvY2sg
bGF5ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYW5rYWogUmFnaGF2IDxwLnJhZ2hhdkBzYW1z
dW5nLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQG9w
ZW5zb3VyY2Uud2RjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFz
c2NoZUBhY20ub3JnPg0KDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQotY2sNCg0KDQoNCg==
