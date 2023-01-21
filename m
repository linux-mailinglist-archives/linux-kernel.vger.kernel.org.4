Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894EB6767C0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAURjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjAURjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:39:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33913BBB5;
        Sat, 21 Jan 2023 09:39:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1C2060B3F;
        Sat, 21 Jan 2023 17:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD9AC433D2;
        Sat, 21 Jan 2023 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674322784;
        bh=TTQhsS+0124V7yGlEPvI/b3+E5gwGkVxPsyPcyh3fYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HmqH4x6Ptw/zTpfBuoRUAbXOkr2qv5+p6STnrE4T2dfEPmUVBsSQfEd03GNEyCC/U
         zSCJYPro1XJmxq+h1vEygdpTMK1l1onGJ6ODGMpZUmpB2mOJqMwwNTGFFK/7dn4OWA
         wKhSWPrcgLyqaNJ0DVS+dq8J9Y+hFLEivOGcnJ0oNQX12os4eAluR+qUO8o9+KUl2y
         3iBhGWoSXEBc6YDtTqe6gGzH0m0jeogpeXcjME3OpHmHKnCwIpbkJt93QfWWbj0169
         AH0rwz1A7nyK7xQTekwCA28/jqI/fmbj0vnUWiScpenaxEW8ypeHAa8yrMNJull42t
         jmicbKXO52B6w==
Date:   Sat, 21 Jan 2023 17:53:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yulong Zhang <yulong.zhang@metoak.net>
Cc:     jonathan.cameron@huawei.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/iio/iio_utils:fix memory leak
Message-ID: <20230121175329.557f7715@jic23-huawei>
In-Reply-To: <20230117025147.69890-1-yulong.zhang@metoak.net>
References: <20230116151654.00005666@Huawei.com>
        <20230117025147.69890-1-yulong.zhang@metoak.net>
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

On Tue, 17 Jan 2023 10:51:47 +0800
Yulong Zhang <yulong.zhang@metoak.net> wrote:

> 1. fopen sysfs without fclose.
> 2. asprintf filename without free.
> 3. if asprintf return error,do not need to free the buffer.
> 
> Signed-off-by: Yulong Zhang <yulong.zhang@metoak.net>
I'm not that worried about rushing in a memory leak fix for the example
code, so I've queued this up for the next merge window.

Thanks,

Jonathan

> ---
>  tools/iio/iio_utils.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 8d35893b2fa8..6a00a6eecaef 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -264,6 +264,7 @@ int iioutils_get_param_float(float *output, const char *param_name,
>  			if (fscanf(sysfsfp, "%f", output) != 1)
>  				ret = errno ? -errno : -ENODATA;
>  
> +			fclose(sysfsfp);
>  			break;
>  		}
>  error_free_filename:
> @@ -345,9 +346,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  			}
>  
>  			sysfsfp = fopen(filename, "r");
> +			free(filename);
>  			if (!sysfsfp) {
>  				ret = -errno;
> -				free(filename);
>  				goto error_close_dir;
>  			}
>  
> @@ -357,7 +358,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  				if (fclose(sysfsfp))
>  					perror("build_channel_array(): Failed to close file");
>  
> -				free(filename);
>  				goto error_close_dir;
>  			}
>  			if (ret == 1)
> @@ -365,11 +365,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  
>  			if (fclose(sysfsfp)) {
>  				ret = -errno;
> -				free(filename);
>  				goto error_close_dir;
>  			}
>  
> -			free(filename);
>  		}
>  
>  	*ci_array = malloc(sizeof(**ci_array) * (*counter));
> @@ -395,9 +393,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  			}
>  
>  			sysfsfp = fopen(filename, "r");
> +			free(filename);
>  			if (!sysfsfp) {
>  				ret = -errno;
> -				free(filename);
>  				count--;
>  				goto error_cleanup_array;
>  			}
> @@ -405,20 +403,17 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  			errno = 0;
>  			if (fscanf(sysfsfp, "%i", &current_enabled) != 1) {
>  				ret = errno ? -errno : -ENODATA;
> -				free(filename);
>  				count--;
>  				goto error_cleanup_array;
>  			}
>  
>  			if (fclose(sysfsfp)) {
>  				ret = -errno;
> -				free(filename);
>  				count--;
>  				goto error_cleanup_array;
>  			}
>  
>  			if (!current_enabled) {
> -				free(filename);
>  				count--;
>  				continue;
>  			}
> @@ -429,7 +424,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  						strlen(ent->d_name) -
>  						strlen("_en"));
>  			if (!current->name) {
> -				free(filename);
>  				ret = -ENOMEM;
>  				count--;
>  				goto error_cleanup_array;
> @@ -439,7 +433,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  			ret = iioutils_break_up_name(current->name,
>  						     &current->generic_name);
>  			if (ret) {
> -				free(filename);
>  				free(current->name);
>  				count--;
>  				goto error_cleanup_array;
> @@ -450,17 +443,16 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  				       scan_el_dir,
>  				       current->name);
>  			if (ret < 0) {
> -				free(filename);
>  				ret = -ENOMEM;
>  				goto error_cleanup_array;
>  			}
>  
>  			sysfsfp = fopen(filename, "r");
> +			free(filename);
>  			if (!sysfsfp) {
>  				ret = -errno;
> -				fprintf(stderr, "failed to open %s\n",
> -					filename);
> -				free(filename);
> +				fprintf(stderr, "failed to open %s/%s_index\n",
> +					scan_el_dir, current->name);
>  				goto error_cleanup_array;
>  			}
>  
> @@ -470,17 +462,14 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  				if (fclose(sysfsfp))
>  					perror("build_channel_array(): Failed to close file");
>  
> -				free(filename);
>  				goto error_cleanup_array;
>  			}
>  
>  			if (fclose(sysfsfp)) {
>  				ret = -errno;
> -				free(filename);
>  				goto error_cleanup_array;
>  			}
>  
> -			free(filename);
>  			/* Find the scale */
>  			ret = iioutils_get_param_float(&current->scale,
>  						       "scale",

