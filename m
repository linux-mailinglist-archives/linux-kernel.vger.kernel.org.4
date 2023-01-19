Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D046742E8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjASTe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjASTeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:34:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DF04DCEC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674156863; x=1705692863;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OLhemjaL8lqWSGD1SejhRJU3Zq2nLjBr7KlED6ORlpw=;
  b=DNkx7+NHWRCwP61Ydw5X57y/nrQk+Z9mYe4vdMpLjiAE315ubCVFPCpb
   2I0lZhKttQDpowzUeSiWKHhGkt4oGaYBE0hlWW9wfJTY9Rqv871xLFG4F
   3yUSR+sw7oPvuIgp5mEGaPMzqc+lA5fMexrqOUeUyDWXXmPX9hjG8Wxv8
   BDyCPerYlv+rHCW0nUPImSoKLBrMpGY4W60IAPj34vZcwM16s0/PpzKh3
   OA8Kq5zS04MZee3OCk7TuJbXUqWXD4Ks9uKkMKMuKWvzNfBTu1B44inuT
   6wc/Be248PqfhW4ph1EoD5OcPDTYhWlINcPgrlakq0yla3IBPfUJ+ujqW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305764749"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305764749"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 11:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="905670409"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="905670409"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jan 2023 11:34:18 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 1/6] virtio console: Harden multiport against invalid
 host input
In-Reply-To: <Y8mXdFms3CzPnW+6@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
 <Y8lfHKz08EVeNa5o@kroah.com> <87fsc6qrvx.fsf@ubik.fi.intel.com>
 <Y8mXdFms3CzPnW+6@kroah.com>
Date:   Thu, 19 Jan 2023 21:34:17 +0200
Message-ID: <87cz7aqpxi.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Jan 19, 2023 at 08:52:02PM +0200, Alexander Shishkin wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > Why did I only get a small subset of these patches?
>> 
>> I did what get_maintainer told me. Would you like to be CC'd on the
>> whole thing?
>
> If you only cc: me on a portion of the series, I guess you only want me
> to apply a portion of it?  if so, why is it a longer series?

I was expecting that this series will eventually go in via the virtio
maintainers, assuming you can give your acks to the char bits.

Or, I can split off the char bits and send them to you
separately. Whichever makes the most sense.

>> > But, this still feels wrong.  Why is this happening here, in init_vqs()
>> > and not in the calling function that already did a bunch of validation
>> > of the ports and the like?  Are those checks not enough?  if not, fix it
>> > there, don't spread it out all over the place...
>> 
>> Good point! And there happens to already be 28962ec595d70 that takes
>> care of exactly this case. I totally missed it.
>
> So this series is not needed?  Or just this one?

Just this one.

Regards,
--
Alex
