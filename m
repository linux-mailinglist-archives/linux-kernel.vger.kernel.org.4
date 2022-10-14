Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68AE5FF4FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJNVFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJNVFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:05:53 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB5A107A92;
        Fri, 14 Oct 2022 14:05:52 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id bh13so5351616pgb.4;
        Fri, 14 Oct 2022 14:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQdjRduw+CFfuvJK0CXPPLfls+7XGY4opgOLABTLuDY=;
        b=N/bCA79e8FA0V8BS2HvojrA1j5xcFqCWpuphJpq60oCly8DQIGE+8bByo62uElS4v3
         G+Acb9dpTnm7ofxdmgMxPEC7evFEq/82JqGooB/aorOO46P6r3MxXbdYRePlYwB17nFY
         bk+NR3L3gAKh65bkBPulk70Cj4a2vRtqW2zqayZ820CgkB4CcqfKD15g5szBFEzFgVEd
         g8LD9KKLub9emP5g5LKzzW4JBrAa5QigGnE4gODHkUZIC7kfN+8d0qJsDyjbvnfhEQ0x
         nMoqwmmUBYXXMH5AS7K5Y6nKgl2y6w4JRoiyFG5nDeN8u48oh0W7QsubFdx55NJ1dad3
         yxmA==
X-Gm-Message-State: ACrzQf1+JlXFtENjJVfrbeaxHjl2bfrwKRDhNQVeSKR+vTtzCHuyV7NK
        hpFJ/eN1EU9wfr4QUheGQeI=
X-Google-Smtp-Source: AMsMyM4bCuI6XCq5wMjR6w97z4hRTdbmvTdxI8s4u0hHxG0adRaa+vuv0oFv8QHIcxwxXCwZLQRPcA==
X-Received: by 2002:a63:e158:0:b0:464:8d6:8b91 with SMTP id h24-20020a63e158000000b0046408d68b91mr6064306pgk.124.1665781551376;
        Fri, 14 Oct 2022 14:05:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:7bd3:5500:b9cd:d90d? ([2620:15c:211:201:7bd3:5500:b9cd:d90d])
        by smtp.gmail.com with ESMTPSA id j5-20020a625505000000b00562019b961asm2152231pfb.188.2022.10.14.14.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 14:05:50 -0700 (PDT)
Message-ID: <925af9f5-b05b-1b61-c905-d19cdc54ce19@acm.org>
Date:   Fri, 14 Oct 2022 14:05:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/2] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010092937.520013-1-beanhuo@iokpp.de>
 <20221010092937.520013-3-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221010092937.520013-3-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 02:29, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Combine ufshcd_get_lu_power_on_wp_status() and ufshcd_set_queue_depth()
> into one single ufshcd_lu_init(), so that we only need to read the LUN
> descriptor once to replace the original twice.

The following part can probably be left out from the patch description 
without reducing clarity: " to replace the original twice".

> +/**
> + * ufshcd_lu_power_on_wp_init - Initialize LU's power on write protect state
> + * @hba: per-adapter instance
> + * @sdev: pointer to SCSI device
> + * @b_lu_write_protect: bLUWriteProtect value read from LU descriptor
> + */
> +static inline void ufshcd_lu_power_on_wp_init(struct ufs_hba *hba, const struct scsi_device *sdev,
> +					      u8 b_lu_write_protect)
> +{
> +	if (hba->dev_info.f_power_on_wp_en && !hba->dev_info.is_lu_power_on_wp &&
> +	    b_lu_write_protect == UFS_LU_POWER_ON_WP)
> +		hba->dev_info.is_lu_power_on_wp = true;
> +}

The body of this function is only three lines long and this function is 
only called once. Are you sure that you want a separate function instead 
of inlining this function in its only caller?

> +static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
> +{
> +	int ret;
> +	int len;
> +	u8 lun;
> +	u8 lun_qdepth;
> +	u8 *desc_buf;

Most kernel developers these days order local variable declarations from 
longest to shortest line ("reverse Christmas tree").

> +	lun_qdepth = hba->nutrs;
> +	lun = ufshcd_scsi_to_upiu_lun(sdev->lun);
> +	len = hba->desc_size[QUERY_DESC_IDN_UNIT];
> +
> +	desc_buf = kmalloc(len, GFP_KERNEL);
> +	if (!desc_buf)
> +		goto set_qdepth;
> +
> +	ret = ufshcd_read_unit_desc_param(hba, lun, 0, desc_buf, len);
> +	if (ret == -EOPNOTSUPP)
> +		/* If LU doesn't support unit descriptor, its queue depth is set to 1 */
> +		lun_qdepth = 1;
> +	else if (desc_buf[UNIT_DESC_PARAM_LU_Q_DEPTH])
> +		lun_qdepth = min_t(int, desc_buf[UNIT_DESC_PARAM_LU_Q_DEPTH], hba->nutrs);

ufshcd_read_unit_desc_param() can return fewer bytes than requested. How 
about modifying ufshcd_read_unit_desc_param() such that it returns the 
number of bytes that has been copied and using that return value above 
to check whether at least UNIT_DESC_PARAM_LU_Q_DEPTH bytes have been 
initialized in desc_buf?

> +	/*
> +	 * According to UFS device spec, The write protection mode is only supported by normal LU,
> +	 * not supported by WLUN.
> +	 */
> +	if (!ret && lun < hba->dev_info.max_lu_supported)
> +		ufshcd_lu_power_on_wp_init(hba, sdev, desc_buf[UNIT_DESC_PARAM_LU_WR_PROTECT]);

Please insert an if (ret < 0) check after the 
ufshcd_read_unit_desc_param() call and jump to the kfree() statement if 
ret < 0 instead of checking several times whether or not ret < 0.

Thanks,

Bart.
