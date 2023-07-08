Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B233874BA84
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjGHAWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGHAWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:22:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA5110
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 17:22:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso40228761fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 17:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688775733; x=1691367733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ul3ss8VYJZdYxVGgDPid5ExlU80Na3C7GU2PntAs5rw=;
        b=FKbtV6TAQrzM9WeSgVb+UO0+3uOFVrJI/VNKohaV6tVFo/baSrw6HVuecfgW6aSjCZ
         iy4MAeQ3b2fqproXeT7z8Yx8tsViWa8H6i0TBHsYgbqryj3J/vIoER1zIFF1vrr9LDDA
         ohYHZM+/YnpcUA448/pC/RRxSOWLHzKDkBz7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688775733; x=1691367733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul3ss8VYJZdYxVGgDPid5ExlU80Na3C7GU2PntAs5rw=;
        b=awx90FpbvLELFdNvftUp4OK9okMMu+oghpZR7Ss2rdDVf8vKIWO6Y3TMAWpdZu05OV
         NYz8zpwr+FPTjGLJ9dYRGj2E6iCNTInRQ0IcH/YX298uUBBEfuFymVmc+SN3pASmqO0w
         Tee5rLRkZEo/K1RKI0ma0o2qJjaKuDe6v+2juhscm0YHOv0lmwrQg5IiWZuwhtGnvEsK
         YLcOIPjy1SKfxdeEe4bkJqZP7mGi3bhTZVze0Vgr1giaBGl/DmAWkntsNUFCxFbGa9pq
         YNoRaSojnJ6EB+VJPDBcJ2UaQBWJj8eLHEU8ABmk/8a4iL/N+JKKo1gaZHLIfohckJKt
         eCTQ==
X-Gm-Message-State: ABy/qLY9CZmW7kGI9ovaUY/xzZaw9tptdwNcfdGmfyIhdh//x9IjDdZN
        7qRCkyhA2BeKZ79oid6BiIUCtjaneC982mcjb40DjA==
X-Google-Smtp-Source: APBJJlEP0kr9EjOIhBy4IpQqtj9ZTmhmfVD4pP7IPF9ogoYm6VGA0P4qtHtjvQpquH7s4hw6y7MaGA==
X-Received: by 2002:a2e:8611:0:b0:2b6:daa3:f0af with SMTP id a17-20020a2e8611000000b002b6daa3f0afmr4849113lji.25.1688775732800;
        Fri, 07 Jul 2023 17:22:12 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id j23-20020a2e6e17000000b002b69f44646bsm999022ljc.17.2023.07.07.17.22.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 17:22:11 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso3811537e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 17:22:11 -0700 (PDT)
X-Received: by 2002:a05:6512:3af:b0:4f8:6c1f:b1ab with SMTP id
 v15-20020a05651203af00b004f86c1fb1abmr4305244lfp.27.1688775731487; Fri, 07
 Jul 2023 17:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner> <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner> <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
 <ZKinHejv+xBq+gti@casper.infradead.org> <CAHk-=wjJ8YP4wswYCC8X2o68vFeVzLesXbW-QdUgzzOZKaHJQw@mail.gmail.com>
In-Reply-To: <CAHk-=wjJ8YP4wswYCC8X2o68vFeVzLesXbW-QdUgzzOZKaHJQw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jul 2023 17:21:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=widpMfo_Zh5zHqL0Ct_VNqsHiwFyLUdM8wm6NF8o6T5kQ@mail.gmail.com>
Message-ID: <CAHk-=widpMfo_Zh5zHqL0Ct_VNqsHiwFyLUdM8wm6NF8o6T5kQ@mail.gmail.com>
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read side?)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 7 Jul 2023 at 17:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > That is, do we want SIGWINCH or SIGALRM to result in a short read?
>
> Now, that's a different issue, and is actually handled by the signal
> layer: a signal that is ignored (where "ignored" includes the case of
> "default handler") will be dropped early, exactly because we don't
> want to interrupt things like tty or pipe reads when you resize the
> window.

In case you care, it's prepare_signal() -> sig_ignored() ->
sig_task_ignored() -> sig_handler_ignored() logic that does this
short-circuiting.

And while I don't think it's required by POSIX, this was definitely a
case where lots of programs that *don't* use any signal handlers at
all are very much not expecting to see -EINTR as a return value, and
used to break exactly on things like SIGWINCH when reading from a tty
or a pipe.

But that logic goes back to before linux-1.0.

In fact, I think it goes back to at least 0.99.10 (June '93).

                 Linus
