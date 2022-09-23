Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69E5E804D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiIWRDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiIWRDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:03:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D445E1280DA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 882C8B817BF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1168DC433C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:03:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YRRFc+Y1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663952605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpNbwnr41Jz+qm/MSd2bLabbvT8x6BkuQby5GkCJIvQ=;
        b=YRRFc+Y1C5bc/tNJuirosfv4o60IcRf7Z8NfB88BMLwSzVPXMNyUEf6tR2zrumRk9UN84S
        aBZ55dE7OZz0pAQWl9gVV1nKJR5/qoC4J8F4M8qUSjURCmf+S0iwqR5OblXyYatsGpFNO+
        aql6j4wQWiaWKK5SdhtO3frOgcK1mgY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d542c358 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 23 Sep 2022 17:03:25 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id j7so532714vsr.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:03:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf3OFD6aKUDimZ5dpbF1PR3PLq7NuAtN4J6xCKfYKoeLQ2kr7Sq+
        5MSIRsgnqYoWjh44Jt7PJ9dEByF1JqQnVbI3+P4=
X-Google-Smtp-Source: AMsMyM7dl3ufaa/9Eq2oIgZVdve1Nlfkzf2UvHu17kGBiltgzEkMjeSuxt+evuFSuCrwq5h9+0tdEE4Qyloc+/F2On8=
X-Received: by 2002:a67:e401:0:b0:398:89f1:492f with SMTP id
 d1-20020a67e401000000b0039889f1492fmr4255092vsf.21.1663952599078; Fri, 23 Sep
 2022 10:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220923122830.3941367-1-Jason@zx2c4.com> <20220923122830.3941367-2-Jason@zx2c4.com>
In-Reply-To: <20220923122830.3941367-2-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 23 Sep 2022 19:03:07 +0200
X-Gmail-Original-Message-ID: <CAHmME9rNK_N2FnkyTBTtUP6yvb-K21BaEnKeH43pFOitihaUUw@mail.gmail.com>
Message-ID: <CAHmME9rNK_N2FnkyTBTtUP6yvb-K21BaEnKeH43pFOitihaUUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] m68k: virt: generate new RNG seed on reboot
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 on its way now with the generalization thing.
