Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A0874305B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjF2WWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2WWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:22:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EAA30F1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v2HOXN/dFzSq+BbK3zWw9kYyIXCnd6hSDikcfU87RyM=; b=AnyuLJ636jsNN4XpDq8IvYL4+x
        OJsuDYS3ppbJCvM2+I+iY0edrYjoeUMng3zVkMIZeA0OoN/i78ehT16n+SIgDLiIXDGFwt3NclplX
        n8zdmBFlPrKq7NOgVKW0SZr9bLOMdNzSECGZRYXErlnBNu/10h3VGLz1446YoQoA+23Tq4xyDMFmC
        yOlb2NR0CqhLUwvRtTGbyVSNtdRYyOgpQWqCsOrHpefGCU6MdY4dte7GiXGztUOIjj0B408xKX0uD
        qvx43aP/+82jOay7lW/fsEa/D5qjX0pX+9Vyni25Tx8hRRXWPx13sRLeoZ918K/zcrKWDKnmsqxkI
        tvbpbSpg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qF01m-002Kfg-2e;
        Thu, 29 Jun 2023 22:22:14 +0000
Date:   Thu, 29 Jun 2023 15:22:14 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: fix unused proc_cap_handler() function warning
Message-ID: <ZJ4EFjIU8VmhFN9c@bombadil.infradead.org>
References: <20230607120857.3621364-1-arnd@kernel.org>
 <29968249-3fce-d53f-4515-1c7b815cd4b4@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29968249-3fce-d53f-4515-1c7b815cd4b4@tessares.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:00:42PM +0200, Matthieu Baerts wrote:
> Hi Arnd,
> 
> On 07/06/2023 14:08, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Since usermodehelper_table() is marked static now, we get a
> > warning about it being unused when SYSCTL is disabled:
> > 
> > kernel/umh.c:497:12: error: 'proc_cap_handler' defined but not used [-Werror=unused-function]
> 
> Thank you for the patch!
> 
> We also hit the same issue on our side after today's sync with Linus'
> tree. I confirm this patch fixes the issue.
> 
> Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> I didn't see this patch applied in Luis' sysctl-next branch, do you know
> who is taking care of it?

I'll send a second pull request to Linus now.

> > Just move it inside of the same #ifdef.
> > 
> > Fixes: e6944e3b75df7 ("sysctl: move umh sysctl registration to its own file")
> 
> A small detail: it looks like the SHA has been modified, it should be
> 861dc0b46432 instead of e6944e3b75df7:
> 
> Fixes: 861dc0b46432 ("sysctl: move umh sysctl registration to its own file")

Adjusted, thanks.

 Luis
