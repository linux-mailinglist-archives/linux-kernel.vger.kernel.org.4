Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2C69512D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjBMT5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjBMT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:57:42 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0171E1F1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:57:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so9911711wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dYztO7vF80n96p9Tj83zv3AWRa9e3rkgB5XW0QNnrn4=;
        b=cFKisWsMbd6AVTlfGRpgWTOT2uprAEUcEO/DB2DfZlr18RZuTeyk2i2cIOEygUn8HO
         KbV0AoiPF3XAjgE3vnfQjzq1fbYlJjyVH8KPUbfEcYfjUvVZbKessD4YHv36UTjhA9Ju
         54oe3FQmDrJb8UkAwd3QVski83Lasn4NkU5ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYztO7vF80n96p9Tj83zv3AWRa9e3rkgB5XW0QNnrn4=;
        b=n2pRjeNn++mEunUzWiO5CxauRJNSpNan5uOFB/WTP0WmCZpnBorfOU6l38TwuA0DBQ
         zLyTHkdpB9WQjyYPoPrx9e+PFl2vdHP9tYkh02j4tlSenPvVuXWGqbIFK8EwAdzEZFle
         SMigN6errp6MQI5ssELcuUKJnovhv2dsgTxJb7SJjok4CP+9QTmte4YvooAxcbMz+WIU
         332mPafK4mPpJHmmvBJcM35y+QCm+J1OhCnFwDD61NGXKGbwRs9/OILEzpT6Hjl5c2QL
         H6/VQI6DOuK5L3aCc+v1/XSLC4M+kxmbWS/GSWO9XW6CKBKOBgNdAFvGSUD+p1Xcw6pS
         u9AQ==
X-Gm-Message-State: AO0yUKXFLFE/VbPZMOx8w2sc4lhDPP7qtiHCbFXyJ/ctiDJM3ReNhnQj
        +PaBDJ5LmAu03Z0X4AuB530mSW1/VXLR6wV/MyE=
X-Google-Smtp-Source: AK7set9YJ+ajvbrEpYXzmEPnwCUErYN615Dyy6wNDZu97ylvyL2eZPJbjrErS0f9bo3RW8IeZ7Csrg==
X-Received: by 2002:a05:600c:4484:b0:3de:b1ec:7f95 with SMTP id e4-20020a05600c448400b003deb1ec7f95mr19305808wmo.18.1676318250100;
        Mon, 13 Feb 2023 11:57:30 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003dc47d458cdsm14078896wmg.15.2023.02.13.11.57.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 11:57:29 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id w3so7529897edc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:57:29 -0800 (PST)
X-Received: by 2002:a50:bb69:0:b0:4ab:3a49:68b9 with SMTP id
 y96-20020a50bb69000000b004ab3a4968b9mr4711581ede.5.1676318249137; Mon, 13 Feb
 2023 11:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20230213010020.1813-1-michael.christie@oracle.com> <20230213010020.1813-2-michael.christie@oracle.com>
In-Reply-To: <20230213010020.1813-2-michael.christie@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Feb 2023 11:57:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+q2KWMzw1XG_p8=taG1UaiiuUEeCJ4wmX+xrHi=CV6Q@mail.gmail.com>
Message-ID: <CAHk-=wg+q2KWMzw1XG_p8=taG1UaiiuUEeCJ4wmX+xrHi=CV6Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] kernel: Move kernel_clone_args's fn to new struct
To:     Mike Christie <michael.christie@oracle.com>
Cc:     brauner@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
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

On Sun, Feb 12, 2023 at 5:00 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> The next patches will add callouts to set the task's comm, and create
> internal resources. This adds a new struct to for these callouts to
> organize them and reduce the args passed into kernel_thread and
> create_io_thread.

This patch too seems to just make things more complicated for no reason.

When the point was to make things simpler, adding a (pointless)
indirection through another structure seems to be against the whole
idea.

The code is neither simpler not more legible. Quite the reverse.

            Linus
