Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ECD70EFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbjEXHzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbjEXHzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA7A1;
        Wed, 24 May 2023 00:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96D2763A4C;
        Wed, 24 May 2023 07:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F67C433EF;
        Wed, 24 May 2023 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684914916;
        bh=gGib/GiA2Gm73b/0ofZL7dpN4pnLkrUgu6vCLEL+1W8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bNwORg2fsGCZ1L383C+8xuiKbgDJVbGHMZyOa7tiH9aRTE+gxZJ/6tG1YFUoV3dku
         a4jzUPp7K3OefjBZBOmzwC0gj5LZiTFfHdedlJCgI9QBaAZT9QnOIxAID17+0r3Lj2
         jV3YMMdJEZa0iVDt5Uk7sLSxIusIWsm38RqpdClb7vFNjy1XBYnrozwto6cEu642PZ
         /ZYVTJQQIX5b0TjUFzBAi5s+Y3GBtBRrCYg98bgzB222j9nbTeeBlSeuROByzZyvmH
         HmiVhs1wBk7nNTKt7TfB588sSeHhW8FxYex8FEMlGNabjocHQun5h8xmaPi88qSqaz
         NUwI/whDfKFAg==
Message-ID: <8de540c2-9b85-34ea-5f6d-e440ccce08b9@kernel.org>
Date:   Wed, 24 May 2023 16:55:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] scsi: pm80xx: Add fatal error check for
 pm8001_lu_reset()
Content-Language: en-US
To:     Pranav Prasad <pranavpp@google.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Pylypiv <ipylypiv@google.com>
References: <20230523214127.4006891-1-pranavpp@google.com>
 <20230523214127.4006891-3-pranavpp@google.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230523214127.4006891-3-pranavpp@google.com>
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

On 5/24/23 06:41, Pranav Prasad wrote:
> From: Igor Pylypiv <ipylypiv@google.com>
> 
> This patch adds a fatal error check for pm8001_lu_reset().
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index b153f0966e5d..e302d5879bb7 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -918,6 +918,16 @@ int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
>  	struct pm8001_device *pm8001_dev = dev->lldd_dev;
>  	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
>  	DECLARE_COMPLETION_ONSTACK(completion_setstate);
> +
> +	if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
> +		/* If the controller is in fatal error state,
> +		 * we will not get a response from the controller
> +		 */
> +		pm8001_dbg(pm8001_ha, FAIL,
> +				"LUN reset failed due to fatal errors\n");
> +		return rc;
> +	}
> +

Same comments as patch 1. And does this really need to be a separate patch ?
both patches touch the same file, and add a similar change to 2 functions, so I
would fold this in patch 1.

>  	if (dev_is_sata(dev)) {
>  		struct sas_phy *phy = sas_get_local_phy(dev);
>  		sas_execute_internal_abort_dev(dev, 0, NULL);

-- 
Damien Le Moal
Western Digital Research

