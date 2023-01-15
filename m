Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0EC66B42B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjAOVcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjAOVcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:32:50 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCCF1631E;
        Sun, 15 Jan 2023 13:32:49 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id d62so12164473ybh.8;
        Sun, 15 Jan 2023 13:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilnTix6mWBqHe/oVeIQUIcilmxo7YfvSR3WJgS0DE/8=;
        b=SFyPWgR4h+zOq5TdDmqx2LprVCLFjPOI29OigwtuV054QFbGDVlmAqVxJzyOtUDDEw
         4BNX96ROEiX7dAKuCFcljAk++zJhr4qlayGktJmZ57rQH0xALjIF6MhvmRfZUgnDyaWQ
         gOsSDPAfnY35YkCRm+dewKvT5Y6mu1R5YMjGNy3CmyWpacHSyPbl6Ggm6TolidfSFvQs
         scPIaoUIFOH7hysEw3rN49PAKljIaggeNbjJWXJr++JaISClvx1v3ErGIGSaq4b9xhOg
         EIAgAr8opb08phMNndYMLBCqMYXBoejwCD4wZef3z7FyzKQaMMxOMtrjFPeWZCXq7pPr
         HuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilnTix6mWBqHe/oVeIQUIcilmxo7YfvSR3WJgS0DE/8=;
        b=oaNt55nFjlrVe6uAXZmSrbBb7V8pExD8L1L30/OK7g2qAUt/YI2pbsZUogk8hTaoga
         ieFB6fUGbDlEyjcR2Wh7JEJBkO2D+kq2hmDSFvLGq9i5SV+F4leJPgh0N2gldDC2iEm2
         yZwkzuxYnImyLbcYPqhqMe10mxMw01paTWe5oGkIHcomzkrjte7StWeoR4DNHtLi9+P8
         8uk4rfLvScB2t4sbyVzwgvc5S04cZNgsZG6CjzVFM0WzmpwWVwvGv9lVWpKbJiPDsHXE
         5suINhHYe8LyAAHssYed7JNpCZVzrfk+B3rp7rehi/nJ8ny/30h2sMlMKv9+ROqdro1N
         6Dxw==
X-Gm-Message-State: AFqh2koAycFilLBbNLAk6hsza9DitAlotLO66aZwFmxqGnIlnIrzv1Tf
        je8y6sclDyJzNrkANr3Ozz6RQYiq8s6pTtZAHjw=
X-Google-Smtp-Source: AMrXdXvDd4gzHGpiVTk6lJtkLc+geAyUAQIReeZNNBY4nWWmsZBoj8l5IYRODMerfaXfJGlYdOPs+eh7k2KY1ARJvSE=
X-Received: by 2002:a25:b78c:0:b0:7e1:ed59:4e43 with SMTP id
 n12-20020a25b78c000000b007e1ed594e43mr185418ybh.323.1673818369117; Sun, 15
 Jan 2023 13:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20230109135828.879136-1-mark.rutland@arm.com> <20230109135828.879136-2-mark.rutland@arm.com>
 <CANiq72kgmFYEO_EB_NxAF=S7VOf45KM7W3uwxxvftVErwfWzjg@mail.gmail.com>
 <Y77/qVgvaJidFpYt@FVFF77S0Q05N> <Y7/xKbOZYztcqz2b@FVFF77S0Q05N> <Y8FTXyKkI77nFIMJ@FVFF77S0Q05N>
In-Reply-To: <Y8FTXyKkI77nFIMJ@FVFF77S0Q05N>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 15 Jan 2023 22:32:38 +0100
Message-ID: <CANiq72kEow5hBBfzSL7=yihgU1Xm=DiKqeV7A8p8h_qW_f18cg@mail.gmail.com>
Subject: Re: [PATCH 1/8] Compiler attributes: GCC function alignment workarounds
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org, will@kernel.org
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

On Fri, Jan 13, 2023 at 1:49 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> It turns out that was a red herring; GCC is actually implicitly marking the
> abort() function as cold, and as Linux's implementation happened to be marked
> as weak I assumed that was the culprit.

That and your previous message probably explains probably why I
couldn't reproduce it.

Thanks a lot for all the details -- the `cold` issue is reproducible
since gcc 4.6 at least: https://godbolt.org/z/PoxazzT9T

The `abort` case appears to happen since gcc 8.1.

Cheers,
Miguel
