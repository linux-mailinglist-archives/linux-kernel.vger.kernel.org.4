Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB1870A631
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 09:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjETHmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 03:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 03:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1097F1A4
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684568511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0AguDfj6JP2qnVVf1ZTLGQH6Es2HVgXZKNmzU3nM3g=;
        b=PZti+F83cztvMI1fURyVUN9mrHoGj9xRHnEKI7YvJcCKumUKB74DJdgmRsgkkqS3x9+9mi
        c1DenXj/UMWxyEKkZ0VWGzuxYoA6X1ppf2TTgs3sKjDkyKdi29KbRwu4xT4t8AK7rVPcaz
        UlnPYG6Gw8vy1HhN9eUWTrSr66w3xnc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-sWRzO65KNiCKTR21wQNcKw-1; Sat, 20 May 2023 03:41:49 -0400
X-MC-Unique: sWRzO65KNiCKTR21wQNcKw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-517c06c1a1bso2345573a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 00:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684568508; x=1687160508;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0AguDfj6JP2qnVVf1ZTLGQH6Es2HVgXZKNmzU3nM3g=;
        b=hfmEC30VHu3NaVRK6wnP7fraY7t45yDtZGXlqzDSc501ZM5iVggzyAvqKS81A/q0aK
         jTHoKFF4e9fv33cmbC5/z6NL/xBrmrYsh172IeD9Z6RdJVwEJoQ6Bb/gKqXaHN/5jQIx
         esqR4ZpFPtDeG/iEBbclFVDiZSd3Sd7BD3PArUNv6x/0Oxz/ChW6x70E67ddz33kVJ6N
         fkfuPU6ENLVQcLUu3aI57NrqDElArtS7D05vqtPoiTfotHCTpa3GH9xgKbm64scDo3Xu
         m8ExQnbkOa+nle+hN/5i3rLoHPNamxhRxyNl0WjcdFtZm9FY5Kq3z2+N28og8L75T3/h
         m3YA==
X-Gm-Message-State: AC+VfDzY16dSnmvzEwNg4nMKFgLevYvLLN6xZAhVT99VpJrCq+c45/iY
        RhkQAqyBpaFKIy80aqHFXXSVKmWACnNXsRil4f2ksZNpKgzHcdfhqRLMe4OLdK4TDta7hZbpGwV
        X2e2JM7ZiseqJ5FiSnAddqXqQ
X-Received: by 2002:a05:6a20:3d83:b0:104:beb4:da38 with SMTP id s3-20020a056a203d8300b00104beb4da38mr4804455pzi.35.1684568508554;
        Sat, 20 May 2023 00:41:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eXTRhEhp3x78rhFMpORaXutxEGfsp/UfsShsbpXjJZiG21s3ATningAfFDQyDpwJnRCAT3A==
X-Received: by 2002:a05:6a20:3d83:b0:104:beb4:da38 with SMTP id s3-20020a056a203d8300b00104beb4da38mr4804442pzi.35.1684568508246;
        Sat, 20 May 2023 00:41:48 -0700 (PDT)
Received: from [10.72.12.17] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79213000000b00639eae8816asm722737pfo.130.2023.05.20.00.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 May 2023 00:41:47 -0700 (PDT)
From:   Yanghang Luy <yanghliu@redhat.com>
X-Google-Original-From: Yanghang Luy <yanghliu@gapps.redhat.com>
Message-ID: <ce2e4e15-d4a5-fb48-1b2f-4f70c623b1b3@gapps.redhat.com>
Date:   Sat, 20 May 2023 15:41:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] vfio/pci: demote hiding ecap messages to debug level
Content-Language: en-US
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>, Bo Liu <liubo03@inspur.com>,
        "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>,
        kvm@vger.kernel.org
References: <20230504131654.24922-1-oleksandr@natalenko.name>
In-Reply-To: <20230504131654.24922-1-oleksandr@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: YangHang Liu <yanghliu@redhat.com>

On 5/4/2023 9:16 PM, Oleksandr Natalenko wrote:
> Seeing a burst of messages like this:
> 
>      vfio-pci 0000:98:00.0: vfio_ecap_init: hiding ecap 0x19@0x1d0
>      vfio-pci 0000:98:00.0: vfio_ecap_init: hiding ecap 0x25@0x200
>      vfio-pci 0000:98:00.0: vfio_ecap_init: hiding ecap 0x26@0x210
>      vfio-pci 0000:98:00.0: vfio_ecap_init: hiding ecap 0x27@0x250
>      vfio-pci 0000:98:00.1: vfio_ecap_init: hiding ecap 0x25@0x200
>      vfio-pci 0000:b1:00.0: vfio_ecap_init: hiding ecap 0x19@0x1d0
>      vfio-pci 0000:b1:00.0: vfio_ecap_init: hiding ecap 0x25@0x200
>      vfio-pci 0000:b1:00.0: vfio_ecap_init: hiding ecap 0x26@0x210
>      vfio-pci 0000:b1:00.0: vfio_ecap_init: hiding ecap 0x27@0x250
>      vfio-pci 0000:b1:00.1: vfio_ecap_init: hiding ecap 0x25@0x200
> 
> is of little to no value for an ordinary user.
> 
> Hence, use pci_dbg() instead of pci_info().
> 
> Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> ---
>   drivers/vfio/pci/vfio_pci_config.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 948cdd464f4e..dd8dda14e701 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1643,7 +1643,7 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
>   		}
>   
>   		if (!len) {
> -			pci_info(pdev, "%s: hiding ecap %#x@%#x\n",
> +			pci_dbg(pdev, "%s: hiding ecap %#x@%#x\n",
>   				 __func__, ecap, epos);
>   
>   			/* If not the first in the chain, we can skip over it */

