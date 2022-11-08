Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A4162096D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKHGSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiKHGSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:18:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22743FBAA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 22:18:05 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A86Bb2q008674;
        Tue, 8 Nov 2022 06:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=zzOS5pPi5maIyqpURKH5fpfqqaMBm8cpkLoYaZVS4Ek=;
 b=D47b91wNsLz+Y24umxIGjqU/7Ts0dc+YSdU3fEwjdZc7Vmahs1wbzakK6AtHTu1Hd16h
 pLdhnqKugF55bqyst3mIrctA3AsPB9FFZAZshPf+kA9pgCTTmsxfXbBQhLVDXU/+w7rX
 1lTnyRj9Jft11o3hzL66hvjbjWFSOex4Zrhfk2PH3Kkek4OYzarDwTa15mLKW5u9UzQr
 cDQP24pHoM7+2M7fsGGS1bnUHPz3I/HQYrXDekL/fJlUUtOfKC1SkDi1Hq7bzDJNXG9z
 Ggz623hYKLimLi6CqXvbcf2WtAd45cKig9VOiCBAuHMFx3Z0dILsATXsKiy4wYbwFJr1 Ew== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhmk80d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 06:18:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A86I01O025091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 06:18:00 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 22:17:58 -0800
Date:   Tue, 8 Nov 2022 11:47:53 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix compiler warning with make W=1
Message-ID: <20221108061753.GA23955@hu-pkondeti-hyd.qualcomm.com>
References: <1667884582-2465-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1667884582-2465-1-git-send-email-quic_charante@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KFnAbdgKXMlmzn-cDPYajl9jD79cbb0j
X-Proofpoint-ORIG-GUID: KFnAbdgKXMlmzn-cDPYajl9jD79cbb0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 mlxlogscore=526
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211080032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charan,

On Tue, Nov 08, 2022 at 10:46:22AM +0530, Charan Teja Kalla wrote:
> Fix the below compiler warnings reported with 'make W=1 mm/'.
> mm/page_ext.c:178: warning: Function parameter or member 'page_ext' not
> described in 'page_ext_put'.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  mm/page_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index affe8024..ddf1968 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -166,7 +166,7 @@ struct page_ext *page_ext_get(struct page *page)
>  
>  /**
>   * page_ext_put() - Working with page extended information is done.
> - * @page_ext - Page extended information received from page_ext_get().
> + * @page_ext: Page extended information received from page_ext_get().
>   *
>   * The page extended information of the page may not be valid after this
>   * function is called.
> 

Looks good to me. Your patch fixes the warning emitted earlier by

./scripts/kernel-doc -none mm/page_ext.c
mm/page_ext.c:178: warning: Function parameter or member 'page_ext' not described in 'page_ext_put'

one nit comment on the changelog summary

mm: fix compiler warning with make W=1

Can you make it more specific like "mm/page_exit: fix kernel doc warning in page_ext_put()"

Thanks,
Pavan
