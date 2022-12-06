Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ACE644169
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiLFKnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiLFKnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:43:00 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214F26328
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 02:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670323379; x=1701859379;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=31y31Kfr+aYyNgRZJuIfo1aOe8I3JoDh4dq09J2qISw=;
  b=UV8FW+4ZeiHTE00r7Hoacep/knUQtnbPfWB7Im0SVttmVFDgZsNDdBLe
   zE7Y5o0+Rc3VuuxSJdiZ0fFetumpRjcAnx+s+v0jQW9igrCcr40E1C8iz
   W/IwW3NEOKBCYahNbf3ZxmOdoQIWv5o2YOFghWJvxzX8XalF3GpOTPbMa
   SP2/v4tAShYmRu/b68bMfpJhg65iU17qqwzYIlXk9e9XxCzJ5OMmckYCT
   twbBe+sE+DgJ3w03ZpM1H7It3fqgwEQJ439TXotIDjX9VxKxS3rm47xOj
   ueUiHA7RnTC5UtI+VQit/QoDOwKio04IeOPIR62KySGMSRHBe5SFoUMlM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="378757239"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="378757239"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 02:42:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="788438522"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="788438522"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.210.59]) ([10.254.210.59])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 02:42:55 -0800
Subject: Re: net/mptcp/pm_netlink.c:1169 mptcp_pm_parse_pm_addr_attr() warn:
 missing error code? 'err'
To:     Dan Carpenter <error27@gmail.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        lkp@intel.com
Cc:     oe-kbuild@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
References: <202212021422.Uh5cCKY2-lkp@intel.com>
 <f0722fd5-af12-4cff-9ffa-38b9e8d23313@linux.intel.com>
 <Y4sI65oadrVtBlnR@kadam>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <3b6b27ec-e478-1e71-a84e-e1177827d437@intel.com>
Date:   Tue, 6 Dec 2022 18:42:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y4sI65oadrVtBlnR@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/2022 4:29 PM, Dan Carpenter wrote:
> On Fri, Dec 02, 2022 at 03:38:01PM -0800, Mat Martineau wrote:
>>> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1158  	/* no validation needed - was already done via nested policy */
>>> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1159  	err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
>>> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1160  					  mptcp_pm_addr_policy, info->extack);
>>> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1161  	if (err)
>>> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1162  		return err;
>>> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1163
>>> 982f17ba1a2534 Florian Westphal 2022-05-03  1164  	if (tb[MPTCP_PM_ADDR_ATTR_ID])
>>> 982f17ba1a2534 Florian Westphal 2022-05-03  1165  		addr->id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
>>> 982f17ba1a2534 Florian Westphal 2022-05-03  1166
>>> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1167  	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
>>> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1168  		if (!require_family)
>>> 982f17ba1a2534 Florian Westphal 2022-05-03 @1169  			return err;
>>>
>>> "err" is zero at this point.  Presumably a negative error code was
>>> intended.
>>
>> Hi Dan -
>>
>> The intended error code is 0 here: the return happens if no
>> MPTCP_PM_ADDR_ATTR_FAMILY value is present and require_family is false.
>>
>> It would be clearer to "return 0;", but the code is working as expected.
>>
>>
>> Could you be sure to cc mptcp@lists.linux.dev and
>> matthieu.baerts@tessares.net for future MPTCP issues?

Hi Mat,

Sorry for the delay, we'll cc you and the mailing list in the future.

Best Regards,
Rong Chen

> 
> These emails are automatically generated by the kbuild team.  I don't
> know what kind of heuristics they use...  I've put them on the To
> header.  There is probably a reason why they don't just use
> get_maintainer.pl...
> 
> regards,
> dan carpenter
> 
> 
