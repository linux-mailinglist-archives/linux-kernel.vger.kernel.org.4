Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2296872B657
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 06:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjFLESq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 00:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFLESp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:18:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF491;
        Sun, 11 Jun 2023 21:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7VuDlLSYJdW+nNu3X898l9wqFn63pIrv3O6konR/Pjs=; b=l5yxoaiDbF4Ou9V0nCQhlIWYsk
        RvKJmlX4OqkVLWP/g42QdE1H/0q529Wq0qDLw9jJgvDorAOir6w45u5eJPIeDVquDB4bSpeV4Wl9/
        jq8OVYC8HWqFZhYN/nJ5OOA+IQijKAlcdHkoX/HSUVd3D3EwkdEM8AB6z3Ioq1yVhzZGL87ip574U
        EPotdZX9edn5ho9GSBE6c+AtugqdQq7hGTj4ZTTi/S9QQaGA2t3pX62/b6ZsyGj2GTatWNCIdXdNL
        qG+a+hK6+ORfHc+Bm5FwR1ICJIlN1GtBY/Y2vGS/TsSKKb9S64Ia3hyPR198Qp2r4LjjVghOpzE6B
        CMjzDNlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8Z0b-002Vpz-10;
        Mon, 12 Jun 2023 04:18:25 +0000
Date:   Sun, 11 Jun 2023 21:18:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yi He <clangllvm@126.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] Add a sysctl option to disable bpf offensive helpers.
Message-ID: <ZIackaLpA3APFFvj@infradead.org>
References: <20230610152618.105518-1-clangllvm@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610152618.105518-1-clangllvm@126.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 03:26:18PM +0000, Yi He wrote:
> The default value of sysctl_offensive_bpf_disabled is 0, which means 
> all the five helpers are enabled. By setting sysctl_offensive_bpf_disabled 
> to 1, these helpers cannot be used util a reboot. By setting it to 2, 
> these helpers cannot be used but privieleged users can modify this flag
> to 0.

That's just a nightmare API.  The right thing is to not allow
program types that can use the helpers from anything but a global
fully privileged context.

And offensive is in this context a really weird term.  Nothing is
offensive here, invasive or allowing to change kernel state might be
better terms.
