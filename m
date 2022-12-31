Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC165A5ED
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 18:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiLaR2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 12:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:28:07 -0500
Received: from second.openwall.net (second.openwall.net [193.110.157.125])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 34F4A2724
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 09:28:04 -0800 (PST)
Received: (qmail 14259 invoked from network); 31 Dec 2022 17:28:03 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 31 Dec 2022 17:28:03 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id B080EAB3A4; Sat, 31 Dec 2022 18:27:58 +0100 (CET)
Date:   Sat, 31 Dec 2022 18:27:58 +0100
From:   Solar Designer <solar@openwall.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Shawn Webb' <shawn.webb@hardenedbsd.org>,
        "oss-security@lists.openwall.com" <oss-security@lists.openwall.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat correctly
Message-ID: <20221231172758.GA10297@openwall.com>
References: <Y6SJDbKBk471KE4k@p183> <Y6TUJcr/IHrsTE0W@codewreck.org> <1a1963aa1036ba07@orthanc.ca> <20221228152458.6xyksrxunukjrtzx@mutt-hbsd> <fe260c38cf7e416288449691bb9cb5dd@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe260c38cf7e416288449691bb9cb5dd@AcuMS.aculab.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Let's wind this oss-security thread down as it relates to brainstorming
and commenting on totally new designs - no more of that, please.

Many things were said, but realistically the interface isn't _that_
broken (this can be parsed correctly, and procps-ng manages to) and is
(hopefully) not going to change much (in my opinion, and I know I'm not
alone in this, most of the proposals would make things worse overall).

Somewhat realistically, one possible change is replacing the most risky
characters, such as braces and anything <= ASCII 32, perhaps with '?'
to match what procps-ng is doing.  Perhaps do this either on all updates
of "comm" or in all places where "comm" is reported to userspace
(including procfs and kernel messages, by calling a common function).
"comm" isn't the full process name anyway - it's often truncated - so it
can reasonably be made safer in other ways as well.  As an option, the
replacing of whitespace (ASCII 32) and braces could be limited to the
"stat" file, but the control characters are (even more) problematic with
other interfaces where "comm" is exposed, so replacing them should
probably be global.

Happy New Year!

Alexander
