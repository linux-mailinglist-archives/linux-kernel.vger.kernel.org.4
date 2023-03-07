Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0816AF3E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjCGTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjCGTKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:10:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA8C8597
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:55:20 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327HFKPk002280;
        Tue, 7 Mar 2023 18:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=FkW88o2DovWlh2UEIlYTAwTKA7K+MRCGlcyCOilz1p0=;
 b=RA+BsyYZd5ir73cngNuaK/qLlUp7clOw4/849+JG8J7Wmino+awYdqmKKIXgCesVROPn
 3iThPH2ivH3kKXAd/MqgJ/oBmLsezRgRbeucsHoY8LlieDZFUOwEQg21JHUqyufPOC6w
 0LLHQhHhS4yXgyskvVs1lCIMzakkSpOElFqPmJbNjLdAoKqiYzugX3jJuRGJ6H5dkypi
 Lra0zCfbzrpKAJGth8xNXfnUj7pAMMQMAac9GDWva72rnd29HSAAbmUmLXmtLh/WTsYR
 vihq95Uk64ZMlzeJySj9AWDRTiwhhh0Es+p5XjUluocuFFaSH+7PVe6YDxp1F/yxUIMo MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p67wfnj59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:25 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 327Ifvfs018468;
        Tue, 7 Mar 2023 18:54:25 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p67wfnj43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 327Eo5l9005880;
        Tue, 7 Mar 2023 18:54:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p418cvpd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 327IsKss54002076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 18:54:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE5EF2004E;
        Tue,  7 Mar 2023 18:54:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6097720040;
        Tue,  7 Mar 2023 18:54:19 +0000 (GMT)
Received: from p-imbrenda (unknown [9.179.29.172])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue,  7 Mar 2023 18:54:19 +0000 (GMT)
Date:   Tue, 7 Mar 2023 19:51:19 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     <yang.yang29@zte.com.cn>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v6 5/6] ksm: add zero_pages_sharing documentation
Message-ID: <20230307195119.745d0b46@p-imbrenda>
In-Reply-To: <202302100920429071565@zte.com.cn>
References: <202302100920429071565@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I7_o-mVw1jZiJGmap1zDh5aDhQdCXHWj
X-Proofpoint-ORIG-GUID: SvKl6EkmaQht5Re9opWMW3J3QiOqk5Ay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_12,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=882 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 09:20:42 +0800 (CST)
<yang.yang29@zte.com.cn> wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> When enabling use_zero_pages, pages_sharing cannot represent how
> much memory saved indeed. zero_pages_sharing + pages_sharing does.
> add the description of zero_pages_sharing.
> 
> Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  Documentation/admin-guide/mm/ksm.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index fb6ba2002a4b..f160f9487a90 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -173,6 +173,13 @@ stable_node_chains
>          the number of KSM pages that hit the ``max_page_sharing`` limit
>  stable_node_dups
>          number of duplicated KSM pages
> +zero_pages_sharing
> +        how many empty pages are sharing kernel zero page(s) instead of

how many empty pages are sharing the kernel zero page(s) instead of
other user pages as it would happen normally. Only meaningful when
``use_zero_pages`` is enabled.

> +        with each other as it would happen normally. Only effective when
> +        enabling ``use_zero_pages`` knob.
> +
> +When enabling ``use_zero_pages``, the sum of ``pages_sharing`` +

When ``use_zero_pages`` is enabled, the sum of ``pages_sharing`` +

> +``zero_pages_sharing`` represents how much really saved by KSM.

``zero_pages_sharing`` represents the actual number of pages saved
by KSM.

> 
>  A high ratio of ``pages_sharing`` to ``pages_shared`` indicates good
>  sharing, but a high ratio of ``pages_unshared`` to ``pages_sharing``

