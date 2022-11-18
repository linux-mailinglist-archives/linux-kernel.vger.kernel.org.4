Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9A362ED22
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiKRFTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbiKRFTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:19:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215C65EFA8;
        Thu, 17 Nov 2022 21:19:08 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI4Tgx3031400;
        Fri, 18 Nov 2022 05:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=xxF78hhFXfjMsk2lwZ47hGX+oCLZsX64v+r4CvKmK7M=;
 b=O1OF8mxycVSsQbfJQutPPCNHLLLqzE0hXlDIw/OunQo68f1VenR7ryz2EctMUW/maGYb
 /5TzajPovGgZCXfAWZ9/+4svKEo6m99spKkDmXpUAtq7UHl28HYAj/QZyXlYIqtiNX0L
 HcsjTVcnbpsPsvy27fKf3XPIOyeMlZSBN5WP0iGql2sHFjfv6cAKzle9cf9oSIcTrOx+
 8Ges8ezercuz8pRd4quc8uIHeOACO67BhTafzNeqIrszqLqPJtiQmQczNEFZuRJ7fRIU
 TuojeqxUzvyuXfM3L0WtB3TITsAFdUx6mWGO3IHsfkVbmJpzy9jslMj6socZxUFoSnuu jw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0te8efb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 05:18:58 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AI5IvqN028922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 05:18:57 GMT
Received: from nasanex01a.na.qualcomm.com (10.52.223.231) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 17 Nov 2022 21:18:56 -0800
Received: from nasanex01a.na.qualcomm.com ([fe80::622:6095:792:52f2]) by
 nasanex01a.na.qualcomm.com ([fe80::622:6095:792:52f2%12]) with mapi id
 15.02.0986.036; Thu, 17 Nov 2022 21:18:56 -0800
From:   "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shaik Sajida Bhanu" <quic_c_sbhanu@quicinc.com>
Subject: RE: [PATCH V1] mmc: core: Wait for 1ms after enabling the clocks post
 voltage switch
Thread-Topic: [PATCH V1] mmc: core: Wait for 1ms after enabling the clocks
 post voltage switch
Thread-Index: AQHY+mngG73hYL8njUypr3/boC5atq5DereAgACpfEA=
Date:   Fri, 18 Nov 2022 05:18:56 +0000
Message-ID: <eb01879da13345c5aa5c5f2f36fafd9a@quicinc.com>
References: <20221117094859.20582-1-quic_sartgarg@quicinc.com>
 <CAPDyKFqLjKOUwbAY5KXWK7g2xcWBQLW09nYoeVCxarfJPGNrTg@mail.gmail.com>
In-Reply-To: <CAPDyKFqLjKOUwbAY5KXWK7g2xcWBQLW09nYoeVCxarfJPGNrTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.6.34]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vCF_zKqPUTTq9q0YmypoyViMk8UzCUYi
X-Proofpoint-GUID: vCF_zKqPUTTq9q0YmypoyViMk8UzCUYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180034
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxNywgMjAy
MiA0OjM3IFBNDQo+IFRvOiBTYXJ0aGFrIEdhcmcgKFFVSUMpIDxxdWljX3NhcnRnYXJnQHF1aWNp
bmMuY29tPg0KPiBDYzogYWRyaWFuLmh1bnRlckBpbnRlbC5jb207IGxpbnV4LW1tY0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tbXNt
QHZnZXIua2VybmVsLm9yZzsgUmFtIFByYWthc2ggR3VwdGENCj4gKFFVSUMpIDxxdWljX3JhbXBy
YWthQHF1aWNpbmMuY29tPjsgUHJhZGVlcCBQcmFnYWxsYXBhdGkgKFFVSUMpDQo+IDxxdWljX3By
YWdhbGxhQHF1aWNpbmMuY29tPjsgU2F5YWxpIExva2hhbmRlIChRVUlDKQ0KPiA8cXVpY19zYXlh
bGlsQHF1aWNpbmMuY29tPjsgV29sZnJhbSBTYW5nIDx3c2ErcmVuZXNhc0BzYW5nLQ0KPiBlbmdp
bmVlcmluZy5jb20+OyBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPjsgSmFzb24g
QS4gRG9uZW5mZWxkDQo+IDxKYXNvbkB6eDJjNC5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gU2hhaWsgU2FqaWRhIEJoYW51IDxxdWljX2Nf
c2JoYW51QHF1aWNpbmMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYxXSBtbWM6IGNvcmU6
IFdhaXQgZm9yIDFtcyBhZnRlciBlbmFibGluZyB0aGUgY2xvY2tzIHBvc3QNCj4gdm9sdGFnZSBz
d2l0Y2gNCj4gDQo+IE9uIFRodSwgMTcgTm92IDIwMjIgYXQgMTA6NDksIFNhcnRoYWsgR2FyZyA8
cXVpY19zYXJ0Z2FyZ0BxdWljaW5jLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBBcyBwZXIgc3Bl
YyB3ZSBzaG91bGQgd2FpdCBmb3IgMW1zIGFmdGVyIHByb3ZpZGluZyB0aGUgU0QgY2xvY2sgdG8g
dGhlDQo+ID4gY2FyZCBhZ2FpbiBhcyBwYXJ0IG9mIHZvbHRhZ2Ugc3dpdGNoIHNlcXVlbmNlIGJ1
dCB0aGVyZSBzZWVtcyB0byBiZSBhDQo+ID4gdmlvbGF0aW9uIGhlcmUuIENsb2NrcyBhcmUgZ2V0
dGluZyBnYXRlZCBiZWZvcmUgMW1zIGFzIHBhcnQgb2YNCj4gPiBzZGhjaV9zZXRfaW9zIGZ1bmN0
aW9uIHdoZXJlIHdlIHRyeSB0byByZXNldCBTRCBDbG9jayBFbmFibGUgYnkNCj4gPiByZXNldHRp
bmcgU0RIQ0lfQ0xPQ0tfQ0FSRF9FTiBiaXQgaW4gU0RIQ0lfQ0xPQ0tfQ09OVFJPTCByZWdpc3Rl
cg0KPiA+IGxlYWRpbmcgdG8gdm9sdGFnZSBzd2l0Y2ggZmFpbHVyZXMgZm9yIHNwZWNpZmljIFNE
IGNhcmRzLg0KPiA+IEJlbG93IGZ0cmFjZXMgYWxzbyBjb25maXJtcyB0aGUgYWJvdmUgdW5kZXJz
dGFuZGluZyA6DQo+ID4NCj4gPiA5LjUxMTM2NzogbW1jX2hvc3Rfc2V0X3Voc192b2x0YWdlOiBt
bWMxIGNhbGxlZA0KPiA+IDkuNTExMzY5OiBtbWNfc2V0X2lvczogbW1jMTogY2xvY2sgMEh6IGJ1
c21vZGUgMiBwb3dlcm1vZGUgMiBjcyAwIFZkZA0KPiA+IDE4IHdpZHRoIDEgdGltaW5nIDANCj4g
PiA5LjUxMTM3MDogc2RoY2lfc2V0X2lvczogbW1jMSBjYWxsZWQNCj4gPiA5LjUxMTM3MDogc2Ro
Y2lfc2V0X2lvczogbW1jMSBzZXR0aW5nIGNsb2NrIGlvcy0+Y2xvY2s6IDAgaG9zdC0+Y2xvY2s6
DQo+ID4gNDAwMDAwDQo+ID4gOS41MTEzNzI6IHNkaGNpX21zbV9zZXRfY2xvY2s6IG1tYzEgY2xv
Y2s6IDANCj4gPiA5LjUxMTM5NDogc2RoY2lfc2V0X2lvczogbW1jMSBnYXRpbmcgY2xvY2tzIGJ5
IHdyaXRpbmcNCj4gPiB+U0RIQ0lfQ0xPQ0tfQ0FSRF9FTiB0byBTREhDSV9DTE9DS19DT05UUk9M
IHJlZ2lzdGVyDQo+ID4gOS41MTE0MTM6IHNkaGNpX21zbV9zZXRfY2xvY2s6IG1tYzEgY2xvY2s6
IDANCj4gPiA5LjUxMTQyMzogbW1jX3NldF9zaWduYWxfdm9sdGFnZTogbW1jMSBjYWxsZWQNCj4g
PiA5LjUzMzgxNjogbW1jX3NldF9pb3M6IG1tYzE6IGNsb2NrIDQwMDAwMEh6IGJ1c21vZGUgMiBw
b3dlcm1vZGUgMiBjcyAwDQo+ID4gVmRkIDE4IHdpZHRoIDEgdGltaW5nIDANCj4gPiA5LjUzMzgy
MDogc2RoY2lfc2V0X2lvczogbW1jMSBjYWxsZWQNCj4gPiA5LjUzMzgyMjogc2RoY2lfc2V0X2lv
czogbW1jMSBzZXR0aW5nIGNsb2NrIGlvcy0+Y2xvY2s6IDQwMDAwMA0KPiA+IGhvc3QtPmNsb2Nr
OiAwDQo+ID4gOS41MzM4MjY6IHNkaGNpX21zbV9zZXRfY2xvY2s6IG1tYzEgY2xvY2s6IDQwMDAw
MA0KPiA+IDkuNTMzOTI1OiBzZGhjaV9lbmFibGVfY2xrOiBtbWMxIEVuYWJsaW5nIGNsb2NrcyBi
eSB3cml0aW5nDQo+ID4gU0RIQ0lfQ0xPQ0tfQ0FSRF9FTiB0byBTREhDSV9DTE9DS19DT05UUk9M
IHJlZ2lzdGVyDQo+ID4gOS41MzM5NTA6IHNkaGNpX3NldF9pb3M6IG1tYzEgZ2F0aW5nIGNsb2Nr
cyBieSB3cml0aW5nDQo+ID4gflNESENJX0NMT0NLX0NBUkRfRU4gdG8gU0RIQ0lfQ0xPQ0tfQ09O
VFJPTCByZWdpc3Rlcg0KPiA+IDkuNTMzOTczOiBzZGhjaV9tc21fc2V0X2Nsb2NrOiBtbWMxIGNs
b2NrOiA0MDAwMDANCj4gPiA5LjUzNDA0Mzogc2RoY2lfZW5hYmxlX2NsazogbW1jMSBFbmFibGlu
ZyBjbG9ja3MgYnkgd3JpdGluZw0KPiA+IFNESENJX0NMT0NLX0NBUkRfRU4gdG8gU0RIQ0lfQ0xP
Q0tfQ09OVFJPTCByZWdpc3Rlcg0KPiA+IDkuNTM0MDQ1OiBtbWNfaG9zdF9zZXRfdWhzX3ZvbHRh
Z2U6IG1tYzEgRG9uZQ0KPiA+DQo+ID4gV2FpdCBmb3IgMW1zIGFmdGVyIGVuYWJsaW5nIHRoZSBj
bG9jayBwb3N0IHZvbHRhZ2Ugc3dpdGNoIHRvIG1ha2Ugc3VyZQ0KPiA+IGNsb2NrIGlzIGtlcHQg
YWxpdmUgZm9yIGFsdGVhc3QgMW1zIGFzIHBlciBzcGVjLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2FydGhhayBHYXJnIDxxdWljX3NhcnRnYXJnQHF1aWNpbmMuY29tPg0KPiANCj4gSSBkb24n
dCBrbm93IHRoZSBleGFjdCBiZWhhdmlvdXIgb2Ygc2RoY2kgYXJvdW5kIHRoaXMsIHNvIEkgd2ls
bCBkZWZlciB0byBBZHJpYW4ncw0KPiBpbnB1dCBmb3IgdGhhdC4NCj4gDQo+IEhvd2V2ZXIsIGxl
dCBtZSBwb2ludCBvdXQgdGhhdCBpbiBtbWNfc2V0X3Voc192b2x0YWdlKCkgd2UgYXJlIHRyeWlu
ZyB0byB0YWtlDQo+IHRoZSAxbXMgaW50byBhY2NvdW50LiBNb3JlIHByZWNpc2VseSwgYWZ0ZXIN
Cj4gbW1jX2hvc3Rfc2V0X3Voc192b2x0YWdlKCkgaGFzIGJlZW4gY2FsbGVkIHRvIHN3aXRjaCB0
aGUgdm9sdGFnZSB0byAxLjhWIGFuZA0KPiB0byByZS1lbmFibGUgdGhlIGNsb2NrLCBtbWNfc2V0
X3Voc192b2x0YWdlKCkgZG9lcyBhICJtbWNfZGVsYXkoMSkiIGFuZCB0aGVuDQo+IGl0IGNhbGxz
IHRoZSAtPmNhcmRfYnVzeSgpIG9wcyB0byBjaGVjayB0aGF0IGNhcmQgZG9lc24ndCBzaWduYWwg
YnVzeSBieSBob2xkaW5nDQo+IERBVDAgbG93Lg0KDQpJIGFncmVlIHVsZiB0aGF0IHdlIGFyZSBh
ZGRpbmcgYSBkZWxheSBvZiAxbXMgaW4gbW1jX3NldF91aHNfdm9sdGFnZSBhZnRlciByZW5hYmxp
bmcgdGhlIGNsb2NrcyBidXQgYmVmb3JlIHRoYXQgZGVsYXkgY29tZXMgaW50byBwaWN0dXJlIGNs
b2NrJ3MgYXJlIGdldHRpbmcgZ2F0ZWQgYXMgcGFydCBvZiBzZGhjaV9zZXRfaW9zIGZ1bmN0aW9u
IGFzIHBhcnQgb2YgYmVsb3cgY29kZS4NCg0KMjM4NAkvKiBSZXNldCBTRCBDbG9jayBFbmFibGUg
Ki8NCjIzODUJY2xrID0gc2RoY2lfcmVhZHcoaG9zdCwgU0RIQ0lfQ0xPQ0tfQ09OVFJPTCk7DQoy
Mzg2IAljbGsgJj0gflNESENJX0NMT0NLX0NBUkRfRU47DQoyMzg3IAlzZGhjaV93cml0ZXcoaG9z
dCwgY2xrLCBTREhDSV9DTE9DS19DT05UUk9MKTsNCg0KPiANCj4gSSB1bmRlcnN0YW5kIHRoYXQg
dGhlIGNvZGUgaW4gbW1jX3NldF91aHNfdm9sdGFnZSgpLCBleHBlY3RzIHRoZSBob3N0IHRvIGJl
DQo+IHJhdGhlciBkdW1iIGZyb20gdGhlIEhXIHBlcnNwZWN0aXZlLCB3aGljaCBtYXkgbm90IGFs
d2F5cyBiZSB0aGUgY2FzZS4NCj4gQWx0aG91Z2gsIEkgd291bGQgcmF0aGVyIGF2b2lkIGludHJv
ZHVjaW5nIG5ldyBob3N0IGZsYWdzLCBhbG9uZyB3aGF0IHlvdQ0KPiBwcm9wb3NlIGluIHRoZSAk
c3ViamVjdCBwYXRjaC4gSWYgdGhpcyBjYW4ndCBiZSBtYW5hZ2VkIGluIHNkaGNpLCB3aXRob3V0
IHNvbWUNCj4gbmV3IGhlbHAgZnJvbSB0aGUgbW1jIGNvcmUsIEkgd291bGQgcmF0aGVyIHN1Z2dl
c3QgdGhhdCB3ZSBpbnRyb2R1Y2UgYSBuZXcNCj4gaG9zdCBjYWxsYmFjayB0aGF0IGNhbiBiZSB1
c2VkIHRvIHJlcGxhY2UgdGhlIGVudGlyZSBwYXJ0IGluDQo+IG1tY19ob3N0X3NldF91aHNfdm9s
dGFnZSgpIChvciBzb21ldGhpbmcgYWxvbmcgdGhvc2UgbGluZXMpLg0KPiANCj4gS2luZCByZWdh
cmRzDQo+IFVmZmUNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvY29yZS5jICB8
IDQgKysrKw0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgfCAzICsrKw0KPiA+ICBpbmNs
dWRlL2xpbnV4L21tYy9ob3N0LmggfCAxICsNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYyBi
L2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jIGluZGV4DQo+ID4gYTFlZmRhODVjNmYyLi5kNjNlMDBh
YWI2Y2IgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMNCj4gPiArKysg
Yi9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYw0KPiA+IEBAIC0xMTgxLDYgKzExODEsOCBAQCBpbnQg
bW1jX2hvc3Rfc2V0X3Voc192b2x0YWdlKHN0cnVjdCBtbWNfaG9zdA0KPiAqaG9zdCkNCj4gPiAg
ICAgICAgIGhvc3QtPmlvcy5jbG9jayA9IDA7DQo+ID4gICAgICAgICBtbWNfc2V0X2lvcyhob3N0
KTsNCj4gPg0KPiA+ICsgICAgICAgaG9zdC0+ZG9pbmdfc2lnbmFsX3ZvbHRhZ2Vfc3dpdGNoID0g
dHJ1ZTsNCj4gPiArDQo+ID4gICAgICAgICBpZiAobW1jX3NldF9zaWduYWxfdm9sdGFnZShob3N0
LCBNTUNfU0lHTkFMX1ZPTFRBR0VfMTgwKSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
QUdBSU47DQo+ID4NCj4gPiBAQCAtMTE4OSw2ICsxMTkxLDggQEAgaW50IG1tY19ob3N0X3NldF91
aHNfdm9sdGFnZShzdHJ1Y3QgbW1jX2hvc3QNCj4gKmhvc3QpDQo+ID4gICAgICAgICBob3N0LT5p
b3MuY2xvY2sgPSBjbG9jazsNCj4gPiAgICAgICAgIG1tY19zZXRfaW9zKGhvc3QpOw0KPiA+DQo+
ID4gKyAgICAgICBob3N0LT5kb2luZ19zaWduYWxfdm9sdGFnZV9zd2l0Y2ggPSBmYWxzZTsNCj4g
PiArDQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBpbmRl
eA0KPiA+IGZiNmU5YTgxZjE5OC4uYWM3YzI1NGVlZjRiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0K
PiA+IEBAIC0yMzEyLDYgKzIzMTIsOSBAQCB2b2lkIHNkaGNpX3NldF9pb3Moc3RydWN0IG1tY19o
b3N0ICptbWMsIHN0cnVjdA0KPiBtbWNfaW9zICppb3MpDQo+ID4gICAgICAgICAgICAgICAgIGhv
c3QtPm9wcy0+c2V0X2Nsb2NrKGhvc3QsIGlvcy0+Y2xvY2spOw0KPiA+ICAgICAgICAgICAgICAg
ICBob3N0LT5jbG9jayA9IGlvcy0+Y2xvY2s7DQo+ID4NCj4gPiArICAgICAgICAgICAgICAgaWYg
KG1tYy0+ZG9pbmdfc2lnbmFsX3ZvbHRhZ2Vfc3dpdGNoKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwLCAxMjUwKTsNCj4gPiArDQo+ID4gICAgICAgICAgICAg
ICAgIGlmIChob3N0LT5xdWlya3MgJiBTREhDSV9RVUlSS19EQVRBX1RJTUVPVVRfVVNFU19TRENM
SyAmJg0KPiA+ICAgICAgICAgICAgICAgICAgICAgaG9zdC0+Y2xvY2spIHsNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBob3N0LT50aW1lb3V0X2NsayA9IG1tYy0+YWN0dWFsX2Nsb2NrID8N
Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oIGIvaW5jbHVkZS9saW51
eC9tbWMvaG9zdC5oIGluZGV4DQo+ID4gOGZkZDNjZjk3MWEzLi4wNmM4OGNkN2E4YmYgMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oDQo+ID4gKysrIGIvaW5jbHVkZS9s
aW51eC9tbWMvaG9zdC5oDQo+ID4gQEAgLTUyMSw2ICs1MjEsNyBAQCBzdHJ1Y3QgbW1jX2hvc3Qg
ew0KPiA+ICAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgaHNxX2VuYWJsZWQ7DQo+ID4N
Cj4gPiAgICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAgIGVycl9zdGF0c1tNTUNfRVJSX01B
WF07DQo+ID4gKyAgICAgICBib29sICAgICAgICAgICAgICAgICAgICBkb2luZ19zaWduYWxfdm9s
dGFnZV9zd2l0Y2g7DQo+ID4gICAgICAgICB1bnNpZ25lZCBsb25nICAgICAgICAgICBwcml2YXRl
W10gX19fX2NhY2hlbGluZV9hbGlnbmVkOw0KPiA+ICB9Ow0KPiA+DQo+ID4gLS0NCj4gPiAyLjE3
LjENCj4gPg0K
