Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0161697B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiKBQna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiKBQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:43:07 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8065B2;
        Wed,  2 Nov 2022 09:37:54 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x18so1022984qki.4;
        Wed, 02 Nov 2022 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZsM+OxUgZJot5MEYbtOs752pz+yn8WH7eG2LSoeX4o=;
        b=X6T+RoxGCUgBYwCi6521bxPlAnAiRh6EvyCfJgfqWn37WUjE3hNoaVYtB1JVNEspvK
         BCOIbpFyCe90k5YalZpAgqR1OnwqCm7fqnbTkPubm/P1kBxZidFdyeRsxiQ/2FbEzgFE
         3CAWd2fkPRv7+wI9OKT5YcwTREsnsnoFURde+Ugk4NfEYjZvti2s9sLX7vM7wc+6t7Jr
         mMp8SCz7veMtHy0CPedzIiaxj60Bb6CLzWwpqV3dh4TPJTAuPLgw4AGhVClC7VfAtAsF
         s9pAlXig6c8ONB9u3TWT32BkGza+vWY9rutTcLo5PagXt6VCr69/6R4Cd3nHV1kDe0hT
         Tklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZsM+OxUgZJot5MEYbtOs752pz+yn8WH7eG2LSoeX4o=;
        b=S6vWuI5Kt2cY/h9QdKQ/X6szw/ogC+KT3c3cRE0axtgbKU2OEOOvRlbnaCKxU5Jrwl
         6CO9gYawg0AA7iC//cuF/0jbwfi+EleWL0MCQHlMGpHdPk7A+LcHg81H8Bv3ug2iOB8p
         IB45+utPVd5msiFdDw3O1V9FX6b9Jqk7jmUXGQbUTckWDGQpuGNiUh0ZHLGZJ53sKHbm
         xgtUFvXYmTJw3cnX//ZfpAkOi4ShXA2rWry+jbmOGpdcq50BBYqVgEQQJIXSuhG9Jsnf
         Fp+uTMms6nK3ZV6F48PC4k3tDuRTN896E0ReuyBlWdzFxrSHVsiAt8RGF5AK1LY90NjI
         zGXw==
X-Gm-Message-State: ACrzQf0XUNZUDf1eHSFsLnExsKQAYSn6loBRlnP1yqu1ZfQeLxIq7zvZ
        mhafJVcvnkgg0X4bZ+/HRMs=
X-Google-Smtp-Source: AMsMyM6GXBlQ4yFw4vp0og+eNh/CoS08b0TOiY+mJpeskOwHDIo6MwZfUqqexkOncQddWy/lQgbuTg==
X-Received: by 2002:a05:620a:41d:b0:6fa:432f:2999 with SMTP id 29-20020a05620a041d00b006fa432f2999mr8809019qkp.157.1667407073356;
        Wed, 02 Nov 2022 09:37:53 -0700 (PDT)
Received: from [192.168.50.208] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id bq10-20020a05620a468a00b006ee77f1ecc3sm8806855qkb.31.2022.11.02.09.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 09:37:52 -0700 (PDT)
Message-ID: <0ce67c60-7b55-6f29-2f97-9b17c1e175c0@gmail.com>
Date:   Wed, 2 Nov 2022 09:37:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] scsi: lpfc: fix double free bug in
 lpfc_bsg_write_ebuf_set
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, james.smart@broadcom.com
Cc:     dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        hackerzheng666@gmail.com, alex000young@gmail.com,
        security@kernel.org, linux-kernel@vger.kernel.org,
        James Smart <jsmart2021@gmail.com>
References: <20221028050736.151185-1-zyytlz.wz@163.com>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20221028050736.151185-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2022 10:07 PM, Zheng Wang wrote:
> When error occurs, it frees dmabuf in both lpfc_bsg_write_ebuf_set
> and lpfc_bsg_issue_mbox.
> 
> Fix it by removing free code in lpfc_bsg_write_ebuf_set.
> 
> Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> Reported-by: Zhuorao Yang <alex000young@gmail.com>
> 
> Fixes: 7ad20aa9d39a ("[SCSI] lpfc 8.3.24: Extend BSG infrastructure and add link diagnostics")
> 
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>   drivers/scsi/lpfc/lpfc_bsg.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
> index ac0c7ccf2eae..7362d9c1a50b 100644
> --- a/drivers/scsi/lpfc/lpfc_bsg.c
> +++ b/drivers/scsi/lpfc/lpfc_bsg.c
> @@ -4439,15 +4439,13 @@ lpfc_bsg_write_ebuf_set(struct lpfc_hba *phba, struct bsg_job *job,
>   
>   		dd_data = kmalloc(sizeof(struct bsg_job_data), GFP_KERNEL);
>   		if (!dd_data) {
> -			rc = -ENOMEM;
> -			goto job_error;
> +			return -ENOMEM;
>   		}
>   
>   		/* mailbox command structure for base driver */
>   		pmboxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
>   		if (!pmboxq) {
> -			rc = -ENOMEM;
> -			goto job_error;
> +			return -ENOMEM;
>   		}
>   		memset(pmboxq, 0, sizeof(LPFC_MBOXQ_t));
>   		pbuf = (uint8_t *)phba->mbox_ext_buf_ctx.mbx_dmabuf->virt;

Minimally, just looking at this one snippet, by returning after the 
mempool_alloc() failure, we are leaking the dd_data memory just allocated.

> @@ -4480,8 +4478,7 @@ lpfc_bsg_write_ebuf_set(struct lpfc_hba *phba, struct bsg_job *job,
>   		lpfc_printf_log(phba, KERN_ERR, LOG_LIBDFC,
>   				"2970 Failed to issue SLI_CONFIG ext-buffer "
>   				"mailbox command, rc:x%x\n", rc);
> -		rc = -EPIPE;
> -		goto job_error;
> +		return -EPIPE;

and this leaks both the dd_data and pmboxq memory.

>   	}
>   
>   	/* wait for additional external buffers */
> @@ -4489,14 +4486,6 @@ lpfc_bsg_write_ebuf_set(struct lpfc_hba *phba, struct bsg_job *job,
>   	bsg_job_done(job, bsg_reply->result,
>   		       bsg_reply->reply_payload_rcv_len);
>   	return SLI_CONFIG_HANDLED;
> -
> -job_error:
> -	if (pmboxq)
> -		mempool_free(pmboxq, phba->mbox_mem_pool);
> -	lpfc_bsg_dma_page_free(phba, dmabuf);
> -	kfree(dd_data);
> -
> -	return rc;
>   }
>   
>   /**

all of these errors should cause:
   lpfc_bsg_write_ebuf_set() to return -Exxx
   causing lpfc_bsg_handle_sli_cfg_ebuf() to return -Exxx
   causing lpfc_bsg_handle_sli_cfg_ext() to return -Exxx
   which causes lpfc_bsg_issue_mbox() to jump to job_done

I understand the argument is that issue_mbox deletes them, but....

job_done:
   checks/frees pmboxq is allocated after the jump so it will be NULL
   frees dmabuf - which was allocated prior to the jump; is freed
      in freedlpfc_bsg_handle_sli_cfg_ebuf() but only in a block
      that returns SLI_CONFIG_HANDLED, which is not the block that
      invokes lpfc_bsg_write_ebuf_set. So it's valid to delete.
      Note: there's a special case for SLI_CONFIG_HANDLED which skips
      over these deletes so it's ok.
   frees dd_data - which is allocated after the jump so it too will
      be NULL

So - the code is fine.  The SLI_CONFIG_HANDLED is a little weird, but 
the logic is fine. If the patch were added it would leak memory.

I take it this was identified by some tool ?

-- james



