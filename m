Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD06E5D29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDRJQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDRJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:16:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CAB4ED0;
        Tue, 18 Apr 2023 02:16:48 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6uWt6020701;
        Tue, 18 Apr 2023 09:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=r73f9qKNQpo8uwsqv0DYvzXxN3vjBzWK0D2/T4vnD+A=;
 b=jiamxwjHAiq0Q5Nv/38NjIEG93ujyQuMs/26Jf2TIO+LDnjwwwi0aCU6dHnkMUd50VKF
 oYg7q1WiPgHPK4TVUluAUHC/Rdf3DYeU8ZRaNH6tzzC47jM2BspHXWiZTmbVcz8Rcx0J
 a8wC6qOZOpXtip/XupTvvvehWCiHliYY5bDrJ33UgM64iuOy+apsCgws7CtoSnJPSHGr
 UZHCdMJf7fuCdFoZOmsFf4UmIDNpbam/PD1okPEi+eIi82r1TRoM4qB3cEgWAsnbNNBC
 ku8a4lJ/+tN8bhbb8emDFsuKOFW3yyeElnB1RukeRjq0nR2OZOGvq0z1K+su0tp5xms9 9A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1bvkseca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:16:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I9Ghb9003618
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:16:44 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 18 Apr 2023 02:16:43 -0700
Received: from nalasex01b.na.qualcomm.com ([fe80::27dd:ab4b:a3c:3d0a]) by
 nalasex01b.na.qualcomm.com ([fe80::27dd:ab4b:a3c:3d0a%12]) with mapi id
 15.02.0986.042; Tue, 18 Apr 2023 02:16:43 -0700
From:   "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
To:     "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "mka@chromium.org" <mka@chromium.org>
Subject: RE: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
Thread-Topic: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
Thread-Index: AQHZbdNSzRZimAa7YESiLSr50VCixK8rwqCAgAMeQQCAAmHlgP//ixIggAB3BoD//4sm0A==
Date:   Tue, 18 Apr 2023 09:16:43 +0000
Message-ID: <11d65b0864b142ffb92255318ce70c45@quicinc.com>
References: <20230413064344.18714-1-quic_tjiang@quicinc.com>
 <CAA8EJpoc4nn+Wr131-o=YQoDeL0t7aj9hC=8NNnJa3SeHwgJ-w@mail.gmail.com>
 <934c32ef9427464a9d0b898b843df6ab@quicinc.com>
 <CAA8EJpqz9o9CtAnXRE86kw-cfL=_d-c5BDAXwQLSJAyZRy_fEg@mail.gmail.com>
 <a908e04e9b7d4b97bc6b5ee3c713e71f@quicinc.com>
 <CAA8EJprztGdP0yqV=O6P2tn4i0+iQ4rfBVY2x-3_93o3C0c-Nw@mail.gmail.com>
In-Reply-To: <CAA8EJprztGdP0yqV=O6P2tn4i0+iQ4rfBVY2x-3_93o3C0c-Nw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.109.133]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WIFQ9xLVxJ4laRU546pZEKd2oQMXwkcA
X-Proofpoint-ORIG-GUID: WIFQ9xLVxJ4laRU546pZEKd2oQMXwkcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=775 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5Og0KDQo+ID4gT24gVGh1LCAxMyBBcHIgMjAyMyBhdCAwOTo0NCwgVGltIEppYW5n
IDxxdWljX3RqaWFuZ0BxdWljaW5jLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gV0NONjg1NSB3
aWxsIHJlcG9ydCBtZW1kdW1wIHZpYSBBQ0wgZGF0YSBvciBIQ0kgZXZlbnQgd2hlbiBpdCBnZXQg
DQo+ID4gPiBjcmFzaGVkLCBzbyB3ZSBjb2xsZWN0IG1lbWR1bXAgdG8gZGVidWcgZmlybXdhcmUu
DQo+ID4NCj4gPiBJcyBpdCBhcHBsaWNhYmxlIG9ubHkgdG8gd2NuNjg1NSBvciB0byBzb21lIG9m
IGVhcmxpZXIgY2hpcHMgdG9vPw0KPiA+ICBbVGltXSAgQWxzbyBhcHBsaWNhYmxlIHRvIGVhcmxp
ZXIgY2hpcHMgLCBidXQgY3VycmVudGx5IGdvb2dsZSBvbmx5IA0KPiA+IHJlcXVpcmUgdXMgdG8g
c3VwcG9ydCB3Y242ODU1DQo+DQo+IFNpbmNlIHVwc3RyZWFtIGlzIG5vdCBhIGdvb2dsZSBrZXJu
ZWwsIHBsZWFzZSBlbmFibGUgdGhpcyBmZWF0dXJlIGZvciBhbGwgcmVsZXZhbnQgY2hpcHNldHMu
DQo+IFtUaW1dIGFncmVlZCAsIGJ1dCB0aGUgdGl0bGUgb2YgdGhpcyBnZXJyaXQgdW5jaGFuZ2Vk
LCAgSSByYWlzZSBhIG5ldyBnZXJyaXQgZm9yIG90aGVyIHJlbGV2YW50IGNoaXBzZXRzICwgaXMg
T0s/DQoNClRoZXJlIGlzIG5vIGdlcnJpdCBoZXJlLg0KDQpBbHNvLCBpcyB0aGVyZSBhbnkgY2hh
bmNlIHlvdSBjYW4gZml4IHlvdXIgZW1haWwgY2xpZW50IHRvIHN0b3AgcHV0dGluZyBvbGQgaGVh
ZGVycyBhdCB0aGUgdG9wIG9mIHRoZSBlbWFpbD8NCltUaW1dIHNvcnJ5IGZvciBjb25mdXNpb24s
IEkgbWVhbiBJIHdpbGwgcmFpc2UgYW5vdGhlciBuZXcgY2hhbmdlIGZvciBvdGhlciByZWxldmFu
dCBjaGlwc2V0LCBpcyBPSyA/IA0KIGFuZCBJIHVzZSBvZmZpY2UgMzY1IHRvIHJlcGx5IHlvdXIg
ZW1haWwgd2hpY2ggd2lsbCBhZGRpbmcgb2xkIGhlYWRlcnMgYXV0b21hdGljYWxseSAsIHVubGVz
cyBJIGRlbGV0ZSB0aGUgb2xkIGhlYWRlcnMgbWFudWFsbHksIHRoYW5rIHlvdS4NCg0KPg0KPiA+
DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVGltIEppYW5nIDxxdWljX3RqaWFuZ0BxdWlj
aW5jLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgfCAy
MjINCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIyMiBpbnNlcnRpb25zKCspDQo+DQo+DQo+DQo+DQo+IC0tDQo+IFdp
dGggYmVzdCB3aXNoZXMNCj4gRG1pdHJ5DQoNCg0KDQotLQ0KV2l0aCBiZXN0IHdpc2hlcw0KRG1p
dHJ5DQo=
