Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8806670D54
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjAQX0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjAQX0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:26:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C838B4A;
        Tue, 17 Jan 2023 13:23:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673990600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9cR92r6412sVEgsFseieEmbL64hVIExQVx/uajzRUqs=;
        b=4gvMSIqJNtFm0M4IlaLBv7hv9uh6wP/jv5tuk+SV8v0eTmaYmF1JpftSG0ZJy0oBApIwa0
        w+F2HouWmAJVKfl5R+L+cea7gKk3FrL+h9hnITaMdz3/IS66/In2gga9M+EUwbEsl+YbY+
        vP94ozvjRJSEvNh4gJ4qLAtMLC8W3wy3+HGT+21nDnmwNeuIrRVwCTg4degx5NlUuPF31m
        F+VGgGqJAqEJjJfZ9a84Fi65CQtT2qryxyGVmG3p4UNaVPZVmyLGFuWDQH6OMlHYT1zkU/
        cL3/8dMghsZ2FdahcLDDPgj1rmU533JPtI/aFr+MJE1GmoVtAMRxk8wCIZmXtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673990600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9cR92r6412sVEgsFseieEmbL64hVIExQVx/uajzRUqs=;
        b=IazwIGkx4PC9hoLOSFvpMA991cbQcJeJhX2yOasyZlxAXJ+KRq46Q/ubauNBbC2xEC/u7P
        tjfvpSXkS3vXS1CA==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 06/19] irqdomain: Drop revmap mutex
In-Reply-To: <20230116135044.14998-7-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-7-johan+linaro@kernel.org>
Date:   Tue, 17 Jan 2023 22:23:20 +0100
Message-ID: <871qnslut3.ffs@tglx>
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
> The global irq_domain_mutex is now held in all paths that update the
> revmap structures so there is no longer any need for the revmap mutex.

This can also go after the 3rd race fix, but ...

>  static void irq_domain_clear_mapping(struct irq_domain *domain,
>  				     irq_hw_number_t hwirq)
>  {
> +	lockdep_assert_held(&irq_domain_mutex);

these lockdep asserts want to be part of the [dis]association race
fixes. They are completely unrelated to the removal of the revmap_mutex.

Your race fixes change the locking and you want to ensure that all
callers comply right there, no?

Thanks,

        tglx
