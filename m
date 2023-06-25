Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8473D507
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 00:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFYWSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 18:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFYWSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 18:18:11 -0400
X-Greylist: delayed 534 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Jun 2023 15:18:08 PDT
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FC3187
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 15:18:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 489BE1D38
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:09:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hera.aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bNXRzKPZ_Z3I for <linux-kernel@vger.kernel.org>;
        Mon, 26 Jun 2023 00:09:04 +0200 (CEST)
Received: from begin (reverse-177-225.fdn.fr [80.67.177.225])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id BC213178E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:09:04 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1qDXuq-008GQB-1N
        for linux-kernel@vger.kernel.org;
        Mon, 26 Jun 2023 00:09:04 +0200
Date:   Sun, 25 Jun 2023 17:56:25 +0200
From:   Samuel Thibault <samuel.thibault@aquilenet.fr>
To:     Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave@mielke.cc
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Message-ID: <20230625155625.s4kvy7m2vw74ow4i@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
        Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228205726.rfevry7ud6gmttg5@begin>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Samuel Thibault, le mer. 28 déc. 2022 21:57:26 +0100, a ecrit:
> Kees Cook, le mar. 27 déc. 2022 19:32:55 -0800, a ecrit:
> > On December 27, 2022 3:40:00 PM PST, Samuel Thibault <samuel.thibault@aquilenet.fr> wrote:
> > >Kees Cook, le sam. 22 oct. 2022 11:29:49 -0700, a ecrit:
> > >> TIOCSTI continues its long history of being used in privilege escalation
> > >> attacks[1]. Prior attempts to provide a mechanism to disable this have
> > >> devolved into discussions around creating full-blown LSMs to provide
> > >> arbitrary ioctl filtering, which is hugely over-engineered -- only
> > >> TIOCSTI is being used this way. 3 years ago OpenBSD entirely removed
> > >> TIOCSTI[2], Android has had it filtered for longer[3], and the tools that
> > >> had historically used TIOCSTI either do not need it, are not commonly
> > >> built with it, or have had its use removed.
> > >
> > >No. The Brltty screen reader entirely relies on TIOCSTI to be able to
> > >support input from various Braille devices. Please make sure to keep
> > >TIOCSTI enabled by default, otherwise some people would just completely
> > >lose their usual way of simply typing on Linux.
> > 
> > Yup, it remains default enabled:
> 
> Yes, but thining of it, very soon people in various security-sensitive
> distributions will disable it, as they should indeed. And people who
> need to use their Braille device on such distributions will get stuck.

And as expected, it did get disabled in Debian for instance, very much
to the dismay of blind users, whose keyboard suddenly stopped working at
all after rebooting with a Linux 6.3 kernel!...

> Can we perhaps just introduce a CAP_TIOCSTI that the brltty daemon would
> be able to use? We could even make it only allow TIOCSTI on the linux
> console (tty->ops == con_ops).

*Please* comment on this so we can progress. ATM people are
advising each other to set dev.tty.legacy_tiocsti=1, which is just
counter-productive in terms of security...

Really, this a serious regression for the people affected by this.

Samuel
