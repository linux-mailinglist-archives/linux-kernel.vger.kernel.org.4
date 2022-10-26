Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3775160D91A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 04:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiJZCP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 22:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJZCP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 22:15:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423629A9EC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 19:15:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q9-20020a17090a178900b00212fe7c6bbeso840318pja.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 19:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7l/phVh9ff32IB3giZcQ3ydhEdMONedR6Fn9Kqfzr3o=;
        b=bXgpMeMQ6ZAdE7l4TOCMLmc8fPSZwjZcspv322R1PC98EOACflsw9eXue0g3JDs28u
         P9jRSwKFkb3FVY4CE/eQwqn3ZhmORTHf4Z9jS7KUkN+2PD/ztSRCmnDJvEemDfNwkOJZ
         Cz7vA1WOZDB3aWwmYgFxsRFCvIdKgaAxHWryM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7l/phVh9ff32IB3giZcQ3ydhEdMONedR6Fn9Kqfzr3o=;
        b=LFlplw2YLiDT+HNYBDGcPekDA0UB20XfctwB7s2Bede+sxiEKjDOxEml8kKrgWf8dx
         gXJtqwoPbNo2wmFbhCSF5SIArxwYZUL56OhCPUVP4tLdCa6/zREQgSXS2koj4x8sa/Rp
         7BF+/IlmadjpAFK0xvy/ENr6ZdlHRwSQRCXbPpG5k+/FMxJH/9sgjjm0Mz+z4rYz7qG1
         MWmSRaVEA2hZcobjxlgLvxvSpGgRWXwyVFLIPoo3igD3pnG+jDhBRfxNzCu/SSD2hYyQ
         mkse88trc9YRZbnT3zPh46nvtxiXdrSBn6YjXxoay3ykHylUZeeEW393goqqesfH1GkD
         TmzQ==
X-Gm-Message-State: ACrzQf3d5gFqMwG/e9A2lHcfHx0kq3u8o9CDNpunX7mAzltXZa4M90He
        XyxrsNXtY+GoGP2+TRDMGurQFQ==
X-Google-Smtp-Source: AMsMyM5S+PyYqJHqsaEk1hSUH3dim2JfSpLMzCeK1LyhxosN+bxcFtw8cW0uU0zAv7y2F0yUwvA67Q==
X-Received: by 2002:a17:902:b717:b0:184:4a5c:c74a with SMTP id d23-20020a170902b71700b001844a5cc74amr42049886pls.0.1666750525648;
        Tue, 25 Oct 2022 19:15:25 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:faf6:e503:6cac:3b53])
        by smtp.gmail.com with ESMTPSA id a191-20020a621ac8000000b00561382a5a25sm2026197pfa.26.2022.10.25.19.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 19:15:24 -0700 (PDT)
Date:   Wed, 26 Oct 2022 11:15:20 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, ngupta@vflare.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2] zram: add size class equals check into recompression
Message-ID: <Y1iYOMuRDgUCV9Qp@google.com>
References: <20221025162638.7853-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025162638.7853-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/25 19:26), Alexey Romanov wrote:
> +/**
> + * zs_lookup_class_index() - Returns index of the zsmalloc &size_class
> + * that hold objects of the provided size.
> + * @pool: zsmalloc pool to use
> + * @size: object size
> + *
> + * Context: Any context.
> + *
> + * Return: the index of the zsmalloc &size_class that hold objects of the
> + * provided size.
> + */
> +unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size)
> +{
> +	struct size_class *class;
> +
> +	class = pool->size_class[get_size_class_index(pool, size)];
> +
> +	return class->index;
> +}
> +EXPORT_SYMBOL_GPL(zs_lookup_class_index);

I cherry-picked it with one tiny tweak: I want this to be ahead of
my series (break dependency on my series). So I removed pool parameter
from `get_size_class_index(pool, size)` in this patch and add it back
in my series (when I change get_size_class_index() prototype).
