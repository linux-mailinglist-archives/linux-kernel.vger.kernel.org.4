Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4AE74A7E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjGFXuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFXuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5AF10E2;
        Thu,  6 Jul 2023 16:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F712614B7;
        Thu,  6 Jul 2023 23:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A94C433C7;
        Thu,  6 Jul 2023 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688687403;
        bh=TyrMk1hJewENthIhHHW+C8m7Poq7V6h/AbUO+VfgG4c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FeRppDTAmuT5UaNaM3zc9t1XQL7ZEX7GfJUIj52oWNSwIXLyLb4iRQgQl2nadc9HG
         pVqfNEbT12TCKe0z+JhSXHri4OtwulqVCb+YCROxkpxTm5qsiFMWLZFF1GszpRfDjS
         jNilBBwk/8JPhMNPZDHkN40MOEaitR1I8U1Ekw6s2mWJkt5+d6LHbvQKjI7al4Wtsj
         cTwiWO5f9+auXrt0re5ipjosr6z8WvwMvEz3fqxaNfeP84GGe+/fMQeOqxuKQF4Tp6
         IssPmcFYtZvoI+a1Ucz86qgdg1fQVfDgaaxTxiM/uUg5c7AlGpcYd4ohGOsTmrDc5h
         90JLLUwnpQJlg==
Message-ID: <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
Date:   Fri, 7 Jul 2023 08:50:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230706130930.64283-2-nmi@metaspace.dk>
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

On 7/6/23 22:09, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Ublk zoned storage support relies on DRV_IN handling for zone report.
> Prepare for this change by adding offsets for the DRV_IN/DRV_OUT commands.
> 
> Also add parenthesis to existing opcodes for better macro hygiene.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  include/uapi/linux/ublk_cmd.h | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 4b8558db90e1..2ebb8d5d827a 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -229,12 +229,22 @@ struct ublksrv_ctrl_dev_info {
>  	__u64   reserved2;
>  };
>  
> -#define		UBLK_IO_OP_READ		0
> +#define		UBLK_IO_OP_READ			0
>  #define		UBLK_IO_OP_WRITE		1
>  #define		UBLK_IO_OP_FLUSH		2
> -#define		UBLK_IO_OP_DISCARD	3
> -#define		UBLK_IO_OP_WRITE_SAME	4
> -#define		UBLK_IO_OP_WRITE_ZEROES	5
> +#define		UBLK_IO_OP_DISCARD		3
> +#define		UBLK_IO_OP_WRITE_SAME		4
> +#define		UBLK_IO_OP_WRITE_ZEROES		5
> +/*
> + * Passthrough (driver private) operation codes range between

This is unclear... Here, what does "driver" refer to ? If it is the ublk
kernel driver, than these commands should not be defined in the uapi
header file, they should be defined in drivers/block/ublk.h. However, if
these are for the user space driver, like all the other operations, then
let's clearly state so. But then, I still not understand why these need
a different naming pattern using the "__UBLK" prefix...

> + * __UBLK_IO_OP_DRV_IN_START and __UBLK_IO_OP_DRV_IN_END for REQ_OP_DRV_IN type
> + * operations and between __UBLK_IO_OP_DRV_OUT_START and
> + * __UBLK_IO_OP_DRV_OUT_END for REQ_OP_DRV_OUT type operations.
> + */
> +#define		__UBLK_IO_OP_DRV_IN_START	32
> +#define		__UBLK_IO_OP_DRV_IN_END		96
> +#define		__UBLK_IO_OP_DRV_OUT_START	__UBLK_IO_OP_DRV_IN_END
> +#define		__UBLK_IO_OP_DRV_OUT_END	160
>  
>  #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
>  #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)

-- 
Damien Le Moal
Western Digital Research

