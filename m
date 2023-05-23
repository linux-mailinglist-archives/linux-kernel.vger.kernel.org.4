Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D97C70DBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbjEWMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEWMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC5D119;
        Tue, 23 May 2023 05:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C6D60AB7;
        Tue, 23 May 2023 12:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECED8C4339C;
        Tue, 23 May 2023 12:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684843560;
        bh=SUyHK5C1YHSNjXUhl2h9UJaIWYSGtQt76r4Mldm1/Uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UaG4mD7b1f2ERFkVE4ULCo5+4ZQ66UwnBcX4R35el/WvbxJBAhKYIbX6xNnoY4fzO
         rODi2cBpUGLAKOYwkQyKSLY8/A8r99LJ4hYm9qrl+1yPUItc323ZKwdgUBv4Ta6vxb
         QSeJ3Id946iLtkWUTya3q5ps+nUx7hP2BqFMy+IjR2DTHjabRqy0iH40vilxs45P88
         zH995/SVZ6Kt1htxGy0TJKyn1Ti4hW857OJaisMNklVfA9Kjw6tPfFfShi2OnMrNqf
         F8iLNxODNdqAQgbHB/EMopWn1SjkKp3r+RWVuNoZ7lTUWFR4NrdDnq8oyaayiBJjTi
         aDW4/Iivitc1g==
Date:   Tue, 23 May 2023 05:09:53 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH RESEND v2] interconnect: drop unused icc_get() interface
Message-ID: <20230523120953.4ryl3rowbppvqmmd@ripper>
References: <20230523095248.25211-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523095248.25211-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:52:48AM +0200, Johan Hovold wrote:
> The icc_get() interface can be used to lookup an interconnect path based
> on global node ids. There has never been any users of this interface and
> all lookups are currently done from the devicetree.
> 
> Remove the unused icc_get() interface.
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Hi Georgi,
> 
> I just noticed that this patch never made it into 6.4 along with the
> rest of the series:
> 
> 	https://lore.kernel.org/lkml/20230306075651.2449-23-johan+linaro@kernel.org/
> 
> This interface is still unused in mainline and should be removed so
> resending the patch again.
> 
> Johan
> 
> 
>  drivers/interconnect/core.c  | 52 ++----------------------------------
>  include/linux/interconnect.h |  8 ------
>  2 files changed, 2 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index ec46bcb16d5e..5fac448c28fd 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -587,7 +587,7 @@ EXPORT_SYMBOL_GPL(icc_set_tag);
>  
>  /**
>   * icc_get_name() - Get name of the icc path
> - * @path: reference to the path returned by icc_get()
> + * @path: interconnect path
>   *
>   * This function is used by an interconnect consumer to get the name of the icc
>   * path.
> @@ -605,7 +605,7 @@ EXPORT_SYMBOL_GPL(icc_get_name);
>  
>  /**
>   * icc_set_bw() - set bandwidth constraints on an interconnect path
> - * @path: reference to the path returned by icc_get()
> + * @path: interconnect path
>   * @avg_bw: average bandwidth in kilobytes per second
>   * @peak_bw: peak bandwidth in kilobytes per second
>   *
> @@ -704,54 +704,6 @@ int icc_disable(struct icc_path *path)
>  }
>  EXPORT_SYMBOL_GPL(icc_disable);
>  
> -/**
> - * icc_get() - return a handle for path between two endpoints
> - * @dev: the device requesting the path
> - * @src_id: source device port id
> - * @dst_id: destination device port id
> - *
> - * This function will search for a path between two endpoints and return an
> - * icc_path handle on success. Use icc_put() to release
> - * constraints when they are not needed anymore.
> - * If the interconnect API is disabled, NULL is returned and the consumer
> - * drivers will still build. Drivers are free to handle this specifically,
> - * but they don't have to.
> - *
> - * Return: icc_path pointer on success, ERR_PTR() on error or NULL if the
> - * interconnect API is disabled.
> - */
> -struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
> -{
> -	struct icc_node *src, *dst;
> -	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> -
> -	mutex_lock(&icc_lock);
> -
> -	src = node_find(src_id);
> -	if (!src)
> -		goto out;
> -
> -	dst = node_find(dst_id);
> -	if (!dst)
> -		goto out;
> -
> -	path = path_find(dev, src, dst);
> -	if (IS_ERR(path)) {
> -		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> -		goto out;
> -	}
> -
> -	path->name = kasprintf(GFP_KERNEL, "%s-%s", src->name, dst->name);
> -	if (!path->name) {
> -		kfree(path);
> -		path = ERR_PTR(-ENOMEM);
> -	}
> -out:
> -	mutex_unlock(&icc_lock);
> -	return path;
> -}
> -EXPORT_SYMBOL_GPL(icc_get);
> -
>  /**
>   * icc_put() - release the reference to the icc_path
>   * @path: interconnect path
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index 2b0e784ba771..97ac253df62c 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -40,8 +40,6 @@ struct icc_bulk_data {
>  
>  #if IS_ENABLED(CONFIG_INTERCONNECT)
>  
> -struct icc_path *icc_get(struct device *dev, const int src_id,
> -			 const int dst_id);
>  struct icc_path *of_icc_get(struct device *dev, const char *name);
>  struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
>  int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
> @@ -61,12 +59,6 @@ void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths);
>  
>  #else
>  
> -static inline struct icc_path *icc_get(struct device *dev, const int src_id,
> -				       const int dst_id)
> -{
> -	return NULL;
> -}
> -
>  static inline struct icc_path *of_icc_get(struct device *dev,
>  					  const char *name)
>  {
> -- 
> 2.39.3
> 
