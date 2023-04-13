Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587AD6E0575
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 05:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDMDrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 23:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDMDrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:47:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C357B3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681357662; x=1712893662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gPdSr4BN4qgnYBujHfxo+7EEfLMISEH3ed+UIrZgyk0=;
  b=ZRUgbbhPUWjKOfkLvTFoNYee0QHwjWqs0QzGWmbVxOIM4Ys6j668V6rE
   a1u7nbLZuZLRQjEpLnwIHZT3QW0SqYtz2iMMwNdO7l1oPsfYsLDcerB+0
   p3TgfzxID8+jgFS9mvmC3IMeSccuVeLBXMD1tsBkaSSPD37qx4QYQ4fkN
   B6fTqQ4gTf0WD1AIsdoDLqLOh03Decn7QjNWtU1/PxpB7bR0b0zYXGdYr
   NNk9gKWmjiB84VIddbDzBhZduAG8qZr6BDFosF203bu5ZnMOCHyLxhFsJ
   b0Jb4zm8/wSOrX0pGdgfjk7jtPVRyppkCmvO+N+i8rKtKtNQkeXHrd+jH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323699893"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323699893"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 20:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="813223452"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="813223452"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2023 20:47:41 -0700
Date:   Wed, 12 Apr 2023 20:58:44 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/24] x86: Implement an HPET-based hardlockup detector
Message-ID: <20230413035844.GA31620@ranerica-svr.sc.intel.com>
References: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:47:29PM -0800, Ricardo Neri wrote:
> Hi x86 trusted reviewers,
> 
> This is the seventh version of this patchset. I acknowledge that it took me
> a long time to post a new version. Sorry! I will commit time to continue
> working on this series with high priority and I will post a new series soon
> after receiving your new feedback.
> 
> Although this series touches several subsystems, I plan to send it to the
> x86 maintainers because a) the series does not make much sense if split
> into subsystems, b) Thomas Gleixner has reviewed previous versions, and c)
> he has contributed to all the subsystems I modify.
> 
> Tony Luck has kindly reviewed previous versions of the series and I carried
> his Reviewed-by tags. This version, however, has new patches that also need
> review.
> 
> I seek to collect the Reviewed-by tags from the x86 trusted reviewers for
> the following patches:
>    + arch/x86: 4, 5
>    + Intel IOMMU: 6,
>    + AMD IOMMU: 9, 10, 11,
>    + NMI watchdog: 23 and 24.

Hello, checking if there is any feedback on these patches that I plan to
send to the x86 maintainer.

I am still seeking to collect the Reviewed-by: tags from the x86 trusted
reviewers.

Thanks in advance!

BR,
Ricardo
