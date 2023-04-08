Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB136DBDCE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 00:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjDHWMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDHWML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 18:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32CC49D9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 15:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5381060B61
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 22:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D48AC433D2;
        Sat,  8 Apr 2023 22:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680991928;
        bh=OYLcFZhhMyeC/gCCEbJPEFclaV3bu8ErLz9OL8jhDe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fcfe6uDS5S/e7WCot3NZAUxBUjQMgfewzolIKOThHnmp20tpX7CRd3xnhYhAWSpQw
         YCtPmCD//MTmuElIVfXir+bOczzvtNbaZZ/iWukx92V+l0nwVOmIPFmBVnljbTC0ba
         8Qwk9vOAc08khnhQ1Da/uy7AoIj4xiUq3i5+NT3vEwKF4cuDLxn8szHgbuIE5FQmmo
         Ei4kavmhTZ6BmBKEzVSeMym4osi6QUuXTmO0C+77MTqjB8meHVUbB3RzPrSfYtqg1o
         JNcRWC00bNYKPF6YBab8KhHqEGiQXeEn4LIXkCHGWRqmrLVN79yjS6xtqNr3u29kGN
         LIPhpc2fUTkEA==
Date:   Sat, 8 Apr 2023 15:12:06 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     peterz@infradead.org, keescook@chromium.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86: make __get_wchan() use arch_stack_walk()
Message-ID: <20230408221206.mi7nsquoxklgword@treble>
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-3-zhengqi.arch@bytedance.com>
 <20230408050822.ezdbhc6j7zuvutrm@treble>
 <fffd59ff-eaa8-bba7-03f2-9fc27620bd1c@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fffd59ff-eaa8-bba7-03f2-9fc27620bd1c@bytedance.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 01:36:06PM +0800, Qi Zheng wrote:
> 
> 
> On 2023/4/8 13:08, Josh Poimboeuf wrote:
> > On Thu, Mar 30, 2023 at 04:15:52PM +0800, Qi Zheng wrote:
> > > Make __get_wchan() use arch_stack_walk() directly to
> > > avoid open-coding of unwind logic.
> > > 
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > 
> > Can we just have a shared version of __get_wchan() for all
> > CONFIG_ARCH_STACKWALK arches?
> 
> From a quick glance, I think it's ok, but we still need to define
> the arch's own get_wchan_cb(). I will try to do it.

Hm, why would we need to do that?

-- 
Josh
