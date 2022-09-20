Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3536B5BDBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiITE76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiITE7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:59:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952EB10FDD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 21:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34AAB61718
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A81EC433C1;
        Tue, 20 Sep 2022 04:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663649987;
        bh=FpIJC/kpLLJSxZQcRSkOGZmZ2DhuZdqOR+7vHg+6TEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkONBK34UTLVMql3fk8fYwpjG1UTHc/hOc6jIWjseGG6j0PaUIHl2RNrQMzAnH60m
         ZzuJVIFnnapjpVr+8zpF72QJDuxvLxXTSd13znEeZr7t/Qzw5oDOaUt8tRET2rA7Av
         BIc7m8NcZU0hv+mU1YGOQu2iNspkyVymuKvoTzHAK5BONwz69hzBzL1I6srgnFRsJ8
         GPsYZvegwiu/m6utEeVtWw2vDDLu4YqESUNxNJ7QW746R5+uetVZcK0wglk75pYPje
         uBIxIz3aHSC177DZF04BJZ1Lf3PZ+U7+nE80zdRzcmBuKkGZXyd8Q55+dP7eH++IiZ
         26iBut1jenZqg==
Date:   Tue, 20 Sep 2022 10:29:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v4 0/5] soundwire: Fixes for spurious and missing UNATTACH
Message-ID: <YylIv9VGYl3VqVIZ@matsya>
References: <20220914160248.1047627-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914160248.1047627-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-22, 17:02, Richard Fitzgerald wrote:
> The bus and cadence code has several bugs that cause UNATTACH notifications
> to either be sent spuriously or to be missed.
> 
> These can be seen occasionally with a single peripheral on the bus, but are
> much more frequent with multiple peripherals, where several peripherals
> could change state and report in consecutive PINGs.
> 
> The root of all of these bugs seems to be a code design flaw that assumed
> every PING status change would be handled separately. However, PINGs are
> handled by a workqueue function and there is no guarantee when that function
> will be scheduled to run or how much CPU time it will receive. PINGs will
> continue while the work function is handling a snapshot of a previous PING
> so the code must take account that (a) status could change during the
> work function and (b) there can be a backlog of changes before the IRQ work
> function runs again.

Applied, thanks

-- 
~Vinod
