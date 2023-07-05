Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57FB748210
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGEKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjGEKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:25:00 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193E122
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:24:59 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 2fe35dd4-1b1e-11ee-abf4-005056bdd08f;
        Wed, 05 Jul 2023 13:24:57 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 5 Jul 2023 13:24:56 +0300
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v2 3/5] spi: Add support for Renesas CSI
Message-ID: <ZKVE-AVDhvZyrJmj@surfacebook>
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
 <20230622113341.657842-4-fabrizio.castro.jz@renesas.com>
 <CAMuHMdVsYohH5FVv6r4ha0AaHRoHjNF1ErjW1FNF7ZAQR9ntxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVsYohH5FVv6r4ha0AaHRoHjNF1ErjW1FNF7ZAQR9ntxg@mail.gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 03, 2023 at 12:19:26PM +0200, Geert Uytterhoeven kirjoitti:
> On Thu, Jun 22, 2023 at 1:34 PM Fabrizio Castro
> <fabrizio.castro.jz@renesas.com> wrote:

...

> > +       if (csi->txbuf)
> > +               /*
> > +                * Leaving a little bit of headroom in the FIFOs makes it very
> > +                * hard to raise an overflow error (which is only possible
> > +                * when IP transmits and receives at the same time).
> > +                */
> > +               to_transfer = min_t(int, CSI_FIFO_HALF_SIZE, bytes_remaining);
> > +       else
> > +               to_transfer = min_t(int, CSI_FIFO_SIZE_BYTES, bytes_remaining);
> 
> Why min_t(int, ...)? Both values are int.

min_t() should be used with a great care.

> It would be better to make both unsigned, though.

I believe you are assuming 3 (three) values and not 2 (two) under "both"
(one variable and two definitions).

-- 
With Best Regards,
Andy Shevchenko


