Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3063B5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiK1XaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiK1XaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:30:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AE5317D0;
        Mon, 28 Nov 2022 15:30:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72720614F0;
        Mon, 28 Nov 2022 23:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA60C433C1;
        Mon, 28 Nov 2022 23:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669678203;
        bh=oQ1NXyRzlFb173JCqIW8f1hvYKMUAyVNiwLTT7sk8vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4aplWhPIs7iqJ6AIaWGsS/0dP/m7uG+YwVnF6ol5zTqZJGcZ61WOk4Lbhse0+rUJ
         Gcs7nZFG2URkBSY7k4TT0AiQCdsKU9Q+PIQSUvBLVNnw9RCJlg6tXpSPctOSf3qqN4
         LDuASRQC7uXiqM6eRsR3yw6eFizPwXCl2GAYZT/SkRYAya3BKcnCV7co0wljbK+r1I
         s6rzLM6xdc6wB/JllmnInmwYBJz5kVfzB2DYK5zqKRReTfy0g3k3t75UmDZjJZupxf
         +NuTw3SKSvHwghFW8SyjnGlnFPAb6GzK+Dgp8h4qcj3zDULS1uCqNUaYVXucpNY++/
         Pvz2hWUzApaQQ==
Date:   Tue, 29 Nov 2022 07:20:09 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] serial: bflb_uart: add Bouffalolab UART Driver
Message-ID: <Y4VCKeeTS2zV1xcZ@xhacker>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-3-jszhang@kernel.org>
 <c0406076-04e1-6b81-1bba-ac684516d898@kernel.org>
 <Y4TD48v84CJcMS+S@xhacker>
 <e1f689d2-d337-5a42-e4c9-91c1d338b42b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1f689d2-d337-5a42-e4c9-91c1d338b42b@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 06:01:28PM +0200, Ilpo Järvinen wrote:
> On Mon, 28 Nov 2022, Jisheng Zhang wrote:
> 
> > On Mon, Nov 28, 2022 at 07:10:41AM +0100, Jiri Slaby wrote:
> > > On 27. 11. 22, 14:24, Jisheng Zhang wrote:
> > > > +static void bflb_uart_tx_chars(struct uart_port *port)
> > > 
> > > Again:
> > > 
> > > Are you unable to use the TX helper? If so:
> > 
> > You know serial subsystem better than me, may I ask for more
> > details? For example,
> > Besides uart_xmit_advance(), do you expect other TX helpers? If yes,
> > can you please list them?
> 
> Please take on look on commit 8275b48b278096edc1e3ea5aa9cf946a10022f79.
> The changes following that commit convert some drivers to use the tx 
> helper so you can look into them to see examples.

Thanks a lot for the hint. Will those tx helpers(uart_port_tx,
uart_port_tx_limited etc.) be in v6.2-rc1? Or I need to patch
based on Jiri's devel branch? Aha, Jiri says "at least uart_xmit_advance

> 
> > > * why?
> > > * use uart_advance_xmit() at least.
> > 
> > Do you mean uart_xmit_advance()? in the do while loop below?
> 
> Yes, Jiri had the name wrong. But your code looked like it could use 
> the tx helper instead.
