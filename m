Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8087D718EB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjEaWoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjEaWoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:44:21 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B807D124;
        Wed, 31 May 2023 15:44:19 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-53f8da65701so90836a12.1;
        Wed, 31 May 2023 15:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685573059; x=1688165059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fD5ZjqjlJEEXtx5aeEmfqHuq48o9Pc6kZflyXmV36Y=;
        b=KEGrD/Txx7uOy4TM9zWXUP9WfPwkWpPVHWKNuyFCWdBlwoGkEKBHp0W4sSOppK5jP8
         WARfdM6aT/B9gwXfIYGum17+eREUXJ1IWQpMlXeHcAekQ501qcGQ2Z7L4I61rogQwplz
         Tn1zkzIDUNo6BxyNS3kN5ljxeaUAdcT0Ib9NZv1SZYQvC8oQYY7e09yG6tNBRR874ERZ
         ue26WBerNJOD3Nv2/DZUesEF9r+AMCJQF1j9A1/+4vjzUuuRyndSLe5ss1VPYhvaLtY7
         PrD9JB2V9NqVnTGHFszjKrEDm/YyJ2GBJ4Vy2LGCiSwYIvHTFExoKqJQ8O0u78d19QT8
         204w==
X-Gm-Message-State: AC+VfDzv1EM89pgZhta4GPZRcI/nVljAG9lrW8f6MyjAWqxFRF4bimg0
        1POvgruzOwP1XAPELI4nDLU=
X-Google-Smtp-Source: ACHHUZ4NOSPHLriHOdbjF/Sun/uDiSMPm6jC57mtKE8I8lZweS7myyzH0En9h+2JLmolCYaqASYBDA==
X-Received: by 2002:a05:6a20:e615:b0:10e:cde2:b524 with SMTP id my21-20020a056a20e61500b0010ecde2b524mr5561726pzb.41.1685573059071;
        Wed, 31 May 2023 15:44:19 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902748600b001b04b1bd774sm1903311pll.208.2023.05.31.15.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 15:44:18 -0700 (PDT)
Message-ID: <c459dd2c-a281-7fc4-90cf-36a71e9548bc@acm.org>
Date:   Wed, 31 May 2023 15:44:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] scsi: sr: Fix a potential uninit-value in sr_get_events()
Content-Language: en-US
To:     Shigeru Yoshida <syoshida@redhat.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230531164346.118438-1-syoshida@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230531164346.118438-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 09:43, Shigeru Yoshida wrote:
> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
> index 12869e6d4ebd..86b43c069a44 100644
> --- a/drivers/scsi/sr.c
> +++ b/drivers/scsi/sr.c
> @@ -177,10 +177,13 @@ static unsigned int sr_get_events(struct scsi_device *sdev)
>   
>   	result = scsi_execute_cmd(sdev, cmd, REQ_OP_DRV_IN, buf, sizeof(buf),
>   				  SR_TIMEOUT, MAX_RETRIES, &exec_args);
> +	if (result)
> +		return 0;
> +
>   	if (scsi_sense_valid(&sshdr) && sshdr.sense_key == UNIT_ATTENTION)
>   		return DISK_EVENT_MEDIA_CHANGE;
>   
> -	if (result || be16_to_cpu(eh->data_len) < sizeof(*med))
> +	if (be16_to_cpu(eh->data_len) < sizeof(*med))
>   		return 0;

I think this change is wrong because it introduces an unintended behavior
change. A better solution is probably to zero-initialize sshdr before
scsi_execute_cmd() is called.

Thanks,

Bart.

