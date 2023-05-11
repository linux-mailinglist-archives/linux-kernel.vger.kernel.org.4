Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6E26FEB02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbjEKFBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjEKFBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:01:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2755930EB;
        Wed, 10 May 2023 22:00:59 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B3f3hF027445;
        Thu, 11 May 2023 05:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=zuL2sjpi13HXnQSxvXxQtFgiwlU0qeaUXm5LPxK416M=;
 b=l9KfjzhGciAy3GYwN3Oso/KmPAfIBSvia2tJCvnP1vEP38XQpZGqjDSMjrWc7WMiC95f
 hcYSJ+5X49OWvVzwkfZ4BQPIporBQMMDVHBbFwPIKZHT/mE1RYhOosgEyxDgC+0KmWWv
 gHCIzwU56cnxcPBgmSVrqgxeqj3xcLzJ5NiZm1LeWJC+iZIS3Q2t1x15OhGMuceFRVtZ
 cZYtQoRia/Tu1yodiNHIb/Z5BqminTk4lqfrDpasOSjzka74e+S9gI+RMakmJxYHij9g
 /ro3xRezQ3KPJtCu7dCrBeISDPJatcVYw8ZrVg1/wKgM/gH2ya4K+g4rN5K8CAXlgYAW DA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgdd9sds8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 05:00:46 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34B50PqP007411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 05:00:25 GMT
Received: from nasanex01a.na.qualcomm.com (10.52.223.231) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 22:00:24 -0700
Received: from nasanex01a.na.qualcomm.com ([fe80::efb2:2dda:c355:1de3]) by
 nasanex01a.na.qualcomm.com ([fe80::efb2:2dda:c355:1de3%12]) with mapi id
 15.02.0986.042; Wed, 10 May 2023 22:00:24 -0700
From:   "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Bhaskar Valaboju (QUIC)" <quic_bhaskarv@quicinc.com>,
        "Sachin Gupta (QUIC)" <quic_sachgupt@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>,
        Brian Norris <briannorris@chromium.org>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable
 internal features
Thread-Topic: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable
 internal features
Thread-Index: AQHZZLsSreM1n2UsG0iOAGSJueq9468bFEYAgA9GsjCAAHb4AP//nJxwgADjuYCAJTsTYA==
Date:   Thu, 11 May 2023 05:00:24 +0000
Message-ID: <c1dc3d77db644958b906fa55200a0ae2@quicinc.com>
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
 <20230401165723.19762-2-quic_sartgarg@quicinc.com>
 <ZCux+gsR8Nz4Epxw@infradead.org>
 <e492e234b3ec4624ae2f905bdae78785@quicinc.com>
 <ZDjmTi1+WA2BtLct@infradead.org>
 <53eda50111e2402e889bd690a0112ee1@quicinc.com>
 <ZDlR9VB7jRxMsEZH@infradead.org>
In-Reply-To: <ZDlR9VB7jRxMsEZH@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.8.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fkvlJ7lTMBMSgRr8zFHGHeMZ7aLa0Spc
X-Proofpoint-ORIG-GUID: fkvlJ7lTMBMSgRr8zFHGHeMZ7aLa0Spc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your valuable comments. We didn't ignore the previous comments i=
nstead we tried to address most of the comments by trying the suggested alt=
ernatives as well but didn't see power improvement as compared to this feat=
ure. Moreover we got the intuition that maintainability was the main concer=
n hence we came up with this newer approach of hooks to limit the lines of =
code in core layer. Every change was pushed earlier in the previous posts a=
nd this time we just refactored the code and was about to push the series b=
ut as per current discussion we'll be reviving the old discussion and try t=
o close all the comments. Closing this thread now.

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Friday, April 14, 2023 6:46 PM
> To: Sarthak Garg (QUIC) <quic_sartgarg@quicinc.com>
> Cc: Christoph Hellwig <hch@infradead.org>; adrian.hunter@intel.com;
> ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org; Ram Prakash Gupta
> (QUIC) <quic_rampraka@quicinc.com>; Bhaskar Valaboju (QUIC)
> <quic_bhaskarv@quicinc.com>; Sachin Gupta (QUIC)
> <quic_sachgupt@quicinc.com>; Pradeep Pragallapati (QUIC)
> <quic_pragalla@quicinc.com>; Sayali Lokhande (QUIC)
> <quic_sayalil@quicinc.com>; Brian Norris <briannorris@chromium.org>;
> Wolfram Sang <wsa+renesas@sang-engineering.com>; Linus Walleij
> <linus.walleij@linaro.org>
> Subject: Re: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable
> internal features
>=20
> On Fri, Apr 14, 2023 at 06:52:18AM +0000, Sarthak Garg (QUIC) wrote:
> > Sorry for the confusion by vendor file I meant driver file for Qualcomm=
 SDCC
> controller (sdhci-msm.c).
>=20
> This is still not how we do development.  The two series you've been poin=
ted out
> got valuable feedback that;s been ignored for between one and four years,=
 that
> needs to be followed up with.
>=20
> You're not going to get magic hooks for your driver that you're not shari=
ng with
> us just because you're too lazy to follow up on the review comments.
