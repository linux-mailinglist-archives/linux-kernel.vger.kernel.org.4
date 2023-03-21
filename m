Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA8C6C3C43
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCUUxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCUUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:53:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B3143924
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:53:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so64902406edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679432018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CVfLEQ96fgtEyGuwyUnqAP2WUVOUslh03bRQ3BEX7A=;
        b=X+dQPoexHev9KjgL10xzyZa8lLljP521vOdDiIPbrDJXqLx023ULI1d5wvOSvzW5dG
         lKrVdQPwUWxsmL3H2LpZniE39oi1IxA5k6WUfoS7BcCdQlKkp9W8nDN9FOKJl+58WptF
         Y7GvoMMAcM2QZ7J8DzphsEZ79mp6dTUYegEJlfqdFTjUw47QC67aYORmGt+Jri/1G9vC
         ebqPIP0t9MbUw0FFcQLur0WtvcTzj08V9vmmzMMN7AJMV4pbjPaIL9aAdDyazht6zeya
         FlhN3IwD3vfVFAuiJvZs5ylk5xqrKI7+hOkLWahazNezdPWt+4GA/ZDx/gEAmmHcVfMv
         zBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679432018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CVfLEQ96fgtEyGuwyUnqAP2WUVOUslh03bRQ3BEX7A=;
        b=j56yuDloVQZQxUEKNBs25WucFcQyfHagLRggdn0UViv1kL7obQIEYsoL4i5M/yTuIk
         kVsbeWCIn4+MZM8rZfBUIKdVgRheMRaKla6NrLw12D2SmHpMp2Nv+X9NcuiaU2qftSvy
         qdS8IbrgSz7p/NN26V5odLkj6OdPeIX+06nhGTWpHVKicC6qbFg2hBCuTnlUGxBTUJai
         JbEhX10WH//4UpVUK93HTyXV+k9k9WGRmMo/fagvx4PSzs6xVXAUNQYnFgaqBI7kiJgy
         uEyQOizt/BKPBU2fsDMKKYluSZofcRBrtRyxvd+Pff1sDdHhC/ugc+6pKWD3Db5bPV0t
         +f8Q==
X-Gm-Message-State: AO0yUKUbkxjvlEUyaz5+618WtuZPq6yRsP1Rk384P+GXAOCQSkALlDm4
        JR5vHwV+RYpByFJbXGNagaSGbQ==
X-Google-Smtp-Source: AK7set8buQSL7WJWvLOGJSlf5w169GupneinxCwEc4tmz07+4XkZBxidXr6kRDxDYk6EzYUBpK2bVg==
X-Received: by 2002:a17:907:6295:b0:932:f88c:c2ff with SMTP id nd21-20020a170907629500b00932f88cc2ffmr16101925ejc.34.1679432017823;
        Tue, 21 Mar 2023 13:53:37 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id u7-20020a170906b10700b0092f38a6d082sm6218757ejy.209.2023.03.21.13.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 13:53:36 -0700 (PDT)
Message-ID: <17185edd-aa6f-386b-4252-0c6eac1ddcfc@linaro.org>
Date:   Tue, 21 Mar 2023 20:53:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] misc: fastrpc: Reassign memory ownership only for
 remote heap
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bkumar@qti.qualcomm.com,
        fastrpc.upstream@qti.qualcomm.com, stable <stable@kernel.org>
References: <1679394100-27119-1-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1679394100-27119-1-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/2023 10:21, Ekansh Gupta wrote:
> The userspace map request for remote heap allocates CMA memory.
> The ownership of this memory needs to be reassigned to proper
> owners to allow access from the protection domain running on
> DSP. This reassigning of ownership is not correct if done for
> any other supported flags.
> 
> When any other flag is requested from userspace, fastrpc is
> trying to reassign the ownership of memory and this reassignment
> is getting skipped for remote heap request which is incorrect.
> Add proper flag check to reassign the memory only if remote heap
> is requested.
> 
> Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
> Cc: stable <stable@kernel.org>
> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

Thanks for fixing this,  without this fix the code inside if condition 
was a dead code.


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
> ---
>   drivers/misc/fastrpc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a701132..9b88132 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1892,7 +1892,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>   	req.vaddrout = rsp_msg.vaddr;
>   
>   	/* Add memory to static PD pool, protection thru hypervisor */
> -	if (req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
> +	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
>   		struct qcom_scm_vmperm perm;
>   
>   		perm.vmid = QCOM_SCM_VMID_HLOS;
