Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC063F1CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiLANhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiLANhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:37:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A51BA4300
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:36:56 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1CHwf2002873;
        Thu, 1 Dec 2022 13:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=IebuVfQptVmMCbqGFzsn28dDo62oICYBESe0AwhGRwk=;
 b=naJPar690wdJ5NSgqyFWyoUYX6HviVRArEMkx/ietKOJM0Nlo2f0QLnZxamJ/HmkexTj
 VZeZZOxICRE3A7BmJFRE1tmXZJQPnRhCQsSJecVMunAEIFnwl9tkxYp11P8/yrjze6r2
 XqAWIztj5AvGWfMlQgj+KjuOlxeUXZVgINkYaXFOy/8TS7h0KuPBkB3f3YFlqxSFCHwc
 us64V2z2iDPuvN4TFX6bN3T+2vt08CE40QxMgq8OLJcr6l7zGL4TSkTFP9gGuAZNasUn
 TdepsRJD2QpK3Iud96UqSQwDLxkucJ/XvQjace7gjhZlUmlOOoyJr5cm1hF9Up6vWpnW YQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6k2ksmnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 13:36:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B1DaiqK030704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 13:36:44 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 1 Dec 2022 05:36:41 -0800
Date:   Thu, 1 Dec 2022 19:06:37 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>,
        Divyanand Rangu <quic_drangu@quicinc.com>
Subject: Re: [PATCH] mm/madvise: fix madvise_pageout for private file mappings
Message-ID: <20221201133637.GC3980@hu-pkondeti-hyd.qualcomm.com>
References: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
 <906b0150-ef7c-d2b9-783f-4e94c48fa367@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <906b0150-ef7c-d2b9-783f-4e94c48fa367@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XJqGYbufGBpF-loKW5gpIbqp1tjogzP1
X-Proofpoint-GUID: XJqGYbufGBpF-loKW5gpIbqp1tjogzP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 impostorscore=0 mlxlogscore=542 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for your review.

On Thu, Dec 01, 2022 at 02:01:22PM +0100, David Hildenbrand wrote:
> >+	 * If the VMA belongs to a private file mapping, there can be private
> >+	 * dirty pages which can be paged out if even this process is neither
> >+	 * owner nor write capable of the file. Cache the file access check
> >+	 * here and use it later during page walk.
> >+	 */
> >+	can_pageout_file = can_do_file_pageout(vma);
> 
> Why not move that into madvise_pageout_page_range() ? Avoids passing this
> variable to that function.
> 
Silly me. I should have done that in the first place.

> In fact, why not even call that function directly instead of storing that in
> madvise_walk_private(). The function is extremely lightweight.

Agreed. I will incorporate your suggestion and send the patch after testing.

> 
> >  	lru_add_drain();
> >  	tlb_gather_mmu(&tlb, mm);
> >-	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> >+	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr, can_pageout_file);
> >  	tlb_finish_mmu(&tlb);
> >  	return 0;
> 
Thanks,
Pavan
