Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43900657156
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 00:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiL0Xtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 18:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiL0Xtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 18:49:43 -0500
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Dec 2022 15:49:41 PST
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E640F1025;
        Tue, 27 Dec 2022 15:49:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 706E51725;
        Wed, 28 Dec 2022 00:42:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hera.aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xU42aC6-5EEs; Wed, 28 Dec 2022 00:42:00 +0100 (CET)
Received: from begin.home (2a01cb008c016e00de41a9fffe47ec49.ipv6.abo.wanadoo.fr [IPv6:2a01:cb00:8c01:6e00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 7DE431721;
        Wed, 28 Dec 2022 00:42:00 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1pAJa3-000Rnb-34;
        Wed, 28 Dec 2022 00:41:59 +0100
Date:   Wed, 28 Dec 2022 00:41:59 +0100
From:   Samuel Thibault <samuel.thibault@aquilenet.fr>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Message-ID: <20221227234159.y53uxqc6i2tkd4nq@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221022182828.give.717-kees@kernel.org>
 <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221227234000.jgosvixx7eahqb3z@begin>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault, le mer. 28 déc. 2022 00:40:00 +0100, a ecrit:
> Hello,
> 
> Kees Cook, le sam. 22 oct. 2022 11:29:49 -0700, a ecrit:
> > TIOCSTI continues its long history of being used in privilege escalation
> > attacks[1]. Prior attempts to provide a mechanism to disable this have
> > devolved into discussions around creating full-blown LSMs to provide
> > arbitrary ioctl filtering, which is hugely over-engineered -- only
> > TIOCSTI is being used this way. 3 years ago OpenBSD entirely removed
> > TIOCSTI[2], Android has had it filtered for longer[3], and the tools that
> > had historically used TIOCSTI either do not need it, are not commonly
> > built with it, or have had its use removed.
> 
> No. The Brltty screen reader entirely relies on TIOCSTI to be able to
> support input from various Braille devices.

(it only needs support for it on the linux console itself, nowhere else)

> Please make sure to keep
> TIOCSTI enabled by default, otherwise some people would just completely
> lose their usual way of simply typing on Linux.
> 
> Samuel
> 
> > Provide a simple CONFIG and global sysctl to disable this for the system
> > builders who have wanted this functionality for literally decades now,
> > much like the ldisc_autoload CONFIG and sysctl.
> > 
> > [1] https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad
> > [2] https://undeadly.org/cgi?action=article;sid=20170701132619
> > [3] https://lore.kernel.org/lkml/CAFJ0LnFGRuEEn1tCLhoki8ZyWrKfktbF+rwwN7WzyC_kBFoQVA@mail.gmail.com/
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: Simon Brand <simon.brand@postadigitale.de>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/tty/Kconfig  | 19 +++++++++++++++++++
> >  drivers/tty/tty_io.c | 11 +++++++++++
> >  2 files changed, 30 insertions(+)
> > 
> > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > index cc30ff93e2e4..d35fc068da74 100644
> > --- a/drivers/tty/Kconfig
> > +++ b/drivers/tty/Kconfig
> > @@ -149,6 +149,25 @@ config LEGACY_PTY_COUNT
> >  	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
> >  	  architectures and 24 bytes on 64-bit architectures.
> >  
> > +config LEGACY_TIOCSTI
> > +	bool "Allow legacy TIOCSTI usage"
> > +	default y
> > +	help
> > +	  Historically the kernel has allowed TIOCSTI, which will push
> > +	  characters into a controlling TTY. This continues to be used
> > +	  as a malicious privilege escalation mechanism, and provides no
> > +	  meaningful real-world utility any more.
> 
> Yes it does.
> 
> > +       Its use is considered
> > +	  a dangerous legacy operation, and can be disabled on most
> > +	  systems.
> > +
> > +	  Say 'Y here only if you have confirmed that your system's
> > +	  userspace depends on this functionality to continue operating
> > +	  normally.
> > +
> > +	  This functionality can be changed at runtime with the
> > +	  dev.tty.legacy_tiocsti sysctl. This configuration option sets
> > +	  the default value of the sysctl.
> > +
> >  config LDISC_AUTOLOAD
> >  	bool "Automatically load TTY Line Disciplines"
> >  	default y
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index fe77a3d41326..a6a16cf986b7 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -2268,11 +2268,15 @@ static int tty_fasync(int fd, struct file *filp, int on)
> >   *  * Called functions take tty_ldiscs_lock
> >   *  * current->signal->tty check is safe without locks
> >   */
> > +static bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI);
> >  static int tiocsti(struct tty_struct *tty, char __user *p)
> >  {
> >  	char ch, mbz = 0;
> >  	struct tty_ldisc *ld;
> >  
> > +	if (!tty_legacy_tiocsti)
> > +		return -EIO;
> > +
> >  	if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))
> >  		return -EPERM;
> >  	if (get_user(ch, p))
> > @@ -3573,6 +3577,13 @@ void console_sysfs_notify(void)
> >  }
> >  
> >  static struct ctl_table tty_table[] = {
> > +	{
> > +		.procname	= "legacy_tiocsti",
> > +		.data		= &tty_legacy_tiocsti,
> > +		.maxlen		= sizeof(tty_legacy_tiocsti),
> > +		.mode		= 0644,
> > +		.proc_handler	= proc_dobool,
> > +	},
> >  	{
> >  		.procname	= "ldisc_autoload",
> >  		.data		= &tty_ldisc_autoload,
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Samuel
> ---
> Pour une évaluation indépendante, transparente et rigoureuse !
> Je soutiens la Commission d'Évaluation de l'Inria.

-- 
Samuel
---
Pour une évaluation indépendante, transparente et rigoureuse !
Je soutiens la Commission d'Évaluation de l'Inria.
