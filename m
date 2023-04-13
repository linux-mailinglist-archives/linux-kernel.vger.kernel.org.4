Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58A6E0A23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDMJYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDMJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:24:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641EF106
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xJh0gAIPHrRxpvJvCCLJ+I5Uoe34c45DcqjaK2Bw8xs=; b=cLqBqTE2gHfX3Ri1M3O1YloR/g
        M05z3Va0SQgPARfER//9WVy7vbTf0X49EBnidkAxQOLgu0rfraXwAOzSa6ycMG/M/mufebWIDb7R7
        zqlU7wKwpplHFpu4uA9/Nh0wLGFFymJncACm7NNtfUBIPLTWOuCekvn7F8cC8fP3978HYI/TJI4LC
        7o9ExbJgAV9Ec+5KCkpirZE+Ii8Im16n2kjX2qBVoborAuM0ApFQD2+GcHwyXMXxyJ5DXNgaZhNqf
        0klwidhMVDYKMvelojdQp0SsMTOHoTcFP5VRmTcedf+0uWn9rlfNcsGLTmzSLvgIV6ai0QHUZL0Bw
        G2SrPFkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmtBf-007fnI-8R; Thu, 13 Apr 2023 09:24:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00E4030002F;
        Thu, 13 Apr 2023 11:24:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE350235CC46F; Thu, 13 Apr 2023 11:24:09 +0200 (CEST)
Date:   Thu, 13 Apr 2023 11:24:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 9/9] objtool: Ignore exc_double_fault() __noreturn
 warnings
Message-ID: <20230413092409.GJ4253@hirez.programming.kicks-ass.net>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <683214828d8b2ad732dab1a74e858087519d8c8b.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683214828d8b2ad732dab1a74e858087519d8c8b.1681325924.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:03:24PM -0700, Josh Poimboeuf wrote:
> +	 *   - have compiler communicate __noreturn functions somehow

This, we're going to have to do that -- because keeping that (ever
growing) list in sync is going to be a pain in the backside.

