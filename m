Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8A717096
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjE3WSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjE3WR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:17:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821CC126
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:17:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so5400069a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685485070; x=1688077070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5DUvOnBbNjICLS8rqmJBzZV+nxJEkq4dfwQCNKJREU=;
        b=UfeedNdeoLrVx4A/HM6fQhmzFaQnWlmLcx/7ycZv+F9FLOUPPvvWAyy+mvDqCyIbjW
         1V6GG20aa8VsCIlIyny1+5Cxnk2S+E34VwhES2uMpNt9uBP2s3uUyQVLwZ9nuz3B1PYQ
         NuMigSOVoEz9S3s7MLyMFb0Sce2wPUmkaBLuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685485070; x=1688077070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5DUvOnBbNjICLS8rqmJBzZV+nxJEkq4dfwQCNKJREU=;
        b=KjQA8tMpXRnYqk/ZGIy/G6rAehAjktNVZT802B2Zp1HLaphMucmqt7r4FhnYDo//Ak
         J1kIycyueghDrU1S8X3mosN3n8eb53+4FRX95SrvlT45Qmla/hkZoNeFAS90z+vLXTqS
         9qCPN2KB5I/t3Nf4EzeFZmjaPj5EOdyHSiNvu92vZ4b5OFMK/xyYKgD0dUah+cPKVOO1
         LSPax9hwSGW03VbC3Biq4iT/dv3rWSJU9MOmQQaKFpWARL1e6uh/XGdu2BuF8IfWlbzS
         hHlOGe7CntmBA+H6/xeteG1XJ4hwN9fxFbfejtjZ0KCtJrSct7Y+2hGlAVXJyvyqVT7k
         ZIQQ==
X-Gm-Message-State: AC+VfDxmfbkhZGiJ38slUZL1z3dLNrGTZrSgpirBNRYSi0lrZ8iilk17
        Z1Xyue7K7ivWsOW2Tbx635ifVMuQ0O/O2ImAOGqCp/va
X-Google-Smtp-Source: ACHHUZ7lu8rCrJtOsXLissVOcTNqJC7KmKx0pi7Ga181PQ63EB5C9s1zHBA2NVVjyJB6Ydl7zD93pQ==
X-Received: by 2002:a17:907:8a28:b0:94d:69e0:6098 with SMTP id sc40-20020a1709078a2800b0094d69e06098mr3652700ejc.45.1685485069886;
        Tue, 30 May 2023 15:17:49 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906244900b0096629607bb2sm7926229ejb.98.2023.05.30.15.17.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 15:17:49 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-30959c0dfd6so5205527f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:17:49 -0700 (PDT)
X-Received: by 2002:a17:906:7945:b0:965:6d21:48bc with SMTP id
 l5-20020a170906794500b009656d2148bcmr3770717ejo.75.1685485048586; Tue, 30 May
 2023 15:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org> <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com> <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com> <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org> <bav73qu5khl2dxkwpvy2hq34lyi56jn6yp7h5qlennka65kre3@zwwmrr55d2by>
 <ZHZRaFWvLEvkoCMA@bombadil.infradead.org>
In-Reply-To: <ZHZRaFWvLEvkoCMA@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 May 2023 18:17:11 -0400
X-Gmail-Original-Message-ID: <CAHk-=wicgDftP9ogSagxiRNvVTm7+YfQpEBuEsoRbkWzsw=EZw@mail.gmail.com>
Message-ID: <CAHk-=wicgDftP9ogSagxiRNvVTm7+YfQpEBuEsoRbkWzsw=EZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Johan Hovold <johan@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 3:41=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> OK thanks! So just to confirm, it seems fine to return the same error
> code if duplicates wait, or do you prefer for some reason for there to
> be an exception and return -EEXIST if the module did succeed in the
> duplicate case?

I think either should be fine, since either was possible before.

By definition, these are module loads being done in parallel, and so
any of them "could" have been the first, and returned success before.

And by extension, any of them could have been not first, and returned
-EEXIST if somebody else loaded the same module first.

So that "somebody else did a load" code:

        if (idempotent(&idem, file_inode(f))) {
                wait_for_completion(&idem.complete);
                return idem.ret;
        }

could certainly have made the return value be something like

        return idem.ret ? : -EEXIST;

instead of that "return idem.ret".

But it does seem simpler - and more in line with the conceptual
"loading the same module is an idempotent operation" of the patch -
to just always return the success value to all of them.

After all, they all did in some sense succeed to get that module
loaded, even if it was a communal effort, and some threads did more
than others...

As mentioned, I don't think it can matter either way, since any of the
callers might as well have been the successful one, and they would
basically have to act the same way regardless (ie "somebody else
succeeded" and "you succeeded" are basically equivalent return
values). If the module was a prerequisite for another module being
loaded, either -EEXIST or 0 _is_ a success case.

             Linus
