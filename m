Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4967688C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjBCAnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:43:38 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507D36537A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:43:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bk15so11080377ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M5SZoZOf4A1Tqrq26h6hgOv78mY8qXAzROlOIKANtsE=;
        b=CHCoyYGBdRXOIoA+Jr7dkkawF4QVxNelCcER/Z8yLvuWU5rEVD95xnWe7+vQy9vp4e
         DVDx7Zc7ndN58VVIxRJWxoclMnG3zPJ1ArBwZ1jd+P3PGKG9+DBtYR0F7vIB30AJCHRo
         0LunAY9rQ0MfEk33PcW07KL6arMLZqus6t4zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5SZoZOf4A1Tqrq26h6hgOv78mY8qXAzROlOIKANtsE=;
        b=10e5/g+20QKL5jRrF4nEm+M5MTSo8Nh/XPm6vP93xnYkiFjVRVIx3GOpwFTxknnu4g
         sEnUalHD87ALWcZ6drmFRVfnHYRtSAI5qXSN4AW3u8jwUHOmTxJganszB7r6ltCesp7k
         po0vrMstUnqdItUGeU9sRmpgWdVVPfqrm+BbzrkOzRduhjwB0PI85+DpLNgfXrTcZeXf
         /QzlAUcbdc/tEQCce9tzbCdn1OXGLlkbhHL9C5tEiMeSz0w3Fq81w6nTtElDPqIKrsh1
         xjWraR59wjfp44mBq6JFOgWv3hGqai6pwvjNI0L5M1dPuoZNYVu/M+1Xrg/CPKHerFtR
         OK3w==
X-Gm-Message-State: AO0yUKUoT6RMJApibvAziB0b0c+gh20R67Zx0KvNKOm1ubHx7exxT7qC
        l9OaNxplOFVNRehb/YDiRnPgzTZeohk5C4lMd5uzCQ==
X-Google-Smtp-Source: AK7set+LDoKg1z23mEjuvZCU2Jyrd9j8Zr7ehDp9i+fLXzhtvuTST+hYeR1Dakyn/+K+VQ4tYPshCg==
X-Received: by 2002:a17:906:6d8e:b0:888:1613:49bc with SMTP id h14-20020a1709066d8e00b00888161349bcmr7462654ejt.48.1675385015519;
        Thu, 02 Feb 2023 16:43:35 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id ke28-20020a17090798fc00b0088991314edesm548009ejc.7.2023.02.02.16.43.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 16:43:34 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id hx15so11046368ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:43:34 -0800 (PST)
X-Received: by 2002:a17:906:4f98:b0:87b:d510:77a8 with SMTP id
 o24-20020a1709064f9800b0087bd51077a8mr2541345eju.235.1675385014409; Thu, 02
 Feb 2023 16:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com> <20230202232517.8695-7-michael.christie@oracle.com>
In-Reply-To: <20230202232517.8695-7-michael.christie@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2023 16:43:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEx+G7bwOj6MsHgpWavVkPAg6c1D1zcg4cgugg+ccrPQ@mail.gmail.com>
Message-ID: <CAHk-=wiEx+G7bwOj6MsHgpWavVkPAg6c1D1zcg4cgugg+ccrPQ@mail.gmail.com>
Subject: Re: [PATCH v11 6/8] vhost_task: Allow vhost layer to use copy_process
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 3:25 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> +/**
> + * vhost_task_start - start a vhost_task created with vhost_task_create
> + * @vtsk: vhost_task to wake up
> + * @namefmt: printf-style format string for the thread name
> + */
> +void vhost_task_start(struct vhost_task *vtsk, const char namefmt[], ...)
> +{
> +       char name[TASK_COMM_LEN];
> +       va_list args;
> +
> +       va_start(args, namefmt);
> +       vsnprintf(name, sizeof(name), namefmt, args);
> +       set_task_comm(vtsk->task, name);
> +       va_end(args);
> +
> +       wake_up_new_task(vtsk->task);
> +}

Ok, I like this more than what we do for the IO workers - they set
their own names themselves once they start running, rather than have
the creator do it like this.

At the same time, my reaction to this was "why do we need to go
through that temporary 'name[]' buffer at all?"

And I think this patch is very much correct to do so, because
"copy_thread()" has already exposed the new thread to the rest of the
world, even though it hasn't actually started running yet.

So I think this is all doing the right thing, and I like how it does
it better than what io_uring does, BUT...

It does make me think that maybe we should make that task name
handling part of copy_process(), and simply create the task name
before we need this careful set_task_comm() with a temporary buffer.

Because if we just did it in copy_process() before the new task has
been exposed anywhere,. we could just do it as

        if (args->name)
            vsnprintf(tsk->comm, TASK_COMM_LEN, "%s-%d", args->name, tsk->pid);

or something like that.

Not a big deal, it was just me reacting to this patch with "do we
really need set_task_comm() when we're creating the task?"

               Linus
