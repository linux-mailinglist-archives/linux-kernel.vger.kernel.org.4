Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BF5740191
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjF0Qo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0Qo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFFE97;
        Tue, 27 Jun 2023 09:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225C3611E4;
        Tue, 27 Jun 2023 16:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D740DC433C0;
        Tue, 27 Jun 2023 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687884266;
        bh=lHpE7is/FZcQr+hDU6WcWf9dfsLK5ZXUTlGo/Cptkaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VY+hhdpFmdc935OmKzseZ1dgmGT0CymD+28Bt3tziPVxEilu4rKvy5y8Vqpe3qhhG
         RWYXsXlVuCTBMew1JuSb9PAvEjwwdM/ocuY9rizMxh5HBo0utu0YApFNi1qms8P9Pu
         ohZpvFwytPjJCF2JqiWHbcHzlH/AIHLkvrbkpyZkcdfJ/wZd/NY15eynAKOvfzxP7P
         fA6isFbK4J3ksTW5+RhkA1WgrH6+eyWZwVz9oo3p/9j/8Vd1sMUy+yEmvvH0qp1qCI
         XFyIfbY5qDsGzlsotH9z6hJo8wGp+eVyQJvk1gOo+SMVOp4UL52kGrDb1BbVtyDqY1
         qHNgzl5AyBfVQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, martin.lau@linux.dev,
        ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Egorenkov <Alexander.Egorenkov@ibm.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] btf: warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date:   Tue, 27 Jun 2023 16:44:24 +0000
Message-Id: <20230627164424.81241-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627163750.81178-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 16:37:50 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Jiri,
> 
> On Tue, 27 Jun 2023 18:20:39 +0200 Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Mon, Jun 26, 2023 at 06:11:20PM +0000, SeongJae Park wrote:
> > > __register_btf_kfunc_id_set() assumes .BTF to be part of the module's
> > > .ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
> > > the function prints an error message and return an error.  As a result,
> > > such modules cannot be loaded.
> > > 
> > > However, the section could be stripped out during a build process.  It
> > > would be better to let the modules loaded, because their basic
> > > functionalities have no problem[1], though the BTF functionalities will
> > > not be supported.  Make the function to lower the level of the message
> > > from error to warn, and return no error.
> > > 
> > > [1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> > > 
> > > Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
> > > Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
> > > Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> > > Fixes: dee872e124e8 ("bpf: Populate kfunc BTF ID sets in struct btf")
> > 
> > should it be this one in Fixes instead?
> >   c446fdacb10d bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF
> 
> The commit c446fdacb10d was trying to fix commit dee872e124e8, which this patch
> is claiming to fix, by relaxing the check.  Nevertheless, it seems the check
> need to further relaxed, and therefore I wrote this patch.
> 
> For the reason, I was thinking this patch is directly fixing c446fdacb10d, but
> is also fixing a problem originally introduced by dee872e124e8.   Nevertheless,
> as the dee872e124e8 also has the Fixes tag, I think your suggestion makes

s/dee872e124e8 also has /c446fdacb10d also has /

Sorry if it made anyone be confused.


Thanks,
SJ

[...]
