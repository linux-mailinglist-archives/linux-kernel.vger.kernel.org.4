Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F59717217
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjE3Xyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjE3Xyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:54:51 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A6B2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:54:49 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f805551a19so27550311cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685490889; x=1688082889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=egonHliL0X+PhNSvnZlUOZqOsOTQyugVPFh8DdfCZ20=;
        b=P4EcgYkCe3WPJDm6MXwEAxb4UbGk2nUKlRxx2Ey9gdMpYWDKI4iaSshcyPgqBLFlZZ
         YBcMPOvEEPwoCk20+ZTWluhBnn+mLQ37bYJbkhBVMRuOnCutXR/UsnQ92jAIfB14kFCI
         Q5Uh+VFAAYXsAXZaGXgTEB8UWEn8cla5NP1UzH0QFed+3e73Doz0E1bxcuEaN3zajiDS
         foX5baIQpGNJLosCWT/k+Tp6b+OVYrhiSHK+7/8FQELWMrOtwIAKMFk6RxX14H2gpL9X
         a1mNnivdxrbtAPD+yHlbpdJF6SBpNelg+i2oqPC1Bkn5byS+Yf2pxiikKKqNbaOqpV7g
         yzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685490889; x=1688082889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egonHliL0X+PhNSvnZlUOZqOsOTQyugVPFh8DdfCZ20=;
        b=TJuOcqDQs6JaGzqt/5zIdM1v3G/CpfZULDzZGVxZnIPTfS+TfXc7wdRM0UH8VaBHOy
         r73H305o0NgCbCCXUappwTUmEd2LHV+YPvMEVptA3PhZ9HBgh/lRPJrgFQ8K1FL570CZ
         byQxU/DhICde5WrhK6T10NHsZW4oeMZkARZCF+CrltRCExfxE4V1M3rrmVQ+VCvyEH59
         CM8OnPx7vQrRV+vdPfaYbGlESKLFqxmhNwZsw998M1aBpCR6cqPhur++ArhKX4rwr80o
         YJqMaFcA3Nr/K6KIH2/WHvcLWdFBioXEtHm4R+2o7aEXBCFQIH5oBEblRuDLemFlj/2x
         FiVQ==
X-Gm-Message-State: AC+VfDzBEFlIjiW/VBUQ9M0CroJzbyTwU8tTpJjruMFDTK1qfmihmb7l
        bMWnrMFL3G5qH/NSqYkz4iWq7Q==
X-Google-Smtp-Source: ACHHUZ49fFO7aKT0uDHqtFxnSbOV7EgxqJVMEueZvO1Uex0RJBiEL6n+MBPNRpenvsjbBwecqZI9lA==
X-Received: by 2002:a05:622a:199b:b0:3f6:ba82:f24d with SMTP id u27-20020a05622a199b00b003f6ba82f24dmr3841966qtc.31.1685490888795;
        Tue, 30 May 2023 16:54:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id k3-20020ac84783000000b003f7fd3ce69fsm5167965qtq.59.2023.05.30.16.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:54:48 -0700 (PDT)
Date:   Tue, 30 May 2023 19:54:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: support exclusive loads
Message-ID: <20230530235447.GB102494@cmpxchg.org>
References: <20230530210251.493194-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530210251.493194-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 09:02:51PM +0000, Yosry Ahmed wrote:
> @@ -216,8 +216,13 @@ int __frontswap_load(struct page *page)
>  
>  	/* Try loading from each implementation, until one succeeds. */
>  	ret = frontswap_ops->load(type, offset, page);
> -	if (ret == 0)
> +	if (ret == 0) {
>  		inc_frontswap_loads();
> +		if (frontswap_ops->exclusive_loads) {
> +			SetPageDirty(page);
> +			__frontswap_clear(sis, offset);
> +		}

Somewhat tangential, but is there still a point to the frontswap
layer? It seems usecases other than zswap have never materialized, at
least not in tree. Life would be a lot easier if we were to just
hardcode the zswap callbacks in the swap functions.

It's not the patch's fault, but it highlights the boiler plate the
indirection causes. ->load() already has the page and could just dirty
it directly. Instead now both layers have to handle invalidation,
which is a vector for bugs.

Can somebody think of reasons to keep it? If not, I'd take a stab at
removing it.
