Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8565A72F364
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbjFNEKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbjFNEKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:10:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268BF19B7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:10:11 -0700 (PDT)
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
        id 4QgsQT3Xndz4x4G; Wed, 14 Jun 2023 14:10:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1686715809;
        bh=wvvRc9qy6Ni7t/b7z+9GETWf6P/wewVtlrltmdxCvjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DFfOrXRu+Zyg3+Fad0QP8M1k5KhwxTXq8rYTpjt/ZqPs1emMh/0XpTc9GFfMQTXpC
         x1Tg15tU6Ag18OQXH0RWERG/mlTQZwCdy/qgcFkoETTyIz015+f4eMr4vsq2rOrt7N
         qkAEVOn27CnNPfU9vby0DDO2A5+XP00l9JqBzdCOz2nygF0MTFJ43y8nxi2nkXHraF
         /7v6wQr2btfPPr6FGm0M3oBIfqVgehn3CxNCfHugZuUnu3ApTGMxmJ68Hd6fuWQGPf
         FeZEJDiMEvlv1oCGlooxUfOdEz9qIchWVxiOeCulNIJYhnrHxW7AJgK/nx8h55syBh
         QRRhLB5gU9FJg==
Date:   Wed, 14 Jun 2023 14:10:05 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     baomingtong001@208suo.com
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        pbonzini@redhat.com, seanjc@google.com, thuth@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: remove unneeded variable
Message-ID: <ZIk9nVjY4G2xInd1@cleo>
References: <20230614023206.3865-1-luojianhong@cdjrlc.com>
 <de7ae31f88510a6b04f29fc01ab44854@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7ae31f88510a6b04f29fc01ab44854@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:34:45AM +0800, baomingtong001@208suo.com wrote:
> fix the following coccicheck warning:
> 
> arch/powerpc/kvm/book3s_pr.c:424:5-6: Unneeded variable: "r".
> 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>  arch/powerpc/kvm/book3s_pr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 9118242063fb..d03b31b240d7 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -421,14 +421,14 @@ void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu)
> 
>  static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
>  {
> -    int r = 1; /* Indicate we want to get back into the guest */
> +    /* Indicate we want to get back into the guest */

Instead of leaving the comment here, where it makes no sense, please
move it to the return statement below.

> 
>      /* We misuse TLB_FLUSH to indicate that we want to clear
>         all shadow cache entries */
>      if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
>          kvmppc_mmu_pte_flush(vcpu, 0, 0);
> 
> -    return r;
> +    return 1;
>  }
> 
>  /************* MMU Notifiers *************/

Paul.
