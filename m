Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841D8646B71
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLHJH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiLHJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:07:05 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD3C6932B;
        Thu,  8 Dec 2022 01:05:42 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id z17so389095qki.11;
        Thu, 08 Dec 2022 01:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCZaqfL2y6oIi6qLsen9O1deOB3/ZmHwo5ZQSP89+xA=;
        b=qSqMknCYgFU577LvCwAsCpl7Cx6TjvOg0CnwpYvc+W8/x8bPJe7sP2tbvrBoLMB2YE
         cRpetONhy/av3o/fZd3oQGFYbQEKP0v4frp/0eESwBi+L8CuItrwub+1x12eFh8e0X2H
         5uPLE/WmpVr7Rdo4jkm+JDsCLWXWgwAU2JEb39oCVnW8tQL3GOnzIzMMDacLQKW1ate4
         N89o2EtNJv5e7fd1tXYr95k0oBzQE5Az7pWDZvlNKkv0s3Xo+6TTXTpk/ZWXFGB3t20V
         74C1XPfDJvqjXBr2Za0qZMz0lQNRoYDB679/5JpypRWCV+q4jSlltVH95M/bUFTU6Qr9
         fBzw==
X-Gm-Message-State: ANoB5pkCL5/Cw4vBCM34LS7iBIrcxLMRFueR43KiX+DUXdU1AuotsqoH
        /81XzpgFy7XCbNFBq5gmZKmblGacNHFqkA==
X-Google-Smtp-Source: AA0mqf7cuDXYaD0qMZul8zY7D6cXsEuiDiUwx4kykcoQr08hPHEu2y87dRy/NqKsDVBU34uyyhI5Kw==
X-Received: by 2002:a37:bf46:0:b0:6fa:894c:da6d with SMTP id p67-20020a37bf46000000b006fa894cda6dmr83297302qkf.527.1670490341100;
        Thu, 08 Dec 2022 01:05:41 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id ck15-20020a05622a230f00b0039953dcc480sm15330451qtb.88.2022.12.08.01.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:05:40 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id g4so878781ybg.7;
        Thu, 08 Dec 2022 01:05:40 -0800 (PST)
X-Received: by 2002:a25:7a02:0:b0:6f7:952d:b145 with SMTP id
 v2-20020a257a02000000b006f7952db145mr41094078ybc.604.1670490339896; Thu, 08
 Dec 2022 01:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20221207162435.1001782-1-herve.codina@bootlin.com> <20221207162435.1001782-7-herve.codina@bootlin.com>
In-Reply-To: <20221207162435.1001782-7-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Dec 2022 10:05:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVxegUAK+C1X_591=3Uup6Qa_R=Q0TydYJ6TCP5-789pg@mail.gmail.com>
Message-ID: <CAMuHMdVxegUAK+C1X_591=3Uup6Qa_R=Q0TydYJ6TCP5-789pg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] soc: renesas: r9a06g032-sysctrl: Handle h2mode
 setting based on USBF presence
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 5:24 PM Herve Codina <herve.codina@bootlin.com> wrote:
> The CFG_USB[H2MODE] allows to switch the USB configuration. The
> configuration supported are:
>   - One host and one device
> or
>   - Two hosts
>
> Set CFG_USB[H2MODE] based on the USBF controller (USB device)
> availability.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
