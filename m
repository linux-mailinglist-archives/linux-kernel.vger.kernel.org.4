Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30CC6A0C70
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjBWPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjBWPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:03:04 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A755C66D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:03:01 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NDg9Ys015886;
        Thu, 23 Feb 2023 15:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=DskhPYzP4KCP365XoSp8mQTWayAEtypEja6b+A2KPyk=;
 b=KEkJlWEYIFd1FgcSVKvFwrCyQr21Uml40QfxttjY8QeXG9FRl4P6e6FpFFYQua1NWNRc
 OXG0/j8iTDHCZSHy+GHNbqQCsXadZ9/gy0le/Tyuox2G37hag/+cuimGkofjpYtzmU2p
 fFr0Ot9MbncXDf9VS7JwZdg8hYPrfwecpO9YRYPZ5bkCtQt1WeMcsyXzvmXr9Ate7Tq5
 S+vgwTmHiY93nj1YE3LI+BkG3ib44zISJCyLm+I/2Q/DHJS8QAXnlv3i3XmgyP2twRVN
 nmS1rU+Rp0aTjKfZiHdK9afti68bqjisNlNs0n7ddtwfc3JZ4H9+CBycqmCtTYkFmmOo UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nx2pyn713-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 15:02:27 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31NETuAf028046;
        Thu, 23 Feb 2023 15:02:27 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nx2pyn705-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 15:02:26 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31NDUGIM015814;
        Thu, 23 Feb 2023 15:02:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa76qnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 15:02:25 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31NF2O8565864036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 15:02:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51C5A58057;
        Thu, 23 Feb 2023 15:02:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B8C58063;
        Thu, 23 Feb 2023 15:02:24 +0000 (GMT)
Received: from localhost (unknown [9.211.113.64])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Feb 2023 15:02:23 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] powerpc/pseries: RTAS work area requires
 GENERIC_ALLOCATOR
In-Reply-To: <20230223070116.660-4-rdunlap@infradead.org>
References: <20230223070116.660-1-rdunlap@infradead.org>
 <20230223070116.660-4-rdunlap@infradead.org>
Date:   Thu, 23 Feb 2023 09:02:23 -0600
Message-ID: <871qmga0hs.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FJQvzrWQfun7DY_va5BNDnrSnw9Ypwi_
X-Proofpoint-GUID: UyEQwhyAVhj9AvEG0l3Esu1FsIrLjFP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_08,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> The RTAS work area allocator uses code that is built by
> GENERIC_ALLOCATOR, so the PSERIES Kconfig should select the
> required Kconfig symbol to fix multiple build errors.
>
> powerpc64-linux-ld: arch/powerpc/platforms/pseries/rtas-work-area.o: in function `.rtas_work_area_allocator_init':
> rtas-work-area.c:(.init.text+0x288): undefined reference to `.gen_pool_create'
> powerpc64-linux-ld: rtas-work-area.c:(.init.text+0x2dc): undefined reference to `.gen_pool_set_algo'
> powerpc64-linux-ld: rtas-work-area.c:(.init.text+0x310): undefined reference to `.gen_pool_add_owner'
> powerpc64-linux-ld: rtas-work-area.c:(.init.text+0x43c): undefined reference to `.gen_pool_destroy'
> powerpc64-linux-ld: arch/powerpc/platforms/pseries/rtas-work-area.o:(.toc+0x0): undefined reference to `gen_pool_first_fit_order_align'
> powerpc64-linux-ld: arch/powerpc/platforms/pseries/rtas-work-area.o: in function `.__rtas_work_area_alloc':
> rtas-work-area.c:(.ref.text+0x14c): undefined reference to `.gen_pool_alloc_algo_owner'
> powerpc64-linux-ld: rtas-work-area.c:(.ref.text+0x238): undefined reference to `.gen_pool_alloc_algo_owner'
> powerpc64-linux-ld: arch/powerpc/platforms/pseries/rtas-work-area.o: in function `.rtas_work_area_free':
> rtas-work-area.c:(.ref.text+0x44c): undefined reference to `.gen_pool_free_owner'
>
> Fixes: 43033bc62d34 ("powerpc/pseries: add RTAS work area allocator")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

oops. Thanks for fixing this.

Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
