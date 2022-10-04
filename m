Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA0E5F4C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJDW6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJDW6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:58:04 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14C2B195
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:58:03 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c19so9294957qkm.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 15:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oUQ472y4a5Iwvz+4i6zJgJAC9lQlD7BHECsTU/KO7xc=;
        b=XM8mgBkPRXeO1pat07ocfIeHEMEhxaPjihcQuI5u8kirfV0Gl5ABcbuAJOkcHNrftf
         mSKZTXN43RlLHntAHkwIBSa5Xw0HxHpC3kobqGTKxAfHhcMviBem/jov3IlTHg+Ba0wZ
         Z7EvqWi2VboLBNvCrxlovbExHH7A7vYt9amsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oUQ472y4a5Iwvz+4i6zJgJAC9lQlD7BHECsTU/KO7xc=;
        b=rtbb35qpOX5I4oa+9/OgIzwscEsRCsP9xZ5TNZIycOxRWj7uapEyOD8mafiAfFYbGF
         tHoKBDjqvLpWQuSmf3KcrvGw7/rPYQ8KMZWXh0UUexmmdMdHx3wf2KjVw6Df4Q2rEJWi
         MTsslpf57X22b4XRm576EUL6AwGPmGBG3H163EjPbiOQRMNyCpeTjZ+dmDpiBne3Nfy5
         HyKK91ThPY4TE3gLygeW7b99tsGGRKPBjHBQg6JVNSlhhx6UqPKAvyHHxt6y0HwHStqZ
         8KJx/VUarrIg5kNBgI3K8J7kVncc01fWzvE7GuMucWb5JBMkDatlWU+novukoLYJmH/4
         ETYQ==
X-Gm-Message-State: ACrzQf2DnKolvEc6Pd9MbK3cJ/qhkl9efrlUu8xdcEFEUPt0KEKiKa6Q
        Tj8RI8e78YRzEgEecIaTWGWDrQ==
X-Google-Smtp-Source: AMsMyM6FWT/+R8xO9leihcqYzDq7+/tPb230ZH04X87EojtN0d2I6a/yJ6K0NtwjTK+66Bjeft5/qA==
X-Received: by 2002:ae9:ef4d:0:b0:6cf:427b:c250 with SMTP id d74-20020ae9ef4d000000b006cf427bc250mr18717138qkg.607.1664924282413;
        Tue, 04 Oct 2022 15:58:02 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id m16-20020a05620a291000b006c73c3d288esm15430156qkp.131.2022.10.04.15.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 15:58:01 -0700 (PDT)
Message-ID: <c634e41e-3c6c-0896-0873-b9d1bb317cea@joelfernandes.org>
Date:   Tue, 4 Oct 2022 18:57:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v7 01/11] rcu: Wake up nocb gp thread on
 rcu_barrier_entrain()
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-2-joel@joelfernandes.org>
 <20221004222853.GA323878@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20221004222853.GA323878@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On 10/4/2022 6:28 PM, Frederic Weisbecker wrote:
> On Tue, Oct 04, 2022 at 02:41:47AM +0000, Joel Fernandes (Google) wrote:
>> From: Frederic Weisbecker <frederic@kernel.org>
>>
>> In preparation of RCU lazy changes, wake up the RCU nocb gp thread if
> 
> It's more than just prep work for a new feature, it's a regression fix.

Oh ok, both our fixes are equivalent but I chose yours since its cleaner. I was
fixing Lazy CBs since I can actually trigger this issue.

>> needed after an entrain. Otherwise, the RCU barrier callback can wait in
>> the queue for several seconds before the lazy callbacks in front of it
>> are serviced.
> 
> It's not about lazy callbacks here (but you can mention the fact that
> waking nocb_gp if necessary after flushing bypass is a beneficial side
> effect for further lazy implementation).
> 
> So here is the possible bad scenario:
> 
> 1) CPU 0 is nocb, it queues a callback
> 2) CPU 0 goes idle (or userspace with nohz_full) forever
> 3) The grace period related to that callback elapses
> 4) The callback is moved to the done list (but is not invoked yet), there are no more pending for CPU 0
> 5) CPU 1 calls rcu_barrier() and entrains to CPU 0 cblist

CPU 1 can only entrain into CPU 0 if the CPU is offline:

		if (!rcu_rdp_cpu_online(rdp)) {
			rcu_barrier_entrain(rdp);
			WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
			raw_spin_unlock_irqrestore(&rcu_state.barrier_lock,
			...
			continue;
		}

Otherwise an IPI does the entraining. So I do not see how CPU 0 being idle
causes the cross-CPU entraining.

> 6) CPU 1 waits forever

But, I agree it can still wait forever, once the IPI handler does the
entraining, since nothing will do the GP thread wakeup.

>>
>> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")

So, do you mind writing a proper patch with a proper commit message and Fixes
tag then? It can independent of this series and add my Reported-by tag, thanks!

Thanks!

 - Joel

