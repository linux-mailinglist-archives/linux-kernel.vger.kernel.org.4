Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901AA5BCE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiISOMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiISOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:12:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E4715FCB;
        Mon, 19 Sep 2022 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663596752; x=1695132752;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mmuYsKqRrTpSJWfKgGWiUtdtxdL3/r3pMzDQ3IrNf9E=;
  b=HGJk/6vYgo6g5n/FmzSIAczWj9BJymWFnG5Rmsg1TeQBb2FCLLNAt5lH
   8MyuQNTKeOgbkV6dAWVsCDhs6iHfuyl8eDD1JUTffw+hcBn7UfIrOce7p
   7tClOoUpg1P2ru8R1ZQhoOCM6ae5CH4DyDa2vGH0voK3/CnNOa64zUF59
   GTzEoWCj7CL53HtrAuzzOw6gSq7Q0KquzqcD+Pe88X8UIX9xjZQ1nyKbw
   LFCj3bVFdLNd2HYEAoc5H3a85cq1ugAt1jfjIaqtN8Hu0xUdiGznxNlxe
   9ux8b4qKZDhHe1ioR110w9Ng8gA0YW14oQxu7Z6iWnLe7KyZvzCxhinSH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="298136837"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="298136837"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 07:12:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="651692744"
Received: from iswiersz-mobl1.ger.corp.intel.com ([10.252.33.172])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 07:12:29 -0700
Date:   Mon, 19 Sep 2022 17:12:26 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
In-Reply-To: <Yyhyxmt+rhxEI0VH@smile.fi.intel.com>
Message-ID: <db3c5a9-9dc3-e57-d74d-8ee2d4b1a33@linux.intel.com>
References: <YyF/dogp/0C87zLb@wantstofly.org> <YyGoZLTFhYQvlf+P@smile.fi.intel.com> <YyG2tDdq9PWTlaBQ@wantstofly.org> <YyHR4o5bOnODZzZ9@smile.fi.intel.com> <7fd034a9-c1e1-2dca-693b-129c9d2649@linux.intel.com> <Yyhyxmt+rhxEI0VH@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-749065660-1663596751=:1603"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-749065660-1663596751=:1603
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 19 Sep 2022, Andy Shevchenko wrote:

> On Thu, Sep 15, 2022 at 07:27:45PM +0300, Ilpo Järvinen wrote:
> > On Wed, 14 Sep 2022, Andy Shevchenko wrote:
> > > On Wed, Sep 14, 2022 at 02:10:44PM +0300, Lennert Buytenhek wrote:
> > > > On Wed, Sep 14, 2022 at 01:09:40PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > -	/*
> > -	 * The above check will only give an accurate result the first time
> > -	 * the port is opened so this value needs to be preserved.
> > -	 */
> 
> Side note: I haven't got why you removed this comment (it may be some staled
> info, but shouldn't be done in the separate change then?).

I cleaned up this part in v2 (as you probably noticed). I was just an 
artifact of how the fix got initially made.

I've also located the place where the comment belongs to. "The above 
check" refers to the THRE test. However, I don't fully understand the 
comment itself, that is, why the test is claimed to only work for for the 
first time. As long as FIFO is cleared beforehand, I think it should work 
on other times too.


-- 
 i.

--8323329-749065660-1663596751=:1603--
