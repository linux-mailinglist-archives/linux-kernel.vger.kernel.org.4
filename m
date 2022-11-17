Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8568F62D4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiKQISv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiKQISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:18:47 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F416B15FC0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:18:43 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id x15so738361qvp.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwpyMGSESHvVxZeQSW3cOqgu6i5GkbRlc3ir09h31MM=;
        b=ni6+6kUAcZesDrCKHk+pgDKEDN4Ds/d9joAqMc7iwhLsWwRwsghq1+Mm6jBzk965zx
         34Iaug0nBSFvtao1qZ3gmKLoLJuSNWyoMjC/jokpYssqf6sAlJPwP2x90ND4v3nv5gQY
         Qs4Oez2Y8nS6L8vzQY0DdNt/qngis7t69GSAyOTPx1/glbalOfxpacgZU4kPEOkz+nPu
         RUwrddYxVjd6/AVT343AgWKhea7rDX08IHRvaTdYXfj2xfIz5EEE+iZpWxIQUe8b8A77
         fSAKlf1ME8WcGSVs6tL9yotUQMyIGWWwfcslClhzvo5A2jV0ts/LQl62KwOTEChtCrt+
         3VUQ==
X-Gm-Message-State: ANoB5pk6GFUpyt1r0xp1ktAXxmAoSAxKtIugB/CmbHqUOtbjghHEEMLb
        grK+N8hltYBtpOVHKv6+4ZfQ0er5JpyIpg==
X-Google-Smtp-Source: AA0mqf4r5KfWTwWLJN1iHIvuZA1JkEbeFrWS0WjTEZYLMVM9jBEwIK+i9jUFvSEuWgqkxr1i7C7IIA==
X-Received: by 2002:a05:6214:1552:b0:4b4:a0b0:2dd9 with SMTP id t18-20020a056214155200b004b4a0b02dd9mr1482258qvw.125.1668673122737;
        Thu, 17 Nov 2022 00:18:42 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c27-20020a05620a269b00b006ee8874f5fasm54180qkp.53.2022.11.17.00.18.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:18:41 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id f201so981449yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:18:41 -0800 (PST)
X-Received: by 2002:a25:9e84:0:b0:6de:6183:c5c3 with SMTP id
 p4-20020a259e84000000b006de6183c5c3mr1234957ybq.89.1668673120788; Thu, 17 Nov
 2022 00:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20221116162152.193147-1-john.ogness@linutronix.de> <20221116162152.193147-24-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-24-john.ogness@linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Nov 2022 09:18:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWEkrVJNdHsvM00a+97Vsk8VYvd_Mxa61GAcSi1gH8=uQ@mail.gmail.com>
Message-ID: <CAMuHMdWEkrVJNdHsvM00a+97Vsk8VYvd_Mxa61GAcSi1gH8=uQ@mail.gmail.com>
Subject: Re: [PATCH printk v5 23/40] tty: nfcon: use console_is_registered()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 5:22 PM John Ogness <john.ogness@linutronix.de> wrote:
> Currently CON_ENABLED is being (mis)used to identify if the console
> has been registered. This is not reliable because it can be set even
> though registration failed or it can be unset, even though the console
> is registered. Use console_is_registered() instead.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
