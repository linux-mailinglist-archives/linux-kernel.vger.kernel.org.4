Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D7C6F9F6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjEHGIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjEHGIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:08:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E1613875
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:08:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so15569285e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683526123; x=1686118123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5W8da6wt3rFKDNRM++Yd7sVb4bFvYT4nuWMH2oQ4co=;
        b=jBR6qF+paUoajq7jJeR+ZgCasEddONzc0BUWQpueMWVKytDeu4W5EWSEdaQRz2wSOY
         P6VY9FsJrnCJKnonL7jC0+LHuGSg9tVdOSDbDcdWA1eTRlA8XzcYE+FTF/G+EWcbIOH4
         BND2bs51cgrvXQ3j3e4mvz/hHO3OJcpUQVURBC66enwKb51RCS9MlIrYQHe8O4wz02P8
         QN4T7B+MaYiubNr/2a991meohXKTqL/mc42L6RzkotLolNWL4J78wMOHjFhFg17S3X+Z
         06YJWdTl2AFz6fVs7lRMrLddSQ2Lu6zv5/MgSS+0JhCD+6xKl2nvMRWRAWhwRu0vB1r0
         E5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683526123; x=1686118123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5W8da6wt3rFKDNRM++Yd7sVb4bFvYT4nuWMH2oQ4co=;
        b=QKnMqC6FsfZZAoqlndx8gbMmPn9IVbRCWGEutfUnb8JdXxptkmvQ3kiqN4Y31aMYze
         Zl+wXI5sKGfB/bKuH8Q8ccRkvLQbagGcqFCDlcEqv1STBKLagdDpvmJwYxtlStDsomFY
         ZmYvw3fzGS4Uxv6HpT8MCM2Jdj6+d6FlJkHtosq5MYvFnodv3crBp60mAquXE2DR6f2B
         joI71netmoNPSfg4hisxqW6WDvSHqlVgGQg8L9HW0Y/hYOB+f4lIMy2tl4F9XDcmV1hl
         AmU6wAEFKSyLJWqtHm3N/XcjopCX910kxfdyQTU4+XTds7c9w+eTXvevlYY43JHZ7Z49
         UKfQ==
X-Gm-Message-State: AC+VfDwNDJWLREyG5SwlmN0YVTIIyiJz2q7dCk0Nk+8ZKfItA8gRlLls
        XOY4yOpP4Rv8yXnhXvcKtHaxs5q4dDlQ3yrVAe8=
X-Google-Smtp-Source: ACHHUZ7d4WSJg4vnVxhZk2Io2D+8Dv28X7WCTzCh8fFCvIe8DWFu20gWxeWwa+nR6a3Hwtx4diqXfA==
X-Received: by 2002:a7b:c4c3:0:b0:3f1:9526:22d4 with SMTP id g3-20020a7bc4c3000000b003f1952622d4mr6219983wmk.21.1683526122746;
        Sun, 07 May 2023 23:08:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bca50000000b003f1957ace1fsm15610474wml.13.2023.05.07.23.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 23:08:40 -0700 (PDT)
Date:   Mon, 8 May 2023 09:08:37 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mcf-edma: Use struct_size()
Message-ID: <9063649a-23a4-4c33-bdc4-f6f82fdef1e3@kili.mountain>
References: <97c2bb1c9b69d0739da3762a7752ae6582c4ad02.1683390112.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c2bb1c9b69d0739da3762a7752ae6582c4ad02.1683390112.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 06:22:06PM +0200, Christophe JAILLET wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more informative.
> 
> 'mcf_chan' is now unused and can be removed. In fact, it is shadowed by
> another variable in the 'for' loop below. Keep this one.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> It will also help scripts when __counted_by macro will be added.
> See [1].
> 
> [1]: https://lore.kernel.org/all/6453f739.170a0220.62695.7785@mx.google.com/

Of course, the main selling point of struct_size() for me is that it
protects you against integer overflows.  Open coding the math might end
up giving you a size which is smaller than expected but struct_size()
will give you ULONG_MAX in that same situation.  The allocation will
fail as expected.  #Safe.

Even when the open coded math is safe, this is easier to audit in an
automated way.

regards,
dan carpenter

