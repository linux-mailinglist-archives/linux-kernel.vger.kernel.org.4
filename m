Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C0E60C12D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJYBlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiJYBk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:40:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9543A15B336
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:21:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so14717324pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LRvrfdB7zmhZ+11/1OF+yZjQrE3psIebH4Rs6IW8U5U=;
        b=jFEZOkqzQnXAvOLt1aoDE8WoO3aWaZ4sdpyKagS/dw0grBXvpDiViiyPWeRLwBGJPz
         4PfjdpD0cVEcMJUKBISct1RLX2bjNyUUWo3v8Hh+eHyW2VNnekLWMZYFX0cpAzu28WDc
         Omv+PtHH4WkZmUeBzDgDTToD8/vFV4LOgJW8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRvrfdB7zmhZ+11/1OF+yZjQrE3psIebH4Rs6IW8U5U=;
        b=l/hMYLqe9UbLmIZksRc4K5Olm9gIZl0zToFR57vJdIKsmFLYki7Dm/VuocCdMx6t0C
         LB1aQF4WPoIOu31maxNfJgrikAYOOJuoMpx5RsaoluhcnG6rPkjVDftPFNxQIq63Mmck
         wpysKfEh0hl918Ke7RLJP0lsITFiqYxepf4SSIsqsuSXq+o7XUrG50T9/TCtlFKUnJk+
         fDDGaZhDoi1ay6CqtjVhXt4hZlgFBYQ045VlqWw17GISTwc6fd13Mc252H9NNiRerftv
         7mm1Ugg9Y2ggdF6bLL1LsqAbjYZukM5CGdWwp596TfPR3dcco2KtcQkMY3xCnUjk2Kt1
         gr9g==
X-Gm-Message-State: ACrzQf3Fq5cGZ3+RIyFCeUBKx1uAJkEMaCZBvKZ+HzYvj/DRRBKB030q
        dy4awoi/OOQ0GRY1XHuhmFVQVQ==
X-Google-Smtp-Source: AMsMyM6JQUizHWRy50ZyNimKExpyj0NoIRw2W9lNzxDo9u+rGLsI9p85efdKHeqLWFeCuourO3+kjw==
X-Received: by 2002:a17:902:ccc4:b0:186:6fcb:3fcf with SMTP id z4-20020a170902ccc400b001866fcb3fcfmr23036976ple.100.1666660867062;
        Mon, 24 Oct 2022 18:21:07 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:c493:65a6:2d64:1325])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a508100b0020a9af6bb1asm444071pjh.32.2022.10.24.18.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 18:21:06 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:21:02 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Romanov <avromanov@sberdevices.ru>, minchan@kernel.org,
        senozhatsky@chromium.org, ngupta@vflare.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1] zram: add size class equals check into recompression
Message-ID: <Y1c5/mSBc+ctWH6v@google.com>
References: <20221024120942.13885-1-avromanov@sberdevices.ru>
 <20221024135909.e351a2dde4eea521f359a04b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024135909.e351a2dde4eea521f359a04b@linux-foundation.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/24 13:59), Andrew Morton wrote:
> > It makes no sense for us to recompress the object if it will
> > be in the same size class. We anyway don't get any memory gain.
> > But, at the same time, we get a CPU time overhead when inserting
> > this object into zspage and decompressing it afterwards.
> > 
> 
> Dumb question: is it ever possible for compression to result in an
> increase in size?

That's a good question. Re-compressed object can be bigger than the
original compressed one, but this should already be taken care of.
We do
        if (comp_len_next >= huge_class_size ||
            comp_len_next >= comp_len_prev ||

This checks whether recompressed object is above huge-size watermark and
whether recompressed size is larger than the original size.
