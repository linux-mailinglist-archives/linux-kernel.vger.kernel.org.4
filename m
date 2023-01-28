Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC067F577
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjA1HWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjA1HWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:22:39 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5155A611FE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:22:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso9844046pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=czFnnNgiMNwVHtOu8IgfTLKpLnKZzktc8ilaRgu2SLg=;
        b=rovDaWkwW8WlO27xY4VUiD/aZvHiRLwNMSkQgtqLrdciFxOgTcudSDnJsAHv8KkLxM
         IAnDuY/G7Zk2eBOcEwZ4dSSR4S7SqRNPhOXVIeuR2KuGxz3GPH11K80oa3m3sB9julDh
         0kVpWxN77OH8NZ+232r6NuT0rax30rlki9uthNbNhsPIXeXaPZwqdtm4M8Nzxf0NBo6q
         JvM4BmrYy2mCnE1IDOTRRGJdt32xNJm8EJAv71R9ziUdwMVViRonZ/CwNnwgSNh56sSe
         /b+abh0GK/ep1OZuWPvg+XpA3mn9UTYYA0Uy6+F2cwgMyZK5SaPHggOyfQQuAg40k0Sd
         ZzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czFnnNgiMNwVHtOu8IgfTLKpLnKZzktc8ilaRgu2SLg=;
        b=pRByZQ1i57g9x3K3ARHOptPVXR1YmHDbLV3Xu+73BOquR84txRlOsrmN3uVj8JFEgP
         Ng0WHJKJs0Y27iIooISAsdwe9UmtGKVqzoV793tmk0Z5hcYXyCF5QCR0fRVG6DreTcCC
         Q+4HsAwvKKji/KZ3gzys8+sAUg54o4uxIguhCNohiYVx+XSZgGVOmDVkgiY+LRAUGlIQ
         ptFjShifHlwAutgXVk54D/8VmKn0nt9CECgcKXlY6jjln09AYw1KzJHmYfOnXsq1TbHN
         4nmaqYGIc5zk/Foea95Kef1jA9vN/VjNN0cPhcpxrRV7ZvAtC4hw3ju69ZQLSApAky2q
         aDkw==
X-Gm-Message-State: AO0yUKVdMm71dWwxyMRpmZM14aZKNRcJ9HwHaepYDRS0x+KcbyE/rtyT
        8rocl1QMYYwWdqiXvCRYQEqLJW2D/CZW4BMTCmK+Aw==
X-Google-Smtp-Source: AK7set+A9FRO1xMuryCPrO/4me6tixWO+0SFK14DctJNZ8/DouO/cwHk9Esb4rQBlA2SMC3R4VlaS3LaxZbOr1Eo4NM=
X-Received: by 2002:a17:90a:414a:b0:22c:1be3:1985 with SMTP id
 m10-20020a17090a414a00b0022c1be31985mr1312197pjg.192.1674890557793; Fri, 27
 Jan 2023 23:22:37 -0800 (PST)
MIME-Version: 1.0
References: <20230127225203.never.864-kees@kernel.org>
In-Reply-To: <20230127225203.never.864-kees@kernel.org>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Sat, 28 Jan 2023 08:22:26 +0100
Message-ID: <CABxcv=kKS8DW0SWL9FxzP6g4AVAis1P21H8d9JE1bAF7p=BugA@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77802: Bounds check regulator id against opmode
To:     Kees Cook <keescook@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kees,

On Fri, Jan 27, 2023 at 11:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> Explicitly bounds-check the id before accessing the opmode array. Seen
> with GCC 13:
>
> ../drivers/regulator/max77802-regulator.c: In function 'max77802_enable':
> ../drivers/regulator/max77802-regulator.c:217:29: warning: array subscript [0, 41] is outside array bounds of 'unsigned int[42]' [-Warray-bounds=]
>   217 |         if (max77802->opmode[id] == MAX77802_OFF_PWRREQ)
>       |             ~~~~~~~~~~~~~~~~^~~~
> ../drivers/regulator/max77802-regulator.c:62:22: note: while referencing 'opmode'
>    62 |         unsigned int opmode[MAX77802_REG_MAX];
>       |                      ^~~~~~
>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/regulator/max77802-regulator.c | 34 ++++++++++++++++++--------

The patch looks good to me.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
