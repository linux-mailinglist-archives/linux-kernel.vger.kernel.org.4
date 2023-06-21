Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD31738F16
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjFUSr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFUSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:47:54 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7079B;
        Wed, 21 Jun 2023 11:47:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qC2ri-0001Xx-27; Wed, 21 Jun 2023 20:47:38 +0200
Date:   Wed, 21 Jun 2023 20:47:38 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Florent Revest <revest@chromium.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        lirongqing@baidu.com, daniel@iogearbox.net, ast@kernel.org,
        kpsingh@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
Message-ID: <20230621184738.GG24035@breakpoint.cc>
References: <20230615152918.3484699-1-revest@chromium.org>
 <ZJFIy+oJS+vTGJer@calendula>
 <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com>
 <20230621111454.GB24035@breakpoint.cc>
 <CABRcYmKeo6A+3dmZd9bRp8W3tO9M5cHDpQ13b8aeMkhYr4L64Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABRcYmKeo6A+3dmZd9bRp8W3tO9M5cHDpQ13b8aeMkhYr4L64Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florent Revest <revest@chromium.org> wrote:
> > in this case an initcall is failing and I think panic is preferrable
> > to a kernel that behaves like NF_CONNTRACK_FTP=n.
> 
> In that case, it seems like what you'd want is
> nf_conntrack_standalone_init() to BUG() instead of returning an error
> then ? (so you'd never get to NF_CONNTRACK_FTP or any other if
> nf_conntrack failed to initialize) If this is the prefered behavior,
> then sure, why not.
> 
> > AFAICS this problem is specific to NF_CONNTRACK_FTP=y
> > (or any other helper module, for that matter).
> 
> Even with NF_CONNTRACK_FTP=m, the initialization failure in
> nf_conntrack_standalone_init() still happens. Therefore, the helper
> hashtable gets freed and when the nf_conntrack_ftp.ko module gets
> insmod-ed, it calls nf_conntrack_helpers_register() and this still
> causes a use-after-free.

Can you send a v2 with a slightly reworded changelog?

It should mention that one needs NF_CONNTRACK=y, so that when
the failure happens during the initcall (as oposed to module insertion),
nf_conntrack_helpers_register() can fail cleanly without followup splat?

Thanks.
