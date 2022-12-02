Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C474C641192
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiLBXiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiLBXiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:38:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409287C90
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670024290; x=1701560290;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IqwJ6eLkEWKAG33953iLKOfDZ9sWXnRfDvO8XmMcNmE=;
  b=FXon+xOMleYxDwiPDV764BAHMZ+5Lu7HH6sE7DhasFSe/kYwMlYuMcEq
   8k5hsD8GJ7+h9PmzGf/NTMRVeb1eKmse0qEvHm7FoS61WmQudfYir164R
   sSOebcTZ0ZMw+HS7jU3sMxmPht4mwUr+FS2TrBbPW7KG71ZcUVLKrxbQ4
   2GUsrd/RWWZ3wKzCJl3mkKAh01lfENoC/sIedL6vtF4bXKM93RZShN9OF
   eDc7zhOWDlaQ3WWWB4v5YnVnlePKAJUf3Wt6mPHdtzlioTsZ+0ntHOXDp
   zldaVy/JvNLerb7LG1w5/RBRn9UImgyo9llt2hPpxRm75T89HOa0cqe62
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="343038549"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="343038549"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 15:38:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="890330876"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="890330876"
Received: from zamamohx-mobl.amr.corp.intel.com ([10.209.22.121])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 15:38:02 -0800
Date:   Fri, 2 Dec 2022 15:38:01 -0800 (PST)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
To:     Dan Carpenter <error27@gmail.com>
cc:     oe-kbuild@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: net/mptcp/pm_netlink.c:1169 mptcp_pm_parse_pm_addr_attr() warn:
 missing error code? 'err'
In-Reply-To: <202212021422.Uh5cCKY2-lkp@intel.com>
Message-ID: <f0722fd5-af12-4cff-9ffa-38b9e8d23313@linux.intel.com>
References: <202212021422.Uh5cCKY2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022, Dan Carpenter wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a4412fdd49dc011bcc2c0d81ac4cab7457092650
> commit: 982f17ba1a2534b878fbcb1a5273bfbc551c5397 mptcp: netlink: split mptcp_pm_parse_addr into two functions
> config: i386-randconfig-m021
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
>
> smatch warnings:
> net/mptcp/pm_netlink.c:1169 mptcp_pm_parse_pm_addr_attr() warn: missing error code? 'err'
>
> vim +/err +1169 net/mptcp/pm_netlink.c
>
> 982f17ba1a2534 Florian Westphal 2022-05-03  1145  static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
> 982f17ba1a2534 Florian Westphal 2022-05-03  1146  				       const struct nlattr *attr,
> 982f17ba1a2534 Florian Westphal 2022-05-03  1147  				       struct genl_info *info,
> 982f17ba1a2534 Florian Westphal 2022-05-03  1148  				       struct mptcp_addr_info *addr,
> 982f17ba1a2534 Florian Westphal 2022-05-03  1149  				       bool require_family)
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1150  {
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1151  	int err, addr_addr;
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1152
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1153  	if (!attr) {
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1154  		GENL_SET_ERR_MSG(info, "missing address info");
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1155  		return -EINVAL;
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1156  	}
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1157
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1158  	/* no validation needed - was already done via nested policy */
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1159  	err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1160  					  mptcp_pm_addr_policy, info->extack);
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1161  	if (err)
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1162  		return err;
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1163
> 982f17ba1a2534 Florian Westphal 2022-05-03  1164  	if (tb[MPTCP_PM_ADDR_ATTR_ID])
> 982f17ba1a2534 Florian Westphal 2022-05-03  1165  		addr->id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
> 982f17ba1a2534 Florian Westphal 2022-05-03  1166
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1167  	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1168  		if (!require_family)
> 982f17ba1a2534 Florian Westphal 2022-05-03 @1169  			return err;
>
> "err" is zero at this point.  Presumably a negative error code was
> intended.

Hi Dan -

The intended error code is 0 here: the return happens if no 
MPTCP_PM_ADDR_ATTR_FAMILY value is present and require_family is false.

It would be clearer to "return 0;", but the code is working as expected.


Could you be sure to cc mptcp@lists.linux.dev and 
matthieu.baerts@tessares.net for future MPTCP issues?

Thanks,

Mat


>
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1170
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1171  		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1172  				    "missing family");
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1173  		return -EINVAL;
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1174  	}
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1175
> 982f17ba1a2534 Florian Westphal 2022-05-03  1176  	addr->family = nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_FAMILY]);
> 982f17ba1a2534 Florian Westphal 2022-05-03  1177  	if (addr->family != AF_INET
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1178  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 982f17ba1a2534 Florian Westphal 2022-05-03  1179  	    && addr->family != AF_INET6
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1180  #endif
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1181  	    ) {
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1182  		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1183  				    "unknown address family");
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1184  		return -EINVAL;
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1185  	}
> 982f17ba1a2534 Florian Westphal 2022-05-03  1186  	addr_addr = mptcp_pm_family_to_addr(addr->family);
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1187  	if (!tb[addr_addr]) {
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1188  		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1189  				    "missing address data");
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1190  		return -EINVAL;
> 01cacb00b35cb6 Paolo Abeni      2020-03-27  1191  	}
>
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>
>

--
Mat Martineau
Intel
