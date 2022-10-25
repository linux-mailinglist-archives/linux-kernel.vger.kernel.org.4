Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B171260C940
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiJYKCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiJYKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:01:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A746D8EE4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:54:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f23so10725805plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=teEM4WgDVKhbrUFMtGCVBMDbqvHqgY/ntqbP9i/hjT8=;
        b=Uioy4OluxBsG3AlrKyPoOTXyTEdNdEI/m+s2juqb7M5C8GhA6sjbjvD4XlNKCsGuIh
         pjyKtrZgf/IVP57BjTs45r09pqECqC0lZTDdteRfUsmOi694KSjgiQ3cFko5PeMyoGDb
         LlDnPTWl13EO41Sp1wMEtL7lnDWoLX0JAJESg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teEM4WgDVKhbrUFMtGCVBMDbqvHqgY/ntqbP9i/hjT8=;
        b=HJLEQr/wsSDOabAnM9MAs40+PoY1mN/pt/RqHBkSN20jBBI7ckY+HiOANX+XOnmuJC
         FVjapNJx8R9ZnQ8vzPmm0gHxDGWKPSG65nXpmpVAe54MEalgCgdeOBh1vmzuFu9Cq5SW
         cr7XPLyeuuA3eMnUEvsam6qmvjCB6OzIMVv3s7orYuEvOQ7DJC688qB13IlGv0w/bPZ0
         pUedx2F8PMEXmWC9XZl2cyTLX+2hNfGHXf9/EDxtpkEgk6o5IAI0sdMPBV4NOVJvgy65
         xXJYfS4qVb5vkZslrMUPxz2jec8Plv/AvrITH+uOawcNcURigalW/s3Lqrwiw/x8PG+9
         H5Cg==
X-Gm-Message-State: ACrzQf0+1BCdBuXReoD26UWZ0ObbYabOg3AzgdUH0v+db3rX7+Kjh5Fn
        zNerbTmLI6eGN8Adg9voqoUH0A==
X-Google-Smtp-Source: AMsMyM6LJTBf2N336a4jB9U2ViJSzezbPqyz+S1w5TEUloejWTCAdBY7SPxrnjQ3WRLr+axAN1Oq+A==
X-Received: by 2002:a17:902:8642:b0:186:6740:dfd4 with SMTP id y2-20020a170902864200b001866740dfd4mr25966106plt.18.1666691669636;
        Tue, 25 Oct 2022 02:54:29 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:c493:65a6:2d64:1325])
        by smtp.gmail.com with ESMTPSA id w12-20020a63474c000000b0045dc85c4a5fsm964615pgk.44.2022.10.25.02.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:54:29 -0700 (PDT)
Date:   Tue, 25 Oct 2022 18:54:24 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Aleksey Romanov <AVRomanov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] zram: add size class equals check into recompression
Message-ID: <Y1eyUMP4VdeU9YVw@google.com>
References: <20221024120942.13885-1-avromanov@sberdevices.ru>
 <Y1dBpLDf+mRH6cLf@google.com>
 <Y1dEOLjD+kpdz0Vo@google.com>
 <20221025094859.7kbcqknlkmo4hj2y@cab-wsm-0029881.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025094859.7kbcqknlkmo4hj2y@cab-wsm-0029881.lan>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/25 09:49), Aleksey Romanov wrote:
> > Oh, apparently Andrew already has a fixup patch for this.
> 
> Hi! Thanks for the quick response.
> 
> Do I need to submit v2 with a fix for >=? Also, I forgot to 
> correct the comment on the zs_get_class_size() function:

I will cherry-pick you patch and send it to Andrew with my rebased
series that this patch conflicts with.

> > * Return: the size (in bytes) of the zsmalloc &size_class into which
> > * the object with specified size will be inserted.
> 
> ... or already inserted.

Will correct that.
