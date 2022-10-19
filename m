Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2568C60421D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiJSKzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiJSKya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:54:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2478D4620C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:25:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42E432040F;
        Wed, 19 Oct 2022 09:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666171798;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIePuYPef2it7SNowdKfN/HZEmC0IyOhP+Vny8+bqds=;
        b=g7Km96rLbAnC8cRypwR59ySl0NhtjkFzJJ0oskvZnD3/kiueV0Hb4w+X0v2ufQjo/8DFhh
        jX6YjJU4O1sfMzhLaYkg4NZZuE8XBOpOpOTWmrslNH9Qp3Lr8M5rJO8AuTOAjA+FA+SjnJ
        x4VsjmhXx3m+zcqc1EP8WLTYSATP8G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666171798;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIePuYPef2it7SNowdKfN/HZEmC0IyOhP+Vny8+bqds=;
        b=xfl32H5HBuHikpxdswLLYtVCWH+I3PKd6Jf2XDfe/0xnBhrs58kX5AQZfEtqKmO5OuQ7UD
        pkNPrR5z1XR9+oCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A2B113A36;
        Wed, 19 Oct 2022 09:29:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R1m2AJbDT2NIBAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 19 Oct 2022 09:29:58 +0000
Date:   Wed, 19 Oct 2022 11:29:56 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Torsten Hilbrich <torsten.hilbrich@secunet.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: v6.1-rc1: Regression in notification of sethostname changes
Message-ID: <Y0/DlHMIPbRDG+fF@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

> Hello Petr,

> your commit

> commit bfca3dd3d0680fc2fc7f659a152234afbac26e4d
> Author: Petr Vorel <pvorel@suse.cz>
> Date:   Thu Sep 1 21:44:03 2022 +0200

>     kernel/utsname_sysctl.c: print kernel arch

>     Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.

>     This helps people who debug kernel with initramfs with minimal environment
>     (i.e.  without coreutils or even busybox) or allow to open sysfs file
>     instead of run 'uname -m' in high level languages.

> broke the notification mechanism between the sethostname syscall and the pollers of /proc/sys/kernel/hostname.

> The table uts_kern_table is addressed within uts_proc_notify by the enum value, however no new enum value was added in "enum uts_proc".

> I noticed the problem when journald-systemd failed to detect hostname changes made with the sethostname syscall (as used by the hostname tool).
> When setting the hostname through /proc/sys/kernel/hostname the poll notification was working.

Thanks a lot for your report, working on a fix!
Andrew, Greg, sorry for a regression.

Kind regards,
Petr

> 	Torsten
