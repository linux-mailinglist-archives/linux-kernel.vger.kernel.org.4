Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EAA728491
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFHQFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjFHQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:05:35 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559E31AE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:05:33 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f829e958bdso6395581cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686240332; x=1688832332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlySnVLL7BDI4T2gMETXFiEvahuz34MfHsvLYgyHA4I=;
        b=zZTqje0AwcodgM6rBPvUVwnbvFvpBnQvSOHZVkLbseSSXxXubrgyxi6aYu216eBDyu
         9Ggd+ual0/SSTfxGdIBW0vngHvrU9t/bOFYgqyeJh7LuaTcocA63yu/xWlI5cyiDQqvV
         OdmO65l4swhJrDxtgqDqu4LtQGg3ps5e1esSx29JTC2zw06rFNNGwFCtuDtgDUY9TYFV
         xuCLM/ypwFyecW9YYUHNu+NbIMIpMRfyapdG2tvKjtirZrXCos4ZwAxtxoyr8ezJDTIk
         q/L1TSmmsHlCuNl5avE11E1nxP1xE5LJjHT0VBjAw47p4u1faCWS7YYOFoqZvMgSOFPa
         GDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686240332; x=1688832332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlySnVLL7BDI4T2gMETXFiEvahuz34MfHsvLYgyHA4I=;
        b=KR324SvITt612D7x4nZOw7pERobxWWZ3s3n9WwSWTo1anofNBWDdOveSMotNnQ0zkt
         +FcJzCgjQ/htrXcvfOzAoN1pSHEGHPxqSzjtSKWUKUgY24hB5K1e8I9rkF9WsqdMrr8B
         kIuqe3lp0OlRQxZg9W3+xZtvIvhrNT6l6UaiV137gqtquson6ej4vk4eIINx6BpduwIX
         s975yvphicWj/7nynXlJJpJA/06wOg7k6yCMjpslHyntc5hRxBp84YV0jwm3d4GJ3KCO
         KF/vvZ/0gPphhv9W/F3x68zAaw7fjD3nmMURabwN2I+V7cQhIP+HyPtPVjHANerntr3B
         5YnA==
X-Gm-Message-State: AC+VfDxsObs4oX+n/Tz6GsboNy/7sydvgrwT5Kl28BE23YdvnmarYoUw
        s4vf16dtp3xWG9UAuugCzCMneQ==
X-Google-Smtp-Source: ACHHUZ6V3RQRuXW5vNZf519RXC0gMfAE6lZ6fBaGM6N7iR1eBarImWPM9JtIBghkR9z1IhZKJOES5g==
X-Received: by 2002:a05:622a:490:b0:3f6:c1af:aa73 with SMTP id p16-20020a05622a049000b003f6c1afaa73mr8876318qtx.42.1686240332439;
        Thu, 08 Jun 2023 09:05:32 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id bw18-20020a05622a099200b003f9aecb599fsm451950qtb.35.2023.06.08.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:05:32 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:05:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 3/7] mm: zswap: remove page reclaim logic from
 z3fold
Message-ID: <20230608160531.GC352940@cmpxchg.org>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-4-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606145611.704392-4-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:56:07PM +0200, Domenico Cerasuolo wrote:
> With the recent enhancement to zswap enabling direct page writeback, the
> need for the shrink code in z3fold has become obsolete. As a result,
> this commit removes the page reclaim logic from z3fold entirely.

> @@ -1649,7 +1409,7 @@ static struct zpool_driver z3fold_zpool_driver = {
>  	.destroy =	z3fold_zpool_destroy,
>  	.malloc =	z3fold_zpool_malloc,
>  	.free =		z3fold_zpool_free,
> -	.shrink =	z3fold_zpool_shrink,
> +	.shrink =	NULL,
>  	.map =		z3fold_zpool_map,
>  	.unmap =	z3fold_zpool_unmap,
>  	.total_size =	z3fold_zpool_total_size,

Same two points of feedback on the changelog and the NULL as for
zbud. Otherwise,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
