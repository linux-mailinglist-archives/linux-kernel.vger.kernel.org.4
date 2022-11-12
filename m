Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AAD6268BD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 11:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiKLKFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 05:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLKFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:05:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A16B13D08
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668247443;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5W9bu2hFI7xLEfEbbLNcIU/JquM0rgAJhzv8BY8pipY=;
        b=f4K+rxY569Ri4dQptv2qXvmQcryIKKOQgdfvNVJRpvcBHH64Cw0/STAXRMdVY7uT2IcqFf
        40elGVM7lIkdevbrKnGgR4mq5p+dm6BMbCiPqBwAbEuzt0Tj8LDzEYsk9kb4M91x0nc9mN
        voF4riOQolHylsn2KL1Ltf0BRdPKyzA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-yuQJI4_1O2ebcW8-0pDPuw-1; Sat, 12 Nov 2022 05:03:57 -0500
X-MC-Unique: yuQJI4_1O2ebcW8-0pDPuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4D3F3C02585;
        Sat, 12 Nov 2022 10:03:56 +0000 (UTC)
Received: from [10.67.24.81] (unknown [10.67.24.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 045DB1121330;
        Sat, 12 Nov 2022 10:03:50 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Allow >1 guest mode in
 access_tracking_perf_test
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20221111231946.944807-1-oliver.upton@linux.dev>
 <20221111231946.944807-2-oliver.upton@linux.dev>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <1024da03-46f6-b82f-0c17-ca1d95dd171b@redhat.com>
Date:   Sat, 12 Nov 2022 18:03:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20221111231946.944807-2-oliver.upton@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/22 7:19 AM, Oliver Upton wrote:
> As the name implies, for_each_guest_mode() will run the test case for
> all supported guest addressing modes. On x86 that doesn't amount to
> anything, but arm64 can handle 4K, 16K, and 64K page sizes on supporting
> hardware.
> 
> Blindly attempting to run access_tracking_perf_test on arm64 stalls on
> the second test case, as the 'done' global remains set between test
> iterations. Clear it after VM teardown in anticipation of a subsequent
> test case.
> 
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>   tools/testing/selftests/kvm/access_tracking_perf_test.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> index 76c583a07ea2..4da066479e0a 100644
> --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> @@ -326,6 +326,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>   
>   	perf_test_join_vcpu_threads(nr_vcpus);
>   	perf_test_destroy_vm(vm);
> +
> +	/* Clear done in anticipation of testing another guest mode */
> +	done = false;
>   }
>   
>   static void help(char *name)
> 

