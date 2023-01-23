Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC5678549
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjAWSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAWSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:52:33 -0500
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (mail-dm3gcc02on2081.outbound.protection.outlook.com [40.107.91.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015EE11EAB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:52:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWmpVJMcsLrAg1vfuGNkPF3/9YWnOOV80mIxrnrzQMedlytp1hydzDVPT4K0fmTHmYejoc4em1LkCRkNDw0vi9s83MsYdjItPgkvalig+rVW6d5LPjnpd9bH6+dfBovOSmFOVbD8sSM1P39O80QKUqrjEYDphIH5RatiR1CccG9OppYmZK3Ps/xHMY1iHGhzAXpebYMmrn7jWxgVJToRwyB8sngderSfkvsV0EdsS1VWM/KwGQJxsczj8dyTfIy8/dJ6/WBYXTwU+iRzuRIyHJqZOCf+Y+W62gNwf6is3zHnA7q5y0fy1905RtcHYn7PEIsuzAfyEOWFBapYBq+D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRJJsrYw3WVUNvPcXgYPi5yKeRIGKEGLznllhTLP5eE=;
 b=EbFwaYQdpozFIQ0B1fsbxb4W6Cqa/3clBx1pP9nW8P93qXchOTAKlQRgdvyHbTPzxKCIV73Fnp6o7LZUCmtq9yebPh5Dyhbjb4RD1jtawwUJ89htni6XkdChAOvOe+qMz8bP0t0OJZT9LOrBNPnwO/6PVHrpoqJok8FEsm5o57LbBURnmb+2dq13+CEE3xUQ45wzQjxBxBvp/f5i+dH0c/UQdVJ2HZBP8ol76fDUbBWQ1y5nb9GtKTNJrZILdvg5p0u7XqxpixPd8Ts+KRjnYz7f6qpDoZ1g/+X8SEbZy6Cfqc4Jdu/MWDOr0HeSXeeaHElJhw1K1qlFJ2eYfVQ1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=redcom.com; dmarc=pass action=none header.from=redcom.com;
 dkim=pass header.d=redcom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redcomlaboratories.onmicrosoft.com;
 s=selector1-redcomlaboratories-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRJJsrYw3WVUNvPcXgYPi5yKeRIGKEGLznllhTLP5eE=;
 b=CukAy1gWCdIkQ7sHgDFYrjVnnyowb5PmIP4/t8EsNq/HhefXX1M/vPfUuLuBM9d/lMmI6Yx6xLZLHb6OkcAaWsAhpHd1C/4lBH5GF/XSAQE95fUO0IoQ2KOIl5csCs4FCEUaQij4iVTJ4tp4ewWhaJBu5pp5nQoIe6/wtlLhnj0e6kpetNPF1CqMTkw2y1kiMdUZEBskB9cb8nSzK8BUCHZx6q8OFWz+tWuziNqxYWWzmlhSKoIRSgfYHIr7Bw/Ull0xYof/BLGTiWWcUcmniFctUESDj3ZNk7uQ1PizkLuTu63HYoMdQxfHD/fbOhaT+CHt2hhdnqEIOuuOoKV1vA==
Received: from MW4PR09MB9284.namprd09.prod.outlook.com (2603:10b6:303:1f2::12)
 by DM8PR09MB7383.namprd09.prod.outlook.com (2603:10b6:5:2e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 18:52:31 +0000
Received: from MW4PR09MB9284.namprd09.prod.outlook.com
 ([fe80::8f89:3436:3ed1:78db]) by MW4PR09MB9284.namprd09.prod.outlook.com
 ([fe80::8f89:3436:3ed1:78db%5]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 18:52:31 +0000
From:   "Wall, Stephen" <stephen.wall@redcom.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Possible bug in sc16is7xx UART driver
Thread-Topic: Possible bug in sc16is7xx UART driver
Thread-Index: AdkvWt8Kz9SPeLnDSxubF/X6RYT/BQ==
Date:   Mon, 23 Jan 2023 18:52:31 +0000
Message-ID: <MW4PR09MB9284AF493E33E1E950361BAFEEC89@MW4PR09MB9284.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=redcom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR09MB9284:EE_|DM8PR09MB7383:EE_
x-ms-office365-filtering-correlation-id: d3fc9ef5-d716-4178-f028-08dafd72fb7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gr245c8cRDLJf3X0aZoc6xyPNMVFSHSUNqZHuYnmidx4swky0sAfZKkpJeppE01zyfmsNqc+a2gY8VcfQbqNVjcSXxp72oqlmvdfauL95MJRwa5YPhxge0zJ906rOeKh8CEjNQNye1doJq3ZWwBVHQhqT1ZXkYTOT4d1VI8zTfkuK2HTtoFPNeeL7kuI5SQ4E91oiqE+/nYcq70GzBwseCiu1HrZ0vvWpw+cn7pazHcJDVG5N0ajwJB/dkL/wy41syOWZ+OUiXayspYYU42qkqN0YzqYvl9rpQRO/cbc89WdazCm4KmHHASvZUxBHg/rFzc54Z5X2KR9ZNCfLDcmy225N0kvpRFvW28D2Ebfr56KYa1BiLingikssPa2gekubZss0tdvlH60xwF48mQB8cWJc8zyKoOrcnI3Pf/QyyZrV57Z0gr6oyUW7uBlVmhsYFssepjy2paSU9/HLpUSdwhjW5aM6A0MYGn8ZVOYGCLfJNWuFVhAvwd5yZeyODUKkDxZl/DcOSmEzgGm7+9WfdYqBpfbN7jGD7VuR52skr16hyaIKOuSjn+fPlAWbM7FWGPsliPWu41mWGYbYBVpIwIcNJCwwaniD4LOmL3wzTCjiLjfSAiTRxKt0gchHueEfgjC25wHRMi11iN4bCfZgk3q66caKggaNv78wUg6oSlKxxthjZbm1FQVhmplUBOXMm9HpxIw00HO01Fxn5qg+iYc7PuWKgrpx83dl6oIiX4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR09MB9284.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(136003)(396003)(366004)(451199015)(83380400001)(66476007)(55016003)(66556008)(66946007)(86362001)(66446008)(76116006)(64756008)(41320700001)(6916009)(8676002)(71200400001)(6506007)(9686003)(186003)(26005)(7696005)(966005)(508600001)(33656002)(38070700005)(8936002)(52536014)(122000001)(5660300002)(4744005)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHQzamIyTVJvR05TSjMvYzBaTStNZWdMSkdwQVNPYjUrd1poc2NZYk5TSlJ0?=
 =?utf-8?B?ZUhodmU2NnFBbWVTR29nVktWLzczcHRpN2xTYkF5N1Q2czQvOFd1Q0s2cTAv?=
 =?utf-8?B?Njg4TllTM2U5TysvL2gybkVPanhDNlF3TUpwSWUrS2VrQjhvN2M5SG51TTJ4?=
 =?utf-8?B?WnhMNSt2OThLYUxReXh6OHZvKzk2WmNXbWhyRGYxS2ZXdXlOSmJsdWdFei9X?=
 =?utf-8?B?YlBIVkNSWW5UcGZvZFEzbXdwRFlNemY2bDJrWmhUdkhmaVJPT3Y3bjVYNGhy?=
 =?utf-8?B?ck9WN01oZnpzMDZHdHdqS3N4L2ZLVGRXNFdWdEh3aTBtam1KZmJQRlhTZUow?=
 =?utf-8?B?Q0F2MXNyS1A3cys3SEZmblowOVlqSFJmNFN2R29KT3Mxcnl0SE1zMkxQZytD?=
 =?utf-8?B?L0V3enZjYytjQ1NUcUhTaXh3dTMrVEwwWkFaU015blRvQ0IwekRETXhBaGIr?=
 =?utf-8?B?KzRmRHUvTUVvVW1WYXE0cWFLeVJaL1JuM3NGYVY3QzVSblR4cU9RdWRJMmhk?=
 =?utf-8?B?UFZqRFlaVGNlZHRiRXZiSVNNcVFqMk9zR2dkL1lqanMxUGJOdU12TUFrbnpE?=
 =?utf-8?B?d0JTanBtQXduWHhOazU1b05JUGJrQXZFN0VHU0ZsSlNTYnUwbXFjR3RPRzNZ?=
 =?utf-8?B?R0xweDJSVXZxY3VTd2xUbkNOMkZhckZ3M21hV1JkaW1Sb21xVW93UXRSak4w?=
 =?utf-8?B?eVdCSjFCUDRYWCtiYjlMTkJYK2RIRWt5SUI5OUtvNzVNZEVsSjVBY0k3b3Ro?=
 =?utf-8?B?U3dFQ2ZCOVV5VCt3cC9oc2hKejdPbkp2U002dml0YmVlaFpWelY3SmNnbmIw?=
 =?utf-8?B?WGpIdklIeFZTcWRCQlBmeTdPV1ZDYmphTmRhbXVDT01HYzU0TlVSZ0JLenBa?=
 =?utf-8?B?by9qTjlSTkR4OTA4RkNNSHZzRVB3TE5hSDlEUThDOTJ4d0ZpcitMMG44ekt6?=
 =?utf-8?B?cjhKSmJjd2k2U1lsTWg1Y0JxVVFldEoySHltSE0wL1FnV056bERpQmxxbnIz?=
 =?utf-8?B?V0UyTS80ZHlkeG9tRStUS2tHNmxVQWQ4SE1OOFhkZjRKQUw2cVB1OVNweVp2?=
 =?utf-8?B?eFIzTlozOTIrYmdyajBkNEwrREtaSUt5NnFha29IZU84ODE3a2ttbGdnamlK?=
 =?utf-8?B?Qy8wZk82VDBua082ZkJCTW1EWkVCVzdJTG9LVm11Y0daZm5QYTZ1MUIrRENs?=
 =?utf-8?B?WTNQd2ZmRDFKU3lKbGg0cFNOUHk3ZDdGSmt1MEdQNnFwd2ZEZzVNRkNHd29r?=
 =?utf-8?B?T3ZnSG5kcTloWnR3ZE9tRUZwY1diZUcrdzBIdlJCWXRIdCtxRmovMlJ0ZDJy?=
 =?utf-8?B?OGlFWXRKbEs3VmZyaXU3dHZWUGJNRU5hTTFQVGNHaDRFZkVueGJUamlmem5W?=
 =?utf-8?B?MlBmWUF4Sk5pdS8zckpmVG5OWGUrV2RSRXY2RXZOREZyeE8xa3RqQTA2SytU?=
 =?utf-8?B?ZU5nNHlvYU9acjN3SmVicmNmVDBxWjVYOVUzeElQczVXZjJwdllqY1hUTSsr?=
 =?utf-8?B?cHZKa0JlY0UzbmxsYXlBVzNXYThVaSs1RHB2TExmTDVhb2tVdUQ5c0ZrZjda?=
 =?utf-8?B?NmxmVVA5UE5NT3JUaTJqMCtTa3RzQVRjSGFRMEJmNDBzaSt0eFhVVGFqRlNT?=
 =?utf-8?B?ZndtaWhRNWI3UFM2ZnZoWmpHSXhUblpBRFZ1dWtDRTJKU2ZFL05ua2ExNnZs?=
 =?utf-8?B?TTVSdmpqdVFuZHJ5YXE2dGNuTjFmVmIvRkVlc0RxKytqUzlXN2QwYTc2emk3?=
 =?utf-8?B?QjZkb3V5MzdvMFdlbDRMZ3phYXlFRVJycFJabHVUak5iOHlwY3VBM3RRd3Jz?=
 =?utf-8?B?ck9TM0FHOGtXNkJobXBCOTEzY01SSWdqZ0hRbEpidkVvNmkxQklmVXphczg4?=
 =?utf-8?B?eFJXK0VYQ25sUlVzTHVLLzFsWkxZR0ovNmhsdExEbGZqV1dpdE9wckxHOE1n?=
 =?utf-8?B?Q1VBQS85bHB1NVZXYWZ2N2JaTFRUeG9DZDB0ZndSNkgxS0puZ2pISW12NWVR?=
 =?utf-8?B?OEpZNTRxNElWYWNaR2F2REUwUmVST2NCM1M4ckpReHNpUnNiNlpDRmI4Q0Jm?=
 =?utf-8?B?QTYyMDhmeU95L2poOWNVbFZ4b1MvY2NEZzdxYm9ROGVsRVVrMzN4SkY2UEF5?=
 =?utf-8?Q?Q6Vzy8CZKaqhxrl0N6fT9EeBk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: redcom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR09MB9284.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fc9ef5-d716-4178-f028-08dafd72fb7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 18:52:31.3598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86200ba5-6348-4d6f-bdd7-96f43e8d9247
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB7383
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBiZWxpZXZlIHRoZXJlIGlzIGEgYnVnIGluIHRoZSBzdGFydHVwIGZ1bmN0aW9uIG9mIHRoZSBz
YzE2aXM3eHggZHJpdmVyIGNvZGUuICBJJ3ZlIGZvcmtlZCB0aGUgcmVwbyBhbmQgbWFkZSBjaGFu
Z2VzIHdpdGggYSBkZXNjcmlwdGl2ZSBjb21tZW50IGhlcmU6IGh0dHBzOi8vZ2l0aHViLmNvbS90
b3J2YWxkcy9saW51eC9jb21taXQvN2E5YzhmMjQwZWZhNGQzZDQ5YWI1YjUyYWMxY2ZiZTc5YTcw
MWFjYg0KDQpUbyBzdW1tYXJpemUgaGVyZSwgdGhlIGRhdGEgc2hlZXQgZm9yIHRoZSBwYXJ0IHNh
eXMgdGhhdCB0aGUgTUNSIHJlZ2lzdGVyIGNhbiBvbmx5IGJlIGFjY2Vzc2VkIHdoZW4gTENSWzBd
IGlzIGNsZWFyZWQsIGFuZCB0aGUgZnVuY3Rpb24gd2FzIGF0dGVtcHRpbmcgdG8gYWNjZXNzIGl0
IHdpdGggTENSIHNldCB0byAweGJmLg0KDQpOb3RlIHRoYXQgSSBhbSBub3QgY3VycmVudGx5IHVz
aW5nIGxpbnV4LCBhbmQgZG9uJ3QgaGF2ZSBoYXJkd2FyZSB0byB0ZXN0IHRoaXMgb24uICBJIGZv
dW5kIGl0IGFzIGEgcmVzdWx0IG9mIHNlYXJjaGluZyBmb3IgY29kZSB0byBjb21wYXJlIHdpdGgg
YSBsb2NhbCBkcml2ZXIgaW1wbGVtZW50YXRpb24gb24gRnJlZUJTRCBydW5uaW5nIG9uIGN1c3Rv
bSBoYXJkd2FyZS4NCg0KUGxlYXNlIENDIG1lIGFzIEkgZ2V0IGZhaWx1cmVzIHdoZW4gdHJ5aW5n
IHRvIHN1YnNjcmliZSB0byB0aGUgbGlzdC4NCg==
