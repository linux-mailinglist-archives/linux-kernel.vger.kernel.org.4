Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE706109C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ1Fgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ1Fgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:36:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73F514088;
        Thu, 27 Oct 2022 22:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNEg8hHL4vlpbPrxZ85hGpWbvqC+E/xjQVF1FRazfh1p6ySeYIhGwz9kbWe8icsV33tDoWw0oZn88WddTmKq9/gg0Q+dl5kGoAWaYsfmS0J8vl2IiJILCthoGukNwJy03CJ+XO5Bv0ffjeA49W9ShsjvCSNSO3MeU7i6Gm40TDFMTuiCN3j4eCfPnlo35mjbOLK9gHms+gd0BEPp6ehXq2EI8nsUkvwZqKLH+pom9/1LnLi5yjuPNt4/yeXgjZejgXoHCanhXfoLRbEhcN2aW5P5HygiE5CnzvOCjbhCXqp3YIJFLwcp07z5q+vPOy0rPyUqd/LOtCDSHvN4etM+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7sSeSBQSSmbcNibEItmgpqZwO2rr8khx0qhkf3yzNg=;
 b=KKXQ9y0Yf7JfRyHduk0ltv8b38mGujYXEzMf6Qy9AdQuNuvi7A/Oh22hHqLuKFFWh8KxMcvPVVYNvOe4Z5wNP/qUQZ96cbt5uu/v3MJGxRshCE7GAUVe4EOjA/QGJDZweF2ADyA3dSF3X7agtgLOV7u+SwlV5D7ZiCmJuw+VDCKMFrVpjgNbv3bKKKt6G4ERwQLM1OprEGNcsSYUPx3kJvmcbMXv1Mha1SQKya7GI6vFwwYfRqL009I4XT1Tb4SDoJ5oyg2EPQGOehLPav34gdwvqPDIyvj2k+REDEO5fgja5UK2P10IOvk67OMsKGtlzuK3pC2yG3s91QHLeHl7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7sSeSBQSSmbcNibEItmgpqZwO2rr8khx0qhkf3yzNg=;
 b=B/1WrXDK6sZy7LxvxPs6S5HIYei26f40HQIEvgdgoeMElTLscfFrk1Ep3pyGGqRYYaZknmapDtUURHxIe/S70uWoQ/QIEI4PjqVsQS9mKFjFYY+V3rN2hhjNPcg+TE9dvZMIfUaFs3utEJ7Pk4HA8GOGq0Plx7g3dQQriEkmB2SnLYPwf+IGjib+BUOr+bjop/Ya9gq56pSAQKCFnHMQrktxCJexBrLblZF111rN7ip6SgV2rdyKcKiUHUIeA4gXtSgVBBgFrPDsXWuqd3b40o9SPmEc2dslvh+aCBILbTf8cD2CB3zyZdsZUPe9VIg8qhyG7eFzHh5ULPz73AI+Gg==
Received: from IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Fri, 28 Oct
 2022 05:36:42 +0000
Received: from IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::ac89:2759:e558:ce6]) by IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::ac89:2759:e558:ce6%7]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 05:36:42 +0000
From:   Jim Lin <jilin@nvidia.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] xhci: hub: export symbol on xhci_hub_control
Thread-Topic: [PATCH v5 1/3] xhci: hub: export symbol on xhci_hub_control
Thread-Index: AQHY6gh46rv2CS48OEa9DCbRUnopZK4iRFIAgAEGHYA=
Date:   Fri, 28 Oct 2022 05:36:41 +0000
Message-ID: <3c3b175d2031b8e440bfdef9b4c23c0272a5f607.camel@nvidia.com>
References: <20221027133127.27592-1-jilin@nvidia.com>
         <20221027133127.27592-2-jilin@nvidia.com> <Y1qOhjOXM4sQW+a/@kroah.com>
In-Reply-To: <Y1qOhjOXM4sQW+a/@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6603:EE_|MW3PR12MB4521:EE_
x-ms-office365-filtering-correlation-id: b16fbf29-75bb-4769-5736-08dab8a664b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r2vggGFDBuTnsUvH/ClQhXqDkYktWhUsl4Gf8KScrQ+JD0TeUQIuMWFmouaptN2EF0JaJnzlGdPzcPPhuCa4780mpqfNLLVX1mJMWyEJs0XwnLOkeXaxBPd51+nvpeacfYgGCvMXpYRL4mlj6i49ukt73+C5UPjE5J7Eoqj7b/SePPSfPXIAwJ7JkRTHLhS3mJna4nPZuU0Z9jjZ7QZDr5ylT2Lomw7XkAWN/bG3FqkRwqxzsnXx/P2cDuCWcnF4FrB/YD5N9iwPZcMS/Jc+dpBpV0sq9L0mMdbL69M0ueDgtX3MNVk6LJojxznmGBGfrlfz2QJgDK/543HuXjmklHZLyCjXJMVpC72xDSnzfyJjAvlhFaBVhMVLZQWlYQCKXEJ3Rho8VR3eQ+GPRTCG7yVYvqIxlji47zUjR1Ot90/Uq2kpeQPVe3dSxEb2olV+oOa4CyS9RogzR9+6L2H7Lx6tbAzBTKJknPySPlbWl9FQOzwmkwV78oNQtfLixDQ+gzX/bLOjdkxfs+AQNXi7SaWrqjgURP5QzmC5nA3OU/S3T5jzx18kkqNzy1J+V8Sa5BuQiGH2Iw4IWfpcGpYvwoyEVYogrszU7NVSGfUSSaAyRVCuoFJevnrPevP/fOz2LyTdWYReOndP4hfHfAQh+fJxkrg7I+rWnigsc6QIzxyiXMWGzK3SciOuIEyqobxKDiN/14xGxLMpOiYBgJqzrE5ijD+li86YdSFav0+JHBp75wzN5LECQC08JdNqdFABg+Mo0aqWfLJjI17YcCg4tS2TvtfPDJlYZya6QQ1+6mY/S7BYdzSgL4lojv2zfaIr3tikIvawIBH6XqL5eryx/gKG9oNCZydvXiRBop0R35gY/fayAyYWR/0GFOix6Ngf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6603.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(6486002)(54906003)(36756003)(186003)(122000001)(4744005)(8936002)(2906002)(38070700005)(86362001)(71200400001)(5660300002)(26005)(316002)(478600001)(91956017)(6512007)(2616005)(966005)(4326008)(66556008)(66446008)(6916009)(66476007)(64756008)(38100700002)(4001150100001)(8676002)(76116006)(6506007)(41300700001)(66946007)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGM2b292MFFKdUNoMkIrUFg5Si9aVjN2YzRLVmdsWXpaWWpkeVM5V0laaitv?=
 =?utf-8?B?clZvZGlTYy9ZSG5XMEhmekRDWVlvWDNrZHNjS3dreVlpNThjUmt4czhPenEz?=
 =?utf-8?B?ZFhsY3VYTjhnbnNqdDdCOEJRSmNBWkZ2NUVQakYrVlVXajFOemVQbDBkZEhY?=
 =?utf-8?B?WjVZT1hUMHpXbFFlODNjQzMyelZYTWl2WnJUNGdTZVJwNHR0c2QxTVl6bGNx?=
 =?utf-8?B?d1pFMk1KY0I4aVM5cUoyTXBQQVUxbmVLQm9XeHhJTHJzZzd1MnFFemJyTW42?=
 =?utf-8?B?YUpPWStSeWQwbVdld0krdUdqVU9razJlZC8yZTBqUzR1RjN6OTl2bUdHTEJy?=
 =?utf-8?B?a1hYc25sQkNORlRCUUhUdE1WbGZuQ3ZiVWo2RUwrUEJrNW1temg2VWxpNmJj?=
 =?utf-8?B?NVhFMGJTTzB5MklSdjVVcnc1NlNoVUxEbi9JbzlocG9SWmVFeGE3Wnk5RCtB?=
 =?utf-8?B?d214RDBVU09Ta3JYV0VCdWIwQzI4a2xpT0YrMVB2RkhFWW41b3dZOS9rR1d3?=
 =?utf-8?B?NUxWMGdBc2l1Vkd6ZEZUUHdaMkN2VWlhbnFXTUs0SWNoSGtCQTVYZHJPWjN5?=
 =?utf-8?B?bGlJYXBYM0V1UEovaFI4TTR1STZGaFVxczBqYzRjUUVFajV6QWJLSmg5anFC?=
 =?utf-8?B?aGh1OGVWSWVucVRMdDR3YUlid3UwSTh5MVpzZlJkUGk2OUt4emF5Zk13OU1N?=
 =?utf-8?B?WUViQUVDWkpteFozRTNNZDc3cDFyWVlKVUxaN2VwL3FjcGVzNGhVVHZUNVRZ?=
 =?utf-8?B?V0dVS0g2eG9lVEJtd0V0Smh6aHd0N1BNRGhsQnkvb0V5UDVsU2xNNDlSTkhu?=
 =?utf-8?B?YUVmUHhrQzFUcG9uck1ldFNFR2ZXWXpzMTVQdkV5c0ZkZS9OZHpxamdCc3VF?=
 =?utf-8?B?ZVhESy9hMU1SMzExYzZ2Y05TZGJpbDk2dUJPQVZWVnVpU3ExMkswMThwd3FU?=
 =?utf-8?B?R0hpTVVhUlBnVklqdWNZbzJjSlpRbmQzTlZqZG50eUVDWGxxdUN6MkRtY2FN?=
 =?utf-8?B?ejAvSno0c1ZiQkdRNTEzajR0VHRiZ000UitsOXlYR2FZT01QYnNzZ0k0bHJq?=
 =?utf-8?B?MzhadEoxQ0czRG5NbDdVN2ZDS1NnZzQ5S0Z4UHorQXprODRHYkdQZWNXTkNH?=
 =?utf-8?B?OFZ2dmtKUW9FcEUzUElhR0dBYzJDc1ZJM1NnbHBJMkhGQ3Q0d05Fc0RQT043?=
 =?utf-8?B?MGhvWWlaSkpETkR3bDBiK0ZvREFNaTFIUmp6QlYweGtlMmdSTjRibDlKOUVy?=
 =?utf-8?B?aDVITWtKK2Z4YkRwQUNsRnU1aWgyY0k0UVd5MXpHRFBSOU9VSVdYUkF3YmIx?=
 =?utf-8?B?emdiVDNvOVozQXFzWXQvYkxYV040bEtCcytlODN3ZElvbG9VdTBsR21nNDFj?=
 =?utf-8?B?YU1ZUloyQ2I5RGJZUmppWElobFVNSy92YUpwdHBIUk9FaGVTUXBwbENEZm5M?=
 =?utf-8?B?RVRxRnRlYXovN3Nmc2U3ZlVicFord2NGc0JGM1M1cUdwSUI3MThhL3l3Tm14?=
 =?utf-8?B?NUNna2FvMXdwbzRrRlZCdlRESjhRMUJWaG9nSVBoNkt6ZWNEUUkydnBsNUwx?=
 =?utf-8?B?NGx6eUM0S0dPdEIvTVM4a0cxUk0rZFhGNkFYSlR2endLS3FnKzFBeEo5dkty?=
 =?utf-8?B?MUdVOWRBUGdPeWtKd3IzWEhVak1QTWlxL0FHYndwRHd6bStOdUFqSGF4VUFQ?=
 =?utf-8?B?QkxGK3NqMXJLOVpWNWs2UURZMFJrbWtmSmhWUGN5LzNBekgvWDI3R3I2VkNH?=
 =?utf-8?B?WHhtTElUZHVhK1luMjIvR3RrOFM0OVUvT2RRV0NhcXpVaW1Qc0hKN2E3REwr?=
 =?utf-8?B?a2gxdzg2M25WWm1BVnQ5bFo0aCsxMnp1aDJxR013b29uUk0zc2tXYkdFRkln?=
 =?utf-8?B?TGVjaTdFYm90TVcwOEZZT2w2QkNyc0dCdHRVMmZXa1dLK0l3S21hNEpYcGZC?=
 =?utf-8?B?aE1CKzB5RWhKbldMY1NxUXRtVlM0S3ppcUdNSUpoMUN2TkNUMVViQ3pkbFIw?=
 =?utf-8?B?RW1NN0pTWllKMU5uOE82eTU4NVByYytaTnZMZXNnYWxmT0RzVmh2bG0wU2lV?=
 =?utf-8?B?NEhwbGRrZU1YelV3eXA5TFNwZy9VZ0U4MkNpRFErZ2JKSE9IOVhzTGRnRU5M?=
 =?utf-8?Q?EWPlkf2CZ+NXu0QahqaI9Usuc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52BAD787651EDD4BAB52FC554DC55180@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16fbf29-75bb-4769-5736-08dab8a664b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 05:36:41.9278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8l09mJrWPXZ5RB/vwSu84yN8tymUz9SVyy2XPOX3QOKKsgtxbzTatdjH/24AP+AOf67Qmwh1uAJUybMw1R2cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDE1OjU4ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBFeHRl
cm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiAN
Cj4gDQo+IE9uIFRodSwgT2N0IDI3LCAyMDIyIGF0IDA5OjMxOjI1UE0gKzA4MDAsIEppbSBMaW4g
d3JvdGU6DQo+ID4gQWRkIEVYUE9SVF9TWU1CT0xfR1BMIG9uIHhoY2lfaHViX2NvbnRyb2woKSBm
b3Igb3RoZXIgZHJpdmVyIG1vZHVsZQ0KPiA+IHRvIGludm9rZSBhbmQgYXZvaWQgbGlua2luZyBl
cnJvci4NCj4gDQo+IFdoYXQgb3RoZXIgZHJpdmVyIG1vZHVsZT8NCj4gDQo+IFRoZXJlIGlzIG5v
IHVzZXIgaGVyZSA6KA0KPiANCj4gY29uZnVzZWQsDQo+IA0KDQpJbiBhcmNoL2FybS9jb25maWdz
L211bHRpX3Y3X2RlZmNvbmZpZw0KSXQgZGVmaW5lcw0KQ09ORklHX1VTQl9YSENJX1RFR1JBPW0N
Cg0KSWYgSSBkb24ndCBhZGQgRVhQT1JUX1NZTUJPTF9HUEwgb24geGhjaV9odWJfY29udHJvbCgp
DQosIEkgd2lsbCBnZXQgY29tcGlsZS9saW5raW5nIGVycm9yIGxpa2UNCg0KRVJST1I6IG1vZHBv
c3Q6ICJ4aGNpX2h1Yl9jb250cm9sIiBbZHJpdmVycy91c2IvaG9zdC94aGNpLXRlZ3JhLmtvXQ0K
dW5kZWZpbmVkIQ0KDQppZiBwYXRjaA0KIltQQVRDSCB2NSwzLzNdIHhoY2k6IHRlZ3JhOiBVU0Iy
IHBhZCBwb3dlciBjb250cm9scyINCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LXVzYi9wYXRjaC8yMDIyMTAyNzEzMzEyNy4yNzU5Mi00LWppbGluQG52aWRpYS5j
b20vDQppcyBhZGRlZCBpbiB4aGNpLXRlZ3JhLmMgdG8gaW52b2tlIHhoY2lfaHViX2NvbnRyb2wo
KQ0KDQpTaG91bGQgSSBpbnRlZ3JhdGUgdGhpcyBwYXRjaCB3aXRoIFtQQVRDSCB2NSwzLzNdIGFz
IG9uZT8NCg0KLS1udnB1YmxpYw0KDQo=
