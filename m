Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0972D543
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbjFLX4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjFLX4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:56:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD127171E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:56:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66577752f05so1420130b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686614169; x=1689206169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23+qpk+O/Ldq4FgWGRIJTzgY9OOm945xbR0BCjqFgYM=;
        b=KGb26G4Le3cYL0pqDi4N2/+KwHaLOJ+wC+UDTsP18AxrkhWiI7mZnGaaocmzPi9V9P
         aPR0mTTCF7wnrqXgHFjh78nzGYIgX64nn2NBrQd+6z3oziTbwVAiKgKKfZCjDMGC3SYZ
         KJw7FInjFn1yGPu99l5nu5SXHU6QQMrtYJkbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686614169; x=1689206169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23+qpk+O/Ldq4FgWGRIJTzgY9OOm945xbR0BCjqFgYM=;
        b=UWHDJHq/Zu016JuW2F56Jpsj1ayHO1nGsRGltioVyo48KCB1e656dTmjjhjUP2SCmX
         Jn2RMtPNL1hZLH5kHm044UmCfPNk2eYUtBOpM+A69n8bqPHFr0xQeH8Tnzk06aaJuZIn
         VwYj0cVfBxATqfAdMhjBtohpc40rjIP6FkwO3BMTKqt7mspMpxLF18eAgCN5iT/bGAkG
         mLvQst3ySCUvbtELQAcgFtXxceiQuz7A6JXHDbKD99TgVMzAz4dcbmy5F6ep2GWlPCmZ
         8EN7hnRlhCPYcVnezIVsX93X+BHiTna5J8gobtNBTu34EDgzY16O1tubIt42GiCp2GqF
         4OPw==
X-Gm-Message-State: AC+VfDzrqkewBp5XDKPcai+BRg425CMl0ctRJsdIkqPFqvGXRGzzZ8Mv
        d/puKX72n0d8CdGSmEuF3JwTHA==
X-Google-Smtp-Source: ACHHUZ7/PiHRhw0ElQFF6kfyq9MbtMkqHpca9JkxwTfy5wTynrc21I3RIJb56DSghX084uxUWyFNhQ==
X-Received: by 2002:a17:90a:3f16:b0:259:466:940f with SMTP id l22-20020a17090a3f1600b002590466940fmr8502011pjc.22.1686614169232;
        Mon, 12 Jun 2023 16:56:09 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5666:8195:ab60:72b3])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001aaffe15f39sm8776925plt.30.2023.06.12.16.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 16:56:08 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:56:06 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, treapking@chromium.org
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <ZIewlkGJJJUXPFL0@google.com>
References: <20230519001709.2563-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 18, 2023 at 02:16:45PM -1000, Tejun Heo wrote:
> In terms of patches, 0021-0024 are probably the interesting ones.
> 
> Brian Norris, Nathan Huckleberry and others experiencing wq perf problems
> -------------------------------------------------------------------------
> 
> Can you please test this patchset and see whether the performance problems
> are resolved? After the patchset, unbound workqueues default to
> soft-affining on cache boundaries, which should hopefully resolve the issues
> that you guys have been seeing on recent kernels on heterogeneous CPUs.
> 
> If you want to try different settings, please read:
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/tree/Documentation/core-api/workqueue.rst?h=affinity-scopes-v1&id=e8f3505e69a526cc5fe40a4da5d443b7f9231016#n350

Thanks for the CC; my colleague tried out your patches (ported to 5.15
with some minor difficulty), and aside from some crashes (already noted
by others, although we didn't pull the proposed v2 fixes), he didn't
notice a significant change in performance on our particular test system
and WiFi-throughput workload. I don't think we expected a lot though,
per the discussion at:

https://lore.kernel.org/all/ZFvpJb9Dh0FCkLQA@google.com/

Brian
