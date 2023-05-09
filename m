Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677EF6FC622
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjEIMU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEIMUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:20:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D5F30E3;
        Tue,  9 May 2023 05:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683634855; x=1715170855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DOQ2P+aYH6VjiZt4o6AQxKLdg0z9OmOL/AuxPkVqVi0=;
  b=BVaRnI1UjoQPENACqXZb44hKD19la9BxTrDQfAmYV7C0vPo+yBh559zA
   r7Il0z+R0g228O5ss5rMqJalY27AN1WGcdkmpFu/iKPZz83pcJCo4IpyK
   xFtLNSRq++Z6yTi1d0DuNROwt1kJ5USM2LSW3hZBzWvDq01UvAbqgkfcH
   KS9OekrEXx1OWbZTD7LyREKVtEg1cun9ruvS/NfarrIHSiO0QT53WE911
   9pLtgabrgQYj33POPWkR+Cr9uKffsEyhEF7hp8GtovHAuUsJvgZizEZ4O
   TQoehPFo3ylPihkG8w+4GoAgxrAWvbKU2PNiN6rruKhuOVy4RwArBsExU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347367793"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="347367793"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 05:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="843077899"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="843077899"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 May 2023 05:20:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 May 2023 15:20:51 +0300
Date:   Tue, 9 May 2023 15:20:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdbabiera@google.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: altmodes/displayport: fix
 pin_assignment_show
Message-ID: <ZFo6oxjdWVzncyn2@kuha.fi.intel.com>
References: <20230508214443.893436-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508214443.893436-1-badhri@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 09:44:43PM +0000, Badhri Jagan Sridharan wrote:
> This patch fixes negative indexing of buf array in pin_assignment_show
> when get_current_pin_assignments returns 0 i.e. no compatible pin
> assignments are found.
> 
> BUG: KASAN: use-after-free in pin_assignment_show+0x26c/0x33c
> ...
> Call trace:
> dump_backtrace+0x110/0x204
> dump_stack_lvl+0x84/0xbc
> print_report+0x358/0x974
> kasan_report+0x9c/0xfc
> __do_kernel_fault+0xd4/0x2d4
> do_bad_area+0x48/0x168
> do_tag_check_fault+0x24/0x38
> do_mem_abort+0x6c/0x14c
> el1_abort+0x44/0x68
> el1h_64_sync_handler+0x64/0xa4
> el1h_64_sync+0x78/0x7c
> pin_assignment_show+0x26c/0x33c
> dev_attr_show+0x50/0xc0
> 
> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 8f3e884222ad..66de880b28d0 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -516,6 +516,10 @@ static ssize_t pin_assignment_show(struct device *dev,
>  
>  	mutex_unlock(&dp->lock);
>  
> +	/* get_current_pin_assignments can return 0 when no matching pin assignments are found */
> +	if (len == 0)
> +		len++;
> +
>  	buf[len - 1] = '\n';
>  	return len;
>  }

thanks,

-- 
heikki
