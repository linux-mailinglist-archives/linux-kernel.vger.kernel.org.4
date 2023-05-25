Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E37710ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbjEYLWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjEYLWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:22:51 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC410B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:22:49 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 793c14e4-faee-11ed-b972-005056bdfda7;
        Thu, 25 May 2023 14:22:46 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 25 May 2023 14:22:46 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 09/11] serial: sc16is7xx: add I/O register translation
 offset
Message-ID: <ZG9FBgX2useVeuWl@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-10-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040324.3773741-10-hugo@hugovil.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, May 25, 2023 at 12:03:23AM -0400, Hugo Villeneuve kirjoitti:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> If the shared GPIO pins on a dual port/channel variant like the
> SC16IS752 are configured as GPIOs for port A, and modem control lines
> on port A, we need to translate the Linux GPIO offset to an offset
> that is compatible with the I/O registers of the SC16IS7XX (IOState,
> IODir and IOIntEna).
> 
> Add a new variable to store that offset and set it when we detect that
> special case.

...

> +/*
> + * We may need to translate the Linux GPIO offset to a SC16IS7XX offset.
> + * This is needed only for the case where a dual port variant is configured to
> + * have only port B as modem status lines.
> + *
> + * Example for SC16IS752/762 with upper bank (port A) set as GPIOs, and
> + * lower bank (port B) set as modem status lines (special case described above):
> + *
> + * Pin         GPIO pin     Linux GPIO     SC16IS7XX
> + * name        function     offset         offset
> + * --------------------------------------------------
> + * GPIO7/RIA    GPIO7          3              7
> + * GPIO6/CDA    GPIO6          2              6
> + * GPIO5/DTRA   GPIO5          1              5
> + * GPIO4/DSRA   GPIO4          0              4
> + * GPIO3/RIB    RIB           N/A            N/A
> + * GPIO2/CDB    CDB           N/A            N/A
> + * GPIO1/DTRB   DTRB          N/A            N/A
> + * GPIO0/DSRB   DSRB          N/A            N/A
> + *
> + * Example  for SC16IS750/760 with upper bank (7..4) set as modem status lines,

Single space is enough.

> + * and lower bank (3..0) as GPIOs:
> + *
> + * Pin         GPIO pin     Linux GPIO     SC16IS7XX
> + * name        function     offset         offset
> + * --------------------------------------------------
> + * GPIO7/RI     RI            N/A            N/A
> + * GPIO6/CD     CD            N/A            N/A
> + * GPIO5/DTR    DTR           N/A            N/A
> + * GPIO4/DSR    DSR           N/A            N/A
> + * GPIO3        GPIO3          3              3
> + * GPIO2        GPIO2          2              2
> + * GPIO1        GPIO1          1              1
> + * GPIO0        GPIO0          0              0
> + */

Wondering if you can always register 8 pins and use valid mask to define which
one are in use?

-- 
With Best Regards,
Andy Shevchenko


