Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96B6C2D19
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCUIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCUIz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:55:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041603A4C5;
        Tue, 21 Mar 2023 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679388847; x=1710924847;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F0Aai9BhaA5K1wsF4Vod4yMCaBMdeTGqMNHzQ0Ugzio=;
  b=Q1LhLM1wue8K/BsguMAvD/cn4g4cPu0HWr4x57XRImMffNckW8sfxkEN
   XnWXMgYdDziLuZKROqH/yzN/1+mGsNXtNpk4Xwd/5m3eWPlMVqUq+wNqH
   K38Ho6h8acDQvaBR46IU/DLviS1raWVz5K4DR+Eninqt7J7i9/sbsO2xy
   5jdfhrNGdsMLxinCRiOxxziSlFV1f7KcrOnOs1TlX1nOEOClrWoOEJ5TN
   zMwZ0MIlLhqa/kIFpqavaZyDod3ee9BfU3h7ziUa8HXph2BDOUj61+xYf
   zRcRzodrlp3HxzwvOCPyYzxbqcUmZAXjengkCFJJ3fhmRGBXMK/CmFKTG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="337605723"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="337605723"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 01:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="770548037"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="770548037"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.37.33])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 01:49:30 -0700
Date:   Tue, 21 Mar 2023 09:49:26 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Jes Sorensen <jes@trained-monkey.org>
Cc:     NeilBrown <neilb@suse.de>, Song Liu <song@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-raid <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nikolay Kichukov <hijacker@oldum.net>
Subject: Re: [PATCH - mdadm] mdopen: always try create_named_array()
Message-ID: <20230321094926.00007a38@linux.intel.com>
In-Reply-To: <c36ee145-c258-5a02-f268-30c145996759@trained-monkey.org>
References: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
        <318ff554-0694-64e1-72bd-d941a775a16f@trained-monkey.org>
        <167926378352.8008.3450187952660050637@noble.neil.brown.name>
        <c36ee145-c258-5a02-f268-30c145996759@trained-monkey.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 13:15:35 -0400
Jes Sorensen <jes@trained-monkey.org> wrote:

> On 3/19/23 18:09, NeilBrown wrote:
> > On Mon, 20 Mar 2023, Jes Sorensen wrote:  
> >> On 3/13/23 20:06, NeilBrown wrote:  
> >>>
> >>> mdopen() will use create_named_array() to ask the kernel to create the
> >>> given md array, but only if it is given a number or name.
> >>> If it is NOT given a name and is required to choose one itself using
> >>> find_free_devnm() it does NOT use create_named_array().
> >>>
> >>> On kernels with CONFIG_BLOCK_LEGACY_AUTOLOAD not set, this can result in
> >>> failure to assemble an array.  This can particularly seen when the
> >>> "name" of the array begins with a host name different to the name of the
> >>> host running the command.
> >>>
> >>> So add the missing call to create_named_array().
> >>>
> >>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217074
> >>> Signed-off-by: NeilBrown <neilb@suse.de>  
> >>
> >> Applied!  
> > 
> > Thanks.
> > 
> > Do you have plans for releasing 4.3?  I'd like this patch to be in a
> > numbered release for at least a few months before we change the kernel
> > Kconfig to allow md to be built without CONFIG_BLOCK_LEGACY_AUTOLOAD.  
> 
> No immediate plans, but no reason why we shouldn't do it. I think
> Mariusz has some pending changes he wants to get in as well, like the
> error number stuff.
> 
> So lets make this a call for submitting changes for mdadm that are
> needed for the next release.
> 

Hi Jes,
My patches around names (where I added those errors) will be too risky to be
merged and released in short period. I'm going to limit the supported
characters for names- it could bring regressions in some non obvious cases and I
would like to give user time to accept it and adopt their solutions to new
naming policy.

Let me see if the patches recently merged doesn't bring any critical
regression, and we are free to go I think :) I will back with a results soon.

Thanks,
Mariusz
