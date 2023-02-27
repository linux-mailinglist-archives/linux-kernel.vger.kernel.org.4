Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD286A46A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjB0QDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjB0QDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:03:08 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66AC10401;
        Mon, 27 Feb 2023 08:03:06 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r40so4534231oiw.0;
        Mon, 27 Feb 2023 08:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wY4yELjMWXO6awZMb6iksWCV1+Ua72vr+LoFoZrRcNI=;
        b=Wu3M9Zzms7rB+HEmXw3QF/BbTf2J61E3ygv1I2NPKXWhU6GPjWdanJRLwrjvilBLtU
         Rr8pPHsfmuakydNlSkNpVsV/OXdx2qHJ98oo9UESdwofNhVwqDETfHpqTA+jL2rtvnQG
         ZL998qqpyJrLAoI46/gpTPTnGtU+40Ns+snV3S5UBbW6aVmPmmLKEACAkLdFMitVI2cT
         UaEAwGzxJggo1BVFPXSvwqr46NrRtzIZBcy8vTLvlECpchuvDpQXu3vpE5ijN0BPajb2
         Bbnb3z0e0tk0KFw1w8RcqiM1bmvFixkVsAgTMVXokc61gDDiFFi+Np/z/s8u+dKHu2vU
         h5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wY4yELjMWXO6awZMb6iksWCV1+Ua72vr+LoFoZrRcNI=;
        b=sUXLyXQXcQqSEC4WAHzEKZSBCcyf3QxduvpLfHQkSrcatedqgDgyPyxkMyL9c7dKqF
         Mn/F2brmvNyeYv5GO8y2Hu8Z0mHbA2l46tZUgAg9tUKK6Xx90YwXr8PTdnNqfRVG5DTW
         ytAh0DUMH/UkIXtkYBgNgrheDYLOmUusgxooE7F2ls1tyKQUtr4quS2/UREBH37YKlUp
         vroYB74yJSZaq16+5j3KlvRSv1Ozk3BjP36PHD6l9af7wE5y4LeAw4owGKuUDyg0nNd3
         iKJkEocpl0dZcAy19vk+AVwFYSA37B+KdPed0l5wDyfwG5O06aERr5eq3K0S7ss6gZ4Q
         SoEg==
X-Gm-Message-State: AO0yUKX2Mq8gHpCirfPAerKeGPbQ2N9l1XWDYMEM1eL5tetoyKMJTzQm
        dJn9uZTsWVTUpYfwdDAU6KDAz1tPI4j++kGMpns=
X-Google-Smtp-Source: AK7set+ZmrR7I1biQluOEJBEn/C6gMWC4qCxUJpYC9xBJ6krD3818J7krK8txkEnXTIjVNWC1IBCWAlO2i4xZ5YiQm0=
X-Received: by 2002:a05:6808:d49:b0:37f:a2ad:6718 with SMTP id
 w9-20020a0568080d4900b0037fa2ad6718mr4518935oik.3.1677513786148; Mon, 27 Feb
 2023 08:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20230224233126.1936-1-gregory.price@memverge.com> <20230224233126.1936-3-gregory.price@memverge.com>
In-Reply-To: <20230224233126.1936-3-gregory.price@memverge.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Mon, 27 Feb 2023 16:02:54 +0000
Message-ID: <CAJwJo6YnELNhU8RmR-z37vDZ=xb0CmUUBgrPGgHP2dqjVm=O2g@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gragory,

On Fri, 24 Feb 2023 at 23:40, Gregory Price <gourry.memverge@gmail.com> wrote:
>
> Implement ptrace getter/setter interface for syscall user dispatch.
>
> These prctl settings are presently write-only, making it impossible to
> implement transparent checkpoint/restore via software like CRIU.
>
> 'on_dispatch' field is not exposed because it is a kernel-internal
> only field that cannot be 'true' when returning to userland.
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
[..]
> +int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
> +                                    void __user *data)
> +{
> +       int rc;
> +       struct ptrace_sud_config cfg;
> +
> +       if (size != sizeof(struct ptrace_sud_config))
> +               return -EINVAL;
> +
> +       if (copy_from_user(&cfg, data, sizeof(struct ptrace_sud_config)))
> +               return -EFAULT;

It seems that the tool you want here would be copy_struct_from_user(),
which is designed for extendable syscalls.

Thanks,
             Dmitry
