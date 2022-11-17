Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1262DC11
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiKQMze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbiKQMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:54:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943EF62045
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:54:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3222D61CD7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00812C433C1;
        Thu, 17 Nov 2022 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668689696;
        bh=/W7ORfPPE7zeYmKBjDaQfbuKt0and2UyiFiMkLGVGuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzrURmewnPxmkdCaTET97qa0Ng3E/qd39BLCotcA/X5Iv+prRsgGh3rPb/PhvWIFe
         A85x0qsXyN2mAkxDzSoNAGpVEplUhLatFkl+cfUsBo7srz53+fMpY8OTO6yDx9sQrs
         +8BHb6CE/94z95xrtAWLgTDpc6mAZq7ZYWBnZGRY=
Date:   Thu, 17 Nov 2022 13:54:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y3YvGdkyGm7azGg4@kroah.com>
References: <Y3YKhee8L+kAfHM4@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3YKhee8L+kAfHM4@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:48:45PM +0530, Deepak R Varma wrote:
> The code currently uses C90 standard extension based zero length arrays.
> The zero length array member also happens to be the only member of the
> structs. Such zero length array declarations are deprecated and the
> new C99 standard extension of flexible array declarations are to be
> used instead.
> 
> The DECLARE_FLEX_ARRAY() helper allows for a flexible array member as
> the only member in a structure. Refer to these links [1], [2] for
> details.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://lkml.kernel.org/r/YxKY6O2hmdwNh8r8@work
> 
> Issue identified using Coccinelle.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> 
> Notes:
>    1. Proposed change is compile tested only.
>    2. Solution feedback from gustavoars@kernel.org
> 
> 
>  drivers/staging/wlan-ng/hfa384x.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
> index 0611e37df6ac..3a1edcb43e07 100644
> --- a/drivers/staging/wlan-ng/hfa384x.h
> +++ b/drivers/staging/wlan-ng/hfa384x.h
> @@ -960,15 +960,15 @@ struct hfa384x_pdr_nicid {
>  } __packed;
> 
>  struct hfa384x_pdr_refdac_measurements {
> -	u16 value[0];
> +	DECLARE_FLEX_ARRAY(u16, value);
>  } __packed;

Why?  This structure is never used anywhere, right?  So why is this
needed to be changed and not just removed entirely?  Same for the other
structures in this patch.

thanks,

greg k-h
