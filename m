Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C17D640501
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiLBKqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiLBKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:46:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14612316F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:46:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 702B76224F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BEAC433C1;
        Fri,  2 Dec 2022 10:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669977960;
        bh=oYNvYKgo9dv4+IjQsFMYDOltTsZ4YmJhVPualRc6LWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WShGELScDTzyHeMKcnDRonBe/P+M8j5R9aQqFBKWQVS6t1/We3daFe1pLIwMOe/MV
         9hidiD3UJpRZfFLEWqlKxS2hs8ORGxsA2LcvnMjuvCcmc8ACFlIL/8XdIM4foLNAQe
         +or2DEeWWkrda+581dU2nZEJbnNtES9h/ta9nX9Y=
Date:   Fri, 2 Dec 2022 11:45:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4nXY05iM034z6Gi@kroah.com>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
 <Y4k3DrPW1eG9WB7r@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4k3DrPW1eG9WB7r@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:21:50PM +0000, Sakari Ailus wrote:
> Hi Greg,
> 
> On Thu, Dec 01, 2022 at 08:30:54PM +0100, Greg Kroah-Hartman wrote:
> > container_of does not preserve the const-ness of a pointer that is
> > passed into it, which can cause C code that passes in a const pointer to
> > get a pointer back that is not const and then scribble all over the data
> > in it.  To prevent this, container_of_const() will preserve the const
> > status of the pointer passed into it using the newly available _Generic()
> > method.
> 
> "_const" in the name suggests that the macro would always take a const
> argument.

I mean it here to be "this will preserve const" as yes, it can take a
const.  Or not.

> Could this be called e.g. container_of_safe() (for type-safe, but
> full type_safe would be a bit long)?

const is an attribute of type safety, container_of is also type-safe
as-is, it's just the const portion here that is the difference between
the two.

Naming is hard :(

> 
> -- 
> Kind regards,
> 
> Sakari Ailus
