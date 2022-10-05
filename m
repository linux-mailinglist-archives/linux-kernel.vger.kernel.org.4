Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE7B5F5B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiJEUnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJEUnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:43:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C693346218
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:43:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b2so266406eja.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uyg/xSbqc6YjfKAnVU7YGGT1j7ZqGbK/FQ9IaJudGs0=;
        b=nq4gFl8x3PDTHtMukRjR339j1Sh8DgsUtPjrpdzKDm4Fl/PRgKx2tgbu7Sft7nJqaO
         uhY2mZlejvrRmhurwx556klr/M/LpvX4cQKViM0I9GheMvEjbZkB13QZjwOkBtzoOB0J
         eEQsiRfS46Y4yNs3XRDBjieT5xl3bZ/FlPV29hgvxhJKYc6ZTb/fbRx+NjR/X7AuHFZH
         3nex9IJdP0xTjJeu0tEPed42MTUOkUCcUrxjLXIRR+tTvSWb1Tq13HilExXkc4nDOtcY
         lBRaiS8MqeNX1yjDtV/B4qkdpg6AGm2/o8xTQIJQhB36MPd62/CEtZ1JwKFH/yd5lQ83
         3pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uyg/xSbqc6YjfKAnVU7YGGT1j7ZqGbK/FQ9IaJudGs0=;
        b=KfvfZvQZQeKCU527YGFKhkGEJf9QeHFmOj0KkOWOmEjpig68BPp9L4ZEm0uIwExlUQ
         MbOl4A+N7vmmCVf5YiKOjNUj5EDonfuUgEdOHqG34uYmCMiKuis23eIa1TQ7QKDkRkSg
         zQl0GfvaopNgM1WTFy/aL+NYDnDL8sMwMQu4JqQdfIPE4SeWG94bjlHn/OoQK/1yxo38
         PA+A3YJAN0gpyN6u5tY4ikaNNi+jJbYiSfYMYWxi+1xPalnfLOE+je1GpKIc5SAL3a3i
         SgcoAHO1Ik+LhGR4C8AoOUzWuW/Joptxqbt8A8060iiEQ5D4Al17ZKHGEZmRLWxaMm5z
         H5KA==
X-Gm-Message-State: ACrzQf3e2Mrj0Aa0LDcAHz0iw04TKWoOM2KctUHOqerbc59PhPDb20iI
        g/BAAeaIM6/1EEEcOrEldZfQYPUJB5EvOcwcosaevg==
X-Google-Smtp-Source: AMsMyM6/Qo8zDvnM3qgpGGqrO5MPh9PzJ8Lb8zrsHZluGDFXq8f2wLT78LMvXO5kjUf5CX9lv2aoWTQeTGk5KahJtYg=
X-Received: by 2002:a17:906:6791:b0:78d:4051:969f with SMTP id
 q17-20020a170906679100b0078d4051969fmr349532ejp.171.1665002583274; Wed, 05
 Oct 2022 13:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220923050039.3371091-1-davidgow@google.com>
In-Reply-To: <20220923050039.3371091-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Oct 2022 16:42:52 -0400
Message-ID: <CAFd5g47Ne7+w36AbaZ9nvq0_yia4X_t6Ft64LAAtBgK5xROC3g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Don't download risc-v opensbi firmware with wget
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Xu Panda <xu.panda@zte.com.cn>,
        Greg KH <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
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

On Fri, Sep 23, 2022 at 1:01 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> When running a RISC-V test kernel under QEMU, we need an OpenSBI BIOS
> file. In the original QEMU support patchset, kunit_tool would optionally
> download this file from GitHub if it didn't exist, using wget.
>
> These days, it can usually be found in the distro's qemu-system-riscv
> package, and is located in /usr/share/qemu on all the distros I tried
> (Debian, Arch, OpenSUSE). Use this file, and thereby don't do any
> downloading in kunit_tool.
>
> In addition, we used to shell out to whatever 'wget' was in the path,
> which could have potentially been used to trick the developer into
> running another binary. By not using wget at all, we nicely sidestep
> this issue.
>
> Cc: Xu Panda <xu.panda@zte.com.cn>
> Fixes: 87c9c1631788 ("kunit: tool: add support for QEMU")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
