Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63C16A0895
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjBWM0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjBWM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:26:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9D9532B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:26:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D94BD616CC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABDEC433EF;
        Thu, 23 Feb 2023 12:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677155198;
        bh=dqlSVxQZeCY+YaNwcYKBewFsr2tm4s6bQA68OMlnzPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3/9vJXxfJa1SR+quJoOh5+BE39nMvrNHyQDhav7wt0ssK7n5kTCfWqwdeWoi/tNK
         wPIMQWiQlg0PepmBQv/cEPr/PWu4EppQolUIoQ9wXAu4CJtfsGaA7sZKV3MyVGv7EI
         8vbMZ+IoOZNSfijEhWjzEK/bX43YpSfqIwTf3KigJNreuJSwvyIeoyJywJM6fQoBSo
         IUMe8NY5HUjM+L8zau/a2y0x1L6aI60Ciciohk28tC+hK9eBjlVljt+Fj4WXYmWG/l
         4IwKPxcd1zK81t0FfLypW3PL0jj8YCiPO4DYQBmaKmQmypddYvZcsq8wW6ttuZZZrs
         EZRpoGf96a5kA==
Date:   Thu, 23 Feb 2023 13:26:31 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        linux-mm@kvack.org, p.raghav@samsung.com, dave@stgolabs.net,
        a.manzanares@samsung.com, yosryahmed@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 5/5] shmem: add support to ignore swap
Message-ID: <20230223122631.hwvhbqxadvbm23nb@wittgenstein>
References: <20230223024412.3522465-1-mcgrof@kernel.org>
 <20230223024412.3522465-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230223024412.3522465-6-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 06:44:12PM -0800, Luis Chamberlain wrote:
> In doing experimentations with shmem having the option to avoid swap
> becomes a useful mechanism. One of the *raves* about brd over shmem is
> you can avoid swap, but that's not really a good reason to use brd if
> we can instead use shmem. Using brd has its own good reasons to exist,
> but just because "tmpfs" doesn't let you do that is not a great reason
> to avoid it if we can easily add support for it.
> 
> I don't add support for reconfiguring incompatible options, but if
> we really wanted to we can add support for that.
> 
> To avoid swap we use mapping_set_unevictable() upon inode creation,
> and put a WARN_ON_ONCE() stop-gap on writepages() for reclaim.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

We would have use-cases for this in systemd. We currently use ramfs for
systemd's credential logic since ramfs is unswappable. It'd be very neat
if we could use tmpfs instead,

Acked-by: Christian Brauner <brauner@kernel.org>
