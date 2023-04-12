Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE166DE87B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 02:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDLAYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 20:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDLAYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 20:24:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA62BC;
        Tue, 11 Apr 2023 17:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C9A623FB;
        Wed, 12 Apr 2023 00:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0641C433EF;
        Wed, 12 Apr 2023 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681259049;
        bh=nJI8/B7eg9JVcOqRr7nH0nG3Zqh+Z58VIDLD98553HI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uFf8tLrIjK/gPzPxin8KfK7izbWHwWmbLJcPv+9w8re77Qp3yiVXrtD0cZasJQOEc
         AwjDUqiU+QjVKO9nI/uJCsD6XB+Bw8yKLPPWQEtfKYJKI+GQu805KFyY+0eMX8uFzB
         jXTGpmajcgpEh9YND8KhTdBnTy4OZKks3Wft3B5Q=
Date:   Tue, 11 Apr 2023 17:24:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
Subject: Re: [PATCH RESEND] uapi/linux/const.h: Prefer ISO-friendly
 __typeof__
Message-Id: <20230411172408.46a5b13a6cab27dda0c822b2@linux-foundation.org>
In-Reply-To: <20230411213946.GA1803920@pevik>
References: <20230411092747.3759032-1-kevin.brodsky@arm.com>
        <20230411210537.GA1800481@pevik>
        <20230411213946.GA1803920@pevik>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 23:39:46 +0200 Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Kevin,
> 
> > > typeof is (still) a GNU extension, which means that it cannot be
> > > used when building ISO C (e.g. -std=c99). It should therefore be
> > > avoided in uapi headers in favour of the ISO-friendly __typeof__.
> 
> > IMHO UAPI are built with -std=c90 -Wall -Werror=implicit-function-declaration
> > (see usr/include/Makefile).
> > But one or the other, you're right both require __typeof__.
> 
> > "If you are writing a header file that must work when included in ISO C
> > programs, write __typeof__ instead of typeof."
> > https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gcc/Typeof.html
> 
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> IMHO problem was introduced when -std=c90 was added (back then the code was in
> include/uapi/linux/kernel.h).

Well...  what actually _is_ the problem?  Presumably build issues under
some circumstances.  Could we please see an instance of those issues
and a description of the circumstances under which they occur?

> Fixes: d6fc9fcbaa65 ("kbuild: compile-test exported headers to ensure they are self-contained")

Might need a cc:stable, depending on the answers to the above.

