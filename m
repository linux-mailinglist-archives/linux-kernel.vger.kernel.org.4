Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D076F5FB8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJKQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJKQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C401EC64;
        Tue, 11 Oct 2022 09:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19EE661123;
        Tue, 11 Oct 2022 16:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183FAC433D6;
        Tue, 11 Oct 2022 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665507428;
        bh=8X8GkrgOpGGj5HDkTWUXplEGBbu7A3Pw+4BTxABEjQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjENLWIbXMigYX+aonaznQV5MvNpG6rRVnxqTaaC6bWDAvZGa/rWlQSUrhH1CvOk1
         GaUzt2JmHGWRDGlvgKl3jr0dNiY7++R7luN/eX2GFdn+3Ge411oYot8j4arBfC/CkU
         S9qoYl9RRj4jirrtJMKjFZ8PqVAiJp8Frtee5beTDIgIe0lp2m6f8w8bizVfopEwku
         hc7GoajkGrfJOw2xxAUIQgZxvTbprgVB6iakyflrRWUFhBzwyqUp6DR6CjYZ5qb2YE
         0G+wdsaRZrmN+Qf2UlQqDa55eK+XxH0UKpOslBYHRpd4xQVQbkKP3eBNkszU3IEdtp
         fqtvuJ+HfBOTw==
Date:   Tue, 11 Oct 2022 09:57:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ten Gao <gaoyankaigeren@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ufs: core: remove encrypt when no data transfer
Message-ID: <Y0WgYlbV4RBqd+lU@sol.localdomain>
References: <20221011072126.30802-1-gaoyankaigeren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011072126.30802-1-gaoyankaigeren@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:21:26PM +0800, Ten Gao wrote:
> From: Ten Gao <ten.gao@unisoc.com>
> 
> when there is no data transmission, ufs is unnecessary to encrypt.
> We need to adjust scsi crypto relation.
> 
> Signed-off-by: Ten Gao <ten.gao@unisoc.com>
> ---
>  drivers/ufs/core/ufshcd-crypto.h | 10 ++++++----
>  include/ufs/ufshci.h             |  2 ++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd-crypto.h b/drivers/ufs/core/ufshcd-crypto.h
> index 504cc841540b..5bc2a0cbdfa6 100644
> --- a/drivers/ufs/core/ufshcd-crypto.h
> +++ b/drivers/ufs/core/ufshcd-crypto.h
> @@ -30,10 +30,12 @@ ufshcd_prepare_req_desc_hdr_crypto(struct ufshcd_lrb *lrbp, u32 *dword_0,
>  				   u32 *dword_1, u32 *dword_3)
>  {
>  	if (lrbp->crypto_key_slot >= 0) {
> -		*dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
> -		*dword_0 |= lrbp->crypto_key_slot;
> -		*dword_1 = lower_32_bits(lrbp->data_unit_num);
> -		*dword_3 = upper_32_bits(lrbp->data_unit_num);
> +		if ((*dword_0 & UTRD_DIRECTION) != UTP_NO_DATA_TRANSFER) {
> +			*dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
> +			*dword_0 |= lrbp->crypto_key_slot;
> +			*dword_1 = lower_32_bits(lrbp->data_unit_num);
> +			*dword_3 = upper_32_bits(lrbp->data_unit_num);
> +		}
>  	}
>  }

This is very dangerous, as it will silently skip en/decryption.  Why was a
keyslot assigned in the first place if the I/O doesn't need en/decryption?

- Eric
