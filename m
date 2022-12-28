Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796276574E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiL1Jqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiL1JqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:46:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745DCDF11;
        Wed, 28 Dec 2022 01:46:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A2EA613FB;
        Wed, 28 Dec 2022 09:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0887FC433EF;
        Wed, 28 Dec 2022 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672220775;
        bh=M9aJImHcshT/NgLbfqGwkdWWzgLR7i0nWaQ0G/H/bJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmJJs60l98CDJuuwpbYyfUX8Q7PNtPY1PrA6f9siwk/9+HA/ouoqvU0fh9H3JH9eJ
         BKKsywVviJa3sNmK353fZuh818Zz6jDmNon7UjHfaDw6vSWpAgXNAhRA6mabr1AVNk
         VbDPExOrif18IAdNtNwG0AXrDzx3WxIpzVgR2awo=
Date:   Wed, 28 Dec 2022 10:46:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        djrscally@gmail.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, rafael@kernel.org
Subject: Re: [PATCH v3] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y6wQZOn+fObx0Mua@kroah.com>
References: <20221123022542.2999510-1-yangyingliang@huawei.com>
 <Y6wOS8NFAZc5+piJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6wOS8NFAZc5+piJ@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 11:37:15AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 23, 2022 at 10:25:42AM +0800, Yang Yingliang wrote:
> > The 'parent' returned by fwnode_graph_get_port_parent()
> > with refcount incremented when 'prev' is not NULL, it
> > needs be put when finish using it.
> > 
> > Because the parent is const, introduce a new variable to
> > store the returned fwnode, then put it before returning
> > from fwnode_graph_get_next_endpoint().
> 
> Rafael, Greg, is this went through the cracks?

Yes, but still in my queue.  I'll look at it when I get back from break.

thanks,

greg k-h
