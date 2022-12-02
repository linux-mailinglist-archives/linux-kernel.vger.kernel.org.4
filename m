Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A391640DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiLBSpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiLBSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:44:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B38E8E1C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:44:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C504B623A8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 18:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B5BC433C1;
        Fri,  2 Dec 2022 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670006648;
        bh=LAV340G9lS2wJ5F+zv4ZwstJo+e5Is3+lTA6FsoO2+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mONMPbzcyIQ9NsB3nRSKp1Gi4x+eOg/0OPKHdx1J3m8uMIP7QrYiVSXeLoCTrOHTJ
         uj4CErQLy7Ik0oT885vpjkFJVDz4MeACSgQFts9gYJDeQUHy9ZUeu0+gcdwhhjhsLp
         Pz8HP/5IEfcRH/zuL2Gih155/sFkcKzmFWqhxEf0=
Date:   Fri, 2 Dec 2022 10:44:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Rik van Riel <riel@surriel.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5%
 regression
Message-Id: <20221202104406.a0f85df9fdc33d0cfc6eb4a4@linux-foundation.org>
In-Reply-To: <f792d1d3-7181-8a17-5cf6-1ea13e84bb9b@leemhuis.info>
References: <202210181535.7144dd15-yujie.liu@intel.com>
        <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
        <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <366045a27a96e01d0526d63fd78d4f3c5d1f530b.camel@surriel.com>
        <Y1GCYXGtEVZbcv/5@dev-arch.thelio-3990X>
        <Y4RX+JZLddDHrLuQ@dev-arch.thelio-3990X>
        <e919e5a3-1118-043e-8bbd-5ee35f2ab411@leemhuis.info>
        <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
        <20221201132237.c55c4bd07ba44463b146882e@linux-foundation.org>
        <f792d1d3-7181-8a17-5cf6-1ea13e84bb9b@leemhuis.info>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 09:46:48 +0100 Thorsten Leemhuis <regressions@leemhuis.info> wrote:

> What beverage of choice do I have to offer you to make you in the future
> include 'Link:' tags linking to the report(s) when you add reverts like
> the one for this issue?

$10 supermarket pinot seems to be my tipple.

I can do that.  Any Reported-by: requires a Link:, OK?
