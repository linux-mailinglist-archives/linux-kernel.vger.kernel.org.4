Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3C6C63CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCWJiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjCWJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:37:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4C838EA8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TmgsCyUsgRsi8w9qg1yRh1RDgUs9f7/DjiEdcSSu24E=; b=NkJVPyinHb+6SRGXFb+WvhPG8B
        TBF3T70NTVgv86hiYederabAE+Di8qDFGpR+dPYq7Lmvegn9wCv9Raa4Q/9HlnkQKkT+5Qf9L027O
        MI548rNUn4ea5yvPhO+CEp4wCDFdPt9xQlO1aQu5DYdjd3LZhDsc6J8B2daoSWPZbIBTrEG2LdhQ8
        UrLAxlfbzTTY755OG3NWURJROvdyZ5ioO2U65VbozUls0bnFsXGx9flmlAyUvQj31Xhxkq+J+SuHX
        f3fqSG/fWUnc29CP3AeAM15BRlnaNYZAVOVGoeMv3KungQIC3OclX9lTL/xtcRse2eoD5wFoALi/5
        aULiWNTA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfHLI-004pBe-2z;
        Thu, 23 Mar 2023 09:34:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D407300237;
        Thu, 23 Mar 2023 10:34:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54417200C937C; Thu, 23 Mar 2023 10:34:44 +0100 (CET)
Date:   Thu, 23 Mar 2023 10:34:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
Message-ID: <20230323093444.GB2508414@hirez.programming.kicks-ass.net>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:
> +		/*
> +		 * There is only one new level per time. When connecting
> +		 * child and parent and set child active when parent is
> +		 * inactive, parent needs to be the upperst
> +		 * level. Otherwise there went something wrong!
> +		 */

> +		/* check if upperst level was newly created */

Sorry for being a pain and with the caveat that I'm not a native speaker
either, but I think upperst should be uppermost. You actually had me
google to see what the word meant..
