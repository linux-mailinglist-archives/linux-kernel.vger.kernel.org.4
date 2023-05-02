Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B3C6F47C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjEBPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjEBPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46007E4D
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683042794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvI30K6rMw48L/vuYdVlLHdx9lMtZjuptjIrhFdSm2E=;
        b=NitvRE3ls1GFNPsnNt4h91hIns28Cxeug5HwGjAaaXiZTx0wSg1rkQsyk/nOC8KmqWH58H
        ZBdSCFVd/H8+QnWfU1OlOAdFnZ5Iy8IP1105XStuNPig2SW2nOXuCPfG3inQFyKS/v14SJ
        U4whOSReIrbwAHOUumYDQNDfny0X/+E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-lcuzpNFWOB2ZXebcpdgmKw-1; Tue, 02 May 2023 11:53:13 -0400
X-MC-Unique: lcuzpNFWOB2ZXebcpdgmKw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-50bd72cd04bso698259a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 08:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042792; x=1685634792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvI30K6rMw48L/vuYdVlLHdx9lMtZjuptjIrhFdSm2E=;
        b=Rs0PRjfB7p0bDEIyMyz6iSW7x7Spr0aQbj7/P0dfsX4oQzHcP1k5EpvlBTPlm8X8uK
         5g2mKm9b3QmLQhN5rIb2IbtdR9nzVEJHRH3Zb7TuYxOcDHuUvoI+j5DAWTRo4iO0/MJd
         yd6LRjN02linotpW9ZWMtDB/nZMUDUO45kcNBhTvAK3CB2o3iSZeiwTU5PNjNT6Cgq7T
         PcyKubsCaHaT6JaF6WCv+JQcFW/8Dd1D2LpJ83zbKOo+93U9SUPYx+0ladwG9ZX2uy6N
         iSeantiFBVvUF6TTXQMKEca5IWSEp77UbTQl1tmS+9iulHJaO2pceGiUNj4rGIxntcT+
         1dAw==
X-Gm-Message-State: AC+VfDwu/TJPjj6SNFFDdXXrxrJ1JT3FJhK/+DDNAxK1IPIKXmwe7dyQ
        nPuguLP5b8tyHnoYDJZq0HA00v4TxxzgTpS5SDgpoPZ3qj7rSB/1uBwwjLkVSzcVeBvLqdmOtGl
        5BkQI375kLahRItapivUFkpoA
X-Received: by 2002:aa7:cd16:0:b0:50b:cbcf:7d9a with SMTP id b22-20020aa7cd16000000b0050bcbcf7d9amr3850744edw.20.1683042792063;
        Tue, 02 May 2023 08:53:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72o/JwbIjdPsW9CjYjPjv6Gf80qvAecqyGbq5q/eeTy0wqoaeUgUIxkiN36AEqfkwIco65Qg==
X-Received: by 2002:aa7:cd16:0:b0:50b:cbcf:7d9a with SMTP id b22-20020aa7cd16000000b0050bcbcf7d9amr3850725edw.20.1683042791739;
        Tue, 02 May 2023 08:53:11 -0700 (PDT)
Received: from [192.168.0.107] (ip4-83-240-118-160.cust.nbox.cz. [83.240.118.160])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7d9d1000000b0050bd53f982fsm588713eds.92.2023.05.02.08.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 08:53:11 -0700 (PDT)
Message-ID: <6e69b57c-80ae-8b6e-cb5f-9e05da46ecd6@redhat.com>
Date:   Tue, 2 May 2023 17:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drivers: mpt3sas: mpt3sas_debugfs: return value check of
 `mpt3sas_debugfs_root`
To:     Jing Xu <U202112064@hust.edu.cn>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230423122535.31019-1-U202112064@hust.edu.cn>
Content-Language: en-US
From:   Tomas Henzl <thenzl@redhat.com>
In-Reply-To: <20230423122535.31019-1-U202112064@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/23 14:25, Jing Xu wrote:
> Smatch complains that:
> mpt3sas_init_debugfs() warn: 'mpt3sas_debugfs_root' is an error 
> pointer or valid
> 
> There is no need to check the return value of the debugfs_create_dir() 
> function, just delete the dead code.
> 
> Fixes: 2b01b293f359 ("scsi: mpt3sas: Capture IOC data for debugging purposes")
> Signed-off-by: Jing Xu <U202112064@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_debugfs.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
> index a6ab1db81167..c92e08c130b9 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
> @@ -99,8 +99,6 @@ static const struct file_operations mpt3sas_debugfs_iocdump_fops = {
>  void mpt3sas_init_debugfs(void)
>  {
>  	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
> -	if (!mpt3sas_debugfs_root)
> -		pr_info("mpt3sas: Cannot create debugfs root\n");
Hi Jing,
most drivers just ignore the return value but here the author wanted to
have the information logged.
Can you instead of removing the message modify the 'if' condition so it
suits the author's intention?
Also there are other similar issues in this file.

Regards,
Tomas


>  }
>  
>  /*

