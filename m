Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8CD5F9BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiJJJYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJJJYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:24:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D035D0C8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:24:30 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A9GNX1029490;
        Mon, 10 Oct 2022 09:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Hl2tgLNm5lg6VuSf7qo6KRUTP5SpNvEJuGFzq+31vvU=;
 b=Hx8KInzwt224qXVYuHos+x95vB6xdJuwSsMa/ssp7pw+mY2kzhAikNpcnz9t8zhzR5Zl
 7K7OyeV6rpfcxO80vE7PuG8NQtttRuoVRPJE4Tv6Riyj6hd77yYN8h9Wysi4natN0Sna
 mB5BrdbX4RH4qDfpKgDdgtgN8kUm9cti6RPy1RZR+PtbcLOq6yG3En5UXGrIw50NhCJU
 mD8uATxGbFY6/oJyRyufMTPnCo1HXrqpUeLpvvX/7V0drfq534tDZJvaz63Yzd6kJenv
 L03eCOOVQTec+TQ+R563x3elAKV8P/ctWetSi0z37WiT/41fTUA166tjTCN2kiy6cz/D zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3k7v6dq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:24:27 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29A8mJ3R020230;
        Mon, 10 Oct 2022 09:24:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3k7v6djf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:24:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29A9KR99029021;
        Mon, 10 Oct 2022 09:24:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3k30u9aj7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:24:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29A9OFq960752272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 09:24:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64A464C046;
        Mon, 10 Oct 2022 09:24:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FEDE4C040;
        Mon, 10 Oct 2022 09:24:15 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.242])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Oct 2022 09:24:15 +0000 (GMT)
Date:   Mon, 10 Oct 2022 11:24:13 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     xu.xin.sc@gmail.com
Cc:     akpm@linux-foundation.org, ran.xiaokai@zte.com.cn,
        yang.yang29@zte.com.cn, jiang.xuexin@zte.com.cn, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v2 0/5] ksm: support tracking KSM-placed zero-pages
Message-ID: <20221010112413.219dc989@p-imbrenda>
In-Reply-To: <20221009021816.315205-1-xu.xin16@zte.com.cn>
References: <20221009021816.315205-1-xu.xin16@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hqGr5RA2tO08WTSR8-F74aiZE3fP-9Ht
X-Proofpoint-GUID: XYvKMfVOoHr7rSfJkFfp6_i-at8BfPfm
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=628
 mlxscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  9 Oct 2022 02:18:16 +0000
xu.xin.sc@gmail.com wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
> when enabling use_zero_pages, all empty pages that are merged with
> kernel zero page are not counted in pages_sharing or pages_shared.
> That is because these empty pages are merged with zero-pages then no
> longer managed by KSM, which leads to two issues at least:
> 
> 1) MADV_UNMERGEABLE and other ways to trigger unsharing will *not*
>    unshare the shared zeropage as placed by KSM (which is against the 
>    MADV_UNMERGEABLE documentation at least); see the link:
>    https://lore.kernel.org/lkml/4a3daba6-18f9-d252-697c-197f65578c44@redhat.com/
> 
> 2) we cannot know how many pages are zero pages placed by KSM when
>    enabling use_zero_pages, which leads to KSM not being transparent
>    with all actual merged pages by KSM.
> 
> With the patch series, we can unshare zero-pages(KSM-placed) accurately
> and count ksm zero pages.

why are you trying so hard to fix something that is not broken?

can't you just avoid using use_zero_pages?

why is it so important to know how many zero pages have been merged?
and why do you want to unmerge them?

the important thing is that the sysadmin knows how much memory would be
needed to do the unmerge, and that information is already there.

> 
> ---
> v1->v2:
> 
> [patch 4/5] fix build warning, mm/ksm.c:550, misleading indentation; statement 
> 'rmap_item->mm->ksm_zero_pages_sharing--;' is not part of the previous 'if'.
> 
> 
> 
> *** BLURB HERE ***
> 
> xu xin (5):
>   ksm: abstract the function try_to_get_old_rmap_item
>   ksm: support unsharing zero pages placed by KSM
>   ksm: count all zero pages placed by KSM
>   ksm: count zero pages for each process
>   ksm: add zero_pages_sharing documentation
> 
>  Documentation/admin-guide/mm/ksm.rst |  10 +-
>  fs/proc/base.c                       |   1 +
>  include/linux/mm_types.h             |   7 +-
>  mm/ksm.c                             | 177 +++++++++++++++++++++------
>  4 files changed, 157 insertions(+), 38 deletions(-)
> 

