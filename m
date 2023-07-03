Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18484746512
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjGCVrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGCVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:47:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97D6E47
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:47:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b7e6512973so28058945ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688420854; x=1691012854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u32Z/SWamtdOM8Qcnx/uI6pLWNj9jKxCfyRf3bgUSd4=;
        b=ZxqYJCUuklhhLV13Ndq7M9tGyH3iTbwndOPgUxpAHGtGqTs6yGrGGnuRwNqvLRsr12
         t9TnkLuqzDvYJcxvHX7LQw6zdMPYK0yUo6O9gNtJO5y8cAYI3YN17f5FYWWMcsk78w9v
         QD1OqyaBMKXcOaEByIudAzx35je7VZhVhJ+nImyZJSfXn7c3X/UZF4x6vS8rmSbTKIci
         HG6r0Gn8cKa3v152mtc0bv+36GzbL4dbKVsl0ckPn124wccnaOszq+kpn2M0824V8gmk
         1/J5f+TcrIlRtkFraGVRmkQE6+im8S4df1K1QeMfbtevJkWaEfPedT+FOKl3HDwMILy2
         r3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688420854; x=1691012854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u32Z/SWamtdOM8Qcnx/uI6pLWNj9jKxCfyRf3bgUSd4=;
        b=cXZtxId3jbwRPT83Iq5Zd7tH7xUmlMiOs5MdPYv8ziRgveCh4Z2auhGOIQUKeVkAUJ
         LQ+G59HefOpxvKtSbmqtZvmjb6pMz2ipg2tsBkXT9npgmjjrAZxm0EuYfZZs9LuJBepb
         hHYIPmuulU5bHaDVYQYr+I7j0F3flmW1IDya+SOtZrr6RjrvYgZ7CztDIvOfMougWsFL
         SDQYeA4GJGac2uJ3/oyq3+QbYPjENAlQIiHqCD18bd+EK7yMST0noyUOixTafjvv0AuC
         oMHRroygaRKvBPTjS5UyDHqG9TDtCKqLxEiWzGowWf+H+XYpEDpYsUdxyVIspb9Wwves
         1P3g==
X-Gm-Message-State: ABy/qLarWg2z88NtrzVebd9leZk7kUHaWQqEvEjzeGRD5EiJSnwJ/fXm
        M2RuCUUaiLmm0RRWguhqFqE=
X-Google-Smtp-Source: APBJJlEVAdVG3NviapKfpZesjTPKw2czTBvNfkiI+IqMTbBt2OeSYR6UBEikfHtYvW1KDcMliKNhcg==
X-Received: by 2002:a17:903:228e:b0:1b8:5fb4:1c85 with SMTP id b14-20020a170903228e00b001b85fb41c85mr8605557plh.16.1688420854011;
        Mon, 03 Jul 2023 14:47:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b0b9])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902934200b001b1920cffd5sm15679675plp.267.2023.07.03.14.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:47:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 3 Jul 2023 11:47:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Norris <briannorris@chromium.org>,
        jiangshanlai@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, nhuck@google.com,
        agk@redhat.com, snitzer@kernel.org, void@manifault.com
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <ZKNB88I41b9DLw1t@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <ZIewlkGJJJUXPFL0@google.com>
 <ZIfY5zhhHU9IgOqx@slm.duckdns.org>
 <CAEXTbpconFReyAKxerNCQW5e51CMG=_RU9JHAquyEfSH1aqajA@mail.gmail.com>
 <ZJNMk9oSp1_IYXLU@slm.duckdns.org>
 <CAHk-=wgXoyxy99HnEFcvf+eUZAS5=ekWt_y84LC3P+0osxh6Jw@mail.gmail.com>
 <CAEXTbpcDS4SV=h41QKE_HkBhsmSa6Pe=63JtQZW8h2Fpc8Vo0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXTbpcDS4SV=h41QKE_HkBhsmSa6Pe=63JtQZW8h2Fpc8Vo0w@mail.gmail.com>
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

Hello, Pin-yen.

On Thu, Jun 29, 2023 at 05:49:27PM +0800, Pin-yen Lin wrote:
> > > I find that perplexing given that switching to a per-cpu workqueue remedies
> > > the situation quite a bit, which is how this patchset came to be. #3 is the
> > > same as per-cpu workqueue, so if you're seeing noticeably different
> > > performance numbers between #3 and per-cpu workqueue, there's something
> > > wrong with either the code or test setup.
> >
> In our case, per-cpu workqueue (removing WQ_UNBOUND) doesn't bring us
> better results. But given that pinning tasks to a single CPU core
> helps, we thought that the regression is related to the behavior of
> WQ_UNBOUND. Our findings are listed in [1].

I see.

> We already use WQ_SYSFS and the sysfs interface to pin the tasks, but
> thanks for the suggestion.

Yeah, I have no idea why there's such a drastic regression and the only way
to alleviate that is pinning the execution to a single CPU, which is also
different from other reports. It seems plausible that there are some
scheduling behavior changes and that's interacting negatively with power
saving but I'm sure that's the first thing you guys looked into.

From workqueue's POV, I'm afraid using WQ_SYSFS and pinning it as needed
seems like about what can be done for your specific case.

Thanks.

-- 
tejun
