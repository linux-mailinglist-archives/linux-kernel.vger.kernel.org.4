Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63C966AC9D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjANQ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjANQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:27:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138977EC2;
        Sat, 14 Jan 2023 08:27:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A105360BC1;
        Sat, 14 Jan 2023 16:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0DFC433EF;
        Sat, 14 Jan 2023 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673713657;
        bh=xhm1s0ctvGqPurQrbTq6wN2B1JQFjU9p9ypUf+Mphrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f69vqOoWeqv8Fod0Oq6vyJKcvCn46EXB+04pKK3ncCFCmQ/UO54OILZIRV5yTFSoC
         Ks+wN2x+NDBjCy9X3rGz9gCvE//xyOplszKEsTtT8CBbkjFIJRQgyZDRoQXiUWcc3L
         QmLA6i7HLln86qYBQmeWz3ZdSNUuPHmfPaxTgPzmvgLTdygGu60ZYUCI0EiqTmTlDH
         MzbbUW4teVnMIphu1VlE+NkG5f15hF4DRWyE6TxhgrYVRKrLpz+hR7Ujvr95zhUjmG
         ovbrPG0VpM15kvTYW+ZuV30ndbKGR4Zfet1grUKGX9bVTU+3KZRmsSg8kJz2+6Ch0T
         HDbWsJdnhFgkA==
Date:   Sat, 14 Jan 2023 16:41:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yulong Zhang <yulong.zhang@metoak.net>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/iio/iio_utils:fix memory leak
Message-ID: <20230114164114.3212921d@jic23-huawei>
In-Reply-To: <20230112110122.22973-1-yulong.zhang@metoak.net>
References: <20230112110122.22973-1-yulong.zhang@metoak.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 19:01:22 +0800
Yulong Zhang <yulong.zhang@metoak.net> wrote:

> 1.fopen sysfsfp without fclose
> 2.asprintf filename without free
> 
> Signed-off-by: Yulong Zhang <yulong.zhang@metoak.net>
Good spot.  One suggestion below on how to tidy up the code
whilst fixing this.

> ---
>  tools/iio/iio_utils.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 8d35893b2..38e9352e5 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -264,6 +264,8 @@ int iioutils_get_param_float(float *output, const char *param_name,
>  			if (fscanf(sysfsfp, "%f", output) != 1)
>  				ret = errno ? -errno : -ENODATA;
>  
> +			fclose(sysfsfp);
> +
>  			break;
>  		}
>  error_free_filename:
> @@ -444,6 +446,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  				count--;
>  				goto error_cleanup_array;
>  			}
> +			free(filename);

Instead of doing it here, why not move the free as early as possible (and hence
drop the need to do it in most of the error paths.
			sysfsfp = fopen(filename, "r");
		+	free(filename);
			if (!sysfsfp) {
				ret = -errno;
		-		free(filename)
... and the other cases that follow.

The same could be done for the case below, at the minor cost of not
having the filename for the print statement (which I think would be fine).

>  
>  			ret = asprintf(&filename,
>  				       "%s/%s_index",

