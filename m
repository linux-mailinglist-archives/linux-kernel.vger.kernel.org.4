Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514F6609D09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiJXIpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJXIpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F9E326DC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4278A60DED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F375C433C1;
        Mon, 24 Oct 2022 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666601127;
        bh=ZO+VTgM9VXFmY0M8fHk7daynC/+MUDqZPORFLMaf1p0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUqqAC4bIyRX+W8dkbjaB7d8Ps2quaTmJ8ioBl5od+rzUAHxy+OBjrpkkiI6itvmC
         dTcEKG+ZxT5S5N/uE3XCu82khuCB37wqEJSP5j5c8hkaBfEUfUDE0TmMPu3MbwAs04
         6m4332DqwYDTUs7wCeU3FfFaZf75Jo6qxZrRXUl4=
Date:   Mon, 24 Oct 2022 10:45:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1ZQpcdK4sdy+5QZ@kroah.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZQSEMLkybFCadS@kroah.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:43:52AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 24, 2022 at 11:26:10AM +0300, Sakari Ailus wrote:
> > container_of() casts the original type to another which leads to the loss
> > of the const qualifier if it is not specified in the caller-provided type.
> > This easily leads to container_of() returning a non-const pointer to a
> > const struct which the C compiler does not warn about.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  include/linux/container_of.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> > index 2f4944b791b81..c7c21d0f41a87 100644
> > --- a/include/linux/container_of.h
> > +++ b/include/linux/container_of.h
> > @@ -13,6 +13,10 @@
> >   * @type:	the type of the container struct this is embedded in.
> >   * @member:	the name of the member within the struct.
> >   *
> > + * WARNING: as container_of() casts the given struct to another, also the
> 
> No need for "also" here (sorry for the grammar nit.)
> 
> > + * possible const qualifier of @ptr is lost unless it is also specified in
> > + * @type. This is not a problem if the containing object is not const. Use with
> > + * care.
> 
> I do not think these last two sentences you added here are needed
> either.
> 
> 
> >   */
> >  #define container_of(ptr, type, member) ({				\
> >  	void *__mptr = (void *)(ptr);					\
> > @@ -27,6 +31,11 @@
> >   * @type:	the type of the container struct this is embedded in.
> >   * @member:	the name of the member within the struct.
> >   *
> > + * WARNING: as container_of() casts the given struct to another, also the

Wrong function name here.

> > + * possible const qualifier of @ptr is lost unless it is also specified in
> > + * @type. This is not a problem if the containing object is not const. Use with
> > + * care.
> 
> Same comments here.

Wait, no one uses this macro, so why not just remove it entirely?

thanks,

greg k-h
