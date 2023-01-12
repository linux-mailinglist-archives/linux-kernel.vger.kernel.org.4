Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4176C66782A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbjALOxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbjALOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:52:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAB16146A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dxKp4F/ZypynYhxVQrwpFBE7F8I1udIiZ+qCB0euLH8=; b=Qw76boxsic6bAdPZ+sbUQ2gqH+
        toujE3QAL7Ysrb/kR6kbNWK8+/9lcxeR5snVxN72gLXv54orCAYheJOMSUJTxsIOq6nlVdd9M05yx
        xzAl7+DGS02CDXkNHHjeh7e9nMs5aY0qzl9lI/Ybug1C2cN+L9cUSAyH9scpEzK8O5SsQgYiCg6Y5
        jAK6oY9jXCznsqioTj6bpA+gfUlBJJaabAP8t+fNLnSC0fudkg27IKcOz4kzbhxN1B+GtqFgHO05t
        iG2Tq/6Nx3QTZSzkBCmPsHHW89g1u9fdQigJA6ONkHFfsmbKlG6YcpbLdRrHDBiKoAXxjMOx3j3S3
        79pDM38g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFyjn-0057zf-Vo; Thu, 12 Jan 2023 14:39:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E8514300C22;
        Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AF0012C539AAE; Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Message-ID: <20230112143141.645645775@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 15:31:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com
Subject: [RFC][PATCH 0/6] x86: Fix suspend vs retbleed=stuff
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm thinking these few patches should do the trick -- but I've only compiled
them and looked at the resulting asm output, I've not actually ran them.

Joan, could you kindly test?

The last (two) patches are optional fixes and should probably not go into /urgent.

