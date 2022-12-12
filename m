Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4476498D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiLLGEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiLLGET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:04:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA355D12E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7FgJ27esuN9GoHpckrjt5wYbZDc+iWAdGgUREAfutxU=; b=INHldDRTL9L4nG0BXUfRWeDukW
        g74cfXuPE8dWgNsZzp6K/r0ZQXRcqx/RMA0ivasa1ZnefKAJlUDt16U6fXKlec1SLWMUG118jgFYj
        we0SccFHK98sG0dTfg5LQyZ/ldKYrK/l336BtV39zjN9UANIqPDwyrNuideFie1Qy1ihFhMeSzDGe
        PKSE9STiMcmKGUOWhfUclQhLVZT7jPknnGxn2o+okd/vh+bDx419m8gXWxo/O6CJVke9b+bSOK6eV
        3NrtDBL5eFA/WhoDLjtlLYSCZC+DoJOswiM96wi2SiaxVZheCgwnpdog6V74OWkwgzli1cPLcbHZF
        JRsFJKPQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4bvF-008aCA-1z; Mon, 12 Dec 2022 06:04:17 +0000
Date:   Sun, 11 Dec 2022 22:04:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Michal Lach <michal.lach@samsung.com>
Cc:     linux-kernel@vger.kernel.org, russell.h.weight@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        ming.lei@canonical.com, tiwai@suse.de
Subject: Re: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
Message-ID: <Y5bEYfQOMyA4XQEW@bombadil.infradead.org>
References: <CGME20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9@eucas1p2.samsung.com>
 <20221123111455.94972-1-michal.lach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123111455.94972-1-michal.lach@samsung.com>
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

Hey Michal! Thanks for your patch! I have a few doubts though!

On Wed, Nov 23, 2022 at 12:14:56PM +0100, Michal Lach wrote:
> If CONFIG_FW_LOADER_USER_HELPER is enabled, it is possible to interrupt
> the loading process after adding pending_list to pending_fw_list.

In that case wouldn't fw_load_abort() get called and do the right thing?
That in the end calls __fw_state_set() which does:

static inline void __fw_state_set(...)
{
	struct fw_state *fw_st = &fw_priv->fw_st;

	WRITE_ONCE(fw_st->status, status);
	if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED) {
#ifdef CONFIG_FW_LOADER_USER_HELPER
	list_del_init(&fw_priv->pending_list);
#endif
	complete_all(&fw_st->completion);
	}
}

So the question I have for you is -- what path could be cancelled
which we don't end up calling a respective abort fw_load_abort()?

> Subsequently, if user calls release_firmware() which deallocates the
> fw_priv structure which pending_list is a member of, the entry in the
> list is not deleted. This causes a use-after-free on further attempts
> to add an entry to the list or on list traversal.

Now we're dealing with the possibility of a driver interaction drivers
can be buggy too. So I'm curious what driver triggers this?

> While not problematic in most drivers since this function is mainly used
> in probe or init routines, some drivers expose firmware loading
> functionality via user-accessible functions like write() etc.
> In this case during the sysfs loading process, we can send SIGKILL to the
> thread which is then in kernel, leave the entry in the list and then free
> the structure.

To account for not having to deal with specific drivers we have the
Linux kernel selftests. And so you can test the firmware loader with all
sorts of crazy situations which any driver could use and try to see
if you can re-recreate the issue.

The kernel selftests driver for the firmware loader is in
lib/test_firmware.c and you can use thetools/testing/selftests/firmware/fw_run_tests.sh
to run all the tests. To test the firmware fallback alone you can use
just fw_fallback.sh.

If you want to just virtualize this and you can also use kdevops [0] and
enable the firmware loader selftest and use:;

make menuconfig          #  enable selftests and just the firmware test
make linux               #  build linux, pick linux-next
make selftests
make selftests-firmware

But this may be something more you can use later once you get your flow
going. Just compiling the kernel and running the selftest manually with
fw_fallback.sh should suffice.

[0] https://github.com/linux-kdevops/kdevops

> Example kernel panics with CONFIG_DEBUG_LIST turned on:
> 
> kernel BUG at lib/list_debug.c:25!
> /* ... */
> Call trace:
>  __list_add_valid+0x7c/0x98
>  fw_load_sysfs_fallback+0xd4/0x334
>  fw_load_from_user_helper+0x148/0x1f8
>  firmware_fallback_sysfs+0xe0/0x17c
>  _request_firmware+0x1a0/0x470
>  request_firmware+0x50/0x78
> /* ... */
> 
> or
> 
> kernel BUG at lib/list_debug.c:56!
> /* ... */
> Call trace:
>  __list_del_entry_valid+0xa0/0xa4
>  fw_load_abort+0x38/0x64
>  fw_load_sysfs_fallback+0x354/0x468
>  fw_load_from_user_helper+0x17c/0x1c0
>  firmware_fallback_sysfs+0xc0/0x11c
>  _request_firmware+0xe0/0x4a4
>  request_firmware+0x20/0x2c
> /* ... */

OK so this proves the bug can happen but I'd like to see the full trace
and the exact kernel version showing that this can happen on a recent
kernel. Without that I'm not seeing how this can trigger yet.

It would be easy to prove with the selftests.

  Luis
