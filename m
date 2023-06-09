Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9094F72A6D7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjFIXq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjFIXqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:46:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F356B30FE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 16:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686354385; x=1717890385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4HsSE/uhcsnZXiarm4S5bjp5qiVOuFJwIva9sHYvHFk=;
  b=J6vKapJqP0mf44k4y1N4r6URYIAN7byHLTf/YLfNpWahnxIxbWk0iISu
   GD53dfuyQ+d8QKQxiFas6zZK+QAQkEN90AsXch8Svf1CTjQgis7pSaBEH
   oCMCH7z9t6xJdTbH0nlUCBVHehWwo24hLyjsx07AVzbQasXAhClJo4+nG
   Cy9Mhde49l5qikNbbUHDTPQ99AYxR5Z6cA1merntWjo70dsqBHFBEulvt
   bqpJYd+DMv1bQeabQeCt85s5lHhoYGMhTKQCsrCRVghgxEfy/02TigaAr
   xLmqHWWpO9yQzg6oAP51LadUy86W/WKMJ3FUsgaTmEXgsi2+EtkzPW/k9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="342384659"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="342384659"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 16:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="704715256"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="704715256"
Received: from cdhirema-mobl5.amr.corp.intel.com (HELO desk) ([10.251.26.88])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 16:46:24 -0700
Date:   Fri, 9 Jun 2023 16:46:19 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Jordy Zomer <jordyzomer@google.com>
Cc:     linux-kernel@vger.kernel.org, phil@philpotter.co.uk
Subject: Re: [PATCH 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <20230609234619.3bkmlgpxzaetua4d@desk>
References: <20230609131355.71130-1-jordyzomer@google.com>
 <20230609131355.71130-2-jordyzomer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131355.71130-2-jordyzomer@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 01:13:55PM +0000, Jordy Zomer wrote:
> This patch fixes a spectre-v1 gadget in cdrom.
> The gadget could be triggered by,
>  speculatviely bypassing the cdi->capacity check.
> 
> Signed-off-by: Jordy Zomer <jordyzomer@google.com>
> ---
>  drivers/cdrom/cdrom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 416f723a2dbb..3c349bc0a269 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -233,6 +233,7 @@
>  
>  -------------------------------------------------------------------------*/
>  
> +#include "asm/barrier.h"
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #define REVISION "Revision: 3.20"
> @@ -2329,6 +2330,8 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
>  	if (arg >= cdi->capacity)
>  		return -EINVAL;
>  
> +	arg = array_index_mask_nospec(arg, cdi->capacity);

array_index_nospec() is the correct function to use. The above generates
a mask and not the original value. Also it is effective when the second
argument is a build time constant. If thats not possible and this
function is not called very often barrier_nospec() is also an option.
