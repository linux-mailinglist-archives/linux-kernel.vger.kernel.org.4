Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329EC711782
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbjEYThA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbjEYTg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:36:56 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51687122
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:36:24 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PDTK6j012903;
        Thu, 25 May 2023 21:35:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=nPfJWupeLhcNH2ScXWIKQIaxQqD038z9+16uwgIqehc=;
 b=iWBltJJ6qNnYuXGFC6Jt8w3Qpw/BdWVevlWubsuI4Ckc8rGtF/PuyZGrPJCy3WDTVw/Q
 KHXEBHeg6udXvMnxVsjV5gmrf8uOes4MU1vQVWCAE8ysXeyoNXT6HiRiKpIun10iw2OM
 jY78639NCSgUIOgyPmkMr0eqNQHIMbSlKeLiOYtBHBpcQWrvMaB5tPX7DExvfIjTv+WG
 mK29xswYP29A6sTioaELQ0WpoHCcj0ls8dqUvAaVHJhLQXQ+ntPsqMAzKKm+WD7mDmYI
 TtQMSaQH+u96Jl5tVKwOy/IR6bcdCeOe5lIasKFGsNAH0L503cMneUsHIz/Avs/bZnHd kg== 
Received: from eur04-db3-obe.outbound.protection.outlook.com (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qt39tvfuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 21:35:04 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahzKtKJHYyGj5Yj72DbR8s8soTdMbemBODKQz4Y3wtpbXqs1TJzKWGdt/uSd7V3Huuiry7jI8zWWzQ2JX8LEX1ubb8YmUmuMA1jOzVH7dn6GCKLE/qnKmccjso+I/cTHt/RwOv8T9vvPBdE9TDuMz2y8714+FQcDcVKtz1dcanlhIQPyS+DJ0FjbDSXEI73pH6VRtZ5BCI+E6+GkEiOM+LKlTYfqhfQBpfpbKfbFj4grDxPdKsW0T0GxBdheaawHCkw+/ssjPmGYDzP9beiVq0nfBDTLMD0ak9XYoKj5nV9gh21GgeMbGs5oJGlMeOWd6aLiSJ2rlC35UF28fotBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPfJWupeLhcNH2ScXWIKQIaxQqD038z9+16uwgIqehc=;
 b=NmlQTi5o9VPz0PnkrdS5kl69axOHobgfJHfNCETlfsQOovHvRawuPxNenlIYIEhWBMR3rPODQ8QHV+nS2JAT3GkxolcdzyENrZdTbUhNL1BQ/hm1ykAvpF0P0JCwNsl2I9L5RQAVVJgQ1MGZDmYpvYUD5HIJfNS2lWRrwLGdkYYry8nM5YULJ29kcaEWw1j+dg9+UZqZkv24R9ZunxRiSJmU6OZebhblyq0Fde2m8AeOf9LJ2LDHem9bC5slB1ZQzgpwFi8XgGe0EOsbh7Fiil7BDbco+0rrgbwYr0p/pRut5Z1/DJYE/P8qz1EE9GAURB3QsroC1gGQUc/sXMpG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by AS4PR10MB6136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:587::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 19:35:03 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a9f5:ed2:136d:e80d]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a9f5:ed2:136d:e80d%5]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 19:35:02 +0000
From:   Etienne CARRIERE <etienne.carriere@st.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
CC:     Sumit Garg <sumit.garg@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Subject: RE: [PATCH v9 3/4] tee: optee: support tracking system threads
Thread-Topic: [PATCH v9 3/4] tee: optee: support tracking system threads
Thread-Index: AQHZjUXixbe5W5+830uXcQHXDNiQ/q9pCREAgAHWVN+AAD7pAIAARc9Y
Date:   Thu, 25 May 2023 19:35:01 +0000
Message-ID: <PAXPR10MB46872AD9A798A1B7DAF4721DFD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20230517143311.585080-1-sumit.garg@linaro.org>
 <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
 <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com>
 <PAXPR10MB468715EB2B1DFE080F380266FD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <CAHUa44FDs-cukERVwev88i855Y-ZaAkLUt=bVxah=GdW+JKVLQ@mail.gmail.com>
In-Reply-To: <CAHUa44FDs-cukERVwev88i855Y-ZaAkLUt=bVxah=GdW+JKVLQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=True;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2023-05-25T19:35:00.880Z;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=ST
 Restricted;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=0;MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|AS4PR10MB6136:EE_
x-ms-office365-filtering-correlation-id: 1f4dce85-8d75-4569-3e9f-08db5d5721c0
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xe1NpvVnuJ9eaykPOGqZpIMpBIEficOF5ylb3f7MxwcYcpmRDsJlyEF0386wtOT2xRmkn+ZJ1mkT+/e6Dyi0Lbtv9aZ6QFtW1hoCNaVrg1MBfC89TWYKPfYQJb1hm4S7NTpXr2Pv1zGbi6FMdFVjVWtv/EoRi0M1hcYxM1zol2fmWuWByZOQo0Yc0BEi6Q8h9Ap/G3ONH8idvIn0DLnkbyos9g3DAupzSuVr+BgA1uIKcouJFtpVmpxLuh0epl72S6oEzXrcEP/4ezN6GNj/90xrcZpkD+HzyI6ALTf+FMG62x1Ux8/aeml+Ok22kQR0qteNKG16jWGmIZjN6p2ydSojCzjBoJBzq0V5lDVMWqsAtZNBMp7e+2wXWL34NursbudGsFuMACK/mNXMmRit8gmhWYKtOK9SP/g0XnmeCcP9Fz4sKtqoaQq+znfODZWalVjFDtcXAngoWkgFs+UCTvphqT3lPlKHE/oZglQ93KOHv0h3wMFakjrlqdlSSFjvV8pN8IoblKRkMNrT1QFOvPre3EAFNzIYh0MPwQMnqfUsj13M18VCVELT7TCmxIB2aEzZkpfdm87Cne3wW0CpjyOaNes3oq49tW3QCrLrZEJ9ym/Ja0eTmzS3mhiM2ZTI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(52536014)(5660300002)(2906002)(8936002)(316002)(66946007)(4326008)(6916009)(64756008)(66899021)(66476007)(66556008)(66446008)(91956017)(54906003)(8676002)(478600001)(33656002)(83380400001)(76116006)(71200400001)(26005)(186003)(9686003)(6506007)(41300700001)(55016003)(86362001)(38070700005)(38100700002)(7696005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFpCcGVUWElQa2w1Yit4emhtUmNaeDRpMEZ6cGJZVVBldjUyK1FTenF6Skgy?=
 =?utf-8?B?MFRjRUF0SGR6OVdpeGJoamN5N2RudXZtRlJZb1BkZ2N2VWZPVWY5aU96aEo5?=
 =?utf-8?B?dFU1T1NCcUl0ZWdTWUducEhFMERBQm1NZW9qdytTMzBmRkJrUWZ3bG9HaTdO?=
 =?utf-8?B?YkNmbVZsaHZha3RVdmthRHdhd1RrRSt6MUJqaWtnQkJ3dGo4cERLS3FTcXRm?=
 =?utf-8?B?TEtmZjl1NTBFRlBVNDRQNFNPODRFd1p3TURjN3JlaTYwSEdPYlNkY0hiRkt3?=
 =?utf-8?B?MDFHTkE3N2NWdlBrZFZXWmI2L3E2K2x5RnBtdXVYVE05RDRuK1k2RUhvQzlj?=
 =?utf-8?B?SWdCc2lJMUdFVm9ZeG03T0JHaXJidDBPNDJoU04vc1hwZEhWVlV0NU50emdt?=
 =?utf-8?B?NlhFdngvWmNFRFl0V0FzQ2IvMlo2Z0czZ2pDOWNiYjFIeU1CRWtCTlM5OUNZ?=
 =?utf-8?B?Nms5ckV4VUd1RU11UUh6UnVZNEtHSkZMbGs3bjdjUW52MmVIQU90S0IwUkNH?=
 =?utf-8?B?Mkc0NTlJcTVCdUQ1VTFUUVcwS2hCRlRNVmZHdU1nVGU0dUtJRk9nN3E2T3Z3?=
 =?utf-8?B?WHduRE93b0hmTjNPSjA2SWZBR2J4aGVNTS8zdGF5bzFGckhiTlVFZlE5RDZ1?=
 =?utf-8?B?d2F2TFBoS05XS3gxQzdRdG5LTjh3SUdOY1V2eDU3bW5mZlg4S3NuQ3B1VlE1?=
 =?utf-8?B?SkZRbnE5ZkdBMlJBOWcyUjV0M0ljbmMvTHg5OWNuT0doOHlnVzZFQTBCaEs4?=
 =?utf-8?B?WHRzWnYvbnFCRG5PZ2V5cldEUWNSRUxUNGZPTFI3N1NuUDZycnl3cDR6eisv?=
 =?utf-8?B?VEx4ZWNIR1hLKzR6OGZrMy9FOUNpMHJyRVNBUG1iRzVKOWpLeTB6L2ZHNm9Q?=
 =?utf-8?B?bXFQWExINzBiOHM4cUZoSVB1c045Qzl5TlBFdFpsWkJzendicHkxZHpFZG16?=
 =?utf-8?B?NnoxM0ZiaHh4L25BK3E3WlBCSks1Wmo4c3lNamttYTNmWGxNdk9nYWpPR1FM?=
 =?utf-8?B?bVM0am5wL0x0NTlROUlHemFQdTBjamlzMy9yVkJ3NDBrSGZ1OTFvVVZSK0Yv?=
 =?utf-8?B?VjZ1YkdzRllwYzJnTEhhc2IxbENueDlCUnJCc0xzUU9saTNKY2lTaTRIdjc5?=
 =?utf-8?B?WDdnYnZPVisyZGVYTVJOM3k4bWFTQ2c3Tk5pdHJpeWM2d2NHQ3QyVmkvY3Bi?=
 =?utf-8?B?TG15bU0rZmNMM01jNGtndUNmSW1xMWxkMzVlN1VRYjRVelErWE05MDZGeHNp?=
 =?utf-8?B?MkNIUy9xT3crcWs0clpReXhrbWs0QmRiYlF1Y290cmFUMFNnb1ZlVG9wTTZS?=
 =?utf-8?B?S05UZ0Y5L2FmNER1aEdkMjhUTjNrczFuM3QyUEZTZ09wTDJ3VHNhQzFoVER4?=
 =?utf-8?B?aWljNUg1bHF3VmNtbEZtRDhTajNuYWZDWW5qWW5FcTlnNWRlRUUwNkI2Sklx?=
 =?utf-8?B?dm56dDZPUHNub1picHNIOFkwL0pCZUxncUdlUzRidldmUGd6cFJUbEtISWRh?=
 =?utf-8?B?VktTdlJndG1KRkxMWERrRzNSVDVlREZXVlViUVNaZHJkOWpFMXZ1b3QvSzdw?=
 =?utf-8?B?SEFScDdxWmdSR1BFQVNPYUxxMG96eGszcnJ3dDVHNnhoZ0lSUVlQWjh5UkVM?=
 =?utf-8?B?WkdzYUU5M3ovbGd2MEM5Z29TWnB6aGlJSVQ5dUJabjNtVEJIYk50QlFLK3lQ?=
 =?utf-8?B?YUtpaDFwYzEvTXZlc3VhRWpQWXNndFZHUmk5U1VSbGFVUEp5anJHRzBWb1NW?=
 =?utf-8?B?M3p6RE5GREZNRHYvVjE0RWJQY29hNk5DNWdyOVdFSHBxOWRqWEk0Zjh2Sk4z?=
 =?utf-8?B?NUVmaUt1ZWJZL0tLdGw0Rk1ybDJxaFYvVDIzVkw3b2Z1MTcwelVTU2dlc01q?=
 =?utf-8?B?b05ySWE3QzVrb2lhUVk2b09jYUFBeWk0bFFwSSt5WEpQK3BrcHFIUVlUd2JS?=
 =?utf-8?B?M2tndWhoZUhhMjdwMHliRjd3NTh1R2ZxTnlVckdLV3hXdVBGZ0F0OFExZito?=
 =?utf-8?B?QllzYnpabzlsWVdIWFVNeSsxeTIzWTczdytMNzR6bUdvWW9McERLbFR6NjdH?=
 =?utf-8?B?eDNVRVByT0krNDlFZURYdDAwcVIzSm0wcy9xaU9Bci9DZnoxelhyYkhNSUY3?=
 =?utf-8?Q?6pVR2ICrg6yerhxL4hXKGCX3c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4dce85-8d75-4569-3e9f-08db5d5721c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 19:35:01.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfZtO06ZfGzzrDtAnqESJ4Z6UptC+MeuOv+XeaRfRgBmZu8nHvq9ateE+xVBTcyG/VKrjKVyqwRuaetp6PpqoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6136
X-Proofpoint-GUID: EODBcpTzPnkuOwZtIb_wy7SbyFY6HJxD
X-Proofpoint-ORIG-GUID: EODBcpTzPnkuOwZtIb_wy7SbyFY6HJxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_12,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250165
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IERlOiBKZW5zIFdpa2xhbmRlciA8amVucy53aWtsYW5kZXJAbGluYXJvLm9yZz4NCj4gRW52
b3nDqSA6IGpldWRpIDI1IG1haSAyMDIzIDE3OjIwDQo+DQo+IEhpLA0KPg0KPiBPbiBUaHUsIE1h
eSAyNSwgMjAyMyBhdCAxOjQ44oCvUE0gRXRpZW5uZSBDQVJSSUVSRQ0KPiA8ZXRpZW5uZS5jYXJy
aWVyZUBzdC5jb20+IHdyb3RlOj4NCj4gPg0KPiA+ID4NCj4gPiA+IERlIDogU3VtaXQgR2FyZyA8
c3VtaXQuZ2FyZ0BsaW5hcm8ub3JnPg0KPiA+ID4gRW52b3nDqSA6IG1lcmNyZWRpIDI0IG1haSAy
MDIzIDA5OjMxDQo+ID4gPiA+IE9uIFR1ZSwgMjMgTWF5IDIwMjMgYXQgMTI6NDEsIEV0aWVubmUg
Q2FycmllcmUNCj4gPiA+IDxldGllbm5lLmNhcnJpZXJlQGxpbmFyby5vcmc+IHdyb3RlOg0KPiA+
ID4gPiBIZWxsbyBTdW1pdCwNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gT24gV2VkLCAxNyBN
YXkgMjAyMyBhdCAxNjozMywgU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0BsaW5hcm8ub3JnPiB3cm90
ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZyb206IEV0aWVubmUgQ2FycmllcmUgPGV0aWVubmUu
Y2FycmllcmVAbGluYXJvLm9yZz4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFkZHMgc3VwcG9ydCBp
biB0aGUgT1AtVEVFIGRyaXZlciB0byBrZWVwIHRyYWNrIG9mIHJlc2VydmVkIHN5c3RlbQ0KPiA+
ID4gPiA+IHRocmVhZHMuIFRoZSBvcHRlZV9jcV8qKCkgZnVuY3Rpb25zIGFyZSB1cGRhdGVkIHRv
IGhhbmRsZSB0aGlzIGlmDQo+ID4gPiA+ID4gZW5hYmxlZC4gVGhlIFNNQyBBQkkgcGFydCBvZiB0
aGUgZHJpdmVyIGVuYWJsZXMgdGhpcyB0cmFja2luZywgYnV0IHRoZQ0KPiA+ID4gPiA+IEZGLUEg
QUJJIHBhcnQgZG9lcyBub3QuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgbG9naWMgYWxsb3dz
IGF0bGVhc3QgMSBPUC1URUUgdGhyZWFkIGNhbiBiZSByZXNlcnZlZCB0byBURUUgc3lzdGVtDQo+
ID4gPiA+ID4gc2Vzc2lvbnMuIEZvciBzYWtlIG9mIHNpbXBsaWNpdHksIGluaXRpYWxpemF0aW9u
IG9mIGNhbGwgcXVldWUNCj4gPiA+ID4gPiBtYW5hZ2VtZW50IGlzIGZhY3Rvcml6ZWQgaW50byBu
ZXcgaGVscGVyIGZ1bmN0aW9uIG9wdGVlX2NxX2luaXQoKS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IENvLWRldmVsb3BlZC1ieTogSmVucyBXaWtsYW5kZXIgPGplbnMud2lrbGFuZGVyQGxpbmFyby5v
cmc+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmVucyBXaWtsYW5kZXIgPGplbnMud2lrbGFu
ZGVyQGxpbmFyby5vcmc+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRXRpZW5uZSBDYXJyaWVy
ZSA8ZXRpZW5uZS5jYXJyaWVyZUBsaW5hcm8ub3JnPg0KPiA+ID4gPiA+IENvLWRldmVsb3BlZC1i
eTogU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0BsaW5hcm8ub3JnPg0KPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAbGluYXJvLm9yZz4NCj4gPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IERpc2NsYWltZXI6IENvbXBpbGUgdGVzdGVkIG9ubHkNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IEhpIEV0aWVubmUsDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPdmVy
YWxsIHRoZSBpZGVhIHdlIGFncmVlZCB1cG9uIHdhcyBva2F5IGJ1dCB0aGUgaW1wbGVtZW50YXRp
b24gbG9va2VkDQo+ID4gPiA+ID4gY29tcGxleCB0byBtZS4gU28gSSB0aG91Z2h0IGl0IHdvdWxk
IGJlIGhhcmRlciB0byBleHBsYWluIHRoYXQgdmlhDQo+ID4gPiA+ID4gcmV2aWV3IGFuZCBJIGRl
Y2lkZWQgbXlzZWxmIHRvIGdpdmUgYSB0cnkgYXQgc2ltcGxpZmljYXRpb24uIEkgd291bGQNCj4g
PiA+ID4gPiBsaWtlIHlvdSB0byB0ZXN0IGl0IGlmIHRoaXMgc3RpbGwgYWRkcmVzc2VzIHRoZSBT
Q01JIGRlYWRsb2NrIHByb2JsZW0gb3INCj4gPiA+ID4gPiBub3QuIEFsc28sIGZlZWwgZnJlZSB0
byBpbmNsdWRlIHRoaXMgaW4geW91ciBwYXRjaHNldCBpZiBhbGwgZ29lcyBmaW5lDQo+ID4gPiA+
ID4gd3J0IHRlc3RpbmcuDQo+ID4gPiA+DQo+ID4gPiA+IFdpdGggdGhlc2UgY2hhbmdlcywgdGhl
cmUgaXMgbm8gbW9yZSBhIHNwZWNpZmljIHdhaXRpbmcgbGlzdCBmb3IgVEVFDQo+ID4gPiA+IHN5
c3RlbSB0aHJlYWRzIGhlbmNlIHdoZW4gYSB3YWl0aW5nIHF1ZXVlIGNhbiBjb21wbGV0ZSwgd2Un
bGwgcGljayBhbnkNCj4gPiA+ID4gVEVFIHRocmVhZCwgbm90IGEgVEVFIHN5c3RlbSB0aHJlYWQg
Zmlyc3QuLg0KPiA+ID4NCj4gPiA+IEkgaGFkIHRob3VnaHQgYWJvdXQgdGhpcyBidXQgSSBjYW4n
dCBzZWUgYW55IHZhbHVlIGluIGhhdmluZyBhDQo+ID4gPiBzZXBhcmF0ZSB3YWl0IHF1ZXVlIGZv
ciBzeXN0ZW0gdGhyZWFkcy4gSGVyZSB3ZSBvbmx5IG5lZWQgdG8gcHJvdmlkZQ0KPiA+ID4gYW4g
ZXh0cmEgcHJpdmlsZWdlZCB0aHJlYWQgZm9yIHN5c3RlbSBzZXNzaW9ucyAoa2VybmVsIGNsaWVu
dHMpIHN1Y2gNCj4gPiA+IHRoYXQgdXNlci1zcGFjZSBkb2Vzbid0IGNvbnRlbmQgZm9yIHRoYXQg
dGhyZWFkLiBUaGlzIHByZXZlbnRzIGtlcm5lbA0KPiA+ID4gY2xpZW50J3Mgc3RhcnZhdGlvbiBv
ciBkZWFkbG9jayBsaWtlIGluIHRoZSBTQ01JIGNhc2UuDQo+ID4gPg0KPiA+ID4gPiBBbHNvLCBh
cyBzdGF0ZWQgaW4gYSBiZWxvdyBhbnN3ZXIsIHRoZXNlIGNoYW5nZSB1bmNvbmRpdGlvbmFsbHkN
Cj4gPiA+ID4gcmVzZXJ2ZSBhIFRFRSB0aHJlYWQgZm9yIFRFRSBzeXN0ZW0gY2FsbHMgZXZlbiBp
ZiBubyBURUUgY2xpZW50DQo+ID4gPiA+IHJlc2VydmVkIHN1Y2guDQo+ID4gPg0KPiA+ID4gSSBk
b24ndCB0aGluayB3ZSBzaG91bGQgbWFrZSB0aHJlYWQgcmVzZXJ2YXRpb25zIGJhc2VkIG9uIHRo
ZSBwcmVzZW5jZQ0KPiA+ID4gb2YgVEVFIGNsaWVudHMuIFlvdSBuZXZlciBrbm93IGhvdyBtdWNo
IHVzZXItc3BhY2Ugb3Iga2VybmVsIFRFRQ0KPiA+ID4gY2xpZW50cyB5b3UgYXJlIGRlYWxpbmcg
d2l0aC4gQW5kIHJlc2VydmluZyBhIHNpbmdsZSBwcml2aWxlZ2VkIHRocmVhZA0KPiA+ID4gdW5j
b25kaXRpb25hbGx5IGZvciBzeXN0ZW0gc2Vzc2lvbnMgc2hvdWxkbid0IGJlIG11Y2ggb2YgYSBi
dXJkZW4gZm9yDQo+ID4gPiBtZW1vcnkgY29uc3RyYWluZWQgZGV2aWNlcyB0b28uDQo+ID4gPg0K
PiA+ID4gQWxzbywgdGhpcyB3YXkgd2Ugd291bGQgZW5hYmxlIGV2ZXJ5IGtlcm5lbCBURUUgY2xp
ZW50IHRvIGxldmVyYWdlDQo+ID4gPiBzeXN0ZW0gc2Vzc2lvbnMgYXMgaXQncyB2ZXJ5IGxpa2Vs
eSB0aGV5IHdvdWxkbid0IGxpa2UgdG8gY29tcGV0ZSB3aXRoDQo+ID4gPiB1c2VyLXNwYWNlIGZv
ciB0aHJlYWQgYXZhaWxhYmlsaXR5LiBUd28gb3RoZXIga2VybmVsIFRFRSBjbGllbnRzIHRoYXQN
Cj4gPiA+IGFyZSBvbiB0b3Agb2YgbXkgaGVhZCBhcmUgSFdSTkcgYW5kIFRydXN0ZWQgS2V5cyB3
aGljaCBjYW4gYmVuZWZpdA0KPiA+ID4gZnJvbSB0aGlzIGZlYXR1cmUuDQo+ID4NCj4gPiBUcnVz
dGVkIEtleXMgaXMgYW4gaW50ZXJlc3RpbmcgdXNlIGNhc2UuIFdoZW4gT1AtVEVFIGFjY2Vzc2Vz
IFRydXN0ZWQgS2V5cywNCj4gPiBpdCBtYXkgbmVlZCB0byBhY2Nlc3MgdGhlIGVNTUMvUlBNQiB1
c2luZyB0aGUgTGludXggT1MgdGVlLXN1cHBsaWNhbnQNCj4gPiAgd2hpY2hqIG1heSByZXB1aXJl
IGFuIGVNTUMgY2xvY2sgb3Igdm9sdGFnZSByZWd1bGF0b3IgdG8gYmUgZW5hYmxlZC4NCj4gPiBJ
ZiB0aGF0IGNsb2NrIG9yIHJlZ3VsYXRvciBpcyB1bmRlciBhbiBTQ01JIGNvbnRyb2wsIHRoZW4g
d2UgbmVlZCAyDQo+ID4gcmVzZXJ2ZWQgVEVFIHRocmVhZDogb25lIGZvciBpbnZva2luZyB0aGUg
VHJ1c3RlZCBLZXkgVEEgYW5kDQo+ID4gYW5vdGhlciBmb3IgdGhlIFNDTUkgcmVxdWVzdCB0byBy
ZWFjaCB0aGUgVEVFIHdpbGwgdGhlIFRydXN0ZWQgS2V5DQo+ID4gVEEgaW52b2NhdGlvbiBzdGls
bCBjb25zdW1lcyBhIHRocmVhZC4NCj4gPg0KPiBXaHkgd291bGQgdGhlIFRydXN0ZWQgS2V5cyBz
ZXNzaW9uIG5lZWQgYSBzeXN0ZW0gdGhyZWFkPyBUbyBtZSwgaXQNCj4gc2VlbXMgdGhhdCB0aGUg
c2Vzc2lvbiBjb3VsZCB1c2UgdGhlIG5vcm1hbCBjbGllbnQgcHJpb3JpdHkuDQoNCkkgYWdyZWUu
IEkgZG9uJ3QgVHJ1c3RlZCBLZXkgc2VydmljZXMgbmVlZHMgYSBwcm92aXNpb25lZCBURUUgc3lz
dGVtIHRocmVhZC4NCg0KRXRpZW5uZQ0KDQo+DQo+IFRoYW5rcywNCj4gSmVucw0KPg0KPiA+IChz
bmlwKQ0KDQpTVCBSZXN0cmljdGVkDQo=
