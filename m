Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE862D379
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiKQGal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiKQGai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:30:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A379FDEF6;
        Wed, 16 Nov 2022 22:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668666637; x=1700202637;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/+HBrrsfrVpXa8wSoQRFbTPEIvOcBtvT7BZKCLGSfzI=;
  b=Fh0+s5j75i7md+n4a3nZwB6seLhuwaOgkf0JHN+lv5WdZpR2wFGdH4Ix
   b5MJnAGQXi8jtmyIZ05qLc9KKgA0Nb5i4YpQkVq+2W+uJppSXgqx3WrCt
   P5/+DMIv9UbHgKxJ+NivD6Lv9VRqsFWP2vXor4ZlA8H6eLqIgZtqc875p
   HOYfhNrFWDBHvAvDzOc/kXqxbe6NsFQaLKeY3DUazDHhr1vHs84IAxZNU
   cadzhz96ZFQxqRrdUkAvdjq50j0M8y1J3fgiyn/U3tNkY9GRREij6Wjb2
   w8NOt3iMh5NTRervCWsbnlyoR6n8KBpH7dxQGedKVQHUc/RVSaVJosiG0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="293166925"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="293166925"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 22:30:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="639674849"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="639674849"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 22:30:34 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
In-Reply-To: <Y3Sw77bL/b6ePl3G@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 16 Nov 2022 10:44:15 +0100")
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
        <87zgcrwfac.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <0445de39-15a4-f645-b380-39f20abb6524@bytedance.com>
        <Y3Sw77bL/b6ePl3G@dhcp22.suse.cz>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Thu, 17 Nov 2022 14:29:36 +0800
Message-ID: <87mt8qw0tr.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 16-11-22 17:38:09, Zhongkun He wrote:
>> Hi Ying, thanks for your replay and suggestions.
>> 
>> > 
>> > I suggest to move the flags in "mode" parameter (MPOL_F_STATIC_NODES,
>> > MPOL_F_RELATIVE_NODES, MPOL_F_NUMA_BALANCING, etc.) to "flags"
>> > parameter, otherwise, why add it?
>> 
>> The "flags" is used for future extension if any, just like
>> process_madvise() and set_mempolicy_home_node().
>> Maybe it should be removed.
>
> No, please! Even if there is no use for the flags now we are usually
> terrible at predicting future and potential extensions. MPOL_F* is kinda
> flags but for historical reasons it is a separate mode and we shouldn't
> create a new confusion when this is treated differently for pidfd based
> APIs.
>
>> > And, how about add a "home_node" parameter?  I don't think that it's a
>> > good idea to add another new syscall for pidfd_set_mempolicy_home_node()
>> > in the future.
>
> Why would this be a bad idea?
>
>> Good idea, but "home_node" is used for vma policy, not task policy.
>> It is possible to use it in pidfd_mbind() in the future.
>
> I woould go with pidfd_set_mempolicy_home_node to counterpart an
> existing syscall.

Yes.  I understand that it's important to make API consistent.

Just my two cents.

From another point of view, the new API gives us an opportunity to fix
the issues in existing API too?  For example, moving all flags into
"flags" parameter, add another parameter "home_node"?  Maybe we can
switch to this new API in the future completely after finding a way to
indicate "current" task in "pidfd" parameter.

Best Regards,
Huang, Ying
