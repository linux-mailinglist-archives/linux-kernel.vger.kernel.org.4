Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE572693A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjFGSxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjFGSxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:53:19 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9181BD2;
        Wed,  7 Jun 2023 11:53:18 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-25690e009c8so3329874a91.0;
        Wed, 07 Jun 2023 11:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686163998; x=1688755998;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6P+PAKNYbxbNX9E/3+E3k8i/1DJ/ZptAnSElYZPC90=;
        b=gMD9WBezapKm5Y0uzKdtaHj/aG76WXW7AObFIh6S8CNq7n6F/ZWuJw0RCG8hM9+rHL
         ErzfZiLkmcs/jnd64i0lUmukB7l5qYceVo6s6nDDGlpp1pWBwi6r+tJuqhlJvc97oxEb
         t8xRZbSfRpgd3cipyB4GsEFZf8959cx4c47WOYUJf2FgHRghK0zGmuSOinFQNHjzs+1X
         ZFdPOQycMx9kngRW6lzq9hKc/aii+v2HsJVTdzoogTh1uMc6DSZ2Jr/JdsN0BBn5EYtP
         eb/PETxfmXgFkzOFyr+o9Y1i8bMlsQGzJaklV0UVMa01WDflvc0nJ4ukJHHMbTSgKnji
         U2tA==
X-Gm-Message-State: AC+VfDy4PsH2kkIU2DhJ9sP+O6nlbkJXFYkz1CXEQXz2/k4/oWduNztd
        72oPXftVH2D1XWdWEhaX3sQ=
X-Google-Smtp-Source: ACHHUZ4tvgf/SYreGGwIqMKu8RQ+3loY5ft/f2mlHs/IZpTz9Nd8VNpsJCFYywsrM8L8QcBuHj31Ig==
X-Received: by 2002:a17:90a:49cc:b0:259:a879:cb8f with SMTP id l12-20020a17090a49cc00b00259a879cb8fmr2226855pjm.7.1686163998206;
        Wed, 07 Jun 2023 11:53:18 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id cm14-20020a17090afa0e00b00256799877ffsm1653239pjb.47.2023.06.07.11.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:53:17 -0700 (PDT)
Message-ID: <f4bb1b90-dda6-8be1-4388-f781bc2f1fc8@acm.org>
Date:   Wed, 7 Jun 2023 11:53:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ufs: core: Combine ufshcd_mq_poll_cqe functions
Content-Language: en-US
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
References: <20230601225048.12228-1-stanley.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230601225048.12228-1-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 15:50, Stanley Chu wrote:
> Currently, ufshcd_mcq_poll_cqe_nolock() is only called by
> ufshcd_mcq_poll_cqe_lock() with the addition of a spinlock wrapper
> for ufshcd_mcq_poll_cqe_nolock(). Combining these two functions
> into one would result in cleaner code.

For future patches, please use the imperative mood for the patch
description ("would result in" -> "results in"). Additionally, a
follow-up patch that renames ufshcd_mcq_poll_cqe_lock() into
ufshcd_mcq_poll_cqe() would be welcome. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
