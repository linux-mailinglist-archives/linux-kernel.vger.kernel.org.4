Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848FC670F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjARBEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjARBEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:04:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059E525E1E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:53:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 959A161522
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BA9C433EF;
        Wed, 18 Jan 2023 00:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674003208;
        bh=ary+9552ah5LGVChJJNw8Obqv4gXSKvJjJzUVjV41Hk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DuDxXZncADwgu7ph/GJbx45iDZy0snE57MUkWC60vBH3qy1xfB40sbJrZesdOEky3
         nlqobOzmJ4IVoyMCBTp1eVBYcyfQ9VoM+Fuk6DKBuLN4hZr//d6fXDqRg08N9CO4a4
         0hP5p2Z/Z2HAlHt55/bxmxP5Hb7pnYkHKgWFRs70=
Date:   Tue, 17 Jan 2023 16:53:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Herton R. Krzesinski" <herton@redhat.com>
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, jforbes@redhat.com,
        dzickus@redhat.com, scweaver@redhat.com
Subject: Re: [PATCH] tools/vm: allow users to provide additional
 cflags/ldflags
Message-Id: <20230117165326.3e693a12a45a1962ca0c40af@linux-foundation.org>
In-Reply-To: <20230116224921.4106324-1-herton@redhat.com>
References: <20230116224921.4106324-1-herton@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 19:49:21 -0300 "Herton R. Krzesinski" <herton@redhat.com> wrote:

> Right now there is no way to provide additional cflags/ldflags when
> building tools/vm binaries. And using eg. make CFLAGS=<options> will
> override the CFLAGS being set in the Makefile, making the build fail
> since it requires the include of the ../lib dir (for libapi).
> 
> This change then allows you to specify:
> CFLAGS=<options> LDFLAGS=<options> make V=1 -C tools/vm
> 
> And the options will be correctly appended as can be seen from the
> make output.
> 
> ...
>
> --- a/tools/vm/Makefile
> +++ b/tools/vm/Makefile
> @@ -8,8 +8,8 @@ TARGETS=page-types slabinfo page_owner_sort
>  LIB_DIR = ../lib/api
>  LIBS = $(LIB_DIR)/libapi.a
>  
> -CFLAGS = -Wall -Wextra -I../lib/
> -LDFLAGS = $(LIBS)
> +CFLAGS += -Wall -Wextra -I../lib/
> +LDFLAGS += $(LIBS)
>  

I think EXTRA_CFLAGS is more conventional?
