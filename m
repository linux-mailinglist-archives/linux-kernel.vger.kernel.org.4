Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4372D80E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjFMDPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbjFMDOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:14:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C4AE7D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:13:25 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D2okBE026900;
        Tue, 13 Jun 2023 03:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=C6/yV/Vq3nHnej1jBfjeowe/1deuVDw+kvoXqNqcZgs=;
 b=kLBmKwzS9n7fmKVsXHH08/m1suVWw1HqWp9Ac4kQQdhCYpf8Bq0vnBiEjmTjYlkzsHHw
 LSpbBUm/3uZXvPtIFNFqfJqhPIL6ifftRT/lD2DXUG+hcnZXKXWYuDlulVDnVNfNHI8Z
 lK9M167Pvv7pTvUP6gfyFdpxS7SU/npR35n3wnVCBOVHI9qYDDWgkyqv28k7neIvglSZ
 LuMhGze7iIQ0jwkcSJNg+Qy5T5Q2FmNvHI6Bspu3y/j6EYkJQDl1qxSRRLerBwha3l81
 PpRfyUEin9A1LDpzr/Ja0x9Cxhx/zBK5kynGApSArWGHKpG/QChwVCwDrAe9y/t0ZCw0 tA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r61q21q78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 03:13:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35D3DD4Y030721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 03:13:13 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 20:13:10 -0700
Date:   Tue, 13 Jun 2023 08:43:06 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
CC:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
Message-ID: <20230613031306.GB1860372@hu-pkondeti-hyd.qualcomm.com>
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
 <20230531221955.GD102494@cmpxchg.org>
 <230e45e8-8cd8-3668-bbfa-a95212b4cb99@quicinc.com>
 <20230605180013.GD221380@cmpxchg.org>
 <f3f15b6a-8618-f755-f21c-4193c502e65c@quicinc.com>
 <CAJuCfpFB33GLbwvYspg966b6AGMopS3ca68hjL94kgpM7et7CQ@mail.gmail.com>
 <4543c4e5-43f1-bae2-245e-951437e4bd07@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4543c4e5-43f1-bae2-245e-951437e4bd07@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ojl4r2Mo_Ojhmq4J9Ynkclsv9-AISmlw
X-Proofpoint-ORIG-GUID: ojl4r2Mo_Ojhmq4J9Ynkclsv9-AISmlw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=956
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 06:12:28PM +0530, Charan Teja Kalla wrote:
> Thanks Suren & Johannes,
> 
> On 6/7/2023 1:18 AM, Suren Baghdasaryan wrote:
> > Hi Folks. Sorry for being late to the party.
> > Yeah, userspace does not have a crystal ball to predict future user
> > behavior, so there will always be pathological cases when usual
> > assumptions and resulting madvise() would make things worse.
> > 
> > I think this discussion can be split into several questions/issues:
> > 1. Inconsistency in how madvise(MADV_PAGEOUT) would affect PSI
> > calculation when the page is refaulted, based on the path it took
> > before being evicted by madvise(). In your initial description case
> > (a) is inconsistent with (b) and (c) and it's probably worth fixing.
> > IMHO (a) should be made consistent with others, not the other way
> > around. My reasoning is that page was expelled from the active list,
> > so it was part of the active workingset.
> > 
> That means we should be setting Workingset on the page while it is on
> the active list and when it is being pageout through madvising. Right? I
> see, this makes it consistent.
> 
> On the same note, discussing with Suren offline, Should the refaulted
> madvise pages start always at the inactive list? If they are really
> active, they get promoted anyway..
> 
Can you elaborate on the rationale why refaulted madvise pages needs to
be on inactive list? If it had not been paged out via madvise, it would
have been activated no?

Thanks,
Pavan
