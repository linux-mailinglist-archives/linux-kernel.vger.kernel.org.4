Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26E56DE8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDLBce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDLBc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:32:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6C46B3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681263136; x=1712799136;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9gA5vwQ3bBvMNxkzVssmI+ZsHqjfQLEtL4neeWIgp6c=;
  b=Ghk84vuE9bnwQf2t3Z9uMdvKd8oYEjLDCjF+C+yqhh51BSFpiRZp+zct
   AEhgurntSL2GVph1gtODe207aGFSOT46x1t3A1CMTvtDS+d0LZWT2n6Mt
   HXNsaDVy1GGSgAXHJqk6a3YSTaCCpfN1DaVRO31HJgoSj2x/Az7fbmWhW
   OOxQdYxViv1aUeM30NzniltF045GKzVtMSSbKeOqstPHCvSkCtFaDSn1N
   qU2h0QXoTun7XKRKCoM56b7NAOazXn+PUtxBY0LeUDsl9CJsTorZa0Lh6
   bj1StkaFw7ROPl0eJzEnQvvzT+uLfvUCQ4m8plDG3UdXRjWelGTjFp7hr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="406601629"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="406601629"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="639023937"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="639023937"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2023 18:31:43 -0700
Message-ID: <6d9ed10d-12ee-792f-fc34-60a8e432c5d2@linux.intel.com>
Date:   Wed, 12 Apr 2023 09:31:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, Vinod Koul <vkoul@kernel.org>,
        Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Joerg Roedel <joro@8bytes.org>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-12-baolu.lu@linux.intel.com>
 <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 5:22 AM, David Laight wrote:
>> Sent: 11 April 2023 07:48
>>
>> From: Tina Zhang<tina.zhang@intel.com>
>>
>> The patch fixes the klocwork issues that operands in a bitwise operation
>> have different size at line 1692 of dmar.c, line 1898 and line 1907 of
>> iommu.c.
> Why is this any kind of thing that needs fixing?

This description is a bit misleading. Actually I queued it as a cleanup
patch.

Best regards,
baolu
