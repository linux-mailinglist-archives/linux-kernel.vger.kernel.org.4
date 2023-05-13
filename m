Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE14F70162B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbjEMKbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbjEMKbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:31:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13DF2738;
        Sat, 13 May 2023 03:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B57260C1D;
        Sat, 13 May 2023 10:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AEFC433EF;
        Sat, 13 May 2023 10:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683973892;
        bh=pE9t+S1isTqXQpDD/QGr2Je7N042xoFfeqxpoT4tSVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPgI/9lG2TTQHuzOjteWJCRb6jC8pcQAG8DFTNjWDJnfGqgvXAGEA8YU8ZMikY3Ti
         VbtrJ3c+XTV4zAiy6AZ7Z5sMYx7Eo4iZBkPE5HMSDlxMYKduO4csN7UD7NaEOt6Z5G
         iVl/hfvqxF+//PtkF4DaZlM49+u0qtO/Di7fvHYY=
Date:   Sat, 13 May 2023 19:23:57 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] tty: n_gsm: add DLCI specific rx/tx statistics
Message-ID: <2023051332-ethics-renounce-b61d@gregkh>
References: <20230426080315.7595-1-daniel.starke@siemens.com>
 <20230426080315.7595-8-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426080315.7595-8-daniel.starke@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 10:03:15AM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Add counters for the number of data bytes received/transmitted per DLCI in
> for preparation for an upcoming patch which will expose these values to the
> user.

As this is patch 8/8, "upcoming patch" makes no sense, sorry.  Please
either drop this and add it as part of the series that provides this
functionality, or add the functionality to the patch series as the next
patch in it.

> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> v3 -> v4:
> No changes.
> 
> Link: https://lore.kernel.org/all/20230424075251.5216-8-daniel.starke@siemens.com/
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 62bff4474b57..2e2e1dafcf40 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -186,6 +186,9 @@ struct gsm_dlci {
>  	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
>  	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
>  	struct net_device *net; /* network interface, if created */
> +	/* Statistics (not currently exposed) */

No blank line before this?

And why isn't this structure documented in kerneldoc to make it more
obvious what is happening?

thanks,

greg k-h
