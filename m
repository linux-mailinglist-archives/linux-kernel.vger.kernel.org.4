Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0626A72C648
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjFLNqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjFLNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:46:22 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040AE102
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:46:21 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so31965245e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686577579; x=1689169579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otV7Rr6B+JZBSPxcoaD0JT8jIkvmj3/OZDYSAFQABGo=;
        b=L6S9pSsFtOAtiLPU9H2E91psntKdw3Q9+jnLEWWdVpZa42YceXy8ixbB5xhTQ+Dgt1
         Aj08hKGdgkffPZIeT1oX5niXmz3sNr3BHOAmpXFF6I53Vr7271U/33aKrP11SPfYNruH
         mjZlZyu1AFoB9pgC+dhWvOsoZiiLvWG+T8S1wY/TRb4f0Vuad7tnHbte7m1E9VBqDQ9c
         q+ZST0boesDCFlOeD49neW8xhGwad3DDSn7+q2cWoSLluudkD169LipfRmue2Gs7gx59
         /oiEXM7Z7/I1V79YqxFzJDbhphKFA6yMTr1Spn3tMrMsCLnM6rmCgR1yFiI0xdgi+oqk
         MeSg==
X-Gm-Message-State: AC+VfDwIm9J/r7f8EeI29uQSW8YCpIZtVivuz3eBYESNgavDuKS2UI0D
        k+xi481GKXjMzLAnt+lk478=
X-Google-Smtp-Source: ACHHUZ40ZnzYX38dZON5DZGAhec83RzGwwTkf5nYXOj/X+j/oivBUCocEpQfv+J3rwBCVyuqeA2I4w==
X-Received: by 2002:a05:600c:299:b0:3f6:444:b344 with SMTP id 25-20020a05600c029900b003f60444b344mr6084293wmk.34.1686577579108;
        Mon, 12 Jun 2023 06:46:19 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f819faff24sm4254387wml.40.2023.06.12.06.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:46:18 -0700 (PDT)
Date:   Mon, 12 Jun 2023 06:46:16 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <ZIchqLWousxkCqyB@gmail.com>
References: <20230203120615.1121272-1-leitao@debian.org>
 <87352z7xld.ffs@tglx>
 <ZIcVoIAQbRl1GTo5@gmail.com>
 <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 03:32:30PM +0200, Borislav Petkov wrote:
> On Mon, Jun 12, 2023 at 05:54:56AM -0700, Breno Leitao wrote:
> > 1) We keep consistency with other CONFIG options. Linux already has a
> > CONFIG option to enable/disable mitigations for speculations
> > (CONFIG_SPECULATION_MITIGATIONS), so, this will be a similar one.
> 
> So you can get what you want by disabling all those options there,
> right?

This patch proposes creating CONFIG_CPU_MITIGATIONS_DEFAULT_OFF that
will turn all the mitigations off in a binary, which is the same as
passing mitigations=off in the command line when the kernel boots.

Setting CONFIG_SPECULATION_MITIGATIONS=n does *not* disable all the
mitigations, as, there are some mitigations that are *not* disabled when
you pass CONFIG_SPECULATION_MITIGATIONS=n. As an example (from my
memory - need to double check in 6.4), MDS and TAA mitigations are not
disabled when CONFIG_SPECULATION_MITIGATIONS=n. MDS and TAA mitigations
are disabled when `mitigations=off` parameter is passed, tho.
