Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570E6646D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiLHKko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiLHKkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:40:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3065C0C5;
        Thu,  8 Dec 2022 02:35:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1603A33791;
        Thu,  8 Dec 2022 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670495736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m4BtgX7iuUEohIxHVLiyV8sjI0sG1CemLNb9OtXHuyE=;
        b=sqBMBGxUS2aksX5AHpvvEhCJZ2pjVIua73CcaodAUua2Rs6GLBLoz7AozXIe3auL5QkAMp
        hduTOwQ81EpFiTxmD2Dq5y5gjoqLfNiRIkKlYpoIPzjLWJklJBDoD/nZynRH35/r3FJicU
        F0m1zuTpL3d9L52rPbju9b+WR84nkok=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8DAD82C153;
        Thu,  8 Dec 2022 10:35:33 +0000 (UTC)
Date:   Thu, 8 Dec 2022 11:35:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 1/4] media: ipu3-cio2: Don't dereference fwnode handle
Message-ID: <Y5G99yAmflKJpF32@alley>
References: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
 <Y35wQuIbiCxyaOyp@smile.fi.intel.com>
 <Y5BWuXjipZcMXlan@paasikivi.fi.intel.com>
 <Y5BiiAwukaVrIvpF@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5BiiAwukaVrIvpF@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-12-07 11:53:12, Andy Shevchenko wrote:
> On Wed, Dec 07, 2022 at 09:02:49AM +0000, Sakari Ailus wrote:
> > On Wed, Nov 23, 2022 at 09:10:58PM +0200, Andy Shevchenko wrote:
> > > Dunno what happened to my previous reply to this. Okay, trying again...
> > > 
> > > + Cc: Petr, Sergey
> > > 
> > > On Mon, Nov 21, 2022 at 05:27:01PM +0200, Andy Shevchenko wrote:
> > > > Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
> > > > which is a better coding practice.
> > > 
> > > It appears that this series depends on fd070e8ceb90 ("test_printf: Refactor
> > > fwnode_pointer() to make it more readable") which is in PRINTK tree.
> > > 
> > > Sakari, Mauro, if you are okay to route this via that tree, can we get your
> > > tags for that? Otherwise we need to postpone this till v6.2-rc1 (but I would
> > > like to decrease the chances to appear a new user of the to be removed API).
> > > 
> > > Note, that Greg Acked v1 of the swnode patches (which are the same in v2).
> > 
> > Sorry for the late reply. Feel free to do that if it's not too late, with:
> > 
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Thank you!
> I think it's a bit late for printk tree to consume this. If it's the case
> (Petr?) then I will submit a new version after v6.2-rc1 is out.

Yes, I am sorry but it is too late for the printk tree. I am going to
send the pull request for 6.2 today or tomorrow. Linus explicitly
asked to send the pull request early this time because the merge
window will be overlapping with the holidays.

On the positive side. There is a high chance that the changes from
the printk tree will be in the mainline early enough so that you
could manage to send this still during the merge window.

Best Regards,
Petr
