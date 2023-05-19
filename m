Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DC70A2BF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjESWUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:20:43 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771481A8;
        Fri, 19 May 2023 15:20:42 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso1138608b3a.3;
        Fri, 19 May 2023 15:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684534842; x=1687126842;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/pMPPdx5W3ZOIDniRvAGehFY24LmkEefv16ppdwDAk=;
        b=lL4g/UmqI9+cpLn21C121OscbBah5fOe1TjfRzu9wOhlChZqNUUpE50gjTUhyx3Wa3
         4EHb3+wS8BYPCjMsacLfkhZRIdYSUZMYjiAGh6ZQsF4mRkOz4jOtfRVcwWEW3Sbu96HS
         1p4Y9jFVt9cwjZEX3uVwx7BC3WJ2YduxjS9qIAl8WtDi1BvBUEqF4O39utRILOSJ6J2T
         E5ZRYIlL7z80waLosd2pPRlRa3j1p70+eLcaZBrn7u9GDsKIB9bS4LpO7z+/7m5QYKoM
         l1TANpnWylz1A1zN9A/ROGejN4c65MjEEHn9A1nB9W8QVBwnIfaPKXaAWem+SpFODpUV
         LZxQ==
X-Gm-Message-State: AC+VfDyE1sAPAsHPebWz7iWQSgGB6nT25PDVWCg6/Tb5BUANgwKGaYWM
        QwOcmlMhvkv4r7VdEEvWIMI=
X-Google-Smtp-Source: ACHHUZ5Kyndb+J6vUB6H5cNzAfa4r427Q0gUzfKOltnnhsPQcJQnR2VFg3ol7hWrZj0mmZvV/+lHcQ==
X-Received: by 2002:a05:6a00:138a:b0:646:663a:9d60 with SMTP id t10-20020a056a00138a00b00646663a9d60mr5816438pfg.10.1684534841787;
        Fri, 19 May 2023 15:20:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id y26-20020a62b51a000000b006475f831838sm172249pfe.30.2023.05.19.15.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 15:20:41 -0700 (PDT)
Message-ID: <d6f2d05f-5dc2-3239-e4e6-299397a61ca0@acm.org>
Date:   Fri, 19 May 2023 15:20:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] ufs: poll pmc until another pa request is completed
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
References: <CGME20230516040117epcas2p4477bbc8aedf05a8c3bc0bd755eeadba0@epcas2p4.samsung.com>
 <1684209152-115304-1-git-send-email-kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1684209152-115304-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 20:52, Kiwoong Kim wrote:
> +		spin_lock_irqsave(hba->host->host_lock, flags);
> +		hba->active_uic_cmd = NULL;
> +		if (ufshcd_is_link_broken(hba)) {
> +			spin_unlock_irqrestore(hba->host->host_lock, flags);
> +			ret = -ENOLINK;
> +			goto out;
> +		}
> +		hba->uic_async_done = cnf;
> +		cmd->argument2 = 0;
> +		cmd->argument3 = mode;
> +		ret = __ufshcd_send_uic_cmd(hba, cmd, true);
> +		spin_unlock_irqrestore(hba->host->host_lock, flags);

Please consider adding 	lockdep_assert_held(&hba->uic_cmd_mutex) near
the start of __ufshcd_poll_uic_pwr() to document that this function is
serialized against other contexts that submit an UIC.

Additionally, I don't think that it is necessary to hold the host lock
around the ufshcd_is_link_broken() or __ufshcd_send_uic_cmd() calls.

Thanks,

Bart.


