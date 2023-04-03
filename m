Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E96D457B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjDCNTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDCNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6504FD1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D7561A81
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6413CC433D2;
        Mon,  3 Apr 2023 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680527977;
        bh=4o73/wPEdsAvrP6wPplYlGDLvvEvn1MOkJ+0Wz1Agnc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qic7sMn5+sCf5CdVyrYy6HUaF8eXT2TSpc2oE4YxiaBK7G/QTB89sV7ISlkCiebMn
         9yVco1F5c+K/CAkJ/MnmuIntgjGR65uYidlbyUEARplfoSfvqZqrNR62vW/sCxUle6
         vtLDIXlxXYkEprPGX6mfKss8ljJWcBKsTEwBmnchknHZHl/ASm/KvelXZulk4s/GlA
         naVbT9+1RVIDVg/163ZdYGLgEX1wpGAeb3OaTIijsDRJngOJvJoTopRYy1ptLBKOer
         wwYJ3+gdwhy3pcyHhgTmDSwmP7xq8DJTZEhKZTn7Br+byILwiJCIVJG56hzPNCnhPR
         BB99t29ifntJw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pjK5q-005JVe-9L;
        Mon, 03 Apr 2023 14:19:30 +0100
MIME-Version: 1.0
Date:   Mon, 03 Apr 2023 14:19:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "zhangjianhua (E)" <chris.zjh@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Gowans, James" <jgowans@amazon.com>, zouyipeng@huawei.com,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
In-Reply-To: <1a974f41-83ec-9c7f-ddf1-cb093ae95046@huawei.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
 <f0879a30-6f88-30e0-ce30-e230df8f2936@huawei.com>
 <001d516c1bb6f0b6d2344f1ae160e796d003c24c.camel@amazon.com>
 <6d1859b0-20f3-05a8-d8d6-dfb0c9985985@huawei.com>
 <fd5588e5b0b1b5d21b1c0df7290844907ebcf367.camel@amazon.com>
 <871qlh9imb.ffs@tglx> <1a974f41-83ec-9c7f-ddf1-cb093ae95046@huawei.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <546fbd173aec3b7fc07d253393920bf5@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: chris.zjh@huawei.com, tglx@linutronix.de, jgowans@amazon.com, zouyipeng@huawei.com, karahmed@amazon.com, dwmw@amazon.co.uk, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-03 14:17, zhangjianhua (E) wrote:
> Hi Thomas
> 
> I have the same problem as James and Yipeng, while modify the irq 
> affinity
> 
> concurrently during LPI interrupt processing, it does cause interrupt 
> loss.
> 
> Fortunately, James and Yipeng give their patches separately with the 
> similar
> 
> solutions, and hope you'll take this issue seriously, thanks.

Neither solutions are remotely acceptable.

I'll look at something a bit more palatable.

         M.
-- 
Jazz is not dead. It just smells funny...
