Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883F68B52D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 06:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBFFY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 00:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFFYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 00:24:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77384196B0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 21:24:54 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3163VnAD029567;
        Mon, 6 Feb 2023 05:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=p+rsc6DQbrD7yDxjGjkUdxSj3SZhUyq9RJ28wdQbzLs=;
 b=aHStcY5wTECufCF4kwixUeXpxWkQeC4NSP625nZLB60crK4f73wjIkDvBzVqZFQokqdt
 HCumH7aLwJK8XH28gl+pNzo27sRKFRstXVEjd2wSMHMtsgb+PLZGwP/9ygIcawAnIpIt
 +Gpz85BI2REHVb+aY+9HyfRalmXvvumJ5x5dv6Xroy4K/TFzeJSjqVSe8MeQiEeHugut
 6lGhnJwc02ou8oA3aQhJr6/4XsyCAoeUfFOpvBL5Aihe+fxyGi5MvDJJ2qFQdLf0Kp+x
 EFcDWA/5LhEM8+XWaxzyJjK8HMjZk4nKkcr2kI/mLUMV/n/Qor9vCkOABxc3AiUQpQnj Sg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhey72uv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 05:22:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3165MUwt007488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 05:22:30 GMT
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 5 Feb 2023 21:22:29 -0800
Date:   Sun, 5 Feb 2023 21:22:28 -0800
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     Minchan Kim <minchan@kernel.org>
CC:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <js1304@gmail.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Message-ID: <20230206052139.GA21897@hu-cgoldswo-sd.qualcomm.com>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
 <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
 <Y9r6LtMOPHfxr7UL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9r6LtMOPHfxr7UL@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Qc1Sgx4fNAH7_Ob2BY89PfaraWLKIhm5
X-Proofpoint-GUID: Qc1Sgx4fNAH7_Ob2BY89PfaraWLKIhm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_02,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=738 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 03:47:58PM -0800, Minchan Kim wrote:
> Hi Chris,
> 
> On Tue, Jan 31, 2023 at 08:06:28PM -0800, Chris Goldsworthy wrote:
> > We're operating in a resource constrained environment, and we want to maximize
> > the amount of memory free / headroom for GFP_KERNEL allocations on our SoCs,
> > which are especially important for DMA allocations that use an IOMMU. We need a
> > large amount of CMA on our SoCs for various reasons (e.g. for devices not
> > upstream of an IOMMU), but whilst that CMA memory is not in use, we want to
> > route all GFP_MOVABLE allocations to the CMA regions, which will free up memory
> > for GFP_KERNEL allocations. 
> 
> I like this patch for different reason but for the specific problem you
> mentioned, How about making reclaimer/compaction aware of the problem:
> 
> IOW, when the GFP_KERNEL/DMA allocation happens but not enough memory
> in the zones, let's migrates movable pages in those zones into CMA
> area/movable zone if they are plenty of free memory.
> 
> I guess you considered but did you observe some problems?

Hi Minchan,

This is not an approach we've considered. If you have a high-level idea of the
key parts of vmscan.c you'd need to touch to implement this, could you point me
to them?

I guess one drawback with this approach is that as soon as kswapd starts,
psi_memstall_enter() is called, which can eventually lead to LMKD running in
user space, which we want to minimize. One aim of what we're doing this is to
delay the calling of psi_memstall_enter().

It would be beneficial though on top of our change: if someone called
cma_alloc() and migrated out of the CMA regions, changing kswapd to behave like
this would move things back into the CMA regions after cma_release() is called
(instead of having to kill a user space process to have the CMA re-utilized upon
further user space actions).

Thanks,

Chris.
