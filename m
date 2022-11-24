Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5378C63774A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKXLO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKXLOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:14:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD3501448EB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:14:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D622E106F;
        Thu, 24 Nov 2022 03:14:59 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB42C3F587;
        Thu, 24 Nov 2022 03:14:52 -0800 (PST)
Date:   Thu, 24 Nov 2022 11:14:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wang Honghui <honghui.wang@ucas.com.cn>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] arm_scpi: Rev last modify to support acpi
Message-ID: <20221124111450.mqfpmatba6f7pap6@bogus>
References: <566DA2F800E4BACA+Y39Ak8xtNJaBqB90@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566DA2F800E4BACA+Y39Ak8xtNJaBqB90@TP-P15V.lan>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:59:47PM +0800, Wang Honghui wrote:
> Rev last modify to support acpi
> 
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
> ---
>  drivers/firmware/arm_scpi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index e2e90dcc38bd..aca0a9780c12 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -908,7 +908,9 @@ static const struct of_device_id shmem_of_match[] __maybe_unused = {
>  	{ }
>  };
>  
> +#ifdef CONFIG_PHYTIUM_MBOX
>  extern struct mbox_chan *phytium_mbox_request_channel(struct mbox_client *cl);
> +#endif

I have already NACK the approach you have taken for SCPI + ACPI. Just forgot
to mention SCPI is old and deprecated protocol and SCMI replaced it. You
much be using that if possible.

Anyways, this kind of #ifdeffery is not allowed in any generic code even if
I agreed with the approach. So please don't change the code in such a way.

-- 
Regards,
Sudeep
