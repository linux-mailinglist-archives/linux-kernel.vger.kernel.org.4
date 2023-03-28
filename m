Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308276CB914
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjC1ILL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjC1ILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:11:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D56A2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9aiFtdzprt66V5jMsLV13bI+fqreux1yG7PfwIIUbAs=; b=AwkDJA9SUvcC1G2kObOazpuxym
        JH78yMYjNI8R6xYv4xDGZ1VhknKQ2ZIoygyN4EwCDsYXY2yF2PL9BP+h3yCDjLbqptwZ61Z/tWpNU
        2Q9E2SkdQbsPebMK7Hx/6AP0zI4wH2POIirAVxatK/u/+eydYKlxWm5uW6yDgg1RwrMPIdNtLym4y
        O+XLNG5GnOHPCCp7gmfmj7b+65EdU0N8p1uxOywHXSmQ6aWIzWuA8LCPxhDYT8jsxpatUGe9ajyMV
        Gndzg/b+PYnU0TGnRg1H7bgBE2EE+lSAdAdKuoM5DUR1UAmq4LzK4tgXzpZ/vcPgjhLMCrj8xA17I
        vdpnGgQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ph4Q6-008Eum-7i; Tue, 28 Mar 2023 08:11:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDD41300289;
        Tue, 28 Mar 2023 10:11:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B33162CB744B1; Tue, 28 Mar 2023 10:11:05 +0200 (CEST)
Date:   Tue, 28 Mar 2023 10:11:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] objtool: Add per-function rate limiting for
 unreachable warnings
Message-ID: <20230328081105.GD4253@hirez.programming.kicks-ass.net>
References: <cover.1679932620.git.jpoimboe@kernel.org>
 <b21f7791b30c54cf8c4d0f489decdc4a47a18963.1679932620.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b21f7791b30c54cf8c4d0f489decdc4a47a18963.1679932620.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 09:00:47AM -0700, Josh Poimboeuf wrote:
> Unreachable instruction warnings are rate limited to once per object
> file.  That no longer makes sense for vmlinux validation, which might
> have other unreachable instructions lurking in other places.  Change it
> to once per function.

Do we want a negative option to disable this? --no-ratelimit or such?
