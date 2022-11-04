Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46119619411
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiKDKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKDKDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:03:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC5D1EADF;
        Fri,  4 Nov 2022 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667556185; x=1699092185;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=g+1FU1UbK9Z2VGaBVxEvU818H48PEczmtH1jj6hXGXA=;
  b=jzwziP6NRmnP5D5GR2iGgO7joKRwRSvktk7N7CMpXpDGOJ+WB8I1yTnj
   E4U8VPquNI7Jm3n1WUUnTIT2oFcSEJukOCr3GOd1/vcwmZ/hTgeqM9CFI
   we3Sd5pJfm9ay/6lgGXU2azZTSL5okgodkF6bb9mOc78ahuA66pVJYRlV
   h6qZ2MFvrbCcdd+t3AGD6iUpZ68XjtmrJ/zlc4zlB/+cVbddwq13tu8ql
   OXNNIVMcwlfyz6rWmJV6R380H47HYXSrwvgAmOy78HPnmzNaMHrJjs9el
   i0TE2Tpcms6At0lW3sM9l3hes6qlMOrKUwYuOQYJM7/+wSbJow6GCE7Nh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="293256992"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="293256992"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 03:03:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="740568617"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="740568617"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.215.240]) ([10.254.215.240])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 03:02:58 -0700
Subject: Re: [PATCH] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        kernel test robot <lkp@intel.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        oe-kbuild-all@lists.linux.dev, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221103153619.11068-1-lhenriques@suse.de>
 <202211042241.mPJd6rKy-lkp@intel.com> <Y2TflzMdeiXRMoek@suse.de>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <fc1fee1f-c6f0-9366-8759-f80b9ba532e7@intel.com>
Date:   Fri, 4 Nov 2022 18:02:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y2TflzMdeiXRMoek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2022 5:47 PM, Luís Henriques wrote:
> On Fri, Nov 04, 2022 at 02:40:25PM +0800, kernel test robot wrote:
>> Hi Luís,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on ceph-client/for-linus]
>> [also build test ERROR on linus/master v6.1-rc3 next-20221104]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Lu-s-Henriques/ceph-fix-memory-leak-in-mount-error-path-when-using-test_dummy_encryption/20221103-233629
>> base:   https://github.com/ceph/ceph-client.git for-linus
> 
> Well, thank you very much!  Now, how do I tell this bot that this patch
> isn't targeting this branch?

Hi Luis,

The below message may help:

 >> [If your patch is applied to the wrong git tree, kindly drop us a note.
 >> And when submitting patch, we suggest to use '--base' as documented in
 >> https://git-scm.com/docs/git-format-patch#_base_tree_information]

we also appreciate that if developers can tell us the right branch
to improve the bot when applied to wrong place.

Best Regards,
Rong Chen

> 
> Cheers,
> --
> Luís
> 
