Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E406ED151
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjDXP3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjDXP3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:29:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A517A8B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:29:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b73203e0aso28624268b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682350154; x=1684942154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwQn07Y16iFJ4fshuTnIaJh3oxGufXQLZ+OStDTOBvc=;
        b=qj+9Aeezu+DWfQzh183d3LnXfkpkjGbb8LbFKZW74Pljo0ABwbW+lE+H3ZzdKu2qUp
         jgepbIB1GYA+d9N4QbIoXcLY2JvinxqyM+/uKBwv0Ka4d8J3F4eXjNXK7GdSQGdLBPp8
         ayhGn/h1NDCki+FdmK9+pO/BSUZak3/NXsm8owR1ZWo+cktWMyTfD6JBQaKoonH1gJUf
         8teEro+nBqg2zk9uqkuG0/y837t/mAyR+tLwmyyUrzyHoc8/fZd3yCNk00F+0Vwi9NMX
         x8M/IFJYJCjM9OPX1Gh8SJ9GzeUzzyDx5UgtlDvCo7n9TlQI1B4JAh0mXHq2jhE+Pxz1
         DHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682350154; x=1684942154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwQn07Y16iFJ4fshuTnIaJh3oxGufXQLZ+OStDTOBvc=;
        b=ImPoJBPfi9BakMpENjUTkIwaFdUVJgPn0BQic3+3+ZR11CLmkuRQk2vloqSlxQxTpH
         x3u3thtwQVhPy7pig/oBTsmrUBC6I+R82tchdDi1xFQYtaB1aka7OJVTeUgvyFG0Jvg/
         NUJminArujO6W+FFUlBYNx6TyUVpcTM8SiXjUijPu9Y+Zi+SZ8UopkrY2cVq9nUF4sVQ
         B/qoVyTRfM4xF9CTUiZt9799qoQZY62dCPZ8Mz8r2SvA4qI0h5TEqczH8iOl0DyoKK7m
         xKPjh0mT7IylctKsJodaOqpPwsmqXmiBN6lz6WbI2kJoh0wrD9Zk3UN8Uovqt8PE11ZG
         Xp9Q==
X-Gm-Message-State: AAQBX9dbLrDWpAB3QWVEcJnQmt59fSI4KRmnqOF23fJ7VI8X1JnHOrqH
        FKQWwUqLfEWBK5E4SRiP8Wo=
X-Google-Smtp-Source: AKy350a85rlM+Wj+fqdXCvALp7o+lUqNXORSVuEO3DfqJwtM4GyhYdB03YPTTTPxBsbdrPAnJ/uFyA==
X-Received: by 2002:a17:902:f355:b0:1a6:7ea8:9f4f with SMTP id q21-20020a170902f35500b001a67ea89f4fmr13498420ple.26.1682350153707;
        Mon, 24 Apr 2023 08:29:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902be1300b001a95680eecesm4047791pls.297.2023.04.24.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 08:29:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 24 Apr 2023 05:29:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 4/5] workqueue: Automatically mark CPU-hogging work items
 CPU_INTENSIVE
Message-ID: <ZEagR7GYUsPN46wm@slm.duckdns.org>
References: <20230418205159.724789-1-tj@kernel.org>
 <20230418205159.724789-5-tj@kernel.org>
 <CAJhGHyDWJAZj6AYKHpJvTPdRCZa7Yvi00x1n+AtRm1qa_2PmOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDWJAZj6AYKHpJvTPdRCZa7Yvi00x1n+AtRm1qa_2PmOw@mail.gmail.com>
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

Hello, Lai.

On Sun, Apr 23, 2023 at 11:23:28AM +0800, Lai Jiangshan wrote:
> wq_worker_stopping() and sched_submit_work() are only called from
> schedule() and are not called for other various kinds of scheduling,
> such as schedule_rtlock(), preempt_schedule_*(), __cond_resched().
> 
> A work item hogging CPU may not call the bare schedule().  To make
> the new wq_worker_stopping() works, it has to be added to other kinds
> of scheduling, IMO.

Yeah, you're right. The proposed code would work fine only on !preempt
kernels. I guess the right thing to do is splitting out the hook for
non-sleeping schedulers and adding them in those paths. I'll look into it.

Thanks for spotting the issue.

-- 
tejun
