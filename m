Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E848C5B883B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiINM1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiINM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:27:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772980E93;
        Wed, 14 Sep 2022 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663158410; x=1694694410;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FXpukppwLTUZtkrCV8069cSTP4V7FD1gf4WK/O7FkMc=;
  b=G52rDO0o2R+pKtiknoUDXjy3C96JY5aDbw1KR5XJh1u0WE3lyBKDmtML
   njBNLRsUh270bgqjEzmG+S5gZzd2zMEvTM7MYdnBnw0uIrs17X+n3usFm
   8oj2wjEupanOEtn8qb4/udd4sv+tXLKnYkCNkGeSIsWmtcMXWrM0umLJl
   8zwliwlWRUcyukNUKwIE1wkTuVsT2txFCYv68/ZXATIpf1oDSifxl8SVl
   Vmxm53HFaf08rLXGjtT6OYWrvQgvRQDXx4oMPpB+uedNdVpClnWlzH19v
   2fFTFN/ry4YKzgycdLD1YhCVZRMNIQYfJvBOKjpuyIdrAUwpH2z/JftSL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298414116"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="298414116"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 05:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="679023475"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2022 05:26:48 -0700
Message-ID: <02ef1ae2-9dae-6f02-9951-1230939f06e2@linux.intel.com>
Date:   Wed, 14 Sep 2022 15:28:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] xhci: Don't show warning for reinit on known broken
 suspend
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Puma Hsu <pumahsu@google.com>
Cc:     "Artem S . Tashkinov" <aros@gmx.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220913203515.451-1-mario.limonciello@amd.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20220913203515.451-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.9.2022 23.35, Mario Limonciello wrote:
> commit 8b328f8002bc ("xhci: re-initialize the HC during resume if HCE was
> set") introduced a new warning message when the host controller error
> was set and re-initializing.
> 
> This is expected behavior on some designs which already set
> `xhci->broken_suspend` so the new warning is alarming to some users.
> 
> Modify the code to only show the warning if this was a surprising behavior
> to the XHCI driver.
> 
> Fixes: 8b328f8002bc ("xhci: re-initialize the HC during resume if HCE was set")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216470
> Reported-by: Artem S. Tashkinov <aros@gmx.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Thanks, adding to queue

-Mathias
