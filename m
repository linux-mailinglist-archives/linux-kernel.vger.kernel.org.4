Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6833E67D07D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjAZPmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjAZPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:42:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201EB6C116
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:42:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A27BCB81E12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0271C433EF;
        Thu, 26 Jan 2023 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674747753;
        bh=LT/X1U1Lm3zVDWdfRgA//QxhMDSEePAzOF+jjRiMjik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoUU/ZIvlvv0/XTNotDzjSfInFoVtobKjl4c8RvfZ87i5nXa0cL4Uc9mUkII8WRKp
         x8hH2Vnz7uE+FEp/Uu8yjGV4Ib3ReYMcSH6bO9dz8y75cZukHxzxohw3peOo0Oc488
         XoXnOsHIKUrQ09GTI3FpNgRg7dA7TjSwXKT3Gb1G5UEoRLdLbWS/+MjTvb5rbjglyu
         T6QRxgPvZsiZo9gJxVPJ7Xpfw1XYojh2Vl7jcxRKwdS5+fKocx+b9rXwi0LXZ73iDl
         w9GCQUFzLG+SmsetAc4UiupUhruvBufkh69bUYK2MUPRI9F0TDHsscnqx/A2zTLFRD
         u21uX5LRKyklg==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com
Subject: Re: [PATCH] Partially revert "perf/arm-cmn: Optimise DTC counter accesses"
Date:   Thu, 26 Jan 2023 15:42:25 +0000
Message-Id: <167474133878.1608677.3170895609021328329.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b41bb4ed7283c3d8400ce5cf5e6ec94915e6750f.1674498637.git.robin.murphy@arm.com>
References: <b41bb4ed7283c3d8400ce5cf5e6ec94915e6750f.1674498637.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 18:30:38 +0000, Robin Murphy wrote:
> It turns out the optimisation implemented by commit 4f2c3872dde5 is
> totally broken, since all the places that consume hw->dtcs_used for
> events other than cycle count are still not expecting it to be sparsely
> populated, and fail to read all the relevant DTC counters correctly if
> so.
> 
> If implemented correctly, the optimisation potentially saves up to 3
> register reads per event update, which is reasonably significant for
> events targeting a single node, but still not worth a massive amount of
> additional code complexity overall. Getting it right within the current
> design looks a fair bit more involved than it was ever intended to be,
> so let's just make a functional revert which restores the old behaviour
> while still backporting easily.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] Partially revert "perf/arm-cmn: Optimise DTC counter accesses"
      https://git.kernel.org/arm64/c/a428eb4b99ab

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
