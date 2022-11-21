Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA863189E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 03:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiKUC0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 21:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKUC0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:26:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDB82A95F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668997594; x=1700533594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mxkKT3/YQd7/03iu3H1pwlXH+uwvD09D9aNNOc/w5gM=;
  b=nqrQCfT4H9wWyGMZpIMhRJrv3EvSpdQj9Wwy+joft0LWxbZKP4ipx++m
   5T8iLIddd9kXJKnd2vbK/61+HKwV9Te6ThwWF0JQz5TxQ2IatWiV1oyLB
   6hJfkOZpdv2Y5UaNSjaimnvrA4r2bHbZvbtpw//AYIwrN5xpH+YBxc3NP
   S9DTvqqHlZ4d201SIw3QD3HIuR3/RAshTrN4/rOLxgvtDN0zU7RKVQtez
   nPYSdBz1dBLKlt6Va4P8Z5URgDJ2rG5iv7CsgwawM1ZZ/ijcS5QsPrjiU
   n/CBYZJyeJQS3nQcTka4qIi/wS1d0LuOQV4fXiIuJvZBHbFSRMf26kRBw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="296816232"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="296816232"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 18:26:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="643149821"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="643149821"
Received: from psomaraj-mobl1.amr.corp.intel.com (HELO [10.212.176.122]) ([10.212.176.122])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 18:26:31 -0800
Message-ID: <6b8f415f-1a29-5c0c-1373-3b08aba735e6@intel.com>
Date:   Sun, 20 Nov 2022 18:26:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Guorui Yu <GuoRui.Yu@linux.alibaba.com>
Cc:     ak@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, isaku.yamahata@gmail.com, jun.nakajima@intel.com,
        kai.huang@intel.com, khalid.elmously@canonical.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        marcelo.cerri@canonical.com, mingo@redhat.com,
        philip.cox@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        tim.gardner@canonical.com, tony.luck@intel.com, wander@redhat.com,
        x86@kernel.org, "Du, Fan" <fan.du@intel.com>
References: <7c09d15b-40bc-c6a0-3282-a94e9d9c36be@intel.com>
 <a69faebb-11e8-b386-d591-dbd08330b008@linux.alibaba.com>
 <51d486c9-4689-c2d6-0db4-4e3754a058db@linux.alibaba.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <51d486c9-4689-c2d6-0db4-4e3754a058db@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/22 18:04, Guorui Yu wrote:
> Kindly ping for any comments here?

No comments from me!

Seriously, this is from June.  I honestly have no idea what this patch
is for or why you're asking about it.  If it were  important, I would
have expected a new post with a new cover letter telling me some time in
the past 5-6 months.

Oh, and btw, I haven't seen you reviewing any other x86 submissions
during that past 5-6 months either.  I'm tend to be more likely to bump
things up near the front of the queue for folks that are helping to keep
the queue short and manageable.
