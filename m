Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E194666A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbjALEv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjALEvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:51:51 -0500
Received: from sr40.hostlife.net (sr40.hostlife.net [185.43.220.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF8F630A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=hardclanz.org; s=default; h=To:From:Subject:Message-Id:Date:Content-Type:
        Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B2RlFVCzBZiiHWKxoHan5c13KwJIoIcrCOogS8pNM9w=; b=zLRf7Ldfo+b6HamXgDl8nFb7yp
        U0JAsoA3FWZ+f7G2ZYGtLO5ttMI6/ZsjciLpDTJP5gbYH+Z3qhbYCCSHZaVV1jYnHJoZH92Ikku9b
        y2obqUteLWEOrgFtl2FfR3A61Nd3eV5WhpIOHFZIR05i0jkJWSWZ5Dy7JoD+02AgXzL41U824J4ne
        QzsXoSTUbDFacCOqO1UFz2w9KYbd5dAistZUlr1BL9r/hnpzk/PjrMPVJbElkF/gH/ZwtpNnUVy2l
        6NgRXfRYiwVegfnKoJYb125Qx2FMJeabKQf62f6Vl6ZJI8xMU+QixzyTYN8oybnESbKcm12mDPypT
        smN7qV/w==;
Received: from [109.225.40.181] (port=49384 helo=localhost)
        by sr40.hostlife.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <emptiedsoul@hardclanz.org>)
        id 1pFpZ2-005XKa-Vi
        for linux-kernel@vger.kernel.org;
        Thu, 12 Jan 2023 05:51:44 +0100
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 Jan 2023 07:51:45 +0300
Message-Id: <CPPXX7JYJGIE.3F2R53GC3ULGZ@hardclanz>
Subject: [RESEND RFC] SIGOOM Proposal
From:   "Arseniy Lesin" <emptiedsoul@hardclanz.org>
To:     <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.12.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sr40.hostlife.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - hardclanz.org
X-Get-Message-Sender-Via: sr40.hostlife.net: authenticated_id: emptiedsoul@hardclanz.org
X-Authenticated-Sender: sr40.hostlife.net: emptiedsoul@hardclanz.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1. Introduction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

AFAIK, majority of linux-running machines are configured to overcommit
memory -- so, memory needs of every process are always pleased. However,
in the Out-Of-Memory condition we repay cruely -- by _killing_ the most
memory-hungry process.=20

Dealing with OOM was always questionable -- kernel-space OOM-killer
often works as the last resort -- system can hang for a pretty long time
(especially when using swap) before it resolves the OOM condition.

User-space OOM-killers solve this problem _partially_ -- they can _kill_
such processes preventively or even display nice GUI prompt for user.

However, the key problem persists -- we can only _kill_ unaware process,
possibly causing valuable data loss. There is no way to tell process: "You
are causing system OOM, release memory or you will be terminated forcefully=
"!

2. Proposal
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

2.1. The SIGOOM Signal
------------------

I propose the addition of new signal: SIGOOM (Out-Of-Memory SIGnal)=20

This signal is intended to be sent to the most memory-hungry process(es)
in order to give process a chance to release memory used for
non-valuable data (for example, browser can unload tabs, that are
currently not in use, assuming tabs are not separate processes) or to
write down valuable data and exit gracefully (for example, some
graphical editor).

Some applications can even set up a poll for OOM event by using signalfd

Default action: 	IGNORE
Proposed senders: 	kernel- and user-space OOM-killers

The technical detail of this addition is a bit unpleasant: there is
actually no room for new signals!=20

Numbers 1-31 are already assigned, every signal with number > SIGRTMIN=20
(currently 32) is considered realtime and queued accordingly.=20

Adding SIGOOM as signal #32 by shifting SIGRTMIN to 33 can do a trick,
but this will almost certainly break compatibility (namely, with glibc
threading)

I propose adding SIGOOM as signal #65 (after SIGRTMAX), but we should
clarify some checks in kernel/signal.c (possibly in other places too,
where signal number is tested against being realtime) and possibly add a
such-like macro:

#define SIG_IS_REALTIME(signum) (((signum) > SIGRTMIN) && ((signum) < SIGRT=
MAX))

I expect your comments on this topic very much, thanks in advance.

2.2. Adjusting kernel oom-killer to use SIGOOM
----------------------------------------------

Since we now have a way to inform process of it's memory utilization we
can try to send process SIGOOM signal first (if process set up handler
or poll for it) and only then kill it.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I will try to prepare a patchset for kernel in next couple of weeks.
Also going to create some patches for user-space oom-killers (sd-oomd,
meta's oomd) and propose a new system call for those (it is not as
important, so i decided not to include it for this RFC).

I invite all interested to discuss this RFC here on list, or you can
catch me on #linux IRC channel (libera network) tonight (nick:
emptiedsoul)

THX for reading, and again, thanks in advance for your comments.
