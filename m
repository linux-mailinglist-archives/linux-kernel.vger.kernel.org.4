Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C001A5BAEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiIPNzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIPNyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:54:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32626B07CE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663336460; x=1694872460;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ac3JZSw6gM2bS1E/Wns1pqFzoAkPzK9cgfP29j6vLyc=;
  b=cUVsaY566c7FGmtsdZoXXpvZeXAFyc7SmS60zq188IVrtRWv0C/cqXFq
   Igobinwn5IXOF4d3WaYFqkpw9a0kz9RbLjYWKmEHDGW8KhjhyxYE5oyzF
   T91Vh5BdI59Qj/ZpLPkpib48pWEUPXbsVy2quFeuOvXMAAAlGRQ4gLtb4
   xCnrVmVlX4e/f+62x6NK4EhTMJTtc6qt3B6fABvUrl+WI8Jt28k0J8hqo
   9xUOZKUU5Su09PkXwnIO2B+juP8xEDpzNoIfIV33eWABNSsKTXFdmoNbP
   mC8gY14D/UmRoiZSMklio7qQOUybNn0VJX2jLUJSn1VBkGNTuQQ4rKpHV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="300355813"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="300355813"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 06:54:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="568836479"
Received: from lroque-mobl1.amr.corp.intel.com ([10.251.209.126])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 06:54:12 -0700
Date:   Fri, 16 Sep 2022 16:54:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hyunwoo Kim <imv4bel@gmail.com>
cc:     arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] char: pcmcia: synclink_cs: Fix use-after-free in
 mgslpc_ops
In-Reply-To: <20220916134751.GA234676@ubuntu>
Message-ID: <21d84319-4d1a-8d8e-a098-947772406faf@linux.intel.com>
References: <20220916134751.GA234676@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022, Hyunwoo Kim wrote:

> A race condition may occur if the user physically removes
> the pcmcia device while calling ioctl() for this tty device node.
> 
> This is a race condition between the mgslpc_ioctl() function and
> the mgslpc_detach() function, which may eventually result in UAF.
> 
> So, add a refcount check to mgslpc_detach() to free the structure
> after the tty device node is close()d.
> 
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

> @@ -2517,9 +2548,14 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
>  	if (debug_level >= DEBUG_LEVEL_INFO)
>  		printk("%s(%d):mgslpc_open(%s) success\n",
>  			 __FILE__, __LINE__, info->device_name);
> +
> +	kref_get(&info->refcnt);
>  	retval = 0;
> +	mutex_unlock(&remove_mutex);
>  
> +	return retval;
>  cleanup:
> +	mutex_unlock(&remove_mutex);
>  	return retval;

Just move the cleanup label instead.


-- 
 i.

