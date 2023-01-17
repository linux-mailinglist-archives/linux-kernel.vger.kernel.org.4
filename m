Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B06670C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjAQWtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjAQWrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:47:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81D749012;
        Tue, 17 Jan 2023 13:50:41 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673992240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kRvzgCBVx5CsqZCT0iVya/YuDwD7HvQx/Cdez2OwYE=;
        b=FmB0R3FWVjeezvBTl+OQJhL03fZ9wAuT6NypmKWIyV9GNt1Fq1xulnRnzRI1YsJqDNaijF
        3gUGS/eoBjK+CB1Tk5PE6FX/fqZe8oBmJEKH7crllx2jlfcuVs9qUn8fqT0Ksm4t2/KHWg
        qvAeQLfjoDK5StxfglOc/NIGTz2JIVKofzXUhmfIK6rgIRqI03lDOhtduH70Oh1JNYpSh7
        hI8v9nXWiE+1oEiZKM8vv2yG6m4948t3ubhOi25Vd2Gl3jg5grNKEbNnxHvScJc+sr3ZFI
        3x4HI7ztFPTZ17igeR5EpjZbgrN4VHYjptf1vtQrx60zBqvc7W1WbYFfm4sIZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673992240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kRvzgCBVx5CsqZCT0iVya/YuDwD7HvQx/Cdez2OwYE=;
        b=yjCanFJ8Zq9WV1KKf+FZelQ0VydqlG6wcxsPQ3lHAcaYAt6NUH8Cd1kwT4oXLHjvlfNaZJ
        K9L7IPHH/y1qWOBg==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 19/19] irqdomain: Switch to per-domain locking
In-Reply-To: <20230116135044.14998-20-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-20-johan+linaro@kernel.org>
Date:   Tue, 17 Jan 2023 22:50:39 +0100
Message-ID: <87mt6gkez4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
> The IRQ domain structures are currently protected by the global
> irq_domain_mutex. Switch to using more fine-grained per-domain locking,
> which may potentially speed up parallel probing somewhat.

Does it or not?

If not then why adding all this churn for no real value?

Thanks,

        tglx
