Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791BC745390
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 03:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGCB3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 21:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGCB3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 21:29:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C1518F;
        Sun,  2 Jul 2023 18:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C367E60C02;
        Mon,  3 Jul 2023 01:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCB0C433C8;
        Mon,  3 Jul 2023 01:29:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Y4+QzqLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1688347774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4674ZbOxpPHoz+ti6WsYFPiu0IyaOts3jCS8wRMfDSY=;
        b=Y4+QzqLUTiJeMalgj+I7Qo91Ha+PS4e9rDKO2uucMD4artd8I2tsWvB0NNZQlRu/PVMC3e
        8bh5NrRfWN1PxNylMDVYDZKT0yy6nTDxUEcOS9jQf/7Fg95TyqIvSC5Ve2NEoo1Yh4RqmH
        ddaBAhi+C2W0eJ4EbPsNpnPz/DqAS5c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5120d0e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 3 Jul 2023 01:29:34 +0000 (UTC)
Date:   Mon, 3 Jul 2023 03:29:30 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        David R <david@unsolicited.net>,
        Boris Ostrovsky <boris.ovstrosky@oracle.com>,
        Miguel Luis <miguel.luis@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>,
        Wireguard Mailing List <wireguard@lists.zx2c4.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Manuel 'satmd' Leiner <manuel.leiner@gmx.de>
Subject: Re: Fwd: RCU stalls with wireguard over bonding over igb on Linux
 6.3.0+
Message-ID: <ZKIkevSrMJISHDig@zx2c4.com>
References: <e5b76a4f-81ae-5b09-535f-114149be5069@gmail.com>
 <79196679-fb65-e5ad-e836-2c43447cfacd@gmail.com>
 <10f2a5ee-91e2-1241-9e3b-932c493e61b6@leemhuis.info>
 <CAHmME9onMWdJVUerf86V0kpmNKByt+VC=SUfys+GFryGq1ziHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9onMWdJVUerf86V0kpmNKByt+VC=SUfys+GFryGq1ziHQ@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 03:46:38PM +0200, Jason A. Donenfeld wrote:
> I've got an overdue patch that I still need to submit to netdev, which
> I suspect might actually fix this.
> 
> Can you let me know if
> https://git.zx2c4.com/wireguard-linux/patch/?id=54d5e4329efe0d1dba8b4a58720d29493926bed0
> solves the problem?

satmd, the original reporter, confirmed over on the Gentoo bug report -
https://bugs.gentoo.org/909066 - that this patch fixes the issue.

This patch has been sent into netdev and will presumably hit the various
trees and stable in due time.

Jason
