Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A69F6E1BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDNFe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNFe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:34:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92A7212C;
        Thu, 13 Apr 2023 22:34:25 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E4cBhn022763;
        Fri, 14 Apr 2023 05:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=lPzv2b2QjmMlKcM058Y7tzEULz14qWMr4jT/EeSqvwI=;
 b=TlE3LFtQhPCNUXVif3BTTD1satObR7WdQ6QIZ+e04fRQ10AhskjvLimyvRtMLbX3KuJG
 XVkLYKXFwbIwjjX98xKgkzC/s7spDxNg+Myoms5sDZ2S2riFKGxN3BollmgMrbt6j/DZ
 USPpHbKmrTAnMxysljaqF6R7olKqk1t7G/JGKaRoKkzMuYOYUkevu75Ayo0Ynfwv0TCV
 rMCJVA5QSZO8pL2gpovs4Pv0iLQQTp7zZC0Jmaelt1ghXOXCUDgXvioPu2C5jqWJVPui
 aZROi5SOJmVzWyjdPrctAwEHGvoRRA9CZ5gNCLKLcS4rL2d3ufkeK2SAG1//nGqRBLmQ ng== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxxhkg7r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 05:33:49 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33E5XmJm028978
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 05:33:49 GMT
Received: from nasanex01a.na.qualcomm.com (10.52.223.231) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 22:33:48 -0700
Received: from nasanex01a.na.qualcomm.com ([fe80::c03c:fa3e:4516:3243]) by
 nasanex01a.na.qualcomm.com ([fe80::c03c:fa3e:4516:3243%12]) with mapi id
 15.02.0986.042; Thu, 13 Apr 2023 22:33:48 -0700
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
Thread-Index: AQHZZLsSreM1n2UsG0iOAGSJueq9468bFEYAgA9GsjA=
Date:   Fri, 14 Apr 2023 05:33:48 +0000
Message-ID: <e492e234b3ec4624ae2f905bdae78785@quicinc.com>
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
 <20230401165723.19762-2-quic_sartgarg@quicinc.com>
 <ZCux+gsR8Nz4Epxw@infradead.org>
In-Reply-To: <ZCux+gsR8Nz4Epxw@infradead.org>
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
X-Proofpoint-ORIG-GUID: ITnVEBb8CIZ5IGmmbnV24JLS3QMru6TB
X-Proofpoint-GUID: ITnVEBb8CIZ5IGmmbnV24JLS3QMru6TB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=989 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304140050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi christoph,

Thanks for your comments.

As mentioned in the cover letter that these ops are needed to implement clo=
ck scaling and partial init features for which we already had below discuss=
ions but faced strong resistance from community. Since these were huge code=
 changes so maintainability was the main concern. Hence we have redesigned =
our entire logic and moved complete code to vendor specific file and to sup=
port this new design now we just need these two hooks in suspend and resume=
 functions along with few symbols to be exported so that we can use those s=
ymbols in our vendor files. I will push the vendor specific changes in the =
next patchset.


Old discussion for Clock scaling feature :
https://patchwork.kernel.org/project/linux-mmc/cover/1571668177-3766-1-git-=
send-email-rampraka@codeaurora.org/

Old discussion for Partial init feature :
https://patchwork.kernel.org/project/linux-mmc/patch/1650963852-4173-1-git-=
send-email-quic_spathi@quicinc.com/

Thanks,
Sarthak

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Tuesday, April 4, 2023 10:44 AM
> To: Sarthak Garg (QUIC) <quic_sartgarg@quicinc.com>
> Cc: adrian.hunter@intel.com; ulf.hansson@linaro.org; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> msm@vger.kernel.org; Ram Prakash Gupta (QUIC)
> <quic_rampraka@quicinc.com>; Bhaskar Valaboju (QUIC)
> <quic_bhaskarv@quicinc.com>; Sachin Gupta (QUIC)
> <quic_sachgupt@quicinc.com>; Pradeep Pragallapati (QUIC)
> <quic_pragalla@quicinc.com>; Sayali Lokhande (QUIC)
> <quic_sayalil@quicinc.com>; Brian Norris <briannorris@chromium.org>;
> Wolfram Sang <wsa+renesas@sang-engineering.com>; Linus Walleij
> <linus.walleij@linaro.org>
> Subject: Re: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable
> internal features
>=20
> On Sat, Apr 01, 2023 at 10:27:22PM +0530, Sarthak Garg wrote:
> > Define new ops to let vendor enable internal features in
> > mmc_suspend/resume paths like partial init feature.
>=20
> 1) vendors have absolutely no business doing anything, you might be
>    doing either something entirely wrong or use the wrong terminology
>    here.
>=20
> 2) any kind of core hook not only needs a very good description, but
>    also an actual user that goes along in the same series.

