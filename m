Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650C85F9F94
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJJNnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJJNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:43:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143B72ED1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:42:59 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ACLwCk025189;
        Mon, 10 Oct 2022 13:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=MpV3+fZa1b3ZgpHkZvz4mAxRXNRh68Ci9DFQYQ7FNGw=;
 b=GwW7jRWH1AsS1CdOxzewbls2Nxy82dtaJEhC8hENTlW7URRdNoLfsbuVx0wtm+2TEiv+
 QwCauHTxx2SSSDbhLIJDdUu024L1OxdXuLMxFDn7rkcLqKzd1xDqRpqTOYha8W5mXO8c
 6pEiLXx5Te7eEjCkPjr9zv4psoarT65uXJZ3A5EDfKtlmckPMcTqCdRB7S6LTn3XDWl2
 tsLt88UvQeeqF58T0MTI90fRHpeHM46bvfKGujb5DYd1oilLZr+7Z4mgW8w0DbISYHV/
 TL/Rgiyy499ixWU0geFlntEcEE5w57b+wlXQVuJaT6r1hitUxsLMadCT9hEEJ32GhqC5 dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3k8snwau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 13:42:55 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29ADIPXk028179;
        Mon, 10 Oct 2022 13:42:55 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3k8snw9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 13:42:54 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29ADcON2021603;
        Mon, 10 Oct 2022 13:42:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3k30u9a42u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 13:42:52 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29ADhLsn53281206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 13:43:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93F50A4054;
        Mon, 10 Oct 2022 13:42:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44149A4060;
        Mon, 10 Oct 2022 13:42:50 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.242])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Oct 2022 13:42:50 +0000 (GMT)
Date:   Mon, 10 Oct 2022 15:42:48 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     xu xin <xu.xin.sc@gmail.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin16@zte.com.cn,
        yang.yang29@zte.com.cn
Subject: Re: [PATCH v2 0/5] ksm: support tracking KSM-placed zero-pages
Message-ID: <20221010154248.1ee86294@p-imbrenda>
In-Reply-To: <20221010120834.318840-1-xu.xin16@zte.com.cn>
References: <20221010112413.219dc989@p-imbrenda>
        <20221010120834.318840-1-xu.xin16@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fvRHA324ng9aHwHN3Nr-NrkmzC7sMAn7
X-Proofpoint-GUID: ZhsBsQbPyOeIL9gs8xS2cD-bUmD7byYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_08,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 12:08:34 +0000
xu xin <xu.xin.sc@gmail.com> wrote:

> Hello, Thanks for your reply.
> 
> >
> >why are you trying so hard to fix something that is not broken?  
> 
> Actually, it breaks the definition of unmerge, though it's usually not a big
> problem.
> >
> >can't you just avoid using use_zero_pages?  
> 
> use_zero_pages is good, not just because of cache colouring as described in doc,
> but also because use_zero_pages can accelerate merging empty pages when there
> are plenty of empty pages (full of zeros) as the time of page-by-page comparision
> (unstable_tree_search_insert) is saved.

interesting, this is some useful information that you could have written
in the cover letter and/or commit messages, to explain why you are
proposing these changes :)

> 
> >
> >why is it so important to know how many zero pages have been merged?
> >and why do you want to unmerge them?  
> 
> Zero pages may be the most common merged pages in actual environment(not only VM but

also interesting information, which you could also have written in the
cover letter and/or commit messages

> also including other application like containers). Sometimes customers (app developers)
> are very interested in how many non-zero-pages are actually merged in their apps.
> 
> >
> >the important thing is that the sysadmin knows how much memory would be
> >needed to do the unmerge, and that information is already there.
> >  
> 
> I think it's about chicken-and-egg problem.
> 
> 
> Anyway, thanks for your reply.
> 

