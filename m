Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BE65C345
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbjACPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjACPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:49:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D6912080;
        Tue,  3 Jan 2023 07:49:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83AA461456;
        Tue,  3 Jan 2023 15:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CEBC433EF;
        Tue,  3 Jan 2023 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672760943;
        bh=gOfiSj4aIN0UjAUIlvhoKrXaCz9kqH8r5kkeyMxL0JE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MWYw6ks3uaa3yHBfwsKUWTwZX0tws+dtkzHPzulH/Zya6jWU4xUUPdR77Y4jTcXa2
         pI338/eeFcAxjvMn1DROP2tWDQf/fWYz9f2m9zhB5cBVbm1NhQpBQGv7YnvCxvd85P
         E1oXVzNyvy8sxP4EikFSlnBEzFarygQDFOxD5jDxlVFX2T5cuF3bBc0/pKbImAsHcA
         0TCLwsy0DUyeEVqZmNScl7iW1KJ2gDsGAKszNOhjZhcaJe6HNsrU/EWd/ppOfxeSQ+
         vhVNartGqbxogEPuZ7aq38il6kHGCau22w4e5+U2UWGtuceVQ3clWG3zzOHBAajVqh
         JxFfQrv9S0nBA==
From:   Felipe Balbi <balbi@kernel.org>
To:     JaeHun Jung <jh0801.jung@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Seungchull Suh <sc.suh@samsung.com>,
        Daehwan Jung <dh10.jung@samsung.com>,
        JaeHun Jung <jh0801.jung@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
In-Reply-To: <20230102050831.105499-1-jh0801.jung@samsung.com>
References: <CGME20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3@epcas2p4.samsung.com>
 <20230102050831.105499-1-jh0801.jung@samsung.com>
Date:   Tue, 03 Jan 2023 17:48:58 +0200
Message-ID: <87cz7vvct1.fsf@balbi.sh>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

JaeHun Jung <jh0801.jung@samsung.com> writes:
> Sometimes very rarely, The count is 0 and the DWC3 flag is set has status.
> It must not have these status. Because, It can make happen interrupt storming
> status.
> So, It have to clean up DWC3_EVENT_PENDING flags set when count is 0.
> It means "There are no interrupts to handle.".
>
> (struct dwc3_event_buffer *) ev_buf = 0xFFFFFF883DBF1180 (
> 	(void *) buf = 0xFFFFFFC00DBDD000 = end+0x337D000,
> 	(void *) cache = 0xFFFFFF8839F54080,
> 	(unsigned int) length = 0x1000,
> 	(unsigned int) lpos = 0x0,
> 	(unsigned int) count = 0x0,
> 	(unsigned int) flags = 0x00000001,
> 	(dma_addr_t) dma = 0x00000008BD7D7000,
> 	(struct dwc3 *) dwc = 0xFFFFFF8839CBC880,
> 	(u64) android_kabi_reserved1 = 0x0),
>
> (time = 47557628930999, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628931268, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628932383, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628932652, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628933768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628934037, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628935152, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628935460, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628936575, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628936845, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628937960, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628938229, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628939345, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628939652, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628940768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628941037, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628942152, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628942422, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628943537, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628943806, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628944922, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628945229, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628946345, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628946614, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
> (time = 47557628947729, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
> (time = 47557628947999, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
>
> Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>

Please get in the habit of running patches through
scripts/get_maintainer.pl. If you did, it would tell you Thinh is the
new maintainer for dwc3.

-- 
balbi
