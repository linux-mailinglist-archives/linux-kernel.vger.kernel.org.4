Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9633B643818
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiLEW2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLEW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:28:13 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A5426DC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:28:11 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id C2B5BC009; Mon,  5 Dec 2022 23:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670279298; bh=co4mLeZEIyazkvh2r1VcvDziHJ44lzOCp9RDU9TLwok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHNALYTllijiOhHJxNwg/dno58sA0voCZf550EHllbtK1LJ4UYroQiEu1BPsfpYB5
         XhARYMw5TTMjuoH56RCVu9d123lMAntmVbvp08AGW+BrWANXvhzEuF64w5lY/L2k8R
         u5G4v6S8fSIC0Iv4yoLQBAwU981b5TkbRwVvgwgEyUfKXCqXlNQcUyonm/szqKg7YE
         ScrHWQ6DDQO+En4xBM75bMuelkgWSpUQIyjpSzTX6WgpZHPvpGsmcUhq9F1t0rmlq+
         B+rbeX3AW4kVaRu0mAgpv39PX4nu7WSrLO2hxThZdjQASv4aAVOeafqaHqUzgbxZkk
         bfOmWkNEiqEAQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id A171EC009;
        Mon,  5 Dec 2022 23:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670279298; bh=co4mLeZEIyazkvh2r1VcvDziHJ44lzOCp9RDU9TLwok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHNALYTllijiOhHJxNwg/dno58sA0voCZf550EHllbtK1LJ4UYroQiEu1BPsfpYB5
         XhARYMw5TTMjuoH56RCVu9d123lMAntmVbvp08AGW+BrWANXvhzEuF64w5lY/L2k8R
         u5G4v6S8fSIC0Iv4yoLQBAwU981b5TkbRwVvgwgEyUfKXCqXlNQcUyonm/szqKg7YE
         ScrHWQ6DDQO+En4xBM75bMuelkgWSpUQIyjpSzTX6WgpZHPvpGsmcUhq9F1t0rmlq+
         B+rbeX3AW4kVaRu0mAgpv39PX4nu7WSrLO2hxThZdjQASv4aAVOeafqaHqUzgbxZkk
         bfOmWkNEiqEAQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8da8fe49;
        Mon, 5 Dec 2022 22:28:03 +0000 (UTC)
Date:   Tue, 6 Dec 2022 07:27:48 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] 9p/client: fix data race on req->status
Message-ID: <Y45wZEvO8gOanV85@codewreck.org>
References: <20221205124756.426350-1-asmadeus@codewreck.org>
 <3368929.hG1Ktuj5m1@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3368929.hG1Ktuj5m1@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Mon, Dec 05, 2022 at 04:19:01PM +0100:
> I must have missed the prior discussion, but looking at the suggested

Good point, I'll add a link to the report as well...
It's this thread:
https://lkml.kernel.org/r/CA+G9fYsK5WUxs6p9NaE4e3p7ew_+s0SdW0+FnBgiLWdYYOvoMg@mail.gmail.com

> solution: if there is no lock, then adding READ_ONCE() and WRITE_ONCE() would
> not fix cross-CPU issues, as those would not have a memory barrier in that
> case.
> 
> Shouldn't that therefore rather be at least smp_load_acquire() and
> smp_store_release() at such places instead?

The barrier is here -- I think we're just protecting against compiler
reordering or if on some arch the store isn't actually atomic.

This code path actually was broken before I added the barrier a while
ago (2b6e72ed747f68a03), as I was observing some rare but very real
errors on a big server so I'm fairly confident that for at least x86_64
the generated code isn't too bad, but if KCSAN helps catching stuff I
won't complain.

-- 
Dominique
