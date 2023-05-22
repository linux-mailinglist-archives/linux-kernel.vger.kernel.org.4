Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E830F70C41C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjEVRTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjEVRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1524109
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B6AC61F11
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B724EC433D2;
        Mon, 22 May 2023 17:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684775935;
        bh=EJh81ERAwI1/1H4wTCD01XYRNVo9bAe3cDknyW2xH9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsPYkJrrb00WygdzSGGqtiVtGAn1oMi/G1qP3qQyRL+2G1KOu5RW4jt6IHOfm9i7N
         PrfqyAnCMp+22ZrwjcWXCJ1RFiY9t7uHVLT4C9f6Kz+IRe7v8w86HOIqsNMlYO1EZr
         k04m5zjmtCQ5d+a85q0mGNnSWNQ6SZY8/WxP2Qa4NkmjMT7gtTBsorVK2QYELM011e
         yH+Zrnn506u5EaEx2D2ORb2Cf7sSbPtJyClUkXYhMMjRtLw92ZOZZrqK1SV7psLc+V
         YCY9iVotoOM3+pKePw5DtzW3KCipseBTX4vzdQHMOTTXwWH8jBiRJbznwphiY4nqFi
         KRRt5+zB3YN3A==
From:   SeongJae Park <sj@kernel.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     sj@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, nmanthey@amazon.de, pabeni@redhat.com,
        ptyadav@amazon.de, willemb@google.com
Subject: Re: [PATCH net] net: fix skb leak in __skb_tstamp_tx()
Date:   Mon, 22 May 2023 17:18:53 +0000
Message-Id: <20230522171853.90173-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522170430.56198-1-kuniyu@amazon.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 10:04:30 -0700 Kuniyuki Iwashima <kuniyu@amazon.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> Date: Mon, 22 May 2023 16:55:05 +0000
> > Hi Pratyush,
> > 
> > On Mon, 22 May 2023 17:30:20 +0200 Pratyush Yadav <ptyadav@amazon.de> wrote:
> > 
> > > Commit 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs with
> > > TX timestamp.") added a call to skb_orphan_frags_rx() to fix leaks with
> > > zerocopy skbs. But it ended up adding a leak of its own. When
> > > skb_orphan_frags_rx() fails, the function just returns, leaking the skb
> > > it just cloned. Free it before returning.
> > > 
> > > This bug was discovered and resolved using Coverity Static Analysis
> > > Security Testing (SAST) by Synopsys, Inc.
> > > 
> > > Fixes: 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.")
> > 
> > Seems the commit has merged in several stable kernels.  Is the bug also
> > affecting those?  If so, would it be better to Cc stable@vger.kernel.org?
> 
> In netdev, we add 'net' in Subject for bugfix, then netdev maintainers
> send a pull request weekly, and stable maintainers backport the fixes to
> affected trees.
> 
> So we usually need not CC stable for netdev patches.

Thank you for the nice explanation!  Seems it is also well documented at
https://www.kernel.org/doc/html/v5.10/networking/netdev-FAQ.html#q-i-see-a-network-patch-and-i-think-it-should-be-backported-to-stable

However, I don't show the 'net' subject rule on the document.  Is it documented
somewhere else?


Thanks,
SJ

> 
> Thanks,
> Kuniyuki
> 
