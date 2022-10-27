Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8155A60ECE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiJ0AQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiJ0AQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:16:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191983A16C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:16:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m6so17268577pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7vXj+46fyiPuMGxxnyzn51Lo7cwsHpHRS0ZMf50pys=;
        b=QXw2HkHNc0iKGWFmi7Z2IQcr2gcKU2aX4UtOMqDNsYx0fjh/LLxbtbZqQ7tT7x2WBv
         rDCEt/q9zAfZhebZR2epjwFdZe2BCBOK5vJR0EHGdJPL778Kgp+wDPtoNllEqWSUlR+b
         4TTRxXgQQFRtjszSFec2jRhDwGKahlOOy46kG/VRmbgmj5PaFTpDZbbO6pWJ25xt8e1i
         u52GJGZ85CugzxrHntkp2URS2xyp2h0SqGNAjib0g7xqqY+x++cYWRnR13DASBISv3wG
         H+4AWkrcMoVjgP+myBECLSQD1wDPFmIJvFvDtR+GlJnht7EaYEy7uTw+TkjDq7YsV/k3
         uZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7vXj+46fyiPuMGxxnyzn51Lo7cwsHpHRS0ZMf50pys=;
        b=Mr8bdql1NzakC8LQX9qPoSm+WVC64avN340F6VX4bLIE4Xg/HuH1LCcBfiCB7GQVhg
         TsKqLcKo7YKYKczlOhJO125Jc2IpFMMgov8bYB2tH9seToPV0Y1G9JzJRyJN7NVHXaFP
         ckO3SkaNGil27MC+h1lcRo+//hq2qAWi0dEMH1lOStCu3hK0gQX0qXIFUFHRgtxwhPZW
         T2Rsuei1DnjbTQCVx99XtrwSUgDDvhwIZRVxqt92341U355YElVyUcufFIMwQcOxDY0Q
         QKNCwoFT6ZWWlEHijZo14oT3C4/oUusvQwG200eGGu2SP0t8cvLFJIC8QDzCaItm8OEm
         lO0w==
X-Gm-Message-State: ACrzQf2K3fDZJol3ZqWImE50GGmC4XSSaizU72oyQy/Q92uxijUTnolO
        zN6a58QY0rWY2XVk1WZFSpCxqg==
X-Google-Smtp-Source: AMsMyM58wWW0puBkcWpp/B6QRCuzQ6np8ztWs4unLkweQabmDbjHTA4FsR2Fih4fUmJsaQ/RH8CaMA==
X-Received: by 2002:a65:5807:0:b0:459:a31a:80c2 with SMTP id g7-20020a655807000000b00459a31a80c2mr39654909pgr.27.1666829776562;
        Wed, 26 Oct 2022 17:16:16 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902a3cb00b00174f7d107c8sm3421728plb.293.2022.10.26.17.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 17:16:16 -0700 (PDT)
Date:   Thu, 27 Oct 2022 00:16:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, vipinsh@google.com,
        ajones@ventanamicro.com, eric.auger@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/18] KVM: selftests/hardware_disable_test: code
 consolidation and cleanup
Message-ID: <Y1nNzO2tC+DCyKWI@google.com>
References: <20221024113445.1022147-1-wei.w.wang@intel.com>
 <20221024113445.1022147-6-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024113445.1022147-6-wei.w.wang@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022, Wei Wang wrote:
> Remove the unnecessary definition of the threads[] array, and use the
> helper functions to create and join threads.
> 
> Also move setting of the thread affinity to __vcpu_thread_create using
> attribute. This avoids an explicit step to set it after thread
> creation.

As David called out, please do this in a separate patch (one logical change per
patch).

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  .../selftests/kvm/hardware_disable_test.c     | 56 +++++--------------
>  1 file changed, 15 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> index f5d59b9934f1..c212d34a6714 100644
> --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> @@ -8,7 +8,6 @@
>  #define _GNU_SOURCE
>  
>  #include <fcntl.h>
> -#include <pthread.h>
>  #include <semaphore.h>
>  #include <stdint.h>
>  #include <stdlib.h>
> @@ -59,64 +58,39 @@ static void *sleeping_thread(void *arg)
>  	pthread_exit(NULL);
>  }
>  
> -static inline void check_create_thread(pthread_t *thread, pthread_attr_t *attr,
> -				       void *(*f)(void *), void *arg)
> -{
> -	int r;
> -
> -	r = pthread_create(thread, attr, f, arg);
> -	TEST_ASSERT(r == 0, "%s: failed to create thread", __func__);
> -}
> -
> -static inline void check_set_affinity(pthread_t thread, cpu_set_t *cpu_set)
> -{
> -	int r;
> -
> -	r = pthread_setaffinity_np(thread, sizeof(cpu_set_t), cpu_set);
> -	TEST_ASSERT(r == 0, "%s: failed set affinity", __func__);
> -}
> -
> -static inline void check_join(pthread_t thread, void **retval)
> -{
> -	int r;
> -
> -	r = pthread_join(thread, retval);
> -	TEST_ASSERT(r == 0, "%s: failed to join thread", __func__);
> -}
> -
>  static void run_test(uint32_t run)
>  {
>  	struct kvm_vcpu *vcpu;
>  	struct kvm_vm *vm;
>  	cpu_set_t cpu_set;
> -	pthread_t threads[VCPU_NUM];
>  	pthread_t throw_away;
> -	void *b;
> +	pthread_attr_t attr;
>  	uint32_t i, j;
> +	int r;
>  
>  	CPU_ZERO(&cpu_set);
>  	for (i = 0; i < VCPU_NUM; i++)
>  		CPU_SET(i, &cpu_set);

Uh, what is this test doing?  I assume the intent is to avoid spamming all pCPUs
in the system, but I don't get the benefit of doing so.
