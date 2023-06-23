Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CAB73C4BD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjFWXWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjFWXWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:22:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9948B273D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:21:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9891c73e0fbso218811866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687562515; x=1690154515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1uwDrPmN/ty8ZrjSO5qsAzCUv8oUyMnm2iO9QZdsZIk=;
        b=Hqu+d2ih3jaLOoh7PyBBaEVojaUrMMYBGA2Rn776fOQSskIiUlc8yZNAJH+J/7o7qS
         Wd8e/Ra0+5/cWpD9FcU8WNUzPqh+3VvfuaKgrsuzarhnT+X1KHT0J2CGK05mE4iRL6+V
         9HO01lWIFbMXy/GPKG8XHYfCKV7bPq7uAaJXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687562515; x=1690154515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uwDrPmN/ty8ZrjSO5qsAzCUv8oUyMnm2iO9QZdsZIk=;
        b=O+TYvo/A+C8dpnpLmVZm+Z/chgUsoG57hAVm3REFLJuLQOhnCAcLsrH0RtEx9dRQvH
         slFWRJBJIOzBdrBZayJuoD8a9EGAFdSMqYtwpzam15pJsHV538LNkm4M4VsIAI3YvYVL
         Zm/xMhh5U6VE8WZlzPXlhTXeBub7CuT+WBZHpH5RQfsozbyRWjqBiFDhydl6650PFv6B
         NCFyz8/omZjvOrWlcPxZLusXuF2gXKalW+/YQr7LUf4spCraJi6XFb9mcQxpP8qO3Sh7
         jlvR2/OefFpWzmYg7i1/w/fVScojb3PLnyBDXJGVynkXZ6Ty4qC2TrVWfS6iYUgBqxOh
         4FPg==
X-Gm-Message-State: AC+VfDzdoAjFOnz3CkLfN+WQxp34zYAk2CqtO9Sc7fSsE9cnFBH7LaPH
        aAe4DZ9woQYeaCfo3gowCosaAC8pVYI8VzM2obYrsvV0
X-Google-Smtp-Source: ACHHUZ7K4g/PdWk6Jby9uqU6c37IfbhmXkirU2a80ZIr+zXr00YZMspLn6ubYYfRI1nm5YwdE++LJw==
X-Received: by 2002:a17:907:1c0b:b0:987:4b4a:916b with SMTP id nc11-20020a1709071c0b00b009874b4a916bmr21650831ejc.24.1687562514698;
        Fri, 23 Jun 2023 16:21:54 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906080200b0098503ba0db4sm188408ejd.149.2023.06.23.16.21.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 16:21:54 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so517368a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:21:53 -0700 (PDT)
X-Received: by 2002:a05:6402:b04:b0:51d:7f9f:4b56 with SMTP id
 bm4-20020a0564020b0400b0051d7f9f4b56mr52877edb.9.1687562513692; Fri, 23 Jun
 2023 16:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230623152926.128aa568@gandalf.local.home>
In-Reply-To: <20230623152926.128aa568@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 16:21:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmnhEY6s1USY+hHX5+31orf7U_TxXvx+Y89xhL-Ydvzg@mail.gmail.com>
Message-ID: <CAHk-=whmnhEY6s1USY+hHX5+31orf7U_TxXvx+Y89xhL-Ydvzg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: user_event fix for 6.4
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 at 12:29, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Before user events become an ABI, fix the return value of the write
> operation when tracing is disabled. It should not return an error, but
> simply report it wrote zero bytes. Just like any other write operation
> that doesn't write data but does not "fail".

This makes no sense.

A write() returning 0 means "Disk full". It's most definitely an
error, and a failure.

But zero is not a particularly _good_ failure code. At least not
unless your tracing disk is full. Is it?

If tracing is disabled, and you write something to it, I would expect
to get a valid and reasonable error code back. Something like EINVAL
or EIO or something to show "you did something wrong".

I do not at all understand the sentence

   "When user_events are disabled, its write operation should return zero"

as an "explanation" for this, and my immediate reaction is "Really?
Why? That makes no sense".

                  Linus
