Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2E5706A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjEQOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjEQOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:10:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E56F3AB1;
        Wed, 17 May 2023 07:10:44 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE77xd005658;
        Wed, 17 May 2023 14:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+mOpdiBpQGpQLdhgNsQ0IGA4Isptj5DTsQgf8TJxyQ4=;
 b=EWzf0i/8eZKP+E5gMk2k0g1z73+ttoEQEF5Q60kUW8EYSie8dxynCG6DtlYCUnU1bXlQ
 X255vvNTXZ5bfZMSIH7QLbno4/jDx1k9dcnRGN6Jb/YjrZGHdnBQuFNgg4c7YzA79FB0
 g2N83+C3+NgigVbpvEv2apNIVXDEYJaV2lbmg1MKNwOxbj8i44A4OidtotlU0+CM0GkO
 GggGc4Rf03TQTGkwwNKggLtnT6GbaywzCkDWas5X2UV6b2FNMkA+kSWMEOvTZl8LX7fp
 lRPQDVdojeWwpFWTQd+bLzMBEzNlUTxSkwf2tfht7rKFYSPUMiSt6CzTYnGG8wHyJ5ZV mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmwyvdcb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:10:03 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HE7L6g006584;
        Wed, 17 May 2023 14:09:22 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmwyvdark-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:09:21 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34HC6Idp029373;
        Wed, 17 May 2023 14:08:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qj264su7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:08:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34HE8ENO32506294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 14:08:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 899BD20040;
        Wed, 17 May 2023 14:08:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA40B2004B;
        Wed, 17 May 2023 14:08:13 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 17 May 2023 14:08:13 +0000 (GMT)
Date:   Wed, 17 May 2023 16:08:12 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] irq_work: consolidate arch_irq_work_raise prototypes
Message-ID: <ZGTfzJC2y2goqwts@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230516200341.553413-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516200341.553413-1-arnd@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MzrgV6C-kCCqi5562HvjyyGNM7bty2Id
X-Proofpoint-GUID: nyhw9ozPCBQ9cpQ8NEUSFvgoTirscyso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=846 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:02:31PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The prototype was hidden on x86, which causes a warning:
> 
> kernel/irq_work.c:72:13: error: no previous prototype for 'arch_irq_work_raise' [-Werror=missing-prototypes]
> 
> Fix this by providing it in only one place that is always visible.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/irq_work.h     | 2 --
>  arch/arm64/include/asm/irq_work.h   | 2 --
>  arch/csky/include/asm/irq_work.h    | 2 +-
>  arch/powerpc/include/asm/irq_work.h | 1 -
>  arch/riscv/include/asm/irq_work.h   | 2 +-
>  arch/s390/include/asm/irq_work.h    | 2 --
>  arch/x86/include/asm/irq_work.h     | 1 -
>  include/linux/irq_work.h            | 3 +++
>  8 files changed, 5 insertions(+), 10 deletions(-)

...

> diff --git a/arch/s390/include/asm/irq_work.h b/arch/s390/include/asm/irq_work.h
> index 603783766d0a..f00c9f610d5a 100644
> --- a/arch/s390/include/asm/irq_work.h
> +++ b/arch/s390/include/asm/irq_work.h
> @@ -7,6 +7,4 @@ static inline bool arch_irq_work_has_interrupt(void)
>  	return true;
>  }
>  
> -void arch_irq_work_raise(void);
> -
>  #endif /* _ASM_S390_IRQ_WORK_H */

...

> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 8cd11a223260..136f2980cba3 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -66,6 +66,9 @@ void irq_work_sync(struct irq_work *work);
>  void irq_work_run(void);
>  bool irq_work_needs_cpu(void);
>  void irq_work_single(void *arg);
> +
> +void arch_irq_work_raise(void);
> +
>  #else
>  static inline bool irq_work_needs_cpu(void) { return false; }
>  static inline void irq_work_run(void) { }

For s390:

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
