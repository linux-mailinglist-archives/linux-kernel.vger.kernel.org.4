Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A50A6BBA38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjCOQvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjCOQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:51:31 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE9612586;
        Wed, 15 Mar 2023 09:51:27 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id le6so26397plb.12;
        Wed, 15 Mar 2023 09:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8yMRvgb1z78m6ywlCEeFIcidxDMeI/qDUWLMk+Wbnw=;
        b=oAXrohi33e/ei5ViEhzFcLruuJiEYkMjlv2M+QY0+mLOF5JSXHd7yij3OmCe/Ndn5m
         q3QPjXPXDHIkZbYBTRNg8hkJkXNGzsqzUngXGN3P0zDqO+vfs56x85bSlhjVNxmzRAeG
         I7vwJm8pD/WqGd6jKFlzt4/Xbrpbl1qjT0JBc1InyIiRhBdksWxnHh4Ym1DyQh6PTgcI
         M2mn5/7Q++X8/64FMpWvX2Rh4TPAiCd2DM0s5uyHBwb4dtdAAd/PAK7LLlFyeepcsAaR
         1fDFcD4xqtUMwQm8GpI5c/V1r8G5IOu/98HJVtB8kss+n16I86e2sGuCzz+wheSodOZk
         3inQ==
X-Gm-Message-State: AO0yUKWNRXIdAra7L2/xwFg/hclFnj4UVKwuazKdFIF4hMP8WnKQmFzV
        sD3KFPbzDfV6Iw6aDSrBY4U=
X-Google-Smtp-Source: AK7set/2AvzEzM5xbHgeaXMKm/azmg7nvgw/oQyhKqEkeuzygZQ5GP5X9mbyM4MwotydyxDXNfYNWw==
X-Received: by 2002:a17:903:888:b0:19e:839e:49d8 with SMTP id kt8-20020a170903088800b0019e839e49d8mr91067plb.59.1678899087181;
        Wed, 15 Mar 2023 09:51:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:558a:e74:a7b9:2212? ([2620:15c:211:201:558a:e74:a7b9:2212])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b0019b9a075f1fsm3901100plb.80.2023.03.15.09.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:51:26 -0700 (PDT)
Message-ID: <92a53663-0359-5e87-2561-340a8719521c@acm.org>
Date:   Wed, 15 Mar 2023 09:51:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] scsi: scsi_dh_alua: fix memleak for 'qdata' in
 alua_activate()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, axboe@kernel.dk,
        sconnor@purestorage.com, michael.christie@oracle.com,
        brian@purestorage.com, yukuai3@huawei.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230315062154.668812-1-yukuai1@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230315062154.668812-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 23:21, Yu Kuai wrote:
> diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
> index 362fa631f39b..a226dc1b65d7 100644
> --- a/drivers/scsi/device_handler/scsi_dh_alua.c
> +++ b/drivers/scsi/device_handler/scsi_dh_alua.c
> @@ -1145,10 +1145,12 @@ static int alua_activate(struct scsi_device *sdev,
>   	rcu_read_unlock();
>   	mutex_unlock(&h->init_mutex);
>   
> -	if (alua_rtpg_queue(pg, sdev, qdata, true))
> +	if (alua_rtpg_queue(pg, sdev, qdata, true)) {
>   		fn = NULL;
> -	else
> +	} else {
> +		kfree(qdata);
>   		err = SCSI_DH_DEV_OFFLINED;
> +	}
>   	kref_put(&pg->kref, release_port_group);
>   out:
>   	if (fn)

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
