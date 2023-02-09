Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3DA6912FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBIWMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIWMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:12:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097BF269B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:12:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9776161BD4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 22:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BACC433EF;
        Thu,  9 Feb 2023 22:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675980742;
        bh=1SXV6XW9O4X3wDnJTuB5NogsbuoDAfbWbnXHdZBOVvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1R6KZgwXLB89mnr+ZRjMcvgvzQGwmzC1JfWkvSLXnDhFQIqyGHkJyFvwoa91UyGqg
         YGJ+q3sw8ft8tNUpUZjHbUe8W7sHLOZCOry4GQA53b0NofqzTt8a7ODMp/6zrM5TEp
         W8JTC4S0lYccO5lWo2iGIIOPU8+6VJhmuYCQMd9c=
Date:   Thu, 9 Feb 2023 14:12:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>
Subject: Re: [PATCH 1/2] mm/MADV_COLLAPSE: set EAGAIN on unexpected page
 refcount
Message-Id: <20230209141221.b7881fb0783a58571f2bca53@linux-foundation.org>
In-Reply-To: <1f344fc1-834d-f1df-8a2c-79918be5b22@google.com>
References: <20230125015738.912924-1-zokeefe@google.com>
        <ecb2cf3-45f0-8aae-3e1-da4e79de9c27@google.com>
        <20230209132846.122ad88e1c2bd0603a630e5c@linux-foundation.org>
        <1f344fc1-834d-f1df-8a2c-79918be5b22@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 13:50:30 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> 
> > 
> > I'm not seeing anything in the [1/2] changelog which indicates that a
> > backport is needed.  IOW,
> 
> Correct: it's just changing the errno for some racy cases from "you're
> wrong, don't bother me again" to "it might be worth having another go":
> not fixing an instability, as 2/2 was.
> 
> > 
> > # cat .signature
> > When fixing a bug, please describe the end-user visible effects of that bug.
> 
> If whatever's being run by the end-user is coded to try again on -EAGAIN,
> then the end-user will less often see occasional unexplained failures.
> 

OK, thanks.  I redid the changelog's final paragraph thusly:

: In this situation, MADV_COLLAPSE returns -EINVAL when it should return
: -EAGAIN.  This could cause userspace to conclude that the syscall failed,
: when it in fact could succeed by retrying.


