Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61842620B55
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiKHIkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKHIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:40:09 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74D13CCD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 00:40:08 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id l15so8300579qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 00:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tFUsRL3FpgdBzxiQy/rXwlRUGlmMU62XkzHAixYMBY=;
        b=NwGnBeUnGEbCODcVAS0dQCsUGJN4Jektqzf73gf1SYCBHB7E3CdjypLJvuK1cjDomJ
         o0w3wNOqOSab+m/MWO/yLH6PIfj4XQBcdEXNjewoeMLhDEQhumbp4CE1YuRod3yUKTee
         Yqg17Pwa44sFMQ4cY18zfbvLD7CNhaiujAp4TAmA6Ycx8DJmPdIMiAFccwm6ACfc1Yty
         yAI8btZ2O3S60tM5kTKMHKNyicCt1NwSEBJEoXfBvVpv3XivrpPi1WdrN3VbaJcoe7gb
         eWCr43VJNA4giiJ3ISg6C9KLhgJ/E42GW6SYRRdWbQao3fldN5IqMF6yXIIZDSxSLoGn
         OVeA==
X-Gm-Message-State: ACrzQf2F0RvVppySXYdObshsqGUbW4gcLWiOkdtZrrDgzWK9DDEqSdDv
        rz0igzH7Vi7cfgqa3AGmGaETaxsj3oUX0DNk
X-Google-Smtp-Source: AMsMyM6+g4BGn1YqbKPMTPrmCewy60ihixdZDlk8t7XeqGPE/RDuWe2YAnigatHfasYE82yHfm+C0w==
X-Received: by 2002:ac8:5a8b:0:b0:3a5:75c2:46e9 with SMTP id c11-20020ac85a8b000000b003a575c246e9mr12871412qtc.229.1667896807008;
        Tue, 08 Nov 2022 00:40:07 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a449400b006faaf6dc55asm8569670qkp.22.2022.11.08.00.40.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 00:40:06 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 7so12012635ybp.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 00:40:05 -0800 (PST)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr41313897ybc.89.1667896805081; Tue, 08
 Nov 2022 00:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20221107141638.3790965-1-john.ogness@linutronix.de> <20221107141638.3790965-25-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-25-john.ogness@linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 09:39:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUEZ2pKM=RJu1NuVarsPSuOw1=R2E6OVQpeO0TqC2tMrA@mail.gmail.com>
Message-ID: <CAMuHMdUEZ2pKM=RJu1NuVarsPSuOw1=R2E6OVQpeO0TqC2tMrA@mail.gmail.com>
Subject: Re: [PATCH printk v3 24/40] tty: nfcon: use console_is_registered()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Mon, Nov 7, 2022 at 3:16 PM John Ogness <john.ogness@linutronix.de> wrote:
> Currently CON_ENABLED is being (mis)used to identify if the console
> has been registered. This is not reliable because it can be set even
> though registration failed or it can be unset, even though the console
> is registered.
>
> Instead, use console_is_registered().
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thanks for your patch!

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
