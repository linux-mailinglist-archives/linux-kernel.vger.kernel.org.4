Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ED763E818
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLADBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiLADBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:01:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C8F7CAB9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:01:00 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B12AlTP007130;
        Thu, 1 Dec 2022 03:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=9yITyNjjhkB3JCJbjgiTUFXeLdNgr1gSqrWveNUxCXg=;
 b=CRtBULHtvupkxP7hVY6zhjcp5c5NiG+I/KYPEwMSFWJ4IDJhzlc6hyblrPlJMJB9asaL
 KAz1FIm7cWVjv3DDLudUF/dRFSVfQkCDaCHg2wA3Rxc2xFNR4p7/+GNkotVI/dQ5VhS2
 Ohpaw3kXF/BRpUdyhKXRLdO7ZHdnvRkrTwTgEZE9oBRI4XYtCjKB1bGChLe+asigmDm9
 CFX6oyo1leOwDx1MGPPN223WTcrbkAkJeRRNFNFiF8jPFpqppKi1g/Mgm+LbC3E+LNid
 xMVgRD/0P0DLOWjCnvn6YTaKCBdXDwXN51eJSYg/AJtFHG5ipNFy39J8xZD8VHX0312p Sg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6k7dr2u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 03:00:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B130qgd003780
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 03:00:52 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 19:00:49 -0800
Date:   Thu, 1 Dec 2022 08:30:45 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>,
        Divyanand Rangu <quic_drangu@quicinc.com>
Subject: Re: [PATCH] mm/madvise: fix madvise_pageout for private file mappings
Message-ID: <20221201030045.GB3980@hu-pkondeti-hyd.qualcomm.com>
References: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
 <20221130151739.a7771037aa83ff536ac2edd5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221130151739.a7771037aa83ff536ac2edd5@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l3HtFWrWsrEUc5TdNdiDs23dDpK5zIjV
X-Proofpoint-GUID: l3HtFWrWsrEUc5TdNdiDs23dDpK5zIjV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212010017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:17:39PM -0800, Andrew Morton wrote:
> 
> On Wed, 9 Nov 2022 10:48:36 +0530 Pavankumar Kondeti <quic_pkondeti@quicinc.com> wrote:
> 
> > When MADV_PAGEOUT is called on a private file mapping VMA region,
> > we bail out early if the process is neither owner nor write capable
> > of the file. However, this VMA may have both private/shared clean
> > pages and private dirty pages. The opportunity of paging out the
> > private dirty pages (Anon pages) is missed. Fix this by caching
> > the file access check and use it later along with PageAnon() during
> > page walk.
> > 
> > We observe ~10% improvement in zram usage, thus leaving more available
> > memory on a 4GB RAM system running Android.
> > 
> 
> Could we please have some reviewer input on this?
> 
> Thanks.
> 

Thanks Andrew for the reminder. Fyi, this patch has been included in Android
Generic Kernel Image (5.10 and 5.15 kernels) as we have seen good savings on
Android. It would make a difference on a low memory android devices.

Suren/Minchan,

Can you please do the needful?

Thanks,
Pavan
