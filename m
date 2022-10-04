Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927B95F4AF2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJDVa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJDVaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:30:55 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7932D9F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:30:55 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d64so15729240oia.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SFQu3t4inF2f+xysjgGlZx3Q+02dLvuG3skqtmC7Pio=;
        b=SA+wt+snYtRdSJbpf94VhrexKFOGonjrwKB67DgxIIH3cROJ5H0Xf5DnQd/Zmg0oCQ
         tPKtQqGfOY7cKeLSWYZGbsrWcmghNbzyuVESVUfz8nlzevxY7EbcVnEl7+e7RLUNUw/e
         AOY7a5m8VQy7rfIxuzrsIOM/1t2RtNNy+bwgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SFQu3t4inF2f+xysjgGlZx3Q+02dLvuG3skqtmC7Pio=;
        b=8MBhVXO/tC5G5lg5jed9iW4p5UzXwSFr5pQ6SFjb55QYekLs00cvVTs18dFfp5ARml
         swiJ3Bi5rGD/DpRjcGLUqi8RnQ7exexfAYf8mvlNVqYtd4iZfwmzAMQ161iERVceKKNt
         HnQL1Bb/jtUCcAr6tUgZ0Rw7Jg7FyJMaktwNvppXuScQVk6eVLQZJrsRE2zec0MgNsFb
         xqA6oiwKCMf6Ta8AldEj72lIEBjDYt7DmJRWDE/NeBvc9plncPjOxtY3tv35LVOIMpdB
         iTpr+tspSVONU1MABb7PbCbhIpweZiv53QMcPyTE3rqBalHD4jdmCXQmSGPIP8vDDhVK
         PgEA==
X-Gm-Message-State: ACrzQf2kDV7ipAChV1Bj0AuL8fpYxONQ6ydKJFe99m8AUpyCHBG5ki/e
        7XHsrYLHK3m0L3eFv6CESOfEBekdoWaiyw==
X-Google-Smtp-Source: AMsMyM5cWUOGUHejntbSISS+Q9DLINmpRQXiGJuPfiQZe8C0D4Wd0Y6C1Yvq5hk3gAREZ9dmviU/IQ==
X-Received: by 2002:aca:de43:0:b0:350:7f0d:967d with SMTP id v64-20020acade43000000b003507f0d967dmr784606oig.260.1664919053570;
        Tue, 04 Oct 2022 14:30:53 -0700 (PDT)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id o24-20020a05680803d800b0035179b87ba5sm3385413oie.20.2022.10.04.14.30.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 14:30:52 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id t4-20020a4aa3c4000000b00475624f2369so9645626ool.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 14:30:52 -0700 (PDT)
X-Received: by 2002:a05:6830:11c6:b0:65f:913:ff93 with SMTP id
 v6-20020a05683011c600b0065f0913ff93mr6285691otq.69.1664919051959; Tue, 04 Oct
 2022 14:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org> <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
In-Reply-To: <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Oct 2022 14:30:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjKsSmNVLa1e22Q29-YUEXWtS39d7EDkcN8v_E7SoKGA@mail.gmail.com>
Message-ID: <CAHk-=wjjKsSmNVLa1e22Q29-YUEXWtS39d7EDkcN8v_E7SoKGA@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 4, 2022 at 1:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So this whole "don't do this" approach you have is not acceptable.

Side note: if we have a security hook for "create random file", then
the notion that creating a whole new namespace somehow must not have
any security hooks because it's *so* special is just ridiculous.

I also note that right now USER_NS is both "default n" and "if not
sure, say 'n'" in the Kconfig files, even though obviously that ship
has sailed long ago.

So originally it might have been a reasonable expectation to say "only
enable this if you're doing containers in servers", but that clearly
isn't the case any more. So we basically take USER_NS for granted, but
the fact that people might want chrome to use it for sandboxing does
*not* mean that randomly we want any CLONE_NEWNS to just be ok,
regardless of how trusted (or not) the case is.

                     Linus
