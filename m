Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14978688823
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBBUP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjBBUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:15:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C12A56480
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:15:22 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312K4YTu031813;
        Thu, 2 Feb 2023 20:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=pZZYul9J/ixZEIegkYZTjTPDfgFDY36EFfrtcPEsdOE=;
 b=Aei0AmCqexEYsbaaVKrljSW0SdQztLowBma/9FXIJytcQ85ixK5E+FM5SeXdHqRxkbeW
 WLDsWz7oXQS1Xj/Oyhtu23ZnBuMuqeIuoHwq3K1HN+rzalmM69kq/0u5UAesMWwGCIYH
 X/DyQ5+vILk0twAwHEBXSDD+Na8v3Egs9cy/c1j0YvETRkpsPZXrUImtotwMop4NIS6B
 O8K787XES9tfX0XB+EqyKnmLZzLh4UnBU3/ifdMG0+0US+CnS7SokTQE1rZnQB/JDG+k
 pKagUBR+icMmxI7R44knJr8e74gIbFV6uZg3SyXXO0ZQmF5n+zZ890GWw2hH+jz+LsXP iw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfkj4c2w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 20:13:05 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312KD4Xa025106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 20:13:04 GMT
Received: from hu-sbhattip-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 12:13:03 -0800
Date:   Thu, 2 Feb 2023 12:13:02 -0800
From:   Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
CC:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Message-ID: <20230202201302.GB22373@hu-sbhattip-lv.qualcomm.com>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
 <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
 <Y9mraBHucYdnHXiS@P9FQF9L96D.corp.robot.car>
 <20230201040628.GA3767@hu-cgoldswo-sd.qualcomm.com>
 <Y9q2yUZmCiNd7iYC@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9q2yUZmCiNd7iYC@P9FQF9L96D.corp.robot.car>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EduucOTmJWbA7olC4l2X28vb6Kr7W3O9
X-Proofpoint-ORIG-GUID: EduucOTmJWbA7olC4l2X28vb6Kr7W3O9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=673 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Roman,

On Wed, Feb 01, 2023 at 11:00:25AM -0800, Roman Gushchin wrote:
> Then _maybe_ a new knob is justified, at least I don't have better ideas.
> Rik, do you have any input here?
> 
> Let's then define it in a more generic way and _maybe_ move to the cma
> sysfs/debugfs (not 100% sure about this part, but probably worth exploring).

We should be able to use a sysfs parameter too. Will try that out. But could
you elaborate on what is more generic way?

Also regarding following in the earlier message:

> Also, if decide to go with a new sysctl, we probably want to define it differently,
> e.g. as a [0-1000)/1000 of the zone size. But, honestly, I'm not sold yet.

Are you saying that the ratio should be limited to 1000th of the zone size?
Or of the free pages in the zone? If the zone is large, 1000th of it would
still be quite big?

Sukadev
