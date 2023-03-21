Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237A66C3989
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCUStP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjCUStN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:49:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F7567A5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:48:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ew6so594147edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679424516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0ckUw7dWkverm2igg++8Ynt0yEw3mz/3PbETIyN2lM=;
        b=QrW8QLlhXRLLsjP3F+4fhjZ2IV7VEOnnPtdH2kcuNjaRfDJSfySxSopa0Z7evi2/vh
         KzYZQ0l0gdztGMIZz+L+NfeD8ytvURoY+K8KAMU6h0FCLYrEP/O7bEinnhzm8wsuJV9V
         9+n5ef7AaK2xYbe1rb2jSLzCj4TgJ/mN5USyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0ckUw7dWkverm2igg++8Ynt0yEw3mz/3PbETIyN2lM=;
        b=h7SjElPmgRWuBaU5jQfbzl0ZwXKkMRxUmI63I+7I4Mj/Z2//LsCPaiTD1XNpXljzGr
         OSRiWHxek6jZteMIbyC/QyOo3+dyqHM8DcHCotpDNw5dWY4cR75rWF3E0LmkVCST7cs8
         w6LWwHbNjgA1JQLi8IoTIOOzZT6+GsryPed+M240IBnkXz6mOlvAkrHgKz6ZDE5OF/tl
         YDEOMf1zs5eFjF2X1mEYPz2aUYg0DFkf0EyjgEv7LDHO5DXxPHyM60Wd1gBqu7LTdHz8
         QsPPXrh/GQ3N8ZCq+xukFK+CF1+4T0/VOHqJWPudheRBcmJtsOHqPhLNtKrcs/+Im7A2
         YE/Q==
X-Gm-Message-State: AO0yUKXWai/TrmefWMZAPEQjGw7zPivIDtf6h8/sGwPNEEy1e8z5NfOX
        KlaJfE0LPIa+U4SeiHegwhUXTynq7hHrvWpkFF5bhWsw
X-Google-Smtp-Source: AK7set/ANVf4hIIcvl8FCSLo9tAzc5vpodQ4gxK4VGFY+ehfx8U2vbTGwsaa5lrS6lm/c0IU0AT3Qg==
X-Received: by 2002:a17:906:938d:b0:925:5eb8:92fd with SMTP id l13-20020a170906938d00b009255eb892fdmr3626268ejx.14.1679424515760;
        Tue, 21 Mar 2023 11:48:35 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id b17-20020a17090630d100b009300424a2fdsm6155443ejb.144.2023.03.21.11.48.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:48:35 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id ew6so593718edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:48:34 -0700 (PDT)
X-Received: by 2002:a17:907:9b03:b0:932:da0d:9375 with SMTP id
 kn3-20020a1709079b0300b00932da0d9375mr2409395ejc.4.1679424514115; Tue, 21 Mar
 2023 11:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <2851036.1679417029@warthog.procyon.org.uk>
In-Reply-To: <2851036.1679417029@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 11:48:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
Message-ID: <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 21, 2023 at 9:43=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
>  (1) Fix request_key() so that it doesn't cache a looked up key on the
>      current thread if that thread is a kernel thread.  The cache is
>      cleared during notify_resume - but that doesn't happen in kernel
>      threads.  This is causing cifs DNS keys to be un-invalidateable.

I've pulled this, but I'd like people to look a bit more at this.

The issue with TIF_NOTIFY_RESUME is that it is only done on return to
user space.

And these days, PF_KTHREAD isn't the only case that never returns to
user space. PF_IO_WORKER has the exact same behaviour.

Now, to counteract this, as of this merge window (and marked for
stable) IO threads do a fake "return to user mode" handling in
io_run_task_work(), and so I think we're all good, but I'd like people
to at least think about this.

              Linus
