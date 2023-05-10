Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE36FD3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjEJDDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEJDD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:03:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2050.outbound.protection.outlook.com [40.107.113.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9941724
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqjtr6zldgCrdynjVX5itxkIGo/j4zQcGpe8EaJwD8JzD9urM6JqkBC+Au3zunGgxonRa3stpAq2LI7BFRvUsuGMLHkbGwMzzaxw7kbA+DD7NlxhSjwqYZuP7s977vPYHWc77B3ju7HYtDpMXu78rOoPt6iew0CTleRlCsBHunTDkNEhTciQRuiVvNaKWjMdAyZzzxU7oF6BTVWYJLa0n2lmOGU+lw0jtYStkjxyzYgQLR0MqtyHneBp0c7ScGMjmhm0lT8/0+IjvPi4GQC8Ln3SmeIIrlVq/AU4PWvrmf9lq0Exc+skbjwDJNmEzLSfY71UKvTffS6wngs3YVx6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu81tCfqX1IVHeOs5RwHZ9fDM68Kv2FeokDdIPKMNvA=;
 b=FcxHXrl+O/zqCg0Uz3O32t5bWl/Q9ivQ9ETDVKU3JRjatKsKSjhLAXAMkMC5MNBvpnpNrMvtbNUHI0qaIsHNmFFeU7L2QnX4fFGejWHJkwlW/J599NGb3FKE9cFT558FZByKR8v1FqxObBOyQba5eTiYBd7JTWfR28Iih5sCeNnFlfdaZLbsX4ec3qURDIGoX42dCHk8ttxYixj3YYNQvr1uIKiiaJ4Dbmyzi3vynsI7XMdum6hto1ndUUmxSxhwOYjo+x0RsQEaH83DFoO5G3N6Ry3pSPs4t+r3+ItQz4WW9wUQkqBtT262EjHNXqAEYmxx89Y8QfW4NEHQS1mXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu81tCfqX1IVHeOs5RwHZ9fDM68Kv2FeokDdIPKMNvA=;
 b=fiUW3C7RMU1lB1NNWFBQdDAKfPEuq5InwGyd5Ygy51Dw4xakfwLlt0XDNFz3v7YDJLeOHyAZ3Szgq7SkfvFEgraIFWyMOyR3KoArf6JQCvTuR+gykYe2E/+pS7m/gemgur7YtddKFqEncfYbQW+uTgLV9Jkcxh/YBZ2MmpwXR3k=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB11796.jpnprd01.prod.outlook.com (2603:1096:400:370::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 03:03:21 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 03:03:21 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: memory_failure: move memory_failure_attr_group
 under MEMORY_FAILURE
Thread-Topic: [PATCH 1/2] mm: memory_failure: move memory_failure_attr_group
 under MEMORY_FAILURE
Thread-Index: AQHZgZ+jOPb53B42WEmli8dwXIs48a9S1LKA
Date:   Wed, 10 May 2023 03:03:21 +0000
Message-ID: <20230510030319.GA30737@hori.linux.bs1.fc.nec.co.jp>
References: <20230508114128.37081-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20230508114128.37081-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TY3PR01MB11796:EE_
x-ms-office365-filtering-correlation-id: 1b9c68c4-6a56-47b8-f274-08db51031cf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMEGuEhduZc/NDvIobO3FWYJXTsLfx45frCbYC1f2UpsAn/57vBGAEE1VUVu5LV2hrQulKAgLFIHj4oOtGDzeZa7LsS4kxWoFAgiI8ThROdey5bz69VJlvVaZZJ0ybCD0GvqLCR8dEFs9a4BAVx+OSFNlpE3dgO6mccKZbbn/6QbMk5/X4yIH6kdR4DWn6a2ugoZ7ciqdx5hNWO9ER2R/RhjGQvbT555D0YI0Pd5NdXY05MJc7usWX49Oa4DMwGAitXSNuc02CYd/golvkIOQdoaxl2VPf9u4rr2on1rjEci7r+b7JYpG147dYlQcSlXZ0HQ9QhOQlZln9ABjXSDUJrVo8r8WUu470Z3PiafvOqqpd7s/7RShmPfOPBBZcHK03OFY7XGtIsNFmY7Bl/c8fziapA4ow8t/Bj931leaQz6Q0pBsusLyFzewaf88obEC2JJOfexDSURJZhkfBueOjEfJ0lFPHQFnMLFu1gr2Y2ez5a2zGI/1fb7Bx3molBoYJTTSaQlvCLt7djRp5y+Ihxo76uCZ5sdpfUcfYnBKz7YUoXmjDYT1veDSODMc9YVSjYT/poquOOw7IOWsY4/vE9edeqiln2RcUIu8FHEfp5jSxefbQWoTcaXmJSnu6KM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(122000001)(33656002)(41300700001)(2906002)(558084003)(26005)(186003)(1076003)(6506007)(9686003)(6512007)(5660300002)(71200400001)(38100700002)(38070700005)(82960400001)(8936002)(8676002)(54906003)(85182001)(478600001)(83380400001)(6486002)(86362001)(66476007)(66556008)(64756008)(66446008)(76116006)(66946007)(6916009)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clhnYXhSanFvZFBNZElxK3ZPZ1J4K2VwRHBwSEFkcHJTNmZEeVc0QUVXVUdV?=
 =?utf-8?B?R0FKK294dSt5cmV5Zkc5RVM1VUZJdUQ1SUc4bFFDUENmNWYxbVhhUnc2NzFL?=
 =?utf-8?B?bS9xYUVTdkQ2U2lnT0JFa0UxN1QzQzBnUGszdU0rMTNUa3AyQ3owWTduS3hP?=
 =?utf-8?B?dnAxdkpiSW12WWlnL20yT0lybjltenYzNWhReVF4enp0b3JtOWdCdmVpUHBD?=
 =?utf-8?B?NzJPMVdjS2VnVzJFbTJ3b2FtMzI1TE5JaGVETC9RdHo1ZXAvWDBGQ01lUkFh?=
 =?utf-8?B?U1E0YW94Y2gwdUt0L0oxQkNZSmlzc0ZoS0poQUI5eitzS3VxT3A3WlJvL3VN?=
 =?utf-8?B?Z3FZU2xNcDZZdEN2VFJwbWVhTWorWE9sb3A2bmh0a04vN0kxN2xDREJ0Q1p1?=
 =?utf-8?B?SmU1SmV2NE53QzhXSFIvWXJaOTZzdlN6eHlVUFVZSG9Zam5Qak1YN044eHMr?=
 =?utf-8?B?NG5XRDlZL3c2VlZ5ZDhZWXFpN1g1MmZ4cVNkRGpkVk90cGFnbUtqaCt6WW40?=
 =?utf-8?B?cEU4SmZLbFdEemZTdytmRDdKcVZST3daNVdXb2pVWFdITFFOanpFcEZqNGg0?=
 =?utf-8?B?d0orSTJHRm9JYXJkTm82dlBtS0V4aVRLU0gyMmlVM2VKdTRqeVlnOG9WRFJ6?=
 =?utf-8?B?QXFaREMrUTRRQ3JpbFAzVkZTYUxPNUlrM3RUb29Xc0w0SlJjNHB0WWdvRE1E?=
 =?utf-8?B?NHlxeTJqR0tXOUswUlBFQjVzZ2dTSGdYN0w3WmNHZzJFeWRaMlN4eG40aWZD?=
 =?utf-8?B?Y2FTdlNUSlUzOHNtZElKNXAvZGpQUW1zTEJNOHFWeUhNVnVHWmhWOW5odVMv?=
 =?utf-8?B?eTN0TWFvanZ2M0RETFVIUW5rSkRXUnk5S2xIS0ptYlBtWUlUUXhqSEZUM24z?=
 =?utf-8?B?eGFGQVZHUzhQWmhPTjFKU0hMN01ReHArNUZLSlMxREVad0dxdThTZVVhUFlN?=
 =?utf-8?B?dklkM21kVHByVnI4d2N2T0VHUTJqYXZSenlHZGF5L3phRU5IeEVWMnI3L1pz?=
 =?utf-8?B?MzhoT2ZDNlhZQVZyUS9zK3BhVEgrNmtLdE4rdG5tbW5KbG5XU2NJWTBwMmsv?=
 =?utf-8?B?ZUhWaGNkNjcwc1lEdDBvUC90K2VraG9uNFBoN2k1QXYrVlZWdG8zWkJHNGha?=
 =?utf-8?B?Um9kam8zb21DVjF1bnJUcGhMYkR1SVE4U01RaUFPK3laM3dyL3d6Q09tN1cw?=
 =?utf-8?B?Njl1ZTRDTGduMkxBNW9DQ2tsOGV2NDRyNkRvaHA4R3NGc3ljQkZ6RGw3L0Vh?=
 =?utf-8?B?SzlRd0pJNEhPTnFGYWdRSE9qSVhqdGxyV1E5enlHK0MwcDdWa1RabmVXZHlO?=
 =?utf-8?B?QjhrVTJjMDFWbUJ6TGh3Z2kxYUtIbnUzN3k2RW5EQlVleUNyY3I1UGlZYnp0?=
 =?utf-8?B?Y2lrYy9HRmZFV1R5Rlg4S3VvMUQ4Q1VWeC9JendVTEdUSTFJdTRVVWRZS1h4?=
 =?utf-8?B?OUN4dkhiZVB3Wlo5OHozQWxWald6NHd1eWZEcVJNY0lwa3A0eUNUUnRHd3dm?=
 =?utf-8?B?cExqd2FPcWFpTkxrRVc0cDVBbWUxOGRrakl2bmdTR1krVGhNYkNYSjRpQngz?=
 =?utf-8?B?czBrUzZ5QUFwWUJ2VitlMDRXbExqTWhNcXA0NTFIODd1WUhIYXlWU0cxellU?=
 =?utf-8?B?K0M0OWJyWUVoVExTYmxkdGw3TndNZ250TEdiaWExWmdlVWZMK0dnWHZjekx6?=
 =?utf-8?B?eVRnc0UxWjg5eHpzT1U3dkR5b1oxMmJXcy90UTFEcUpXWHJxRkJPOVBhT0NI?=
 =?utf-8?B?OEF6NEgxZ2JQM29ZcE5SOWVqa1dnRXd2N3lpTnRpOGhaTmJOL2pkWWdyZFBM?=
 =?utf-8?B?ZmJhclh4MTR0ZTNZLzhxUmpidVhJOXhjZElNM2xrTDhxWmNiRUl1WkdjZVdZ?=
 =?utf-8?B?QWhkUmtueVRzWmhQZ0V3bTZjYjBPWHRQWTBrVDRWUk14amdhQjI1dmlmRUE1?=
 =?utf-8?B?QWZ0aW1VWGVONm9SSkk5NVB1QW1OcnZVenZtdE1hNVV6YWtqcVAvM1BHcmFV?=
 =?utf-8?B?OWlmVHZhNUxMTTlaWjRJdzVwNTd1bE94UDVIQmJzNXRRMFhXbUZFU09UTVlF?=
 =?utf-8?B?U3pSUnYwS1BvbERKa0pVZzdNRW9sc3M2ZndHSXBXdXhBMFRUS3VoV3hiWFB6?=
 =?utf-8?B?ZmZ3YTJGS1FXK2tsbXBDSjM5dnY5U0V5NDZtNndGVElBdUZWa2Q5UTVFeUdn?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB3D308AE181044EAF64E0AAE7D1A427@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9c68c4-6a56-47b8-f274-08db51031cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 03:03:21.5043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wompNrdPgza+qR0cSFS09vnsoVXPxbUYMDjWjbAPn6Z0OCFwB0UV+BCvRrCy5Go5y523zKaaEy7ay0lKBIiIBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMDgsIDIwMjMgYXQgMDc6NDE6MjdQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFRoZSBtZW1vcnlfZmFpbHVyZV9hdHRyX2dyb3VwIGlzIG9ubHkgY2FsbGVkIGlmIE1F
TU9SWV9GQUlMVVJFDQo+IGVuYWJsZWQsIG1vdmUgaXQgdW5kZXIgdGhpcyBjb25maWd1cmF0aW9u
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2VmZW5nIFdhbmcgPHdhbmdrZWZlbmcud2FuZ0BodWF3
ZWkuY29tPg0KDQpBY2tlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVj
LmNvbT4=
