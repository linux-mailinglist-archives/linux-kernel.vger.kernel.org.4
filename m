Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61D745FB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjGCPXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGCPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:23:23 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BF7E62;
        Mon,  3 Jul 2023 08:23:14 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qGLOC-0000cR-Qj; Mon, 03 Jul 2023 17:22:56 +0200
Date:   Mon, 3 Jul 2023 17:22:56 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Florent Revest <revest@chromium.org>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
        fw@strlen.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, kpsingh@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH nf v2] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
Message-ID: <20230703152256.GC7043@breakpoint.cc>
References: <20230703145216.1096265-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703145216.1096265-1-revest@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florent Revest <revest@chromium.org> wrote:
> If nf_conntrack_init_start() fails (for example due to a
> register_nf_conntrack_bpf() failure), the nf_conntrack_helper_fini()
> clean-up path frees the nf_ct_helper_hash map.
> 
> When built with NF_CONNTRACK=y, further netfilter modules (e.g:
> netfilter_conntrack_ftp) can still be loaded and call
> nf_conntrack_helpers_register(), independently of whether nf_conntrack
> initialized correctly. This accesses the nf_ct_helper_hash dangling
> pointer and causes a uaf, possibly leading to random memory corruption.
> 
> This patch guards nf_conntrack_helper_register() from accessing a freed
> or uninitialized nf_ct_helper_hash pointer and fixes possible
> uses-after-free when loading a conntrack module.

Reviewed-by: Florian Westphal <fw@strlen.de>
