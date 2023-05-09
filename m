Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8B6FBFC4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjEIG6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjEIG6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:58:05 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1B10D071;
        Mon,  8 May 2023 23:57:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 47CD6804D;
        Tue,  9 May 2023 06:57:59 +0000 (UTC)
Date:   Tue, 9 May 2023 09:57:58 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v10 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230509065758.GZ14287@atomide.com>
References: <20230508110339.38699-1-tony@atomide.com>
 <202305090752.w4XZxmsN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305090752.w4XZxmsN-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <lkp@intel.com> [230508 23:13]:
> >> drivers/tty/serial/serial_base_bus.c:97:13: warning: variable 'id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>            } else if (type == &serial_port_type) {
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/tty/serial/serial_base_bus.c:102:77: note: uninitialized use occurs here
>            err = dev_set_name(&sbd->dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
>                                                                                       ^~
>    drivers/tty/serial/serial_base_bus.c:97:9: note: remove the 'if' if its condition is always true
>            } else if (type == &serial_port_type) {
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/tty/serial/serial_base_bus.c:83:13: note: initialize the variable 'id' to silence this warning
>            int err, id;
>                       ^
>                        = 0
>    1 warning generated.

Thanks I'll just add else goto err_free_dev for unknown types.

Regards,

Tony
