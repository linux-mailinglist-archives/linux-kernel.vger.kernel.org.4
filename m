Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1E96EF195
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbjDZJ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbjDZJ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:59:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1BC4EF2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:59:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b8b19901fso8449878b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682503153; x=1685095153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDQSmR3vhfuY5wD7//ZjiyUrNw8FfLpaCbF2hNAW7A8=;
        b=UChbCaTHDh1zDI2Mpv3WMMKP3U0l8VlU7gu+cMaGz9dE0Ei9Mqykvs0cihczEstdSy
         EY6QxBuqPazZbWYrtzpfOSF5gw03gCVV6SUCR5SM5PIv9prj07Lfh2/MJuzyE1gxj0Jt
         V6RS7HCRVD67MT55J4G4zun3lz2NZrFz1IslSwhqrUdrhonOzjGNrgZXTkrsMvh6fdT8
         6QufwBaCnR6dhFEiy1Om0maCKqoOtBjEF6zepJ87py6o5eIztsaoZl+dFdV64ZQjOOS/
         MeblJzB2WrcJjKLKK8vPB/3V9TltmzAL3ZCrtJHIoM7iYYmlDXH5Vi1Cx9FCFSvZY4qR
         j2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682503153; x=1685095153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RDQSmR3vhfuY5wD7//ZjiyUrNw8FfLpaCbF2hNAW7A8=;
        b=YPrceZVvG+DjvU6xQcnb95TVJNO2XFlenRLb6DdmxXqxLz1wji32vOBM/aHh0FoVAw
         azKjpuTLFGUFtr96CDr306Ax3dS52Do6T54JQMiH7gooW8UvYUE5JvpMTs7GAsg7XD9S
         rBfKLG3Mg9uNBBqJ8LNUECqc5m4kMoJHWB29LmTBAH/jp83G3KV+SpY9gE5zCyTr93IQ
         psNTDYWhpTGyriahCLdf/oGR2gJZO4UJO0U42VL1JIJhivQw9tsYWK7/4/mWxviYQsNy
         yayu/boSasLZoWGQHtLcD3u+qYyngRedVvFv39mNwppcNzOJrCJayQvNpk7t13Oc6vda
         UA2g==
X-Gm-Message-State: AAQBX9eFxI9Fa0vjqltHVrbLUVXU2Jdqw4GTBJgDEtO27wWbhQCxaLnG
        ExNskvg/zNa/4vG4QYWYYNhIrj7P1G1sXQ9RTOo=
X-Google-Smtp-Source: AKy350aeRUFwRFS/9eg5SLTEXt3NPabPbXCpA4JVj2iQdij4+Pb3jl8wR3w9lrqj7t3ZGlfVnpmgtg==
X-Received: by 2002:a05:6a00:23d6:b0:63d:2910:5c8b with SMTP id g22-20020a056a0023d600b0063d29105c8bmr27702193pfc.29.1682503153326;
        Wed, 26 Apr 2023 02:59:13 -0700 (PDT)
Received: from [10.200.11.252] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id c15-20020a624e0f000000b0063f534f0937sm5939078pfb.46.2023.04.26.02.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 02:59:13 -0700 (PDT)
Message-ID: <0201ec78-5b43-40e1-c1a0-4891f47206dc@bytedance.com>
Date:   Wed, 26 Apr 2023 17:59:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 20/34] maple_tree: Remove unnecessary check from
 mas_destroy()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-21-Liam.Howlett@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230425140955.3834476-21-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/25 22:09, Liam R. Howlett 写道:
> mas_destroy currently checks if mas->node is MAS_START prior to calling
> mas_start(), but this is unnecessary as mas_start() will do nothing if
> the node is anything but MAS_START.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>   lib/maple_tree.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 89e30462f8b62..35c6e12ca9482 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5817,9 +5817,7 @@ void mas_destroy(struct ma_state *mas)
>   	if (mas->mas_flags & MA_STATE_REBALANCE) {
>   		unsigned char end;
>   
> -		if (mas_is_start(mas))
> -			mas_start(mas);
> -
> +		mas_start(mas);
>   		mtree_range_walk(mas);
>   		end = mas_data_end(mas) + 1;
>   		if (end < mt_min_slot_count(mas->node) - 1)
