Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17826A270C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 04:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBYDlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 22:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBYDk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:40:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C5688C8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:40:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ec43so4897287edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYlzXS6O2H/qnoN4QpI6Ir8Wr8FOKJQ0LdPDj4qFNbw=;
        b=XgrGHcsjD8lXdt+NU3BdqeLszj1cBLsQmLQ4vnPOiq+KgU/kc+x004DNcSCRsZR35i
         dlF2s1jAJR5lHW+W2aovLxh8pUCZMBZF/FkTxmw2tHlVMxnOTd8VJCTQNAIEE1hJz8M/
         b+lFTBnv03PMId15hHYAnAeoZAYArgGhCmXMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYlzXS6O2H/qnoN4QpI6Ir8Wr8FOKJQ0LdPDj4qFNbw=;
        b=vJmuqVNWLHzp0cXPMPE0rnM71KCWB2zD0FPz4LCQtkkcL/SMPFYwdDS2tI9oXDB+I7
         24EDvzqSRCZuztbzdodOmA7gNFGk+GB2lxOsq9Tg5vmJJ22basDfe877HNLf5xB9hT6Z
         xJP8MKaOY8Zu053Hr7ePvCqbHKL5JsmIgVq+XovWys+tjb3WHb3fT4Cc8uSO5+CXrYwH
         51VWCGQ3hgAqfgCsGa7/9hhIgnkut93RQ48u+yTf/puTIN7G9TLeKlquEj6hYZyX2mw2
         aNT8MTh+GGmxbxeeb/Q2i/Ut89TyGzXaAs7bgnR9kvpE9+EV/gtfq0VQN7qOhPSo1HHl
         aJgA==
X-Gm-Message-State: AO0yUKX0u7faT81yUkZGC7SGy8GUdUz/IO0tIEI24KeiOV5/hIq0RkSo
        3rI5Bs8FtTZVpPvuh0lLdYDA4nmbIdiSW7tnDeP9ZQ==
X-Google-Smtp-Source: AK7set/M7Ghom7jYebGGFvwK7GvCBuPibA8G9WXevQBohG55XOdgLNO2Exp3iHBtW8N0eMhCmcKpiA==
X-Received: by 2002:a17:906:a87:b0:878:955e:b4a4 with SMTP id y7-20020a1709060a8700b00878955eb4a4mr27024092ejf.33.1677296434399;
        Fri, 24 Feb 2023 19:40:34 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id bq7-20020a170906d0c700b008c5075f5331sm330677ejb.165.2023.02.24.19.40.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 19:40:34 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id cq23so5064962edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:40:33 -0800 (PST)
X-Received: by 2002:a50:aa9e:0:b0:4ac:b616:4ba9 with SMTP id
 q30-20020a50aa9e000000b004acb6164ba9mr8460933edc.5.1677296433597; Fri, 24 Feb
 2023 19:40:33 -0800 (PST)
MIME-Version: 1.0
References: <Y/gxyQA+yKJECwyp@ZenIV>
In-Reply-To: <Y/gxyQA+yKJECwyp@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 19:40:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkFyUQFwvFm78h1MXZJO8y+YqvhrDpNt6j4JFaRuGxyQ@mail.gmail.com>
Message-ID: <CAHk-=wgkFyUQFwvFm78h1MXZJO8y+YqvhrDpNt6j4JFaRuGxyQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git misc bits
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Thu, Feb 23, 2023 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

Ugh. And I just noticed that you broke my perfect run of "only pull
signed tags" this merge window.

Oh well. It's not like it's a disaster, but it's a bit sad.

My scripting currently reacts to pulling unsigned stuff only when it's
not coming from a kernel.org tree. I think I should just update my
scripts to always alert me.

I should have realized as I pulled those anyway, but I just didn't
think about it.

              Linus
