Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7926E1E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDNIlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDNIlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:41:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2762630EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:41:06 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E7YIKh028051;
        Fri, 14 Apr 2023 08:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MUbRgHcxUzzphkp1NjHgTEGr6XT09JXkAJtK7tGJNdI=;
 b=Q/VNrGnXPDbh6V3hNl6RWNSq9zPpJS+2WpgrYZ9LXg7MrO9085u0uFLzJTeSnzCLRbGF
 2gviH9HbJ5RtITzunvm7LxDLBW44ZUmFydVuzTMXjagBmQcqJh6tiV/Yb+L+3w/MjC4q
 XSRzigjUjDjZwx+ARtfFQCPFfpPzDLDLZFlJ0HKexZ7zW9T9Kgs+kivHGIfADeDODXJo
 jFO6BRgr/L93KwmTipsPEaV71joI2MTia7xobPyPxBcWiLbfGBHDWTg9Iajj8GEXjVas
 kRI6n86qKSbqkamB/THJaqVEQULSpIE8k+0/wvt6ICHTc2qi7XzoHnMVIJek26wSj5SX iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxuxbnyux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:41:01 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33E7YUNR029724;
        Fri, 14 Apr 2023 08:41:00 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pxuxbnyu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:41:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33E3rAq7005093;
        Fri, 14 Apr 2023 08:40:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m23hxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:40:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33E8eu4254854134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 08:40:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30DBA2004E;
        Fri, 14 Apr 2023 08:40:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 919D520040;
        Fri, 14 Apr 2023 08:40:55 +0000 (GMT)
Received: from p-imbrenda (unknown [9.179.9.46])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
        Fri, 14 Apr 2023 08:40:55 +0000 (GMT)
Date:   Fri, 14 Apr 2023 10:40:53 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     xu xin <xu.xin.sc@gmail.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin16@zte.com.cn,
        yang.yang29@zte.com.cn
Subject: Re: [PATCH v6 0/6] ksm: support tracking KSM-placed zero-pages
Message-ID: <20230414104053.7c57a4f6@p-imbrenda>
In-Reply-To: <20230414013507.184195-1-xu.xin16@zte.com.cn>
References: <20230328153852.26c2577e4bd921c371c47a7e@linux-foundation.org>
        <20230414013507.184195-1-xu.xin16@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aKBRVJvJJY-938Cq5MwOmeWDl6cKxBbw
X-Proofpoint-GUID: SzXKc7Lk_vaA3XiZbry-6fqTN542GmaZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=624 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 09:35:07 +0800
xu xin <xu.xin.sc@gmail.com> wrote:

> >> The core idea of this patch set is to enable users to perceive the number of any
> >> pages merged by KSM, regardless of whether use_zero_page switch has been turned
> >> on, so that users can know how much free memory increase is really due to their>
> >> madvise(MERGEABLE) actions. But the problem is, when enabling use_zero_pages,
> >> all empty pages will be merged with kernel zero pages instead of with each
> >> other as use_zero_pages is disabled, and then these zero-pages are no longer
> >> monitored by KSM.  
> >  
> 
> We have sent the v7 series, so some old codes might be changed, and no need to talk
> more.
> 
> >We appear to have some outstanding activity on this quite old patchset.
> >From my notes:
> >
> >- An unresponded-to question from Claudia:
> >	https://lkml.kernel.org/r/20230307192421.30ab869c@p-imbrenda
> >  
> 
> Claudia is right, but the v7 patches don't rely on rmap_items now, so we can skip
> this comment.
> 
> >- Hoping for overall review from David
> >  
> 
> David's review is great, and we accept his advice on the basic approach in v7 patches
> to track the ksm zero pages. and now the v7 patches use pte_dirty to mark the
> KSM-placed zere pages. But since pte_dirty is related to architectures, and some
> architecture may treat pte_dirty as writable, so we restrict the feature of tracking
> ksm zero pages only to the tested and well-working architecture.
> 
> >- Another query from Claudia, and a response indicating that a v7 is
> >  in the works.
> >	https://lore.kernel.org/all/20230307194320.79373a26@p-imbrenda/T/#u  
> 
> The v7 series don't changed it there now, then we can skip it.
> 
> >
> >- Another unresponded-to review query:
> >	https://lkml.kernel.org/r/20230307195119.745d0b46@p-imbrenda
> >  
> 
> The v7 series have referred to Claudia's review but made a few modifications.

I would just like to point out that my name is Claudio, not
Claudia. (this goes to Andrew as well)


thanks

> 
> >- Another response indicating that a v7 is coming
> >	https://lkml.kernel.org/r/20230307195313.2e21245a@p-imbrenda
> >
> > So I think I'll drop the v6 series.  Please address all these things in
> > the next version and let's start over.  
> 
> Yes, the next version is here:
> https://lore.kernel.org/lkml/202304131346489021903@zte.com.cn/
> 
> 

