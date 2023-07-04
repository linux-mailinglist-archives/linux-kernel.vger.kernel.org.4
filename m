Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477BC747A7D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGDXoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGDXoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:44:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1998B133;
        Tue,  4 Jul 2023 16:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE1861405;
        Tue,  4 Jul 2023 23:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA50FC433C7;
        Tue,  4 Jul 2023 23:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688514241;
        bh=ceayCKM3+x6ed5rZZm2T8UQm1FTZPyFU9zOczId87uI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CKS9UMP+8Jd5GwgH+mtjfRSJQkZ9xonvTumDGZUqoYbJzW/83bsl23P6i2E3Mdou6
         dyDutVrDe3/IUaypeYZ3FiefL+ruoidHj3gHgV/sHb7rtAG9j3X1tslOmNAYPF3yYq
         UFpgUDlms0c9IMKFCwfVjjo8+saub4ZvyVD2b5p3QaoZ1dDd6inFuveguWdUsrSlFe
         cfx9yfknL4jGzQR7O6iLz4eKrCfHP/AZ4Z2LMZuY3XMjeaV+HJCPQNQyZ7b6jn2dG2
         OK0MTSgMHhkUSR6Ui/Ba0DiO/N9K45urH+eOMppLzTijnbxewdtys+khF9XVPoU7ey
         4eYO8+Xh2pvWA==
Message-ID: <451e842b-8233-2d85-00f4-d3a0bae1e694@kernel.org>
Date:   Wed, 5 Jul 2023 08:43:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 4/5] ublk: add helper to check if device supports user
 copy
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
References: <20230704165209.514591-1-nmi@metaspace.dk>
 <20230704165209.514591-5-nmi@metaspace.dk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230704165209.514591-5-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 01:52, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> This will be used by ublk zoned storage support.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/block/ublk.c | 2 +-
>  drivers/block/ublk.h | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk.c b/drivers/block/ublk.c
> index a0453619bf67..0b1ec102aaae 100644
> --- a/drivers/block/ublk.c
> +++ b/drivers/block/ublk.c
> @@ -1947,7 +1947,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  		UBLK_F_URING_CMD_COMP_IN_TASK;
>  
>  	/* GET_DATA isn't needed any more with USER_COPY */
> -	if (ub->dev_info.flags & UBLK_F_USER_COPY)
> +	if (ublk_dev_is_user_copy(ub))
>  		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
>  
>  	/* We are not ready to support zero copy */
> diff --git a/drivers/block/ublk.h b/drivers/block/ublk.h
> index 2a4ab721d513..fcbcc6b02aa0 100644
> --- a/drivers/block/ublk.h
> +++ b/drivers/block/ublk.h
> @@ -100,4 +100,9 @@ struct ublk_io {
>  	struct io_uring_cmd *cmd;
>  };
>  
> +static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
> +{
> +	return ub->dev_info.flags & UBLK_F_USER_COPY;
> +}
> +
>  #endif

-- 
Damien Le Moal
Western Digital Research

