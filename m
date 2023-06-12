Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048CF72D527
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbjFLXrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFLXrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:47:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE68D3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:47:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25bf6902882so940961a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686613640; x=1689205640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWh9DZ7JNAtNpX17CUlzUgnxqEqVKUVt17wNyTVgk7U=;
        b=mh62KYaIhX54gxKQBEA84fQptOqik2Nrlcs0XWMfo8rWSGUGdnyqQWnsXJpwxFUUmj
         WPjJR9oIxKuFjlVPI6LGnxFwDZCh9sqIcfMswRUIqRMX7YhrUPH1qEYJnTtZGak9LkOR
         1rbxXj4tPlQd8QLE14SDpXlB/EkstSaea7ZF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686613640; x=1689205640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWh9DZ7JNAtNpX17CUlzUgnxqEqVKUVt17wNyTVgk7U=;
        b=H5NHa+2ODVkrdDmnHGiJpYPiol9Q9oTU1gJq+LQuXHqfyLJVyaEVMwnyaOpgWL7Nti
         IapAhZfUVR8HKrSLiIQ4cTHdUzDLaZz7cjLYSR4jx/isuWD84yFEJrhP4a6m133HIqIY
         UtxhpG+9Xqx87jM1OTAwWVhkYEM0jQozvAuyccuo6PPnxmp9QqcaDJPBUKVHwroIXUGA
         hW4QJWtQd/r8kU69sCjQkDY2LGDaM3k+FcPBFRthMKN5Lg89rbbp0ZHfQ0+s6lx2hiSu
         zdFys2DNPlOdF/mVnoIEaiI+rulH7cZZLKcyccOozj7a2/qF+ae8zCGEX8CpTxKV54U9
         rk8A==
X-Gm-Message-State: AC+VfDyMM7jzcSxOMMe1tiIFCu/tMJmB6CLilhXhsMi1lJnSETq1YjHc
        5FWE1pN0xBXEg7tgwwJbKzuFug==
X-Google-Smtp-Source: ACHHUZ6S3uXqC10URUIxLfvyUJkV3JjJEA+SksA7trdtqV0rSStSAgODHAYpPSMlLu95aA8eqvTtwQ==
X-Received: by 2002:a17:90a:9109:b0:23f:9445:318e with SMTP id k9-20020a17090a910900b0023f9445318emr12274874pjo.3.1686613640044;
        Mon, 12 Jun 2023 16:47:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5666:8195:ab60:72b3])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902d88c00b001ac40488620sm8800152plz.92.2023.06.12.16.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 16:47:19 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:47:17 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Replace RX workqueues with kthreads
Message-ID: <ZIeuhU/vnoL1yWmQ@google.com>
References: <20230609103651.313194-1-treapking@chromium.org>
 <87o7lohq9e.fsf@kernel.org>
 <CAEXTbpdDsoghsxbJqszx0OWWw1o9D8p9f_9-4OgOM-a-w7OzSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXTbpdDsoghsxbJqszx0OWWw1o9D8p9f_9-4OgOM-a-w7OzSA@mail.gmail.com>
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

Thanks Pin-yen for most of the investigation here and for pushing the
patch. With some additional information though, I might suggest *not*
landing this patch at the moment. More details appended:

On Sat, Jun 10, 2023 at 01:41:51AM +0800, Pin-yen Lin wrote:
> I realized that I might have over-simplified the background and the
> impact of this patch...
> 
> The short answer to the question is that the throughput improved from
> 100 mbps to 180 mbps. The test was run on ChromeOS's v5.15 kernel
> fork. More detailed test setting is mentioned in [1].
> 
> However, the throughput of the same test case on our v4.19 kernel is
> 320 mbps. That is, we observed a 320 mbps --> 100 mbps regression when
> we tried to update the kernel version. This patch is more like a
> mitigation of the regression. It improves the throughput, even though
> it is still not as good as the older kernel.
> 
> That being said, this patch does improve the throughput, so we think
> this patch can be landed into the mainline kernel.
> 
> Best regards,
> Pin-yen
> 
> [1]: https://lore.kernel.org/all/ZFvpJb9Dh0FCkLQA@google.com/

I (we?) was optimistic this would be an improvement (or at least, no
worse) due to some of the reasoning at [1]. And, the work here is just a
single work item, queued repeatedly to the same unbound workqueue. So
conceptually, it shouldn't be much different than a kthread_worker,
except for scheduler details -- where again, we'd think this should be
an improvement, as the scheduler would now better track load for the
task (mwifiex RX) in question.

But additional testing on other mwifiex-based systems (RK3399 + PCIE
8997) showed the inverse: some throughput drops on similar benchmarks,
from 110 Mbps to 80 Mbps. (Frankly, both numbers are significantly below
where we might like...)

Considering we still don't have a full explanation for all the
performance differences we've been seeing (on either test platform), and
that at least one of our platforms showed a (smaller) regression, I
think we might want to do more research before committing to this.

Brian
