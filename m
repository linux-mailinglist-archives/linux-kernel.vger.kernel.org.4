Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694217448AA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 13:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGALGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 07:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGALGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 07:06:09 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5416A3ABF
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 04:06:08 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3373211a1so2015546b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 04:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688209567; x=1690801567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gmmxI/09Vu1gvcqFW6wSCMsDrsU4gDstlNgv8XFwqYg=;
        b=hYrTCI7JxoaqJZg/w4gVpQgy48lZiuGWo+hifIVceh6qtqUdzsRTROEVXNPinlvfig
         BRpaenb+2Tadwnhn3gTkXC5r/x4rgdVPWBAD6PUjl+IHgWs/YMbNSXRJVIWYmfVrIb1I
         40cO21V4kRB8KA0ezJ5ZV+J4h/24JpkVQSWFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688209567; x=1690801567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmmxI/09Vu1gvcqFW6wSCMsDrsU4gDstlNgv8XFwqYg=;
        b=fyRIrMYNV99H5+QbQ2AMM+NgqAEhOVm4TIWDYw6QRkRAtbCtd48fG9bazt4t68WxcZ
         IE8fXbVYVXP4k/MmGifBUmfBSfb7Wm0oVPz8ImfgWA2Q2Q0EqH9heAFA+toxE0eL0mRo
         Gg67ySJMRGCf0B1yAB1sU88vryIyKYXaibCuWXvylL+5E/lR6hCJ3uOYAcd9iFSRvChd
         NVKGTIYXeadezIFLYEYn6TrFvpuYgQHBDmtC4xZK/gKrCIi7ZxTxvUkSPHKW0qWXYsx/
         HaGe5dkqC4mxjyjKzhfuICj65xHHfyC+GPIrFdzTs1QBOiPsiHx+cKYLlnMj8/rbyNl9
         1PlQ==
X-Gm-Message-State: AC+VfDztgY3y6QmSvc+x/RGVXsyfgo20NdKGQjF03iqvjIUsySvi5py0
        s6u6WE31Vn2r/T5OrRcNZn0jEA==
X-Google-Smtp-Source: ACHHUZ4pV0Kah8DCJV+Y5YyZlN9QSW79Br3FCQuTe5iDhfm7KMAOlTjyoF9hL2lHOGNGztkp1Rq3cA==
X-Received: by 2002:a05:6808:158d:b0:3a3:6e8e:5168 with SMTP id t13-20020a056808158d00b003a36e8e5168mr6106193oiw.39.1688209567625;
        Sat, 01 Jul 2023 04:06:07 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id g19-20020aa78193000000b0065dd1e7c2c1sm9025796pfi.63.2023.07.01.04.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 04:06:07 -0700 (PDT)
Date:   Sat, 1 Jul 2023 20:06:02 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/3] zsmalloc: remove zs_compact_control
Message-ID: <20230701110602.GB283328@google.com>
References: <20230624053120.643409-1-senozhatsky@chromium.org>
 <20230624053120.643409-4-senozhatsky@chromium.org>
 <ZJnHc8ynABmyI7sE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJnHc8ynABmyI7sE@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/26 10:14), Minchan Kim wrote:
> On Sat, Jun 24, 2023 at 02:12:16PM +0900, Sergey Senozhatsky wrote:
> > From: Minchan Kim <minchan@kernel.org>
> > 
> > __zs_compact always putback src_zspage into class list after
> > migrate_zspage. Thus, we don't need to keep last position of
> > src_zspage any more. Let's remove it.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
>  
>  Thanks for picking it up, Sergey!

Thank you for clearing up the code!
