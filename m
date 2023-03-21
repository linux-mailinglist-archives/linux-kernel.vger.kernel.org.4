Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5F6C3400
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjCUOW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjCUOWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:22:54 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D050704
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:22:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s19so3325574pgi.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679408562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zK2oKikLMhsjpoZfnl9kq7jtqVSuiVQmn3GCed10h+c=;
        b=SaLlnOexv4eAThvkdekCVUZbUl7mmWclkJm5i4VPUOcuiV8sDgFFFZAJ7Dcv83liaf
         sVfmP2IHzpOGa4Vmfkn2+0MNveaCHR6b4nXs6285V23Vi2oBFlqady5SGwFm0psjaGOE
         2Qe7JYp8I3C6M+/KXndjqTPMC4dQGk3ZHo4/U3U0OFjvn+Upz3euXrzpvr2wxcpgPfVh
         i7vrPvqV2jCoD9/xHRv8TKQM0l8Gnv8Yr3yOpXkOMt3uOTQlJJKycsobnPHN9VxiR48f
         q3zutwuvvLV+SD2vi55V8EG0bWZ6Jc8tIPk40jHvJpg4zbCrDXOX34UVLT6g4YuC0tx1
         5BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK2oKikLMhsjpoZfnl9kq7jtqVSuiVQmn3GCed10h+c=;
        b=THGA4zKDSQJnXQez9SYBTjxFUBx++o1lEyL6LfcfJ/H6KHVRVS3KNCFoSBNGHn1j5P
         LqLLH7kPeJwR3H157D4sIjnnGjshFmya0BKnNQOLm+0DGuvDxOal1da9Ye7mlorrMW1P
         1CTJx2HfiRt3C9yL6xEYqU7ZTHNfyBpvVtXc8MzuWv5KJHG90oXghW3XLh5ZqpwoiGcW
         5F7mAerPfEqenOlFpNnFezOYOMOEPOp3Gu1ZsM/0z9D1dwaPm+H6/WJpdkrx+yvI8NJ+
         TICqwqQ0hxczcWdGaWFJyh1izPfWmWtCeghjTO6EUTQrwIHv4TN3CZrRD8TyW0FCTdiY
         5FkA==
X-Gm-Message-State: AO0yUKUmasetDKIWN93hYzEpzwBNZsYAIFt9YSkw5slMVBIXtxb8LWXZ
        Puv/fGU6kdxv3sNkpBlywHhlpWNuKcGV1nZLLarv2A==
X-Google-Smtp-Source: AK7set/1T5zRnc6NbUwdtyPcUSXfTLHVV+/+mx2Jhf5DoqgGoV0ZRF21wj6FDDc6X5zCtifrNJHVuw==
X-Received: by 2002:a62:524f:0:b0:625:e728:4c5f with SMTP id g76-20020a62524f000000b00625e7284c5fmr2230069pfb.22.1679408561777;
        Tue, 21 Mar 2023 07:22:41 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id k23-20020aa790d7000000b0059442ec49a2sm8515706pfk.146.2023.03.21.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:22:41 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:22:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf kvm: Support refcnt in structure kvm_info
Message-ID: <20230321142235.GD221467@leoy-yangtze.lan>
References: <20230320061619.29520-1-leo.yan@linaro.org>
 <20230320061619.29520-2-leo.yan@linaro.org>
 <ZBmqiKC1FSGI0/iE@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBmqiKC1FSGI0/iE@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:00:56AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > +static inline void __kvm_info__zput(struct kvm_info **ki)
> > +{
> > +	kvm_info__put(*ki);
> > +	*ki = NULL;
> > +}
> > +
> > +#define kvm_info__zput(ki) __kvm_info__zput(&ki)
> > +
> > +static inline struct kvm_info *kvm_info__new(void)
> > +{
> > +	struct kvm_info *ki;
> > +
> > +	ki = zalloc(sizeof(*ki));
> > +	if (ki)
> > +		refcount_set(&ki->refcnt, 1);
> > +
> > +	return ki;
> > +}
> > +
> >  #endif /* HAVE_KVM_STAT_SUPPORT */
> >  
> >  extern int kvm_add_default_arch_event(int *argc, const char **argv);
> 
> I had to add this:
> 
> Provide a nop version of kvm_info__zput() to be used when
> HAVE_KVM_STAT_SUPPORT isn't defined as it is used unconditionally in
> hists__findnew_entry() and hist_entry__delete().

Thanks a lot, Arnaldo.

Just want to check, before I sent out this series I have run building
test with the command `make -C tools/perf build-test` and I didn't see
the building failure.  Do I need to run other testing?

Thanks,
Leo
