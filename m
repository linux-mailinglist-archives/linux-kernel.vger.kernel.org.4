Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7642C642907
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiLENOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiLENOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:14:02 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE9D132;
        Mon,  5 Dec 2022 05:14:01 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id e18so8160475qvs.1;
        Mon, 05 Dec 2022 05:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JCSTPwGV8OAXCug3QnDBPm3zXv9tZlARCqDy61HFGi0=;
        b=E7gbu1LvMyZIRCnVhLV53Ryh5udwwN2TZjwaV/3o0iLzMAJNjI8LVR6y2Q6KJL5Ieh
         4dMApO3I7G/9EHy+D8oG/X62yYlmWuWvxZ1EiXCgMjs1ypXKV+Hh5IqpnrGFMVMMQ7ck
         s7idnPmnYqOD/Rt4n31hqI072Tdqtr5gW+rGOi58wiUMnI3Xjl1GggJvkFA1L6rJeCVZ
         BheJaxUnyYga+9eDBm8LQRlW3Jo73Ly0QfrQNxeUtq9MqzGHmc8ueERhCD5N4b9QChEQ
         rrJv6PmzD5zr2EEXIJFbfcYIFhMI6Q+LO4MfuSoJnSqRNWg3uAtSRdo4QgR1BFH8wzEV
         68kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCSTPwGV8OAXCug3QnDBPm3zXv9tZlARCqDy61HFGi0=;
        b=xAEunCCaf9VbWQZlkU9MOGVk7vBUVtv3nSmbTFOCWyEgeOUgMTX8DqZ9z3xqq48Gn+
         m8nXAl4gNhDxZXhVybGtSaum3Y+szZfb4Mi9WtZV+WnHNy/ZBCn00XLvCpzsTF18EJPw
         nCd9rRnPPM1OaC8wZn2JVHp1myFvECvetel5umETMSZjtb9qIj8wTuVXj2tHTW1qGZDv
         CPe5n+F8CEwrbwgODQEOU5Y2nX1mZHvwX3dxfLSEy7nySRdmm6QzDEKHPi4ekmU+Lkd7
         wrBEC74cRF9D9nkjBoOYM4xDlHJkcjmMd5bKg79OTwDN3xyqT5lDGV/xoW9Rf0//DV8A
         MrpA==
X-Gm-Message-State: ANoB5pkatBk7d2R+R52BNvU01xGRbLtSJvAi3uGeE2pvm9S5moyMpYXE
        SCFrwu6cpVKrzmUPR1gc+A+feVfKHpP7qlIiuyk=
X-Google-Smtp-Source: AA0mqf6b30lUrz9VODmoS6ytEhykCwbmIPtoYRuxo6Bguic2qF/nyCjv6tphJKS9fmu9uPnKNBv8NtNDa6D3bq7Rm/Q=
X-Received: by 2002:ad4:57aa:0:b0:4c6:f83c:4741 with SMTP id
 g10-20020ad457aa000000b004c6f83c4741mr36552859qvx.11.1670246040341; Mon, 05
 Dec 2022 05:14:00 -0800 (PST)
MIME-Version: 1.0
References: <202212051942082259437@zte.com.cn>
In-Reply-To: <202212051942082259437@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Dec 2022 15:13:24 +0200
Message-ID: <CAHp75Vc-gMuv=HpiF-LURrpy+0MDiQUe0hVv24pRezhQg2E-Lw@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] x86/platform/uv: use strscpy to instead of strncpy()
To:     yang.yang29@zte.com.cn
Cc:     steve.wahl@hpe.com, mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, dvhart@infradead.org, andy@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
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

On Mon, Dec 5, 2022 at 1:42 PM <yang.yang29@zte.com.cn> wrote:
>
> From: Xu Panda <xu.panda@zte.com.cn>

Thank you for an update, my comments below.

> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
> ---
> change for v2
>  - fix the mistake and make the code better and simpler,
> thanks to Andy Shevchenko.
> ---

This is (the changelog) in the wrong place.

> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>

> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

No, I haven't given you this tag, sorry. The changelog is enough to give credit.

...

>         char arg[ACTION_LEN], *p;
>
>         /* (remove possible '\n') */
> -       strncpy(arg, val, ACTION_LEN - 1);
> -       arg[ACTION_LEN - 1] = '\0';
> -       p = strchr(arg, '\n');
> -       if (p)
> -               *p = '\0';
> +       strscpy(arg, val, strnchrnul(val, ACTION_LEN, '\n') - val);

And even better is to replace ACTION_LEN by sizeof(arg).

-- 
With Best Regards,
Andy Shevchenko
