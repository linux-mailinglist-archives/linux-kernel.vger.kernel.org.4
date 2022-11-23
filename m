Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBA76361DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiKWObL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbiKWOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:30:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252D8636A;
        Wed, 23 Nov 2022 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669213769; x=1700749769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EHIebqLa03sscCy2G1HPFRaMhMaapA0LRQ/7aYLe60o=;
  b=HLnwIhmLQbsU7flFHusNrmvzyOpIv3cpSBTx+zY7bqoeaAke+hR2DjV5
   UO7TFkKIdLde4VRA04P8nwa1g7NXaqfVNiF1D9CAy1zMxEU5EFwyI06XW
   yTXhnM0r4tQHkDBAHxW8KPn12g2ZeK5pAx2AK5XKOksk758kvWrLIaVdI
   nzRCnL4e4/nshKDCsOIgnSMSQfZURS4hivRS+baitUd965HK3f+X8bS3w
   +GbxKA0xXnN4Ua0SaM573iFw9he5ztTQ3nsle11t3jGsFk0Yj3Ejvphvt
   Xfhwmd2jyj/eJUH+efiCBouXWgWJz3cPZaS1KSNyp1u8BGugYFylDBcnm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311705279"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="311705279"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 06:29:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="766737472"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="766737472"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2022 06:29:05 -0800
Message-ID: <3c56ee14-2ff6-8b45-4407-8e7828ed4236@linux.intel.com>
Date:   Wed, 23 Nov 2022 16:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v3 4/4] xhci: Convert to use list_count()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20221122153516.52577-1-andriy.shevchenko@linux.intel.com>
 <20221122153516.52577-4-andriy.shevchenko@linux.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20221122153516.52577-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2022 17.35, Andy Shevchenko wrote:
> The list API now provides the list_count() to help with counting
> existing nodes in the list. Utilise it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: no change
> v2: no change
>   drivers/usb/host/xhci-ring.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
