Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8313626AEB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiKLRli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLRlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:41:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6FA11A3A;
        Sat, 12 Nov 2022 09:41:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C85F1B80989;
        Sat, 12 Nov 2022 17:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52863C433C1;
        Sat, 12 Nov 2022 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668274893;
        bh=MD3R54de6IVkcG0PdDLdRKVnF5hrYqwTKUYedHjwVoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nbAFArz+g+Rcau3mLt/ICc77vjKQPnP07KtWiuootfYSY+kD88dIFnm42w5WLf7+B
         mulFGX+Cr0QYyOHevC7psw7gl3vaaKuQ/0UkrFYNP/sEVX5iFoT+3GAHctFELquh4f
         NTOjB+u3ZV6jrSmetPF8qCR3cBd+iNV01BkdCzF7I5PqM4cKIvttVlT1j9s5jhqoAD
         LAtZ+VPKJ7dphpwqG7pb2G6YPlhMGwg6EARFexNWspb4mps+CZ6XkE2j4re3sykRPa
         zuYS9DTKVl4cQId/ntbmQRYAdkdJu+tZBVea8T3fdlTIIZbFV1kiFfqRpCNZyHDaUx
         DUyzohQ+bFL9A==
Date:   Sat, 12 Nov 2022 17:53:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <daniel.baluta@intel.com>
Subject: Re: [PATCH] iio: core: Fix entry not deleted when
 iio_register_sw_trigger_type() fails
Message-ID: <20221112175343.759300f5@jic23-huawei>
In-Reply-To: <20221108032802.168623-1-chenzhongjin@huawei.com>
References: <20221108032802.168623-1-chenzhongjin@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 8 Nov 2022 11:28:02 +0800
Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> In iio_register_sw_trigger_type(), configfs_register_default_group() is
> possible to fail, but the entry add to iio_trigger_types_list is not
> deleted.
> 
> This leaves wild in iio_trigger_types_list, which can cause page fault
> when module is loading again. So fix this by list_del(&t->list) in error
> path.
> 
> BUG: unable to handle page fault for address: fffffbfff81d7400
> RIP: 0010:__iio_find_sw_trigger_type.isra.3+0x62/0xb0 [industrialio_sw_trigger]
> Call Trace:
> <TASK>
>  iio_register_sw_trigger_type+0x65/0x1f0 [industrialio_sw_trigger]
>  do_one_initcall+0xd0/0x4e0
>  do_init_module+0x1cf/0x6b0
>  load_module+0x65c2/0x7820

I dropped some of the unnecessary noise in the call trace and applied this
to the fixes-togreg branch of iio.git and marked it for stable.

Thanks,

Jonathan

>  ...
> 
> Fixes: b662f809d410 ("iio: core: Introduce IIO software triggers")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  drivers/iio/industrialio-sw-trigger.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
> index 994f03a71520..d86a3305d9e8 100644
> --- a/drivers/iio/industrialio-sw-trigger.c
> +++ b/drivers/iio/industrialio-sw-trigger.c
> @@ -58,8 +58,12 @@ int iio_register_sw_trigger_type(struct iio_sw_trigger_type *t)
>  
>  	t->group = configfs_register_default_group(iio_triggers_group, t->name,
>  						&iio_trigger_type_group_type);
> -	if (IS_ERR(t->group))
> +	if (IS_ERR(t->group)) {
> +		mutex_lock(&iio_trigger_types_lock);
> +		list_del(&t->list);
> +		mutex_unlock(&iio_trigger_types_lock);
>  		ret = PTR_ERR(t->group);
> +	}
>  
>  	return ret;
>  }

