Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4349F6B8BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCNHG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCNHG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:06:27 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78F5F74A6E;
        Tue, 14 Mar 2023 00:06:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E46C380C1;
        Tue, 14 Mar 2023 07:06:23 +0000 (UTC)
Date:   Tue, 14 Mar 2023 09:06:22 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        oe-kbuild-all@lists.linux.dev,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230314070622.GL7501@atomide.com>
References: <20230309085713.57700-1-tony@atomide.com>
 <202303100516.22vtkWv4-lkp@intel.com>
 <20230310065238.GJ7501@atomide.com>
 <ZAs0pvTByHWbb+9N@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAs0pvTByHWbb+9N@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Andy Shevchenko <andriy.shevchenko@intel.com> [230310 13:46]:
> On Fri, Mar 10, 2023 at 08:52:38AM +0200, Tony Lindgren wrote:
> > * kernel test robot <lkp@intel.com> [230309 21:31]:
> > > >> drivers/tty/serial/serial_ctrl.c:17:34: warning: 'serial_ctrl_pm' defined but not used [-Wunused-const-variable=]
> > >       17 | static DEFINE_RUNTIME_DEV_PM_OPS(serial_ctrl_pm, NULL, NULL, NULL);
> > >          |                                  ^~~~~~~~~~~~~~
> > 
> > Thanks I'll tag it with __maybe_unused.
> 
> It requires to use pm_ptr() macro, it was designed exactly to *not* spread
> __maybe_unused.

Heh yeah.. Turns out the issue here is that the serial_ctrl_pm ops is not
used at all for serial_ctrl.c and can be just dropped.

Regards,

Tony
