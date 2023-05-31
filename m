Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E49E717C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbjEaJkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjEaJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:40:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9178D9
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:40:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f60dfc6028so57834495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685526008; x=1688118008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrOxajovW5T4Rbc75jHs3zSIJj4eFv63SxzUYy8QEwU=;
        b=qUlVbwtJBWmIyaMOTjCP/Jml9WD6DnDXO4a8G5HdiF/aIRwSGT9KLO1PItVeboq7RW
         4se6h/UfuCnFxfNORMrQMgwKI56A2x/tV4LZ9HZQlos09T8x2x2GollQ8kkZsooJZS6Z
         JERGkcC87yHxF8AmnB2ONMaEXiBuKcMvi6Gh5MP8HfCFtFXuV49G+xaRg0GmyLsoZc0K
         QycT3N4DLTpkhqnuFESrGpxBiePWXdvPjnBgZ1njZslPsHu7ZJ1QFZstxHFLyc1/ZP4O
         GqoG+M/mM5pqDG8rNHzMit31d4DUyLje7OENUzOaQjra61WtsRZWt6e01Z51ugTx6S/q
         Koaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526008; x=1688118008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrOxajovW5T4Rbc75jHs3zSIJj4eFv63SxzUYy8QEwU=;
        b=DzV+OR6+HbIVS1/NzR0+cqySY51IrkxvWVXBAlRpFQRVhOwuR0qgqPcSYJXeSfYRgW
         QiPRAWApXbKzuGO0tRGnn5ajKXKN9XJfQ0dA90gfPzMBG1gdsQv/136z+9iiL26H5aoH
         hBhxrtGBbw780U/+vkUH1rHJUC2SbX/yunPeLPmErSDepq+BRRQqLq3HYheuC2MqD9+f
         Ynf/6FTqdrJYYj1ikyCmKZnpmpq9hcFJYayKsoiM5DT/30gWNCCxuDR9WC8lsgMuNQh4
         scqC9XYRQecS+aLjoZlkyFBti6zzrhl8G5jup2LF8g9yH10rIV2SeFHnjauWm3J9qept
         QKcA==
X-Gm-Message-State: AC+VfDyby9SaDi2mgW0fEIgAHlwTzZ5Qq1JD8Qn8xPvy+vqlIIrLRAWF
        uSBZBdMg/mvnjCDpxnHb78kmFg==
X-Google-Smtp-Source: ACHHUZ7QLmP32Ur33JMLykY91ywIOn9nnqyILXvyiJhEBzynYD4c3RWkXh/LJXNTMuCZPlJB3qhBvg==
X-Received: by 2002:adf:dd92:0:b0:30a:b46a:a443 with SMTP id x18-20020adfdd92000000b0030ab46aa443mr3268355wrl.51.1685526008093;
        Wed, 31 May 2023 02:40:08 -0700 (PDT)
Received: from [10.1.3.59] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b0030632833e74sm6170228wrs.11.2023.05.31.02.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 02:40:07 -0700 (PDT)
Message-ID: <af5df07e-f93f-9588-4fdb-b89b37aa28a1@baylibre.com>
Date:   Wed, 31 May 2023 11:40:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] blk-mq: check on cpu id when there is only one ctx
 mapping
Content-Language: en-US
To:     Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk
Cc:     kbusch@kernel.org, liusong@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        peter.wang@mediatek.com, stanley.chu@mediatek.com,
        powen.kao@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com
References: <20230531083828.8009-1-ed.tsai@mediatek.com>
 <20230531083828.8009-2-ed.tsai@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230531083828.8009-2-ed.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 10:38, Ed Tsai wrote:
> commit f168420 ("blk-mq: don't redirect completion for hctx withs only
> one ctx mapping") When nvme applies a 1:1 mapping of hctx and ctx, there
> will be no remote request.
> 
> But for ufs, the submission and completion queues could be asymmetric.
> (e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
> ctx won't complete request on the submission cpu. In this situation,
> this nr_ctx check could violate the QUEUE_FLAG_SAME_FORCE, as a result,
> check on cpu id when there is only one ctx mapping.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

