Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A43745078
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGBTie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjGBTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4466EA7;
        Sun,  2 Jul 2023 12:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C353260C90;
        Sun,  2 Jul 2023 19:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EA7C433C8;
        Sun,  2 Jul 2023 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688326703;
        bh=GO/2m3o3QzugHX0ejwoldXMDJ2qiOEkWXVYlwf1J2Js=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w6JHpPK9XF1tAioPGht2AJY2ewjk+aGNR+1ach5+Rb5mnZylGDReR7cW7Pf7l43jJ
         i3DqCgHauO/2V3sNHvpwHpXYFXmvLhUD855uhAcwnN8JSH7cppS19ggVO0yTLcUDBW
         cWzKMaUR/wh0lnAN2Mi6M0yePyFlcLHIfO4VMrMU=
Date:   Sun, 2 Jul 2023 12:38:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>,
        Qun-wei Lin (=?UTF-8?Q?=E6=9E=97=E7=BE=A4=E5=B4=B4?=) 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        Chinwen Chang (=?UTF-8?Q?=E5=BC=B5=E9=8C=A6=E6=96=87?=) 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Kuan-Ying Lee ( =?UTF-8?Q?=E6=9D=8E=E5=86=A0=E7=A9=8E?=) 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li (=?UTF-8?Q?=E6=9D=8E=E4=B8=AD=E6=A6=AE?=) 
        <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm: Call arch_swap_restore() from do_swap_page()
Message-Id: <20230702123821.04e64ea2c04dd0fdc947bda3@linux-foundation.org>
In-Reply-To: <ZJ1VersqnJcMXMyi@arm.com>
References: <20230523004312.1807357-1-pcc@google.com>
        <20230523004312.1807357-2-pcc@google.com>
        <20230605140554.GC21212@willie-the-truck>
        <CAMn1gO4k=rg96GVsPW6Aaz12c7hS0TYcgVR7y38x7pUsbfwg5A@mail.gmail.com>
        <ZJ1VersqnJcMXMyi@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 10:57:14 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Andrew, what's your preference for this series? I'd like at least the
> first patch to go into 6.5 as a fix. The second patch seems to be fairly
> low risk and I'm happy for the third arm64 patch/cleanup to go in
> 6.5-rc1 (but it depends on the second patch). If you prefer, I can pick
> them up and send a pull request to Linus next week before -rc1.
> Otherwise you (or I) can queue the first patch and leave the other two
> for 6.6.

Thanks.  I queued [1/3] for 6.5-rcX with a cc:stable.  And I queued
[2/3] and [3/3] for 6.6-rc1.

If you wish to grab any/all of these then please do so - Stephen
will tell us of the duplicate and I'll drop the mm-git copy.
