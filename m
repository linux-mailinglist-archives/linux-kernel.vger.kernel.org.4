Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C477D666F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjALKRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239881AbjALKPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:15:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDE3D98;
        Thu, 12 Jan 2023 02:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673518537; x=1705054537;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jFP9aQEfPbjadxD0A6G/7Tdp9/QXKykODGpkmN/88FE=;
  b=aUitqnpB7bVawKfT2qoBwkJBQ+0BowHXU1IeQMnoCusB3IFtGuh6+0/J
   WN03GJQmwCddbe7z55j7FEyEri4+QbIWrfJgW06gPOP3mu4NBg0FT5nw/
   L+LeHljDswL0xcn5htuDa/4ca49mowvO8kW5VzIsQ6o8HzpeVWaxrtrIr
   MYZ5Wc3Po93v+SNH2YRfKQJsi5Qom9mxWzVibXtLW7Y2O1raFGUn2zUNO
   cQt9pN8SiYw9lK+3hjs8A0nwsv2Fqe+/W1hhy29+HJn7RMB572DWx3XGK
   2a64oTnufdywntH0cfhAnBsQO5iiqfHYnP/yLKtU4AbjLNnnToOpxAkBS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321358245"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="321358245"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:15:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="651075956"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="651075956"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:15:34 -0800
Date:   Thu, 12 Jan 2023 12:15:32 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, Kees Cook <keescook@chromium.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] tty: vt: separate array juggling to
 juggle_array()
In-Reply-To: <20230112080136.4929-9-jirislaby@kernel.org>
Message-ID: <73d26b6d-6272-37cf-f09e-3e652c5212d0@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-9-jirislaby@kernel.org>
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

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> The algorithm used for scrolling is the array juggling. It has
> complexity O(N) and space complexity O(1). I.e. quite fast w/o
> requirements for temporary storage.
> 
> Move the algorithm to a separate function so it is obvious what it is.
> It is almost generic (except the array type), so if anyone else wants
> array rotation, feel free to make it generic and move it to include/.
> 
> And rename all the variables from i, j, k, sz, d, and so on to something
> saner.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/vt/vt.c | 52 ++++++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 74db07b32abe..7cda18b7ee3d 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -398,40 +398,44 @@ static void vc_uniscr_clear_lines(struct vc_data *vc, unsigned int y,
>  			memset32(vc->vc_uni_lines[y++], ' ', vc->vc_cols);
>  }
>  
> +/* juggling array rotation algorithm (complexity O(N), size complexity O(1)) */
> +static void juggle_array(u32 **array, unsigned int size, unsigned int nr)
> +{
> +	unsigned int gcd_idx;
> +
> +	for (gcd_idx = 0; gcd_idx < gcd(nr, size); gcd_idx++) {
> +		u32 *gcd_idx_val = array[gcd_idx];
> +		unsigned int dst_idx = gcd_idx;
> +
> +		while (1) {
> +			unsigned int src_idx = (dst_idx + nr) % size;
> +			if (src_idx == gcd_idx)
> +				break;
> +
> +			array[dst_idx] = array[src_idx];
> +			dst_idx = src_idx;
> +		}
> +
> +		array[dst_idx] = gcd_idx_val;
> +	}
> +}
> +
>  static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>  			     enum con_scroll dir, unsigned int nr)
>  {
>  	u32 **uni_lines = vc->vc_uni_lines;
> -	unsigned int i, j, k, sz, d, clear;
> +	unsigned int size = b - t;
>  
>  	if (!uni_lines)
>  		return;
>  
> -	sz = b - t;
> -	clear = b - nr;
> -	d = nr;
> -
>  	if (dir == SM_DOWN) {
> -		clear = t;
> -		d = sz - nr;
> -	}
> -
> -	for (i = 0; i < gcd(d, sz); i++) {
> -		u32 *tmp = uni_lines[t + i];
> -		j = i;
> -		while (1) {
> -			k = j + d;
> -			if (k >= sz)
> -				k -= sz;
> -			if (k == i)
> -				break;
> -			uni_lines[t + j] = uni_lines[t + k];
> -			j = k;
> -		}
> -		uni_lines[t + j] = tmp;
> +		juggle_array(&uni_lines[top], size, size - nr);

top? Should be t I think.

> +		vc_uniscr_clear_lines(vc, t, nr);
> +	} else {
> +		juggle_array(&uni_lines[top], size, nr);

Ditto.

> +		vc_uniscr_clear_lines(vc, b - nr, nr);
>  	}
> -
> -	vc_uniscr_clear_lines(vc, clear, nr);
>  }
>  
>  static void vc_uniscr_copy_area(u32 **dst_lines,
> 



-- 
 i.

