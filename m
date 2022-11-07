Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F105E61F19B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKGLOq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Nov 2022 06:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiKGLOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:14:43 -0500
Received: from mail.lixid.net (lixid.tarent.de [193.107.123.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5D460F2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:14:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.lixid.net (MTA) with ESMTP id 4E77914123E;
        Mon,  7 Nov 2022 12:14:36 +0100 (CET)
Received: from mail.lixid.net ([127.0.0.1])
        by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
        id 0W6NnBm9u4P5; Mon,  7 Nov 2022 12:14:30 +0100 (CET)
Received: from x61w.mirbsd.org (vpn-172-34-0-14.dynamic.tarent.de [172.34.0.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lixid.net (MTA) with ESMTPS id EC829141231;
        Mon,  7 Nov 2022 12:14:29 +0100 (CET)
Received: by x61w.mirbsd.org (Postfix, from userid 1000)
        id 01F4E61728; Mon,  7 Nov 2022 12:14:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by x61w.mirbsd.org (Postfix) with ESMTP id F06B3602AA;
        Mon,  7 Nov 2022 12:14:28 +0100 (CET)
Date:   Mon, 7 Nov 2022 12:14:28 +0100 (CET)
From:   Thorsten Glaser <t.glaser@tarent.de>
To:     Mark Rutland <mark.rutland@arm.com>
cc:     linux-kernel@vger.kernel.org, ardb@kernel.org, arnd@arndb.de,
        boqun.feng@gmail.com, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v2] atomics: fix atomic64_{read_acquire,set_release}
 fallbacks
In-Reply-To: <Y2jf1nd63iBGMCz0@FVFF77S0Q05N>
Message-ID: <d8c546d-bf1e-5f7c-ab57-d56b12cf494d@tarent.de>
References: <20220203161243.3955547-1-mark.rutland@arm.com> <fcafd6d9-7d3e-67b0-3176-5fb8e9c322ef@tarent.de> <Y2jf1nd63iBGMCz0@FVFF77S0Q05N>
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022, Mark Rutland wrote:

> Do you have a particular case in mind that you care about?

Definitely:

I have a qdisc which does rate limiting, and I need to update the
rate 100+ times a second and “tc qdisc change” introduces too much
delay (I *think* but I’m implementing this right now and we’ll see
whether this is indeed the problem).

The qdisc already uses relayfs over debugfs anyway to communicate
status info *to* userspace, so I’m adding another debugfs file and
will update the rate from its write fop.

So, after *much* reading and asking around, atomic64_set_release()
in the write fop, combined with atomic64_read_acquire() in the qdisc
hot path (which runs in softirq context and thus ought to be lockless)
seems to be “the answer”.

Basically, atomically changing a 64-bit value while keeping at least
the read part lockless was my requirement. (I’d be happy enough even
if the new value was read with _some_ delay, say within 1 µs, as long
as after the old value only the new value would be read, and never
a different value. Giving up ILP32 support for this is acceptable,
even if it may limit other uses later, although given this already
throws tons of u64 quantities around for nanoseconds it’d have sucked
on ILP32 already and I can tell the users to run it on LP64 only, it’s
for a specific use case only anyway.)

bye,
//mirabilos
-- 
Infrastrukturexperte • tarent solutions GmbH
Am Dickobskreuz 10, D-53121 Bonn • http://www.tarent.de/
Telephon +49 228 54881-393 • Fax: +49 228 54881-235
HRB AG Bonn 5168 • USt-ID (VAT): DE122264941
Geschäftsführer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Alexander Steeg

                        ****************************************************
/⁀\ The UTF-8 Ribbon
╲ ╱ Campaign against      Mit dem tarent-Newsletter nichts mehr verpassen:
 ╳  HTML eMail! Also,     https://www.tarent.de/newsletter
╱ ╲ header encryption!
                        ****************************************************
