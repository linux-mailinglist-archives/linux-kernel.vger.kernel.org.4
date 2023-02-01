Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E55687020
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBAUw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjBAUwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:52:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30228EC47;
        Wed,  1 Feb 2023 12:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675284748; x=1706820748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CtnHyRlm9FCMYY900WFdvW+1NpDuurJ2OBLz6uxrVNQ=;
  b=dqsNmwXVFIk/4UaFW6eYz8WL9OiMjgTXy3JvSaKIYZWoTRNXU/PH4xU7
   obh3nLs9XJKGbQmYrvf4Crkwom98pnQGMJB/0mhfXNU2wXprNjcV8VG6c
   INhb2PTnDVEMCKjFGqJM4j3fQyq6sa3l363y5mzigYxSEPue4/VU1m9wY
   vRlxSQdlAfP798mkD5OfCtIQr3/9QH1TrzlLWR5hkXtkii5/5XqCQN8Hm
   OcyIoN8AF0iU4T+y2zMpFu3MMxuH4gMspQIb8mTjbwsvjKv96p0rktGvY
   IK9OFxPwv+tUAv6rJHhgsO0RRWnfrkHSXD/AgEzJlQQHk/aNLeqyoD68z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="307926737"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="307926737"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 12:49:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="695512665"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="695512665"
Received: from sgkhacha-mobl1.amr.corp.intel.com (HELO [10.212.227.86]) ([10.212.227.86])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 12:49:23 -0800
Message-ID: <ee97e1d6-5a21-2c5c-4fdf-05e2700e94cc@intel.com>
Date:   Wed, 1 Feb 2023 12:49:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-5-jithu.joseph@intel.com>
 <6a675f9b-2bbb-9317-2015-0b3362e49fdc@intel.com>
 <c04c1aee-b84c-324c-e7db-c004e778ef4e@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <c04c1aee-b84c-324c-e7db-c004e778ef4e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 11:56, Joseph, Jithu wrote:
>> Voila!  Less code, less obfuscation, less duplicated effort.  Or, worst
> Agreed, will modify it as you suggest above to remove the duplicate zero assignments

... and the union ... and the _unnecessary_ bitfields.  You can make an
argument that ->ctrl_result should be a bitfield.  The other
structure members, not so much.  Make them standalone unsigned integers.

But, when it's down to a single bit in an otherwise completely
unpopulated byte-sized field, your arguments for using a bitfield kinda
dry up.  But, heck, if that's the hill you want to die on, who am I to
stop you?
