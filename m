Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B36FA11B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjEHHdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHHdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C84138
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 176F761236
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93C0C433D2;
        Mon,  8 May 2023 07:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683531213;
        bh=Ewso4HhzAJsqbCT6d20i437Q1SAxJH/VSuHeEApsxno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksQ/haKdEaXlVJf5aV4SAe7/h6YRzUWHQCOmPabBVhnPsYgPWDktr8vLtVV48Egem
         4N/QFzD9aUhobzl9LNc/vuuaRS62YMRs5epnu3teAICr7Up3NVXpKZxx2L27potgiZ
         Wg3tYcGgfte+jBAzGZwsHkxInQUbJUZjngdOn5h14yVWOg9TKsX+cI8YvopmOlakH0
         CmqtfQ+xEMvl2CsAQeXz4C45wXoAuO/ejo1jo3DhfToz5M0PPsTxn2zA1Mchuqb91q
         OeamyywMW7+YLJopIGyCSfqBnp/ZzP0JDMUYNpJpJzGGHr4Cu3tjqjbcxeCOGZMZNB
         s60WuEqbbPFaA==
Date:   Mon, 8 May 2023 13:03:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2] soundwire: bus: Don't filter slave alerts
Message-ID: <ZFilyckgWJlHiBiU@matsya>
References: <20230418140650.297279-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418140650.297279-1-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-23, 15:06, Charles Keepax wrote:
> It makes sense to have only a single point responsible for ensuring
> that all currently pending IRQs are handled. The current code in
> sdw_handle_slave_alerts confusingly splits this process in two.  This
> code will loop until the asserted IRQs are cleared but it will only
> handle IRQs that were already asserted when it was called. This
> means the caller must also loop (either manually, or through its IRQ
> mechanism) until the IRQs are all handled. It makes sense to either do
> all the looping in sdw_handle_slave_alerts or do no looping there and
> let the host controller repeatedly call it until things are handled.
> 
> There are realistically two sensible host controllers, those that
> will generate an IRQ when the alert status changes and those
> that will generate an IRQ continuously whilst the alert status
> is high. The current code will work fine for the second of those
> systems but not the first with out additional looping in the host
> controller.  Removing the code that filters out new IRQs whilst
> the handler is running enables both types of host controller to be
> supported and simplifies the code. The code will still only loop up to
> SDW_READ_INTR_CLEAR_RETRY times, so it shouldn't be possible for it to
> get completely stuck handling IRQs forever, and if you are generating
> IRQs faster than you can handle them you likely have bigger problems
> anyway.
> 
> This fixes an issue on the Cadence SoundWire IP, which only generates
> IRQs on an alert status change, where an alert which arrives whilst
> another alert is being handled will never be handled and will block
> all future alerts from being handled.

Applied, thanks

-- 
~Vinod
