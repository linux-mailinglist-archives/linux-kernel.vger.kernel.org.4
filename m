Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62C73E2A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFZPDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFZPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:03:14 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F5130;
        Mon, 26 Jun 2023 08:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIfQrZT2XDwYohZP+Aolbs1HbaMz0l2U83HIgtQAvSrFpcROoXvSZLwk1u3iCpCnnNkY2zs2V1/oUXubYAsk+xFK2pQjTQQq04hMczE38SQd+PYKoKGD/ZqQ5jIbHJDp58lKC7JATgVkCezEAzbdoUvPZH2YpRcjBOasxbqFty/8k0jLn+A0OjhOU6uwh6b16ewaP2Fr7bdTCE4V893HIKWadz/BXB6WC9OVARvAXvxrSbn+0ec5hayNXrzpizoHcSlFd60S17ObWVvb08GjA6yvqrclg8K9z533eQduPhaGRFr8pJlrmOTfkVitcRbnxw920DWMd4Wxuk79ZXaKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssSiYbdaCpE/9c7aLkYBGXISPI3UKjZMGFrMqaVo5zo=;
 b=UcRqXpvtwFvEjPKIIDUJx+ikX01LUhGc0eANG++HyONpHUxn1gfNvOkMF+YJbC/uzfKo8ssHoxQS+wEDJkztUqlKZEm7SDIwnGJXhE4hCXiUvD0IFcbqO/gHstdEvwvmrOEsErWDZhEIa8NJwh5aEoctk8X97ZPoMCpXHa0RLwNEbylSWR4A3RE5HjVwTOgMQeyg8iJdrrSSG9jJ+ueBuVakOlB8iVOa+tqac9oR1GJ5IbLPqomauetCurgUxKDc6MGyNY+WAfWVPRypr61mSpLMsaW9D8MCIdgV4IeaKq4kMmPPGx5ksxJhPnIeuEqWlM0Wf2mygNFV/wIPm16vOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssSiYbdaCpE/9c7aLkYBGXISPI3UKjZMGFrMqaVo5zo=;
 b=Mg3DpsD5qObTMz90K9eLKu3SUV1c9/shJ2takw5VolF20QkIeWPg0rhx+E/7TPOLZvI58YFHy3t8N4yo1Ci+oeJEOeoRBbbGu9oC3MkcTCzneZzg0ZbrT5+abITOmc9N2k1qAAr59KEiEGU2YS9hOSLbZ0v4lHqFU9fXQFQcOFM=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYWP286MB3301.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Mon, 26 Jun 2023 15:03:10 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 15:03:10 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "andy@kernel.org" <andy@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIHYyIDEvMl0gZ3Bpb2xpYjogY2RldjogRml4?=
 =?gb2312?Q?_&lr->wait.lock_deadlock_issue?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIIHYyIDEvMl0gZ3Bpb2xpYjogY2RldjogRml4ICZsci0+?=
 =?gb2312?Q?wait.lock_deadlock_issue?=
Thread-Index: AQHZqBNf7gwzAWjB50ahRCRRc44o16+c65UAgAAAWNWAAAK1gIAAPtnR
Date:   Mon, 26 Jun 2023 15:03:10 +0000
Message-ID: <TYCP286MB11883FA1925B0DE0030B216D8A26A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB1188A94580A60F47CAF892C88A26A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <ZJlwjhQT2wfO3Ukn@smile.fi.intel.com>
 <TYCP286MB11884755575685089C1BBDC38A26A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <ZJlzHc8eiHnPe+Ot@smile.fi.intel.com>
In-Reply-To: <ZJlzHc8eiHnPe+Ot@smile.fi.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB1188:EE_|TYWP286MB3301:EE_
x-ms-office365-filtering-correlation-id: 4ffe456a-3032-487b-db83-08db765674cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0a+HfpotjTvJ35ib0f4+KiNkAjV2z+yQ9vwhqoLU8jMjsz8yIUOt5C6jkFoq4ma7yJ2cfvY/ojK0cutFq2gdy4zLSOb0us+OuEJgyncpDSe6MIphwhZMcyPjyBcd7x4kj1rPRsw1QKwDfv2QftIFt1UfOtd4T1EkWNdVnfoTIX7ujzA3DeH6aijPrAlkP1E1W7aDCNoMDXMy3VjwMPS7wYjbIcGdJxJTUHInxRa1qHBMjEZJp8PJF4+fpPCvDcpZYm93mqFbNR4OVNPWgfiYUXESMM1GUJ77PUOaTIZi6D1cZoVLErD+kxrHrpwFnd6auy/2bUgbFlLlSELOfQ8cFqa3jgi5jPHBAcsMEL7V+/zS2YBDUp/yCocTiKryhvZ3TZwdaWBJntLYmTYYQTDO5vvUVcrsWt5j1WE63+Qxy7gg5w+raEKTw0cMz2+mtbODWSr4Ay3AYDMRD3wPRYpg6F0423DLvjaKhiEOg6te8hU2dASHDU4uiLFzhKtQZHvL37lgZ7DzZBbEhK1ulaGMVb7OnOyQAVfKheFCDrU6JTwewOHNVTPBOinTIrs4T5YO/GaPWeUqN6WE5YizNqf8V8SVG4NGNNhroEtBJRk9GiHia50kmVyOSjMbdQTk1L0n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(6506007)(478600001)(71200400001)(54906003)(7696005)(26005)(9686003)(186003)(2906002)(5660300002)(224303003)(558084003)(33656002)(52536014)(38100700002)(122000001)(66946007)(76116006)(91956017)(786003)(8936002)(316002)(86362001)(66476007)(6916009)(66556008)(55016003)(4326008)(41300700001)(66446008)(38070700005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bFJ3Qk1aWGQ2dlY3RXZrMzZJaE9WaW94ckRCZlhvWWNtSkk4YkdYZ1R5M0RR?=
 =?gb2312?B?Q2NCKy84YjJCVkZUQ1Qyb1JnOWdwQmVET3NXc09uOS9SYjR3ZUVPeGUwenpX?=
 =?gb2312?B?WVkveEZnN2p0YmtMVS9XRy91ODJLTktQaS82RkQraUNva05QMGhmNE1JMXB1?=
 =?gb2312?B?dGVMLzQwcGV2c0k1YWtoMDdXcHhFNTdNQjkrWHhudU54YitYV2tGcDM0bzNB?=
 =?gb2312?B?d012RGNRbHlYMWRFMU5VQUZQLzVyNS84ZDJKemFSSlUydUxTd0FSa2NycnQ0?=
 =?gb2312?B?MXFhT2tSQUVSRjRWZEVaQlF3TlovR05EbUxWL0VyY0pnVXFYbkx5YUY4UWNJ?=
 =?gb2312?B?M3E4RE16dFFLL0UzTE9aUDU3WE04ekd5ODBacXc0eEs5amhvNWlNdDFaZ2lB?=
 =?gb2312?B?VEVQcmFkZ292SXFrYklETWt3RWhkWnBQTzJnQUxtbkFtTXdRdnloZ2dEeTRa?=
 =?gb2312?B?SG54SHc3UzZLcDlxZnYwN3dOMllHQUx1M2pYQWtVSVVCaHJnUlI4anpqWllz?=
 =?gb2312?B?RjNGQVZJY3o4UTBtMTVndnl4dTR4NmVYNHdrVEVUc1gvaHJoY2lld0o1L1d2?=
 =?gb2312?B?WVdBZjJqdVJFTU1vK2xPV3ZxU0dVU1Q2MzVqUk4wNXV0cUVQb3FBYmVlTjNX?=
 =?gb2312?B?QVcwcGJKdXRPSndJRHVCbWdoRmVWUEhEN2pweEJQa1o0RzFxeldLWkFGQmZT?=
 =?gb2312?B?Vk9xSWo4bWFXaHlZSHpJRVR4WDNTdTJRVy9VOW5zM08wV2k4QmxpL2RyWDZF?=
 =?gb2312?B?TWwra0wyVDZxWlptOGJIR2JiZWVJTXNMZ2FScVhXTzRSbGtvMHVMcE5MQ0sx?=
 =?gb2312?B?ZG9RektVUDYvc01peWlYWUk2TFdyaW13VTR2TklQTlpUYnlTMEpaM1Z2QjND?=
 =?gb2312?B?WkpYZEp5Ynpyb2tBeWltc3IvUWZmU2h1bUpyeWlFQjdHRjdqMS9aQjg0M2Qv?=
 =?gb2312?B?UVZNUGpoN0NTb1FQY3ZISXdxUnJ4aGgrMFkrOGFyZ2MwVFpudXBTckZHRitC?=
 =?gb2312?B?TjIwRStkZ0dOT3pQM21zMHZEbjhBdmhGZHBQSjFETUhiTTNib0Z3MGVlWFZ3?=
 =?gb2312?B?d2U3TFNIck13bitkSnIzakltOG5KOUlaazdxenUrby80b3BvREN6aURVQ0li?=
 =?gb2312?B?cWdQTEVhWnFMS2NOQ1RZQlJRMkl4OUlidDl2RUNyYkZTTWNTemRYU2pLRlZ3?=
 =?gb2312?B?U3NKenk5SzFRWllIdjJFN2dwemZ3Q2ZuK2tjZ3JUMVF6K2FLM25kT1ZNR3pl?=
 =?gb2312?B?d0hveTZoOVJ2bXZYaW9uMEIvK2VSNzNLdi8xWUFqNGV0YzdlZE4zNkplUldy?=
 =?gb2312?B?MUUzOThOazhNaWVIME9qWGsxaUhMVHB2eFNUZ3prVlJLTnNmUld5Szdpem1X?=
 =?gb2312?B?b0lYL1VvU1Qzcys3LzlWKzlSU3V4UlVWbnR1ZmtKSXBESk1FYzBBWXgrZ1g4?=
 =?gb2312?B?eUZ6YWhuVHZwc2ZvUTlkM0dIcmsrT1RrditHdEFONmpMeTVBT3gvTElmbyts?=
 =?gb2312?B?TCs4SXppRFNtVlZieWlkMzYzK3g3RnQ1Z2RVZ3FKYzMrMHVoTXZ3em9EeXNy?=
 =?gb2312?B?QytlVkF4OG5DMWNFTUNvN0F6aThUanJzUnRpMkFFeHlQZURMU1RpbEF5c3Rm?=
 =?gb2312?B?bVFFUHRldUwwTHIvOGhSTkdiTHlwaWtONjJJenA0V2JBS0h5YkR0ekpyaXlu?=
 =?gb2312?B?Y1pyTWVyNk12QWxaa0VaL1pPNjlGaGFlODZjYndOSWdLTStVYk5ZcVFXOHdU?=
 =?gb2312?B?S3pHMFRJTEpuTVUwQmtUT1pTdVJKaWEyVjdiNVZXeUUvZXpZaXBzZkpHU1gz?=
 =?gb2312?B?NHRBUnJIM3ZOZVlLSldvWG9ZNDhqUktYa1NiSmdJV0hzNFpIaHdjcEhkSE1t?=
 =?gb2312?B?blZnaGxxZWVLdzhvQUJQb3I5WnY3cEFBMWNJaU1wSW5EUFg4WEZ4RmdTNk5O?=
 =?gb2312?B?b3F4SWVzNmEyK0toL2h1MlFBMHh4d0ExRGF2Ly8xa3ZNY3k5MGpKSk9sNWZo?=
 =?gb2312?B?U1JDMVQyamhKMTIwLy9oSUFlU2IwODZBaTFvcFgrcjF5ZXdvckpjcDRLOHkr?=
 =?gb2312?B?K0c0eWU5cUlmSVlDZ243cmR1UjZwNi83dm9lM1d6Z0ZsNzNlaFlHaHU0aUZJ?=
 =?gb2312?Q?hipCNDwd/rtN1hqG/Anx/VaxO?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffe456a-3032-487b-db83-08db765674cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 15:03:10.1820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPsiXxFhy+61GFl26jhGVgnINHeY74cg6WVs8/v5PWCfnDs35UaN7pgxkcJgPxLtRdpJH7XK9XMZTIcfor+PjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3301
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIG11Y2ggZm9yIHRoZSBzdWdnZXN0aW9uIGFuZCBndWlkYW5jZS4gSSB0aGluayB0aGUg
bmV3IHBhdGNoIHNlcmllcyBzaG91bGQgYmUgY29ycmVjdCBub3cuIE5vdGUgdGhhdCBJIHVzZSBh
bm90aGVyIGVtYWlsIHRvIHNlbmQgdGhlIHBhdGNoZXMgc2luY2UgSSBoYXZlIHNvbWUgcHJvYmxl
bSB0byBzZXR1cCB0aGlzIG9uZSB3aXRoIGdpdCBzZW5kLW1haWwgZHVlIHRvIDJGQS4KCkJlc3Qg
UmVnYXJkcywKQ2hlbmdmZW5n
