Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC5B604CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJSQDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJSQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:02:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663B2120EF7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:01:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F12AB824FA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC61C433C1;
        Wed, 19 Oct 2022 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666195304;
        bh=GihHyTSy2xQe2pRTAJxMrcMP9JdqHBFRWGP16YIKPD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=durc5FUE3XHNVactgpcfBT4GMJkIfVXWeDUghddaWMG0gLfkBD8uOgLXEcbYtS4lX
         4uFjPpMgla2ymtkoBrvD/EvBHkez5ZvTD6umVSjPRJ1ykmstZrzywBpbSvn9tf8UCV
         Rck0R/fmQv0Zvg+3s0Vie5NvdcLR5Qj8HPWHkm2s=
Date:   Wed, 19 Oct 2022 18:01:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 04/38] printk: introduce console_is_enabled()
 wrapper
Message-ID: <Y1AfYCpZr6Errg7a@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:01:26PM +0206, John Ogness wrote:
> After switching to SRCU for console list iteration, some readers
> will begin accessing console->flags as a data race. This is safe
> because there is at most one CPU modifying console->flags and
> using rmw operations.
> 
> The primary reason for readers to access console->flags is to
> check if the console is enabled. Introduce console_is_enabled()
> to mark such access as a data race.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
