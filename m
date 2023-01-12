Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E226666EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjALJth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbjALJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:48:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A903050F74;
        Thu, 12 Jan 2023 01:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673516654; x=1705052654;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3kPZjp6HimM9YSIBTE/oXUSO1orPN/Jj19BPBdqSxnA=;
  b=l+UTFcoVie11piSJVRB6ILBprJamFId/vQFYo3nCzcJsU5EKzOHfmN89
   FkmwIck/5/Sy1y/acUZiVCb/9gsqozH2cUX+DvBO/KW1euLKTH1RSAYIO
   eKEFAbO72xm5DnmtRiXot98JycuThn7QIqjBtehPF75CuULHFzUPzHINE
   gJEmoA3TQoEE8vEq05C1DYuOd5VphesIzECoK3FOEHiu/M6GbKJkH9cbn
   7m92Eqkv5Se2pGOOnWjfN98gJ8W+6Xpl8ClrVGak7jA9R+ZublTQOUo1O
   VSuhZqK+lZexeRhUn+yHvFLMrkKfZDMt5xd5WXYNVe8eUcoAvFsE3l6EF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="307181255"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="307181255"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:42:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607725662"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="607725662"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:42:55 -0800
Date:   Thu, 12 Jan 2023 11:42:53 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, Kees Cook <keescook@chromium.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] tty: vt: replace BUG_ON() by WARN_ON_ONCE()
In-Reply-To: <20230112080136.4929-7-jirislaby@kernel.org>
Message-ID: <239b3d75-6186-3c3c-91bb-7ec46545f345@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-7-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-12161107-1673516577=:1665"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-12161107-1673516577=:1665
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> No need to panic in vc_uniscr_copy_line(), just warn. This should never
> happen though, as vc_uniscr_check() is supposed to be called before
> vc_uniscr_copy_line(). And the former checks vc->vc_uni_lines already.
> 
> In any case, use _ONCE as vc_uniscr_copy_line() is called repeatedly for
> each line. So don't flood the logs, just in case.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/vt/vt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 119b3eafef59..db72375141b0 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -535,7 +535,8 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
>  	int offset = row * vc->vc_size_row + col * 2;
>  	unsigned long pos;
>  
> -	BUG_ON(!uni_lines);
> +	if (WARN_ON_ONCE(!uni_lines))
> +		return;
>  
>  	pos = (unsigned long)screenpos(vc, offset, viewed);
>  	if (pos >= vc->vc_origin && pos < vc->vc_scr_end) {
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-12161107-1673516577=:1665--
