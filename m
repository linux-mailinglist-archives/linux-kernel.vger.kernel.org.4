Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63E65F11A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiI3Scn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiI3Scj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:32:39 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3631B14D4;
        Fri, 30 Sep 2022 11:32:38 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id d1-20020a17090a6a4100b002095b319b9aso3959987pjm.0;
        Fri, 30 Sep 2022 11:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pGmxq8tDBSfiPNAIZ25qzZIB0dRZb2RCLRuZ0IccZag=;
        b=RHFqR+mFKMnhwJo60iqtqrqdeOp2oig7jwnCzyVCI/SLVIxC/MXDAjR0ycHQo3CJGP
         NHZEdAiMlXb701ldXKNljAlGyDDvg/CTn8ZCoW7c6EO3+GU+nRHEgdDb2cbiD27siwmh
         tSfRhhj7LNeQY0ypbGR/98VN/PWtBO2VyHWRUdD94nSz9WNd1NWmC4KH7F3G+BgkbIrL
         QYO40migr0/B4iDlrEKJDatnnKr8IeQMls25f2RksCAk/6luImp+QxBKXIuLbcYlY+K3
         Rf7WMIEJp2gh1OXo3U1aOOr4bJy/q7UJ1dKQlbhpf2893WmhyXTu4pYibLf0ScjYitgu
         csaA==
X-Gm-Message-State: ACrzQf2RNJdJbziD1QTj4XoFmL04jAW3O4AXC/H9Ip+l1FktVejx0I6y
        DlsegeR1ysfOwq+QRWRBPXo=
X-Google-Smtp-Source: AMsMyM6x9mzhkst02rDj+5NHQLQ9eMpWzm75K1RoD0MiFIcFrYfU9xdTvfahB327EwcQNCkFcvulvA==
X-Received: by 2002:a17:90b:1c8e:b0:205:783b:fe32 with SMTP id oo14-20020a17090b1c8e00b00205783bfe32mr24053856pjb.39.1664562757664;
        Fri, 30 Sep 2022 11:32:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:56f2:482f:20c2:1d35? ([2620:15c:211:201:56f2:482f:20c2:1d35])
        by smtp.gmail.com with ESMTPSA id w27-20020aa7955b000000b00535d3caa66fsm2106983pfq.197.2022.09.30.11.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 11:32:36 -0700 (PDT)
Message-ID: <4767355d-e7b0-d38b-88f3-c070ed0b5e5b@acm.org>
Date:   Fri, 30 Sep 2022 11:32:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 03/16] ufs: core: Defer adding host to scsi if mcq is
 supported
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, mani@kernel.org,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, quic_richardp@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        avri.altman@wdc.com, beanhuo@micron.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <197a8bcca288f9c36586099aa07606ed3f067c9b.1663894792.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <197a8bcca288f9c36586099aa07606ed3f067c9b.1663894792.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 18:05, Asutosh Das wrote:
> @@ -8218,6 +8219,14 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>   		ret = ufshcd_device_params_init(hba);
>   		if (ret)
>   			goto out;
> +
> +		if (is_mcq_supported(hba)) {
> +			ret = scsi_add_host(host, hba->dev);
> +			if (ret) {
> +				dev_err(hba->dev, "scsi_add_host failed\n");
> +				goto out;
> +			}
> +		}
>   	}

Calling scsi_add_host() from ufshcd_probe_hba() seems wrong to me since 
that function is not only called when probing a host controller but also 
when resetting a host controller. See also ufshcd_host_reset_and_restore().

>   
>   	ufshcd_tune_unipro_params(hba);
> @@ -9764,10 +9773,12 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>   		hba->is_irq_enabled = true;
>   	}
>   
> -	err = scsi_add_host(host, hba->dev);
> -	if (err) {
> -		dev_err(hba->dev, "scsi_add_host failed\n");
> -		goto out_disable;
> +	if (!is_mcq_supported(hba)) {
> +		err = scsi_add_host(host, hba->dev);
> +		if (err) {
> +			dev_err(hba->dev, "scsi_add_host failed\n");
> +			goto out_disable;
> +		}
>   	}
>   
>   	hba->tmf_tag_set = (struct blk_mq_tag_set) {

Please make sure there is only a single scsi_add_host() call in the UFS 
host controller driver.

Thanks,

Bart.
