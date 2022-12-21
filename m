Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF405652A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiLUAuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUAuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:50:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F2214020;
        Tue, 20 Dec 2022 16:50:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EB4CB81AC3;
        Wed, 21 Dec 2022 00:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55BFC433EF;
        Wed, 21 Dec 2022 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671583800;
        bh=UQfaCMmNKemVUDC7EJVOsBtsfVKMwNk1684fgHLkLl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9lU+Szrwvol+FSib7YYWiFxVvwz7C3RMHTQKHFEUDlF7Jv1kVwYIHw29dJP1xldZ
         qBaS1zsTuIQ1RE7XBRVHburjYI6La/xr7KBiMhs0faR0gsd+rGlhn/m/3ExA7vLT5x
         48Y9Jsv5osTCS0jrbQ1wiE8SdO2TIyeGSn7ucCgGQeAaeGcuDWUY4N5Je7X5Dhv7FS
         dmmnUmZRvI5fM4J/sCIdA5XZFtfg4DHvFnlR7N0ujT2PnAqwzlm06kVHIh4Xtwem1i
         l2g3PSvLW1Tnn7emFZcQinc+w0j69QbOBj4Uxsvyv+BjVMT3m7fNg+uU9plAkpIpAH
         OBEw2qRxs3vGw==
Date:   Wed, 21 Dec 2022 01:49:57 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221221004957.GA29021@lothringen>
References: <20221220140714.GB22763@lothringen>
 <CA83E649-8C79-4D39-9BFE-BBEF95968B98@joelfernandes.org>
 <20221220224459.GA25175@lothringen>
 <CAEXW_YSAv+MzZoW9RK9H3E6DAyZH+wB=4bMy5nXTOExSwgSwAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSAv+MzZoW9RK9H3E6DAyZH+wB=4bMy5nXTOExSwgSwAg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> Agreed about (1).
> 
> > _ In (2), E pairs with the address-dependency between idx and lock_count.
> 
> But that is not the only reason. If that was the only reason for (2),
> then there is an smp_mb() just before the next-scan post-flip before
> the lock counts are read.

The post-flip barrier makes sure the new idx is visible on the next READER's
turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
may appear unordered from the update side POV if there is no barrier between the
scan and the flip.

If you remove the smp_mb() from the litmus test I sent, things explode.
