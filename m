Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1186AF3E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjCGTKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjCGTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:10:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1149E31D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:55:06 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327Gg5hT013017;
        Tue, 7 Mar 2023 18:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=StuDxdzwe246OJVWMdOXxOlz8Rjeg+UVwZ4EJarO83Y=;
 b=XUSORQG/a+L/NoP5yM4y8Q8CDCFpNXzl3Dc41PKSWE3Y/skcv7X248kKny7N4bNaugx3
 GR8ofwUuClaw9kjwP6YtD/7pTJICDLpk3ErZFOMDX1msJGosHugzD1hetyjaNDSwKLuf
 O0vKolXziBdtB3Xn3F7aCDz6XLE4EVgWsYHzMmjxzAtI9EtFdKKq59zIExxKFA3jB12a
 tzYxC70WnL+x2hV3rhOXoDJsWj1BNw2XuZEXwC/0X0Exvxvyq9mDC55dRP4aEymH40QZ
 xcIiQlVMMbNp/ABxIW52zScSqazOvyqDMhfbXyS4iKkac1fPtoVITVK0lUsgftZYjngc DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6914b998-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:32 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 327IL42X015451;
        Tue, 7 Mar 2023 18:54:31 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6914b98d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:31 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 327EdQKi005745;
        Tue, 7 Mar 2023 18:54:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p41brcq07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 327IsQJ53867298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 18:54:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B636020043;
        Tue,  7 Mar 2023 18:54:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E94820040;
        Tue,  7 Mar 2023 18:54:26 +0000 (GMT)
Received: from p-imbrenda (unknown [9.179.29.172])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue,  7 Mar 2023 18:54:26 +0000 (GMT)
Date:   Tue, 7 Mar 2023 19:53:13 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     <yang.yang29@zte.com.cn>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v6 6/6] selftest: add testing unsharing and counting ksm
 zero  page
Message-ID: <20230307195313.2e21245a@p-imbrenda>
In-Reply-To: <202302100921574141612@zte.com.cn>
References: <202302100921574141612@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kvpUDED9MjvBZKmEK_05C8Wt5bbNlwXS
X-Proofpoint-GUID: Th0uJZ0gBlU7CEkZA-IIqI7cizQB622e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_12,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 mlxlogscore=538 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303070164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 09:21:57 +0800 (CST)
<yang.yang29@zte.com.cn> wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> Add a function test_unmerge_zero_page() to test the functionality on
> unsharing and counting ksm-placed zero pages and counting of this patch
> series.
> 
> test_unmerge_zero_page() actually contains three subjct test objects:
> 	1) whether the count of ksm zero page can react correctly to cow
> 	   (copy on write);
> 	2) whether the count of ksm zero page can react correctly to unmerge;
> 	3) whether ksm zero pages are really unmerged.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>

[...]

> +static int unmerge_zero_page(char *start, unsigned long size)
> +{
> +	int ret;
> +
> +	ret = madvise(start, size, MADV_UNMERGEABLE);
> +	if (ret) {
> +		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Wait for two full scans such that any possible unmerging of zero
> +	 * pages happened. Why? Because the unmerge action of zero pages is not

please remove "Why? Because"

> +	 * done in the context of madvise(), but in the context of
> +	 * unshare_zero_pages() of the ksmd thread.
> +	 */
> +	return wait_two_full_scans();
> +}
> +
>  static char *mmap_and_merge_range(char val, unsigned long size)
>  {
>  	char *map;

[...]
