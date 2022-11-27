Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AF6639D97
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 23:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiK0W24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 17:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiK0W2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 17:28:55 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2545F5F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 14:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669588130; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:in-reply-to:
         references; bh=gGhS+gjWIS8ZrXKdyUu4RaesR9AwE+r1bkf2O8duDok=;
        b=rzUG5fJ64gHF86zW+bwbeAu50Hk4CmIIEQk1MpzDaufwF2WBmrRsudPOal4LNnKwIC6HmZ
        Ei4c04Xi/fTXCzvzN/RgqGYta4eaKISK6unBza3kyEDXhVm4XYb53qR8hxzIrkICNg3MGB
        thJGzrNqjiDG6MdsRdlLZv053EJ20hM=
Date:   Sun, 27 Nov 2022 22:28:41 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: of_reserved_mem_device_init() prints kernel memory in dmesg
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Message-Id: <TF21MR.NSQQ6SJI3CJ7@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, Marek,

Here's what I get in dmesg on a 6.1-rc6 kernel:

OF: fdt: Reserved memory: reserved region for node 
'video-memory@1f00000': base 0x01f00000, size 1 MiB
OF: reserved mem: initialized node video-memory@1f00000, compatible id 
shared-dma-pool
ingenic-drm 13050000.lcd-controller: assigned reserved memory node 
<garbage data...>

I would *think* it's because the name is obtained using fdt_get_name() 
in fdt_scan_reserved_mem(), and the pointer becomes invalid as soon as 
the FDT is freed (is it freed?).

Not sure how to fix that myself, I tried to kstrdup(uname) in 
fdt_reserved_mem_save_node(), but it gives me a NULL pointer, probably 
too early in the boot process?

Cheers,
-Paul


