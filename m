Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B3368DD28
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjBGPgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjBGPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:36:51 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDA52366E;
        Tue,  7 Feb 2023 07:36:50 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317FHYDG029274;
        Tue, 7 Feb 2023 15:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=1THnRWeDL5EycU0KSF5rNw1gmtsHkkvviicj+5+IlfI=;
 b=gOZf7ZXZ8dplyODS3aGlH+TLt485eAuYKKaAAXObqznZqnA006AKZCcN5KKkN/rNhxW6
 5THM8sU8hL2sr76rhF/wy0B0fPRbkIvFfraAem5qXSr0em4emDNG2alSu3aUueWaVO2N
 OnJMf1VQpmAwrlLIu8ocx/5Fx1uVWG4Jp2DYdPXCcB1uXLubA8aL36PHEuWXVyrdDfpk
 JtF57C3dXxFUUPG+dBna1WxARpnp9phG/YauTJkSKZmlmK/TeUWpx3t3dSJzYug8fzPu
 L6a4j26d9HkRy4aXq9qnPAOMQ+2s1wzcuDPeW2/eCcWK8YoCvp6wFl7cMEG+dL3jtTkx bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nks5f8hka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 15:36:16 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317FJQdM005425;
        Tue, 7 Feb 2023 15:36:16 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nks5f8hhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 15:36:15 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3172fI09017256;
        Tue, 7 Feb 2023 15:36:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3nhf06tpa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 15:36:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 317Fa9UW15925584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Feb 2023 15:36:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB11F20063;
        Tue,  7 Feb 2023 15:36:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D21A2004B;
        Tue,  7 Feb 2023 15:36:09 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.56])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Feb 2023 15:36:09 +0000 (GMT)
Date:   Tue, 7 Feb 2023 16:36:07 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/7] KVM: s390: Use "int" as return type for
 kvm_s390_get/set_skeys()
Message-ID: <20230207163607.4cf6739c@p-imbrenda>
In-Reply-To: <20230203094230.266952-6-thuth@redhat.com>
References: <20230203094230.266952-1-thuth@redhat.com>
        <20230203094230.266952-6-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h1QNOgTrAn4DjVcRnfzpjxJfKWNrvq6W
X-Proofpoint-GUID: 90LiL_K4VkqoTHGkM7gQCTWyDwGtHxR-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070138
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Feb 2023 10:42:28 +0100
Thomas Huth <thuth@redhat.com> wrote:

> These two functions only return normal integers, so it does not
> make sense to declare the return type as "long" here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e4890e04b210..8ad1972b8a73 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1992,7 +1992,7 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
>  	return ret;
>  }
>  
> -static long kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
> +static int kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
>  {
>  	uint8_t *keys;
>  	uint64_t hva;
> @@ -2040,7 +2040,7 @@ static long kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
>  	return r;
>  }
>  
> -static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
> +static int kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
>  {
>  	uint8_t *keys;
>  	uint64_t hva;

