Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF11074016A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjF0Qh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjF0Qhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC3B97;
        Tue, 27 Jun 2023 09:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43080611E2;
        Tue, 27 Jun 2023 16:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C08C433C8;
        Tue, 27 Jun 2023 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687883872;
        bh=r1Zn6rFZGv2qCvkWHTzQxNdBye9pe1D7vb/SPlI/qbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4sU5FTF50gx4fEW/KwomVCXzjlQ0STh011IYkVtvtkf/gW6FaqcH8Fpjp0t9yo3a
         WZ7nQB8HeKw5NPArG9XUsJv+8LcFaW7UwizPmu1X468YnnvlTXwjpHXG5Zm4tDSqtE
         0lE5l3zYl98koHR0IET+i9SoEAF916ruVeS4I/tPNwigdvOlOE9Wg4FGX/5UF2DBwj
         lPV9MXmtvk/hx5VtCvvJ1lkmFoOyzPC3/Au45/E/uESULHcSTgnxfVo76Jo8WejzfA
         3jb5jEfpALpNNRVZKOLY29z/cyF+BWAHjneLc4fFzGVmV0aYCvtyd9nGouPEvSnRIP
         mx5CQucrlwWnw==
From:   SeongJae Park <sj@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, martin.lau@linux.dev,
        ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Egorenkov <Alexander.Egorenkov@ibm.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] btf: warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date:   Tue, 27 Jun 2023 16:37:50 +0000
Message-Id: <20230627163750.81178-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZJsMVxGVCJoF19wQ@krava>
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

Hi Jiri,

On Tue, 27 Jun 2023 18:20:39 +0200 Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Jun 26, 2023 at 06:11:20PM +0000, SeongJae Park wrote:
> > __register_btf_kfunc_id_set() assumes .BTF to be part of the module's
> > .ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
> > the function prints an error message and return an error.  As a result,
> > such modules cannot be loaded.
> > 
> > However, the section could be stripped out during a build process.  It
> > would be better to let the modules loaded, because their basic
> > functionalities have no problem[1], though the BTF functionalities will
> > not be supported.  Make the function to lower the level of the message
> > from error to warn, and return no error.
> > 
> > [1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> > 
> > Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
> > Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
> > Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> > Fixes: dee872e124e8 ("bpf: Populate kfunc BTF ID sets in struct btf")
> 
> should it be this one in Fixes instead?
>   c446fdacb10d bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF

The commit c446fdacb10d was trying to fix commit dee872e124e8, which this patch
is claiming to fix, by relaxing the check.  Nevertheless, it seems the check
need to further relaxed, and therefore I wrote this patch.

For the reason, I was thinking this patch is directly fixing c446fdacb10d, but
is also fixing a problem originally introduced by dee872e124e8.   Nevertheless,
as the dee872e124e8 also has the Fixes tag, I think your suggestion makes
sense. 

I will fix so in the next spin.

> 
> other than that looks good
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thank you, I will also add this to the next version of this patch :)


Thanks,
SJ

> 
> jirka
> 
> > Cc: <stable@vger.kernel.org> # 5.17.x
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  kernel/bpf/btf.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 6b682b8e4b50..d683f034996f 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7848,14 +7848,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
> >  
> >  	btf = btf_get_module_btf(kset->owner);
> >  	if (!btf) {
> > -		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> > -			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
> > -			return -ENOENT;
> > -		}
> > -		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
> > -			pr_err("missing module BTF, cannot register kfuncs\n");
> > -			return -ENOENT;
> > -		}
> > +		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> > +			pr_warn("missing vmlinux BTF, cannot register kfuncs\n");
> > +		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> > +			pr_warn("missing module BTF, cannot register kfuncs\n");
> >  		return 0;
> >  	}
> >  	if (IS_ERR(btf))
> > -- 
> > 2.25.1
> > 
> > 
