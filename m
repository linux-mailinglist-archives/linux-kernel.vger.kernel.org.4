Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B375FC127
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJLHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJLHRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:17:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C577675F;
        Wed, 12 Oct 2022 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665559029; x=1697095029;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uJPPiijsvfmVMsD+Sw9j7a0edMnEKrE5sNYkhJdmad0=;
  b=c/VHzdFJUIkEPze2D3A3Acoy51BQYnkouimHtEeWXvY8NogA3IJ6rgpe
   k2JmsYNjboMTF2CQke4xjfeJHjAJsDfH33LdAzJN5dHv7UVu2iHCQh8ZF
   6sbIciQinWfvtmv65Hoq3jgCCYN/9Aaz1+A2nK9rQP6YZ1Sg4ggyDZoQE
   b5FOXcLHsu7+1MhE4pECfIABORBzCu5sYvy+FHRxEYWobkJ2fWFqqSE5U
   IWiRyjdtVFxmRKS8hvTqhzAsP1824J2IE2N/0YSKFKS9sshATbeVC1Ot6
   d0zpqVv2Ty/uju6mdxqds0b/HCszb3Am/nBcg75k/TGE77Ubh71Y4Eijf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="292045692"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="292045692"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 00:17:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="629002967"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="629002967"
Received: from beataba-mobl.ger.corp.intel.com (HELO localhost) ([10.213.23.28])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 00:17:04 -0700
Date:   Wed, 12 Oct 2022 09:17:00 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Song Liu <song@kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, jonathan.derrick@solidigm.com,
        jonathanx.sk.derrick@intel.com
Subject: Re: [RFC PATCH] mdadm: Add parameter for bitmap chunk threshold
Message-ID: <20221012091700.0000695b@linux.intel.com>
In-Reply-To: <20221006220840.275-2-jonathan.derrick@linux.dev>
References: <20221006220840.275-1-jonathan.derrick@linux.dev>
        <20221006220840.275-2-jonathan.derrick@linux.dev>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Oct 2022 16:08:38 -0600
Jonathan Derrick <jonathan.derrick@linux.dev> wrote:

> Adds parameter to mdadm create, grow, and build similar to the delay
> parameter, that specifies a chunk threshold. This value will instruct
> the kernel, in-tandem with the delay timer, to flush the bitmap after
> every N chunks have been dirtied. This can be used in-addition to the
> delay parameter and complements it.
> 
> This requires an addition to the bitmap superblock and version increment.

Hello Jonathan,
To provide that to parameter to bitmap we are updating bitmap superblock, right?
Why we need to define it in config then? I someone wants to change that
should use --grow. Am I correct?

The "threshold" is not a context property, it should be added to struct shape.
Ideally, we can extract bitmap properties to separate struct and pass it around.

And I would like to have IMSM support if that is possible.

Thanks,
Mariusz
