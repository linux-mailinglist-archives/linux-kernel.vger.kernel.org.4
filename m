Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA572CD44
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjFLRyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjFLRy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:54:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D30510E7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:54:13 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-543ae6ce8d1so3193170a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686592453; x=1689184453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyB2HATrYe07EZyc2MwF8RbLQn+UFgKmybbWs9IGAwU=;
        b=MywNV8fXHWlAfDdphSSsN0f4MvLWc/0kHWE8dxMLiZxkJpjRJopoFLoiugeDzOVyoA
         Jb+4YLDxBH4R7sOPubDpy/zC0pBC3fntcZBvZV3NpqGTi40BKjNdSjNzlNEQzQIpvovW
         CB6xZaqfU4IrOddgVEn8QSfbpCP8230BKbOhhQ9Gi58cTcxcqhNZ5Zp/N32eIaJK817X
         8h5A2xwYoOlg8TY8CfC1K33aD/PqJOobF3kVxBC7INCcFnqz3e9wNNyHkeaI/kSMwDoi
         Sj2zRkfrSImmLnb5UiYie6xT56qOYxa2ZRwap5HG6x5w+oEmtltFv1BA2/q+g0rgz5BG
         nk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592453; x=1689184453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyB2HATrYe07EZyc2MwF8RbLQn+UFgKmybbWs9IGAwU=;
        b=UxDcDy8xpgCcUHRpPbqYLnA9MkB3pbyTWPJiZh+UxLYgpbhK9fYZ02kDQI6qDfV94t
         aDXe/RTW25Trf/XlQGNtewS6StBt9CStnq1I+vKy+8CJZ8MNlx/W7av7/wtjS8kixF/g
         40nybC0+bHEyVmFszVUZFwnOZ7KS/yC2OxxN6XZTU7T6Typ5Tmw6k3VBVynWNYBigQ50
         xJy6egUHmX9IE3MmpHCYrErWBAmY+01JyhbcgU/r/M4Zdj0WtJia/1toAf4koF9Qzd6k
         SkNQHaXzCojxchfQkR1vWpZhW2fHI/Vwd7wK2tiJVvcx5utQ/5PgQ7NPhBuavkgmmZd1
         o3ng==
X-Gm-Message-State: AC+VfDzZpM7CH5w59UQ5Li9L1kYExu7zSC99Itr0pORTfqd/KcOALgzS
        PEIuHDI8wWBQOKf8xWFC83c=
X-Google-Smtp-Source: ACHHUZ5QY3+5a49J28P27Uzg4dWqLSU9/jmW7TJ8NLPRztzUuecnMUPUkbrnKunlRzN7YKwCJJRcqA==
X-Received: by 2002:a17:902:ea01:b0:1ac:4735:45d7 with SMTP id s1-20020a170902ea0100b001ac473545d7mr8990405plg.6.1686592452544;
        Mon, 12 Jun 2023 10:54:12 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b00198d7b52eefsm8488904plh.257.2023.06.12.10.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:54:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Jun 2023 07:54:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yuanhan Zhang <zyhtheonly@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        pmladek@suse.com, zyhtheonly@yeah.net, zwp10758@gmail.com,
        tiozhang@didiglobal.com, fuyuanli@didiglobal.com
Subject: Re: [PATCH] workqueue: introduce queue_work_cpumask to queue work
 onto a given cpumask
Message-ID: <ZIdbyOBdU6zAGxVw@slm.duckdns.org>
References: <20230606093135.GA9077@didi-ThinkCentre-M930t-N000>
 <ZIJbvCcaqjzNteWs@slm.duckdns.org>
 <CAEQmJ=gYe=d53HHC1xW_epmPmmddA4J28SHybwGmQzUZgxZovg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEQmJ=gYe=d53HHC1xW_epmPmmddA4J28SHybwGmQzUZgxZovg@mail.gmail.com>
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

On Fri, Jun 09, 2023 at 02:28:19PM +0800, Yuanhan Zhang wrote:
> // I resend this to put it into the same thread, sorry for the confusion.

This got resent quite a few times and I don't know which one to reply to.
Just picking the one which seems like the latest.

> > Can you elaborate the intended use cases?
> 
> Thanks for your reply! Please let me use myself as an example to explain this.
> 
> In my scenario, I have 7 cpus on my machine (actually it is uma, so
> queue_work_node
> or using UNBOUND do not works for me), and for some unlucky reasons
> there are always some irqs running on cpu 0 and cpu 6, since I'm using arm64
> with irqs tuning into FIFO threads, those threaded irqs are always running on
> cpu 0 and 6 too (for affinity). And this would not be fixed easily in
> short terms :(
> 
> So in order to help async init for better boot times for my devices,
> I'd like to prevent
> works from running on cpu 0 and 6. With queue_work_cpumask(), it would be simply
> done by:
> 
> ...
> cpumask_clear_cpu(0, cpumask);  // actually I use sysfs to parse my cpumask
> cpumask_clear_cpu(6, cpumask);
> queue_work_cpumask(cpumask, my_wq, &my_work->work);
> ...

But this would require explicit code customization on every call site which
doesn't seem ideal given that this is to work around something which is tied
to the specific hardware.

Wouldn't it be better to add a kernel parameter to further constrain
wq_unbound_cpumask? Right now, on boot, it's only determined by isolcpus but
it shouldn't be difficult to add a workqueue parameter to further constrain
it.

Thanks.

-- 
tejun
