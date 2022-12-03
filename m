Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3382464169A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 13:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLCMQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 07:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLCMQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 07:16:20 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF092B255;
        Sat,  3 Dec 2022 04:16:19 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a27so8473946qtw.10;
        Sat, 03 Dec 2022 04:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h70TBke2aedZh5TRlzmm86xQSiyKUCTbsGye69uQbfc=;
        b=NIkPiX6SYMKIpWDkM71wQJEknqTrJzZw5L7HgIGRrU6NwirQ26wXQalq2Xj/4s2X4E
         WkaOsZHLQ/a9c28tYXVWMRo1G1EZwMlL1FY2LELfyp+yah/ejHprJMlyhp/QFD7nwKB/
         zMl3giAKCBMEEgSVfw2Hh7kmaDfGKHf7vBe4WZlI2XhNZjAUwS4tqypvzBz/LHNCD5EG
         Y4S/K1vfA5Vi3kDeJpFgCAr7tF7ql07N+7xF5lux5eFTDL6sabNmAj65pBDxkWMAIH02
         xhmck6ZkNslD7azACPIh0Y7ytwnRwA1EsWjvbkUNuN+aj99s9ECAJu383UYiKMoRgQvD
         89og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h70TBke2aedZh5TRlzmm86xQSiyKUCTbsGye69uQbfc=;
        b=wRBywX3dMNKR3zi1nf8+K3MseXzm/7r4Ikv3Ja+dO6iiqlifTSi5G5uG/4mEweccvv
         FukVHwSNlmLyOqsTCBw606coeMQoHfreBsdXpwuPTLABb0uv2hjifNFCzmh/Gx11yxKc
         lJIMDONat9RdOCMe1hO6zJ+VCe1GwOJKnFYiaxvSl5LDFjG9cKKFqBnIN/g0DBzkz0C1
         bT4rJen5n/MQcZn+D19VL22EfeqiMFfLjkGZJ12F3RwVri7A6USt8BWWqO5AKCXo0n51
         DFGZ86Hx+G+QumL0lxQZutUxqEqNcmlUbHdUj+esNeMu9Y6GUERdEN2rQ8liSjyGbmU1
         vRNA==
X-Gm-Message-State: ANoB5pl3GooVgyUNS8lY36XHOY5MtWg5tkmw2FqP+ZxDM2+LFpaqHt/Y
        ZsAD2COc0/8NQCMwUVGwla6pGW6Wizi/k9MOgIs=
X-Google-Smtp-Source: AA0mqf5dYkXi1ZQZe3/WFNLoLQJYSmQkNHK+zvh7h340dLM7xX6dcybpsQYVQ3oOikieiB33kLdUw/0/OzLlxVpmp04=
X-Received: by 2002:ac8:7eeb:0:b0:3a5:2615:5694 with SMTP id
 r11-20020ac87eeb000000b003a526155694mr53700676qtc.429.1670069778762; Sat, 03
 Dec 2022 04:16:18 -0800 (PST)
MIME-Version: 1.0
References: <202212031424175433783@zte.com.cn>
In-Reply-To: <202212031424175433783@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Dec 2022 14:15:42 +0200
Message-ID: <CAHp75Vch84NZhZa_Gy4qNO1-6ZJq3GBGmJXHSDurW5jeoYzhdQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] x86/platform/uv: use strscpy to instead of strncpy()
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

On Sat, Dec 3, 2022 at 8:24 AM <yang.yang29@zte.com.cn> wrote:

> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.

...

>         /* (remove possible '\n') */
> -       strncpy(arg, val, ACTION_LEN - 1);
> -       arg[ACTION_LEN - 1] = '\0';
> +       strscpy(arg, val, ACTION_LEN - 1);

Should be ACTION_LEN here, no?

>         p = strchr(arg, '\n');
>         if (p)
>                 *p = '\0';

Wouldn't be better to refactor this

p = strnchrnul(val, ACTION_LEN, '\n');
strscpy(arg, val, p - val);

?

-- 
With Best Regards,
Andy Shevchenko
