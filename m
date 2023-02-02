Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522E4688570
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBBRdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBBRdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9C74C07
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675359130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cAKUGmodg4IRX1hPLMrz7uTyPgg2ivvgeN6HaVeWe+E=;
        b=ZW7zXFRVb6x+OYR0dD5MMjPXT2rLX0xPdlEO7gCbD/bF4HWRZ2Em5knNEhJWiMRc6FE7nR
        PwnhXTeGuobynul1outs1W6teVRQ+X1c3BzNg+gkGrZGvYCajJ/odkwD+1hkx+5nE2MPYC
        189Jg5k9UXn0303Ibm0I7j0Y7GkN31A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-GyoR3YI_NIWJGbrkCJyd4Q-1; Thu, 02 Feb 2023 12:32:08 -0500
X-MC-Unique: GyoR3YI_NIWJGbrkCJyd4Q-1
Received: by mail-ed1-f69.google.com with SMTP id t26-20020aa7d71a000000b004a244cc7ee8so1900077edq.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 09:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAKUGmodg4IRX1hPLMrz7uTyPgg2ivvgeN6HaVeWe+E=;
        b=gLNW74y/kqO/o52UnOwD6YAJDqmvqKMRJIzkg9z3m0FDbdkBFAeYuILl+Q8yOMUCPF
         lnac6Uhvos9iIhzRY4XmXGJQBNC7f4V+Nj64ijbc3DsZo2wXKH/64O1HisaJHEIiqFF/
         o6KRXOUWDkbP32JigQOdoR53MMtyV6bI4zaeG8yAersIprC5wNy2mQqh2YQ8HF9D8OrM
         kW2oq9GrKVjlYCPKuQDAqyvP1YrPiKY+yLrDIKl4EdBrXoojSQd2BSq/WEGu6keZUsrD
         6VgheApeG26AFqYcZPCsBpx6yKkb27uB5BfrNF/Ka02DyAClf9nqJ0Im4teg7RLgYpqq
         o47g==
X-Gm-Message-State: AO0yUKXiz9bc/mqHbeF6EbkJ3uzWZK2G/o9t3UuUi3Eb0M5HPOUJgahI
        +KvcpAQn9v/84WiYRlOI6JXgHLorRe6yBqTL0W3PZveReb4/wKmrTSZnuYrJ5Obzh20sEAUdgsR
        vhVLZZpKhsa8J1JjH1L9z0oFo
X-Received: by 2002:a17:906:f0f:b0:878:572b:8ffb with SMTP id z15-20020a1709060f0f00b00878572b8ffbmr2321071eji.72.1675359127725;
        Thu, 02 Feb 2023 09:32:07 -0800 (PST)
X-Google-Smtp-Source: AK7set814grh/B0gFF2lHfKdKmP7hDQcPriv/Ppwx2OKqUQo7xYH1W1GRl0FIPl+8F0vOvvHLvBZNw==
X-Received: by 2002:a17:906:f0f:b0:878:572b:8ffb with SMTP id z15-20020a1709060f0f00b00878572b8ffbmr2321060eji.72.1675359127576;
        Thu, 02 Feb 2023 09:32:07 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709061b5700b0086f4b8f9e42sm78415ejg.65.2023.02.02.09.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:32:06 -0800 (PST)
Date:   Thu, 2 Feb 2023 12:32:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, si-wei.liu@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Directly assign memory key
Message-ID: <20230202123132-mutt-send-email-mst@kernel.org>
References: <20230202125718.1013961-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202125718.1013961-1-elic@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 02:57:18PM +0200, Eli Cohen wrote:
> When creating a memory key, the key value should be assigned to the
> passed pointer and not or'ed to.
> 
> This fix has is required but had no real impact so far.

I don't get what this sentence says. Both grammar and general meaning
elude me.

> Fixes: 29064bfdabd5 ("vdpa/mlx5: Add support library for mlx5 VDPA implementation")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/resources.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> index 9800f9bec225..45ad41287a31 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -213,7 +213,7 @@ int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev, u32 *mkey, u32 *in,
>  		return err;
>  
>  	mkey_index = MLX5_GET(create_mkey_out, lout, mkey_index);
> -	*mkey |= mlx5_idx_to_mkey(mkey_index);
> +	*mkey = mlx5_idx_to_mkey(mkey_index);
>  	return 0;
>  }
>  
> -- 
> 2.38.1

