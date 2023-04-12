Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8996DF193
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjDLKFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjDLKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063877A98
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98CF86329B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86473C4339B;
        Wed, 12 Apr 2023 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681293899;
        bh=oeHVXBgw/xh3zO+Pnydf9J/h2XOmECN7MIu3+GNG39Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBFqo8YoK03T36dsFTv0c8crR6XKvyEmC7Zy7yUk/pR0W3Aj690J83FeJl5xtOzxT
         4ymA1st86pkF1mvmWcENDVb5SuTrqPttM8b4NZf7Hvni9wesNNIsUESI/eVJadDMzq
         UUbXFMDNbafgVI2pNfNu3Ylud/NcRiKkGyPik/MBpSz5pHlDCRKaTdl9T64dxxo/Vt
         yH99WngCgxHZDrAqndV9njV5r2zHT7fVyQ/ScWCyT9H4Gu9Xb7fOaHf5Gce1LPvj9e
         F0iYnoc1sfivTAHf6fAx1JKXtt5ezSchEvqtbrDEOEcMvr27msch08aFaUpa1Uj+GP
         Q/8DsGMHwNQgw==
Date:   Wed, 12 Apr 2023 15:34:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND] soundwire: bus: Fix unbalanced pm_runtime_put()
 causing usage count underflow
Message-ID: <ZDaCRwU+WFqNo5iL@matsya>
References: <20230406134640.8582-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406134640.8582-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-04-23, 14:46, Richard Fitzgerald wrote:
> This reverts commit
> 443a98e649b4 ("soundwire: bus: use pm_runtime_resume_and_get()")
> 
> Change calls to pm_runtime_resume_and_get() back to pm_runtime_get_sync().
> This fixes a usage count underrun caused by doing a pm_runtime_put() even
> though pm_runtime_resume_and_get() returned an error.
> 
> The three affected functions ignore -EACCES error from trying to get
> pm_runtime, and carry on, including a put at the end of the function.
> But pm_runtime_resume_and_get() does not increment the usage count if it
> returns an error. So in the -EACCES case you must not call
> pm_runtime_put().
> 
> The documentation for pm_runtime_get_sync() says:
>  "Consider using pm_runtime_resume_and_get() ...  as this is likely to
>  result in cleaner code."
> 
> In this case I don't think it results in cleaner code because the
> pm_runtime_put() at the end of the function would have to be conditional on
> the return value from pm_runtime_resume_and_get() at the top of the
> function.
> 
> pm_runtime_get_sync() doesn't have this problem because it always
> increments the count, so always needs a put. The code can just flow through
> and do the pm_runtime_put() unconditionally.

Applied, thanks

-- 
~Vinod
