Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FFD6FF61F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbjEKPiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237708AbjEKPiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:38:07 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643674C38;
        Thu, 11 May 2023 08:38:06 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6439f186366so5435871b3a.2;
        Thu, 11 May 2023 08:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683819486; x=1686411486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZSuUDNZroiyxm8tSJ9/WgOQoub/MYxlf8xCitRpuzE=;
        b=E3cXAISAw9Bot++cvZ0EXW1inQ7B/pPWva41TqvasvmiaRY3nQTg70JGfGFkhbTCJU
         N9VFXdvDw3+M0nHQv8Ct+Vi8Yo20EcsEAnquARCSWAeTR10GPS1X6OjMpd+AtsdJ53N6
         VS/Wn/R2Q11gRh2ao5alul6MU1NDIw3LpQiqumjzZML55D/zKtQyIKZelktSOBndPYx8
         5ayZbzKtCWRMpgRlXUFbd6F1qaMimR6gRZdBEd4Ul4U1OBXljZeVLZjrvHJLgBcc/YaY
         Us36MTQ93BhG1zPDyD14okjZ0Z/zr68z07t+gw5Sp5HEQBEa/3VWShS+Pe+CkleUYTQx
         8n1A==
X-Gm-Message-State: AC+VfDw3x2sH7JXnskBzStiKoEDJv+H47UuflvFcnWd7VjM078zPTgsG
        k8ZOckdLtGGZcX1jIWpV8BWS66AvQJk=
X-Google-Smtp-Source: ACHHUZ4yVECYtD+qVm4EPWXQ7n+M0L0oJ8Y1QiJhaT60VoEzwjnc6YrVie/FMwn3rdeYFmeiM417FQ==
X-Received: by 2002:a05:6a00:14d0:b0:63d:2f13:1f3 with SMTP id w16-20020a056a0014d000b0063d2f1301f3mr29540905pfu.33.1683819485772;
        Thu, 11 May 2023 08:38:05 -0700 (PDT)
Received: from [172.20.11.151] ([173.214.130.133])
        by smtp.gmail.com with ESMTPSA id n1-20020aa78a41000000b0064550f76efesm5499494pfa.29.2023.05.11.08.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 08:38:05 -0700 (PDT)
Message-ID: <aa9af9ae-62a4-6469-244c-b5d9106bb044@acm.org>
Date:   Thu, 11 May 2023 08:38:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] ufs: don't use the fair tag sharings
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        naomi.chu@mediatek.com, wsd_upstream@mediatek.com
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
 <ZF0K7A6G2cYBjSgn@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZF0K7A6G2cYBjSgn@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 08:34, Christoph Hellwig wrote:
> On Tue, May 09, 2023 at 02:52:30PM +0800, Ed Tsai wrote:
>> The tags allocation is limited by the fair sharing algorithm. It hurts
>> the performance for UFS devices, because the queue depth of general I/O
>> is reduced by half once the UFS send a control command.
> 
> But it is there for a reason.  You completely fail to explain why you
> think your change is safe, and also why you did not try to even explain
> where the overhead is and how else you tried to mitigate it.

Hi Christoph,

For which devices is the fair sharing algorithm useful? As far as I know 
the legacy block layer did not have an equivalent of the fair sharing 
algorithm and I'm not aware of any complaints about the legacy block 
layer regarding to fairness. This is why I proposed in January to remove 
the fair sharing code entirely. See also 
https://lore.kernel.org/linux-block/20230103195337.158625-1-bvanassche@acm.org/.

Thanks,

Bart.
