Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0631E666EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjALJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjALJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:54:42 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41CA64FF;
        Thu, 12 Jan 2023 01:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673517138; x=1705053138;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eLWDeyC8QQXWhFINsIlAtVneYWu8MSfnph1t9h36pHw=;
  b=l3Prdq69spzyqUqucMGPxMT8sxK8h0LB+QlI+0qbGymvwxo+qgm5L+SR
   vxv1KeGAdNUbUp+jN/DDXQnogRpsJ7oK2r+08Nyrsb6YqavWu3cuw6OhW
   /Kfb2LSEfybAhDESyVS0h8yeWMWg1rVlkRhI3NNPbVoEr5H/KROwc9KnH
   Kw43aOw7cHfaTVCpZBwxLrtZM1aJEfRZt0nGiqRXC8rRV/riB8jB5kBnw
   8nTwtj2Pqqw02ZMcPD3Tz5mPFGuO96C1u67pDKaPrj+YnSPNHz7y2UqCF
   AONb81rrtf5ohXKZ4R+XWB6LnCfaZynytXhLnP4hZG6Tyq8nfDxsdyoqE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="304037584"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="304037584"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:52:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="903116283"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="903116283"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:52:16 -0800
Date:   Thu, 12 Jan 2023 11:52:14 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, Kees Cook <keescook@chromium.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] tty: vt: simplify some unicode conditions
In-Reply-To: <20230112080136.4929-8-jirislaby@kernel.org>
Message-ID: <2a1c8867-92e9-edce-257e-89a343efe836@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-8-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1038312899-1673517137=:1665"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1038312899-1673517137=:1665
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> After previous patches, we can simply test vc->vc_uni_lines, so do so in
> many unicode functions. This makes the code more compact. And even use
>   if (!)
>     return;
> in vc_uniscr_scroll(), so that the whole code is indented on the left.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/vt/vt.c | 85 +++++++++++++++++++--------------------------
>  1 file changed, 36 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index db72375141b0..74db07b32abe 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -357,18 +357,14 @@ static void vc_uniscr_set(struct vc_data *vc, u32 **new_uni_lines)
>  
>  static void vc_uniscr_putc(struct vc_data *vc, u32 uc)
>  {
> -	u32 **uni_lines = vc->vc_uni_lines;
> -
> -	if (uni_lines)
> -		uni_lines[vc->state.y][vc->state.x] = uc;
> +	if (vc->vc_uni_lines)
> +		vc->vc_uni_lines[vc->state.y][vc->state.x] = uc;
>  }
>  
>  static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
>  {
> -	u32 **uni_lines = vc->vc_uni_lines;
> -
> -	if (uni_lines) {
> -		u32 *ln = uni_lines[vc->state.y];
> +	if (vc->vc_uni_lines) {
> +		u32 *ln = vc->vc_uni_lines[vc->state.y];
>  		unsigned int x = vc->state.x, cols = vc->vc_cols;
>  
>  		memmove(&ln[x + nr], &ln[x], (cols - x - nr) * sizeof(*ln));
> @@ -378,10 +374,8 @@ static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
>  
>  static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
>  {
> -	u32 **uni_lines = vc->vc_uni_lines;
> -
> -	if (uni_lines) {
> -		u32 *ln = uni_lines[vc->state.y];
> +	if (vc->vc_uni_lines) {
> +		u32 *ln = vc->vc_uni_lines[vc->state.y];
>  		unsigned int x = vc->state.x, cols = vc->vc_cols;
>  
>  		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
> @@ -392,59 +386,52 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
>  static void vc_uniscr_clear_line(struct vc_data *vc, unsigned int x,
>  				 unsigned int nr)
>  {
> -	u32 **uni_lines = vc->vc_uni_lines;
> -
> -	if (uni_lines) {
> -		u32 *ln = uni_lines[vc->state.y];
> -
> -		memset32(&ln[x], ' ', nr);
> -	}
> +	if (vc->vc_uni_lines)
> +		memset32(&vc->vc_uni_lines[vc->state.y][x], ' ', nr);
>  }
>  
>  static void vc_uniscr_clear_lines(struct vc_data *vc, unsigned int y,
>  				  unsigned int nr)
>  {
> -	u32 **uni_lines = vc->vc_uni_lines;
> -
> -	if (uni_lines) {
> -		unsigned int cols = vc->vc_cols;
> -
> +	if (vc->vc_uni_lines)
>  		while (nr--)
> -			memset32(uni_lines[y++], ' ', cols);
> -	}
> +			memset32(vc->vc_uni_lines[y++], ' ', vc->vc_cols);
>  }
>  
>  static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>  			     enum con_scroll dir, unsigned int nr)
>  {
>  	u32 **uni_lines = vc->vc_uni_lines;
> +	unsigned int i, j, k, sz, d, clear;
>  
> -	if (uni_lines) {
> -		unsigned int i, j, k, sz, d, clear;
> +	if (!uni_lines)
> +		return;
>  
> -		sz = b - t;
> -		clear = b - nr;
> -		d = nr;
> -		if (dir == SM_DOWN) {
> -			clear = t;
> -			d = sz - nr;
> -		}
> -		for (i = 0; i < gcd(d, sz); i++) {
> -			u32 *tmp = uni_lines[t + i];
> -			j = i;
> -			while (1) {
> -				k = j + d;
> -				if (k >= sz)
> -					k -= sz;
> -				if (k == i)
> -					break;
> -				uni_lines[t + j] = uni_lines[t + k];
> -				j = k;
> -			}
> -			uni_lines[t + j] = tmp;
> +	sz = b - t;
> +	clear = b - nr;
> +	d = nr;
> +
> +	if (dir == SM_DOWN) {
> +		clear = t;
> +		d = sz - nr;
> +	}
> +
> +	for (i = 0; i < gcd(d, sz); i++) {
> +		u32 *tmp = uni_lines[t + i];
> +		j = i;
> +		while (1) {
> +			k = j + d;
> +			if (k >= sz)
> +				k -= sz;
> +			if (k == i)
> +				break;
> +			uni_lines[t + j] = uni_lines[t + k];
> +			j = k;
>  		}
> -		vc_uniscr_clear_lines(vc, clear, nr);
> +		uni_lines[t + j] = tmp;
>  	}
> +
> +	vc_uniscr_clear_lines(vc, clear, nr);
>  }
>  
>  static void vc_uniscr_copy_area(u32 **dst_lines,
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

With the note that increased density of "vc[-_]" per line feels a step 
backwards on readability even if the number of lines is less, IMHO.

-- 
 i.

--8323329-1038312899-1673517137=:1665--
