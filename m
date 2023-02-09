Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9135691216
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBIU3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjBIU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:29:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF4B60E48;
        Thu,  9 Feb 2023 12:29:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r18so2314036wmq.5;
        Thu, 09 Feb 2023 12:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UPNm/W8PxgUL4xA1OhKhmSLOAIkT0NcEWitFuUcmvyc=;
        b=a7jCGjxK1TaQ77zgVNdaka8cXhi13O0lXMRvjtPkN+vs4AFnlasSrf+xqSJBq3u+L+
         7U8/lzl2266P1sDVqe279149XZeKK/BiInJNIzOdeGij1tPGeTqCh+ZADzqFNqrLkEAC
         W7MblnEj7EABNPfUP4qv2Xsch3FSQTydYX1aiKPwcAYOkbU44aSCI90EIsGs4Tv+1GTt
         nvhnhPRgZO1wsM4S68IAhIXhAvSg69B+d3snDMyyz6k7h5xXNxZ+gAPqapfB4AnW+t/1
         jxviJEviLqCCDGc4X5t/mz0vguppWIqnP9OX2z/P4TAG74uJQlBi5wx+zet1TXoZ2AdT
         rFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPNm/W8PxgUL4xA1OhKhmSLOAIkT0NcEWitFuUcmvyc=;
        b=IQ/DOgoLt1zpaBqgaeIpZ2Qs+spNLUG8KrIrMBkwpGazG1IMRz82nZ17vtbsz6ITgV
         CouwuyZGhgh5DXaU8167yH7PKzmrNlfQFAw0+Hf9iN57Th7v21EejP+F7ujjSDEa6OYk
         ROoqsAEvJIBR6l4WjV5uVJZv2OwOUHspVe5QgX3ODn7PyXxXys/oMr04RPf/HNXdGJjv
         l25HyvTyvjRXv/wWZ8sW0F65idQccJbHyKpJ0UQuQULOCE55wLmMUXaGQOf3BGjW0qsy
         o5wwbkZaz8s24zZOzIzL4n6yjS6uhL/cc0iUQ1l7m/PVz3y/9+Ki5JV7Tbngf3iDhBLl
         CJQw==
X-Gm-Message-State: AO0yUKX6XxsvgzizZsKxHzF5/J0Lif/xc3YSk4qzFIBM/sFO0P94ECwe
        lGawjzZVOjNZlplLzSI1HuS/CmsmCVJZNgXF5jk=
X-Google-Smtp-Source: AK7set8njhHhob1wZuTEaL4q0IK6UrzYb8Xm6VLSwMy3bPjJqee8WncwiAspTPyeEeorDchMroBvoM9L0gHqjLmsj/s=
X-Received: by 2002:a05:600c:45c6:b0:3da:fef7:218 with SMTP id
 s6-20020a05600c45c600b003dafef70218mr660225wmo.94.1675974588963; Thu, 09 Feb
 2023 12:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20230131144458.1980891-1-gregory.price@memverge.com> <20230131144458.1980891-2-gregory.price@memverge.com>
In-Reply-To: <20230131144458.1980891-2-gregory.price@memverge.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 9 Feb 2023 12:29:37 -0800
Message-ID: <CANaxB-zzbyQmj=o8tkRAgS6hCXr4JTuQTDMEsC5pj88JTgrLfg@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oleg@redhat.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 7:30 AM Gregory Price <gourry.memverge@gmail.com> wrote:
>
> Implement ptrace getter/setter interface for syscall user dispatch.
>
> These prctl settings are presently write-only, making it impossible to
> implement transparent checkpoint/restore via software like CRIU.
>
> 'on_dispatch' field is not exposed because it is a kernel-internal
> only field that cannot be 'true' when returning to userland.
>

Acked-by: Andrei Vagin <avagin@gmail.com>

> Signed-off-by: Gregory Price <gregory.price@memverge.com>

<snip>

> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index 195ae64a8c87..6d2f3b86f932 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -112,6 +112,15 @@ struct ptrace_rseq_configuration {
>         __u32 pad;
>  };
>
> +#define PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG 0x4210
> +#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211
> +struct syscall_user_dispatch_config {

nit: all structures in this header have the ptrace prefix. I think it
is better to add it to this one too.

> +       __u64 mode;
> +       __s8 *selector;
> +       __u64 offset;
> +       __u64 len;
> +};
> +
>  /*
>   * These values are stored in task->ptrace_message
>   * by ptrace_stop to describe the current syscall-stop.
