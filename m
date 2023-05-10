Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785E6FE6D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbjEJWBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEJWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:01:00 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DA11BC6;
        Wed, 10 May 2023 15:00:59 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1aaea3909d1so73616645ad.2;
        Wed, 10 May 2023 15:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683756059; x=1686348059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev0c8UkGcZy/QLlUdjHVUK5oJqUNTLHWrEFmmuvEiRo=;
        b=FNm1o2cp1wvHHC4Paeo50MMbiVOnXBVpYYiNZ1Zy2Q1rpzPnbZFFkX5u+6HIBvJDOy
         MlD1n4RMNCoQdtIuRIUN7mRWrEMbC9nUST3GbU2C9EKB8TTML/JSEm/7leLdwDNZrcrm
         jGfCYFrKiSBnxCX37Zbssqoo5zvxD15jFxRjk2ItagYqALWrR9IxgI+fboPjP2TNaOU1
         5Um/2vzTx6Iy4BWRP0Z5I/wDBMjlYUgCdIVWnK6FNXY2TWfqL9K15vRWBL/CPPJmcWUR
         BtU+BHe6JJvDC5eja7zW2AULRbBijSHDY5HheFCzovZ1mrO6nuYcchFs2ihtX9mG+2a0
         q88Q==
X-Gm-Message-State: AC+VfDyMmfb6UsvzZyb8xl4wcl/07ZwP1v3WThL9X2XfOduqUyIFUnUv
        0B2VHf6sUxVR3X6X7MbQdjI=
X-Google-Smtp-Source: ACHHUZ6NcdFmkAeWH5JJKD5SHe1GeFw5P0QJUpw40tqwtLkCcPEGenizNZt/gU/G0nvsHJHGeN9h7w==
X-Received: by 2002:a17:903:41d0:b0:1ac:4412:bd9 with SMTP id u16-20020a17090341d000b001ac44120bd9mr23684415ple.3.1683756058747;
        Wed, 10 May 2023 15:00:58 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:d8b7:fa5f:6808:3db3? ([2001:4958:15a0:30:d8b7:fa5f:6808:3db3])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902b40500b0019a6cce2060sm4276477plr.57.2023.05.10.15.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 15:00:58 -0700 (PDT)
Message-ID: <590cbc0e-51a5-5738-cb2e-7619adf2e4be@acm.org>
Date:   Wed, 10 May 2023 15:00:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/7] ufs: mcq: Add support for clean up mcq resources
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1683688692.git.quic_nguyenb@quicinc.com>
 <d8de00bab403dc725cf638750083d5e5f1449eec.1683688693.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d8de00bab403dc725cf638750083d5e5f1449eec.1683688693.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 22:24, Bao D. Nguyen wrote:
> +bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
> +{
> +	struct request *rq;
> +
> +	if (!cmd)
> +		return false;
> +
> +	rq = scsi_cmd_to_rq(cmd);
> +	if (!rq || !blk_mq_request_started(rq))
> +		return false;
> +
> +	return true;

The return value of scsi_cmd_to_rq() is never NULL so please remove the 
!rq test.

> @@ -7450,8 +7499,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>   
>   	ufshcd_hold(hba, false);
>   	reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
> -	/* If command is already aborted/completed, return FAILED. */
> -	if (!(test_bit(tag, &hba->outstanding_reqs))) {
> +	if (!is_mcq_enabled(hba) && !test_bit(tag, &hba->outstanding_reqs)) {
> +		/* If command is already aborted/completed, return FAILED. */
>   		dev_err(hba->dev,
>   			"%s: cmd at tag %d already completed, outstanding=0x%lx, doorbell=0x%x\n",
>   			__func__, tag, hba->outstanding_reqs, reg);

With the above change, the doorbell register is read even in MCQ mode. 
Shouldn't reading the doorbell register be skipped in MCQ mode?

Thanks,

Bart.
