Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6167E5F78B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJGNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJGNNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:13:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45931CBFF3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:13:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so4693752pjo.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx1A8VZz2C9MrIadfwpDwtJ95gIG5yP6liuo34oI2JU=;
        b=klfdocq1WkN/CJB6VFdoFVsNBhv2or+S6nkqOOeN+5/2YRV/U4XmlES4zvcZfA4a4k
         DvSgiVZMPhP979+YaFDhbOxrLiAFhYlF2L8NnPuocmimP0nMRALkcWwBhzo1N5sqEF50
         Sup7/NvbiGeRh97GYXxzXxN2VgBmdByVeugdayYBWYoMIa9h7x2S6oldfIlzx9seWajQ
         tXiekocjVamz9qFgCqeDele+fBqURG1PIZ7kWPLgLannPAIlsfqwP08nWsZCqCT91DDW
         XCmPtKGcJJMx/n1D89j15MOfGwDr/XkxuKuVLdN3OKFbekMEFTDbT3NEiOsj80xYEeZG
         i6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx1A8VZz2C9MrIadfwpDwtJ95gIG5yP6liuo34oI2JU=;
        b=AySDS5W/Wpj333hqN/WtzHl01xkEO2QVO/X+h7VjpQOhXMKiIEnoVB9PrFJkcCyTXl
         tF+zjl4ZphTbuxRwvI4GlBnqbVIotmv7Tkz7cXGDxFEPcdpFPbmiB/kDCvrcGF5By+00
         PnuB8E/UCc7LXsKGIxtCDx0Ghin+6LIaWEzda1bhl2qN+dvyybCio4fjaqlD+bqGPdBn
         aupddJfGIkJjD/V44NDLDa51rRTsRhaQ9a+bDZGzLj9tY4ZhvPqN1C1JyMp2UOuUkfNi
         zdWHYBdQNQg3T49J7yrSWt4/5Ezck34ENTsEFdUvbU5eGB84c64SMOqhAC4OJRiS0TZZ
         pGmQ==
X-Gm-Message-State: ACrzQf3MefQiNNhzZ0eGCiRSRBa8xBThMZOI9QFLqxRVbo7AjEfy3KhR
        efnE4OUwtAppUDhJ/XLKRV0nn8Z4Ejfl6Rz9oI7BzA==
X-Google-Smtp-Source: AMsMyM7tGKO3Q1AzhonCNeE4O6rxBaH/B+z+9vUkBMit50X+3vZ9txh4xN776AnHvV+41w+DJw5eWc/WdYcyjyZyq7U=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr16774732pjb.164.1665148393003; Fri, 07
 Oct 2022 06:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <08aac29e2d8545a6b56e092bc508409e@hyperstone.com>
In-Reply-To: <08aac29e2d8545a6b56e092bc508409e@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Oct 2022 15:12:36 +0200
Message-ID: <CAPDyKFqw2CNS+M5iMcP-_FyBThrUvGbyECMrEJheUD4YP7fwEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: queue: Flush recovery work on cleanup
To:     Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 at 15:39, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> To prevent any recovery work running after the queue cleanup flush it.
> Any recovery running post-cleanup dereferenced mq->card as NULL
> and was not meaningful to begin with.
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/queue.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index fefaa901b50f..a1b985d3dfda 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -493,6 +493,13 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>         if (blk_queue_quiesced(q))
>                 blk_mq_unquiesce_queue(q);
>
> +       /*
> +        * If the recovery completes the last (and only remaining) reques=
t in
> +        * the queue, and the card has been removed, we could end up here=
 with
> +        * the recovery not quite finished yet, so flush it.
> +        */
> +       flush_work(&mq->recovery_work);
> +

Not sure if it really matters in this case, but isn't
cancel_work_sync() the more proper thing to call instead?

>         blk_mq_free_tag_set(&mq->tag_set);
>
>         /*

Kind regards
Uffe
