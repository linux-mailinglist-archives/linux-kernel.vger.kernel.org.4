Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A5742BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjF2SHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2SHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:07:18 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457461BD6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:07:16 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TFtxQr005169;
        Thu, 29 Jun 2023 18:06:54 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3rha5phfcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 18:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg0E5qnmo8L2vxNiC+g6JfiEXxMDI2tlqzwvdSz3lm70gs4Ma0lSQhr7gsRX5i+NNfJDL5sRO1v+maN4AvwrfBF3WtXGHmgGA2g4iWUuOJYPaAFkCXYP6YcH8XPMJztPvIpJiKS5NzZcxFaUQTeKOEm9qf6xF4K+G+zmOUOBJ6oqPaLKKUnX3ipjX45d1C0+/YAxBswewE6iREhCutxxn7XhRhqecGA8FS6cXLdgYyTTbAj0CT/8L43xuGoCzzba0kupa6kQuR4voli3uM2oMuuI2WwP5fWWv0aRfyBbkZL0cFpFYFNzwb750ipZA31p/qDIhTVpjS5+t1bsWs6o0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiXfCNU5kgqlvL3Z/b9w9uLj67W/rXy2j3rfKBKQwKU=;
 b=Ubukt0kVTE2JXYua3D3ZRvPY11P8+WEX2MCKYJJ1c3o8vu2JoUAFdZe4ffC20MjouaIWxl8uGOoofTP2MsHWXMdJxvd5qXJl13LEM03sEp9bcoOLqfC636qGmBNJAgxEDt6cskghum81mgvnNtJHjckXLkUDfPBS5MT3ZmJWQf1GbtsRtRDTSu9nt62QMAMnPukFjFg/PFICyg2pulrfg5FGif7P/SGHf+fPtMMRp1VDZKuzNt+B9UjGvx4DTihLFTtw2nX5uN0XVfB2pBh7CHvZG49ifjD+FrWbv1f7nvwIL5I8xzCia7ttmEyH0NFSPuUqqJB16j7/hovnKPSweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiXfCNU5kgqlvL3Z/b9w9uLj67W/rXy2j3rfKBKQwKU=;
 b=FjtdUrtaVWmk6QFGJLYUDBOi6hkbVAte8WQOAacDAkz2zyVUh/ack7mVVuoFwo3A15kRFrijdZtf9bSYEPfmcGgib6e1JwnjUo8utwcJXOivA+3iKkY+RMFkKBK9+Y1Wr8tmA/Ln5xWz4KpuvDZEmpE2dBTLAPD0BhPhmY8VhLLqJXf36kdxFmMeUtnQ8K3f5ATFYbuKb6D5w+KFSkxZSTB92n+EJTWgdU2KaPOReWEuEK71aEzP5ZePf+a8Ha3R5CiYNRJvkifebuV8Joc6yQs8ZxPHvV8mIQzc3HFueP6Kh2UdE73QAtdSnak1zoHE10UnA4NuwB2WejqJpCEBsg==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by DB4PR03MB9338.eurprd03.prod.outlook.com (2603:10a6:10:3fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 18:06:50 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 18:06:50 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Rahul Singh <rahul.singh@arm.com>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jane Malalane <jane.malalane@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2] xen/evtchn: Introduce new IOCTL to bind static evtchn
Thread-Topic: [PATCH v2] xen/evtchn: Introduce new IOCTL to bind static evtchn
Thread-Index: AQHZqqDns5B5iYjWyUqK/twjIbdmaq+iE6mA
Date:   Thu, 29 Jun 2023 18:06:50 +0000
Message-ID: <90c961d4-9d10-6fbc-b5f7-84d231264289@epam.com>
References: <764d561e3aecb7e63e8601dc50aaef9fc40834e4.1688051342.git.rahul.singh@arm.com>
In-Reply-To: <764d561e3aecb7e63e8601dc50aaef9fc40834e4.1688051342.git.rahul.singh@arm.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|DB4PR03MB9338:EE_
x-ms-office365-filtering-correlation-id: ed51e7c5-20e1-494d-9fa6-08db78cb9cb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WateOr1QCbQrijjlDrm6nEEl+PSao9CIMnkWnyUTbntsL1M5xQn8H/GfjGvdKa4Ls0cK6CdgngICPAUBrda+f0YX2x7hb1VY4KljviDRbrRZZ7UEZkT+Fmaq1F4CHtRuwPdeAA+Edryesyb+YQ86GjgdhZtztaUekkJ9pZOSgoi7hnQg/g6BXPkIdYHq9Xh07/G+AFrNA/Lg76YjQmGmu5iBlkk9Rtn/1DO/mG4OEn4vTPnusgVnFXK93pO2/UXowjggGEiEKKFfiDnyzAnNJSkkwTnQN/s5vx0V34sCpsfZFcmxyKYP3ASid+9cExTTmqKxS3BM3aDHgJX2bfDygXMzCuLr8Z0I19WxZ+o7wzK9rPK/kJDlaE04sWqI1OKHcOTazI/NGPrXDwEXs6S8kNDbZd3OC8EAJ1tiZOz7nzFzQSXt5kXrH1uIAkom6IIpw7qXNJIiLorzVqeyo+F/nq9SUVkUCS3W4UtBQkbkOP1TWKyaUA33g//eku7mDyjPrJpXunY73TDCbDgiUZB689DpxTk5TVxE3T7kLdf/43rYK2uty/rhFr6RtaAxAlXo20oUz5bF9KWsr2Fwhw4gu24pq6kNn0C+f3URHYxoBT56WBz6fa1RgV/XY6zI626HTmBv4cSejVjM01S3541xHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(71200400001)(54906003)(8676002)(8936002)(5660300002)(36756003)(478600001)(6916009)(4326008)(91956017)(6486002)(31686004)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(316002)(41300700001)(6512007)(38100700002)(122000001)(53546011)(186003)(2616005)(6506007)(26005)(86362001)(31696002)(83380400001)(38070700005)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?andYSjhrY09XV0s4VHI5b2E0SmxxaU02MElUcmIybTBpR2U1R1M0RlZnVUpV?=
 =?utf-8?B?U00zMFdaU1ZKbTltRUUzU0dvd01UOTJtdEluaHZPUkQ4ZmhRaUZ6bkJqNXo0?=
 =?utf-8?B?N1B6aVl0clhkMjgzRUs5U3RhVnhRNFZUc2VXY1FlZnNQazd1ZjZxTVNWRmhx?=
 =?utf-8?B?WjJnRElKNk84RzRzYzlWcmwrUkFpZE9MbnRUOER4TnF3RVV6SmJiSzRKQ0t6?=
 =?utf-8?B?ZGpyUTZ2TlJzTVhic3VXeFhMN0R3a3RhZy9meExXSFp0WUFkeEVSTGVMaW5C?=
 =?utf-8?B?YjJoY1VuQ3RTdTRhL2FaeFJZYTJ0NXN6RGNoMkNXOGJUN3I4RGNrMUp3Wmxi?=
 =?utf-8?B?UWRiNVJWOStMQUdzOERmRUt4bVo4UTE1S1JvYU1vMEM3eU02RUE0bU9LSzNk?=
 =?utf-8?B?SnJ2Yk9RdzdESzZWWDlvMHNLL3dyTUlUUGJhRFFadW45b3V2TmQ2THhRYjIv?=
 =?utf-8?B?eU9wNG51dFJCMVpNWFlHdnV5NTUwN2pGRFdtbWZTc1lEelhiQlNmTVo4ekRT?=
 =?utf-8?B?ZEJETW8wZjVzNmp0U1FvQlFGQUVKSStDV2FlMUVpY08zcm5zUHplNWFHWHpD?=
 =?utf-8?B?bWZ6MFgwdEtMTmJCbzFPYytqL0g1NCtQZlcvSjlORXBTRTF0RXRiQWVnL3Rq?=
 =?utf-8?B?OGtnbUZqM2swK3dsRnptYWwxcFI5ODd3eElLNWEySE41d3VYVEMwRTZ0Q0Y4?=
 =?utf-8?B?ZTlUUVJBaDVFdHU1L2Q1c2lJek5TWHhyNDNNUytjYXNMUlNGa0YwRmNMWDhU?=
 =?utf-8?B?YzhuSWFQRHFVN3dwalBReEJvcjR0SXhNcTN5T2lBMWFIM1RReHE2S3dsNXBa?=
 =?utf-8?B?VmpqLzk1bEhmajZJSmx0Yi90aXVrM1VSUWxDVGxZY2U3YmZTdkQwZm43K2dL?=
 =?utf-8?B?eFJUVDUya2RwLy9xVjlDN2NKdllmeUFkc2tTQXVGOEs4Q29kQndraVg0bDhY?=
 =?utf-8?B?Zmc3a24vQW9aN0ZScjRmSDBQeXN0cnFLd2hWVFJBbXdCTFdObXM4QjgzWmJj?=
 =?utf-8?B?UGcxdVpkRFpDZndQbUdTNVU1OFBibkpHb2R1L2hpQTIreCtjV2drbkUwT1cv?=
 =?utf-8?B?OWh4QnVoWDRGN3BsUmdvaDcyQXV1MXFKUnpvUHNtWFY3OXN5T2NRMzd0dCtO?=
 =?utf-8?B?WWNiaUtSa1FJdkJkMUIrbTNyM01PNnNUUGVxTmRxVlZReUVoTDJwSjZuRFl1?=
 =?utf-8?B?ZDNSblRPSUxnb1p5Q2UrdXdHbFVEamw1MzVwaEZpQVJaVlNMN0FkTHVBNUJ4?=
 =?utf-8?B?bHZXUUJaUkpyMXJhVG5sS3p0UDA1QWk2WW9XSFpjMkIzRVlsOEtDMnJzWXVa?=
 =?utf-8?B?c20yT0RiUFhTTXFxdXJuL25zMWRCc3ZxL1h2WStta1dHRHBYQUF1b2pOLy9r?=
 =?utf-8?B?SnRyaUdkNWNYcXFGRnVxUGtudHh1YzVncTdQbEdyTjdORGZUa0UyNW1Ca3BX?=
 =?utf-8?B?MHlrRjlTc1plRS93RGxEeTNQSERwSm41NDVrOTBiS0tSaDNxRmtEWlFqOHdB?=
 =?utf-8?B?ck9RS3VhZXBmdTBaWVlhQkd2RHlOUXB1SHdTTWNiejgyMDdEbDV6TmMzMG9V?=
 =?utf-8?B?cUhmU3hNZmpsdTk3cGhoT1lCeVBLN0pYc09ETUkvbnhsM09YRldJOW5SUFZT?=
 =?utf-8?B?S2p0WU0yRmtsUHJ4bWlzNXVaVjkvNG5OVVdjWEpScHYrQUphdUx3RVVzTXFE?=
 =?utf-8?B?Nm9mWU9sZ0g3VHFiQ0hSR0FsL3NTUmh4alIwdU9vVEQ3aWVsN3ZzQitkaEg0?=
 =?utf-8?B?UkpaNzJITmpJY2g5Uk9sQTdnYmpqQWpoRjd5K3hqclJnbDU1aVlDR3NxQVg1?=
 =?utf-8?B?bGZ6TW9uVU5TaUhPUTZoWm9oS3NlSWxDN2plM2dacFNjYjVibHFyZ3NKbExu?=
 =?utf-8?B?MG5xUHluZXJBRjFUekFka0o1cSt6ZkNVSHBNbHRYbitxbGlOU2RBc01QZzhq?=
 =?utf-8?B?OEpCM0FDWm1UTGwybTlCVTFGbWI3eEhhVUYvUXlxZ09HWnFXL1A1TjVHT0xq?=
 =?utf-8?B?R0VXY292cUcxUk53ZE14eDc4Sk9NQzA1TkJuVEoyZWZuV0picGV3bENQMTQ3?=
 =?utf-8?B?d2huRE1aWWlLcGhzQXJiZ01wZnE1Nk9yallyQmpJQ0tNTVhBOGh5R25Bc1lk?=
 =?utf-8?B?RUZ3RVVURHkzUGpUeDBuWmFCK2o0ZlVNRVMvSG9pc2huVG1JUjIwdWd0alBK?=
 =?utf-8?Q?pKTI/srr9ejc0RhZXIulWVM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2FCF9F9202F6C4F9F1C798BB990AE43@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed51e7c5-20e1-494d-9fa6-08db78cb9cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 18:06:50.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PY8Ge1F8LSKzzJ54ldXsIvmoWdDYAT463tl9Hpf012P2OFo55e6IKmVvVDZ8RvvcE8tidw1EAwewUOQZHDP0luG9NAKLIpWShIdgmT45UDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9338
X-Proofpoint-GUID: 945mKLx5oeaphABgEZenTOSu8Z0CX3Ls
X-Proofpoint-ORIG-GUID: 945mKLx5oeaphABgEZenTOSu8Z0CX3Ls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_05,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 spamscore=0 mlxlogscore=554 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI5LjA2LjIzIDE4OjQ2LCBSYWh1bCBTaW5naCB3cm90ZToNCg0KSGVsbG8gUmFodWwN
Cg0KDQo+IFhlbiA0LjE3IHN1cHBvcnRzwqB0aGUgY3JlYXRpb24gb2Ygc3RhdGljIGV2dGNobnMu
IFRvIGFsbG93IHVzZXIgc3BhY2UNCj4gYXBwbGljYXRpb24gdG8gYmluZCBzdGF0aWMgZXZ0Y2hu
cyBpbnRyb2R1Y2UgbmV3IGlvY3RsDQo+ICJJT0NUTF9FVlRDSE5fQklORF9TVEFUSUMiLiBFeGlz
dGluZyBJT0NUTCBkb2luZyBtb3JlIHRoYW4gYmluZGluZw0KPiB0aGF04oCZcyB3aHkgd2UgbmVl
ZCB0byBpbnRyb2R1Y2UgdGhlIG5ldyBJT0NUTCB0byBvbmx5IGJpbmQgdGhlIHN0YXRpYw0KPiBl
dmVudCBjaGFubmVscy4NCj4gDQo+IEFsc28sIHN0YXRpYyBldnRjaG5zIHRvIGJlIGF2YWlsYWJs
ZSBmb3IgdXNlIGR1cmluZyB0aGUgbGlmZXRpbWUgb2YgdGhlDQo+IGd1ZXN0LiBXaGVuIHRoZSBh
cHBsaWNhdGlvbiBleGl0cywgX191bmJpbmRfZnJvbV9pcnEoKSBlbmRzIHVwIGJlaW5nDQo+IGNh
bGxlZCBmcm9tIHJlbGVhc2UoKSBmaWxlIG9wZXJhdGlvbnMgYmVjYXVzZSBvZiB0aGF0IHN0YXRp
YyBldnRjaG5zDQo+IGFyZSBnZXR0aW5nIGNsb3NlZC4gVG8gYXZvaWQgY2xvc2luZyB0aGUgc3Rh
dGljIGV2ZW50IGNoYW5uZWwsIGFkZCB0aGUNCj4gbmV3IGJvb2wgdmFyaWFibGUgImlzX3N0YXRp
YyIgaW4gInN0cnVjdCBpcnFfaW5mbyIgdG8gbWFyayB0aGUgZXZlbnQNCj4gY2hhbm5lbCBzdGF0
aWMgd2hlbiBjcmVhdGluZyB0aGUgZXZlbnQgY2hhbm5lbCB0byBhdm9pZCBjbG9zaW5nIHRoZQ0K
PiBzdGF0aWMgZXZ0Y2huLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFodWwgU2luZ2ggPHJhaHVs
LnNpbmdoQGFybS5jb20+DQo+IC0tLQ0KPiB2MjoNCj4gICAqIFVzZSBib29sIGluIHBsYWNlIHU4
IHRvIGRlZmluZSBpc19zdGF0aWMgdmFyaWFibGUuDQo+ICAgKiBBdm9pZCBjbG9zaW5nIHRoZSBz
dGF0aWMgZXZ0Y2hucyBpbiBlcnJvciBwYXRoLg0KDQoNClBhdGNoIGxvb2tzIGdvb2QgdG8gbWUs
IGp1c3QgYSBuaXQgKHF1ZXN0aW9uKSBiZWxvdy4NCg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMveGVu
L2V2ZW50cy9ldmVudHNfYmFzZS5jIHwgIDcgKysrKystLQ0KPiAgIGRyaXZlcnMveGVuL2V2dGNo
bi5jICAgICAgICAgICAgIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAg
aW5jbHVkZS91YXBpL3hlbi9ldnRjaG4uaCAgICAgICAgfCAgOSArKysrKysrKysNCj4gICBpbmNs
dWRlL3hlbi9ldmVudHMuaCAgICAgICAgICAgICB8ICAyICstDQo+ICAgNCBmaWxlcyBjaGFuZ2Vk
LCAzNyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVu
dHNfYmFzZS5jDQo+IGluZGV4IGM3NzE1ZjhiZDQ1Mi4uNWQzYjVjN2NmZTY0IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPiArKysgYi9kcml2ZXJzL3hl
bi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPiBAQCAtMTEyLDYgKzExMiw3IEBAIHN0cnVjdCBpcnFf
aW5mbyB7DQo+ICAgCXVuc2lnbmVkIGludCBpcnFfZXBvY2g7IC8qIElmIGVvaV9jcHUgdmFsaWQ6
IGlycV9lcG9jaCBvZiBldmVudCAqLw0KPiAgIAl1NjQgZW9pX3RpbWU7ICAgICAgICAgICAvKiBU
aW1lIGluIGppZmZpZXMgd2hlbiB0byBFT0kuICovDQo+ICAgCXJhd19zcGlubG9ja190IGxvY2s7
DQo+ICsJYm9vbCBpc19zdGF0aWM7ICAgICAgICAgICAvKiBJcyBldmVudCBjaGFubmVsIHN0YXRp
YyAqLw0KPiAgIA0KPiAgIAl1bmlvbiB7DQo+ICAgCQl1bnNpZ25lZCBzaG9ydCB2aXJxOw0KPiBA
QCAtOTgyLDcgKzk4Myw4IEBAIHN0YXRpYyB2b2lkIF9fdW5iaW5kX2Zyb21faXJxKHVuc2lnbmVk
IGludCBpcnEpDQo+ICAgCQl1bnNpZ25lZCBpbnQgY3B1ID0gY3B1X2Zyb21faXJxKGlycSk7DQo+
ICAgCQlzdHJ1Y3QgeGVuYnVzX2RldmljZSAqZGV2Ow0KPiAgIA0KPiAtCQl4ZW5fZXZ0Y2huX2Ns
b3NlKGV2dGNobik7DQo+ICsJCWlmICghaW5mby0+aXNfc3RhdGljKQ0KPiArCQkJeGVuX2V2dGNo
bl9jbG9zZShldnRjaG4pOw0KPiAgIA0KPiAgIAkJc3dpdGNoICh0eXBlX2Zyb21faXJxKGlycSkp
IHsNCj4gICAJCWNhc2UgSVJRVF9WSVJROg0KPiBAQCAtMTU3NCw3ICsxNTc2LDcgQEAgaW50IHhl
bl9zZXRfaXJxX3ByaW9yaXR5KHVuc2lnbmVkIGlycSwgdW5zaWduZWQgcHJpb3JpdHkpDQo+ICAg
fQ0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHhlbl9zZXRfaXJxX3ByaW9yaXR5KTsNCj4gICANCj4g
LWludCBldnRjaG5fbWFrZV9yZWZjb3VudGVkKGV2dGNobl9wb3J0X3QgZXZ0Y2huKQ0KPiAraW50
IGV2dGNobl9tYWtlX3JlZmNvdW50ZWQoZXZ0Y2huX3BvcnRfdCBldnRjaG4sIGJvb2wgaXNfc3Rh
dGljKQ0KPiAgIHsNCj4gICAJaW50IGlycSA9IGdldF9ldnRjaG5fdG9faXJxKGV2dGNobik7DQo+
ICAgCXN0cnVjdCBpcnFfaW5mbyAqaW5mbzsNCj4gQEAgLTE1OTAsNiArMTU5Miw3IEBAIGludCBl
dnRjaG5fbWFrZV9yZWZjb3VudGVkKGV2dGNobl9wb3J0X3QgZXZ0Y2huKQ0KPiAgIAlXQVJOX09O
KGluZm8tPnJlZmNudCAhPSAtMSk7DQo+ICAgDQo+ICAgCWluZm8tPnJlZmNudCA9IDE7DQo+ICsJ
aW5mby0+aXNfc3RhdGljID0gaXNfc3RhdGljOw0KPiAgIA0KPiAgIAlyZXR1cm4gMDsNCj4gICB9
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ldnRjaG4uYyBiL2RyaXZlcnMveGVuL2V2dGNo
bi5jDQo+IGluZGV4IGM5OTQxNWE3MDA1MS4uZTZkMjMwMzQ3OGIyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3hlbi9ldnRjaG4uYw0KPiArKysgYi9kcml2ZXJzL3hlbi9ldnRjaG4uYw0KPiBAQCAt
MzY2LDcgKzM2Niw4IEBAIHN0YXRpYyBpbnQgZXZ0Y2huX3Jlc2l6ZV9yaW5nKHN0cnVjdCBwZXJf
dXNlcl9kYXRhICp1KQ0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgaW50
IGV2dGNobl9iaW5kX3RvX3VzZXIoc3RydWN0IHBlcl91c2VyX2RhdGEgKnUsIGV2dGNobl9wb3J0
X3QgcG9ydCkNCj4gK3N0YXRpYyBpbnQgZXZ0Y2huX2JpbmRfdG9fdXNlcihzdHJ1Y3QgcGVyX3Vz
ZXJfZGF0YSAqdSwgZXZ0Y2huX3BvcnRfdCBwb3J0LA0KPiArCQkJYm9vbCBpc19zdGF0aWMpDQo+
ICAgew0KPiAgIAlzdHJ1Y3QgdXNlcl9ldnRjaG4gKmV2dGNobjsNCj4gICAJc3RydWN0IGV2dGNo
bl9jbG9zZSBjbG9zZTsNCj4gQEAgLTQwMiwxNCArNDAzLDE2IEBAIHN0YXRpYyBpbnQgZXZ0Y2hu
X2JpbmRfdG9fdXNlcihzdHJ1Y3QgcGVyX3VzZXJfZGF0YSAqdSwgZXZ0Y2huX3BvcnRfdCBwb3J0
KQ0KPiAgIAlpZiAocmMgPCAwKQ0KPiAgIAkJZ290byBlcnI7DQo+ICAgDQo+IC0JcmMgPSBldnRj
aG5fbWFrZV9yZWZjb3VudGVkKHBvcnQpOw0KPiArCXJjID0gZXZ0Y2huX21ha2VfcmVmY291bnRl
ZChwb3J0LCBpc19zdGF0aWMpOw0KPiAgIAlyZXR1cm4gcmM7DQo+ICAgDQo+ICAgZXJyOg0KPiAg
IAkvKiBiaW5kIGZhaWxlZCwgc2hvdWxkIGNsb3NlIHRoZSBwb3J0IG5vdyAqLw0KPiAtCWNsb3Nl
LnBvcnQgPSBwb3J0Ow0KPiAtCWlmIChIWVBFUlZJU09SX2V2ZW50X2NoYW5uZWxfb3AoRVZUQ0hO
T1BfY2xvc2UsICZjbG9zZSkgIT0gMCkNCj4gLQkJQlVHKCk7DQo+ICsJaWYgKCFpc19zdGF0aWMp
IHsNCg0KDQpJIHRoaW5rIG5vdyAic3RydWN0IGV2dGNobl9jbG9zZSBjbG9zZTsiIGNhbiBiZSBw
bGFjZWQgaGVyZSBhcyBpdCBpcyBub3QgDQp1c2VkIG91dHNpZGUgb2YgdGhpcyBibG9jay4NCg0K
QWxzbyB0aGlzIGJsb2NrIGxvb2tzIGxpa2UgYW4gb3Blbi1jb2RlZCB2ZXJzaW9uIG9mIHhlbl9l
dnRjaG5fY2xvc2UoKQ0KZGVmaW5lZCBhdCBldmVudHNfYmFzZS5jLCBzbyBtYXliZSBpdCBpcyB3
b3J0aCBtYWtpbmcgeGVuX2V2dGNobl9jbG9zZSgpIA0Kc3RhdGljIGlubGluZSBhbmQgcGxhY2lu
ZyBpdCBpbnRvIGV2ZW50cy5oLCB0aGVuIGNhbGxpbmcgaGVscGVyIGhlcmU/DQpQbGVhc2Ugbm90
ZSwgSSB3aWxsIGJlIG9rIGVpdGhlciB3YXkuDQoNCg0KPiArCQljbG9zZS5wb3J0ID0gcG9ydDsN
Cj4gKwkJaWYgKEhZUEVSVklTT1JfZXZlbnRfY2hhbm5lbF9vcChFVlRDSE5PUF9jbG9zZSwgJmNs
b3NlKSAhPSAwKQ0KPiArCQkJQlVHKCk7DQo+ICsJfQ0KPiAgIAlkZWxfZXZ0Y2huKHUsIGV2dGNo
bik7DQo+ICAgCXJldHVybiByYzsNCj4gICB9DQoNCltzbmlwXQ==
