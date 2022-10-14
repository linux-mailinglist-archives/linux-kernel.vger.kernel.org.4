Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F8E5FF24E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiJNQfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiJNQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:34:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78DB21812
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:34:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso8361320pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBxxsrmiTMVnC6L39aahbgagT1+SvZAUCiWNUgh/lWI=;
        b=sDpdUr8vp75k8W7ILpihfiK5ZooZsrHszH4P9vakiznZc5R7yn/raMbnxzfh9kIa+J
         4OhvbpcSHySHDD4jGUd+4M873vSvBiWPSF1bUXazE9ujfOOQPO2sqWQxsoz/fvByLOzX
         JqXQXzoUkWNPCjorNYDFYSZnrVpszBDWvEQgwK5H6vXwknGt4ZEPx6cHMIHpLnA32A/p
         e34oCDd7DMTWx/nXqHnZwMush4wxgcBPJm9IgvnN3BWOilQOaLu87oaxcpICtUZD0bGL
         GJzNNH8/2Tu6ZtNpCGyoBvY3wqAiqBGDMncVpaeJy1jeATwxiEKJxQZwcfkUEZi5EzWk
         3h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBxxsrmiTMVnC6L39aahbgagT1+SvZAUCiWNUgh/lWI=;
        b=a902wlJWnX1ngnvJ6VxK0NLLNmr8FpoUGhWqYzdiAonhTJlHlHuPNuIBzlLYVvloyT
         suzUeuwzmcMEz/9LzkvIg09BUivKCKYq0psher1YzNar0EBEwQ/dTNZ3SbVqb48fMSqF
         LbJ5n8+ILcDyEZqyvpSh5MX1uWHpjJ8QQmME5BE67da69vEmH1rvTAvmBB2lcbp/mUlp
         UYbz2eOQhRO/+4jzHYGSOv0wE2a0o7RH98cEytqCbInrQSTWfMDsIVZyPGbDC5x733Gz
         GotDura5zVl6iYZ0M59uO8L0ou1Dk+uYoN9cWBaBMIqLjxd2YiE50D2gI8xe1ARv9vM3
         glbg==
X-Gm-Message-State: ACrzQf1oB5i962QeYNjzZ2vzdLabVvRWrePRGxt1sokg1OzlFh1TnFZc
        mrudgWvJDpf1vW3WPHJySScDPA==
X-Google-Smtp-Source: AMsMyM6aCNOXTixliam4nOju0FXDdS1Agx0aGaQ+07Vs5gwGT2BkQCCEludl+AL+kCYtMB0KILlmPQ==
X-Received: by 2002:a17:902:ecca:b0:183:7473:580c with SMTP id a10-20020a170902ecca00b001837473580cmr6170976plh.167.1665765292199;
        Fri, 14 Oct 2022 09:34:52 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w29-20020aa7955d000000b00562657a7b11sm1981099pfq.8.2022.10.14.09.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 09:34:51 -0700 (PDT)
Date:   Fri, 14 Oct 2022 16:34:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     Vipin Sharma <vipinsh@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dmatlack@google.com" <dmatlack@google.com>,
        "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] dirty_log_perf_test vCPU pinning
Message-ID: <Y0mPqNRSgpArgyS8@google.com>
References: <20221010220538.1154054-1-vipinsh@google.com>
 <DS0PR11MB63735576A8FBF80738FF9B76DC249@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB63735576A8FBF80738FF9B76DC249@DS0PR11MB6373.namprd11.prod.outlook.com>
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

On Fri, Oct 14, 2022, Wang, Wei W wrote:
> On Tuesday, October 11, 2022 6:06 AM, Vipin Sharma wrote: 
> > Pin vCPUs to a host physical CPUs (pCPUs) in dirty_log_perf_test and optionally
> > pin the main application thread to a physical cpu if provided. All tests based on
> > perf_test_util framework can take advantage of it if needed.
> > 
> > While at it, I changed atoi() to atoi_paranoid(), atoi_positive,
> > atoi_non_negative() in other tests, sorted command line options alphabetically
> > in dirty_log_perf_test, and added break between -e and -g which was missed in
> > original commit when -e was introduced.
> 
> Just curious why not re-using the existing tools (e.g. taskset) to do the pinning?

IIUC, you're suggesting the test give tasks meaningful names so that the user can
do taskset on the appropriate tasks?  The goal is to ensure vCPUs are pinned before
they do any meaningful work.  I don't see how that can be accomplished with taskset
without some form of hook in the test to effectively pause the test until the user
(or some run script) is ready to continue.

Pinning aside, naming the threads is a great idea!  That would definitely help
debug, e.g. if one vCPU gets stuck or is lagging behind.

> 
> For example, with below changes:
> diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/se                                                                                                             lftests/kvm/lib/perf_test_util.c
> index 9618b37c66f7..aac58d1acb3c 100644
> --- a/tools/testing/selftests/kvm/lib/perf_test_util.c
> +++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
> @@ -264,6 +264,7 @@ void perf_test_start_vcpu_threads(int nr_vcpus,
>                                   void (*vcpu_fn)(struct perf_test_vcpu_args *))
>  {
>         int i;
> +       char vcpu_name[5];
> 
>         vcpu_thread_fn = vcpu_fn;
>         WRITE_ONCE(all_vcpu_threads_running, false);
> @@ -275,6 +276,8 @@ void perf_test_start_vcpu_threads(int nr_vcpus,
>                 WRITE_ONCE(vcpu->running, false);
> 
>                 pthread_create(&vcpu->thread, NULL, vcpu_thread_main, vcpu);
> +               sprintf(vcpu_name, "%s%d", "vcpu", i);
> +               pthread_setname_np(vcpu->thread, vcpu_name);
>         }
> 
> and with top we can get
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>    4464 root      20   0 4248684   4.0g   1628 R  99.9  26.2   0:50.97 dirty_log_perf_
>    4467 root      20   0 4248684   4.0g   1628 R  99.9  26.2   0:50.93 vcpu0
>    4469 root      20   0 4248684   4.0g   1628 R  99.9  26.2   0:50.93 vcpu2
>    4470 root      20   0 4248684   4.0g   1628 R  99.9  26.2   0:50.94 vcpu3
>    4468 root      20   0 4248684   4.0g   1628 R  99.7  26.2   0:50.93 vcpu1
