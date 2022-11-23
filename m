Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87FC6366D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiKWRS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbiKWRSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:18:17 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E802D1D9;
        Wed, 23 Nov 2022 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669223891;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=R0UeZqgN1W/KRuMkfNtu6clTRSc+cnm48BfzbzHViQ4=;
    b=ocdqGLd+yA5M3ntml67/sAnrOr//K+8+oHf4ldTOkbKssIxeaLkCiJBzW+UG2Ij3o5
    6veCdyuJVfLc0xlZtLqgHxdo6/dzHAdoaV7RnMzRO5mSbe0vD3cgXwD8ssdSFCCx5W+h
    pL9I5DwJO6H/miHcQNtzCf199IHvMX6udRq0vUB8gwIDY9jku4KHVU/wa+jQSSV8+k8l
    p2fdPbXaq6uzaCTv/m7Ry7hc+/NFc6qT/hKryU7pmL0/5MCLHG5S5ucvKoVoAjCg80hJ
    qC/QGdufHzO46ZV+BPhCELZEOGAX4I38a6KlXH7Iju297wPTw/DKuI2MXOZ52cR2kw8R
    +ofQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
X-RZG-CLASS-ID: mo00
Received: from blinux
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyANHIAnJX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 23 Nov 2022 18:18:10 +0100 (CET)
Message-ID: <e0d77da04feaa39addf679df9d0964ed180cd06a.camel@iokpp.de>
Subject: Re: [PATCH v3 3/4] ufs: core: Remove len parameter from
 ufshcd_set_active_icc_lvl
From:   Bean Huo <beanhuo@iokpp.de>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 23 Nov 2022 18:18:10 +0100
In-Reply-To: <1669045590-26101-4-git-send-email-Arthur.Simchaev@wdc.com>
References: <1669045590-26101-1-git-send-email-Arthur.Simchaev@wdc.com>
         <1669045590-26101-4-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-21 at 17:46 +0200, Arthur Simchaev wrote:
> len argument is not used anymore in ufshcd_set_active_icc_lvl
> function.
> 
> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
> ---
>  drivers/ufs/core/ufshcd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 7456aa2..604348f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7391,12 +7391,11 @@ static u32 ufshcd_get_max_icc_level(int
> sup_curr_uA, u32 start_scan,
>   * In case regulators are not initialized we'll return 0
>   * @hba: per-adapter instance
>   * @desc_buf: power descriptor buffer to extract ICC levels from.
> - * @len: length of desc_buff
>   *
>   * Returns calculated ICC level
>   */
>  static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
> -						const u8 *desc_buf, int
> len)
> +						const u8 *desc_buf)


The Linux kernel already deprecates the 80 character per line coding
style, so you could keep one line here after removing len.


Reviewed-by: Bean Huo <beanhuo@micron.com>



