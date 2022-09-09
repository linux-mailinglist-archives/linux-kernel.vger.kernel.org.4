Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F775B375C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiIIMNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiIIMNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:13:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A0226;
        Fri,  9 Sep 2022 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662725471; x=1694261471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rAXi6+HHAZMlDHGDkaj3u78qfSW8KSCFPrkKbWOqt/M=;
  b=U2EZzPQc1su34kIwmaObh4Sf7F/ABMiMgFU5UAEppu7MHfqadND+F9NY
   7TCfUaVD90mz4sudvoIHY6/ATe2kHwEszkXsvki8pygUYuw91RQ0dhbNB
   ltlZNhnUWI8urU3/1Zgkrd7Hd/h28WVFJH4ZiFOjIjNlVjUU1rfmttUGn
   lEjEdB5Y3LX0Cyd7Uuq3nx6XroPYa/QjU6BxcTkqhPVZli91WCaHcdFW9
   T3BJgp0Q01qc10n3XYRNXrH7z/RGiqAKMXtRyx/i/FdZb3AAAMeet+H0b
   qQcYUEDTVQpj3VmrHsB2FIlern/LX410tiw0l6GGXOFbwhdOhAAewmPHQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323668276"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="323668276"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 05:11:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="615252318"
Received: from omeier-mobl1.ger.corp.intel.com (HELO [10.209.54.138]) ([10.209.54.138])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 05:11:09 -0700
Message-ID: <8d7a22f3-6677-1438-84d2-68a56211ad11@intel.com>
Date:   Fri, 9 Sep 2022 05:11:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/intel: Clear SGX bit if both SGX driver and KVM SGX
 are not enabled
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, linux-sgx@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, seanjc@google.com, jarkko@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909080853.547058-1-kai.huang@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220909080853.547058-1-kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 01:08, Kai Huang wrote:
> Currently on platform which has SGX enabled, if CONFIG_X86_SGX is not
> enabled, the X86_FEATURE_SGX is not cleared, resulting in /proc/cpuinfo
> shows "sgx" feature.  This is not desired.

Why is it not desired?
