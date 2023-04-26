Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D106EFC84
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbjDZVbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjDZVbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:31:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255E40F8;
        Wed, 26 Apr 2023 14:31:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso6039605b3a.0;
        Wed, 26 Apr 2023 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682544664; x=1685136664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyAQfyFwzjMa4fofwS6O6zoQbKADFEMPLkANCNd7SDY=;
        b=kNYE18oyzz/4Iu23lWj3r7k9A2SG2IGsbPaxPxW1iel0+ewNBRxYByhR21n4I78bnc
         Ui0oWecoTiQnXa/2hHdbMmJPwpdjWt+1lM0QbabDEbc1gxG5nfA/w5FDen9D7NpUzgcW
         pXuG4L2YO0oKpT99avgG8226IqviThdKgE5xEjQt/HrbabLpv6nlcWZKLUSjZjOypEqD
         MM6Zu/L15H54GC3PfM8MftvShFk19m6i5aS/t3bfipKOysCLdcrQMounT55UCZEl4YEj
         NepjeJzX0a/PATueFAhVKBd3thhBf6VR5BVEiibGb69jHwfAb6uZ2uxiGzb64pqKlVJO
         1EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682544664; x=1685136664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyAQfyFwzjMa4fofwS6O6zoQbKADFEMPLkANCNd7SDY=;
        b=Axal/5sHWLZZyHTGspo7sLskxn32lfsQxaxX9Fvd3KONjWVBDWqP7PUBtc6fkEFW0J
         jjDgyYZznGLl/w+f4zk6jSunN6xj2Dl+QTmSS0iRzhoycA4ZxFEwwXpGOaLNYltUOimb
         iafQX143D7f7jU9YeqhVckYG4arwCO1TTEiTmFHo8hqf5GX3r2o7btyBJn93alh3NK9X
         yiqwqAYxc6/o0HYnIbvT8cNuUN7MisVD9PwP+rQzRFyMgmFrunVD78xtHHlXObIxAK4z
         O56AmDoOeHzXyEM9MsNdNsbLMNNxgQu4JcEvueQ+wS4e7TrEl/7A8sNHcOOxIDJfGGd2
         Z65A==
X-Gm-Message-State: AAQBX9fgSlSQwjhQtiD/kWuYdgm5NM4aqHdE43cby918s8I9wz4/JIjF
        5FwHuEehyPMGt8p6eDrliQA=
X-Google-Smtp-Source: AKy350bOJ7cGT13b9cTaIJbspEun6EnH9BHZnGaCgQDJfMzaGaWEmwY+YLKlnS8p3AJwb1gGn99qDQ==
X-Received: by 2002:a05:6a00:1147:b0:63b:6933:a328 with SMTP id b7-20020a056a00114700b0063b6933a328mr27547348pfm.28.1682544662168;
        Wed, 26 Apr 2023 14:31:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1976])
        by smtp.gmail.com with ESMTPSA id 2-20020a621802000000b0063d24d5f9b6sm11763176pfy.210.2023.04.26.14.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 14:31:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Apr 2023 11:31:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, riel@surriel.com
Subject: Re: [PATCH RFC rcu] Stop rcu_tasks_invoke_cbs() from using
 never-online CPUs
Message-ID: <ZEmYFLKspo-rhyp4@slm.duckdns.org>
References: <83d037d1-ef12-4b31-a7b9-7b1ed6c3ae42@paulmck-laptop>
 <ZEmBy0H5T5vQJDUW@slm.duckdns.org>
 <1713f8f6-88d6-41f1-bbc6-045b2e017289@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713f8f6-88d6-41f1-bbc6-045b2e017289@paulmck-laptop>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 26, 2023 at 02:17:03PM -0700, Paul E. McKenney wrote:
> But the idea here is to spread the load of queueing the work as well as
> spreading the load of invoking the callbacks.
> 
> I suppose that I could allocate an array of ints, gather the online CPUs
> into that array, and do a power-of-two distribution across that array.
> But RCU Tasks allows CPUs to go offline with queued callbacks, so this
> array would also need to include those CPUs as well as the ones that
> are online.

Ah, I see, so it needs to make the distinction between cpus which have never
been online and are currently offline but used to be online.

> Given that the common-case system has a dense cpus_online_mask, I opted
> to keep it simple, which is optimal in the common case.
> 
> Or am I missing a trick here?

The worry is that on systems with actual CPU hotplugging, cpu_online_mask
can be pretty sparse - e.g. 1/4 filled wouldn't be too out there. In such
cases, the current code would end scheduling the work items on the issuing
CPU (which is what WORK_CPU_UNBOUND does) 3/4 of the time which probably
isn't the desired behavior.

So, I can initialize all per-cpu workqueues for all possible cpus on boot so
that rcu doesn't have to worry about it but that would still have a similar
problem of the callbacks not really being spread as intended.

I think it depends on how important it is to spread the callback workload
evenly. If that matters quite a bit, it probably would make sense to
maintain a cpumask for has-ever-been-online CPUs. Otherwise, do you think it
can just use an unbound workqueue and forget about manually distributing the
workload?

Thanks.

-- 
tejun
