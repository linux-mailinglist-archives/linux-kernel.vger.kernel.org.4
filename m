Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FF70CFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjEWAw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjEWAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:52:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0062D58
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:45:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2537a79b9acso3040614a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684802668; x=1687394668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ohaTtJOaeTv+DUbIMaoQB65niNoQeGMvZ+rell6iqk=;
        b=Lh2t3iKMxSvClzmCWv9vggXg6qa912HRceMhmGZW22Nea0fZW/Q4GLwhOXlOvZlt8+
         svTRTl6rlknvFhR/Vb28ViINP9WwvZd/IjbY8vu685AtJGUVUZog1b3RQQM9orQ0WDtk
         dECpFw98w8XuJATQW2Y9dMfd+3Xoavt+3vGl6CQsk2BtDr0Qu2EJi01c1Oe3q75H7bHv
         1OGVaoV2JE/o0M/8bwm9TIGFYoE8GSL+GWN8OpYHBWW6QU2KiWyW6OLC9Dv0mIABSqSV
         wS7nO7w+CYB2CEx/D2V5zSOHVLL/c3SiyK87ySOtc86/ZhxG8Hlq6aUypkW0y1WTBXZy
         cQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684802668; x=1687394668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ohaTtJOaeTv+DUbIMaoQB65niNoQeGMvZ+rell6iqk=;
        b=SJvvxgjGIBd7uC6YwlLRpGPyP4YB6FhQEw+kMzRzFr0JBbr2xtBV+/ixK5Tap1/cAR
         6VCN65azJKz8EgU5vWNYHyHwNizf9kZs3ySuxIo6n+X8Q6f6GpYeGOzJSx22IxlKLjQ5
         OEfgFJbJmJtw/r5RhtMYPeKLLWhh8GS7wVx2yO1OazENFMzRaoiAXklRMg+XJjakbU01
         EOgi9Tv8vjbAm/17mQaaCLhxmm5Eb8drR+8Ft+/w1x8sfW4e/YWixZ9vsbopqhDhAYEW
         tL9RNHer+Dq1VQ2rlppJRWDwLQYe/TpDplWSF4fYN3++RsJLTCc9JhzTr0BDDxetqAk5
         89MQ==
X-Gm-Message-State: AC+VfDzOzHFfAcyYzU6qV5ZbFF0RuO6Ei6XbqzM2g39sv4Ssq/0XNFut
        S2x1UNSbvTDFT7Izor7LJQg=
X-Google-Smtp-Source: ACHHUZ7Z00JJe8o88wNi/jig565qsA7QD7/XTMHnzm4a67eYa0dAv7dLNOTRPHowJnhdhWSqEW9znQ==
X-Received: by 2002:a17:90a:d513:b0:24d:d377:d1 with SMTP id t19-20020a17090ad51300b0024dd37700d1mr12085705pju.45.1684802668474;
        Mon, 22 May 2023 17:44:28 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id lp4-20020a17090b4a8400b002555689006esm3048698pjb.47.2023.05.22.17.44.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 May 2023 17:44:28 -0700 (PDT)
Date:   Tue, 23 May 2023 08:52:26 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Sandeep Dhavale <dhavale@google.com>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH] erofs: use HIPRI by default if per-cpu kthreads are
 enabled
Message-ID: <20230523085226.00006933.zbestahu@gmail.com>
In-Reply-To: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
References: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 17:21:41 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> As Sandeep shown [1], high priority RT per-cpu kthreads are
> typically helpful for Android scenarios to minimize the scheduling
> latencies.
> 
> Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
> EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
> EROFS_FS_PCPU_KTHREAD.
> 
> Also clean up unneeded sched_set_normal().
> 
> [1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
> Cc: Sandeep Dhavale <dhavale@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/Kconfig | 1 +
>  fs/erofs/zdata.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 704fb59577e0..f259d92c9720 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -121,6 +121,7 @@ config EROFS_FS_PCPU_KTHREAD
>  config EROFS_FS_PCPU_KTHREAD_HIPRI
>  	bool "EROFS high priority per-CPU kthread workers"
>  	depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
> +	default y

How about removing this config option?

>  	help
>  	  This permits EROFS to configure per-CPU kthread workers to run
>  	  at higher priority.
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 92f3a01262cf..3ba505434f03 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -367,8 +367,6 @@ static struct kthread_worker *erofs_init_percpu_worker(int cpu)
>  		return worker;
>  	if (IS_ENABLED(CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI))
>  		sched_set_fifo_low(worker->task);
> -	else
> -		sched_set_normal(worker->task, 0);
>  	return worker;
>  }
>  

