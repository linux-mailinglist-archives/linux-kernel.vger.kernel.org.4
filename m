Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934686911F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBIULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBIULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:11:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1919D4495;
        Thu,  9 Feb 2023 12:11:00 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319JoYRe022355;
        Thu, 9 Feb 2023 20:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=lzg55gqBt66bmMIEwf2RJtwXPLteq8IkRySUSPdydgU=;
 b=j3Wd2bnQap2pKVTs3IQHLCxiCnkShspUwJ1rXpwwCq6Lq29SQ+GhGVxjAa4bHF+918gd
 7t//RQ+jO6lVQXL69Ed0MaeDR2Cr+NQquV+EXLTSvlIvQpa/S+fm8UJFwdsF8iMFPOhM
 FI+3dwkSEn32s7Y1sXYpcfbeP1T20slyZxVgAY+YSHe0dGEcTx1i5n2KmprhwtAYE0HT
 cTPcE37m0FlTmhXPeaddrpmSzP/i84cu7jZWmq5w9LCobGtuw88WTmNhkzapmqE/4yum
 VEs+kEsxdwgz+5pDScJff6rpMO8LY0z/KWs4zE4ba3gbF41UaJ7CEsnNmXhdjcy182fH 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn7bh0qnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 20:10:52 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 319JpCO7024504;
        Thu, 9 Feb 2023 20:10:51 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn7bh0qky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 20:10:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319CXVmk023824;
        Thu, 9 Feb 2023 20:10:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06xmyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 20:10:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319KAkE347710618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 20:10:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0EBA20049;
        Thu,  9 Feb 2023 20:10:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78FD520043;
        Thu,  9 Feb 2023 20:10:46 +0000 (GMT)
Received: from osiris (unknown [9.179.10.102])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Feb 2023 20:10:46 +0000 (GMT)
Date:   Thu, 9 Feb 2023 21:10:45 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/s390: Define private VM_FAULT_* reasons from top
 bits
Message-ID: <Y+VTRZkd7Lp032gq@osiris>
References: <20230205231704.909536-1-peterx@redhat.com>
 <20230205231704.909536-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205231704.909536-4-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qedQ-ytSGCJByGHcqG7hLNZUcq09Ise_
X-Proofpoint-ORIG-GUID: GUVVKyqRs8oLr6iuWnLPGibYzHbGhXWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=969
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090186
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 06:17:04PM -0500, Peter Xu wrote:
> The current definition already collapse with the generic definition of
> vm_fault_reason.  Move the private definitions to allocate bits from the
> top of uint so they won't collapse anymore.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/s390/mm/fault.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Thanks a lot!

Applied.
