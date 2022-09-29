Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45C95EEE54
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiI2HEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiI2HE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:04:26 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77295131F69
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:04:13 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 91B99C01D; Thu, 29 Sep 2022 09:04:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664435050; bh=jnYXx8RyU8Xz38FBBjgJIXss06fviVw1nDupFosbI1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vi7DUuTg1NGRDGjgO8BHjnNsST4FQrlM17K62hZQZV9IPwqEXqxsOXn9AaMgnzX0q
         TsMdnEksZLwa5hFYeyAGJaWPb5W8ds0Jbj535bo3fDFTBCVhzSPCZL0AAQrtHq91b7
         yWXA3pft1fA2NIg6wwhnnDAPz4dHFDIzIEWwITvF7aIsasTfJbc43WOumi9Jn2C2m2
         SCwRSJaSSLqkmLeQrj782dJ+yAsAaV3gjEseASZUKJ3otLJM1HlaEV/w3SkuBr7di/
         foQlfT/7cUtfzbGPZC81xpvrzFA3MC3JTS6LXov/PFItLXDAEt6EyC4jAozjpeAH9V
         z0dMr9YNF2Q7g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 5D81FC009;
        Thu, 29 Sep 2022 09:04:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664435050; bh=jnYXx8RyU8Xz38FBBjgJIXss06fviVw1nDupFosbI1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vi7DUuTg1NGRDGjgO8BHjnNsST4FQrlM17K62hZQZV9IPwqEXqxsOXn9AaMgnzX0q
         TsMdnEksZLwa5hFYeyAGJaWPb5W8ds0Jbj535bo3fDFTBCVhzSPCZL0AAQrtHq91b7
         yWXA3pft1fA2NIg6wwhnnDAPz4dHFDIzIEWwITvF7aIsasTfJbc43WOumi9Jn2C2m2
         SCwRSJaSSLqkmLeQrj782dJ+yAsAaV3gjEseASZUKJ3otLJM1HlaEV/w3SkuBr7di/
         foQlfT/7cUtfzbGPZC81xpvrzFA3MC3JTS6LXov/PFItLXDAEt6EyC4jAozjpeAH9V
         z0dMr9YNF2Q7g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id dc3ba70a;
        Thu, 29 Sep 2022 07:04:05 +0000 (UTC)
Date:   Thu, 29 Sep 2022 16:03:50 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH 2/2] 9p: client_create: init fcall_cache earlier
Message-ID: <YzVDVhSHBVFltc4o@codewreck.org>
References: <YzQc2yaDufjp+rHc@unreal>
 <20220928214417.1749609-1-asmadeus@codewreck.org>
 <20220928214417.1749609-2-asmadeus@codewreck.org>
 <YzUzyw9JE4lFWKo5@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzUzyw9JE4lFWKo5@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Romanovsky wrote on Thu, Sep 29, 2022 at 08:57:31AM +0300:
> > +	 * followed by data accessed from userspace by read
> > +	 * Note we do not check for failure here because the cache is
> > +	 * optional; warning will be issued on dmesg for failure.
> > +	 */
> > +	clnt->fcall_cache =
> > +		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
> > +					   0, 0, P9_HDRSZ + 4,
> > +					   clnt->msize - (P9_HDRSZ + 4),
> > +					   NULL);
> > +
> 
> clnt->msize can be changed after call to ->create() if it is larger than clnt->trans_mod->maxsize).

Ugh, that's what I get for doing this in a hurry because you're all
talking about order this order that...

This is absolutely correct, I'm dropping this patch.

--
Dominique
