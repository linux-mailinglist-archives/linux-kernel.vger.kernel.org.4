Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36837335E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbjFPQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345310AbjFPQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:20:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7E49EB;
        Fri, 16 Jun 2023 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686932343; x=1718468343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UvlAWXFvcZKcfDoTtp8TET+wD+HFp3f4tOtfMwkM8E4=;
  b=d5M2zPQ7YQ2zlOhC948ij9pva2+X42H1uLBRmlymyyRm+vQKOl7Awrj0
   3oMepyECCeYCEtD0KoJ0rVZoiRVb2e6DNkbYioRz82oGqW3cYNIqof8pF
   giSS04ST4kq3DNJNxE944pKzGRJRMa5RyWKGvIGLwVdCp+BLBPc1dz7Wp
   3HwCos2HHSN+4hNbg5q9kNzQePw0Vm4qiNmH4w+cigeZ8xNwy4ZpBmnx+
   ZFhtZsK5CobbE3cWBNuPmKLwZnQ4pNNL61IxIX2MaDZhQ+y9w4WHjRLSX
   APJBdYS1rrO7CY1DP/6d6/lhFBCbYOoxk3d77Ykrrnwo+Hi4Q3Pdxj6vh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445634580"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="445634580"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="837080672"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="837080672"
Received: from fashta-mobl.amr.corp.intel.com (HELO [10.255.231.221]) ([10.255.231.221])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:18:28 -0700
Message-ID: <5d517282-9dfe-5508-8dbc-a20f862245e1@intel.com>
Date:   Fri, 16 Jun 2023 09:18:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] nospec: Add documentation for array_index_nospec
Content-Language: en-US
To:     Jordy Zomer <jordyzomer@google.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, dave.hansen@linux.intel.com, daniel@iogearbox.net,
        tglx@linutronix.de, rdunlap@infradead.org,
        pawan.kumar.gupta@linux.intel.com
References: <20230616133735.351479-1-jordyzomer@google.com>
 <20230616133735.351479-2-jordyzomer@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230616133735.351479-2-jordyzomer@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 06:37, Jordy Zomer wrote:
> array_index_nospec() should only be used if the upper boundary is a built
> time constant. Otherwise the boundary could be speculated on as well.
> While it might be more difficult to control two loads, it doesn't rule
> out the problem. Adding this to the documentation so people won't mis-use
> it instead of barrier_nospec().

Then shouldn't we be using __builtin_constant_p() to enforce this?
