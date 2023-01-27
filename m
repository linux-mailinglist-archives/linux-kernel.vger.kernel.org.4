Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC46567DC39
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjA0CVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjA0CVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:21:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E28F3C281
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:21:21 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R1j3Io019437;
        Fri, 27 Jan 2023 02:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Lp05XCaPWf0U23eMLOvtWyP1zmNLo0APsR0YlYOciiE=;
 b=OY2TDJ7b+61N9bMXebaxmun8TxKw3pOw7nUDSaqKFV/8wcJD1v4Cu1/6zcH9BAQG2Rjb
 4MrCJdWYGNiohqY0jkmPN8gs1bUyc48xZpuQDSA1gPoLJ44Bz0rJ6xXka10aemwMiDUi
 MFESvAZUe+kTIGIJMglb2Fn7HmiYK4tGh8DxzytG+sZ2L8cCb8SPJE6qQW39WutMMeak
 AakZRxFsElod72PMOD7xXlYTfxWOyaYG0cNijjyH/io8XyTRwN96J66dj5r2RDlGBD05
 2LOwsoRvP8FJA/6bb71v/oFQxDm1QYHIRvDSFXYUQLpamiZXE3dAH9oxnYhA1GVw/PtK mQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb2nsur84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 02:20:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30R2KSeR026093
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 02:20:28 GMT
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 26 Jan 2023 18:20:27 -0800
Date:   Thu, 26 Jan 2023 18:20:26 -0800
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <hpa@zytor.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: Re: [RFC] mm: Allow ZONE_DMA32 to be disabled via kernel command line
Message-ID: <20230127021348.GA3754@hu-cgoldswo-sd.qualcomm.com>
References: <20230126164352.17562-1-quic_c_gdjako@quicinc.com>
 <555fca66-81b6-3406-eac1-140c00669477@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <555fca66-81b6-3406-eac1-140c00669477@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eCBjl6an9UV9bNf5tgQ6RnFlHzgbgZpA
X-Proofpoint-GUID: eCBjl6an9UV9bNf5tgQ6RnFlHzgbgZpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 07:15:26PM +0000, Robin Murphy wrote:
> On 2023-01-26 16:43, Georgi Djakov wrote:
> >From: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> >
> >It's useful to have an option to disable the ZONE_DMA32 during boot as
> >CONFIG_ZONE_DMA32 is by default enabled (on multiplatform kernels for
> >example). There are platforms that do not use this zone and in some high
> >memory pressure scenarios this would help on easing kswapd (to leave file
> >backed memory intact / unreclaimed). When the ZONE_DMA32 is enabled on
> >these platforms - kswapd is woken up more easily and drains the file cache
> >which leads to some performance issues.
> >
> >Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> >[georgi: updated commit text]
> >Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> >---
> >The main question here is whether we can have a kernel command line
> >option to disable CONFIG_ZONE_DMA32 during boot (at least on arm64).
> >I can imagine this being useful also for Linux distros.
> 
> FWIW I'd say that "disabled" and "left empty then awkwardly tiptoed around
> in a few places" are very different notions...
> 
> However, I'm just going to take a step back and read the commit message a
> few more times... Given what it claims, I can't help but ask why wouldn't we
> want a parameter to control kswapd's behaviour and address that issue
> directly, rather than a massive hammer that breaks everyone allocating
> explicitly or implicitly with __GFP_DMA32 (especially on systems where it
> doesn't normally matter because all memory is below 4GB anyway), just to
> achieve one rather niche side-effect?
> 
> Thanks,
> Robin.

Hi Robin,

The commit text doesn't spell out the scenario we want to avoid, so I
will do that for clarity. We use a kernel binary compiled for us, and
by default has CONFIG_ZONE_DMA32 (and it can't be disabled for now as
another party needs it). Our higher-end SoCs are usually used with
8-12 GB of DDR, so using a 12 GB device as an example, we would have 8
GB of ZONE_NORMAL memory and 4 GB of ZONE_MOVABLE memory with the
feature, and 4 GB of ZONE_DMA32, 4 GB of ZONE_NORMAL and 4 GB of
ZONE_MOVABLE otherwise.

Without the feature enabled, consider a GFP_KERNEL allocation that
causes a low watermark beach in ZONE_NORMAL, such that such that
ZONE_DMA32 is almost full. This will cause kswapd to start reclaiming
memory, despite the fact that that we might have gigabytes of free
memory in ZONE_DMA32 that can be used by anyone (since GFP_MOVABLE and
GFP_NORMAL can fall back to using ZONE_DMA32).

So, fleshing out your suggestion to make it concrete for our case, we
would want to stop kswapd from doing reclaim on ZONE_NORMAL watermark
breaches when ZONE_DMA32 is present (since anything targeting
ZONE_NORMAL can fall back to ZONE_DMA32).

Thanks,

Chris.
