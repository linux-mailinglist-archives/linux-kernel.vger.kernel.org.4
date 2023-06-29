Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C541742773
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjF2Ncv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjF2Nck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:32:40 -0400
Received: from sonata.ens-lyon.org (unknown [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B53583;
        Thu, 29 Jun 2023 06:32:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id A599F20103;
        Thu, 29 Jun 2023 15:32:20 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 117FFccbxKwj; Thu, 29 Jun 2023 15:32:20 +0200 (CEST)
Received: from begin.home (lfbn-bor-1-1163-184.w92-158.abo.wanadoo.fr [92.158.138.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 40424200FD;
        Thu, 29 Jun 2023 15:32:20 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1qErkx-009h1v-25;
        Thu, 29 Jun 2023 15:32:19 +0200
Date:   Thu, 29 Jun 2023 15:32:19 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Kees Cook <keescook@chromium.org>, Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Dave@mielke.cc" <Dave@mielke.cc>
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Message-ID: <20230629133219.5z667lt6pz25exkf@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Kees Cook <keescook@chromium.org>, Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Dave@mielke.cc" <Dave@mielke.cc>
References: <20221022182828.give.717-kees@kernel.org>
 <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin>
 <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
 <20221228205726.rfevry7ud6gmttg5@begin>
 <20230625155625.s4kvy7m2vw74ow4i@begin>
 <202306271944.E80E1D0@keescook>
 <20230628060716.vvgtlgbushyjh6km@begin>
 <55c209a024a94d1f9c6af85dfddb11a0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c209a024a94d1f9c6af85dfddb11a0@AcuMS.aculab.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight, le jeu. 29 juin 2023 13:23:54 +0000, a ecrit:
> From: Samuel Thibault
> > Sent: 28 June 2023 07:07
> ...
> > > So is there really no solution for brltty and TIOCSTI being disabled?
> > 
> > No, there is no way to simulate characters on the Linux console. The
> > alternative would be to use uinput, but that simulates keycodes, not
> > characters, thus requiring backtranslating first, which is very fragile.
> 
> It could probably be rewritten to use a pseudo-tty pair.

That's what yasr does for instance, but that does not make the login
prompt accessible, which is a must (just like sighted users don't log in
blindly...)

Samuel
