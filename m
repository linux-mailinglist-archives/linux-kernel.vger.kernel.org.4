Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391E36636B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjAJBeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjAJBd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:33:58 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FC8395FA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:33:58 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e21so10376012ybb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 17:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bCQEHkZFU92catxkBEDSkllxhfGBYSOPJ6bS5OX+np4=;
        b=UL7JuP9Qd87W93pYEySBGGXP/+5qmGlzT4yaZBTwaELe4YUCPteNRNGqWjcBOqaHB8
         a7C2/rl1S6SS5Ie2sNWnfcszK6rVpC0/po53m5swA3G/l6V+7vWsJF57Gnwr/iqkNqv+
         PMBqLoOZf3EpNhSmN2sNYOzl9ciKkCPf/OQ8pvLU4vcbFlDAs0bYiTCI3Mm9S3wWtHpJ
         BKOMvpKZk1eoiRILLlWV8TXFRRYB3PqdPQuM0ANR7NtwBG0HrvpVqnFpUkH57ivZ6Fn7
         gRR5GQ6sJNufqc7C0RXdThcL0HDUOyMtyZj3DbDR9tYCmXT/98nFrSA6O+lM1W0DCSiI
         vPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCQEHkZFU92catxkBEDSkllxhfGBYSOPJ6bS5OX+np4=;
        b=yPqA3C6cz21Ok8L8sokgmW8q6oc/HHHiYhjyDh/3Bxyq6FGDnGWscftxUrdySIzR6N
         mnm3s4/tQBA5xECBlv4VIohUocU4U/y+7Gcp434jPtQ2Qnp7A9I2e52KLbbWIimbAzYU
         lSAj73934F8d1VT0YYFn55S4JZ4kK0+kb0OVF1ArgIfxgrt83uLj+zSuPFPPQEf+3OnU
         0ML8uf6vZDy3RcSoFwe8x4NBcREbwApHv/nggvr0A0OIMoMDFKWda7TLRToj/bQcZLXn
         co8mluJfIHWUKy7phv6BBNo3mNZkPD+iBQ6kJ3KXLZtLFkgzs3li/3VZJr6N1SG5D3ci
         Fo8A==
X-Gm-Message-State: AFqh2koulTeHaG94N/sn2ByuCugmcwQD3m7C0RTuBuDviXKqplom74dH
        UIWCqydL7FAkuR928UtlKKnDjVM07rfbD7uKRflE8iRvf6fHJShR
X-Google-Smtp-Source: AMrXdXt604IP28HQikzync7eCkkW92FMRQKCM1QxQopQ9ijz0R4RNvliZGAzq2BK311P684yj86ysH/o4zfSWu3r7ls=
X-Received: by 2002:a25:fc1:0:b0:7b9:66ba:4421 with SMTP id
 184-20020a250fc1000000b007b966ba4421mr1294503ybp.340.1673314437033; Mon, 09
 Jan 2023 17:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20230107080702.4907-1-hdanton@sina.com> <20230108222548.698721-1-kamatam@amazon.com>
 <20230108234917.5322-1-hdanton@sina.com>
In-Reply-To: <20230108234917.5322-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 9 Jan 2023 17:33:45 -0800
Message-ID: <CAJuCfpEWd6RtevMiUcv7RCH7rjadTMr7UYjJJiGw1ReNHtbJ0g@mail.gmail.com>
Subject: Re: another use-after-free in ep_remove_wait_queue()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Munehisa Kamata <kamatam@amazon.com>, hannes@cmpxchg.org,
        ebiggers@kernel.org, mengcc@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Jan 8, 2023 at 3:49 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On 8 Jan 2023 14:25:48 -0800 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> >
> > That patch survived the repro in my original post, however, the waker
> > (rmdir) was getting stuck until a file descriptor of the epoll instance or
> > the pressure file got closed. So, if the following modified repro runs
> > with the patch, the waker never returns (unless the sleeper gets killed)
> > while holding cgroup_mutex. This doesn't seem to be what you expected to
> > see with the patch, does it? Even wake_up_all() does not appear to empty
> > the queue, but wake_up_pollfree() does.
>
> Thanks for your testing. And the debugging completes.
>
> Mind sending a patch with wake_up_pollfree() folded?

I finally had some time to look into this issue. I don't think
delaying destruction in psi_trigger_destroy() because there are still
users of the trigger as Hillf suggested is a good way to go. Before
[1] correct trigger destruction was handled using a
psi_trigger.refcount. For some reason I thought it's not needed
anymore when we placed one-trigger-per-file restriction in that patch,
so I removed it. Obviously that was a wrong move, so I think the
cleanest way would be to bring back the refcounting. That way the last
user of the trigger (either psi_trigger_poll() or psi_fop_release())
will free the trigger.
I'll check once more to make sure I did not miss anything and if there
are no objections, will post a fix.

[1] https://lore.kernel.org/lkml/20220111232309.1786347-1-surenb@google.com/

Thanks,
Suren.

>
> Hillf
