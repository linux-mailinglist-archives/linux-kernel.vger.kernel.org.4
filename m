Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC437685E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjBAEKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBAEJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:09:57 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EC0EC71
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 20:09:56 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31137Cc7022955;
        Wed, 1 Feb 2023 04:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=zy6Rha6dBVIMAWy3lFXkqLXt6GDCnsCwrZjTyGqNoWQ=;
 b=KtW5+IQhcXsJKukL4v6raDyHWRqT/D4byuAcAvnF9M3B4bUfzggzWBAGdL/tew2g1GgJ
 PZzmc8ghCakcjVR5Zv+PF54uzdrMGOAMXHvnebad5UoV8msJ84vFgGZ7y7t3ZyAH/Iip
 mWha4E1s9JzQ9p4GiKD8rpUHr7MzbrmND3GO9mrqhKNpxEyHYlGv/we4KefEI64xF/Hq
 YFHSaSRCPvjMMWd6VqTz/x11TYL1pRH7Ko7oUumn5I4ZaGzbMMEkcucJdezwbuS51O+d
 LfslIvVdFFYNWmHLQoFmXEibETrdK2B3BXUjaDjf+gUTaNdHr0HKhuyz39Z0C9UorEKi RQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nexb02guu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 04:09:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31149LPp028958
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 04:09:21 GMT
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 20:09:21 -0800
Date:   Tue, 31 Jan 2023 20:09:13 -0800
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <dave.hansen@linux.intel.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <hch@lst.de>, <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>
Subject: Re: [RFC] mm: Allow ZONE_DMA32 to be disabled via kernel command line
Message-ID: <20230201040913.GA4959@hu-cgoldswo-sd.qualcomm.com>
References: <20230126164352.17562-1-quic_c_gdjako@quicinc.com>
 <555fca66-81b6-3406-eac1-140c00669477@arm.com>
 <20230127085553.5120-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230127085553.5120-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1o19gB-wBRlPAda26TeSBX4RL71zd1Vy
X-Proofpoint-ORIG-GUID: 1o19gB-wBRlPAda26TeSBX4RL71zd1Vy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=494
 malwarescore=0 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:55:53PM +0800, Hillf Danton wrote:
> On Thu, 26 Jan 2023 18:20:26 -0800 Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> > On Thu, Jan 26, 2023 at 07:15:26PM +0000, Robin Murphy wrote:
> > > However, I'm just going to take a step back and read the commit message a
> > > few more times... Given what it claims, I can't help but ask why wouldn't we
> > > want a parameter to control kswapd's behaviour and address that issue
> > > directly, rather than a massive hammer that breaks everyone allocating
> > > explicitly or implicitly with __GFP_DMA32 (especially on systems where it
> > > doesn't normally matter because all memory is below 4GB anyway), just to
> > > achieve one rather niche side-effect?
> > > 
> > > Thanks,
> > > Robin.
> > 
> > Hi Robin,
> > 
> > The commit text doesn't spell out the scenario we want to avoid, so I
> > will do that for clarity. We use a kernel binary compiled for us, and
> > by default has CONFIG_ZONE_DMA32 (and it can't be disabled for now as
> > another party needs it). Our higher-end SoCs are usually used with
> > 8-12 GB of DDR, so using a 12 GB device as an example, we would have 8
> > GB of ZONE_NORMAL memory and 4 GB of ZONE_MOVABLE memory with the
> > feature, and 4 GB of ZONE_DMA32, 4 GB of ZONE_NORMAL and 4 GB of
> > ZONE_MOVABLE otherwise.
> > 
> > Without the feature enabled, consider a GFP_KERNEL allocation that
> > causes a low watermark beach in ZONE_NORMAL, such that such that
> > ZONE_DMA32 is almost full. This will cause kswapd to start reclaiming
> > memory, despite the fact that that we might have gigabytes of free
> > memory in ZONE_DMA32 that can be used by anyone (since GFP_MOVABLE and
> > GFP_NORMAL can fall back to using ZONE_DMA32).
> 
> If kswapd is busy reclaiming pages even given gigabytes of free memory
> in the DMA32 zone then it is a CPU hog.
> 
> Feel free to check pgdat_balanced() and prepare_kswapd_sleep().

Thanks for pointing out this gap in my understanding - I'm taking a closer look
at these paths to see whether there is room for what Robin suggested.

