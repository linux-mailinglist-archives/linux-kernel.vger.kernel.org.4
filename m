Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA2871FEB7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjFBKNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjFBKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:13:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B85C0;
        Fri,  2 Jun 2023 03:13:34 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685700812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7GzoTaph3PJwwLQgPyik4Eh+bbnZRkPzskpAeL6aSA=;
        b=GG3G5mL0bgKlxf6U+FJBDL6Q1lUEIKeL4TxsOPB4fSfBkk/fcfVyWWUUtHTLjysXvihtjX
        dg/Seh5PS7j7QK8kubfn/HKaB7/ZGg32l+FqXnwtp/F2PYanop+GXVgwZaSB6EkgPisrPn
        ggoMEaq4XMMOL2r2rylrdWLpFiOqzEBJD+mv+6BjNvwaq7B/HZguez5Q5EooMkyH84lBZv
        14tq4SpYgp3gpUBXRKME+aWk0wr+c912N7Vn4rkCZf0UoVV8TlTC8NMG7Z6UCJViu5Ts2o
        knwkQycTe/KoOm1C4W6hDbK2YxTF4GgwTOyOwQ4sVhhYA2FZ8QmEQGHOl0OasA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685700812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7GzoTaph3PJwwLQgPyik4Eh+bbnZRkPzskpAeL6aSA=;
        b=mZtG4RT88sue4AZKYDqVM5VkrPwnXz/sPSOFAK7alYyAi80FpCRuwryq9FZ70KRmumsdmx
        VsglgIllqcsaEDDA==
To:     Chen-Yu Tsai <wenst@chromium.org>, Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
In-Reply-To: <20230602083335.GA181647@google.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <20230602083335.GA181647@google.com>
Date:   Fri, 02 Jun 2023 12:19:28 +0206
Message-ID: <87a5xii33r.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-02, Chen-Yu Tsai <wenst@chromium.org> wrote:
> This patch, in linux-next since 20230601, unfortunately breaks
> MediaTek based Chromebooks. The kernel hangs during the probe of the
> serial ports, which use the 8250_mtk driver.

Are you sure it is this patch? Have you bisected it?

Unfortunately next-20230601 also brought in a series that added
spinlocking to the 8250 driver. That may be the issue here instead.

For 8250 bug reports we really need to bisection.

John Ogness
