Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29BB6B017C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCHIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjCHIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:32:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A48B422F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:32:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 308B9B81BFA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCB3C433EF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678264309;
        bh=bwsi2TdpkHpxJa6HfxtQBXiZr4kcs7rH9Wii1RQdk/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DS0Tw88o35Hrz5pnq3qW6GB4DRSnT94yMZBzfyrq+BKuZ5pp6biNf6Xhv0oS6lfYv
         6hQKd/M/ImKbOlgZAchPcD6ycHBTTV9mnXuI7/YpTX0YTbJzPgKnxw4mixvHHa9n9C
         awfEwuyduwey3F7WMotvyof+HSiI78jOF0cw4SVJaD6uq83+Q/PQ3T5Y54LtDIqSkn
         OvlMDswmZrYL7YEro80XIAnHUGHqk6zp5xRf/ukq6ScwTDQso4KMEF/U8cAEo9wJYU
         Lq1Hk/S4jOQ7xuDoFjsZ7EMaVoaq5V4ew1Y5Y25hE1P2DpIWajrmf5NSDjKPN8Ostg
         EPD4hTygH+y5A==
Received: by mail-lj1-f171.google.com with SMTP id a32so15761492ljr.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:31:49 -0800 (PST)
X-Gm-Message-State: AO0yUKVhpNSnl6mn0r8QgGAghjXY1hgwqVCRiEleTKfRJLoe0oPntXgw
        qdjyShcmAWzFBkSVqIHsj8W+GPF06unKpjgYTBQ=
X-Google-Smtp-Source: AK7set/XrADghP9kqoeUGpbKwe/GJn4i6d6RvRf6EZaW8XNImePMHohaAv8GaM2Uc6ic74hVytwC4KmrIKcjnXbc8Zk=
X-Received: by 2002:a05:651c:11c6:b0:295:d460:5a2d with SMTP id
 z6-20020a05651c11c600b00295d4605a2dmr5260707ljo.2.1678264307882; Wed, 08 Mar
 2023 00:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20230307140522.2311461-1-ardb@kernel.org> <92fc6409-3fbe-f345-1806-02c3ea9ec520@arm.com>
In-Reply-To: <92fc6409-3fbe-f345-1806-02c3ea9ec520@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Mar 2023 09:31:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH_bNu7woOQ1458YEv0d9jodTL9B25B6zZvEn-9dTGZWg@mail.gmail.com>
Message-ID: <CAMj1kXH_bNu7woOQ1458YEv0d9jodTL9B25B6zZvEn-9dTGZWg@mail.gmail.com>
Subject: Re: [PATCH v3 00/60] arm64: Add support for LPA2 at stage1 and WXN
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 17:28, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> Hi Ard,
>
> Just to say that I plan to work my way through this lot over the next couple of
> weeks. I hope you can tolerate comments dribbling in as I go?
>

Yes, please take the time you need. I am confident we will still be
able to comfortably beat actual LPA2 hardware coming to market.
