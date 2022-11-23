Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55E8636745
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiKWRcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbiKWRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:31:39 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371068E2B9;
        Wed, 23 Nov 2022 09:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669224682;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0nhAiOB5tBSBigTMtkx6J+G6Cq310y66dwYZRw1qDCM=;
    b=k9ARrRX6ewfCD8yG2SUCle3o1TGEIRg+8jZ/FM6W0DLgPWYpGVUcNleji6EGpB6BTh
    aRBVBYW7Ta1KdC0bouoDUQkKHCd4zOJQJ66S+0Y6mGx3az7J26W2puG3ibs8OUt2dyVQ
    YYY9ufBNDOcV/ob/mHRqrHEV60xji12JcEiT31fEAOtVl+z+9uWEEKy+XbF+Ag2BoIop
    xEtbXdtYB1C/YgZ0hPq+ocfBSfpvBVKCdvWMV4ZDcybarPLjOd55xXDLi9HUwVwmNmwT
    FQ3GFr3w9rj3VQVR/+WUUeGuAxMgly6FXIKeBkCDS+h82q1Az1yDfFeWRuMo6HkVV6Cd
    0pcw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
X-RZG-CLASS-ID: mo00
Received: from blinux
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyANHVLnLS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 23 Nov 2022 18:31:21 +0100 (CET)
Message-ID: <67f8930848d9c6b73f225a55920de29623db9bdd.camel@iokpp.de>
Subject: Re: [PATCH v3 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length
 function
From:   Bean Huo <beanhuo@iokpp.de>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 23 Nov 2022 18:31:20 +0100
In-Reply-To: <1669045590-26101-5-git-send-email-Arthur.Simchaev@wdc.com>
References: <1669045590-26101-1-git-send-email-Arthur.Simchaev@wdc.com>
         <1669045590-26101-5-git-send-email-Arthur.Simchaev@wdc.com>
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
............
> -	if (param_offset >= buff_len) {
> -		dev_err(hba->dev, "%s: Invalid offset 0x%x in
> descriptor IDN 0x%x, length 0x%x\n",
> -			__func__, param_offset, desc_id, buff_len);
> -		return -EINVAL;
> -	}
> -
>  	/* Check whether we need temp memory */
>  	if (param_offset != 0 || param_size < buff_len) {
>  		desc_buf = kzalloc(buff_len, GFP_KERNEL);
> @@ -3434,15 +3407,23 @@ int ufshcd_read_desc_param(struct ufs_hba
> *hba,
>  
>  	/* Request for full descriptor */
>  	ret = ufshcd_query_descriptor_retry(hba,
> UPIU_QUERY_OPCODE_READ_DESC,
> -					desc_id, desc_index, 0,
> -					desc_buf, &buff_len);
> -
> +					    desc_id, desc_index, 0,
> +					    desc_buf, &buff_len);
>  	if (ret) {
>  		dev_err(hba->dev, "%s: Failed reading descriptor.
> desc_id %d, desc_index %d, param_offset %d, ret %d\n",
>  			__func__, desc_id, desc_index, param_offset,
> ret);
>  		goto out;
>  	}
>  
> +	/* Update descriptor length */
> +	buff_len = desc_buf[QUERY_DESC_LENGTH_OFFSET];
> +
> +	if (param_offset >= buff_len) {
> +		dev_err(hba->dev, "%s: Invalid offset 0x%x in
> descriptor IDN 0x%x, length 0x%x\n",
> +			__func__, param_offset, desc_id, buff_len);
> +		return -EINVAL;
> +	}
> +

a little bit concerned here, but understood your point that you want to
anyway read descriptor, then check if param_offset is a valid input. I
think, there is no problem. 

All in all, this series is a very nice cleanup, we removed all
unnecessary if-state, and complicated rules, making code more readable
than before.

Reviewed-by: Bean Huo <beanhuo@micron.com>


Thanks,
Bean



