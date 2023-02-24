Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20306A1F43
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBXQC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBXQC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:02:56 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D76D9E;
        Fri, 24 Feb 2023 08:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677254572; x=1708790572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OK6xVD4pu1D+hp96pEtt4aikEhMk/fdUn8KWKayYOIA=;
  b=q2tAnA1oZatPuk5BHtTz36LXYWxAPcH8jM8KC3BfppOQnWErHEYLdLri
   QHOt9QfllbUlP3LfAD6DSU6sP4g9ryQt8ZVE/udUcI3I6r1++JksII7QN
   Y93DwOMzWzqk5q7v8jgDZKcmkDMJ/WaOeCgKNmjqFCVpIZGaXt8hVBfzI
   HFgZgMRGwoKZdtyWzQsQxjfw1T2X5CUSnP+mZ0EYDhP8gspuESmlseQfU
   Dp+K7oUL8xbzQOHDQj/87IN6xTcb+vcFWX719p3rn8aZ3hqxgPogbPaDa
   CaaeoKoJR9fxWATHxuBWToO0CMKxYA3ipV0eokcBOZf7HnzWdyOhsIOjD
   A==;
X-IronPort-AV: E=Sophos;i="5.97,325,1669046400"; 
   d="scan'208";a="224155037"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2023 00:02:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFrsKxmkbULajdwm8GPCoQmxWUoHJ7SUB79Aji55OfXHjEiywAPU9azW5xh/1UspyL8WL8CJwMkGCgrNk7E4FL+Rv8j9zpwzDko8DoswjflT+YSb5CS1Mc85sEdjo7gyx8PHaZG60l/178TDkQbINqunB0RZaykDrCYLx1slJt36EThcmia3GdlaTMf6nWSO6SDh31mfKe0OcrSC7whY1hmM4m2FGVVhCDKlJPQF663+PdTvMydvdQpjpML3RTjFRkDDvJAiLu3w/JxA9w5OCE6dflzPV+Qqr11vvnRoK4CpmdWRfY2agGor04STwaR2Jp9wQX1f+mQBT+ygmwpC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK6xVD4pu1D+hp96pEtt4aikEhMk/fdUn8KWKayYOIA=;
 b=FwsJ8NjPzdpZKRkTmOU+boqhOZo8DslElB/TSZHbI2mHIG/VybRyzJ2PyMalQ4FNwLxZf/2JxOHA0xKzugJMcSJoB2EJWpDgQ357JxsrHRHAzeudI8ltWiA5jUxC11dedBQKe77CGf2cKhtys8EDGHMxc71aYJI0Omor5nJ5Aq+ACfIb8WT6R1b/FZzq/HkU950C2z/JuovbWeCKAUIgv/JGwjkQ+CoqkLvcGcI9zvJsofrmrktmjMFP4VA7EZ0aNPGYUtPC+nYDsjGgLffVB4gbEFA5uZHHf0ZEipzIQEQBcIedNR+I+ckyO2MdWU3g/brGDVtJsH13BscScfWgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK6xVD4pu1D+hp96pEtt4aikEhMk/fdUn8KWKayYOIA=;
 b=pqbKEUzWo7awb/KpkBRVj302QIpJ9e8kdR1KpfohVRQCpbUG822V2MGK2R5c14KALS2OHBU+BdHyDW81BOtD99n7dCtEDk+c23voEUCA0OnfxmjPKHTwt8UT7tqrlg6//8EA/cHTZf9QMreKob080tVWTTedKMn4uy6GMZ0CT8M=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB7036.namprd04.prod.outlook.com (2603:10b6:5:24d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 16:02:46 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a%7]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 16:02:46 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: ublk: enable zoned storage support
Thread-Topic: [PATCH] block: ublk: enable zoned storage support
Thread-Index: AQHZSGgyrRYNUqNJ0E+BNxJDaEh1M67eQgsA
Date:   Fri, 24 Feb 2023 16:02:45 +0000
Message-ID: <Y/jfpKyntm9KSBVo@x1-carbon>
References: <20230224125950.214779-1-nmi@metaspace.dk>
 <Y/jdkCR4ug7iZZ+L@x1-carbon>
In-Reply-To: <Y/jdkCR4ug7iZZ+L@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB7036:EE_
x-ms-office365-filtering-correlation-id: de06a01c-e08e-4966-46cc-08db168091c6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fUAqM6tXVQQnm/wl3JMuTUtu4iRkrRE6fbOB3Jw2pcMietDB5Grt3yB3VlqA+2JgRdF5Zm15B1Ds8Ygakv3tED+jDP977+N9SW0+A20iuhXh3SgCk1yKA36XFlAEqcgLEeGPo71TJCuwUY8GBHokTKvisHne4jLochh/g+Yo7rPRJ4pb5Vojh3jGncoptW55OABTTNeygnumfODPJHtglQk1Qp3SJe8H8S4bTuCaKcGNuiZuPwjogOSAuvFFlMBt5gbcr5dX5qbGeX7orbPxRQM1td+DFD9a6NnH3pDbg3+MPcA+wT5frEbBPamhu5a3DCCUX1wx+f7i1ED2pnLV83+6adOSyB8fMXhTJB6Jt+F6nYcv3eyMPSzuY2aQYMTM2hjgUntIGBf387uAADncYz6LWW78q56HoOY/rl5GDlEE/sWSI9e/oD+7u26N3HU4ibwc1aT0v6hgvzy8UX1gYEbVz15x67v5CCgohdN9TAH4VVyX5HR1OKKieBFPs/xpsXeoI8wD69tV/HGWTZI3X6pcJUw7ZJZ9LpjOyGsmM+bN4N+/XwmmkEOtDZbcY5BKSrP+vagHZSu35txzoeGbNbIq7p7DRy0tFdmngxuBye1NChFhb4IFBkxTtUrP/OWT8c4JzoWWOPRV5t49my1idefkNKgVueGWIsdRSx/YmV1URAjvzpc7lU3Ge8xwr/Rp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199018)(33716001)(2906002)(82960400001)(38100700002)(122000001)(86362001)(64756008)(478600001)(6486002)(966005)(71200400001)(186003)(9686003)(26005)(38070700005)(66446008)(91956017)(76116006)(66556008)(66946007)(83380400001)(54906003)(6512007)(6916009)(4326008)(6506007)(66476007)(41300700001)(8936002)(316002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUNiNWtiMzNnQ0xYaGJBejJaNzY5ZnRjSDV3VUJZK0dTaFAzVit3ZDBBWVNL?=
 =?utf-8?B?N1lFK1pTTnptdXVFY21YYitsaStzSFlqTFlZVktFRGpXSE1VM1BHaEpZU3h5?=
 =?utf-8?B?czFOQ2t4VUhMMHRaUTZNSlViZXVLa3hwU3Z1YWo0MktMalh4QjRaUWV4dHlB?=
 =?utf-8?B?SnM2K2xJSkFNM0tGenkxRVJpMTgydkdXWmtMcmJuU2RWZEkyWW1UZFZuQ3pu?=
 =?utf-8?B?ZkQxQ1JXTWkyV1ErVkoxajBtanpCeVBTbEFINXpBVlRJMk9xNU1pWnpWajd3?=
 =?utf-8?B?ZUJTMmdFU2hDY0tNVjJCZkpVQW9icjZBTDVXUTFuRE1BUGtydjV1U1FCcHdk?=
 =?utf-8?B?SjlDYWFTQkdEbWlFRmNaK2tHWVBUWHBCaVFsbVNSUkxwcmRNYThZTEtkUm1m?=
 =?utf-8?B?azdyVjNPcXA1UlpzOGVBcHMwMWh3aHRZVlJ2N1M1NG5DSTNaekxnWklCZWZp?=
 =?utf-8?B?aFZNanpGckpjRW1WZE5yQjlDdm84OGZYQ2hzakN2b1ZRdlh5UWhzektaZXF0?=
 =?utf-8?B?bFNBQks0UEwxVTQyc2s2YlczM3BCVDd0M3FwUlhUUnRlckl2N1NmNTlCN2FU?=
 =?utf-8?B?M0h3K2xNTlBZRldoWFNRaU80TndNTVN6R0xVS2Q5UnQzMVBaQytHU0lSNGow?=
 =?utf-8?B?c2hKVGNmb1JjeHZVcDVoamxnTlh5dEhCRVRQNnBtZUNhYkF0RlVvMndlV2dm?=
 =?utf-8?B?c0J3MzloUC9QdmNnWjd0ejNMM0RXMVI2YXhncTZ2dEJGTGtVUGxDT2paYjk1?=
 =?utf-8?B?RWF2WHNOTHdPK0tSRWpGaFVFQ3V5OXdsTEVHRU5wa2g5OUdHcXhtL3ZpeHgv?=
 =?utf-8?B?WUpVbFVCb2RvQXl1am5qMGcwbU5YaHFWT3FyWjJybFc4bkZNRitvTGlqR0hw?=
 =?utf-8?B?NjB5QldoWTNzdUhqa1hibWdmOWMzMzVydXk1OXBXVVBYckM3aVd5YkhORjVl?=
 =?utf-8?B?V2dURmlTVDNwdERpRncwS1dSR0dUQmNpM3VhakNtcFNITzh6eHZpbGl4YWs4?=
 =?utf-8?B?WGFYWjZadmhhNUZ3YVpDa1E4L2Q2NmpRVndNQnRWNWJKaG94NEFYREpFYUxm?=
 =?utf-8?B?eUNTbHNGOTlYQk9XY0tDdHhzRHBNYXRjandzeTNrU1dWTDFwWWZVQ2ZNblZV?=
 =?utf-8?B?eXhXampEb0pyOWo1RnZCVDg4NFc2NUVROEVIenMycitUa3VPQVIxTFJVV2wx?=
 =?utf-8?B?M0pySnYvd1Ayck1JakdmMjh5aFNXbG1CNHJIZnZlaCtiMU1CbUlhcVBia2xD?=
 =?utf-8?B?elowb3cvVndKVXYzck1sazFwN1VWVHNDemFIYXNkUU0rZTRLdC9HV2dwSm9B?=
 =?utf-8?B?ODhXbXhMNWFWQTRzMjFNMXV0NFFFeit4aXpCenVYMjdGTWxCOFFYMDZkdkpO?=
 =?utf-8?B?MWhBUVg5TEt0Vk13dEZZWUc0N3h3bXNaRW1KMDJqT1drUTA5SE9STUxDN3V1?=
 =?utf-8?B?bUVPdndPeUJqaGFlUGhHU2xld0hJZXZXSXZ1V3dEY24wZWdGaWdxSUtxanND?=
 =?utf-8?B?bnNOdUxLQ2dmT1Y5S2V5TXdHc2tlRFl6dlNiYmh3SW8rWkRZOGdZYXRYamNF?=
 =?utf-8?B?UUFoYzlIczk2TnFZcFhjU3hGajIrenhMRE1QRERuTWRRSDZ0ZWJzUmIzUFpz?=
 =?utf-8?B?dEhxU2RDQUlMT0E0ZEhVRXB5NS9HZkZpQnNuVjVHOTFTbC8vZDlmS2x6ODZM?=
 =?utf-8?B?QUpwM3lSUk9tdzJFS3I1Y2xISEZHNHNUV3pzZlo4Z080QktGdXNUU2tkelN0?=
 =?utf-8?B?dFZXNkYyaUwya2kyWFdmNDg5Ukl2YlplNUpSaHpHbXIxMzY0K1RUMUVjdnV6?=
 =?utf-8?B?dWszQ0ZZdG4yRCtpMGovU0Y1cC9oUE1UdytueVFSQ1JQWVdLR1h2bjVRbGdo?=
 =?utf-8?B?ZTk2U242SjlZb1ozQmhXS29yUm5tbC9EUkUxTnBNb1lPVGR0QnZ2UGNKc1NN?=
 =?utf-8?B?cjBNdTE0YStpYk41Z2k3Y0FxeWNFZ2hlWk1kUkphMTZ6LzRubVF2VFBUUStE?=
 =?utf-8?B?YTJQQStEQUhkMmhyaC92cVE2ZVdZRnJFUmZLS1Qwd0greDQ2NUJMUnY5THEr?=
 =?utf-8?B?MEh2eW96Rk9FY2R2WTZBbWVvTzR6Ykh6RGNRQlJTbWloQ3hkaXNiU0UwaG8y?=
 =?utf-8?B?eVRUYS9xNjk5MzVaWmRQTUpWUmJla0U3c0JwaU05bU8yWmJMRmR6a05UZ1Ax?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C9823D7073F264D93AB80C9D2395037@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gglZx2NU0VevKmEsr0khwgONItIGuu8j05J+y/VR7pOpsMfEmGaxzIiht9Y7c5LC/Z2Y+gfS+PakfwZGa5xW7pgqdNHkBIiNSitoHAbQutFosKuGaXLn1oUzuNxBl8Yo4ltuWM5m4L4eZY9J3/15a7gbsDZWgrkzqjc5JvUJgJYBjbYsK9Fd5Vnis5kpP+HiSY/fm25zJfcKQ80GzexlTPX7d5t2GTcEJbwebJcHzwUnorEa/XEbiVQK5xaSdt2tyrAeoeG9GZZv1G30G1i/EewZXPUi9zerOZpkpPVLOAu7HZrSLe+g/fwwYhC67ga5U9d8ZYIds6rbvaYaSJHDZlcKX39vwxQ5WpJ5GgDql17cWZ2qHYOX/e+Zh8Ra9t4H3mEFqvbhayuh3wQmxTZg2C1Yn/H3bMBOo1NqGdbg6NdQ431Rhcch3xNYdQ8TUjL7KXnSTozKuMJRWvTLavw6lqv1hEyIRHuLzqpHw03Kq3Bme8gn5wkbqEkXEEr8L7hgO+9dMq39VDS5NqXwWCyuc3P5vUuau3bcamlxUNYj0Agdh9b5H/utU1F37FOWqtpNtBZ9Zsfe9eoHItpsyGKbZNMNNLbDS/3qhda3VFK55tMwByUCmnwITRu1CCG+bCtA36ZaUMoo8XwaeS/zBsv/DW+v6irGssn48GPuA0pjThFfrEWpkX4KwqP0zeQqqCFQC2FpWcZatf/yBQ7COzWq3DhSiFUq1Kn0C36J7zXjTr64FLtaJnlRNHP6JpZ8FbP9GwWophL4SmH+7/Qo64CqME1G0uqTYKIIUksSyvbMs+5EYYvNZmEfjck/U3VRfNgEDTdT8vcCIakGjKbr6qAp3GUDEYnxeaarGjNlTeiew68L2nqPTx0hSdLiFcnxX8YTzfY/vO8Jx1Ola2EzlPabXQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de06a01c-e08e-4966-46cc-08db168091c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 16:02:46.0060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rltRHihHf8XMAYpZnH0gM6pYj5aQDwqJpfbPh/5jtMGoh/bXt2nrHznqU3sC2EKN6fz2EWpTgnfOKXqr9pzPdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7036
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBGZWIgMjQsIDIwMjMgYXQgMDQ6NTM6NTJQTSArMDEwMCwgTmlrbGFzIENhc3NlbCB3
cm90ZToNCj4gSGVsbG8gQW5kcmVhcywNCj4gDQo+IE9uIEZyaSwgRmViIDI0LCAyMDIzIGF0IDAx
OjU5OjUwUE0gKzAxMDAsIEFuZHJlYXMgSGluZGJvcmcgd3JvdGU6DQo+ID4gQWRkIHpvbmVkIHN0
b3JhZ2Ugc3VwcG9ydCB0byB1YmxrOiByZXBvcnRfem9uZXMgYW5kIG9wZXJhdGlvbnM6DQo+ID4g
IC0gUkVRX09QX1pPTkVfT1BFTg0KPiA+ICAtIFJFUV9PUF9aT05FX0NMT1NFDQo+ID4gIC0gUkVR
X09QX1pPTkVfRklOSVNIDQo+ID4gIC0gUkVRX09QX1pPTkVfUkVTRVQNCj4gPiANCj4gPiBUaGlz
IGFsbG93cyBpbXBsZW1lbnRhdGlvbiBvZiB6b25lZCBzdG9yYWdlIGRldmljZXMgaW4gdXNlciBz
cGFjZS4gQW4NCj4gPiBleGFtcGxlIHVzZXIgc3BhY2UgaW1wbGVtZW50YXRpb24gYmFzZWQgb24g
dWJkc3J2IGlzIGF2YWlsYWJsZSBbMV0uDQo+ID4gDQo+ID4gWzFdIGh0dHBzOi8vZ2l0aHViLmNv
bS9tZXRhc3BhY2UvdWJkc3J2L2NvbW1pdC8xNGEyYjcwOGY3NGY3MGNmZWNiMDc2ZDkyZTY4MGRj
NzE4Y2MxZjZkDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBIaW5kYm9yZyA8YS5o
aW5kYm9yZ0BzYW1zdW5nLmNvbT4NCj4gPiAtLS0NCj4gDQo+IERpZCB5b3UgdHJ5IHRvIGJ1aWxk
IHRoaXMgcGF0Y2ggd2l0aCBDT05GSUdfQkxLX0RFVl9aT05FRCBkaXNhYmxlZD8NCj4gDQo+IEkg
Z290IHRoZSBmb2xsb3dpbmcgYnVpbGQgZXJyb3JzIHdoZW4gYnVpbGRpbmcgaXQgb24gdG9wIG9m
IHZhbmlsbGEgdjYuMg0KPiB3aGVuIENPTkZJR19CTEtfREVWX1pPTkVEIGlzIGRpc2FibGVkOg0K
PiANCj4gZHJpdmVycy9ibG9jay91YmxrX2Rydi5jOiBJbiBmdW5jdGlvbiDigJh1YmxrX2Rldl9w
YXJhbV9iYXNpY19hcHBseeKAmToNCj4gZHJpdmVycy9ibG9jay91YmxrX2Rydi5jOjIyMToyODog
ZXJyb3I6IOKAmHN0cnVjdCBnZW5kaXNr4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYbnJfem9u
ZXPigJkNCj4gICAyMjEgfCAgICAgICAgICAgICAgICAgdWItPnViX2Rpc2stPm5yX3pvbmVzID0g
cC0+ZGV2X3NlY3RvcnMgLyBwLT5jaHVua19zZWN0b3JzOw0KPiAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF5+DQo+IGRyaXZlcnMvYmxvY2svdWJsa19kcnYuYzogSW4gZnVuY3Rp
b24g4oCYdWJsa19kZXZfcGFyYW1fem9uZWRfYXBwbHnigJk6DQo+IGRyaXZlcnMvYmxvY2svdWJs
a19kcnYuYzoyNDQ6MTc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDi
gJhkaXNrX3NldF9tYXhfYWN0aXZlX3pvbmVz4oCZOyBkaWQgeW91IG1lYW4g4oCYYmRldl9tYXhf
YWN0aXZlX3pvbmVz4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0N
Cj4gICAyNDQgfCAgICAgICAgICAgICAgICAgZGlza19zZXRfbWF4X2FjdGl2ZV96b25lcyh1Yi0+
dWJfZGlzaywgcC0+bWF4X2FjdGl2ZV96b25lcyk7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAg
IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gICAgICAgfCAgICAgICAgICAgICAgICAgYmRl
dl9tYXhfYWN0aXZlX3pvbmVzDQo+IGRyaXZlcnMvYmxvY2svdWJsa19kcnYuYzoyNDU6MTc6IGVy
cm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhkaXNrX3NldF9tYXhfb3Bl
bl96b25lc+KAmTsgZGlkIHlvdSBtZWFuIOKAmGJkZXZfbWF4X29wZW5fem9uZXPigJk/IFstV2Vy
cm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAgIDI0NSB8ICAgICAgICAgICAg
ICAgICBkaXNrX3NldF9tYXhfb3Blbl96b25lcyh1Yi0+dWJfZGlzaywgcC0+bWF4X29wZW5fem9u
ZXMpOw0KPiANCg0KVGhlIHByb2JsZW0gaGVyZSBpcyBwcm9iYWJseSB0aGF0IGJsa2Rldi5oIGRv
ZXMgbm90IGhhdmUgZHVtbXkgZnVuY3Rpb25zIGZvcg0KZGlza19zZXRfbWF4X2FjdGl2ZV96b25l
cygpIGFuZCBkaXNrX3NldF9tYXhfb3Blbl96b25lcygpDQoNCmluIHRoZToNCiNlbHNlIC8qIENP
TkZJR19CTEtfREVWX1pPTkVEICovDQpjYXNlLg0KDQpJIGRvIHNlZSBkdW1teSBmdW5jdGlvbnMg
aW4gYmxrZGV2LmggZm9yIGRpc2tfbnJfem9uZXMoKSwgZGlza196b25lX2lzX3NlcSgpDQphbmQg
ZGlza196b25lX25vKCkgd2hlbiBDT05GSUdfQkxLX0RFVl9aT05FRCBpcyBub3Qgc2V0Lg0KDQoN
CktpbmQgcmVnYXJkcywNCk5pa2xhcw==
