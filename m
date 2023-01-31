Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DED682652
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjAaIZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjAaIZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:25:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521A93B0DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F44613B3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F9FC433D2;
        Tue, 31 Jan 2023 08:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675153554;
        bh=sQYpsRn0336Uppe33iacTmEelJCp6JM/JUY3m63RleI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1X/gulwL55O4a9HXBGFaKpziyp4d5PtbaSvQiypLOF23ESw41Du33mJIje4HTLXY
         QymXNMNl8NUlr4g+AdRkE9ASjKlgI2K48sxEC23L6PUNwawSIfBwQu+CDcvxcNdb7r
         i2toNqO4XqPA0QuV5OznSwGhJbBy3ppXQf0nPO1A=
Date:   Tue, 31 Jan 2023 09:25:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, haibinzhang@tencent.com,
        hewenliang4@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5.10] arm64: fix a concurrency issue in
 emulation_proc_handler()
Message-ID: <Y9jQj4tnDOOPNn92@kroah.com>
References: <20230131065211.2826133-1-ruanjinjie@huawei.com>
 <Y9jC2msv2q39+ZA1@kroah.com>
 <78883f84-dceb-9b24-b1f3-321d84091a85@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78883f84-dceb-9b24-b1f3-321d84091a85@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 04:23:19PM +0800, Ruan Jinjie wrote:
> 
> 
> On 2023/1/31 15:27, Greg KH wrote:
> > On Tue, Jan 31, 2023 at 02:52:11PM +0800, ruanjinjie wrote:
> >> This patch is addressing an issue in stable linux-5.10 only.
> >>
> >> In linux-6.1, the related code is refactored in 124c49b1b("arm64:
> >> armv8_deprecated: rework deprected instruction handling") and
> >> this issue was incidentally fixed. However, the patch changes a lot and
> >> is not specific to this issue.
> > 
> > Then what about 5.15.y?  You can not upgrade to that kernel and have a
> > regression, right?
> 
> This patch has a pre-dependency af483947d ("arm64: fix oops in
> concurrently setting insn_emulation sysctls"), which has not merged into
> branches except 5.10.y, so the other branches don't apply.

So there is no bug in 5.15.y?  That's confusing.

> > And nit, you need a ' ' before the '(' character.
> > 
> > But why can we just not take the original commit that fixed this issue?
> > That way almost always is the best (prevents regressions, makes
> > backports easier, is actually tested, etc.) ?
> 
> Thank you! It is ok to take the original commit to fix this issue.

Please submit it after testing.

thanks,

greg k-h
