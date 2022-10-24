Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8FB609D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiJXJMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiJXJL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:11:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50C859242
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666602717; x=1698138717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k4mXm3Uma4IzcE7u6k0jkX0nYTICoEZt5wd1Yg4s8pg=;
  b=E9JI+2b0hpRttbpKsA3R9QjOiMet9m9nLCGY+uO3B+N18fKqm5wwJaCt
   1thp1Fkyg6CZ5A+tPmxYEJ1xBOFVY/qfb7YaDvmEUnmj78w/30eFp+fXQ
   510K8mmSJUMPJgYEXuv3bHTgkLuOvF7QcpM8evGq22axaNX/LtbAWNyY1
   9aHH6UzkRXtGpmeXWMUw/izfTqcKmAF7js4I2nhCua1B4xSq9elh9wwQT
   7KTlsJ2won/G0ZYXdiunA8XePYgU9+4PA6/yub2Q6xp1OifQeOsE5Q1tf
   8GGoFVg835vlQIkArzi2ueXldG2aYjl0ta6HkWShlWme3hjM47/pK3xFP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="308467867"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="308467867"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 02:11:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="662374735"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="662374735"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 02:11:55 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id B2EBF201D5;
        Mon, 24 Oct 2022 12:11:53 +0300 (EEST)
Date:   Mon, 24 Oct 2022 09:11:53 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1ZW2WYli7Bfioxr@paasikivi.fi.intel.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
 <Y1ZQpcdK4sdy+5QZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZQpcdK4sdy+5QZ@kroah.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the comments.

On Mon, Oct 24, 2022 at 10:45:25AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 24, 2022 at 10:43:52AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 24, 2022 at 11:26:10AM +0300, Sakari Ailus wrote:
> > > container_of() casts the original type to another which leads to the loss
> > > of the const qualifier if it is not specified in the caller-provided type.
> > > This easily leads to container_of() returning a non-const pointer to a
> > > const struct which the C compiler does not warn about.
> > > 
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  include/linux/container_of.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> > > index 2f4944b791b81..c7c21d0f41a87 100644
> > > --- a/include/linux/container_of.h
> > > +++ b/include/linux/container_of.h
> > > @@ -13,6 +13,10 @@
> > >   * @type:	the type of the container struct this is embedded in.
> > >   * @member:	the name of the member within the struct.
> > >   *
> > > + * WARNING: as container_of() casts the given struct to another, also the
> > 
> > No need for "also" here (sorry for the grammar nit.)
> > 
> > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > + * @type. This is not a problem if the containing object is not const. Use with
> > > + * care.
> > 
> > I do not think these last two sentences you added here are needed
> > either.
> > 
> > 
> > >   */
> > >  #define container_of(ptr, type, member) ({				\
> > >  	void *__mptr = (void *)(ptr);					\
> > > @@ -27,6 +31,11 @@
> > >   * @type:	the type of the container struct this is embedded in.
> > >   * @member:	the name of the member within the struct.
> > >   *
> > > + * WARNING: as container_of() casts the given struct to another, also the
> 
> Wrong function name here.

I'll address this and the other two issues above in v2.

> 
> > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > + * @type. This is not a problem if the containing object is not const. Use with
> > > + * care.
> > 
> > Same comments here.
> 
> Wait, no one uses this macro, so why not just remove it entirely?

Good question. It appears to be a (relatively) common pattern to look up
something and the return its containing object if the lookup was
successful. Doing a quick

	$ git grep 'container_of.*:' drivers include

reveals more than 20 instances of the pattern. There are probably more
those that use if for testing for NULL. I guess people don't know about
this macro, apart from the developers of the staging driver it was added
for (commit 05e6557b8ed833546ee2b66ce6b58fecf09f439e).

-- 
Kind regards,

Sakari Ailus
