Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1824E649756
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 01:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiLLATo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 19:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLLATl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 19:19:41 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9860DE;
        Sun, 11 Dec 2022 16:19:40 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id o12so7267615qvn.3;
        Sun, 11 Dec 2022 16:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uspk5Nv9SyM61iM2cOfEA5hsUJIN1WzruNiZhWdpdfk=;
        b=Rgo3cIgwUUnut+4g9Gf4kZYW4ae/AcVQm+Nbt32q0X6rkz0nkfDIV/zzeU+VWV+i/w
         lmI/ew9cgaTxjvds+zmOIT5DNdb/TmGkOPwIVL5WGCGGKHEPzlgYHeKcajYU74PZomi5
         UENTOe4JMKIOJdYbF5MH/SywaSfhXSP+pe4drY0gFh+6wtxrlKbVDhidDdxcB7Inh9SE
         sKH28poqovXBIOdvcKLYUVEIQQ6QTkv3X5IpOWUZVIrZ3ZAhayLFBpenWDy+XVesDD6o
         /KPPHStcNdoPA5pdyq5EZkEV+vpaVTtQg5ApOiyspOWvo4LwNzzwU5joS+SBximV27Fv
         LRNQ==
X-Gm-Message-State: ANoB5pn2zEGOty9ANZOeh+AQdHru9ZgWh/3NLl2TrSEBNwFCe7TlGW2B
        KbZ1A1GDpm46/fao9F3R+es=
X-Google-Smtp-Source: AA0mqf4scmrbSQfQBvwEHlOtvweKsOroN/veicb8XTYNkzJVzh8GqL1iVLjA6sexXTfsFYh40ZF7Mw==
X-Received: by 2002:ad4:4388:0:b0:4c7:8c96:d2ca with SMTP id s8-20020ad44388000000b004c78c96d2camr18234098qvr.15.1670804379896;
        Sun, 11 Dec 2022 16:19:39 -0800 (PST)
Received: from [10.205.211.210] ([67.142.235.252])
        by smtp.gmail.com with ESMTPSA id bs40-20020a05620a472800b006cbc6e1478csm4742570qkb.57.2022.12.11.16.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 16:19:39 -0800 (PST)
Message-ID: <71a10a4c-a726-edac-c5d3-1bfded690503@acm.org>
Date:   Sun, 11 Dec 2022 16:18:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length
 function
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1670763911-8695-5-git-send-email-Arthur.Simchaev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1670763911-8695-5-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/22 05:05, Arthur Simchaev wrote:
> There shouldn't be any restriction of the descriptor size
> (not the descriptor id for that matter) up to QUERY_DESC_MAX_SIZE.
> According to the spec, the caller can use any descriptor size,
> and it is up to the device to return the actual size.
> Therefore there shouldn't be any sizes hardcoded in the kernel,
> nor any need to cache it, hence ufshcd_map_desc_id_to_length function is
> redundant. Always read the descriptors with QUERY_DESC_MAX_SIZE size.
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

I have not yet replied with "Reviewed-by" to this patch so you are not
yet allowed to add my Reviewed-by tag to this patch.

> +	/* Update descriptor length */
> +	buff_len = desc_buf[QUERY_DESC_LENGTH_OFFSET];

Should a check be added here that desc_buf[QUERY_DESC_LENGTH_OFFSET]
<= QUERY_DESC_MAX_SIZE to protect against firmware bugs? Since
QUERY_DESC_MAX_SIZE == 255, adding BUILD_BUG_ON(QUERY_DESC_SIZE != 255)
and a comment may be sufficient.

Thanks,

Bart.
