Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4A688595
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjBBRht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBBRhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:37:46 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC8974A54
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:37:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so1916213pjp.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 09:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rT9lxIbE1aC6ouLgKeksCMpiSX53tsqaQ/chOF5F5DM=;
        b=SSF/D16aUlH8isttzJP7c9uokQeid1v6qga5ijrReEho6oTeTzHdpUI7qyx4TP2066
         FQ2Rmy9my5puz88apP1nVfqXbh5do5wpLLHxHmR+fBkQEVMMeC+XQFfLiUSicdWT6W4j
         Kw+iGwKbVmwRADA09uBTkGY9vwEs4tO6uVmeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rT9lxIbE1aC6ouLgKeksCMpiSX53tsqaQ/chOF5F5DM=;
        b=vdTPFQYqHKVf8Qu+gvNDt84kjTu9mDzZzft1JhNYEDU4jFlR+fWjC1veq9RZA3aZ/1
         DXElFqhYwrxv8AKjW2tY4w2WaW44pBRXEPEeJ+yCqnTTYXvA3uWEMTKA3v7UMllkwUe+
         cYrlHBXlJhFZLgWwjyn9BqrItSMTRznuBQU1T7w4OLkDmqwizZLlDlLvkk8L5aa+Ojfi
         At1SvoHGAkxjODwgJuspo1ZCzyfkHSic5YuS9/SPoqFAJgxW34EksRv0H1ojqDJEmVjc
         p19GeAe/E0sPZR1NX28hrWrNVdhYifnod+l4pFxrY+YoEcACVLsGGzuNRJ/Qn5YH6ysX
         2eBw==
X-Gm-Message-State: AO0yUKV3wGpSTdtzgV5yvvRLCp4HcX9gZCiZ2G/lvSis+MvqCQQygkOr
        yadprbdu9nKrCVKbBT8VUzhWObtzqbZcZZ68aIVevA==
X-Google-Smtp-Source: AK7set9jJjaTtddAE+vHzmZXbvQK5j0dCjR1vmVsYlKwkrY2TfxhEwHqMc5gioQc/nHfy1zMGj/DjeOsLtSOifxfOuU=
X-Received: by 2002:a17:90a:6c62:b0:22c:445b:d81 with SMTP id
 x89-20020a17090a6c6200b0022c445b0d81mr671030pjj.104.1675359464436; Thu, 02
 Feb 2023 09:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <20230201163420.1579014-2-revest@chromium.org>
 <Y9vPAdFBJF/gKXaO@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <Y9vPAdFBJF/gKXaO@FVFF77S0Q05N.cambridge.arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 2 Feb 2023 18:37:33 +0100
Message-ID: <CABRcYmLrYXuP-yio0dy4WskENn81Qw2WS0ArMp=rdHuiGyjYhQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 4:02 PM Mark Rutland <mark.rutland@arm.com> wrote:
> Looking at samples/ftrace/, as of this patch we have a few samples that are
> almost identical, modulo the function being traced, and some different register
> shuffling for arguments:
>
> * ftrace-direct.c and ftrace-direct-multi.c
> * ftrace-direct-modify.c and ftrace-direct-modify
>
> ... perhaps it would be better to just delete the !multi versions ?

The multi versions hook two functions and the !multi hook just one but
I agree that this granularity in coverage is probably just a
maintenance burden and doesn't help with much! :)
I'll delete the !multi in v2, as part of the patch 2 and patch 1 will
just migrate the selftest to use the multi API.
