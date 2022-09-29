Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CE85EF3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiI2Km7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiI2Kmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:42:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D63147A12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:42:50 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T904hF028572;
        Thu, 29 Sep 2022 10:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=3OEtUohKov+5N35Ww2H23sWgdBX4b8OAubti8YZUKtY=;
 b=YuWlIy73LdpdCvXyA1B2gJpjynm3OQI1XAJWCQ45MTr2984uf5ZHF4AzU9RMbiAnSCIE
 hgDyD0ffy8IEJ93CF4n+0cIAIVnDDelgEQ2tk+RcDU8ZJZsXG8TMDEmuC+XR8GjWxh1/
 B0KV0pqI7zPNnzQ06zzxtlx8mqHH7ye0JvNcsP3zORWzo0JDjPG8JTLc3lVwJKKRXH+s
 wALiXwnmhPMp3GWGvMLqQxcbHhGq+XXbvPlpNSLgxCIKqJtL0inQW8d+sb72N7HXVfkQ
 sNslyEvomhUHZPwlEkFaA5M88Pml8xKo/WTOs7lWPj54HzsBde2+a6+h/hQJBM5ptonN iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw8bmtwuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:42:48 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28TA77kf035972;
        Thu, 29 Sep 2022 10:42:48 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw8bmtwu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:42:48 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28TAZfMr025329;
        Thu, 29 Sep 2022 10:42:46 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3jssh8vw4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:42:46 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28TAcQbB50004314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 10:38:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C80852050;
        Thu, 29 Sep 2022 10:42:44 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.242])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0A14E5204E;
        Thu, 29 Sep 2022 10:42:44 +0000 (GMT)
Date:   Thu, 29 Sep 2022 12:42:42 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     xu.xin.sc@gmail.com
Cc:     akpm@linux-foundation.org, david@redhat.com,
        imbrenda@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
Message-ID: <20220929124242.60ef57ee@p-imbrenda>
In-Reply-To: <20220929025206.280970-1-xu.xin16@zte.com.cn>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RyDh9rc124c3v-DbLRaw4maZtGvjDtez
X-Proofpoint-GUID: pZ_VTkvTqeOfgtB6K-hbdZwLkMppifpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=633 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 02:52:06 +0000
xu.xin.sc@gmail.com wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
> after enabling use_zero_pages, all empty pages that are merged with
> kernel zero page are not counted in pages_sharing or pages_shared.

that's because those pages are not shared between different processes.

> That is because the rmap_items of these ksm zero pages are not
> appended to The Stable Tree of KSM.
> 
> We need to add the count of empty pages to let users know how many empty
> pages are merged with kernel zero page(s).

why?

do you need to know how many untouched zero pages a process has?

does it make a difference if the zero page is really untouched or if it
was touched in the past but it is now zero?

> 
> Please see the subsequent patches for details.
> 
> 
> 
> 
> *** BLURB HERE ***
> 
> xu xin (3):
>   ksm: abstract the function try_to_get_old_rmap_item
>   ksm: add the accounting of zero pages merged by use_zero_pages
>   ksm: add zero_pages_merged in Documentation
> 
>  Documentation/admin-guide/mm/ksm.rst |  10 ++-
>  mm/ksm.c                             | 122 +++++++++++++++++++++------
>  2 files changed, 106 insertions(+), 26 deletions(-)
> 

