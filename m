Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5BB73D640
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFZDUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFZDUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:20:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09B411C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A13660C72
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60E1C433C8;
        Mon, 26 Jun 2023 03:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687749638;
        bh=0j42pFaHzOUI6swjUOLjkgy+NNh2RUt8s6H5ez2k5IM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lgqx4Tr02Iw9n2yo+uU0QlSokM0TVEq9+ArAqcY9hQEFnVFq4ks++nrhAS3lR2TA5
         uu8czI9zAZg8kicW5bE+OlAFIaJWeudWIOR358LrAYgfnP/irTMaL2gn8aGxjV5jw8
         M3LXLctJ024YN17riX4Z9Chx+B7cg+0AtR7pqZKrLusTldNVnQwQinz+ZvE0qCYUyz
         hdSgm3sqlug63AAFT+bTkfnJPK2UFj3ut75xqqNnGaJiZnlrH474nw5PPkyc+O9pYU
         LdIsZOw4wDJZEnVWvVRmO22MWwH7oUfdg5/phrjwIDRCxdCUuApOfEA9WJwCWnyaFM
         i7bIbbup2JaxA==
Date:   Sun, 25 Jun 2023 20:20:36 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH] objtool: Make 'sec-address' always on
Message-ID: <20230626032036.m7vdthsguezm52wa@treble>
References: <e7e1de1d01194df3ff4053cb0815fc2ddba33213.1687360711.git.christophe.leroy@csgroup.eu>
 <202306241520.4jIgEhK4-lkp@intel.com>
 <2bd6c377-51ac-e2e2-6fcf-9c9b0f96f9cf@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bd6c377-51ac-e2e2-6fcf-9c9b0f96f9cf@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 08:30:48AM +0000, Christophe Leroy wrote:
> >>> vmlinux.o: warning: objtool: ibt_selftest+0x14 (.text+0x92b54): sibling call from callable instruction with modified stack frame
> >     vmlinux.o: warning: objtool: .altinstr_replacement+0x19a4: redundant UACCESS disable
> >     vmlinux.o: warning: objtool: iovec_from_user.part.0+0xb1 (.text+0x1c47761): call to copy_iovec_from_user.part.0() with UACCESS enabled
> >     vmlinux.o: warning: objtool: ibt_selftest+0x1e (.text+0x92b5e): return with modified stack frame
> > 
> 
> I can't really see any link between that warning and the changes in the 
> patch.

I suspect it's a pre-existing warning, but because the patch made a
change to the default formatting (adding .text+off), it looks like a new
warning to the bots.

-- 
Josh
