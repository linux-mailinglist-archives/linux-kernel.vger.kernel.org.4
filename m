Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B77659C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 23:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiL3WAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 17:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiL3V76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:59:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A481CFF7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 13:59:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ACAB61C2E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607C6C433EF;
        Fri, 30 Dec 2022 21:59:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A9NOIL6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672437593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lt8RccqW0EZGdcsp4V34geQbTFJgnELz8Rhyk+5m6GU=;
        b=A9NOIL6GumZlZuuJSvm/ukN5gXjRMFRJ8nI5syRESrj3smE5vsP1yiFDnW1Bg2c1c8A6tq
        opxkL3iQhoNYF9aXaoi8j73Iq0Zu5M66COrEPPC/Vbk8/4PsQbZAg00VfABM6cc+HNzYST
        2hhOJkykZcSSV4ZgVvuFTKIKzUzxg60=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fdaa9073 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Dec 2022 21:59:53 +0000 (UTC)
Date:   Fri, 30 Dec 2022 22:59:46 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, hpa@zytor.com, bp@alien8.de,
        philmd@linaro.org
Subject: Re: [PATCH qemu v2] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y69fUstLKNv/RLd7@zx2c4.com>
References: <20221230183819.604388-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221230183819.604388-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 07:38:19PM +0100, Jason A. Donenfeld wrote:
> The microvm machine has a gross hack where it fiddles with fw_cfg data
> after the fact. So this hack is updated to account for this appending,
> by reserving some bytes.

This is a little derpy. I'll send a v3 in a second to clean this up.
