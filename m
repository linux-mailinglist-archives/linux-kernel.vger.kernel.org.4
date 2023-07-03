Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5027454D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGCFbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCFbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:31:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA313180;
        Sun,  2 Jul 2023 22:31:48 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3635Hm28023285;
        Mon, 3 Jul 2023 05:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=xsCU60YmzX3PTFCsu3PcmHa94j57YZLwRjKbNWeEISk=;
 b=kSfXrDyl0RfoolDBLvAYEpenph9s/bhur5OBWk0wYv3Pq/1UZkfTI5gyDABjjcQbouf5
 9m4CNE26+ZD+SMmyQildh9S82IfFJV7XTdoWpp0jWGl/JBOqH06WvHRH+/JqrG+yIE0J
 Cj42mO7t6Wyj8L3ydUjUEQttBSvHETSWZBWiE4eMouFsD+S6dV7y29DnytPs0w/yeAYX
 QK9yov3I16Mj6lI1wkoDiRKrdM2N2Hb+bn5d2Lc1gfzJHE2MSxlqsEGQDvR7W5m+dszg
 c2iuyVquoCFjr9aOWtsNGmHzuA3mVGlmxbPrmQE2BDTuexbwpNGUNsHzMLo3g96eKopn hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkr27g808-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 05:31:38 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3635JJ3m027725;
        Mon, 3 Jul 2023 05:31:37 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkr27g7ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 05:31:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3621fMnC031324;
        Mon, 3 Jul 2023 05:31:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4s4fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 05:31:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3635VXYK36438482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jul 2023 05:31:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 300462004E;
        Mon,  3 Jul 2023 05:31:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE8DE20043;
        Mon,  3 Jul 2023 05:31:30 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.109.216.99])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Jul 2023 05:31:30 +0000 (GMT)
Date:   Mon, 3 Jul 2023 11:01:28 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Fabiano Rosas <farosas@linux.ibm.com>, jpn@linux.vnet.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@ozlabs.org>,
        Thomas Huth <thuth@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, gshan@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] KVM: ppc64: Enable ring-based dirty memory tracking
Message-ID: <ZKJdMEnu14MxZ1NV@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230608123448.71861-1-kconsul@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608123448.71861-1-kconsul@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eSlrFMC61zYwXxa0zM3sKRzOLECO6uWi
X-Proofpoint-GUID: 3NkeYMLezpaKytG2r7LMjBBJEDG7k8P8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=542
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307030047
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

On 2023-06-08 08:34:48, Kautuk Consul wrote:
> - Enable CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL as ppc64 is weakly
>   ordered.
> - Enable CONFIG_NEED_KVM_DIRTY_RING_WITH_BITMAP because the
>   kvmppc_xive_native_set_attr is called in the context of an ioctl
>   syscall and will call kvmppc_xive_native_eq_sync for setting the
>   KVM_DEV_XIVE_EQ_SYNC attribute which will call mark_dirty_page()
>   when there isn't a running vcpu. Implemented the
>   kvm_arch_allow_write_without_running_vcpu to always return true
>   to allow mark_page_dirty_in_slot to mark the page dirty in the
>   memslot->dirty_bitmap in this case.
> - Set KVM_DIRTY_LOG_PAGE_OFFSET for the ring buffer's physical page
>   offset.
> - Implement the kvm_arch_mmu_enable_log_dirty_pt_masked function required
>   for the generic KVM code to call.
> - Add a check to kvmppc_vcpu_run_hv for checking whether the dirty
>   ring is soft full.
> - Implement the kvm_arch_flush_remote_tlbs_memslot function to support
>   the CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT config option.
> 
> On testing with live migration it was found that there is around
> 150-180 ms improvment in overall migration time with this patch.
> 
> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
Can someone review this ?
