Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AFB730959
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjFNUmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjFNUmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:42:42 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1D12947
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=cW4dy2To7/M902URPa1VAjOZaTBlNB+GfxWd9TtkCSE=;
        b=E+yvNIrkyeT6IEUt9sQXovg5SM1XJyIh1I4psC5M3E0rZecTNFqf6dUoJZIzciYDZF0wHtv1CkbtY
         Ug1uzl6V27VzH/JmBV94T1MdtTmgFg2jzeFq6Mfho6iJGF+23+QBKJ0QDxcICllSjMb+Kt1MW6XBKv
         PQsAOS9u08oxojjceExcrYB6dEKtgWFOX2UcAeoJzROmdLfweXYrEpnTYdlO2gOY+dDHjQtqVpfKXH
         yhxY21X3GJ1ZCEp4H8EZ6mPYVhtwndrZHgoJss5Wr0lAHHK6G4CZP3yqRUlLm7GYcjj9weu2d/kNrz
         fKoNo+NR6+5qOQMLwzz0o0xdvg/UVSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=cW4dy2To7/M902URPa1VAjOZaTBlNB+GfxWd9TtkCSE=;
        b=VXu9k3ldXcowqgW30zeYdluY94r2cP2Z6PZzlWmByvpKOXcQRh1vwTttSWKSGKkWXSw4a8h/rZkbB
         U3M0jZMAA==
X-HalOne-ID: e3e45d00-0af3-11ee-bc48-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id e3e45d00-0af3-11ee-bc48-b90637070a9d;
        Wed, 14 Jun 2023 20:41:52 +0000 (UTC)
Date:   Wed, 14 Jun 2023 22:41:51 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [patch 09/17] sparc/cpu: Switch to arch_cpu_finalize_init()
Message-ID: <20230614204151.GA1492503@ravnborg.org>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.431995857@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613224545.431995857@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:39:35AM +0200, Thomas Gleixner wrote:
> check_bugs() is about to be phased out. Switch over to the new
> arch_cpu_finalize_init() implementation.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

