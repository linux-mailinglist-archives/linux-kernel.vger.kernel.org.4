Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACC728487
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjFHQC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjFHQCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:02:34 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056711984
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:02:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75d54faa03eso69447685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686240151; x=1688832151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XmeNd28q5yHmtNMDWyiOtbfHgBbeEmEURGIKSmo3fao=;
        b=4Err329amGe3/r1KRfph3RhHvzoY0MnuVR+qgGwAsXSKTNif3JYbQZ+WUSP0rk9ZFJ
         RsmfOKm3LfNWGSxgYyKZPcg4Brx0rkywvP49hGy+8YOJfED/l3/DBAW91mrnCdRA6ARO
         zw7/xN87kMHBfs7OutjXEEtFfMaFPiJ7aaPlMvs9OdtD1Irf3W1jwY6L/81/kR345lY2
         XSS+lA/VBovFuT09Z8S/wsstexqc6b4WMIUeUAOs1UXW6EX5z5Lzy6DtvIQRIMHpm/3u
         IbZW75l2Ah74BlfGxekqRydAowHLXzVCsNOUQojBqzFMtGrxVEz+1AR2+IUburOJCk1a
         kifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686240151; x=1688832151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmeNd28q5yHmtNMDWyiOtbfHgBbeEmEURGIKSmo3fao=;
        b=aqwq682QeloQZ+lZY8pGvLXI7OjarFaHkKDVTVVdZg+fTwXtp1aJ0KyMhd+iqP/TB6
         5iFmI27m4kZMWTYbAjvYxk6/gLUXoA2OBVDhyAMb2L2D2T58+lBUx5Sx3TgJtKGVsPs5
         A5ypUbyUAjMo1aY0YkRH/NGzHLqmsr5Uagizd0GwaF3Qo563/BQlxxI4+DXfHJjHFoy6
         gSS3K+pqdcXrKcdOULK4rN8qiLqfOiQa2WM7ci+k5V8TrLqQODbhxCbw3lpT29cipfiE
         y39pw3fZCERLzzYpqlBAKlEPkx4VMZlp58IESsOP3m74Y8cbhtxVduMr7hxziI8ZZUEu
         RfDg==
X-Gm-Message-State: AC+VfDzN6RUZ+T09GIEDUomE42bb0KAmokyTdJxmenQuER5n76wMe5oa
        jP9g8OwS/o/TKWlA+r5JeutXXw==
X-Google-Smtp-Source: ACHHUZ7XJNSgG1NVbM+XaXN7XC+P/oWfSYzdsJY/RsrgzEsNlY7Czuf4ys9lExvWsCi7Rkcuw/DIxw==
X-Received: by 2002:a05:620a:601c:b0:75b:23a0:debd with SMTP id dw28-20020a05620a601c00b0075b23a0debdmr6445125qkb.59.1686240151229;
        Thu, 08 Jun 2023 09:02:31 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id j26-20020a05620a001a00b007592af6fce6sm417471qki.43.2023.06.08.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:02:30 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:02:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 2/7] mm: zswap: remove page reclaim logic from zbud
Message-ID: <20230608160230.GB352940@cmpxchg.org>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-3-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606145611.704392-3-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Domenico,

On Tue, Jun 06, 2023 at 04:56:06PM +0200, Domenico Cerasuolo wrote:
> With the recent enhancement to zswap enabling direct page writeback, the
> need for the shrink code in zbud has become obsolete. As a result, this
> commit removes the page reclaim logic from zbud entirely.
> 
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

I find the changelog a bit difficult to understand. How about:

Switch zbud to the new generic zswap LRU and remove its custom
implementation.

> @@ -585,7 +425,7 @@ static struct zpool_driver zbud_zpool_driver = {
>  	.destroy =	zbud_zpool_destroy,
>  	.malloc =	zbud_zpool_malloc,
>  	.free =		zbud_zpool_free,
> -	.shrink =	zbud_zpool_shrink,
> +	.shrink =	NULL,
>  	.map =		zbud_zpool_map,
>  	.unmap =	zbud_zpool_unmap,
>  	.total_size =	zbud_zpool_total_size,

Like Minchan pointed out in the zsmalloc patch, you can just remove
the line as the member is NULL by default.

With that, please add:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
