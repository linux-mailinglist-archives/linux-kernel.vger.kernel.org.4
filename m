Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B31E7408D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 05:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjF1DMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 23:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjF1DMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 23:12:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1E1FCD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 20:12:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id af79cd13be357-7672303c831so2180485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 20:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687921964; x=1690513964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQFnqlRY9Ayf2Ahh0aPEKPTmp8m8k9EoLrFDTq688fk=;
        b=IBuDEKo0D1Uh11I4ooWMUIDiV8ZzO5Flc5tZkjkJkAKLGU/yzN2xTfWq63KS1o7r0C
         PDBN8XAN2S6t4ZZmiSPsrocNwTbK8+a46yK+DILkAEaTO31rtUtlV9s93UsXx3tf6jvA
         /QMtM8Fr8g90GmrLAV5k/Ix8jcVx33aokTC0jgEncoMNL72bDrqtLRMqONKXZAqW1H5C
         L8FSSXmdrIu2znrR8gLKexhUwr28BxhONrTuqCTtofMcvKrhk2/NH3dyAxRDll3nU8+5
         UPl7ldCVr5htvDi/xyupH8Pzlbv21uRekyRTSQLqGiCPm6sSsu7rYW70fVA2NU1kDyQR
         oADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687921964; x=1690513964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQFnqlRY9Ayf2Ahh0aPEKPTmp8m8k9EoLrFDTq688fk=;
        b=MsuyF8tgWZAOtwGx6kw1Z8Z1eli/q4SXsJjRqdUYzlfvgKPGYwUL8Df/USiNLkj651
         mUPeeaWvFzq2ZTBaBmnPw91rKfrr3aDO4wY8c6y+D17JENJ/SvBkPd+OvmPoPGfiZ1xN
         hjgA9Ku8FI9r2oGhSBhtRZ8sgTuxCpqweXztkn9b4DhxPITuvbHQeKhdtx9WxWekDGCR
         51yCnauOnc7EhHbxo+nLsXG8Tu24ncbqMjPHkIqLkn2xkBCR1azmNd/yNdWBq5eusxCk
         hjFs4cLiwyh9PdZpYgyPD8odDC6jBp3ipScDf43QajBW5OKc+sa5hwhABg/mTp0g+4bM
         qG1Q==
X-Gm-Message-State: AC+VfDxafbWrKT+GvSVGJ/pb5GnXZWTBS7AGnl4MhBdbQZyRweQpB85B
        20C57WMGo7heqiH5VQ+TSX8=
X-Google-Smtp-Source: ACHHUZ5fE+nCtAiS5q66CNGbWqtXaVbzNtYn8+AA48bsp+k/x/OKL3tSxED5z7ybqVa9a0kLIoIHhQ==
X-Received: by 2002:a05:620a:444f:b0:765:ad28:2c6f with SMTP id w15-20020a05620a444f00b00765ad282c6fmr9514662qkp.20.1687921964006;
        Tue, 27 Jun 2023 20:12:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id oj3-20020a17090b4d8300b0024e4f169931sm8574690pjb.2.2023.06.27.20.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 20:12:43 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     sunnanyong@huawei.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com,
        yang.yang29@zte.com.cn, xu.xin16@zte.com.cn
Subject: Re: [PATCH] mm/ksm: delete the redundant ksm_merging_pages interafce in proc
Date:   Wed, 28 Jun 2023 11:12:33 +0800
Message-Id: <20230628031233.9734-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627133542.2446285-1-sunnanyong@huawei.com>
References: <20230627133542.2446285-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Message-ID: <20230627133542.2446285-1-sunnanyong@huawei.com> (raw)
> 
> Since the ksm_merging_pages information already included in
> /proc/<pid>/ksm_stat, we can delete /proc/<pid>/ksm_merging_pages to
> make the directory more clean, and can save a little bit resources.

I think it's ok to remove it because this interface was not proposed for a long time.
I believe its users are not many yet. The earlier we delete it, the better.

The patch is good except some grammar issues.

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

> /proc/<pid>/ksm_stat, we can delete /proc/<pid>/ksm_merging_pages to
> make the directory more clean, and can save a little bit resources.
> 
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  Documentation/admin-guide/mm/ksm.rst              |  6 +++---
>  .../translations/zh_CN/admin-guide/mm/ksm.rst     |  4 ++--
>  fs/proc/base.c                                    | 15 ---------------
>  3 files changed, 5 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index 7626392fe82c..e668d4b5e800 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -208,9 +208,9 @@ several times, which are unprofitable memory consumed.
>  	process_profit =~ ksm_merging_pages * sizeof(page) -
>  			  ksm_rmap_items * sizeof(rmap_item).
>  
> -   where ksm_merging_pages is shown under the directory ``/proc/<pid>/``,
> -   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``. The process profit
> -   is also shown in ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
> +   where ksm_merging_pages and ksm_rmap_items is shown in the file

 is -> are

> +   ``/proc/<pid>/ksm_stat``. The process profit is also shown in
> +   ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
>  
>  From the perspective of application, a high ratio of ``ksm_rmap_items`` to
>  ``ksm_merging_pages`` means a bad madvise-applied policy, so developers or
> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/ksm.rst b/Documentation/translations/zh_CN/admin-guide/mm/ksm.rst
> index 0029c4fd2201..1662f271efc8 100644
> --- a/Documentation/translations/zh_CN/admin-guide/mm/ksm.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/ksm.rst
> @@ -167,8 +167,8 @@ KSM可以通过合并相同的页面来节省内存，但也会消耗额外的
>         process_profit =~ ksm_merging_pages * sizeof(page) -
>                           ksm_rmap_items * sizeof(rmap_item).
>  
> -   其中ksm_merging_pages显示在 ``/proc/<pid>/`` 目录下，而ksm_rmap_items
> -   显示在 ``/proc/<pid>/ksm_stat`` 。
> +   其中ksm_merging_pages、ksm_rmap_items显示在 ``/proc/<pid>/ksm_stat`` 文件中，收益
> +   值ksm_process_profit也显示在该文件中。
>  
>  从应用的角度来看， ``ksm_rmap_items`` 和 ``ksm_merging_pages`` 的高比例意
>  味着不好的madvise-applied策略，所以开发者或管理员必须重新考虑如何改变madvis策
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 05452c3b9872..173261dbeaea 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3186,19 +3186,6 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
>  #endif /* CONFIG_LIVEPATCH */
>  
>  #ifdef CONFIG_KSM
> -static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *ns,
> -				struct pid *pid, struct task_struct *task)
> -{
> -	struct mm_struct *mm;
> -
> -	mm = get_task_mm(task);
> -	if (mm) {
> -		seq_printf(m, "%lu\n", mm->ksm_merging_pages);
> -		mmput(mm);
> -	}
> -
> -	return 0;
> -}
>  static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>  				struct pid *pid, struct task_struct *task)
>  {
> @@ -3348,7 +3335,6 @@ static const struct pid_entry tgid_base_stuff[] = {
>  	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
>  #endif
>  #ifdef CONFIG_KSM
> -	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
>  	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
>  #endif
>  };
> @@ -3686,7 +3672,6 @@ static const struct pid_entry tid_base_stuff[] = {
>  	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
>  #endif
>  #ifdef CONFIG_KSM
> -	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
>  	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
>  #endif
>  };
> -- 
> 2.25.1
