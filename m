Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966DE605C57
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiJTKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiJTKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:31:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E3F169CC5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:31:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 945881FA0B;
        Thu, 20 Oct 2022 10:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666261846;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2npfToEZqSD943t+AIhJGEaS4hfBHUeIL0TiPXg5g0=;
        b=H24lMvQmLxNYTkW9KUMcjVidNm9xUR1sC5nQRV5c8waRvRPTyNLke6yISbKhUok5vU9baK
        OVfrjcl4+NpMBgCNnh3HbfGtgjEcVtUaaVHK9HRjX7NeAVBBKBwgMczGQUnrMqwKK57P2o
        Qd/Kyih4PiRSvNIilNbqB6MSi5lEP4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666261846;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2npfToEZqSD943t+AIhJGEaS4hfBHUeIL0TiPXg5g0=;
        b=PGy7AW7naxq+AkSqlZRPim5P6dPZhTnmpXrDcnMnMKkl8EIrsUzQsHvYqjtjR2NzsOswMr
        Kq0Mb/1gcZPmtkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 298BC13AF5;
        Thu, 20 Oct 2022 10:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gWnqKFQjUWPxXwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 20 Oct 2022 10:30:44 +0000
Date:   Thu, 20 Oct 2022 12:30:39 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Torsten Hilbrich <torsten.hilbrich@secunet.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: v6.1-rc1: Regression in notification of sethostname changes
Message-ID: <Y1EjT2gdvXVEv8ak@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com>
 <Y0/DlHMIPbRDG+fF@pevik>
 <Y0/uFkggIJMjxcpi@pevik>
 <ec9e00b9-8b47-7918-c39b-8b0069003169@secunet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec9e00b9-8b47-7918-c39b-8b0069003169@secunet.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 19.10.22 14:31, Petr Vorel wrote:
> >> Hi Torsten,

> >>> Hello Petr,

> >>> your commit

> >>> commit bfca3dd3d0680fc2fc7f659a152234afbac26e4d
> >>> Author: Petr Vorel <pvorel@suse.cz>
> >>> Date:   Thu Sep 1 21:44:03 2022 +0200

> >>>     kernel/utsname_sysctl.c: print kernel arch

> >>>     Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.

> >>>     This helps people who debug kernel with initramfs with minimal environment
> >>>     (i.e.  without coreutils or even busybox) or allow to open sysfs file
> >>>     instead of run 'uname -m' in high level languages.

> >>> broke the notification mechanism between the sethostname syscall and the pollers of /proc/sys/kernel/hostname.

> >>> The table uts_kern_table is addressed within uts_proc_notify by the enum value, however no new enum value was added in "enum uts_proc".

> >>> I noticed the problem when journald-systemd failed to detect hostname changes made with the sethostname syscall (as used by the hostname tool).
> >>> When setting the hostname through /proc/sys/kernel/hostname the poll notification was working.

> >> Thanks a lot for your report, working on a fix!
> >> Andrew, Greg, sorry for a regression.

> > Hi Torsten,

> > could you please post exact steps to reproduce the problem.
> > Although the required fix to add new enum into enum uts_proc is trivial,
> > I was not able to reproduce the problem with 6.1.0-rc1 (actually
> > 6.1.0-rc1-4.g1d716d8-default which contains few extra patches).

> > # hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
> > opensuse-tumbleweed.20221001
> > opensuse-tumbleweed.20221001
> > opensuse-tumbleweed.20221001

> > # hostnamectl set-hostname foo; echo $?
> > 0
> > # hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
> > foo
> > foo
> > foo

> > # hostname bar; echo $?
> > 0
> > # hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
> > bar
> > bar
> > bar

> > # echo "baz" > /proc/sys/kernel/hostname
> > # hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
> > baz
> > baz
> > baz


> > # hostnamectl set-hostname foo; reboot
> > After reboot it's 'foo'.
> > What am I missing?

> > BTW I originally tested the feature only on dracut initramfs (with rapido [1]),
> > which obviously bypass systemd. For a fix I'm creating rpm package (binrpm-pkg).

> The problem is happening in the systemd-journald poll notification. I was checking for the problem by attaching gdb to the running systemd-journald and setting a breakpoint to the server_cache_hostname function. This function is triggered via dispatch_hostname_change whenever the hostname changes. This is done via sd_event API in systemd.

> Here is an example program for this functionality without any further dependency:

> #include <poll.h>
> #include <fcntl.h>
> #include <stdbool.h>
> #include <stdio.h>
> #include <unistd.h>

> int main()
> {
> 	struct pollfd info;

> 	info.fd = open("/proc/sys/kernel/hostname", O_RDONLY);
> 	info.events = 0;
> 	info.revents = 0;

> 	while (true) {
> 		int res = poll(&info, 1, -1);
> 		if (res > 0) {
> 			if (info.revents != 0) {
> 				char buffer[64];
> 				gethostname(buffer, sizeof(buffer));
> 				printf("Hostname has changed to: %s\n", buffer);
> 			}
> 		}
> 	}
> }

Rigth, poll() is broken. Thanks a lot for a simple reproducer!
I'll send a fix shortly.

Kind regards,
Petr

> I have also attached this program.

> If you call this program and issue calls of the hostname utility to change the hostname some message should be printed.

> 	Torsten


> #include <poll.h>
> #include <fcntl.h>
> #include <stdbool.h>
> #include <stdio.h>
> #include <unistd.h>

> int main()
> {
> 	struct pollfd info;

> 	info.fd = open("/proc/sys/kernel/hostname", O_RDONLY);
> 	info.events = 0;
> 	info.revents = 0;

> 	while (true) {
> 		int res = poll(&info, 1, -1);
> 		if (res > 0) {
> 			if (info.revents != 0) {
> 				char buffer[64];
> 				gethostname(buffer, sizeof(buffer));
> 				printf("Hostname has changed to: %s\n", buffer);
> 			}
> 		}
> 	}
> }

