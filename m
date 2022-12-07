Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DE7646524
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLGXcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:31:59 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4703189ACE;
        Wed,  7 Dec 2022 15:31:59 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id a9so18521332pld.7;
        Wed, 07 Dec 2022 15:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89G9yW94FuUwQeU9iD8DjLO4IBdrRmB5Y4jr3v6OvPE=;
        b=kNT9lpBfpjCcEFhJwsk83HPsvwUa/0lwsP+9cRMEXXxjsPJ9V4hZ7FLoZh+v+C72nX
         OkubANKQe41S7p4dA9s09fb+RSz4R11DCScpIOWEgA1iI578s3H6yMMKByVQZWIPb7vf
         BtoBa+PR7J9g+djb7Ji+mFjvqCu2ONgLcNBeltruSKE31JWWDIVyW1siRCtuJfowDTgj
         RIOxxyxdOCfg481U2m/OeblrGMPCEhHJJ7+Ug0ptjHLIvlrXc0DFqmBodPsdo+QzxZDW
         5koZQL9mgaJjy3Dy/tE8oGet5ZHrcEC6qF7BQhORlQx7+NJDoP0PsCgFICnIQW4mL+kl
         n0wQ==
X-Gm-Message-State: ANoB5pn4p5Qw+HeRTbapJX4vR53FgEAVRXNNO1iLuGOtDHsZU0tCClDb
        PH8468MHF8+0igYdy9qfQ8k=
X-Google-Smtp-Source: AA0mqf7KoTUWiVuUbP5gv8s3h+lpEEwCmkTd4Dyp4WeSe4OOW3atoyCad2TF4EkuQ2QAMjTzFbPZOw==
X-Received: by 2002:a17:90a:7444:b0:219:d415:d7cd with SMTP id o4-20020a17090a744400b00219d415d7cdmr17123960pjk.89.1670455918488;
        Wed, 07 Dec 2022 15:31:58 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b00188c04258c9sm15119330pla.52.2022.12.07.15.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 15:31:57 -0800 (PST)
Message-ID: <b89f3337-0869-35a8-114d-85e1fd81eb2c@acm.org>
Date:   Wed, 7 Dec 2022 15:31:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/4] ufs: core: Remove redundant wb check
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1669550910-9672-2-git-send-email-Arthur.Simchaev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1669550910-9672-2-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 04:08, Arthur Simchaev wrote:
> We used to use the extended-feature field in the device descriptor,
> as an indication that the device supports ufs2.2 or later.
> Remove that as this check is specifically done few lines above.
> 
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
> ---
>   drivers/ufs/core/ufshcd.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 2dbe249..2e47c69 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7608,10 +7608,6 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
>   	     (hba->dev_quirks & UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES)))
>   		goto wb_disabled;
>   
> -	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
> -	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
> -		goto wb_disabled;
> -
>   	ext_ufs_feature = get_unaligned_be32(desc_buf +
>   					DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);

Does this code really have to be removed? I see a check of the
UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES flag above the removed
code but no check of the descriptor size?

Thanks,

Bart.


