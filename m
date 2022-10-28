Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2BD611B22
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJ1TsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJ1Trz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:47:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197AD241B0B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WE0U9W6dwiOwdUAAWamaejYu7mRh00CBAA+DvQdSjfE=; b=eaYeJOI/JkIUgdDdMN+N831oxC
        Q8byy3AieM7i/k0417HGZBppWRL1GjNYp7/PEykj6mqsngsEoS+mF3bbp0GRJye5EhbFf+/eN56Qo
        RqbTwvgI0b7bDnzbOIBQTtrXOFvUJP9OrJYo9gJaKDEB0C6bg+tFKtRZ4uTUBp51YxstMjFkywQIp
        7euD1FQDsI6BklpWqzALTpgYo5YsjFEfzB0UusP4+K5pV8MStLhEtoou6gZ7U9z21gNeKZrYbG4Vf
        GA44h7I9KBpyvHZge9QjykXYmvCeMRvLa9bUAQ3+FueenInF6hyuq9QaD6X8hRqv/RDvfhfqaIco4
        RdPYCm9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooVKV-001V5o-VS; Fri, 28 Oct 2022 19:47:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B387130010B;
        Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9314C2C26AB85; Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Message-ID: <20221028194022.388521751@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Oct 2022 21:40:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        djwong@kernel.org, yujie.liu@intel.com, tglx@linutronix.de,
        jpoimboe@kernel.org, joao.moreira@intel.com,
        samitolvanen@google.com
Subject: [PATCH 0/5] x86/kallsyms: Fix the call-thunk kallsyms fail
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As reported here:

  https://lkml.kernel.org/r/202210241614.2ae4c1f5-yujie.liu@intel.com

The kallsyms change for call-thunks doesn't really work out as expected. These
patches revert that change and propose an alternative.




