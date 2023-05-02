Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492C6F4B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjEBUuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEBUuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB71997
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D25F16283B
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 20:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEECAC433EF;
        Tue,  2 May 2023 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683060609;
        bh=rVY7UjkHMPXkAmvlUx3cyWY9OcG8ElTmqO6luNZigbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UHHzZJkmv6VU2ttN/tzoV8fgyxFhGAvO/t+EsVRvXfGvTaIaWkampkGmQHEIXIbV8
         Fju6RGahPy8FJBR2HgwIrSbZ7GFeund0kW3cY6sOhbBQxfylqShqMhEtqdPcRrNVXX
         nQ6PECscHOgrN8qjYyma72fz3Yqp8iCZqQXoPckA=
Date:   Tue, 2 May 2023 13:50:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     wenyang.linux@foxmail.com, Oscar Salvador <osalvador@suse.de>,
        William Lam <william.lam@bytedance.com>,
        Pintu Kumar <pintu@codeaurora.org>, Fu Wei <wefu@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: compaction: optimize compact_memory to comply
 with the admin-guide
Message-Id: <20230502135008.cb8cc8475971d190d32e699a@linux-foundation.org>
In-Reply-To: <20230428105848.ghtz5v3q6mug4hiw@techsingularity.net>
References: <tencent_DFF54DB2A60F3333F97D3F6B5441519B050A@qq.com>
        <20230428105848.ghtz5v3q6mug4hiw@techsingularity.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 11:58:48 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1736,6 +1736,7 @@ static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNE
> >   */
> >  static unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
> >  static int sysctl_extfrag_threshold = 500;
> > +static int sysctl_compact_memory;
> >  
> 
> __read_mostly but that aside, it's only used in
> sysctl_compaction_handler so could also be declared as static within
> that function. That way if CONFIG_SYSCTL is not set, it should be
> guaranteed that the compiler does not save storage for it.

but

static struct ctl_table vm_compaction[] = {
	{
		.procname	= "compact_memory",
		.data		= &sysctl_compact_memory,
		.maxlen		= sizeof(int),
		.mode		= 0200,
		.proc_handler	= sysctl_compaction_handler,
	},


I'll add the __read_mostly, thanks.
