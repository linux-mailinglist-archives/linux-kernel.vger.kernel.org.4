Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1F6E2EBB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 05:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDODE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 23:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDODE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D4144AE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 20:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10F94644E4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013CCC433D2;
        Sat, 15 Apr 2023 03:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681527894;
        bh=oWel6s+C+uqagn6K4/nTnPlyC70jxGXPY+vOwAK6HE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G20KdsROA4xaDU+ubwGVzeWYkmacNQkMqQ4YtlsG3dtqaGC+E8CQgaQwummAeQMcc
         EeGWMhI5Iu9NJsMiAfk51CttGuCrnuvyYKGcyriowNrINWnSBcB70XvoGUC2VsRK/G
         nBFwDkBGuujxpcdJtVmuR3gKy9yjBhnDQhfGGTQFjhKE2pD97hT0px1pVgHPsO9bYC
         dy4tu4JKtM9QmetkVrP7AA1bRkxLdzKVCPgDN1WIkpsL29WAcfLsgIyxplNJcMyAXq
         lXMvV7MAdfHKVx50WgOinTprAkIUYmCoFlJ4dmn40le4uqbMwtNPmaolldwbkUeUk3
         WeWopPJAQbdGA==
From:   SeongJae Park <sj@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
Date:   Sat, 15 Apr 2023 03:04:52 +0000
Message-Id: <20230415030452.3223-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZDoRSlHiyIvAz+pR@casper.infradead.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2023 03:51:54 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Apr 15, 2023 at 12:37:53AM +0000, SeongJae Park wrote:
> >   *
> > + * begin:
> >   *  rcu_read_lock();
> > - * again:
> >   *  obj = lockless_lookup(key);
> >   *  if (obj) {
> >   *    if (!try_get_ref(obj)) // might fail for free objects
> > - *      goto again;
> > + *      goto begin;
> >   *
> >   *    if (obj->key != key) { // not the object we expected
> >   *      put_ref(obj);
> > + *      rcu_read_unlock();
> >   *      goto again;
> 
> - *      goto again;
> + *      goto begin;

Oops, thank you for catching, Matthew!


Thanks,
SJ
