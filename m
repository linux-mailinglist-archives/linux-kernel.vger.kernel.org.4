Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA2C5EEEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiI2HZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbiI2HYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:24:53 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD442E2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:24:32 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id B0109C01D; Thu, 29 Sep 2022 09:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664436269; bh=8xgJCeoUgsZNjtT6KDoCDIr+mxANEC08PbBvO5haN7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZaQ3bR27CTZjB1QUn3jqwPzDUY4DP3R6wqI4bIr0DK8FD+lcOpPu3+3zwYFtQ3Qw
         8eqXELKd1WZuZz3Dv14TDo6JeH3ydBy3Wkc480gor0TVJko3b5JNLCmm5C0Vo/IaXN
         jNE4oX+LgVwdi1lySRI3DTgzmAv5e1yean+g0snTIf7KVbNOxVa26HY5gY3sGCKZKI
         mmGWQc//GT4TcV2RG4qVMvooGaGgIrMVbT9s2LsBnfEYFoFnI9zCiEqc1378Hi5fgs
         Cb7fuSwvrhezXRg+8nsuyasl3qx//RgSvjz80vUyiIbMTusDuumEuUS8WNsboDbVxi
         kgR3idl569eVA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 4CED2C009;
        Thu, 29 Sep 2022 09:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664436269; bh=8xgJCeoUgsZNjtT6KDoCDIr+mxANEC08PbBvO5haN7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZaQ3bR27CTZjB1QUn3jqwPzDUY4DP3R6wqI4bIr0DK8FD+lcOpPu3+3zwYFtQ3Qw
         8eqXELKd1WZuZz3Dv14TDo6JeH3ydBy3Wkc480gor0TVJko3b5JNLCmm5C0Vo/IaXN
         jNE4oX+LgVwdi1lySRI3DTgzmAv5e1yean+g0snTIf7KVbNOxVa26HY5gY3sGCKZKI
         mmGWQc//GT4TcV2RG4qVMvooGaGgIrMVbT9s2LsBnfEYFoFnI9zCiEqc1378Hi5fgs
         Cb7fuSwvrhezXRg+8nsuyasl3qx//RgSvjz80vUyiIbMTusDuumEuUS8WNsboDbVxi
         kgR3idl569eVA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id e36ba166;
        Thu, 29 Sep 2022 07:24:25 +0000 (UTC)
Date:   Thu, 29 Sep 2022 16:24:10 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] 9p: client_create/destroy: only call trans_mod->close
 after create
Message-ID: <YzVIGuISTnIFSIs9@codewreck.org>
References: <20220928215800.1749929-1-asmadeus@codewreck.org>
 <20220928221923.1751130-1-asmadeus@codewreck.org>
 <YzUzAqsq803Z+rtr@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzUzAqsq803Z+rtr@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Romanovsky wrote on Thu, Sep 29, 2022 at 08:54:10AM +0300:
> > +	// ensure clnt->trans is initialized to call close() on destroy
> > +	// if and only if create succeeded
> > +	if (err < 0) {
> > +		clnt->trans = ERR_PTR(err);
> >  		goto out;
> > +	}
> > +	if (IS_ERR(clnt->trans))
> > +		clnt->trans = NULL;
> >  
> >  	if (clnt->msize > clnt->trans_mod->maxsize) {
> >  		clnt->msize = clnt->trans_mod->maxsize;
> > @@ -1036,7 +1043,7 @@ void p9_client_destroy(struct p9_client *clnt)
> >  
> >  	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
> >  
> > -	if (clnt->trans_mod)
> > +	if (clnt->trans_mod && !IS_ERR(clnt->trans))
> 
> It is completely no-go to rely on internal value inside of structure after
> failure in ->create() callback.

We're overriding the value after ->create(), in both cases that might
pose problem (success without setting trans/failure); I can't see how
that would possibly fail.

But as you've seen in the other commit I am in no shape to write any
decent code and consider the implications of what I'm changing in this
untangled mess, so you know what: I'll just leave this broken.

Please send me a patch if you care, I'm done here.
-- 
Dominique

