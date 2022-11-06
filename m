Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D961E601
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 21:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiKFUwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 15:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKFUwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 15:52:07 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C743DFA3
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 12:52:05 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e15so6006483qts.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 12:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wNw+GsgSA3mDfmIGEJOC9tOk11FI7uIYw9klYw0CF7M=;
        b=Q41+LhBiBzlCTNELBASET72QJbokNOrSbpy+Wo8+R8WkrHaoPDp3eQ6+6YSogJgpk7
         CP2S400W+HrwrljY9MtTbPe4nfBTcnn+TF8pMFWf089FfqS/L40F9qOMdP5IUECgAUOv
         bThj5S0/7crEuzAg0WOPeKHqNdFI/pxkuWqd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNw+GsgSA3mDfmIGEJOC9tOk11FI7uIYw9klYw0CF7M=;
        b=rOqQahKjO9M6Pc2v3Uh+t6hWlIaIZah6to8xv6o09SLmFkHMjCPgnb5RMrQ+LsAdFQ
         rCpLB/evqmiB7SBxiHpuLGyi535tG+o9qDbM3tshzpEw2pi4TQDsCHnXb4pmsnf2vJlC
         0OnB4+tkEg0OPVZ6DBZeHre6Hsu4PXqTR5HapkvM4+NITIAK5ufyrrwF6cBywuy2bjRd
         bOaBadVHLULSEZaiLDe5M8NGp2BIVIvWZN/TwZqb3OJo39YbBHADUpih9J26/cfwh4BQ
         YpRjnL+jsTVO81UgI8GFJruSKhcMNq0zTvBg/1IQ58LJuG22TukqEDJ8xC25LUeILDQm
         8utA==
X-Gm-Message-State: ACrzQf2yraaMv0kT3WZoCepd3BdBB59FB+oAzitdHbEIzbZrjupLyJNM
        ylt9yaZ+UU6wsEtHFJHEXOIll3IS2kXxMw==
X-Google-Smtp-Source: AMsMyM6z2Dy5OjB+j/3oUT1ds4py+KOWNxf3Aa1xSy1D7QyyV+U/pjX4Ly2yhhSJpU2l2X+RA+nUFw==
X-Received: by 2002:ac8:5dce:0:b0:3a4:f665:453d with SMTP id e14-20020ac85dce000000b003a4f665453dmr37144361qtx.276.1667767924154;
        Sun, 06 Nov 2022 12:52:04 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 9-20020a370c09000000b006cfc9846594sm5074646qkm.93.2022.11.06.12.52.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 12:52:02 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-36ad4cf9132so87921377b3.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 12:52:02 -0800 (PST)
X-Received: by 2002:a0d:ef07:0:b0:373:5257:f897 with SMTP id
 y7-20020a0def07000000b003735257f897mr25572007ywe.401.1667767922482; Sun, 06
 Nov 2022 12:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20221106054535.709068702@goodmis.org> <20221106054649.099333291@goodmis.org>
In-Reply-To: <20221106054649.099333291@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Nov 2022 12:51:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com>
Message-ID: <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to timer_shutdown*()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
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

Thanks, this looks reasonable.

On Sat, Nov 5, 2022 at 10:46 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The coccinelle script:
>
> @@
> expression E;
> identifier ptr, timer, rfield, slab;

I think Julia suggested making 'ptr' be an expression too, and I think
she's right. Probably 'slab' should be too - there's no reason to
limit it to just one identifier.

>   ... when strict
>       when != ptr->timer.function = E;

I suspect any "ptr->timer" access anywhere between the
del_timer_sync() and the freeing should disable things.

Although hopefully there aren't any other odd cases than that one
"clear timer function by hand" one.

                   Linus
