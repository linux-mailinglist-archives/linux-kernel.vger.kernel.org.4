Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD36E72EBD9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjFMTXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjFMTXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:23:22 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 445281A3;
        Tue, 13 Jun 2023 12:23:19 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 4C68BE0DE9;
        Tue, 13 Jun 2023 22:23:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=zwaZB7EIoXwjK7JA+PxW
        ghZnbZYcLtoPqynXw2gl3Kk=; b=dFC65nNcaau9CQ55vIdPARkyVudUWAuQghMh
        yMt3RaJWVQTuyJjIc/3FArVFyViYGVDcLxcBB3ShyWGxuHWzPVDLTiKhq9TTpLd6
        adev6Qp7BL8TjM6REjvr8mWmSekhgsgLKTQwS2/mZ+6SJXh3y+X6yZy+XgFGrllT
        IW7xm0A=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 1D6C1E0DE4;
        Tue, 13 Jun 2023 22:23:18 +0300 (MSK)
Received: from mobilestation (10.8.30.34) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Jun 2023 22:23:17 +0300
Date:   Tue, 13 Jun 2023 22:23:17 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 2/3] device property: Implement device_is_compatible()
Message-ID: <20230613192317.lsk5nqo6vkhnhz52@mobilestation>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-3-andriy.shevchenko@linux.intel.com>
 <20230613094508.mnmktmmt4l657ymj@mobilestation>
 <ZIiH1iAbjLoUScyb@smile.fi.intel.com>
 <ZIiH66uEQ6U7tdXB@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIiH66uEQ6U7tdXB@smile.fi.intel.com>
X-Originating-IP: [10.8.30.34]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 06:14:51PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 13, 2023 at 06:14:30PM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 13, 2023 at 12:45:08PM +0300, Serge Semin wrote:
> > > On Fri, Jun 09, 2023 at 06:48:59PM +0300, Andy Shevchenko wrote:
> > > > Some users want to use the struct device pointer to see if the
> > > > device is compatible in terms of Open Firmware specifications,
> > > > i.e. if it has a 'compatible' property and it matches to the
> > > > given value. Provide inline helper for the users.
> > > 
> > > IMO much useful wrapper. Thanks for the patch.
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > There is a v3. Do you mind to tag it as well?
> 
> Ah, and thank you for review! Appreciate it.

Always welcome.) I've resent the tags for the patches 2 and 3. Patch 1
is out of my competence, sorry.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

