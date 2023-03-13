Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB386B809F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjCMSbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjCMSao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C251481CC7;
        Mon, 13 Mar 2023 11:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A027A6147C;
        Mon, 13 Mar 2023 18:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3052C433D2;
        Mon, 13 Mar 2023 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678732164;
        bh=HmAKeBXDkOiHAU2wSF4/Jh6zy061K5i1NIQ79kIKwkc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=muxHcZnWWlGPmExVpjXqDWganm2Hi4r0WO8up1TSMUoX/DjkPTc4VOsoIMh8T9tSG
         5DiiwsGl38fzF3ipZ+yoh2HC+ZctPcw35fGOYDxuarCN6bmuhpwyYJcg5jxyER5Cd/
         KXRs4gwhPlO9AmgSviju9vdyBn+jVYzGfS8+zVxY=
Date:   Mon, 13 Mar 2023 11:29:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/sys.c: fix and improve control flow in
 __sys_setres[ug]id()
Message-Id: <20230313112923.340128142a92fe50140974db@linux-foundation.org>
In-Reply-To: <20230217162154.837549-1-omosnace@redhat.com>
References: <20230217162154.837549-1-omosnace@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2023 17:21:54 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:

> Linux Security Modules (LSMs) that implement the "capable" hook will
> usually emit an access denial message to the audit log whenever they
> "block" the current task from using the given capability based on their
> security policy.
> 
> The occurrence of a denial is used as an indication that the given task
> has attempted an operation that requires the given access permission, so
> the callers of functions that perform LSM permission checks must take
> care to avoid calling them too early (before it is decided if the
> permission is actually needed to perform the requested operation).
> 
> The __sys_setres[ug]id() functions violate this convention by first
> calling ns_capable_setid() and only then checking if the operation
> requires the capability or not. It means that any caller that has the
> capability granted by DAC (task's capability set) but not by MAC (LSMs)
> will generate a "denied" audit record, even if is doing an operation for
> which the capability is not required.
> 
> Fix this by reordering the checks such that ns_capable_setid() is
> checked last and -EPERM is returned immediately if it returns false.
> 
> While there, also do two small optimizations:
> * move the capability check before prepare_creds() and
> * bail out early in case of a no-op.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Looks and sounds good to me, so I queued it up for some testing.  I'd
ask that someone more familiar with this code perform review, please.

I assume that you believe that a -stable backport is desirable?  I'll
add a cc:stable to the patch for now.

