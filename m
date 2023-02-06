Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567BA68C2CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjBFQQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjBFQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:16:13 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD4513DDE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:15:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so18385869lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 08:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gaaFjZoa42Ja79jXUWSIIIkDl/uB+0HXTqjNFaP/4Tg=;
        b=PHXmHsjX/NlR5cDMN2RZXkRFI2ufJcL6W7Vdt00g//qPDvm0Ro9mRustABPxwIlsoI
         iYj03Nk1C2e7fP70gphUwsvAh6mPa87Z1tLjcubJHCeAJslgTFnHdzgEgo3Oz2O7gJeP
         4gRLHbLZh2629Wkou7J5BkkeWj+LlCUf8bVD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaaFjZoa42Ja79jXUWSIIIkDl/uB+0HXTqjNFaP/4Tg=;
        b=hUT3NEe3PizE2cyk95vfl1ewCq70iSB9RYQxcXRrypJXqOTIUNw7IBzLbS3QHbnhmb
         +n8V4KDMlc/CvEpTnxSUhhrrTauQw/ZgGDV4Ay1OA9TcT785Sl6KWIZr9XYh/Vf1ytsl
         UpNb3h1T4gB3hXppYRElI++bcI06ljhsf0OiHMFjBlL9mvRJTIjWRIqhC9+o8iAwpWvc
         qiTNO11exxj0kvsSvxz7U8DOL3PtntNYbnsYfwzdc2nX+e5JvQ9HN1+QxH/wWEkLu/DA
         n70o3xsXatLZZUfBmeBEoOoTa8xQgFPkViQi5aToCCK53LhEpKzOl6i7YtF3c7zLJngW
         tlEA==
X-Gm-Message-State: AO0yUKVxPv8HAlfs8iWKIAWiHDV82rXTCAQj7x1yyGB8HCFzBoCsYpAr
        Uuu5rfooElYldkd7gBw+wRUrrYijDDC5DvnU+2k=
X-Google-Smtp-Source: AK7set/TkUM3+6I032cDhh6umurubUbygYRUlCfc+T1yuDfj5l97juW2rwl9pmVBhVhFbh/TyIq7GQ==
X-Received: by 2002:a19:700a:0:b0:4a4:68b7:deb7 with SMTP id h10-20020a19700a000000b004a468b7deb7mr57486lfc.19.1675700141963;
        Mon, 06 Feb 2023 08:15:41 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id bi32-20020a0565120ea000b004cc82b70809sm805634lfb.150.2023.02.06.08.15.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 08:15:41 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id v17so18369511lfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 08:15:41 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr5133989eje.78.1675699644119; Mon, 06
 Feb 2023 08:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com> <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
In-Reply-To: <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Feb 2023 08:07:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=6amjgu3UiJX8HcNN9z-jqCRg=P=T4ZytFap2fgAdgw@mail.gmail.com>
Message-ID: <CAHk-=wg=6amjgu3UiJX8HcNN9z-jqCRg=P=T4ZytFap2fgAdgw@mail.gmail.com>
Subject: Re: [PATCH v4] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
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

On Mon, Feb 6, 2023 at 7:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> As for Linus' point about us needing to avoid sleep under RCU +
> spinlock, curious if we can capture *existing* bad users of that with
> Coccinelle SmPL.

Well, we have it dynamically with the "might_sleep()" debugging. But
that obviously only triggers if that is enabled and when those
particular paths are run.

It would be lovely to have a static checker for "sleep under spinlock
or in RCU" (or any of the other situations: preemption disabled either
explicitly or due to get_cpu() and similar).

But I suspect it would be quite hard to do.

               Linus
