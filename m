Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59029685E29
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBAEI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBAEIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:08:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF448A2A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 20:08:53 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3113rD7q024180;
        Wed, 1 Feb 2023 04:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=jeG1kJgmiYXAQEdKnh8AQsfZmwuryvrkVGa5eVwhPlU=;
 b=MIXk41jil1BwBuPoa2u0uUhnCwKSypZW/r3l5Hf57KWFsqk088ItUGug8KVnqKRDYElK
 bVycONdBwnQ2owUL+idzjwUPzTDwg0qF3gRa0j48Pq/ex1lxsVZmLa36qZ75+L7cI2yW
 gYqRkpudFm4dQN4iJ3HLwMeYAcem2DfE2COah/PEg9EH5iaAvOmpSkN36Ak7HUB859ud
 br5BTniSAh+7P9AHNPHZB+ZKhVpYadJBvOs6zYMXqamHasBLv7J2FmDp6APIFzrnzW2T
 Qvngqcom8FQdRxYC99vPZh5VhvRo4v5EssJ1LNf9092iD5CBqoTsMyx7lZC7/Dxep5vg vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3new3uawqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 04:06:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31146adg021519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 04:06:36 GMT
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 20:06:35 -0800
Date:   Tue, 31 Jan 2023 20:06:28 -0800
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
CC:     Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Message-ID: <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4NYaRv6g8HHNJPyqaLQusuG72RlX1VbC
X-Proofpoint-ORIG-GUID: 4NYaRv6g8HHNJPyqaLQusuG72RlX1VbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 suspectscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:59:36PM -0800, Roman Gushchin wrote:
> On Tue, Jan 31, 2023 at 12:10:01PM -0800, Sukadev Bhattiprolu wrote:
> > On Tue, Jan 31, 2023 at 10:10:40AM -0800, Roman Gushchin wrote:
> > > Hi Sukadev!
> > > 
> > > Can you, please, share a bit more details about your setup? E.g. what is
> > > the zone size, the cma area size and the value you want to set your sysctl to?
> > 
> > Hi Roman,
> > 
> > I currently have a device with 8GB Zone normal and 600MB of CMA. We have a
> > slightly different implementation and use up all the available CMA region.
> > i.e. going forward, we intend to set the ratio to 100 or even higher.


Hi Roman,

> It means you want allocations be always served from a cma region first?

Exactly.

> What's the point of it?

We're operating in a resource constrained environment, and we want to maximize
the amount of memory free / headroom for GFP_KERNEL allocations on our SoCs,
which are especially important for DMA allocations that use an IOMMU. We need a
large amount of CMA on our SoCs for various reasons (e.g. for devices not
upstream of an IOMMU), but whilst that CMA memory is not in use, we want to
route all GFP_MOVABLE allocations to the CMA regions, which will free up memory
for GFP_KERNEL allocations. 

> The idea behind the current formula is to keep cma regions free if there is
> a plenty of other free memory, otherwise treat it on par with other memory.

With the current approach, if we have a large amount of movable memory allocated
that has not gone into the CMA regions yet, and a DMA use case starts that
causes the above condition to be met, we would head towards OOM conditions when
we otherwise could have delayed this with this change.  Note that since we're
working on Android, there is a daemon built on top of PSI called LMKD that will
start killing things under memory pressure (before an OOM is actually reached)
in order to free up memory. This patch should then reduce kills accordingly for
a better user experience by keeping a larger set of background apps alive. When
a CMA allocation does occur and pages get migrated out, there is a similar
reduction in headroom (you probably already know this and know of the FB
equivalent made by Johannes Weiner). 

Thanks,

Chris.
