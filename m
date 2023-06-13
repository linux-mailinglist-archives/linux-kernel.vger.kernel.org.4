Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5F72DC3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbjFMIVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241115AbjFMIVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:21:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3231D1701
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:21:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9745ba45cd1so794467466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686644476; x=1689236476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Pvx1ZmU24K4FZvRE8B1LH+FzXYUhn7Zlw9SxVgFETI=;
        b=WV9KwxgCmwycsJKEZ2A3MVrJnOyEcnrhenIiS1vCorQckKUZbgaHKgCZ7aeeMzogI+
         wHn1nD6eLRM9UUV/XH2vwtPs0ck9Hq6L0Z6GxZZK9h3eEBG+oUeQdYRO9rgYmvL3QAoU
         Z2E9ZR65YbMir/v5Tfy8o759WO6XSZMop80+Rr6gOpNLsO1sJ53OhUjZQ4LZmOVRsjXc
         51/PMpMXfp6UJvH09Glowk7+iFXfbr4obL7nBtrgee4Il6UZGqe4wxLxt2YGma2doHLU
         8AU7PMahB3SR//5174TShrk9tBKOqjXbxuUW0nFWQAObUIeM21zyUE9mWi+DT5VB0/et
         G+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644476; x=1689236476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Pvx1ZmU24K4FZvRE8B1LH+FzXYUhn7Zlw9SxVgFETI=;
        b=JfV0knCuP1Gs132QhE5NGgOrvEF99lyzTpfM/gXbVeHHwYogl6b7+cNa9Ztr8dRHCH
         CgcGCbpMHgVqyGuqeAhy+PCcvYhTS+8jk7R0Uwx+nxJURl3emEFVT0IElQ4/yLmxctFF
         FlJW6mHChlfxtpvbrZVmRjccJlKfHSkeuKZ+ChY/x3wdc32/IjuMzNUcmkdFHVPCj4j9
         Wi82mFcFCy1bh2cHBYQawP5oCSMMQg8GidA7V99NKW3zcfN6+EszA4s+GebvtkVeikfm
         QE+gdGuN2AOT6BUwYRZGs/nSIbpntpxr/BwCwrZOpY5i8QqrHFQVMBM+6ooUIX+ZCczu
         wofg==
X-Gm-Message-State: AC+VfDy7H7hiMFlXFzaDgf9jCGscuC3SIbE/DN+H+btzjR/0QGuBbDpu
        D2yjk2hKZ5ZMtANv3epueaIrFg==
X-Google-Smtp-Source: ACHHUZ5d/0b4pt5v1YwrkSYa0J18Ko73cwLj+3akehMf5jUxzvy6+qyhbgRNEvBhG9AFf0JQQLHfCw==
X-Received: by 2002:a17:907:7249:b0:978:6e73:e841 with SMTP id ds9-20020a170907724900b009786e73e841mr9590037ejc.35.1686644476434;
        Tue, 13 Jun 2023 01:21:16 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:802c:7f03:2fe0:bd27:d746])
        by smtp.gmail.com with ESMTPSA id g22-20020a17090613d600b009545230e682sm6329868ejc.91.2023.06.13.01.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:21:15 -0700 (PDT)
Date:   Tue, 13 Jun 2023 10:21:15 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8365: Fix inverted topclk operations
Message-ID: <20230613082115.c56ds3btkouetpu6@blmsp>
References: <20230511133226.913600-1-msp@baylibre.com>
 <4e4327afb0c71ae299e6aaaa3dffd4f9.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e4327afb0c71ae299e6aaaa3dffd4f9.sboyd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Jun 12, 2023 at 06:13:10PM -0700, Stephen Boyd wrote:
> Quoting Markus Schneider-Pargmann (2023-05-11 06:32:26)
> > The given operations are inverted for the wrong registers which makes
> > multiple of the mt8365 hardware units unusable. In my setup at least usb
> > did not work.
> > 
> > Fixed by swapping the operations with the inverted ones.
> > 
> > Reported-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> Checkpatch complains now that there isn't a Closes: tag here.

Alexandre reported this internally, so there is nothing I could point to
for a Closes tag.

> 
> > Fixes: 905b7430d3cc ("clk: mediatek: mt8365: Convert simple_gate to mtk_gate clocks")
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> 
> Applied to clk-fixes

Thank you.

Best,
Markus
