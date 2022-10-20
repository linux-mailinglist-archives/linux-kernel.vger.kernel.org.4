Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEAC60587B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJTH2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJTH2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:28:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC39A15F31A;
        Thu, 20 Oct 2022 00:27:56 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K786ch019627;
        Thu, 20 Oct 2022 07:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=76b4s0g5OpacSJJ4kiOMB0gSt2osK1uQ3hQIT2NW/Qo=;
 b=j8g5aG+RbzO63TiNeR/RVqUmuH/vqhChPQlKgX5UrlHjz6btxG3hlH4c2mYCH73/GjAl
 k0ILVYVQCs04GybWxEIVQZPs7Unfe34U3YbWRrcvrSaFp9+lkEiWnkIZ7G0JtOLLfiRk
 4KB+8SfQocGmcYG+meF3108NlU+E8uXJRP5YNR4YNPRhSKQupdfVqSz6ccQCV7PU8uqM
 jlCNp58sqSeZ3ZMiclW4yFISAVLjMvRg+Fl+UTWcJ3soIUfZ+geOQ9VrddklEmdIHEfQ
 jQ/4D7sL8W37So67L2d3Woco19GSP8Ui/r4eNE5v/jUO8uWHpu8/ZfJADLxADYy7sM6Z yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kaxvfvujn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 07:27:45 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29K78C39020549;
        Thu, 20 Oct 2022 07:27:44 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kaxvfvuhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 07:27:44 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29K7KKpe027799;
        Thu, 20 Oct 2022 07:27:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3kajmrs5n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 07:27:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29K7RcMm1049278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 07:27:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BDA752051;
        Thu, 20 Oct 2022 07:27:38 +0000 (GMT)
Received: from osiris (unknown [9.152.212.239])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2C9975204E;
        Thu, 20 Oct 2022 07:27:38 +0000 (GMT)
Date:   Thu, 20 Oct 2022 09:27:37 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 rcu 08/11] arch/s390: Add
 ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
Message-ID: <Y1D4aYbjRJjUEelZ@osiris>
References: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
 <20221019225846.2501109-8-paulmck@kernel.org>
 <b74752cc-5833-c1b5-3697-262c523e794b@linux.ibm.com>
 <Y1D3hReCp/9C9gD3@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1D3hReCp/9C9gD3@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UDKphAujlv8J1PZYU3H9b4TpBSZgSete
X-Proofpoint-GUID: -GAMInkg2xOXh_cknrok7edWDN-txW4l
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_02,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=708
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:23:49AM +0200, Heiko Carstens wrote:
> On Thu, Oct 20, 2022 at 07:16:44AM +0200, Christian Borntraeger wrote:
> > Am 20.10.22 um 00:58 schrieb Paul E. McKenney:
> > > The s390 architecture uses either a cmpxchg loop (old systems)
> > > or the laa add-to-memory instruction (new systems) to implement
> > > this_cpu_add(), both of which are NMI safe.  This means that the old
> > > and more-efficient srcu_read_lock() may be used in NMI context, without
> > > the need for srcu_read_lock_nmisafe().  Therefore, add the new Kconfig
> > > option ARCH_HAS_NMI_SAFE_THIS_CPU_OPS to arch/arm64/Kconfig, which will
> > 						s390 ?

Ah, this typo is what Christian pointed out; missed that.

> > > cause NEED_SRCU_NMI_SAFE to be deselected, thus preserving the current
> > > srcu_read_lock() behavior.
> > > 
> > > Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
> > > 
> > > Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > > Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ...
> > > ---
> > >   arch/s390/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> 
> Not sure what Christian was trying to say with his empty reply :)
> In any case:
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
