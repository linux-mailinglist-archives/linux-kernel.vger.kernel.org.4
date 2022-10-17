Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDBD601A53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiJQUdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiJQUc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:32:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211172317A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666038589; x=1697574589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PU9aa6CXppJ3uBLC9tV3QHDj74uj9e3OMPUKK2iQ3Mc=;
  b=gOWN70+fTp+j1Lb2UDX7YQJxovfQ2PqhB9sBTbDr6uTDqeo+QNOR1g1U
   g0jgS3Ev7clAlFzRt6y/z5aQRqycZ7A48xpRZCt3c7W0lGYCPodk08phA
   /6c1QL0oy5HhFJcjRHNWOxftubPBacl+VHUXEeL1k6CCx5PkamzrRL7Ls
   0BKMigqqhRe7a8/ecpJhS4toBNrTvqmmDTfNHrSGG8N5LrHvxd2Ufgaxi
   7sAZVtw49cgFcnzC0JpHcS49cXlo+wAEX3XlgNzML5tEXBZ+v0O+WOjy8
   InNDUDBkHtxrIevDigq4C3CtbwgHtg/sPOgEg+tk3EFOtRWhti9opNUqd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="304650227"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="304650227"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 13:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="697193413"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="697193413"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2022 13:27:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okWhT-0092Rj-2r;
        Mon, 17 Oct 2022 23:27:03 +0300
Date:   Mon, 17 Oct 2022 23:27:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Message-ID: <Y026l2PZgvt+G6p0@smile.fi.intel.com>
References: <20221017194447.2579441-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017194447.2579441-1-jane.chu@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:44:47PM -0600, Jane Chu wrote:
> While debugging a separate issue, it was found that an invalid string
> pointer could very well contain a non-canical address, such as

non-canical?

> 0x7665645f63616465. In that case, this line of defense isn't enough
> to protect the kernel from crashing due to general protection fault
> 
> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
>                 return "(efault)";
> 
> So run one more round of check via kern_addr_valid(). On architectures
> that provide meaningful implementation, this line of check effectively
> catches non-canonical pointers, etc.

OK, but I don't see how this is useful in the form of returning efault here.
Ideally we should inform user that the pointer is wrong and how it's wrong.
But. It will crash somewhere else at some point, right? I mean that there
is no guarantee that kernel has protection in every single place against
dangling / invalid pointers. One way or another it will crash.

That said, honestly I have no idea how this patch may be considered
anything but band-aid. OTOH, I don't see a harm. Perhaps others will
share their opinions.

-- 
With Best Regards,
Andy Shevchenko


