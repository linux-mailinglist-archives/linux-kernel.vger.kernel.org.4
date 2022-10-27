Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35E1610407
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbiJ0VK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiJ0VKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:10:03 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFCBBA251;
        Thu, 27 Oct 2022 14:05:57 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id h2so2831040pgp.4;
        Thu, 27 Oct 2022 14:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mGxklrunTZK6vIuzzjEA7VHLokZM3EDboJ72ZVNdvI=;
        b=IVdZJCZB0prZjBWGXl5/I0UmuwoJ+e+HtrbJdHu/vAq4oq7FD02aGU2bq504F9LUdt
         7DfDb1o6bIjbVXdwf0ASR5UnrKOhNWfvCHCmA9X12WMB8qiZSLItS5DvaEWh+pfUlgYB
         jY+XElAFdWHRRbQPze7IY7dD/pQ84GqmZk4+XW2Is+dZvVEYuCvUYL20NbHPgcfZGq3w
         GqS678Qx+3FUSxGmRKAVu+1lr/OEPDYOQajRajkS/vZbRrmIhG/Bnwa1/S19m6TBpYaJ
         cEN6XT6dObZodPJNWyfQfGl2OYsbQ6yTrfULODZdDrWTreFcnZcSj7O0M90J7MlpNDhE
         DhVA==
X-Gm-Message-State: ACrzQf1bYaX46WtSCb3ypIIFNNvhYQmDct6+GNUZ5Y8791wEvH3lbRFx
        aaHkaqiy35BbkCvUhdIb6M9FysYd66o=
X-Google-Smtp-Source: AMsMyM5mnBxyzcIL4mVZ+bDP+9W2blgpJRaZyzgxDzLAqk6tdTAolivJF6ZuMy7FwLGQYv4ybuas+g==
X-Received: by 2002:a63:5f54:0:b0:462:1149:f3b3 with SMTP id t81-20020a635f54000000b004621149f3b3mr43848351pgb.445.1666904715163;
        Thu, 27 Oct 2022 14:05:15 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bc2b:ff19:1b02:257b? ([2620:15c:211:201:bc2b:ff19:1b02:257b])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090a154400b001ef8ab65052sm1385024pja.11.2022.10.27.14.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:05:14 -0700 (PDT)
Message-ID: <a5c8533b-8d5a-2056-a449-cb347c031d92@acm.org>
Date:   Thu, 27 Oct 2022 14:05:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 02/17] ufs: core: Optimize duplicate code to read
 extended feature
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, quic_richardp@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <5997d1d2ceaab9baab13b8a11f6643d0d5905e19.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5997d1d2ceaab9baab13b8a11f6643d0d5905e19.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> The code to parse the extended feature is duplicated more then 2
> times in the ufs core. Replace the duplicated code with the
> function.
> 
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> ---
>   drivers/ufs/core/ufshcd.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 80f01d0..e2be3f4 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7605,13 +7605,7 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
>   	     (hba->dev_quirks & UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES)))
>   		goto wb_disabled;
>   
> -	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
> -	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
> -		goto wb_disabled;
> -
> -	ext_ufs_feature = get_unaligned_be32(desc_buf +
> -					DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
> -
> +	ext_ufs_feature = ufs_get_ext_ufs_feature(hba, desc_buf);
>   	if (!(ext_ufs_feature & UFS_DEV_WRITE_BOOSTER_SUP))
>   		goto wb_disabled;
>   
> @@ -7665,7 +7659,7 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
>   	if (!(hba->caps & UFSHCD_CAP_TEMP_NOTIF) || dev_info->wspecversion < 0x300)
>   		return;
>   
> -	ext_ufs_feature = get_unaligned_be32(desc_buf + DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
> +	ext_ufs_feature = ufs_get_ext_ufs_feature(hba, desc_buf);
>   
>   	if (ext_ufs_feature & UFS_DEV_LOW_TEMP_NOTIF)
>   		mask |= MASK_EE_TOO_LOW_TEMP;

Ah, that's the change I asked for in my reply to the previous patch :-)

Shouldn't patches 01/17 and 02/17 be reordered?

`git rebase -i` should make it easy to reorder these two patches.

Thanks,

Bart.
