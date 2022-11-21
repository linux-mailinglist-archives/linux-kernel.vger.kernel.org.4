Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF8632CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKUTXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKUTXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:23:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B0182BDC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PC5Ekwbg7mjr8ndTEQw6b2xgl9D7W1S/NH0d0WeHLRM=; b=RUzOio/LA2TUG7Jx8teEDurJvk
        ePEfQ1qQqBjJHRKq3qsFa3P+g2ICnoUyZTlfuc77tFADL1cBwZJ+kRrOcv8flzOBV2T0QhyztpJdn
        GR0Rcy8Qt7qjww/i9vryMWpF3N2+3i7ERCaYsrnRklDi3VyJV/EWBA0pH7RXgYZ2lo5fuLNXasn9r
        c6bdAzblnM3Hi5IODOxhTmW8jEt2jPTfA44yW5uwIkAQ6l1RnkRAaLo5eSikcyFElwREZxUYjiBmx
        92YPiZo+AvIEUVQevEswyuOGeiyrQw/fyIc9eBd2/Dbsffxtg0Ru7Jn5Bt89nhbuDZOsLffNOibKA
        tHjJS/sw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxCNp-00HE8L-Vn; Mon, 21 Nov 2022 19:23:09 +0000
Date:   Mon, 21 Nov 2022 11:23:09 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        russell.h.weight@intel.com, tianfei.zhang@intel.com,
        error27@gmail.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH] test_firmware: fix memory leak in test_firmware_init()
Message-ID: <Y3vQHTZpjNijVjiM@bombadil.infradead.org>
References: <20221119035721.18268-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119035721.18268-1-shaozhengchao@huawei.com>
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

On Sat, Nov 19, 2022 at 11:57:21AM +0800, Zhengchao Shao wrote:
> When misc_register() failed in test_firmware_init(), the memory pointed
> by test_fw_config->name is not released. The memory leak information is
> as follows:
> unreferenced object 0xffff88810a34cb00 (size 32):
>   comm "insmod", pid 7952, jiffies 4294948236 (age 49.060s)
>   hex dump (first 32 bytes):
>     74 65 73 74 2d 66 69 72 6d 77 61 72 65 2e 62 69  test-firmware.bi
>     6e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  n...............
>   backtrace:
>     [<ffffffff81b21fcb>] __kmalloc_node_track_caller+0x4b/0xc0
>     [<ffffffff81affb96>] kstrndup+0x46/0xc0
>     [<ffffffffa0403a49>] __test_firmware_config_init+0x29/0x380 [test_firmware]
>     [<ffffffffa040f068>] 0xffffffffa040f068
>     [<ffffffff81002c41>] do_one_initcall+0x141/0x780
>     [<ffffffff816a72c3>] do_init_module+0x1c3/0x630
>     [<ffffffff816adb9e>] load_module+0x623e/0x76a0
>     [<ffffffff816af471>] __do_sys_finit_module+0x181/0x240
>     [<ffffffff89978f99>] do_syscall_64+0x39/0xb0
>     [<ffffffff89a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
