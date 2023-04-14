Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98896E1CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDNGxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:53:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BBE10F3;
        Thu, 13 Apr 2023 23:53:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E6U9Xt025305;
        Fri, 14 Apr 2023 06:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=2pVW8ketNRb+oakq1EgzGeek6bIazHMT5U1Px10lHjU=;
 b=GPdGsydu6F44pwpldXUqW46CPSGHbGCG3kZbk+OyHhFe4APMPTlA6gbI5+pP7WmpZH7G
 uLyL/I9heD0e69N+dySwHxXLv5ZbIr/MTR5I3aOSFBLPW9HXw4DOiuSuL7sdnj0fLie8
 wlQy/FIw0tIwDr2N22d4I74N8TLmp3x8BClRkqURZ2uDvB7HAaUTPmZkX3cC1mFb5l2r
 AzgItmUKL8tp6QL8YRAbZdHJBlK1bi9J1+w6yLchcFerHHORSs5NU3GcTuEqxNcO8teZ
 ABPSMTRTjVnd3mQGAATD/P7AUCSAicOaHqlhX8QYimrcjXrkKmgkzhVQ2QCwJJaZbgmS 0g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxxhkgdqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 06:52:19 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33E6qJQs000919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 06:52:19 GMT
Received: from nasanex01a.na.qualcomm.com (10.52.223.231) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 23:52:18 -0700
Received: from nasanex01a.na.qualcomm.com ([fe80::c03c:fa3e:4516:3243]) by
 nasanex01a.na.qualcomm.com ([fe80::c03c:fa3e:4516:3243%12]) with mapi id
 15.02.0986.042; Thu, 13 Apr 2023 23:52:18 -0700
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
Thread-Index: AQHZZLsSreM1n2UsG0iOAGSJueq9468bFEYAgA9GsjCAAHb4AP//nJxw
Date:   Fri, 14 Apr 2023 06:52:18 +0000
Message-ID: <53eda50111e2402e889bd690a0112ee1@quicinc.com>
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
 <20230401165723.19762-2-quic_sartgarg@quicinc.com>
 <ZCux+gsR8Nz4Epxw@infradead.org>
 <e492e234b3ec4624ae2f905bdae78785@quicinc.com>
 <ZDjmTi1+WA2BtLct@infradead.org>
In-Reply-To: <ZDjmTi1+WA2BtLct@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.5.147]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tWyH60GFlUM8L4J2KUwSh-1IAtapRmEL
X-Proofpoint-GUID: tWyH60GFlUM8L4J2KUwSh-1IAtapRmEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=707 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304140061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the confusion by vendor file I meant driver file for Qualcomm SDC=
C controller (sdhci-msm.c).
Further to make things more clear I will push the complete series.

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Friday, April 14, 2023 11:06 AM
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
> You don't get it.  There is no such thing "as vendor files".
>=20
> I'm not sure where you get your terminology from, but whatever that is mi=
ght
> be your source of the fundamental misunderstanding how Linux kernel
> development works.  I would recommend to take some training before wastin=
g
> everyones time.

