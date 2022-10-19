Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A746D604467
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiJSMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiJSMDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:03:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2DE1A385
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NHrwrYopQeC4Jky1ozZ0NBYbtG5x6jjkISZclLD6Oxc=; b=nn1wiY5f0WQds8X1ObdZ3rUevL
        6kCMi/caShFIqMo5KlgyC/JZRNJ7uZsGIYV1moLI1v43XtcLHnQJ/Ng271nVYGGr7m7gdZdo8TWvV
        WtMbAQIoDN0hXnF8QAba7wHtZppovWJE8IDOJ4yDjAbFGUeZcDbuw0tpEY/qSv3+KfiGq1f1n82W9
        irFAzCs2plng+J0u8Z7QIXHhY4MXvNGx5rfu5i5HvEL9xAxqBjUZTmb3fyMrPadc4m7n8STAnWMFg
        QHL4G1yNuOp8syayGywyNaAOFhIgb/ViXD/BwYy6Ipgg2Y2Qn7ARYLvXcDB73Y2xqy7gEJrl9gtW8
        qzDvan8w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ol7Os-004jn6-LL; Wed, 19 Oct 2022 11:38:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B62CB300110;
        Wed, 19 Oct 2022 13:38:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66D642C229361; Wed, 19 Oct 2022 13:38:17 +0200 (CEST)
Date:   Wed, 19 Oct 2022 13:38:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y0/hqbzrqZk89149@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08E9DgGD0lPB85O@hirez.programming.kicks-ass.net>
 <20221018233148.lgoiis2tws7caw3l@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018233148.lgoiis2tws7caw3l@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:31:48PM -0700, Josh Poimboeuf wrote:

> Is there a reason not to default to FineIBT if the hardware supports it?

Not really; and that's the default implemented here. Kees seems to think
the kCFI thing is a little more resillient against attacks where the
attacker can write code -- but IMO that's a bit of a lost cause.

Being able to run kCFI on IBT hardware is useful for
development/debugging purposes though.
