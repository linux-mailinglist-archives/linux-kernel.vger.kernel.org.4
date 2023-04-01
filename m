Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A616D2C17
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 02:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjDAA1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 20:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjDAA1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 20:27:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CB91D2ED;
        Fri, 31 Mar 2023 17:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8F7AB832C9;
        Sat,  1 Apr 2023 00:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C577C4339C;
        Sat,  1 Apr 2023 00:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680308838;
        bh=7jzReH1q9CRmvwL2uyfg2ERH5Qy9V7KrZ1wL21mKO3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bKmB6pi5MGQPJG0P2ovIQFUXPFD/tQqM5fIOL9JPhw5ssGeY3/kcknBSl0u7ZJdaK
         dyZmU6zW/Vi4SLhs90/RDlIuBt/R28ac1CJnV9bBBQs70rwnNHrybOPwZFww9pthhf
         1rDcUQDBqeEdb0w7ff6NPmU73UQo6U/rDt0qhbzBT2DgaFldG2fV0+VGOp/lM5E73g
         a3g69Ie2Y66J5tVpAiUIpvBhtOCg53L9JMzwIQYlgdyeX5ZUBkqdxs2cAUxs9FYcgE
         kvJqvu/RejN3twj+aSDCx60KrA3JroA9mCDQQC/TTIapfbVjBesYbZBWOdkYmkmy56
         GPW2bcJSsrRog==
Received: by mail-lf1-f45.google.com with SMTP id g19so17905188lfr.9;
        Fri, 31 Mar 2023 17:27:18 -0700 (PDT)
X-Gm-Message-State: AAQBX9ca9LtuhKMvFYTqpDaWspHPHZzaPvl08uI11GPPlpd4qhZ3NzG/
        qdlcQeJUp8oz5Hcx7AJXp2Wh+ES1lAUIGCbmBwE=
X-Google-Smtp-Source: AKy350a9yA6FOkVUeOQKc+dL58DDGuR3rZfb22m/S97w40D1BtWLf0DV/PorjGix/gOyn8yggqK4BhGEzqtmSqJVGts=
X-Received: by 2002:ac2:44a6:0:b0:4eb:d25:8686 with SMTP id
 c6-20020ac244a6000000b004eb0d258686mr6719045lfm.3.1680308836566; Fri, 31 Mar
 2023 17:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
 <ZCaE71aPvvQ/L05L@bombadil.infradead.org>
In-Reply-To: <ZCaE71aPvvQ/L05L@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 31 Mar 2023 17:27:04 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6P5AYVKMk=G1bEUz5PGZKmTJwtgQBmE-P4iAo7dOr5yA@mail.gmail.com>
Message-ID: <CAPhsuW6P5AYVKMk=G1bEUz5PGZKmTJwtgQBmE-P4iAo7dOr5yA@mail.gmail.com>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with module_memory")
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jim.cromie@gmail.com, linux-modules@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 12:00=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Thu, Mar 30, 2023 at 04:45:43PM -0600, jim.cromie@gmail.com wrote:
> > hi Luis, etal
> >
> > kmemleak is reporting 19 leaks during boot
> >
> > because the hexdumps appeared to have module-names,
> > and Ive been hacking nearby, and see the same names
> > every time I boot my test-vm, I needed a clearer picture
> > Jason corroborated and bisected.
> >
> > the 19 leaks split into 2 groups,
> > 9 with names of builtin modules in the hexdump,
> > all with the same backtrace
> > 9 without module-names (with a shared backtrace)
> > +1 wo name-ish and a separate backtrace
>
> Song, please take a look.

I will look into this next week.

Thanks,
Song
