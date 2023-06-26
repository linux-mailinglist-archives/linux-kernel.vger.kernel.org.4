Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB773ECDC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjFZV1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjFZV1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:27:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A1D1702;
        Mon, 26 Jun 2023 14:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DAE160EB2;
        Mon, 26 Jun 2023 21:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EAFC433C0;
        Mon, 26 Jun 2023 21:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687814856;
        bh=cD+DlgssDHp9bWUfoAqdwHPtpJlWEj+4Ut4kvVblUg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ljNIZ97KtuHOBzk+gfTMQAonQtKrXqmArEvp6gf6th8U9snAirn5HZDr1pg39P5AM
         38gQsvUyYJlV3jRaJ6kdS4HMZqqEbbjpqCwKDqWHdOiJQ00c6CDF3KnUyl1a+uCfIT
         +xjUvT7wagBbCIUxOr1Ysw1TFcb4kRMdstAYOVJmeh1c2aJ1ajmTMXLray5ohrZA1k
         TGJKSOFKLXOkfZHHSsu2DT8/xHwyfZDfAaRIj4k7jAwNPPrkoK47wsuRy8FgpA5QG0
         MiMilxWpzVqMxN+muUL8m1ErVMR7jUvIEziUej63OU+jBJM+NfvkJEhv2s1qez5gY8
         SzPCGc2kupEtQ==
Date:   Mon, 26 Jun 2023 14:27:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        dhowells@redhat.com, acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        davem@davemloft.net, irogers@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, sfr@canb.auug.org.au
Subject: Re: [PATCH net-next] perf trace: fix MSG_SPLICE_PAGES build error
Message-ID: <20230626142734.0fa4fa68@kernel.org>
In-Reply-To: <20230626090239.899672-1-matthieu.baerts@tessares.net>
References: <2947430.1687765706@warthog.procyon.org.uk>
        <20230626090239.899672-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 11:02:39 +0200 Matthieu Baerts wrote:
> Our MPTCP CI and Stephen got this error:
> 
>     In file included from builtin-trace.c:907:
>     trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags':
>     trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (first use in this function)
>        28 |         if (flags & MSG_##n) {           |                     ^~~~
>     trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
>        50 |         P_MSG_FLAG(SPLICE_PAGES);
>           |         ^~~~~~~~~~
>     trace/beauty/msg_flags.c:28:21: note: each undeclared identifier is reported only once for each function it appears in
>        28 |         if (flags & MSG_##n) {           |                     ^~~~
>     trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
>        50 |         P_MSG_FLAG(SPLICE_PAGES);
>           |         ^~~~~~~~~~
> 
> The fix is similar to what was done with MSG_FASTOPEN: the new macro is
> defined if it is not defined in the system headers.
> 
> Fixes: b848b26c6672 ("net: Kill MSG_SENDPAGE_NOTLAST")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/r/20230626112847.2ef3d422@canb.auug.org.au/
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> 
> Notes:
>     @David: I solved it like that in MPTCP tree. Does it work for you too?
> 
>     I guess tools/perf/trace/beauty/include/linux/socket.h file still needs
>     to be updated, not just to add MSG_SPLICE_PAGES but also other
>     modifications done in this file. Maybe best to sync with Arnaldo because
>     he might do it soon during the coming merge window I guess.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Arnaldo, are you okay with us taking this into the networking tree?
Or do you prefer to sync the header after everything lands in Linus's
tree?
