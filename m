Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDB872B26E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjFKPTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFKPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:19:09 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0BA1B7;
        Sun, 11 Jun 2023 08:19:08 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-64d57cd373fso2338473b3a.1;
        Sun, 11 Jun 2023 08:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686496748; x=1689088748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFExSe/q0LX9tbRTk5+f74hTyWE8aqZzoVPz3pVv7x8=;
        b=IoyvU5Zepg9vuCrb5zBvVahiDLCumYMKuv4NKM9Ozk6QXshBxl8KkQk+9YYTqiJgC3
         9KY/5s0rRHWcabWwkZkiSk0g6vtSLUp6QlgoKG9rtZdgCqyDG5vTFCwpaLKOvA6rIaWR
         6zj4Gm4ZH6UDL3VPJm/HtK2CThKLuDXH80nwXnGyHmM6IPYb4kLa0ilIiZ748jS3pKDq
         c0Au7RI1li9bb+wRzeh1xZ4E5h9N5UJ9onx2PxcfD2hRCEOeRiIZP/bqfZi8D7sT4uKL
         82o7nNyOYPHJ5M5DbMy54GfNK9KtRZdCj2tLz16cm3BO9kwZ4+HUH8vSsFJ7OhDldAiU
         b+xQ==
X-Gm-Message-State: AC+VfDxSDzFKFWeoZ8B7iEOoCXg9ufvsmshumkIJ65qA4tkF2xb4oJsq
        KEn7ZTA8eBk0JkMhdW14KxE=
X-Google-Smtp-Source: ACHHUZ7KNYSZhwMlWKJmeQAkJJdQy5MnpaIoDREmYyWKxyurcmvq4aWYyvEgmfA7ztBRay/tydeflw==
X-Received: by 2002:a17:90a:4fe6:b0:259:30e7:733c with SMTP id q93-20020a17090a4fe600b0025930e7733cmr8032978pjh.21.1686496748220;
        Sun, 11 Jun 2023 08:19:08 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h13-20020a65518d000000b0053f5ff753e2sm5452666pgq.23.2023.06.11.08.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 08:19:07 -0700 (PDT)
Message-ID: <523bee5c-605f-ad6a-951a-2b9701362961@acm.org>
Date:   Sun, 11 Jun 2023 08:19:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] scsi: ufs: mcq: Fix the incorrect OCS value for
 the device command
Content-Language: en-US
To:     Stanley Chu <chu.stanley@gmail.com>
Cc:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
References: <20230610021553.1213-1-powen.kao@mediatek.com>
 <20230610021553.1213-2-powen.kao@mediatek.com>
 <0367b612-b6a5-8fb1-9cee-28de04b7ce81@acm.org>
 <CAGaU9a_D_KUstcQkPXsxepCdcvn3Knv-mzBh_kJDoYHwP-ndVQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAGaU9a_D_KUstcQkPXsxepCdcvn3Knv-mzBh_kJDoYHwP-ndVQ@mail.gmail.com>
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

On 6/11/23 07:49, Stanley Chu wrote:
> This patch removes the 'cqe' member from the struct ufs_dev_cmd, as
> shown in the code section below. Please let us know if anything else
> has been missed. Very appreciated.
> 
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 9b2d1859f885..602615e6d1bf 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -225,7 +225,6 @@ struct ufs_dev_cmd {
>          struct mutex lock;
>          struct completion *complete;
>          struct ufs_query query;
> -       struct cq_entry *cqe;
>   };

I misread the patch. Since the patch looks fine to me after having taken 
a second look:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

