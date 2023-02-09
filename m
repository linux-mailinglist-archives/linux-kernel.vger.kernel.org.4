Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4D1690489
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBIKWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBIKWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:22:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944466ED1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m05LkTDara9V0i8+bZvYhhkAU/rn7EhCM5HAveAw0jg=; b=I6PLhjWdOJffsKcqad9XknQgtM
        yvkidpqQMRJneoDNriqwuhjc3qbbf6w/tgo0vTS0hb7p+uXv5qdyN4Tc0FD2N/oaufIFv20IJhFBj
        eHpJHAkwPgoVb886+68Dia4KGjPlLkfbJK//hp09IZDWWD8F8HgnnTTyWnERLPYTV4GibPWlYdj0y
        9igxeoHy2xK1dUDxc3xzJjj7C8PxzBcksPnPurYAkxtru19//NJnwK4VoTuxtgrVrEoK4NidxHuCy
        6PFsWuEmWg7lWmZF+PzjNuKk4xLgWLO4DiINvE//SdoDbIAVUv7daUWBlCPjUHEu8HcY15oK1pV4F
        rbAMalvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ44b-0026Ql-Gp; Thu, 09 Feb 2023 10:22:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 930D73002BF;
        Thu,  9 Feb 2023 11:22:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 723B320A20FEE; Thu,  9 Feb 2023 11:22:36 +0100 (CET)
Date:   Thu, 9 Feb 2023 11:22:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] objtool: Honey, I shrunk the instruction
Message-ID: <Y+TJbNHT3jDF8wov@hirez.programming.kicks-ass.net>
References: <20230208171756.898991570@infradead.org>
 <Y+QEak2HWlkNuJ3U@fedora.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QEak2HWlkNuJ3U@fedora.fritz.box>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:22:02PM +0100, Damian Tometzki wrote:
> On Wed, 08. Feb 18:17, Peter Zijlstra wrote:
> > Hi,
> > 
> > Boris complained he could no longer build allyesconfig on his 32G desktop
> > machine without having OOM terminate either objtool or chrome.
> > 
> > After talking about these patches on IRC, Nathan mentioned the linux-clang CI
> > was also having trouble of recent, and these patches appear to make it happy
> > again.
> > 
> > In total these patches shrink an allyesconfig run by about 6G:
> > 
> > pre:	5:58.22 real,   226.69 user,    131.22 sys,     26221520 mem
> > post:	5:03.34 real,   210.75 user,    88.80 sys,      20241232 mem
> > 
> > Also at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core
> > 
> Hello Peter,
> 
> with clang-17 the build failed: 
> In file included from weak.c:10:
> In file included from /home/damian/kernel/linux/tools/objtool/include/objtool/objtool.h:13:
> /home/damian/kernel/linux/tools/objtool/include/objtool/elf.h:88:86: error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]
> static_assert(offsetof(struct reloc, rela.r_offset) == offsetof(struct reloc, offset));

Oh urgh. Apparently the kernel wrapper went missing in this userspace
project :-)

include/linux/build_bug.h:#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)

Anyway, it's that last patch and I meant to do that in a slightly less
horrid way :-)
