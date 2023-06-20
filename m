Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248B17363A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjFTGgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFTGgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:36:02 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2586E6E;
        Mon, 19 Jun 2023 23:36:00 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:35:55 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florent Revest <revest@chromium.org>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, lirongqing@baidu.com, wangli39@baidu.com,
        zhangyu31@baidu.com, daniel@iogearbox.net, ast@kernel.org,
        kpsingh@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
Message-ID: <ZJFIy+oJS+vTGJer@calendula>
References: <20230615152918.3484699-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615152918.3484699-1-revest@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 05:29:18PM +0200, Florent Revest wrote:
> If register_nf_conntrack_bpf() fails (for example, if the .BTF section
> contains an invalid entry), nf_conntrack_init_start() calls
> nf_conntrack_helper_fini() as part of its cleanup path and
> nf_ct_helper_hash gets freed.
> 
> Further netfilter modules like netfilter_conntrack_ftp don't check
> whether nf_conntrack initialized correctly and call
> nf_conntrack_helpers_register() which accesses the freed
> nf_ct_helper_hash and causes a uaf.
> 
> This patch guards nf_conntrack_helper_register() from accessing
> freed/uninitialized nf_ct_helper_hash maps and fixes a boot-time
> use-after-free.

How could this possibly happen?

nf_conntrack_ftp depends on nf_conntrack.

If nf_conntrack fails to load, how can nf_conntrack_ftp be loaded?

> Cc: stable@vger.kernel.org
> Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  net/netfilter/nf_conntrack_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
> index 0c4db2f2ac43..f22691f83853 100644
> --- a/net/netfilter/nf_conntrack_helper.c
> +++ b/net/netfilter/nf_conntrack_helper.c
> @@ -360,6 +360,9 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
>  	BUG_ON(me->expect_class_max >= NF_CT_MAX_EXPECT_CLASSES);
>  	BUG_ON(strlen(me->name) > NF_CT_HELPER_NAME_LEN - 1);
>  
> +	if (!nf_ct_helper_hash)
> +		return -ENOENT;
> +
>  	if (me->expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
>  		return -EINVAL;
>  
> @@ -515,4 +518,5 @@ int nf_conntrack_helper_init(void)
>  void nf_conntrack_helper_fini(void)
>  {
>  	kvfree(nf_ct_helper_hash);
> +	nf_ct_helper_hash = NULL;
>  }
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
