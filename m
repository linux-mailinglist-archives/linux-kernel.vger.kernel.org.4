Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935E96BF037
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCQRx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjCQRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:53:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1650EC889C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:53:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eh3so23417544edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679075595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvERMCVN4Wmso5JvL8vtaebl1nl7Lfcqf5asBd+56Jg=;
        b=BzvF7WQbmCzw6GI78Ue0kcZ8xlCFnyDVraL1PFRbW0TNtEG6lS0S1W1bOfrD7hwbTN
         jGTylJvBHGUf/9ap6WXxvc0cNlBuomQ1r/u2u7sT7B3p7V85HYvWwKqhDqC/j7h9eqHX
         AXcDoPGdr8n655cHzo1dn+MzHefrwVJdsvqmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvERMCVN4Wmso5JvL8vtaebl1nl7Lfcqf5asBd+56Jg=;
        b=KFv9DGQC5c18ZAPzEfzqISA3FFL60iLG/gz8sEqbo9WS92q84Da0UjYQApLZ9REgst
         ZSCT4j8DOphA0aS73CS5GsZz2L68wQHeh+hfUFBMuW2I3MZ6j85e+TAu9+51ZpRGV3uC
         D142OK4xz9mD7Uo2Cwkb3g8mtdJ+GVButf79/Djsb4PFiQGlnrXuk7drKzjgctjjDXv7
         FaPn7MlRxvnqyT5AzRwFzzvdXKdWRbFELOOojuocEam2vo77czFMtNQQ1CX9xaC2kJzX
         VdwS9Aa0erSLJt6/MLAR+DmFZK6oevXu1ZERorToTSFzh+yWKZT3iMd1WooMwXWsCJzK
         2lPA==
X-Gm-Message-State: AO0yUKWJ6rdw3npU1MabbyNAYS5lA+dMqXYoDX9p6QMTSQHKuL9vXJOj
        S8aYgEnUMR5Jh8W6QknQLMtwS47API7zfUeWgPtT5Q==
X-Google-Smtp-Source: AK7set9ztKKGIEwOF5HeFOSOKpKobnrCfDTQgOsgBmrCovLPbvHbCkcr7a8kNCnS4C1okShPG+2HEQ==
X-Received: by 2002:a17:906:d555:b0:8b1:7de3:cfaa with SMTP id cr21-20020a170906d55500b008b17de3cfaamr297481ejc.3.1679075595216;
        Fri, 17 Mar 2023 10:53:15 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id de16-20020a1709069bd000b0092b422c9d37sm1212050ejc.110.2023.03.17.10.53.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 10:53:13 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id fd5so23444134edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:53:13 -0700 (PDT)
X-Received: by 2002:a50:c009:0:b0:4fb:4a9f:eb95 with SMTP id
 r9-20020a50c009000000b004fb4a9feb95mr2205587edb.2.1679075592691; Fri, 17 Mar
 2023 10:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdKkJbY8WUhj43sFyboo985d1pQK-R41Xv38btRgWxro2RQ@mail.gmail.com>
In-Reply-To: <CAJvTdKkJbY8WUhj43sFyboo985d1pQK-R41Xv38btRgWxro2RQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 10:52:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZe7YUCEOt9S5bDLT2xf30Tx4V8bsSepsfrwt5vDUBgQ@mail.gmail.com>
Message-ID: <CAHk-=wgZe7YUCEOt9S5bDLT2xf30Tx4V8bsSepsfrwt5vDUBgQ@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat v2023.03.17
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 8:53=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
>
> "Keeping happy users happy since 2010."

What's this? You don't care about the sad ones and trying to make them
happy too?

              Linus
