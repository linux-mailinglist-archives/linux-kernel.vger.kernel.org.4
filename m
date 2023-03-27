Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D2D6CB0BB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjC0Vec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjC0Veb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:34:31 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFA02121;
        Mon, 27 Mar 2023 14:34:30 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id ix20so9784955plb.3;
        Mon, 27 Mar 2023 14:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ1Q27BixpjwQZ9TKyNNIa72xj78VYX4qx6Qa2RfEzY=;
        b=WnV3VDpDZEPs0RHnbAZfmUc21AjCITWQrrAjVbxzfdc7GyV+UgNOLMyXcDjHksVPKw
         F5ugckPHdWAP8DejfSNoZbJ5CKpzYetSPkeStdEbrEtPmlWuwcILvYluKZ8hc6Wd/wU6
         Vy/gcjjhQNh6/f6WnMlJTXyJAEMUZXvyEwrofrZU/2M++dCCXAgTDON3loqOgenpBvkg
         drA1iN2CzAw4MKUZj25LLXLyMB1naUuQWcNS4jK4n7Ik98mIrTGI9+9Gm9ORO8B0DLMX
         AmcMCaTimVcssliy5YWlXhZ1jRWCtaGx1x7fqw6Tu5va+jCsz0Uo1hCWLhQ1qtueHjIO
         Lm3A==
X-Gm-Message-State: AO0yUKWW+muolioPemlebgnWS/TJ1gRCUeDxRaHc9l82YIGFk5DzGYyX
        8YnSnROfjHyPlL+IxnvScWlysys7KIA=
X-Google-Smtp-Source: AK7set8/neRjEoh9MuSaSvNMMgp1Z/uzrKMIYu8Y3xQS1NcajTUx6fANbAWdFpjNC7x2uArRCqc11g==
X-Received: by 2002:a05:6a20:38a5:b0:d9:fc6c:51fa with SMTP id n37-20020a056a2038a500b000d9fc6c51famr9974073pzf.32.1679952869673;
        Mon, 27 Mar 2023 14:34:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:798e:a3a0:ddc2:c946? ([2620:15c:211:201:798e:a3a0:ddc2:c946])
        by smtp.gmail.com with ESMTPSA id j3-20020aa783c3000000b0062d2ac22b08sm4095704pfn.65.2023.03.27.14.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 14:34:29 -0700 (PDT)
Message-ID: <f41d7aba-63ce-4c32-c01e-68d3647c7479@acm.org>
Date:   Mon, 27 Mar 2023 14:34:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/5] scsi: introduce SHOST_BLOCKED state to support
 blocking IO
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
References: <20230325011734.507453-1-yebin@huaweicloud.com>
 <20230325011734.507453-3-yebin@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230325011734.507453-3-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 18:17, Ye Bin wrote:
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index 9b6fbbe15d92..3b497fd4d329 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -90,6 +90,7 @@ int scsi_host_set_state(struct Scsi_Host *shost, enum scsi_host_state state)
>   		switch (oldstate) {
>   		case SHOST_CREATED:
>   		case SHOST_RECOVERY:
> +		case SHOST_BLOCKED:
>   			break;
>   		default:
>   			goto illegal;
> @@ -99,6 +100,7 @@ int scsi_host_set_state(struct Scsi_Host *shost, enum scsi_host_state state)
>   	case SHOST_RECOVERY:
>   		switch (oldstate) {
>   		case SHOST_RUNNING:
> +		case SHOST_BLOCKED:
>   			break;
>   		default:
>   			goto illegal;
> @@ -109,6 +111,7 @@ int scsi_host_set_state(struct Scsi_Host *shost, enum scsi_host_state state)
>   		switch (oldstate) {
>   		case SHOST_CREATED:
>   		case SHOST_RUNNING:
> +		case SHOST_BLOCKED:
>   		case SHOST_CANCEL_RECOVERY:
>   			break;
>   		default:
> @@ -144,6 +147,14 @@ int scsi_host_set_state(struct Scsi_Host *shost, enum scsi_host_state state)
>   			goto illegal;
>   		}
>   		break;
> +	case SHOST_BLOCKED:
> +		switch (oldstate) {
> +		case SHOST_RUNNING:
> +			break;
> +		default:
> +			goto illegal;
> +		}
> +		break;
>   	}

If a host is blocked, error recovery happens and completes, the host 
will be unblocked. I don't think that is acceptable.

The "blocked" property is orthogonal to the host state so a new boolean 
member variable should be introduced in struct Scsi_Host instead of 
introducing a new SCSI host state.

Thanks,

Bart.
