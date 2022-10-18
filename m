Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD92860326E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJRS1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJRS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:27:32 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FAC80BC0;
        Tue, 18 Oct 2022 11:27:29 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id 3so14917779pfw.4;
        Tue, 18 Oct 2022 11:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gTnDYN+v/DnI0QsKpXa/UtAUso84QgTliR3hhbiP+U=;
        b=GVz4twAc9DSQsaXr0zseJ2/rZGuktWxUluvHVUyyG2VOK4ee7s16gkstVb9eZbeE0s
         5KsOyvHf5blTGy1RVCozhGPwFdfM4+MOUc3kI1biusDZ5Hfm/yd8HacAF4z/C8Qi11eI
         GNYa9jVvFejV8pLEihAe+Y4X7ZhCccZMpt/xtn5NMNxe3cPZUab25QDLAgFCCYNANuLD
         GADTdHXi6CQDTLKHMruAA4TgRN+LcbSDHTFJb8b/L0Cnz5j7g4rw4mNE20WCPLfJYgVA
         BMXmKqUADKH3QHIEWHnOp/3Pz6Qv+d61231ynFxmVnJByoTOvulR1rxrb9dJM3OohK3b
         hHSA==
X-Gm-Message-State: ACrzQf2LebDdfJc0kashiQPSEiaDrWNROlAgPKUdxZI30R7OrhKSE8/O
        V+ypjfcRQzsAjqEh4LPsOK0=
X-Google-Smtp-Source: AMsMyM7JkzmG8pULqktRD7quRNIV212kjStg+eqb79LUMY1/+o+FdqhXlghGnhNlEYEby9J5P0dzPw==
X-Received: by 2002:a05:6a00:d72:b0:562:86e9:ae55 with SMTP id n50-20020a056a000d7200b0056286e9ae55mr4282340pfv.13.1666117648764;
        Tue, 18 Oct 2022 11:27:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:522b:67a3:58b:5d29? ([2620:15c:211:201:522b:67a3:58b:5d29])
        by smtp.gmail.com with ESMTPSA id r3-20020a17090a438300b0020ad53b5883sm8454334pjg.14.2022.10.18.11.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 11:27:28 -0700 (PDT)
Message-ID: <9868763a-d360-db53-02b9-2d7ab9628d79@acm.org>
Date:   Tue, 18 Oct 2022 11:27:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/3] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com, huobean@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221018181627.326657-1-beanhuo@iokpp.de>
 <20221018181627.326657-3-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221018181627.326657-3-beanhuo@iokpp.de>
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

On 10/18/22 11:16, Bean Huo wrote:
> +static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
> +{
> +	u8 lun_qdepth;
> +	u8 *desc_buf;
> +	int ret;
> +	int len;
> +	u8 lun;
> +
> +	lun_qdepth = hba->nutrs;
> +	lun = ufshcd_scsi_to_upiu_lun(sdev->lun);
> +	len = hba->desc_size[QUERY_DESC_IDN_UNIT];

Isn't the preferred style for kernel code to combine the above 
declarations and assignments (but not memory allocation calls)?

> +	desc_buf = kzalloc(len, GFP_KERNEL);
> +	if (!desc_buf)
> +		goto set_qdepth;
> +
> +	ret = ufshcd_read_unit_desc_param(hba, lun, 0, desc_buf, len);
> +	if (ret < 0) {
> +		if (ret == -EOPNOTSUPP)
> +			/* If LU doesn't support unit descriptor, its queue depth is set to 1 */
> +			lun_qdepth = 1;
> +		kfree(desc_buf);
> +		goto set_qdepth;
> +	}
> +
> +	if (desc_buf[UNIT_DESC_PARAM_LU_Q_DEPTH])
> +		/*
> +		 * In per-LU queueing architecture, bLUQueueDepth will not be 0, then we will
> +		 * use the smaller between UFSHCI CAP.NUTRS and UFS LU bLUQueueDepth
> +		 */
> +		lun_qdepth = min_t(int, desc_buf[UNIT_DESC_PARAM_LU_Q_DEPTH], hba->nutrs);

Should a test be added that verifies that UNIT_DESC_PARAM_LU_Q_DEPTH < len?

Additionally, please use braces ({}) around multi-line if-statement bodies.

> +	/*
> +	 * According to UFS device specification, the write protection mode is only supported by
> +	 * normal LU, not supported by WLUN.
> +	 */
> +	if (hba->dev_info.f_power_on_wp_en && lun < hba->dev_info.max_lu_supported &&
> +	    !hba->dev_info.is_lu_power_on_wp &&
> +	    desc_buf[UNIT_DESC_PARAM_LU_WR_PROTECT] == UFS_LU_POWER_ON_WP)
> +		hba->dev_info.is_lu_power_on_wp = true;

Also here, should the following test be added: 
UNIT_DESC_PARAM_LU_WR_PROTECT < len?

Otherwise this patch looks good to me.

Thanks,

Bart.
