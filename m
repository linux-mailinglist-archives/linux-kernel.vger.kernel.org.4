Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40D6983C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBOSqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjBOSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:46:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C63E60E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:45:35 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FIZl9O003844;
        Wed, 15 Feb 2023 18:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=tWAJ0djBBRmJ+2qctagcKFZKqKdOj3NuXjt0yoiDyGI=;
 b=MW1pyN6sPcRvsNiTk5RF2qwLVDNmeieXn4fyKF/uDS/2/BEFYIoHywjBxjzsnICLJheC
 M4RcaIw5kPmQcw5pFL5qxCko4tGl8MllWCZL9aafDTMIY9S0L1R56jFKSGc4DDyuXgxm
 LpHtfeuQxYuVIq213uzEi5T7H/gS/1pASZqtpmVYxZVDrcHA0x3Acq14fIkoODF5QePW
 B0BdewSMEmUksmHcEaCb6/QM5r4k03fLJS0TsDsxorrXXVskxHDY/3m4SnVO6tk/3K25
 yIAYoJHQT2VBxWIOomCjMLjFO2JyS9FJz07R999UTzFSX/ERICE59f5klcnfae0+kQyN Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns462spey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 18:44:40 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FIaiH2016444;
        Wed, 15 Feb 2023 18:44:40 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns462spen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 18:44:40 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FI9OKI001021;
        Wed, 15 Feb 2023 18:44:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3np2n7m5hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 18:44:39 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FIicQ51180296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 18:44:38 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E41D458053;
        Wed, 15 Feb 2023 18:44:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD2FD5805D;
        Wed, 15 Feb 2023 18:44:37 +0000 (GMT)
Received: from localhost (unknown [9.163.66.216])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 18:44:37 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 1/9] powerpc/machdep: Define 'compatible' property in
 ppc_md and use it
In-Reply-To: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
References: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
Date:   Wed, 15 Feb 2023 12:44:37 -0600
Message-ID: <874jrmahuy.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2KoSZSgCyvUbn6l4BOymzvLsZF61rnI-
X-Proofpoint-GUID: iBzKRmEq8YnIgT_TK-Pij4sYl0v7jQcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_09,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150165
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Most probe functions do nothing else than checking whether
> the machine is compatible to a given string.
>
> Define that string in ppc_md structure and check it directly from
> probe_machine() instead of using ppc_md.probe() for that.
>
> Keep checking in ppc_md.probe() only for more complex probing.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v3: New
> ---
>  arch/powerpc/include/asm/machdep.h |  1 +
>  arch/powerpc/kernel/setup-common.c | 13 +++++++------
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index 378b8d5836a7..c5dfe5ff923c 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -20,6 +20,7 @@ struct pci_host_bridge;
>  
>  struct machdep_calls {
>  	char		*name;
> +	char		*compatible;

Seems like 'compatible' ought to be const char *? Possibly 'name' also.
I'm able to build ppc64le with those changes, at least.
