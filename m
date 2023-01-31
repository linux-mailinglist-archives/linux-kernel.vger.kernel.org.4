Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6080E682585
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjAaH13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaH10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:27:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A2302AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:27:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B096E6136F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A220C433EF;
        Tue, 31 Jan 2023 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675150045;
        bh=/+z9RH4h0gpPcoPZBLaROC49eL3VvR3fCyK472WqbL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zSlxHep1Rvnwya56O4mLu37nMVy7xkgtMR2LJp+VUct98kiiyzXOYkVYCg8QZJpq1
         FxsIePbCBFY0QXyKDupjbCXBRCAu0+SmccSr+5BMqY+ZafgGJ8UYeTXjcQb6d3qE3U
         RF7cplsN0xJvBfbTl++GWZvql/vmO4zhSY6nt94s=
Date:   Tue, 31 Jan 2023 08:27:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, haibinzhang@tencent.com,
        hewenliang4@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5.10] arm64: fix a concurrency issue in
 emulation_proc_handler()
Message-ID: <Y9jC2msv2q39+ZA1@kroah.com>
References: <20230131065211.2826133-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131065211.2826133-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:52:11PM +0800, ruanjinjie wrote:
> This patch is addressing an issue in stable linux-5.10 only.
> 
> In linux-6.1, the related code is refactored in 124c49b1b("arm64:
> armv8_deprecated: rework deprected instruction handling") and
> this issue was incidentally fixed. However, the patch changes a lot and
> is not specific to this issue.

Then what about 5.15.y?  You can not upgrade to that kernel and have a
regression, right?

And nit, you need a ' ' before the '(' character.

But why can we just not take the original commit that fixed this issue?
That way almost always is the best (prevents regressions, makes
backports easier, is actually tested, etc.) ?

thanks,

greg k-h
