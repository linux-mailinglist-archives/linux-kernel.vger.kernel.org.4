Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099E0675488
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjATMcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjATMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:32:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2DBC88F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674217932; x=1705753932;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4oREZyA0VMbS86NOyKgrmhA4Zt21EXpff/XKm7uSCnU=;
  b=bdnTtI2OnGhU8TOKaha9u9tW7flvksPlYgVJ/x2ZFSgS4654E3jwvZLO
   t0bXLOuYBS/YxbOdde4NIKagugsSR8KN3GTbR8qXYgMW+daq2lBFyZMth
   ng/glNnR+2EWJq68Kv9QFH7AOQDxAVKx2Xsj9fjVXpuh9KGIHafDjSRwQ
   eifaUhTcptx2OUO6pcW20OZ60RdDdFGSKRVsYG84gAjPAwsxEjQb1Jl4Y
   uEHV8yXaqik+cf4q91nZc+7UeV5P8KzHHZfwIN17Mj+DTQISXvfQ/n01H
   MehMSWIcYJRbUDoVq8zUw4tfU9G1DDmd76BwGwGIMfnYaeQrDJ2QyD5Gk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="411801045"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="411801045"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:32:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="768679617"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="768679617"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2023 04:32:10 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 0/6] Harden a few virtio bits
In-Reply-To: <20230120065402-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230120065402-mutt-send-email-mst@kernel.org>
Date:   Fri, 20 Jan 2023 14:32:09 +0200
Message-ID: <877cxhqtdi.fsf@ubik.fi.intel.com>
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Jan 19, 2023 at 03:57:15PM +0200, Alexander Shishkin wrote:
>> Hi,
>> 
>> Here are 6 patches that harden console, net and 9p drivers against
>> various malicious host input as well as close a bounds check bypass
>> in the split virtio ring.
>
> Hardening against buggy devices is one thing,
> Hardening against malicious devices is another.
> Which is this?

Well, the big difference is the intent, but buggy input is buggy input,
they've got that in common and we're trying to deal with it here.

The motivation for this patchset is protecting against malicious
devices.

> If really malicious, aren't there any spectre considerations here?
> I am for example surprised not to find anything addressing
> spectre v1 nor any uses of array_index_nospec here.

That's strange, patch 6/6 is exactly that. There's probably more coming
in the future as the analysis and audit progress.

Regards,
--
Alex
