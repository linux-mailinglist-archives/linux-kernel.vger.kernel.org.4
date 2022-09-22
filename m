Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F115E6034
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiIVKw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiIVKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:52:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AEAD12CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B3B62C17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B825C433D6;
        Thu, 22 Sep 2022 10:52:52 +0000 (UTC)
Date:   Thu, 22 Sep 2022 11:52:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/1] arm64: defconfig: Add Coresight as module
Message-ID: <Yyw+gHXLG/fXoQbT@arm.com>
References: <20220921140535.152627-1-james.clark@arm.com>
 <Yyso42iP40niLTxO@arm.com>
 <adc70f4a-83f8-2bcc-87f1-28db004ae8e8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc70f4a-83f8-2bcc-87f1-28db004ae8e8@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:34:45AM +0100, James Clark wrote:
> On 21/09/2022 16:08, Catalin Marinas wrote:
> > 2. Always on CONFIG_PID_IN_CONTEXTIDR (we might as well remove the
> >    Kconfig entry). This would write the root pid namespace value
> >    (task_pid_nr()).
> 
> If we're not worried about the overhead after all, this would be the
> easiest solution. And then SPE or Coresight already decide whether they
> want to use the value or not, so no further changes are needed.
> 
> From Leo's patch there is a table that shows a 1% overhead with it
> enabled permanently, and I've heard a figure like that mentioned before.
> So I could also resurrect that patch to use static keys? Although it's a
> bit more complicated, that would be my preference. And then we can have
> that mode always on.

I don't think we should bother with static keys, just always enable it
but try to reduce/group the ISBs from all the functions called on the
__switch_to() path. We may actually get a speed-up.

-- 
Catalin
