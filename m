Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E58607E60
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJUSl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJUSly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:41:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779E245F63
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 11:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 300EFB82CFA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 18:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C3FC433D6;
        Fri, 21 Oct 2022 18:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666377710;
        bh=J25tCoTUjk8qI2my3h483nRH1yTzPJQzaDGzvBeN80c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OBVBymlS2oWG8CfVh+LJmkN3AgV9mNG0yarvnTFyigm5t2K6PlJwLlit1Mv/S+Mat
         R+uzyc+ok0k6dd7xLQEDxL20LaTELZzTWgQGv34DxIIbpLRQsrIUBTJkEdv7J/Y+M3
         cwujOZXPCou/gDWRgK/NrgJ1+FySv/Ckqf7z+sSo=
Date:   Fri, 21 Oct 2022 11:41:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     david@redhat.com, ying.huang@intel.com, ziy@nvidia.com,
        shy828301@gmail.com, apopple@nvidia.com,
        jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: migrate: Fix return value if all subpages of
 THPs are migrated successfully
Message-Id: <20221021114149.eadf6fafdd0b2c2409a46389@linux-foundation.org>
In-Reply-To: <fca6bb0bd48a0292a0ace2fadd0f44579a060cbb.1666335603.git.baolin.wang@linux.alibaba.com>
References: <fca6bb0bd48a0292a0ace2fadd0f44579a060cbb.1666335603.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 18:16:23 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> When THP migration, if THPs are split and all subpages are migrated successfully
> , the migrate_pages() will still return the number of THP that were not migrated.
> That will confuse the callers of migrate_pages(), for example, which will make
> the longterm pinning failed though all pages are migrated successfully.
> 
> Thus we should return 0 to indicate all pages are migrated in this case.
> 

This had me puzzled for a while.  I think this wording is clearer?

: During THP migration, if THPs are not migrated but they are split and all
: subpages are migrated successfully, migrate_pages() will still return the
: number of THP pages that were not migrated.  This will confuse the callers
: of migrate_pages().  For example, the longterm pinning will failed though
: all pages are migrated successfully.
:
: Thus we should return 0 to indicate that all pages are migrated in this
: case.

This is a fairly longstanding problem?  No Fixes: we can identify?

Did you consider the desirability of a -stable backport?

