Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D4466C2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjAPOwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjAPOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:52:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB8A2BF12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=myQj/MBdPle3LrkO0rdNRoaNXUdtePdBjz6BKLQ5f+E=; b=FLqszaemcNeksY+EzWYCNg5GsL
        /G5G9NGNsU5jSnXxmUVfg9zG6N/3rGrhBPe83E3mCwQJwFiPtv8xLfUsSjfoBhZsvFtKTQ1zUjPJn
        loCzDMF4bI22KL1b9sTSVxk7fHjzXBVSse/Lwsv3dC7P30UtJgbySM1qUCQ7MOTR2TwOglVOWs9hT
        33DfxsJhDNCZvED7aBcJBwNHXcILUuCh/DHiTwhRVuw4HWX/ilGletp3oUrAu2C5nKWm5xshkfTdK
        qREZO4eRXzw9xnacQMHb2wRGQM7vUlh1iTHsSlwu3j+0/G5iySYxx1czWr0FWKGo1MB1E/AVje45d
        zxW+5voA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pHQc7-005csx-17;
        Mon, 16 Jan 2023 14:37:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1E283007C5;
        Mon, 16 Jan 2023 15:37:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A94B22081B292; Mon, 16 Jan 2023 15:37:38 +0100 (CET)
Message-ID: <20230116142533.905102512@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Jan 2023 15:25:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 0/7] x86: retbleed=stuff fixes
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Patches to address the various callthunk fails reported by Joan.

The first two patches are new (and I've temporarily dropped the
restore_processor_state sealing).

It is my understanding that AP bringup will always use the 16bit trampoline
path, if this is not the case, please holler.


