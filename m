Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB1747A67
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjGDXdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDXdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:33:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A480010E0;
        Tue,  4 Jul 2023 16:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24B6761403;
        Tue,  4 Jul 2023 23:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C16EC433C8;
        Tue,  4 Jul 2023 23:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688513620;
        bh=UBFg7jM+nGcOP7aJdMI3jZqzTjbzaLg092QfOy0yvUw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HIDaMt+6kJ4YWNGPr1+9fNcesC14qKbQzsBGmljimdmWT9eF91Vf4HC1m8hy4vIVy
         JoWUICY/teZbXcNfqNDJjde9i0eNqpT3sfB++bBlfYTXaso4m5mXizHOFXEkolP+dH
         kG1X/noBXGo5PSzGUnZgiR3N32JZHhe6FheHRPtLruYunJ+jcoYfo2ddFAELnhqUWA
         npD/GJGW1qJxgUEGBtOpSvxt9yMAWrO87yiTzeJh46qO31eU066ZWft95/AbULdisi
         9AQkLJfu+4pA6li2ZUU+9wTOToTz/CkrkTiUlwWpujQo/Ub7jf7PL6b6cyhryZsrV0
         IT8KMXaQkD8gA==
Message-ID: <68cc8239-f1d2-1ff5-796d-0e9b47c92b64@kernel.org>
Date:   Wed, 5 Jul 2023 08:33:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/5] ublk: add opcode offsets for DRV_IN/DRV_OUT
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
 <20230704165209.514591-2-nmi@metaspace.dk>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230704165209.514591-2-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 01:52, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Ublk zoned storage support relies on DRV_IN handling for zone report.
> Prepare for this change by adding offsets for the DRV_IN/DRV_OUT commands.
> 
> Also add parenthesis to existing opcodes for better macro hygiene.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  include/uapi/linux/ublk_cmd.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 4b8558db90e1..a32810c8ef2b 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -229,12 +229,16 @@ struct ublksrv_ctrl_dev_info {
>  	__u64   reserved2;
>  };
>  
> -#define		UBLK_IO_OP_READ		0
> -#define		UBLK_IO_OP_WRITE		1
> -#define		UBLK_IO_OP_FLUSH		2
> -#define		UBLK_IO_OP_DISCARD	3
> -#define		UBLK_IO_OP_WRITE_SAME	4
> -#define		UBLK_IO_OP_WRITE_ZEROES	5
> +#define		UBLK_IO_OP_READ			(0)
> +#define		UBLK_IO_OP_WRITE		(1)
> +#define		UBLK_IO_OP_FLUSH		(2)
> +#define		UBLK_IO_OP_DISCARD		(3)
> +#define		UBLK_IO_OP_WRITE_SAME		(4)
> +#define		UBLK_IO_OP_WRITE_ZEROES		(5)

I do not think that adding the parenthesis is useful given that the values are
all constants.

> +#define		__UBLK_IO_OP_DRV_IN_START	(32)
> +#define		__UBLK_IO_OP_DRV_IN_END		(96)
> +#define		__UBLK_IO_OP_DRV_OUT_START	(__UBLK_IO_OP_DRV_IN_END)
> +#define		__UBLK_IO_OP_DRV_OUT_END	(160)

While the UBLK_IO_OP_XXX definitions are fairly obvious from their name, these
are much less obvious. A comment before these __UBLK_IO_OP_XXX would be welcome
to describe what these operations are.

>  
>  #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
>  #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)

-- 
Damien Le Moal
Western Digital Research

