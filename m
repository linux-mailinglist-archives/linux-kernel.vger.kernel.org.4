Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14B5659B60
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiL3SbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiL3SbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:31:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1230711160
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:31:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0FBDB81CF1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 18:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05574C433EF;
        Fri, 30 Dec 2022 18:31:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J3B4XhDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672425062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXt2pVTyOEWOaU+OtHDx5id1pyeiBSa5KFgN5fm5To8=;
        b=J3B4XhDzHiZNH3A6G96GIpz/KipVLvZ1RxVHyk65whTC9NrpoVhIPmEqFC9bLj1QBihQKf
        8AbhgrLypG41a+slb7Y5xXqqMLBLQ9o6eNyaZZ5YWl8TSEMIoEZGKJxvnQx6F6Cinw7v7F
        v9vMMBimh77q0o5DSPfiV4C2I9ADqF4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 42803c24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Dec 2022 18:31:02 +0000 (UTC)
Date:   Fri, 30 Dec 2022 19:30:58 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, hpa@zytor.com, bp@alien8.de
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y68uYvfd66IYPpy/@zx2c4.com>
References: <20221228143831.396245-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221228143831.396245-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:38:30PM +0100, Jason A. Donenfeld wrote:
> The setup_data links are appended to the compressed kernel image. Since
> the kernel image is typically loaded at 0x100000, setup_data lives at
> `0x100000 + compressed_size`, which does not get relocated during the
> kernel's boot process.
> 
> The kernel typically decompresses the image starting at address
> 0x1000000 (note: there's one more zero there than the decompressed image
> above). This usually is fine for most kernels.
> 
> However, if the compressed image is actually quite large, then
> setup_data will live at a `0x100000 + compressed_size` that extends into
> the decompressed zone at 0x1000000. In other words, if compressed_size
> is larger than `0x1000000 - 0x100000`, then the decompression step will
> clobber setup_data, resulting in crashes.
> 
> Fix this by detecting that possibility, and if it occurs, put setup_data
> *after* the end of the decompressed kernel, so that it doesn't get
> clobbered.
> 
> One caveat is that this only works for images less than around 64
> megabytes, so just bail out in that case. This is unfortunate, but I
> don't currently have a way of fixing it.
 
I've got a different solution now that tries to piggy back on cmdline.
I'll send a v2. It avoids the 62MiB crash situation of this one and
seems to work fine.
