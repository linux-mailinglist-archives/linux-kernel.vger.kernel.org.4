Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A80E707CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjERJ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjERJ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:26:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1CFC3;
        Thu, 18 May 2023 02:26:47 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I8iWYk017337;
        Thu, 18 May 2023 09:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=l4eWh7+rn5/X+0JGaPIW3uUeEg7Fa2SZlqeEZEpEiks=;
 b=LEAD5wwSE9HQJ9AycMMftYTnwwtmawYiXqE85eGs4AgcRF7WbnUd2KBnpBlTCSXkCfUf
 ytXqLUtq9CRohao6lhKF0k2HkjLEsSEgGgLIbj/Zhh+GFd0l8gCNS2bSqjPxVyxgYt0/
 XPllS0UVuGtQRTHSW6b9WmH2dLss3CLFYhx2X/pcFoiwwQwHUtjTj8rQTrynzuiy8fDo
 RdkHgsib7kZj3QOa3vr1S/yf5CGXe1gJCsp1Drj9ALCHI2nP6cCNDFQjN8zmmEj7XgcR
 /eT/gQkmwW7TXw/HUkfKWenW2Vc7QNhnhsHoVSoGRabQXtMGmEvSvLluZSUGrqpanxu+ 6w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn73us21x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 09:26:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34I9PqFa006447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 09:25:52 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 02:25:52 -0700
Received: from nalasex01a.na.qualcomm.com ([fe80::5cb1:e5a2:c713:5b68]) by
 nalasex01a.na.qualcomm.com ([fe80::5cb1:e5a2:c713:5b68%4]) with mapi id
 15.02.0986.042; Thu, 18 May 2023 02:25:52 -0700
From:   "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Yu Kuai <yukuai1@huaweicloud.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
Thread-Topic: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
Thread-Index: AQHZiJvu5joNBe/ZIUyNvEQWRViGA69en4qAgAAGL4CAAABcAIAAAuMAgAD7kXA=
Date:   Thu, 18 May 2023 09:25:52 +0000
Message-ID: <7e32c001d222483394327c5802a6c985@quicinc.com>
References: <20230517084434.18932-1-quic_pragalla@quicinc.com>
 <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
 <a2f86cd7-776c-d7ed-8815-62683a14ba36@kernel.org>
 <ZGScoCeOILHpc8c1@infradead.org>
 <344bfde9-5f7e-80a2-038f-3bfc387ea678@kernel.org>
In-Reply-To: <344bfde9-5f7e-80a2-038f-3bfc387ea678@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.217.217.238]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8jhhghv1qUXGe0RYN3HCsKAQqt7O2nCV
X-Proofpoint-GUID: 8jhhghv1qUXGe0RYN3HCsKAQqt7O2nCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_07,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=454 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYW1pZW4gTGUgTW9hbCA8
ZGxlbW9hbEBrZXJuZWwub3JnPiANClNlbnQ6IFdlZG5lc2RheSwgTWF5IDE3LCAyMDIzIDM6MDIg
UE0NClRvOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+DQpDYzogWXUgS3Vh
aSA8eXVrdWFpMUBodWF3ZWljbG91ZC5jb20+OyBQcmFkZWVwIFByYWdhbGxhcGF0aSAoUVVJQykg
PHF1aWNfcHJhZ2FsbGFAcXVpY2luYy5jb20+OyBheGJvZUBrZXJuZWwuZGs7IGxpbnV4LWJsb2Nr
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgeXVrdWFpIChD
KSA8eXVrdWFpM0BodWF3ZWkuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCBWMV0gYmxvY2s6IEZp
eCBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UgaXNzdWUgb24gc3RydWN0IGlvX2NxDQoNCk9uIDUv
MTcvMjMgMTg6MjEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBXZWQsIE1heSAxNywg
MjAyMyBhdCAwNjoyMDoxOVBNICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4+IHR3aWNl
IGZvciB0aGUgc2FtZSBpY3EuIFRoZSBtaXNzaW5nIHJjdSBsb2NrIGluIGlvY19leGl0X2ljcXMo
KSANCj4+IGFscmVhZHkgd2FzIGluIGl0c2VsZiBhIGJ1ZywgYW5kIHRoZSBtaXNzaW5nIGZsYWcg
Y2hlY2sgaXMgYW5vdGhlci4NCj4gDQo+IHNwaW5sb2NrcyBpbXBseSBhIHJjdSBjcml0aWNhbCBz
ZWN0aW9uLCBubyBuZWVkIHRvIGR1cGxpY2F0ZSBpdC4NCg0KUmlnaHQuIEFuZCBJIG1pc3JlYWQg
dGhlIGNvZGUuIEFzIFl1IHNhaWQsIGdpdmVuIHRoYXQgaW9jX2V4aXRfaWNxcygpIGl0ZXJhdGVz
IHRoZSBsaXN0IG9mIGljcXMgdW5kZXIgaW9jLT5sb2NrIGFuZCB0aGUgaW9jIGlzIHJlbW92ZWQg
ZnJvbSB0aGF0IGxpc3QgdW5kZXIgdGhlIHNhbWUgbG9jaywgaW9jX2V4aXRfaWNxcygpIHNob3Vs
ZCBuZXZlciBzZWUgYW4gaWNxIHRoYXQgd2VudCB0aHJvdWdoIGlvY19kZXN0cm95X2ljcSgpLi4u
DQpWZXJ5IHdlaXJkLg0KDQpUaGlzIHdlaXJkIGNhbiBiZSBwb3NzaWJsZSANCjEuIHVwZGF0aW5n
IGljcV9oaW50IHdoaWNoIGlzIGFubm90YXRlZCBhcyBfX3JjdSB0eXBlIHdpdGhvdXQgUkNVLXBy
b3RlY3RlZCBjb250ZXh0IGluIGlvY19kZXN0cm95X2ljcSgpLg0KTW9yZW92ZXIsIHRoaXMgd2Fz
IHRha2VuIGNhcmUgaW4gZWxzZSBwYXJ0IG9mIGlvY19yZWxlYXNlX2ZuKCkgYnkgcmN1X3JlYWRf
bG9jay91bmxvY2soKSBidXQgbWlzc2VkIGluIGlmIHN0YXRlbWVudCB3aGljaCBjYW4gbGVhZCB0
byB0aGlzIHdlaXJkLg0KDQoyLiBleHRyYWN0aW5nIGljcSBmcm9tIGhsaXN0L2xpc3QgZWxlbWVu
dHMgYXJlIGRvbmUgdXNpbmcgcmN1IGxvY2tzIHByb3RlY3RlZCBpbiBpb2NfY2xlYXJfcXVldWUo
KSBidXQgc2FtZSB3YXMgbm90IGF0IGlvY19leGl0X2ljcXMoKS4NCg0KU28sIGZhciB3ZSBoYXZl
IHNlZW4gMTArIGluc3RhbmNlcyBvZiB0aGlzIGNyYXNoIG9uIDYuMSBrZXJuZWwgZHVyaW5nIHN0
YWJpbGl0eSB0ZXN0aW5nIChJbnZvbHZlcyBJTywgcmVib290cywgZGV2aWNlIHN1c3BlbmQvcmVz
dW1lLCBhbmQgZmV3IG1vcmUpLg0KV2l0aCB0aGUgVjEgcGF0Y2gsIHdlIGRpZG4ndCBvYnNlcnZl
IHRoZSBpc3N1ZSBmb3IgYXQgbGVhc3QgNDhocnMrIG9mIHN0YWJpbGl0eSB0ZXN0aW5nLg0KDQoN
Ci0tDQpEYW1pZW4gTGUgTW9hbA0KV2VzdGVybiBEaWdpdGFsIFJlc2VhcmNoDQoNCg==
