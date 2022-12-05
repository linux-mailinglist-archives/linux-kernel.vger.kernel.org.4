Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D464E6426F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiLEKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLEKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:51:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E5C14D00
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:51:45 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C24EF20511;
        Mon,  5 Dec 2022 10:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670237503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sILhT8q/SbH6/uFwCNgNyK6QPXBE0QnfsA9dGRiHK28=;
        b=dGQ8lmBNAkGWO+5j9REEwUde2AwPji4ZiTD5rDUHgryg98bPEZOj2Hoijuh1spVWl2Poib
        WLqwckRggBqsistxjJ4Ex+6M9Cwok8K50M2sFS8acmVNYQEh+E0ie6Fyk3no3cZ6ZNis/F
        WP3PPYgE4BYfb/Od81zVVVMSwM5+UZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670237503;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sILhT8q/SbH6/uFwCNgNyK6QPXBE0QnfsA9dGRiHK28=;
        b=kN2Pwm2ofJkO5SaQJiDg6DGLT6Z+Lbml+zHr/5wW7g/39o//wfIdaTlKhrH7yOecY6Z2EC
        BWKxi8Np55Q7h3Cw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B63DB1348F;
        Mon,  5 Dec 2022 10:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Myt4LD/NjWO/EwAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 10:51:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 46398A0727; Mon,  5 Dec 2022 11:51:43 +0100 (CET)
Date:   Mon, 5 Dec 2022 11:51:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Bartosz Taudul <wolf@nereid.pl>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: Increase UDF_MAX_READ_VERSION to 0x0260
Message-ID: <20221205105143.j6m4g6uzkiy3j3y6@quack3>
References: <20221203010658.247048-1-wolf@nereid.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203010658.247048-1-wolf@nereid.pl>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 03-12-22 01:07:24, Bartosz Taudul wrote:
> Some discs containing the UDF file system are unable to be mounted,
> failing with the following message:
> 
>   UDF-fs: error (device sr0): udf_fill_super: minUDFReadRev=260
>     (max is 250)
> 
> The UDF 2.60 specification [0] states in the section Basic Restrictions
> & Requirements (page 10):
> 
>   The Minimum UDF Read Revision value shall be at most #0250 for all
>   media with a UDF 2.60 file system. This indicates that a UDF 2.50
>   implementation can read all UDF 2.60 media. Media that do not have a
>   Metadata Partition may use a value lower than #250.
> 
> The conclusion is that the discs failing to mount were burned with a
> faulty software, which didn't follow the specification. This can be
> worked around by increasing UDF_MAX_READ_VERSION to 0x260, to match the
> Minimum Read Revision. No other changes are required, as reading UDF
> 2.60 is backward compatible with UDF 2.50.
> 
> [0] http://www.osta.org/specs/pdf/udf260.pdf
> 
> Signed-off-by: Bartosz Taudul <wolf@nereid.pl>

Yeah, thanks for the patch. I've merged it into my tree.

								Honza

> ---
>  fs/udf/
> udf_sb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
> index 4fa620543d30..09d62bf1f5fb 100644
> --- a/fs/udf/udf_sb.h
> +++ b/fs/udf/udf_sb.h
> @@ -6,7 +6,7 @@
>  #include <linux/bitops.h>
>  #include <linux/magic.h>
> 
> -#define UDF_MAX_READ_VERSION		0x0250
> +#define UDF_MAX_READ_VERSION		0x0260
>  #define UDF_MAX_WRITE_VERSION		0x0201
> 
>  #define UDF_FLAG_USE_EXTENDED_FE	0
> --
> 2.38.1
> 


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
