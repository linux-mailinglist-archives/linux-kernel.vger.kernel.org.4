Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE01708C33
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjERXSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjERXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ABF199E;
        Thu, 18 May 2023 16:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FFC9652B9;
        Thu, 18 May 2023 23:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D93CC433EF;
        Thu, 18 May 2023 23:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684451864;
        bh=aCjv5Vh74VrC6iL1FQNps3UVoOBqRjl3Z9qlrwIR9X4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vJUHvlMsT0H3EFzQwwPxpfiyOSU8+bmV2bXjOaSCSwWu8ZuFtC10pyNRbirTNvZDM
         0OPh91KH5mbTF5kOQq+N+UMvXz+ellu6A5tByz/sEHAe0aQnLRFsuG3M3nWJl2IQme
         EthrRkaEU39Y9pmNcqOw9bUJaYEZwK1F2I23JvUPP4WmHpZ2W8CrYZkzbOAGkJ0fIo
         MspRMaHcmlaOphHmJJQzGTfVDjSu6A8UWC/PyyarCD7feEgMqnPPusuxQrUsaZah0m
         mZqHsSJzOp1gy4CWpcKZimFKu7geBzOAjnL45jutHwRlA3U70TO5J3YolXmycj6u03
         CXfXxm7YoxYPg==
Message-ID: <ce4ee43c-8acd-6ad8-3a18-bf4bdfe48f9c@kernel.org>
Date:   Fri, 19 May 2023 08:17:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] ata: libata-core: Simplies if condition
Content-Language: en-US
To:     Yahu Gao <yahu.gao@outlook.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yahu Gao <gaoyh12@lenovo.com>
References: <OS3P286MB0632EC8F4BE2127EF092F59B9E789@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <OS3P286MB0632EC8F4BE2127EF092F59B9E789@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 11:36, Yahu Gao wrote:
> From: Yahu Gao <gaoyh12@lenovo.com>
> 
> Simplify the condition used in ata_dev_revalidate() to not
> issue identify commands to port multiplier devices.
> 
> Signed-off-by: Yahu Gao <gaoyh12@lenovo.com>

Applied to for-6.5 with a fixed up commit title (typo... please run
scripts/checkpatch.pl next time). Thanks !

> ---
>  drivers/ata/libata-core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> Changes since V1:
>  1. Update the subject
>  2. Add more descriptive
>  3. Remove review-by without email
>  4. keep "ata_class_enabled(new_class) &&" condition
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 14c17c3bda4e..2c9472b00f17 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3802,11 +3802,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
>  		return -ENODEV;
>  
>  	/* fail early if !ATA && !ATAPI to avoid issuing [P]IDENTIFY to PMP */
> -	if (ata_class_enabled(new_class) &&
> -	    new_class != ATA_DEV_ATA &&
> -	    new_class != ATA_DEV_ATAPI &&
> -	    new_class != ATA_DEV_ZAC &&
> -	    new_class != ATA_DEV_SEMB) {
> +	if (ata_class_enabled(new_class) && new_class == ATA_DEV_PMP) {
>  		ata_dev_info(dev, "class mismatch %u != %u\n",
>  			     dev->class, new_class);
>  		rc = -ENODEV;

-- 
Damien Le Moal
Western Digital Research

