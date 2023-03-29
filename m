Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434126CD25C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjC2G4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC2G4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:56:15 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959C82D74;
        Tue, 28 Mar 2023 23:56:11 -0700 (PDT)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T5kfiW019104;
        Wed, 29 Mar 2023 06:55:59 GMT
Received: from eur01-he1-obe.outbound.protection.outlook.com (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3pkhqrwne2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 06:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvq74Sdno0Pn9I1TaqobyId7m3kWsBFN8yCsR3IJUrf/2Q8Q0WqnUA7suX6neKPLjf7xSVi5fcADgk3U0nUIK+WQ/8hezsoWfYrIV298EQpXkSW1SxupLiteHLhwyF9FV+L77+MVO47QCtw0Ye4pJ2lKWZdVFcRoMrZv2smKgHjOevmWRh4V0dXoI8QbE58aCC8KvcEo1KnLEs/8qXQpREX1m3WCFKqbLkwTSgXRLq1gvhO5cYhuKSpPYkU7dM4JxLEBm8ag+iDqZyTHyTMXePMnZnsq3N6nwxVTBUmAgzQnVsofrLCFR8ohnE+t7dZI9PKSCwq9MhLHE86hT6s9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhIooVbQWUZf8NzYXnOVOKL1TXqa0K3M//rYXCpJ6NY=;
 b=YPHkoejNaggzGt2TRZxjblPMzK6fSupVRnrGuc/B+4kpRNfkdBbmeUTvEQYwQ7sCPUYxuC8TdER66TUK1J6i1bffIPT/RN7n4H21OZguFEZI6vLF+g2LKmVYuX562bLxvct66olgv7Yo5u/tuhMsHA8TkPU6nDVPmcD9EDpw1QM/xkTHatxWKfZZ6MzY8CjjY8RkrMYELX+ZojoxpIaI+3q+dssR2ax+KEy0gH9OJmFpGuv5tuRfDjSpp9IuZ/MA0T0DAi1oSsb+tl+In7EMSLsdYp9onURda/fPnOiNqMZyrmGUSzD8BhQAsgWKZGSOulCEFKd38cuvKQfY+fbDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhIooVbQWUZf8NzYXnOVOKL1TXqa0K3M//rYXCpJ6NY=;
 b=dVNUSATRX+Oa0AOHvso3v+5TYGtMN5zpyY01ko3CmOXaw0hDJ3TohacnGr9zMfBJelGh3kw9zMEIjw8sKC2OYx96lc6hjzMjRwD5YXgy4pcD22KK2thpsGGbRo6Wg5xSjgG0nczvwfD2MbHtyseCtQnntoL0GzRqN0BXDcfboZyzgDpkXElXxyYnxRGvzqrtIoNSgu1TfKxf6uE8bliif8U48KUdxM8CnyKVHs0NOoLX1DoE3/u3qAi98Go7dnjjGPG6CcMBNxghlghin3CBheSIee9L5dUYNNVgsdz1GjePItxPio9JDCE+5fHohqbFW/jWRwzRRrR+V3W0jbR7kw==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AM9PR03MB7044.eurprd03.prod.outlook.com (2603:10a6:20b:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 06:50:02 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::bdd:a497:66a0:a342]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::bdd:a497:66a0:a342%5]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 06:50:02 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Dan Carpenter <error27@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen/scsiback: don't call
 scsiback_free_translation_entry() under lock
Thread-Topic: [PATCH] xen/scsiback: don't call
 scsiback_free_translation_entry() under lock
Thread-Index: AQHZYVG+3GUB3O/23kquKYQ39EYPJq8QVnGAgAD0KoCAAAgfgA==
Date:   Wed, 29 Mar 2023 06:50:02 +0000
Message-ID: <9e94aeea-b56f-ef97-089c-84b669367002@epam.com>
References: <20230328084602.20729-1-jgross@suse.com>
 <df07e1e3-ebe0-65c6-58c0-831739b9ed4c@epam.com>
 <38d97163-5c02-9193-5c20-ab3b5274bd51@suse.com>
In-Reply-To: <38d97163-5c02-9193-5c20-ab3b5274bd51@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AM9PR03MB7044:EE_
x-ms-office365-filtering-correlation-id: e38c81d6-36d9-4f8d-c4f8-08db3021d23a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DiV1le8pFx9iK5Kiqy4nt8OeVt+K8Pck6t0sAy1oD6shr3EvxRFFo5tuHdpdTKBZC5MCaENzptkdq+hC1+wwZu/bUYNCCS+ASq5lOq2QeI+pTizwF80Q3hyUaEm3ugTgbesP7yWhu/1NEj5sru+vm+UZP/ONwPEHGk+F1jej9PkXp91dHYMZ8gQRpwoP0/vVdPWhKfsVlDPc5r8AxzwZP2ycyY7In1NAlYFliMg3k/GkAzFtE3skA73GqFjzEsopMpVpwPkEHTN3c4+LVh0Dp7reJdvNfVXI9szDyAbozIybvTTVyrhWr2RBr/ihjj5F9e7a1jTlFEYOn9Bqcvi7edhmxOM35XsHqcu3Xnt3S9DdafO3u9vVwtGpKM7c8IgoQZ5GGYprv4Oo6HS3MYa4oUieA/PxdJ1nyjeVLiDDnkGGflwgh0TZH62wbmiihKFwUnKwAcUum9CGC0DufPEFF6Fa39fUPAhDKn6B7EuwH7Z/EzLlEtYshlPl06SYPgfTCxv1620tRwNSHozXQA3uooUD3zyIJd82tMmZ/ZhowW29gT3YOkejc4tShSFqwrtogt80Gn4BmT2OaayR/XnjJgC5+21Jg++6RS5xN17uNEmvUrcqvVaom1Tp8Uc3wM0w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(6506007)(122000001)(53546011)(26005)(6486002)(966005)(38100700002)(2616005)(186003)(2906002)(8936002)(5660300002)(6512007)(36756003)(54906003)(478600001)(38070700005)(316002)(71200400001)(91956017)(41300700001)(86362001)(31696002)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(4326008)(31686004)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDZsYUFMK1I4UFIxMnVvS0UrcFhLNmlEbk04M25kcDBad01aZnF1d1BSaDlv?=
 =?utf-8?B?a1hnUjBvR2lRR0FNVnFTQVY0MEZtVzVPSHJlYkY1cWhLUklNbzlvNUNSV1Rh?=
 =?utf-8?B?cjU0NHBtQmRvYWVmbk9GYjB1WGFzWWMvMHZGSER6Q2ZDR3YzSVRJUmgxWm1t?=
 =?utf-8?B?UE44ZDdTT25FUEpYeExZZ3h6aU5vY09Xb3Vucjl3d2h2TXVnYkw4L3VYR0lX?=
 =?utf-8?B?enN0MlRRM01jaG5hNnQwdWRmbUN4eC9BdFVuQzVwcnVybll6ZmhrM3lUdVh5?=
 =?utf-8?B?cVJoaENMUVY5VFNUWmdoU3lDQm1ZeVhrUHZ3NXRTa2VCRWNxTnJMWVlQS3Zu?=
 =?utf-8?B?dEV4YVNEMFVvLzNmdDViUEcrQ2piY1hUUTlqTlJQRDBySCtYaWxwNjErTEhr?=
 =?utf-8?B?TWMxUjgwQ2xGYUU0Tmd4ZnJyODdKMFdFUDZzZUc1TmI0Rlc0aVV4MVVJVVJt?=
 =?utf-8?B?eGc5amVaZGlhL1BGdkx5ZERORmlwblVXZ3ZQcEdJREkxckpTb1F4dVhXQjFs?=
 =?utf-8?B?Nm95NFpLbmNpa2dhRUdtR0Q3QzhyNXZITE1hVDBFMnoxcWRUNSszV2pEUjh1?=
 =?utf-8?B?NVp3UU9TUUd2bnAvdVd3V0dnUmQ5SGN6RUlTTk9LdVhsUDJZWDZlRUIySVJl?=
 =?utf-8?B?bmM0VzcvQXovZ1hkSjZDU1F6ZnNDY1ZFNjVycHFXUmsvUXZHR3hKYWlnM20r?=
 =?utf-8?B?UFplNzhBb09pWEdEdVk1Q0tOc0xtNW9XaUxDVjhUUkJjUjc5WGI4eWVCTWxV?=
 =?utf-8?B?ZXg4TnA2OHdkQlJMVDRaY1FNcXJaeTJ4ZEZVaFBsRGt1ZUdJb1YwZGFGNEFT?=
 =?utf-8?B?TkFnc1RzWU43bjhDSmhDMk1ub2FGMW1RQTExVnVQU3JrVW1UYktlZGJJdEwy?=
 =?utf-8?B?LzEvUUxoNjdCUllTdTdXbUhOK1NBc09WRzBYaW01WHMrancxRktUaVRMbDUy?=
 =?utf-8?B?bGI2dWtTTkpiT1BEVFdqL3lYOVNUTUQzTHlOUm9CUzFZaHQxdmN0c3RZd2My?=
 =?utf-8?B?OTliaWYycjR5QStOc2FieVZJbnZ6Zm55SG80MlhOTkYzdlFRY1BVSkRBbTVV?=
 =?utf-8?B?d0RydEh2ZVdUNEtONC9LbXVLSmczZHltMHdseFJkR3hnejNHbUdOU3hSeWRu?=
 =?utf-8?B?NWhiMTZlS0E2b2FtNnJDMjdGR1kxd0lYVWswd1kwbnY1U3lZdk1oTXVFaXJU?=
 =?utf-8?B?N2tGV0dGYnFidlRJaEpHYk1RNncxVHYzZlJlVlZGTHFjeDVRMWVKMjVXY3Vy?=
 =?utf-8?B?UHM5bzlQVnJHTjd5VWRiZ3JQL3VCcDI3eTV1eldTeXBOV1Q2M3lJQmc1ZWVm?=
 =?utf-8?B?NC9lUjAyMEErL2F5cnUyRDlZcHJ4bjNSSEF4QS9aRkM5ZkpBRFhma0cyZ0pR?=
 =?utf-8?B?L2d3RllHTFh1UjlmOGJwYXVxS290RHBQMHJNTmd2ZVJKdGRPV1VXYXFnR3hP?=
 =?utf-8?B?UlVqZFUxalVISWZEc3UxMjVXQ0JzL0tOTmovVUNJOWloNWV4d0FxZ1N1aWJx?=
 =?utf-8?B?ZWM3SnRGOVZURHl0UWkwTDhIL1VJaUZqek56VjBwQVBiaVBQWEYwYkVLM3NQ?=
 =?utf-8?B?N0dzS0IrNmsrQUJiMnR4MEYySEdMTnpVaG1naTZOQnM0ckZidEl3dmtJSUVr?=
 =?utf-8?B?Z0VjWmJvZU5JcTdyS2U4K3VVc0VVdC9SS3lOTGJtdGVmTmVhZDlNT3JzUTA2?=
 =?utf-8?B?ci9KaWNaWk1aT2FYcUZqMktFNUVYN3FOdWlHeG1QbVJlL000YTFsZy9lTVJl?=
 =?utf-8?B?STRIUHVsNUtoUmdLOUhJQXhQcXhQZjVydkt4Wm5mU1lEekcxVDhYQVBmYWdz?=
 =?utf-8?B?bjRtaHAvQU5ZeWkvVFFmeFVaM2syZjdoYzNxOXNkVm9oYThxTy9OR3doMFNB?=
 =?utf-8?B?U0VvV1RTZUF5a1RkeWJyK21PSXpnM21SSkRZRjh1NGVJRkZPVk1WbXYrdnNT?=
 =?utf-8?B?eHNtTkpvUDZVMHQ5ZXFiZmQxamNSaC9qME9UcVVlaHVqeVl6WnBQcUtrd0Jo?=
 =?utf-8?B?anNsbEZ5TWJyc2NoUlZWeTNVYVczcW5PdzRuM3JTOEY5V2p0dVlHZG9MWVhn?=
 =?utf-8?B?MnFMamRvem5XamFFaVVabWVMSEdlbkhCSWhFVmVJcDNZa0plQ2NMTFVTcE10?=
 =?utf-8?B?YlVWcHJXU29uQVl5Tnd0ZUNSZjVST1RhcEFJbEc5S1ZnK3ZjN0hrbWZTRitJ?=
 =?utf-8?Q?rJZ7ZPSPKvGb48J69NQHtfM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5FDC056BDEB2E44B1B779D0CAC6F944@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38c81d6-36d9-4f8d-c4f8-08db3021d23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 06:50:02.1698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9o/w6Jsu1EBqgU4dtreGfREmr5RrdqdN5A4iRGY9LAt4muj7LFU6cYKGSQ2Khk5ZuTDTcn11H2Pjhst14IuMfONWrR5qj+IZ6x/vMLPIJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7044
X-Proofpoint-ORIG-GUID: LJDg4k5yuiFzF4xfRe48eA3-Od7Gtbe_
X-Proofpoint-GUID: LJDg4k5yuiFzF4xfRe48eA3-Od7Gtbe_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_01,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290056
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI5LjAzLjIzIDA5OjIwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQpIZWxsbyBKdWVy
Z2VuDQoNCg0KPiBPbiAyOC4wMy4yMyAxNzo0NywgT2xla3NhbmRyIFR5c2hjaGVua28gd3JvdGU6
DQo+Pg0KPj4NCj4+IE9uIDI4LjAzLjIzIDExOjQ2LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4N
Cj4+IEhlbGxvIEp1ZXJnZW4NCj4+DQo+Pj4gc2NzaWJhY2tfZnJlZV90cmFuc2xhdGlvbl9lbnRy
eSgpIHNob3VsZG4ndCBiZSBjYWxsZWQgdW5kZXIgc3BpbmxvY2ssDQo+Pj4gYXMgaXQgY2FuIHNs
ZWVwLg0KPj4+DQo+Pj4gVGhpcyByZXF1aXJlcyB0byBzcGxpdCByZW1vdmluZyBhIHRyYW5zbGF0
aW9uIGVudHJ5IGZyb20gdGhlIHYycCBsaXN0DQo+Pj4gZnJvbSBhY3R1YWxseSBjYWxsaW5nIGty
ZWZfcHV0KCkgZm9yIHRoZSBlbnRyeS4NCj4+Pg0KPj4+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVu
dGVyIDxlcnJvcjI3QGdtYWlsLmNvbT4NCj4+PiBMaW5rOiANCj4+PiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9ZKkpVSWw2NFVEbWRrYm9o
QGthZGFtL19fO0t3ISFHRl8yOWRiY1FJVUJQQSEyM0lLZFZoYW1vRnE4cHRVbnByZF9UdWJETU9i
ai0wUUFhbHNHaWZmQkhDZUVkT3V3cnE3ejRvaGc5MlNqMG9sZ2wwbmg3M29YdlNyLWkxenFYaFkk
IFtsb3JlWy5da2VybmVsWy5db3JnXQ0KPj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3Mg
PGpncm9zc0BzdXNlLmNvbT4NCj4+PiAtLS0NCj4+PiDCoMKgIGRyaXZlcnMveGVuL3hlbi1zY3Np
YmFjay5jIHwgMjcgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+Pj4gwqDCoCAxIGZpbGUg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy94ZW4veGVuLXNjc2liYWNrLmMgYi9kcml2ZXJzL3hlbi94ZW4tc2Nz
aWJhY2suYw0KPj4+IGluZGV4IDk1NDE4OGIwYjg1OC4uMjk0ZjI5Y2RjN2FhIDEwMDY0NA0KPj4+
IC0tLSBhL2RyaXZlcnMveGVuL3hlbi1zY3NpYmFjay5jDQo+Pj4gKysrIGIvZHJpdmVycy94ZW4v
eGVuLXNjc2liYWNrLmMNCj4+PiBAQCAtMTAxMCwxMiArMTAxMCw2IEBAIHN0YXRpYyBpbnQgDQo+
Pj4gc2NzaWJhY2tfYWRkX3RyYW5zbGF0aW9uX2VudHJ5KHN0cnVjdCB2c2NzaWJrX2luZm8gKmlu
Zm8sDQo+Pj4gwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7DQo+Pj4gwqDCoCB9DQo+Pj4gLXN0YXRp
YyB2b2lkIF9fc2NzaWJhY2tfZGVsX3RyYW5zbGF0aW9uX2VudHJ5KHN0cnVjdCB2MnBfZW50cnkg
KmVudHJ5KQ0KPj4+IC17DQo+Pj4gLcKgwqDCoCBsaXN0X2RlbCgmZW50cnktPmwpOw0KPj4+IC3C
oMKgwqAga3JlZl9wdXQoJmVudHJ5LT5rcmVmLCBzY3NpYmFja19mcmVlX3RyYW5zbGF0aW9uX2Vu
dHJ5KTsNCj4+PiAtfQ0KPj4+IC0NCj4+PiDCoMKgIC8qDQo+Pj4gwqDCoMKgwqAgRGVsZXRlIHRo
ZSB0cmFuc2xhdGlvbiBlbnRyeSBzcGVjaWZpZWQNCj4+PiDCoMKgICovDQo+Pj4gQEAgLTEwMjQs
MTggKzEwMTgsMjAgQEAgc3RhdGljIGludCANCj4+PiBzY3NpYmFja19kZWxfdHJhbnNsYXRpb25f
ZW50cnkoc3RydWN0IHZzY3NpYmtfaW5mbyAqaW5mbywNCj4+PiDCoMKgIHsNCj4+PiDCoMKgwqDC
oMKgwqAgc3RydWN0IHYycF9lbnRyeSAqZW50cnk7DQo+Pj4gwqDCoMKgwqDCoMKgIHVuc2lnbmVk
IGxvbmcgZmxhZ3M7DQo+Pj4gLcKgwqDCoCBpbnQgcmV0ID0gMDsNCj4+PiDCoMKgwqDCoMKgwqAg
c3Bpbl9sb2NrX2lycXNhdmUoJmluZm8tPnYycF9sb2NrLCBmbGFncyk7DQo+Pj4gwqDCoMKgwqDC
oMKgIC8qIEZpbmQgb3V0IHRoZSB0cmFuc2xhdGlvbiBlbnRyeSBzcGVjaWZpZWQgKi8NCj4+PiDC
oMKgwqDCoMKgwqAgZW50cnkgPSBzY3NpYmFja19jaGtfdHJhbnNsYXRpb25fZW50cnkoaW5mbywg
dik7DQo+Pj4gwqDCoMKgwqDCoMKgIGlmIChlbnRyeSkNCj4+PiAtwqDCoMKgwqDCoMKgwqAgX19z
Y3NpYmFja19kZWxfdHJhbnNsYXRpb25fZW50cnkoZW50cnkpOw0KPj4+IC3CoMKgwqAgZWxzZQ0K
Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXQgPSAtRU5PRU5UOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBs
aXN0X2RlbCgmZW50cnktPmwpOw0KPj4+IMKgwqDCoMKgwqDCoCBzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZpbmZvLT52MnBfbG9jaywgZmxhZ3MpOw0KPj4+IC3CoMKgwqAgcmV0dXJuIHJldDsNCj4+
PiArDQo+Pj4gK8KgwqDCoCBpZiAoIWVudHJ5KQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4g
LUVOT0VOVDsNCj4+PiArDQo+Pj4gK8KgwqDCoCBrcmVmX3B1dCgmZW50cnktPmtyZWYsIHNjc2li
YWNrX2ZyZWVfdHJhbnNsYXRpb25fZW50cnkpOw0KPj4+ICvCoMKgwqAgcmV0dXJuIDA7DQo+Pj4g
wqDCoCB9DQo+Pj4gwqDCoCBzdGF0aWMgdm9pZCBzY3NpYmFja19kb19hZGRfbHVuKHN0cnVjdCB2
c2NzaWJrX2luZm8gKmluZm8sIGNvbnN0IA0KPj4+IGNoYXIgKnN0YXRlLA0KPj4+IEBAIC0xMjM5
LDE0ICsxMjM1LDE5IEBAIHN0YXRpYyB2b2lkIA0KPj4+IHNjc2liYWNrX3JlbGVhc2VfdHJhbnNs
YXRpb25fZW50cnkoc3RydWN0IHZzY3NpYmtfaW5mbyAqaW5mbykNCj4+PiDCoMKgIHsNCj4+PiDC
oMKgwqDCoMKgwqAgc3RydWN0IHYycF9lbnRyeSAqZW50cnksICp0bXA7DQo+Pj4gwqDCoMKgwqDC
oMKgIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQgPSAmKGluZm8tPnYycF9lbnRyeV9saXN0cyk7DQo+
Pj4gK8KgwqDCoCBzdHJ1Y3QgbGlzdF9oZWFkIHRtcF9saXN0Ow0KPj4NCj4+DQo+PiBJIHdvdWxk
IHVzZSBMSVNUX0hFQUQodG1wX2xpc3QpOw0KPiANCj4gVGhlcmUgaXMgbm8gbmVlZCB0byBpbml0
aWFsaXplIGl0LCBzbyBJIHRoaW5rIEkgd2lsbCBrZWVwIGl0IGFzIGlzLg0KPiANCj4+DQo+Pj4g
wqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+Pj4gwqDCoMKgwqDCoMKgIHNwaW5f
bG9ja19pcnFzYXZlKCZpbmZvLT52MnBfbG9jaywgZmxhZ3MpOw0KPj4+IC3CoMKgwqAgbGlzdF9m
b3JfZWFjaF9lbnRyeV9zYWZlKGVudHJ5LCB0bXAsIGhlYWQsIGwpDQo+Pj4gLcKgwqDCoMKgwqDC
oMKgIF9fc2NzaWJhY2tfZGVsX3RyYW5zbGF0aW9uX2VudHJ5KGVudHJ5KTsNCj4+PiArwqDCoMKg
IGxpc3RfY3V0X2JlZm9yZSgmdG1wX2xpc3QsIGhlYWQsIGhlYWQpOw0KPj4NCj4+IHNvIHdlIGp1
c3QgbW92ZSBhbGwgZW50cmllcyBmcm9tIGhlYWQgdG8gdG1wX2xpc3QgaGVyZSB0byBiZSBwcm9j
ZXNzZWQuLi4NCj4gDQo+IENvcnJlY3QuDQo+IA0KPj4NCj4+PiDCoMKgwqDCoMKgwqAgc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmaW5mby0+djJwX2xvY2ssIGZsYWdzKTsNCj4+DQo+PiAuLi4gd2hl
biB0aGUgbG9jayBpcyBub3QgaGVsZCwgb2sNCj4+DQo+PiBQYXRjaCBMR1RNLCBidXQgb25lICht
YXliZSBzdHVwaWQpIHF1ZXN0aW9uIHRvIGNsYXJpZnkuDQo+Pg0KPj4gV2h5IGRvIHdlIG5lZWQg
dG8gdXNlIGEgbG9jayBoZXJlIGluIHRoZSBmaXJzdCBwbGFjZT8gVGhlDQo+PiBzY3NpYmFja19y
ZWxlYXNlX3RyYW5zbGF0aW9uX2VudHJ5KCkgZ2V0cyBjYWxsZWQgd2hlbiB0aGUgZHJpdmVyDQo+
PiBpbnN0YW5jZSBpcyBhYm91dCB0byBiZSByZW1vdmVkIGFuZCAqYWZ0ZXIqIHRoZSBkaXNjb25u
ZWN0aW9uIGZyb20NCj4+IG90aGVyZW5kIChzbyBubyByZXF1ZXN0cyBhcmUgZXhwZWN0ZWQpLCBz
byB3aGF0IGVsc2UgbWlnaHQgY2F1c2UgdGhpcw0KPj4gbGlzdCB0byBiZSBhY2Nlc3NlZCBjb25j
dXJyZW50bHk/DQo+IA0KPiBNYXliZSBub3RoaW5nLCBidXQgSSB0aGluayBpdCBpcyBnb29kIHBy
YWN0aWNlIHRvIGtlZXAgdGhlIGxvY2sgaW4gb3JkZXINCj4gdG8gYXZvaWQgZnV0dXJlIGNvZGUg
Y2hhbmdlcyB0byBjYXVzZSBwcm9ibGVtcy4NCg0KDQpUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlv
biwgaXQgc291bmRzIHJlYXNvbmFibGUgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBPbGVrc2FuZHIg
VHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+DQoNCj4gDQo+IA0KPiBK
dWVyZ2VuDQo+IA==
