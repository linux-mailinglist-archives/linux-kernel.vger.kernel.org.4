Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB366C384
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjAPPVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjAPPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:21:12 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A9D23D95;
        Mon, 16 Jan 2023 07:16:58 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NwbGF4cWZz6HJLs;
        Mon, 16 Jan 2023 23:16:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 15:16:55 +0000
Date:   Mon, 16 Jan 2023 15:16:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yulong Zhang <yulong.zhang@metoak.net>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/iio/iio_utils:fix memory leak
Message-ID: <20230116151654.00005666@Huawei.com>
In-Reply-To: <20230116033007.58038-1-yulong.zhang@metoak.net>
References: <20230114164114.3212921d@jic23-huawei>
        <20230116033007.58038-1-yulong.zhang@metoak.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 11:30:07 +0800
Yulong Zhang <yulong.zhang@metoak.net> wrote:

> 1. fopen sysfs without fclose.
> 2. asprintf filename without free.
> 3. if asprintf return error,do not need to free the buffer.
> 
> Signed-off-by: Yulong Zhang <yulong.zhang@metoak.net>
> ---
> Yes, you are right. Thanks you for the advice.
> I found another problem, when asprintf return error, still free the
> buffer.This is not correct,I've removed it.
> 
> > sysfsfp = fopen(filename, "r");
> > if (!sysfsfp) {
> >       ret = -errno;
> >       fprintf(stderr, "failed to open %s\n",
> >               filename);
> >       free(filename);
> >       goto error_cleanup_array;
> > }
> > free(filename);  
> Because in if statement still use filename,so I can't free filename
> before it.And I am not sure it can be removed,so I free filename after if
> statement.

Agreed.  My suggestion is drop that error print to simplify the code.
It isn't particularly important to know the full filename that we failed
to open so I think dropping it is a reasonable thing to do.

If you really care about the message then
fprintf(stderr, "failed to open %s/%s_index\n", scan_el_dir, current->name);
will work.


> 
>  tools/iio/iio_utils.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 8d35893b2fa8..abec4331701c 100644
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
> @@ -350,6 +351,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  				free(filename);
>  				goto error_close_dir;
>  			}
> +			free(filename);
>  
>  			errno = 0;
>  			if (fscanf(sysfsfp, "%i", &ret) != 1) {
> @@ -357,7 +359,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  				if (fclose(sysfsfp))
>  					perror("build_channel_array(): Failed to close file");
>  
> -				free(filename);
>  				goto error_close_dir;
>  			}
>  			if (ret == 1)
> @@ -365,11 +366,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
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
> @@ -395,9 +394,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
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
> @@ -405,20 +404,17 @@ int build_channel_array(const char *device_dir, int buffer_idx,
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
> @@ -429,7 +425,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  						strlen(ent->d_name) -
>  						strlen("_en"));
>  			if (!current->name) {
> -				free(filename);
>  				ret = -ENOMEM;
>  				count--;
>  				goto error_cleanup_array;
> @@ -439,7 +434,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  			ret = iioutils_break_up_name(current->name,
>  						     &current->generic_name);
>  			if (ret) {
> -				free(filename);
>  				free(current->name);
>  				count--;
>  				goto error_cleanup_array;
> @@ -450,7 +444,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  				       scan_el_dir,
>  				       current->name);
>  			if (ret < 0) {
> -				free(filename);
>  				ret = -ENOMEM;
>  				goto error_cleanup_array;
>  			}
> @@ -463,6 +456,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  				free(filename);
>  				goto error_cleanup_array;
>  			}
> +			free(filename);
>  
>  			errno = 0;
>  			if (fscanf(sysfsfp, "%u", &current->index) != 1) {
> @@ -470,17 +464,14 @@ int build_channel_array(const char *device_dir, int buffer_idx,
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

