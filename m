Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68448720632
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbjFBPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjFBPaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:30:23 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33118C;
        Fri,  2 Jun 2023 08:30:22 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-64d57cd373fso2601142b3a.1;
        Fri, 02 Jun 2023 08:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685719822; x=1688311822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPKdSeegJ1AjrJW7LMNG9qtOmBvErTcO60Kp9uoBAUo=;
        b=B9ra3mj7DImeWz7UQ+7vlYszdhQQs67FppTsNnLFkwnf6zcN+f/+YYvcQEBbavjksc
         6C4V7ZL67thxgkK1CLQWaft5aLBIMLqkx1WEUDtfxZM5bK4dDr7Y6zT+TGq5j3EuicRK
         I84BVKgeCstctHErojGZ3hz3EGQ9YNVrgc34FK3Vo853KRAKiD2SnNr1MvXG9w8iKA14
         9wedDXR8YdEJgCfj1ciQZbZs9eihPJUeQmsQEGenrNl/fODUtePpaeMJebMwuI9P8Gab
         dABxyhqq1RWjgyZoiPYHp1LDGFvupZPW/BTMNPip2y7S8BrP5JuBtnOEc3Zdn985GuZH
         Ffnw==
X-Gm-Message-State: AC+VfDyrwkXynhhzH2a59n+gWyesSJblk2LgcY9igrFjbDIq2meFQF6I
        jv9zSfhg2hp2/JZ83suS8VY=
X-Google-Smtp-Source: ACHHUZ6t+PZGDb1tlOYRkSVMTfB+/8WJ1iwPlQA6V89bTxaoWefn2zm47DGjvtayj0rFawrAfWDGbA==
X-Received: by 2002:a17:902:e9d5:b0:1b0:56cf:b89d with SMTP id 21-20020a170902e9d500b001b056cfb89dmr152512plk.12.1685719821515;
        Fri, 02 Jun 2023 08:30:21 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902904500b001ae365072cfsm1508558plz.219.2023.06.02.08.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 08:30:21 -0700 (PDT)
Message-ID: <7b553268-69d3-913a-f9de-28f8d45bdb1e@acm.org>
Date:   Fri, 2 Jun 2023 08:30:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6] scsi: core: Wait until device is fully resumed before
 doing rescan
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     dlemoal@kernel.org, bblock@linux.ibm.com, acelan.kao@canonical.com,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230602084956.1299001-1-kai.heng.feng@canonical.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230602084956.1299001-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 01:49, Kai-Heng Feng wrote:
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index d217be323cc6..092f37464101 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1621,6 +1621,11 @@ void scsi_rescan_device(struct device *dev)
>   {
>   	struct scsi_device *sdev = to_scsi_device(dev);
>   
> +#ifdef CONFIG_PM_SLEEP
> +	if (dev->power.is_suspended)
> +		wait_for_completion(&dev->power.completion);
> +#endif
> +
>   	device_lock(dev);
>   
>   	scsi_attach_vpd(sdev);

Directly accessing dev->power.completion from the SCSI core seems like a 
layering violation to me. Isn't this an object that should only be 
accessed directly by the device driver power management core? 
Additionally, what guarantees that the desired power state has been 
reached after wait_for_completion(&dev->power.completion) has finished?

I think we need another solution. The device_lock() and device_unlock() 
calls have been introduced by commit e27829dc92e5 ("scsi: serialize 
->rescan against ->remove"). I think there are other ways to serialize
scsi_rescan_device() against scsi_remove_device(), e.g. via 
host->scan_mutex. Is this something that has been considered?

Thanks,

Bart.
