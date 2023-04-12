Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D49D6DFB95
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjDLQnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjDLQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:43:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616BA2136
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:10 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CGPdYh030348;
        Wed, 12 Apr 2023 16:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+f9ZDsRzwlCRpYEhdGS4XIqTMO4m7WimgJcGQeZITHc=;
 b=SE1Ghhyo7Ay9ZO+Y/AhU08vz+m9+V87mCLWiVu/EK02PHy49561agtnPAS+ezskw5d4g
 DBix6+rexL80gtxXpZgW944cp5m7bg7p4KGfuzEqKP66zPk6+N2MzpbaEjN6jyrfC2Mo
 PLhZ2njRIBKjAWFdelUxq38nS6QgX/gyl0cj98TAdRP0Uyh6n/APhttBB25obmYcs/ur
 DvmovZ4ig+Fl9hdqqUzb4aFRrTJl0gUa1qyNYz5RLknvryY8SRwCVd5RZqNgNSNV7gzP
 Ni07fysiEHDhihH/lLqGKia7Bs75aUl0oSNdjUJB8YJ14v3WNF/TXKCMd5hiBl8MgbIA aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwyks28c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:43:04 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33CGQVFr033708;
        Wed, 12 Apr 2023 16:43:04 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwyks28ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:43:03 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C89BFO022263;
        Wed, 12 Apr 2023 16:43:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3pu0h5t3w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:43:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33CGgwYJ42598992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 16:42:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3AAA20049;
        Wed, 12 Apr 2023 16:42:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 569B120040;
        Wed, 12 Apr 2023 16:42:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.179.16.229])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Apr 2023 16:42:57 +0000 (GMT)
Date:   Wed, 12 Apr 2023 19:42:55 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/29] selftests/mm: uffd_[un]register()
Message-ID: <ZDbfjxFkxKVATjVQ@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160747.3107258-1-peterx@redhat.com>
 <ZC/5xstCOs8wp6nK@linux.ibm.com>
 <ZDWxTsJUTS1OSjJw@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDWxTsJUTS1OSjJw@x1n>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KkLfTep0WgEyJ-wWLOWPikuKuORP1tJv
X-Proofpoint-ORIG-GUID: Q73J75TqF1P0I208rr5svmYQt5e2j3lQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxlogscore=707
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:13:18PM -0400, Peter Xu wrote:
> On Fri, Apr 07, 2023 at 02:08:54PM +0300, Mike Rapoport wrote:
> > > @@ -96,11 +95,7 @@ static void register_region_with_uffd(char *addr, size_t len)
> > >  	 * handling by the userfaultfd object. In mode, we request to track
> > >  	 * missing pages (i.e., pages that have not yet been faulted in).
> > >  	 */
> > > -
> > > -	uffdio_register.range.start = (unsigned long)addr;
> > > -	uffdio_register.range.len = len;
> > > -	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> > > -	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
> > > +	if (uffd_register(uffd, addr, len, true, false, false)) {
> > 
> > I'd replace booleans with a bit flags as it easier to read.
> > Other than that LGTM.
> 
> It was mostly for no need to remember the long names of macros, and easier
> when conditionally set with some modes. E.g., we have 5 callers have things
> like:
> 
>   uffd_register(..., test_uffdio_wp ? UFFDIO_REGISTER_MODE_WP : 0);
> 
> The bools simplifes it to:
> 
>   uffd_register(..., test_uffdio_wp, ...);
> 
> But let me know if you still think that's better - I can switch here.

No strong feelings, however you prefer.
 
> Thanks,
> 
> -- 
> Peter Xu
> 

-- 
Sincerely yours,
Mike.
