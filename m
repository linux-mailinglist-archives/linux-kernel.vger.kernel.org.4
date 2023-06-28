Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2C740BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjF1IhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:37:00 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138]:37174 "EHLO
        sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjF1Icx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:32:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 522972011A;
        Wed, 28 Jun 2023 08:07:19 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8P8yQ3a3VF9W; Wed, 28 Jun 2023 08:07:19 +0200 (CEST)
Received: from begin (unknown [91.151.117.182])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 39C10200D5;
        Wed, 28 Jun 2023 08:07:18 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1qEOKi-009kLK-1u;
        Wed, 28 Jun 2023 08:07:16 +0200
Date:   Wed, 28 Jun 2023 08:07:16 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave@mielke.cc
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Message-ID: <20230628060716.vvgtlgbushyjh6km@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <keescook@chromium.org>, Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave@mielke.cc
References: <20221022182828.give.717-kees@kernel.org>
 <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin>
 <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
 <20221228205726.rfevry7ud6gmttg5@begin>
 <20230625155625.s4kvy7m2vw74ow4i@begin>
 <202306271944.E80E1D0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306271944.E80E1D0@keescook>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook, le mar. 27 juin 2023 19:48:45 -0700, a ecrit:
> On Sun, Jun 25, 2023 at 05:56:25PM +0200, Samuel Thibault wrote:
> > > Can we perhaps just introduce a CAP_TIOCSTI that the brltty daemon would
> > > be able to use? We could even make it only allow TIOCSTI on the linux
> > > console (tty->ops == con_ops).
> 
> Does brltty run with CAP_SYS_ADMIN?

ATM most often, yes, though we are trying to reduce the CAP_* privileges
to what it actually needs.

> > *Please* comment on this so we can progress. ATM people are
> > advising each other to set dev.tty.legacy_tiocsti=1, which is just
> > counter-productive in terms of security...
> 
> So is there really no solution for brltty and TIOCSTI being disabled?

No, there is no way to simulate characters on the Linux console. The
alternative would be to use uinput, but that simulates keycodes, not
characters, thus requiring backtranslating first, which is very fragile.

> What is FreeBSD doing? I imagine it's the same situation there too,
> though maybe there is just no support?

There is just no support in the kernel, only a patch against "screen".

> > Really, this a serious regression for the people affected by this.
> 
> Can you send a patch adding a CAP_SYS_ADMIN exception?

Sure!

Samuel
