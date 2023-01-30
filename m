Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1169868075A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjA3IZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA3IZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:25:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359582411A;
        Mon, 30 Jan 2023 00:25:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C415960CA3;
        Mon, 30 Jan 2023 08:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4365FC433EF;
        Mon, 30 Jan 2023 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675067114;
        bh=VGiJId1bjg3NxXN/pSLWx22A7YpzR0vUawCKWzEuKi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVS/ofOUDmw7mdGXqcY5tqwJ2PEjf5mF362Q4I55VAef+MEQjVcyyP0fVw+WooqhI
         Cih2HvmA/h59/hyIN1/Mb13BVHJVsIOHDF+qx9lsQFB7QDMotNaV5ZeUox8xjDxSzo
         x9hNAgYYQMWI3H7kZ9u5nqdHu1WJ6DP5+ch7NbQVGwTYMINJNEobpU0z4PxzhfXmhr
         hWZLZ1X5dr8Ai4Zz7/bG9kD2wWp0NY0NEvH20TNIVIGnuTzyovWvo/IuppeyO1I73l
         kr4UBvZ7O7yyhuMW/llyBFbvkNCvcXafl4tyQ2R9uNa6zKZvnQnahCLQfhUoUobg8D
         0j7d+GmHbHYvQ==
Date:   Mon, 30 Jan 2023 13:55:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: include specific ops when
 GENERIC_MSI_IRQ is set
Message-ID: <20230130082506.GC12687@thinkpad>
References: <20230130075615.17108-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230130075615.17108-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 08:56:15AM +0100, Lukas Bulwahn wrote:
> Commit 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN") removes
> the config GENERIC_MSI_IRQ_DOMAIN and replaces all references with
> GENERIC_MSI_IRQ.
> 
> Probably due to concurrent development, commit 519b6274a777 ("scsi: ufs:
> qcom: Add MCQ ESI config vendor specific ops") adds an ifdef block
> conditional under the config GENERIC_MSI_IRQ_DOMAIN.
> 
> Make this code conditional under the existing config GENERIC_MSI_IRQ.
> 
> Fixes: 519b6274a777 ("scsi: ufs: qcom: Add MCQ ESI config vendor specific ops")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

There is already a patch submitted for fixing this issue:
https://lore.kernel.org/linux-scsi/20230126211831.2274211-1-arnd@kernel.org/

Thanks,
Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 681da3ea7154..14283f6dc3f7 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1538,7 +1538,7 @@ static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +#ifdef CONFIG_GENERIC_MSI_IRQ
>  static void ufs_qcom_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  {
>  	struct device *dev = msi_desc_to_dev(desc);
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
