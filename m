Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030205F60D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJFFxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJFFxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:53:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570E8991B;
        Wed,  5 Oct 2022 22:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4916461840;
        Thu,  6 Oct 2022 05:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66948C433C1;
        Thu,  6 Oct 2022 05:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665035615;
        bh=N4/IurFsKjRB5Iw83ji87dyJdKBMr395ZfQkYKZjUqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KhXEYWz9x66Oj8Q8+BY6WR5SkhGdDqOjr5MH/1SrMs9vOSzuL+2vlKtNucg+Hrmxs
         uskw4JuEPsnMfWKBT+lQjxqWhoMBxtEGj8CPXfxoJXYDfMX+Op42Ub2USOGXdoSOSD
         mEg7jwnmoBjnb88T0/GPum271wYpkrgTP57KEt5ZLz88hoTwF8KDesR6NVBJjfct1W
         ON1wdXyv2AfW/ZQ4zYOAhi+QdSlNhjd86xd+5Bto+u+gRZDtd2yCT85h7jwCxhEp3b
         MGUYNT6rXqILEUTAo/OxDUo188LUTdlJkwOrDrqwcUgF4UOyoJyq5iDkpydeC3OG2l
         Eit2buuDSVpng==
Date:   Thu, 6 Oct 2022 06:53:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] docs: improve the HTML formatting of kerneldoc
 comments
Message-ID: <20221006065329.787c2592@sal.lan>
In-Reply-To: <87r0zmqkao.fsf@intel.com>
References: <20221004201222.281845-1-corbet@lwn.net>
        <20221004201222.281845-6-corbet@lwn.net>
        <87r0zmqkao.fsf@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 05 Oct 2022 19:58:39 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Tue, 04 Oct 2022, Jonathan Corbet <corbet@lwn.net> wrote:
> > Make a few changes to cause functions documented by kerneldoc to stand out
> > better in the rendered documentation.  Specifically, change kernel-doc to
> > put the description section into a ".. container::" section, then add a bit
> > of CSS to indent that section relative to the function prototype (or struct
> > or enum definition).  Tweak a few other CSS parameters while in the
> > neighborhood to improve the formatting.  
> 
> Way back I tried to keep the formatting changes minimal to avoid opening
> that particular can of worms along with the rest of the Sphinx
> transition.
> 
> But I do wonder if people find value in repeating e.g. the struct
> definitions in the documentation. I'd argue the rendered documentation
> is more for an overview, and if you need to know the exact details,
> you'll be in the editor typing code and you can look up the actual
> definition in source. Having the definition feels maybe a bit excessive.

I have split thoughts regards to it. The advantage of having the
struct definition there is to allow checking the type of each argument,
which is useful. It also provide a way to double-check if the parser
is dealing well with the argument, but, on the counter-side, the
type printed by kernel-doc may not be identical to what's inside the
Kernel, on some special cases, as the parse logic for arguments is
complex. The same applies on functions and macros.

> 
> We also don't use Sphinx C Domain's ".. c:member::" for struct/union
> members, 

I'm wondering how much extra build time this would impact ;-)
If the impact is not huge, I'm in favor of using it.

> or ".. c:enumerator::" for enumeration contants. 

This one can be more problematic, as it could break existing
cross-references.

> They provide arguably nicer rendering out of the box than our stuff.

Agreed.

> The Sphinx way to do parameter lists would be field lists i.e. ":param
> foo: description". Ditto for return values ":return: description". (Not
> saying we should convert the comments, but kernel-doc the script could
> emit those.)
> 
> Perhaps we'd be better off going towards Sphinx standard usage than
> tweaking our own thing?
> 
> I'm afraid I don't have the time to work on this. Talk is cheap and all
> that. My two cents.
> 
> Anyway, here are some examples how this might look like: [1].
> 
> 
> BR,
> Jani.
> 
> 
> 
> [1] https://hawkmoth.readthedocs.io/en/latest/examples.html

It reminds that we're currently lacking a  way to describe non-macro
#defines. In special for bit-based defines, it would be nice to have
a good way to document them, without needing to convert defines into 
enums.

Regards,
Mauro
