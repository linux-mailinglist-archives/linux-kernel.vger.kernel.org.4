Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB7E64452B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiLFN7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiLFN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:59:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A7C6143
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:59:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F2E16176E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 13:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C03C433D6;
        Tue,  6 Dec 2022 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670335166;
        bh=pBfGabi2/wXkebpJ8J8lEIDp/m5U4OB2XlYBddIlHL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gI7qwPfNa2KUJdwrwtrf5oWP+Bj3XZl+P8eOymxLFNAEqmZ4JWbcNlpB1UThMI+kn
         K1Z6yp89E9HiVS8QRJWQ0+eug/BAz1jUvdFz+LsGnXM5Y823XkieUXVZSpKEBo7Y5T
         D7RoiJNlcsjf37m8fKk4yNt8TqG9DztJnpEUu31HJ9PyCRTpEmgx0em3Ui4E7IuzgH
         wyMyPhGw0LWziyAM/7iAYFOIi9rrpvswCK/9RcK4lz30iD13n+IOPPPZSWRPIUtHf1
         fPX2sM/4WJAsZ/ggrIVUdrKuRdgkQn2zMirw0dYH7EfuwEO6c37mREsbQ4MK+hTgRI
         tm3RhExuYo0cg==
Date:   Tue, 6 Dec 2022 22:59:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Fix some checker warnings
Message-Id: <20221206225923.342044429adb3aafe67400a7@kernel.org>
In-Reply-To: <382777.1670236186@warthog.procyon.org.uk>
References: <20221205180617.9b9d3971cbe06ee536603523@kernel.org>
        <20221205123200.51539846cb9dd9dc158cc871@kernel.org>
        <166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk>
        <276025.1670228915@warthog.procyon.org.uk>
        <382777.1670236186@warthog.procyon.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2022 10:29:46 +0000
David Howells <dhowells@redhat.com> wrote:

> Btw, do you know how to deal with:
> 
> 	add_ftrace_export(struct trace_export **list, struct trace_export *export)
> 
> being called by:
> 
> 	add_ftrace_export(&ftrace_exports_list, export);
> 
> but ftrace_exports_list has an __rcu annotation, so the list argument in the
> former should have an __rcu annotation in it somewhere too.

Can't you just add __rcu to the 'list' argument?

> 
> OTOH - there's only one user of add_trace_export() and add_ftrace_export(), so
> can they be collapsed into register_ftrace_export()?

Steve, do you have any idea?

Thanks,

> 
> David
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
