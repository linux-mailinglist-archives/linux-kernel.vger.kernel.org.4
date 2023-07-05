Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ECD748854
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjGEPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjGEPtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CD1728
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 910EF61601
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 15:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E63C433C7;
        Wed,  5 Jul 2023 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688572148;
        bh=wUQaHnYHUwnVipBpt2LgwmRDolTVE3ThEDGnTGR+Eds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fG4XT65n6cKnLJenjLqQmGWEBlAiyjkMKt0HSpYaUV5eR2EHSpIgV0SOmzYSapEc3
         7LXqOIeoCOXNXSWuuaxx3BN+jUfYb/G5r213KO5LsowSdYtl+rA0e7BctzdnCsKY+d
         btp/WMyfyUG/4qN91o+MTZq7O12MH+TLIfEZM4rE=
Date:   Wed, 5 Jul 2023 08:49:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        Suren Baghdasaryan <surenb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Fwd: Memory corruption in multithreaded user space program
 while calling fork
Message-Id: <20230705084906.22eee41e6e72da588fce5a48@linux-foundation.org>
In-Reply-To: <7668c45a-70b1-dc2f-d0f5-c0e76ec17145@leemhuis.info>
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
        <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info>
        <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
        <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
        <2023070359-evasive-regroup-f3b8@gregkh>
        <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
        <2023070453-plod-swipe-cfbf@gregkh>
        <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
        <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
        <2023070509-undertow-pulverize-5adc@gregkh>
        <7668c45a-70b1-dc2f-d0f5-c0e76ec17145@leemhuis.info>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 10:51:57 +0200 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:

> >>> I'm in wait-a-few-days-mode on this.  To see if we have a backportable
> >>> fix rather than disabling the feature in -stable.
> 
> Andrew, how long will you remain in "wait-a-few-days-mode"? Given what
> Greg said below and that we already had three reports I know of I'd
> prefer if we could fix this rather sooner than later in mainline --
> especially as Arch Linux and openSUSE Tumbleweed likely have switched to
> 6.4.y already or will do so soon.

I'll send today's 2-patch series to Linus today or tomorrow.
