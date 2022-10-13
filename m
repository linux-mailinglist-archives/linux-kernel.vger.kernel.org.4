Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC64C5FDDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiJMP4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJMP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:56:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4BDDAC79;
        Thu, 13 Oct 2022 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665676586; x=1697212586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dI+DILzBBZUT1i/UtFpVToNvMMaVGySdc/KLfAolyQA=;
  b=QVEYeyhSFBPZUskVZRcrU5R5D5ngH5v8KEmW+G+s2ZsfaQ/hQzOjNikg
   91DOdhhX99kujp4qi5hc/OD0aYpjE6Efu91zuhjVz7xyFormuhqp8mJw/
   Lv7w9/zyo7s5fpWnjUWhfGTRlSrW0YXzFzhqzJPfoCYEWDFSHUW+WBaKF
   SyrbTJ85hlriaacdX4GRTkkfLNWH6GoPDsUZj5uGyDB+S5Sfdr2vj8UO+
   HdklnatB1lF5wnbwAdesaZo9BFSuni6nYNndjaNiJQSFqLitoOZOaiJlO
   ghFqbxe9uuUl/Z40kbGuzs/NS/2gqD1ZJsbawNGxycrrFmCMSBWjABGLm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="302732006"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="302732006"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 08:56:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="802292494"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="802292494"
Received: from mkucejko-mobl.ger.corp.intel.com (HELO [10.213.24.166]) ([10.213.24.166])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 08:56:15 -0700
Message-ID: <668e5126-f344-c30b-a743-877b1783cec7@intel.com>
Date:   Thu, 13 Oct 2022 08:56:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 0/8] x86/topology: Improve CPUID.1F handling
Content-Language: en-US
To:     Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, corbet@lwn.net, fenghua.yu@intel.com,
        jdelvare@suse.com, linux@roeck-us.net, len.brown@intel.com
References: <20220922133800.12918-1-rui.zhang@intel.com>
 <5af2d8bb-8591-78f6-8102-6f7d0df33d98@intel.com>
 <9a1ae0b5d7a5ee3c870195e942d58bdd9b3b71db.camel@intel.com>
 <CAJvTdKkYTQzY1UsH_o2QdN1bS4gVfT87bEwMvgUXYwd+VFD+=w@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAJvTdKkYTQzY1UsH_o2QdN1bS4gVfT87bEwMvgUXYwd+VFD+=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 03:58, Len Brown wrote:
> This series of BUG FIXES needs to be marked for -stable.

Hi Len,

That would have been great feedback to include with your review when
your provided your acks.  It's also not clear where the bug fixes stop
and the "related fixes" begin.  Is the entire series bug fixes that need
to be marked for -stable?
