Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11906BF6FB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCRAhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCRAhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:37:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F30298F8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:37:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so7033983pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1679099853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsqJ2FThmy4OXzq7vzmkyG0P9MJhsLVw+x1g28a4sdc=;
        b=1ukzmtXDsFNUp6jp1ICIw6l8dmlw9Px31lUTYNtTqcIbFmX8pKl7qpIpkGLDsRClpf
         +bqD1TPWFbteH4ZapgH5v5B5svVVcWDytzU4LmyhbsSfirRlC5zkNOPBCpcyROe7suvw
         sVyNg9WtfNVAfKG7dIMZ0PERv8PsZtb2Z0H4UJZ9LsHqGWYeddFLrCej5d6heJrOarJY
         Os0UQ//K+5YP9ASLl7bOlPIVCqhkuSgaor+8ySeJelGVGAd6lJQv8GeKlXwUvby5Ms87
         mktosNumzdUFD7JJSV9il2FaYEIiPovv0U8sWRSHc2MASRakuMNlO6MQx3kSnDQKfrC+
         /pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679099853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsqJ2FThmy4OXzq7vzmkyG0P9MJhsLVw+x1g28a4sdc=;
        b=lR2B2XL9qCtSRQ70mzx2C+Q2CV1nOEKK215nwwtV5HkR8tRhFKz17YZTW+9fcMkG+F
         VA2zaYkWXLjAL3TwAhG/VUfg4VC/CA3zjZ0bMIVqZ2T2S5Q2+CLSSs1zrK38r5NJj1el
         9p5brbLyTKKe6unIHTZ6mzCNiCn4Uc2V1zx8DgnYjdlOzB7FZtutr5v2axy12qnSsK8o
         l6o3XV0LN/5KJIOAvEQQeZmEyGRsJSez8bgJNKW6+OUCoj6ylDZUIdYP452zOU5M9jpB
         wnJryZXqnNhWsLvU03M5kGp+YnN9U3erXbU/58lLRXtnsQNluxYhfUUDNEZpIILRLAvL
         L8OA==
X-Gm-Message-State: AO0yUKVmsh/SSuyovJFDpQINXs7BeKRnGFvKZoafMMkwcxCngDBzSLtP
        CjIYXlKzxjszJqEfAlzejsLkpkdGHzfX6zs36KE=
X-Google-Smtp-Source: AK7set/w/LZITNrsIWBwTVDruoNlaZ6AOU0yoW+i7jGUPAAcgmf/dJ5TXtlveacg9491eSTNP2vX2w==
X-Received: by 2002:a17:90a:8988:b0:237:401c:9bd5 with SMTP id v8-20020a17090a898800b00237401c9bd5mr9829412pjn.46.1679099853021;
        Fri, 17 Mar 2023 17:37:33 -0700 (PDT)
Received: from destitution (pa49-196-94-140.pa.vic.optusnet.com.au. [49.196.94.140])
        by smtp.gmail.com with ESMTPSA id l18-20020a17090add9200b0023530b1e4a0sm2062252pjv.2.2023.03.17.17.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 17:37:32 -0700 (PDT)
Received: from dave by destitution with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1pdKZd-000J7B-1A;
        Sat, 18 Mar 2023 11:37:29 +1100
Date:   Sat, 18 Mar 2023 11:37:29 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yebin10@huawei.com
Subject: Re: [PATCH 2/4] pcpcntrs: fix dying cpu summation race
Message-ID: <ZBUHyXkdzViG2VmT@destitution>
References: <20230315084938.2544737-1-david@fromorbit.com>
 <20230315233618.2168-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315233618.2168-1-hdanton@sina.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 07:36:18AM +0800, Hillf Danton wrote:
> On 15 Mar 2023 19:49:36 +1100 Dave Chinner <dchinner@redhat.com>
> > @@ -141,11 +141,20 @@ static s64 __percpu_counter_sum_mask(struct percpu_counter *fbc,
> >  
> >  /*
> >   * Add up all the per-cpu counts, return the result.  This is a more accurate
> > - * but much slower version of percpu_counter_read_positive()
> > + * but much slower version of percpu_counter_read_positive().
> > + *
> > + * We use the cpu mask of (cpu_online_mask | cpu_dying_mask) to capture sums
> > + * from CPUs that are in the process of being taken offline. Dying cpus have
> > + * been removed from the online mask, but may not have had the hotplug dead
> > + * notifier called to fold the percpu count back into the global counter sum.
> > + * By including dying CPUs in the iteration mask, we avoid this race condition
> > + * so __percpu_counter_sum() just does the right thing when CPUs are being taken
> > + * offline.
> >   */
> >  s64 __percpu_counter_sum(struct percpu_counter *fbc)
> >  {
> > -	return __percpu_counter_sum_mask(fbc, cpu_online_mask);
> > +
> > +	return __percpu_counter_sum_mask(fbc, cpu_dying_mask);
> >  }
> >  EXPORT_SYMBOL(__percpu_counter_sum);
> >  
> > -- 
> > 2.39.2
> 
> Hm... the window of the race between a dying cpu and the sum of percpu counter
> spotted in commit f689054aace2 is stil open after a text-book log message.
> 
> 	cpu 0			cpu 2
> 	---			---
> 	percpu_counter_sum() 	percpu_counter_cpu_dead()
> 
> 	raw_spin_lock_irqsave(&fbc->lock, flags);
> 	ret = fbc->count;
> 	for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
> 		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
> 		ret += *pcount;
> 	}
> 	raw_spin_unlock_irqrestore(&fbc->lock, flags);
> 
> 				raw_spin_lock(&fbc->lock);
> 				pcount = per_cpu_ptr(fbc->counters, cpu);
> 				fbc->count += *pcount;
> 				*pcount = 0;
> 				raw_spin_unlock(&fbc->lock);

Their is no race condition updating fbc->count here - I explained
this in the cover letter. i.e. the sum in percpu_counter_sum() is to
a private counter and does not change fbc->count. Therefore we only
need/want to fold the dying cpu percpu count into fbc->count in the
CPU_DEAD callback.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
