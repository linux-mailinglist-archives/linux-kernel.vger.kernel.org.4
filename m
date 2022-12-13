Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA98F64C035
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiLMXFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiLMXFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:05:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51743127
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=acFcWsZp8jeuy0aOVlX6PCUPzovLJAhrsBv6ucRF3IU=; b=gi8Qn5HRZAtpxzz5YJZ05RPV8g
        YJ0W7ei0he98EPBkc/C6n9oP+SGGHW+OZVWGoDeSShO4KHZT2AMnaQGFrSeufGjh0TMzW7OeZEmlx
        prUxCXndMK79i6OS38dDpWijDBvTEugkcuqkxM7zKHdeAdcbvXqWI6RMl1ZnpWjtaoeniR3PK3BOf
        alnuEcmqJvhsipsytjf+H789Pr92NPi7NisZUkwxUcfURmBiNECXXiSoM+LS1SeDOAPqK20b6LAVd
        5Wm4OJytRw3tuF3cXJGoWoSLN9AhKtUi7v97bpioc85HlplK4pBzlUZ5n7K621alFIgYY2H+/p4XF
        Rb9du+fw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5ELD-0084r9-L8; Tue, 13 Dec 2022 23:05:39 +0000
Date:   Tue, 13 Dec 2022 15:05:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     =?utf-8?Q?Micha=C5=82?= Lach <michal.lach@samsung.com>
Cc:     linux-kernel@vger.kernel.org, russell.h.weight@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, tiwai@suse.de
Subject: Re: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
Message-ID: <Y5kFQ0R7o20Fycvp@bombadil.infradead.org>
References: <CGME20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9@eucas1p2.samsung.com>
 <20221123111455.94972-1-michal.lach@samsung.com>
 <Y5bEYfQOMyA4XQEW@bombadil.infradead.org>
 <c1d10d21-f3ca-7633-8b65-5d3916cfa648@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1d10d21-f3ca-7633-8b65-5d3916cfa648@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:52:51PM +0100, Michał Lach wrote:
> On 12/12/22 07:04, Luis Chamberlain wrote:
> > Hey Michal! Thanks for your patch! I have a few doubts though!
> 
> :-)
> 
> > To account for not having to deal with specific drivers we have the
> > Linux kernel selftests. And so you can test the firmware loader with all
> > sorts of crazy situations which any driver could use and try to see
> > if you can re-recreate the issue.
> > 
> > The kernel selftests driver for the firmware loader is in
> > lib/test_firmware.c and you can use thetools/testing/selftests/firmware/fw_run_tests.sh
> > to run all the tests. To test the firmware fallback alone you can use
> > just fw_fallback.sh.
> > 
> > If you want to just virtualize this and you can also use kdevops [0] and
> > enable the firmware loader selftest and use:;
> > 
> > make menuconfig          #  enable selftests and just the firmware test
> > make linux               #  build linux, pick linux-next
> > make selftests
> > make selftests-firmware
> > 
> > But this may be something more you can use later once you get your flow
> > going. Just compiling the kernel and running the selftest manually with
> > fw_fallback.sh should suffice.
> 
> Thanks a lot, I had no idea that there is something like this.

selftests has been there for ages, kdevops support for selftests is
pretty new, like 1 week old only :)

> > OK so this proves the bug can happen but I'd like to see the full trace
> > and the exact kernel version showing that this can happen on a recent
> > kernel. Without that I'm not seeing how this can trigger yet.
> 
> Unfortunately I cannot provide a trace. The kernel version was 5.15.41 (-stable).

Ah, I suspected as much, given I couldn't see how this could happen in
linux-next.

> Keeping that in mind, I will try to reproduce this behaviour with in-tree
> code and provide proof.

Yes please use linux-next, if you can't reproduce there then likely
your kernel is missing some fixes.

  Luis
