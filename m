Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC3C661F02
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjAIHIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjAIHIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:08:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4061157;
        Sun,  8 Jan 2023 23:07:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C06F9CE0E95;
        Mon,  9 Jan 2023 07:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001ACC433F0;
        Mon,  9 Jan 2023 07:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673248075;
        bh=Zwa/0Kc9RycNQnqCv0qfKsVWUve+AEFePq/i81NsDEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3zMiOBPFIu23E6+s5kU6iMY1QAgTfsXd/W2nB40wUjffSrgdl1xdlnUPfcdq539z
         sR8cX8glQzBoUdDdR87J3aQETNpL3xAOCp+ZhAcYyl19hKv9dXZgQW24Al20mZzV2a
         sVwtWQzw+wCf3u99Gvag9CKunlSPbaPQ2pM4SJuI=
Date:   Mon, 9 Jan 2023 08:07:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: atmel: fix incorrect baudrate setup
Message-ID: <Y7u9SAX++YsXvnVC@kroah.com>
References: <20230109070200.200181-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109070200.200181-1-t.schramm@manjaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 08:02:00AM +0100, Tobias Schramm wrote:
> Commit ba47f97a18f2 ("serial: core: remove baud_rates when serial console
> setup") changed uart_set_options to select the correct baudrate
> configuration based on the absolute error between requested baudrate and
> available standard baudrate settings.
> Prior to that commit the baudrate was selected based on which predefined
> standard baudrate did not exceed the requested baudrate.
> This change of selection logic was never reflected in the atmel serial
> driver. Thus the comment left in the atmel serial driver is no longer
> accurate.
> Additionally the manual rounding up described in that comment and applied
> via (quot - 1) requests an incorrect baudrate. Since uart_set_options uses
> tty_termios_encode_baud_rate to determine the appropriate baudrate flags
> this can cause baudrate selection to fail entirely because
> tty_termios_encode_baud_rate will only select a baudrate if relative error
> between requested and selected baudrate does not exceed +/-2%.
> Fix that by requesting actual, exact baudrate used by the serial.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---

What commit id does this fix?  Please list that as a the "Fixes:" tag.

Also, does this need to go to older/stable kernels?

thanks,

greg k-h
