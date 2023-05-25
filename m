Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8D0710507
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbjEYE5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbjEYE4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:56:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BE6E4D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 21:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CBB464298
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667ADC4339C;
        Thu, 25 May 2023 04:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990327;
        bh=y2L/IIIbUSQAirgDGHF3NbV/KKuT0WS9p4HR8mVBkSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ID5Orvp1ODegRGJbUG8c0Cm5CDTwM7ob6aTRO9UcmEw0rkVGLsEhVxexdPXfHu2n9
         0158iHwyq1xRryFlewp5ZX8pdUtnEmNCNasp+DgGR8u1kn937xGb1M1dOw0icJNHYq
         V8/Dvt3r0qCoUlo6k69kHda5aeKNj16ZKZ2e4uKI/jHk7osGCZyJ1vCql0L4O3j1UX
         adpecbYUzYfYrD5m/mz4081E21uUqpS/+y+etWfv9txsGYpw+oRtue5aJO8VBJli/I
         QxmWTrdvoAsEOF0dL82GgpbsgqlYI3hBrDQd5lEIdbOl4BZpO14UYXlE0r/u3uRmO/
         UUg4XZLJZnbyg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     jiangshanlai@gmail.com, Tejun Heo <tj@kernel.org>
Cc:     kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCHSET wq/for-6.5] workqueue: Ordered workqueue creation cleanup
Date:   Wed, 24 May 2023 21:54:45 -0700
Message-Id: <168499048181.3998961.3057649391948254093.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421025046.4008499-1-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 16:50:24 -1000, Tejun Heo wrote:
> When multiple work items are queued to a workqueue, their execution order
> doesn't match the queueing order. They may get executed in any order and
> simultaneously. When fully serialized execution - one by one in the queueing
> order - is needed, an ordered workqueue should be used which can be created
> with alloc_ordered_workqueue().
> 
> However, alloc_ordered_workqueue() was a later addition. Before it, an
> ordered workqueue could be obtained by creating an UNBOUND workqueue with
> @max_active==1. This originally was an implementation side-effect which was
> broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
> ordered"). Because there were users that depended on the ordered execution,
> 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> made workqueue allocation path to implicitly promote UNBOUND workqueues w/
> @max_active==1 to ordered workqueues.
> 
> [...]

Applied, thanks!

[14/22] soc: qcom: qmi: Use alloc_ordered_workqueue() to create ordered workqueues
        commit: 56310520308ab863030e9baa9a8f63bb31c94e27

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
