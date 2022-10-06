Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7715F6F18
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiJFU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiJFU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:27:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D8BEADD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:27:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b2so2712986plc.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSfOYgB7QcjQtHbJhfVo2r2XCJmV0WBSW4LA1S6H6mY=;
        b=n+IETemn0RhHM4VOKVH9refh4D/Bw8dtlhNbXet6YMrvQvK0gEZxQtKL6qx9Tt6mQb
         sRysWq4jRMrEmQ6t+6VVGWbK4vcphDCi7ifEON/MBQSK2rvc87ASCJnM59HEqSUf4X16
         NAXbngEpATB2TmH9MN7FpnDG1B30CCkYA+uC1ea6mvtj734cYG9uKa0Z7q9MLvXNF7sx
         ccXw5ywHg8ZerTX0LShwy1Dy51N3QhGBlDVwdl998WeVBKKWvid0DclxYStGmM9N1bwk
         3hXnSzu5eCW5iNkmvPeRI8Zo8c2DyKpKsdioQ3kKQr6quWvQ/72tZEspm3vFkK+1SJPX
         eaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSfOYgB7QcjQtHbJhfVo2r2XCJmV0WBSW4LA1S6H6mY=;
        b=ziolhKxITRUhPkNlfGJ/5LdfCCvRySbD15GyTUifB3fVBODaRh2cPqmhXiN11riUB/
         mgqOClsqXKfUU5bJFMafy2bbnptB+lvol0bbWas4rfsvh37dle98FGoZA15dUMNFirMf
         HdsLLkpqT+jizuL7XQeyNNKArkb9lhuxVao1B5TxNMDf6Ni7EfjAbmUIAMGn+OFYoscD
         InMTeQGJ2i7fjKnrjl2YsEYqqVkGvG/hDrsncOOJDxz0xPF4VwFBfuOZcPNO5CrKc+mu
         s6q9z2NdmaNlkByGI9LLVxGrsew/alJEbvlRmWA49TMnISBiVTqkmN9UOG9V8wF1CkPh
         h49g==
X-Gm-Message-State: ACrzQf0Yd9/ckPfWjwyaEbGvuoljUEktBKxvXSaWrernndzFqSwD78EO
        +hVU50LJbEPpPY35QnsHGGcQNg==
X-Google-Smtp-Source: AMsMyM4kf4UcVHaIKsExjPykA+zggYu68a12YmLiVGDSQfscQxedLL+YNFHBL87NjcWx/ynk17GF2Q==
X-Received: by 2002:a17:90b:3510:b0:202:f18c:fdb6 with SMTP id ls16-20020a17090b351000b00202f18cfdb6mr1502448pjb.122.1665088022293;
        Thu, 06 Oct 2022 13:27:02 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b0017f93a4e330sm21062pln.193.2022.10.06.13.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:27:01 -0700 (PDT)
Date:   Thu, 6 Oct 2022 20:26:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, andrew.jones@linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] KVM: selftests: Run dirty_log_perf_test on
 specific CPUs
Message-ID: <Yz86ETKxsCGb7s+u@google.com>
References: <20221006171133.372359-1-vipinsh@google.com>
 <20221006171133.372359-5-vipinsh@google.com>
 <Yz8xdJEMjcfdrcWC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz8xdJEMjcfdrcWC@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022, Sean Christopherson wrote:
> On Thu, Oct 06, 2022, Vipin Sharma wrote:
> > +{
> > +	cpu_set_t cpuset;
> > +	int err;
> > +
> > +	CPU_ZERO(&cpuset);
> > +	CPU_SET(pcpu, &cpuset);
> 
> To save user pain:
> 
> 	r = sched_getaffinity(0, sizeof(allowed_mask), &allowed_mask);
> 	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)", errno,
> 		    strerror(errno));

Forgot TEST_ASSERT() already provides errno, this can just be:

	TEST_ASSERT(!r, "sched_getaffinity() failed");

> 
> 	TEST_ASSERT(CPU_ISSET(pcpu, &allowed_mask),
> 		    "Task '%d' not allowed to run on pCPU '%d'\n");
> 
> 	CPU_ZERO(&allowed_mask);
> 	CPU_SET(cpu, &allowed_mask);
> 
> that way the user will get an explicit error message if they try to pin a vCPU/task
> that has already been affined by something else.  And then, in theory,
> sched_setaffinity() should never fail.
> 
> Or you could have two cpu_set_t objects and use CPU_AND(), but that seems
> unnecessarily complex.
> 
> > +	err = sched_setaffinity(0, sizeof(cpu_set_t), &cpuset);
> > +	TEST_ASSERT(err == 0, "sched_setaffinity() errored out for pcpu: %d\n", pcpu);
> 
> !err is the preferred style, though I vote to use "r" instead of "err".  And print
> the errno so that the user can debug.

As above, ignore the last, forgot TEST_ASSERT() provides errno.

> 
> 	r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
> 	TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
> 		    errno, strerror(errno));
