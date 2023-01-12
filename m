Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04D3666D58
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjALJD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbjALJCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:02:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AAD5005C;
        Thu, 12 Jan 2023 00:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673513899; x=1705049899;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vQleIK3d6nlYiV7q13AvoUrr9DXrvzpJ21QDzCiLFLE=;
  b=aDo/J4GwlHcteVh2SPklznr8t7siMypIarpkQgskHqCJYfCw4eTNZMUD
   /sJxaqDP6sKZs47qgEIfvco5YvuHYpuddSNlSxGz2ogG3vvJ7krQpAatm
   SBrlGOx4T2Yp2aFJqLp94LbjIgW+TJfqdxM2YSn7AUefe5oq1OcRt9Yup
   1piSpBvcfymeeB2ckU/8ngTKi6EOwVaHiRLEWdZYSSjVwd3KphSA877cg
   pcDnE9WFEwdqDoIPAxhszgHzjxiniXuospwLUX4xVjT7rkUPu1BAri8sf
   s0Il1i3uBxw7syUgWzK8LcE75LICLD2JPUuP6BFX10oLGGGIAmhLpEWUZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350877468"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="350877468"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:58:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="986459213"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="986459213"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:58:11 -0800
Date:   Thu, 12 Jan 2023 10:58:08 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/11] tty: vt: use sizeof(*variable) where possible
In-Reply-To: <20230112080136.4929-4-jirislaby@kernel.org>
Message-ID: <c6cf55b6-194c-47c8-a44-5266711cd3b@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-4-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> Instead of sizeof(type), use sizeof(*variable) which is preferred. We
> are going to remove the unicode's char32_t typedef, so this makes the
> switch easier.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/vt/vt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 561c82e120cf..3ae0212f1aa7 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -330,11 +330,11 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
>  {
>  	struct uni_screen *uniscr;
>  	void *p;
> -	unsigned int memsize, i;
> +	unsigned int memsize, i, col_size = cols * sizeof(**uniscr->lines);
>  
>  	/* allocate everything in one go */
> -	memsize = cols * rows * sizeof(char32_t);
> -	memsize += rows * sizeof(char32_t *);
> +	memsize = col_size * rows;
> +	memsize += rows * sizeof(*uniscr->lines);

Wouldn't something from linux/overflow.h be more appropriate for these?

-- 
 i.

>  	p = vzalloc(memsize);
>  	if (!p)
>  		return NULL;
> @@ -344,7 +344,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
>  	p = uniscr->lines + rows;
>  	for (i = 0; i < rows; i++) {
>  		uniscr->lines[i] = p;
> -		p += cols * sizeof(char32_t);
> +		p += col_size;
>  	}
>  	return uniscr;
>  }
> @@ -469,7 +469,7 @@ static void vc_uniscr_copy_area(struct uni_screen *dst,
>  		char32_t *src_line = src->lines[src_top_row];
>  		char32_t *dst_line = dst->lines[dst_row];
>  
> -		memcpy(dst_line, src_line, src_cols * sizeof(char32_t));
> +		memcpy(dst_line, src_line, src_cols * sizeof(*src_line));
>  		if (dst_cols - src_cols)
>  			memset32(dst_line + src_cols, ' ', dst_cols - src_cols);
>  		src_top_row++;
> 

