Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26398670DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjAQXfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjAQXeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC3F10F2;
        Tue, 17 Jan 2023 13:20:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673990446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFt1AJQ9n7qGyugZoMBl7mWBYMnX6oI/Uf8Kag8wje0=;
        b=NvUPD+FWtELzTgMxbE9uDL2FKa1hRDnJvkJKh6TK1nwWJdESVKTzRLOtgwCAnRCZv94iG+
        8YNU6ZRAyiWfB8WmDGifmKKfoQKiBJjTpCE1At9hpzbwQQXI0vT/k2mOZi8p6rzV01/KVs
        cSxE7XL2+1bVq9jZdmzR+YztzHYBOh/Q9vWORgjXiYi9Yj187fbjctDCb11f+ubqKjKEqU
        ZF23xjhRzJWOopLQlr71d5J6EsZDSYKBJWmq2o6CbZ1bbtZ6LoCVpGRw3W9IF83j3eTN+7
        VhLkf2sBDdRShXWGyjbkuCQpbYmiujP7rTRBPGmiSiYSLf0USsqg8oZpmpKtVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673990446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFt1AJQ9n7qGyugZoMBl7mWBYMnX6oI/Uf8Kag8wje0=;
        b=/Ktw//WEB6yelYeDZAO9repdpMW0rl4hya6E88cwj+07K0+gYzAbmtZI1P/iOX6LTBHEBN
        IczWgVOGX/eVb0AQ==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 04/19] irqdomain: Fix association race
In-Reply-To: <20230116135044.14998-5-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-5-johan+linaro@kernel.org>
Date:   Tue, 17 Jan 2023 22:20:46 +0100
Message-ID: <874jsoluxd.ffs@tglx>
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
> The sanity check for an already mapped virq was done outside of the

s/was/is/

> irq_domain_mutex-protected section which meant that an (unlikely) racing

s/meant/means/

> association may not be detected.

You describe the status quo and then correctly what the fix is:

> Fix this by factoring out the association implementation, which will
> also be used in follow-on changes to rework the locking.

Otherwise your fix fixes something which existed in the past, no?

Thanks,

        tglx
