Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C966E5DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjDRJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjDRJl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:41:27 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5C47170E;
        Tue, 18 Apr 2023 02:41:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9FFF38106;
        Tue, 18 Apr 2023 09:41:24 +0000 (UTC)
Date:   Tue, 18 Apr 2023 12:41:23 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Clear port->pm on port specific driver
 unbind
Message-ID: <20230418094123.GA14287@atomide.com>
References: <20230413070342.36155-1-tony@atomide.com>
 <ZDgoi2mFYYqswAhu@smile.fi.intel.com>
 <20230414054726.GE36234@atomide.com>
 <63b333cb-13c7-db58-9cf-697aa1c4c48a@linux.intel.com>
 <20230414094035.GF36234@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414094035.GF36234@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230414 09:40]:
> I'm now wondering still if we should clear all the conditional hardware
> specific functions too in addition to port->pm that get set in
> serial8250_register_8250_port(). Maybe best done in a separate patch
> as needed.. Any suggestions?

Well we can't do memset on the port for sure at this point.. But what
we can do is call serial8250_set_defaults() instead of clearing just
port->pm. This will set the port back to serial8250 default functions,
and will set port->pm too.

I'll send v2 patch after some more testing.

Regards,

Tony
