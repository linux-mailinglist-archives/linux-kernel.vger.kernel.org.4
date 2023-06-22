Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407EB73A74C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjFVRc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFVRc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F252125
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687455096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3A/9MXgBBjsOiJR7aN+jD3J+Q2qngmB+feAsrMbXy+w=;
        b=JjKGMMxueYREB2uYgZciIv4mBi6/z9XkjDe2dqFY5sXVWQsg1Du7Ht0OI9JhuDwgvpGqmf
        UK7j83QbzSeXVisfr56p0T2KssPgEaIjilmeTMcntDvY3uLN++Vo00NxRZg7zVPxtazke1
        GwxiyYFLJSwRffvFbrDeM+XOnfJmUmQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-UyN40HpJMXeYe_nUBtgVVA-1; Thu, 22 Jun 2023 13:31:31 -0400
X-MC-Unique: UyN40HpJMXeYe_nUBtgVVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F2C11C08781;
        Thu, 22 Jun 2023 17:31:28 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11C002166B25;
        Thu, 22 Jun 2023 17:31:28 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 0BC4130C0457; Thu, 22 Jun 2023 17:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 0ACF83F7CF;
        Thu, 22 Jun 2023 19:31:28 +0200 (CEST)
Date:   Thu, 22 Jun 2023 19:31:28 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v2 3/6] device-mapper: structs and parameter
 strings must not overlap
In-Reply-To: <20230603145244.1538-4-demi@invisiblethingslab.com>
Message-ID: <c0c36fe0-41cf-abf-727c-bbef17b6face@redhat.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com> <20230603145244.1538-1-demi@invisiblethingslab.com> <20230603145244.1538-4-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Jun 2023, Demi Marie Obenour wrote:

> The NUL terminator for each target parameter string must precede the
> following 'struct dm_target_spec'.  Otherwise, dm_split_args() might
> corrupt this struct.  Furthermore, the first 'struct dm_target_spec'
> must come after the 'struct dm_ioctl', as if it overlaps too much
> dm_split_args() could corrupt the 'struct dm_ioctl'.
> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-ioctl.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 64e8f16d344c47057de5e2d29e3d63202197dca0..da6ca26b51d0953df380582bb3a51c2ec22c27cb 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1391,7 +1391,7 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
>  	return mode;
>  }
>  
> -static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
> +static int next_target(struct dm_target_spec *last, uint32_t next, const char *end,
>  		       struct dm_target_spec **spec, char **target_params)
>  {
>  	static_assert(_Alignof(struct dm_target_spec) <= 8,
> @@ -1404,7 +1404,7 @@ static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
>  	 * sizeof(struct dm_target_spec) or more, as otherwise *last was
>  	 * out of bounds already.
>  	 */
> -	size_t remaining = (char *)end - (char *)last;
> +	size_t remaining = end - (char *)last;
>  
>  	/*
>  	 * There must be room for both the next target spec and the
> @@ -1423,10 +1423,7 @@ static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
>  	*spec = (struct dm_target_spec *) ((unsigned char *) last + next);
>  	*target_params = (char *) (*spec + 1);
>  
> -	if (*spec < (last + 1))
> -		return -EINVAL;
> -
> -	return invalid_str(*target_params, end);
> +	return 0;
>  }
>  
>  static int populate_table(struct dm_table *table,
> @@ -1436,8 +1433,9 @@ static int populate_table(struct dm_table *table,
>  	unsigned int i = 0;
>  	struct dm_target_spec *spec = (struct dm_target_spec *) param;
>  	uint32_t next = param->data_start;
> -	void *end = (void *) param + param_size;
> +	const char *const end = (const char *) param + param_size;
>  	char *target_params;
> +	size_t min_size = sizeof(struct dm_ioctl);
>  
>  	if (!param->target_count) {
>  		DMERR("%s: no targets specified", __func__);
> @@ -1445,6 +1443,13 @@ static int populate_table(struct dm_table *table,
>  	}
>  
>  	for (i = 0; i < param->target_count; i++) {
> +		const char *nul_terminator;
> +
> +		if (next < min_size) {
> +			DMERR("%s: next target spec (offset %u) overlaps %s",
> +			      __func__, next, i ? "previous target" : "'struct dm_ioctl'");
> +			return -EINVAL;
> +		}
>  
>  		r = next_target(spec, next, end, &spec, &target_params);
>  		if (r) {
> @@ -1452,6 +1457,15 @@ static int populate_table(struct dm_table *table,
>  			return r;
>  		}
>  
> +		nul_terminator = memchr(target_params, 0, (size_t)(end - target_params));
> +		if (nul_terminator == NULL) {
> +			DMERR("%s: target parameters not NUL-terminated", __func__);
> +			return -EINVAL;
> +		}
> +
> +		/* Add 1 for NUL terminator */
> +		min_size = (size_t)(nul_terminator - (const char *)spec) + 1;
> +
>  		r = dm_table_add_target(table, spec->target_type,
>  					(sector_t) spec->sector_start,
>  					(sector_t) spec->length,
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 

