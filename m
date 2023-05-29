Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98D0714997
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjE2Mov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjE2Mor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A11AD;
        Mon, 29 May 2023 05:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FEBD61360;
        Mon, 29 May 2023 12:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CF1C433EF;
        Mon, 29 May 2023 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685364284;
        bh=ajuRnL6bE9DZhlolJ++MLwqSb9Q2TGkVGPr6Ts71Dg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VA8Krba+ytnf1eZJdew+FIgQT7Efb78lrxzuPaHxK5/h2pzu9XU5VL0vok+qaAnmC
         t6zceO9xi6nfEUZN8ED14frQFS1RmRAjs/msN4o1deg3RkyYx/XH3LteQVb4wLzkif
         xJtoNKDVADj4q9Gng4EHQ5pp/N5L5DAfCPecuLSAehc0JHBmI63YEsLamDsjGA2z85
         z0s46tJY1RLDW1KFbOMytaiNn7ileTI35ve7LsJCDDvUC3kqGxe+rdQq9Skn+ygzdS
         J1bsOdKKlRCRCqI4GBqMBe67oDkzrqVM6HlwAlLV+FXBPZsu/8AnhJOZDWwvI3Iwox
         RVJIMDaq/miMA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q3cEr-0000Uk-VR; Mon, 29 May 2023 14:44:42 +0200
Date:   Mon, 29 May 2023 14:44:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
 <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
 <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 07:00:05AM -0400, Linus Torvalds wrote:

> However, can I ask you to just verify that it was purely the exclusive
> open part, and it wasn't that I messed up something else. IOW, can you
> replace the
> 
>         return exclusive_deny_write_access(file);
> 
> in prepare_file_for_module_load() with just a "return 0", and remove the
> 
>                 allow_write_access(f.file);
> 
> line in finit_module()?
> 
> That's obviously _instead_ of the revert that I already pushed out,
> just to verify that "yup, it's that part, not something silly
> elsewhere"

Yes, those two changes are enough to make the problem go away.

> I do wonder what it is that is different in your setup, and maybe you
> could also enable the
> 
>         pr_debug("finit_module: fd=%d, uargs=%p, flags=%i\n", fd, uargs, flags);

Below is the corresponding output with a working kernel: 174 requests
for the 131 modules that end up being loaded (without the revert there
is only around 110 modules loaded).

There is some probe deferral and async probing going on during normal
boot which may be part of the explanation.

Johan

[    0.669112] finit_module: fd=3, uargs=00000000b461506c, flags=0
[    0.674144] finit_module: fd=4, uargs=00000000b461506c, flags=0
[    0.676783] finit_module: fd=5, uargs=00000000b461506c, flags=0
[    0.678920] finit_module: fd=3, uargs=00000000b461506c, flags=0
[    0.837967] finit_module: fd=5, uargs=0000000000157d9f, flags=0
[    0.839414] finit_module: fd=3, uargs=00000000b461506c, flags=0
[    0.844129] finit_module: fd=4, uargs=00000000b461506c, flags=0
[    0.845016] finit_module: fd=3, uargs=00000000b461506c, flags=0
[    0.849132] finit_module: fd=3, uargs=00000000b461506c, flags=0
[    0.849460] finit_module: fd=4, uargs=00000000b461506c, flags=0
[    3.345004] finit_module: fd=4, uargs=00000000e3e6c6d2, flags=0
[    3.364302] finit_module: fd=4, uargs=0000000095136ea7, flags=0
[    3.371928] finit_module: fd=5, uargs=0000000095136ea7, flags=0
[    4.099183] finit_module: fd=3, uargs=00000000ce2d6f3e, flags=0
[    4.103156] finit_module: fd=3, uargs=000000004e3e14c2, flags=0
[    4.713558] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.715608] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.717620] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.717910] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.719517] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.725862] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.726730] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.727018] finit_module: fd=14, uargs=00000000262da138, flags=0
[    4.730525] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.749602] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.749675] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.749678] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.774117] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.795307] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.797327] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.798405] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.799140] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.800850] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.807306] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.807313] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.807321] finit_module: fd=16, uargs=00000000262da138, flags=0
[    4.807394] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.807463] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.807525] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.807530] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.807590] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.811469] finit_module: fd=0, uargs=0000000080fab15b, flags=0
[    4.845851] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.845875] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.846282] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.846363] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.846363] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.846669] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.846994] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.847005] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.847194] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.847356] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.847448] finit_module: fd=17, uargs=00000000262da138, flags=0
[    4.847556] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.847651] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.848175] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.850005] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.850485] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.866031] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.866032] finit_module: fd=16, uargs=00000000262da138, flags=0
[    4.866381] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.866711] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.867757] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.868360] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.886043] finit_module: fd=16, uargs=00000000262da138, flags=0
[    4.886046] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.886046] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.886060] finit_module: fd=17, uargs=00000000262da138, flags=0
[    4.886114] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.886140] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.886326] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.886716] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.887210] finit_module: fd=16, uargs=00000000262da138, flags=0
[    4.887451] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.887811] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.887963] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.892066] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.896048] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.896070] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.896092] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.896157] finit_module: fd=18, uargs=00000000262da138, flags=0
[    4.896193] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.896211] finit_module: fd=18, uargs=00000000262da138, flags=0
[    4.896737] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.896751] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.897174] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.897343] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.897388] finit_module: fd=19, uargs=00000000262da138, flags=0
[    4.897555] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.897592] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.899657] finit_module: fd=16, uargs=00000000262da138, flags=0
[    4.899973] finit_module: fd=6, uargs=00000000262da138, flags=0
[    4.900316] finit_module: fd=17, uargs=00000000262da138, flags=0
[    4.901188] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.901668] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.901708] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.902030] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.903964] finit_module: fd=14, uargs=00000000262da138, flags=0
[    4.905243] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.907083] finit_module: fd=17, uargs=00000000262da138, flags=0
[    4.907480] finit_module: fd=16, uargs=00000000262da138, flags=0
[    4.907519] finit_module: fd=16, uargs=00000000262da138, flags=0
[    4.909481] finit_module: fd=13, uargs=00000000262da138, flags=0
[    4.911705] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.912056] finit_module: fd=18, uargs=00000000262da138, flags=0
[    4.912079] finit_module: fd=15, uargs=00000000262da138, flags=0
[    4.915340] finit_module: fd=19, uargs=00000000262da138, flags=0
[    4.933199] finit_module: fd=16, uargs=00000000262da138, flags=0
[    4.933585] finit_module: fd=18, uargs=00000000262da138, flags=0
[    4.935169] finit_module: fd=20, uargs=00000000262da138, flags=0
[    4.956021] finit_module: fd=19, uargs=00000000262da138, flags=0
[    4.956797] finit_module: fd=16, uargs=00000000262da138, flags=0
[    4.959865] finit_module: fd=17, uargs=00000000262da138, flags=0
[    4.964171] finit_module: fd=17, uargs=00000000262da138, flags=0
[    4.977073] finit_module: fd=18, uargs=00000000262da138, flags=0
[    4.980167] finit_module: fd=18, uargs=00000000262da138, flags=0
[    5.043379] finit_module: fd=6, uargs=00000000262da138, flags=0
[    5.053709] finit_module: fd=6, uargs=00000000262da138, flags=0
[    5.131232] finit_module: fd=15, uargs=00000000262da138, flags=0
[    5.140785] finit_module: fd=19, uargs=00000000262da138, flags=0
[    5.186244] finit_module: fd=18, uargs=00000000262da138, flags=0
[    5.186247] finit_module: fd=6, uargs=00000000262da138, flags=0
[    5.186252] finit_module: fd=6, uargs=00000000262da138, flags=0
[    5.186451] finit_module: fd=15, uargs=00000000262da138, flags=0
[    5.186507] finit_module: fd=13, uargs=00000000262da138, flags=0
[    5.187345] finit_module: fd=6, uargs=00000000262da138, flags=0
[    5.190282] finit_module: fd=15, uargs=00000000262da138, flags=0
[    5.195744] finit_module: fd=13, uargs=00000000262da138, flags=0
[    5.198242] finit_module: fd=16, uargs=00000000262da138, flags=0
[    5.198271] finit_module: fd=20, uargs=00000000262da138, flags=0
[    5.222394] finit_module: fd=6, uargs=00000000262da138, flags=0
[    5.222395] finit_module: fd=6, uargs=00000000262da138, flags=0
[    5.222407] finit_module: fd=16, uargs=00000000262da138, flags=0
[    5.222430] finit_module: fd=21, uargs=00000000262da138, flags=0
[    5.222432] finit_module: fd=16, uargs=00000000262da138, flags=0
[    5.222443] finit_module: fd=15, uargs=00000000262da138, flags=0
[    5.229650] finit_module: fd=22, uargs=00000000262da138, flags=0
[    5.257981] finit_module: fd=6, uargs=00000000262da138, flags=0
[    5.313560] finit_module: fd=6, uargs=00000000262da138, flags=0
[    6.144316] finit_module: fd=6, uargs=00000000262da138, flags=0
[    6.178956] finit_module: fd=6, uargs=00000000262da138, flags=0
[    6.178961] finit_module: fd=6, uargs=00000000262da138, flags=0
[    6.182057] finit_module: fd=13, uargs=00000000262da138, flags=0
[    6.182067] finit_module: fd=13, uargs=00000000262da138, flags=0
[    6.243708] finit_module: fd=0, uargs=00000000f9e4f67e, flags=0
[    6.249397] finit_module: fd=0, uargs=000000001b26db10, flags=0
[    6.249904] finit_module: fd=1, uargs=000000001b26db10, flags=0
[    6.250626] finit_module: fd=2, uargs=000000001b26db10, flags=0
[    6.251515] finit_module: fd=3, uargs=000000001b26db10, flags=0
[    6.254112] finit_module: fd=4, uargs=000000001b26db10, flags=0
[    6.255129] finit_module: fd=6, uargs=00000000262da138, flags=0
[    6.255504] finit_module: fd=6, uargs=00000000262da138, flags=0
[    6.259256] finit_module: fd=0, uargs=00000000e1b6cfe4, flags=0
[    6.264136] finit_module: fd=0, uargs=000000004070418f, flags=0
[    6.265227] finit_module: fd=1, uargs=000000004070418f, flags=0
[    6.270175] finit_module: fd=0, uargs=0000000092757077, flags=0
[    6.271230] finit_module: fd=1, uargs=0000000092757077, flags=0
[    6.322960] finit_module: fd=3, uargs=00000000fb904223, flags=0
[    6.373125] finit_module: fd=0, uargs=00000000e2cdc73f, flags=0
[    6.380061] finit_module: fd=0, uargs=000000000591e4e9, flags=0
[    6.392296] finit_module: fd=0, uargs=0000000088d2796a, flags=0
[    6.464595] finit_module: fd=0, uargs=000000001aa8b42e, flags=0
[    6.479839] finit_module: fd=0, uargs=00000000de50a030, flags=0
[    6.488790] finit_module: fd=0, uargs=00000000cbcb6a65, flags=0
[    6.492573] finit_module: fd=1, uargs=00000000cbcb6a65, flags=0
[    6.514903] finit_module: fd=0, uargs=000000006f393376, flags=0
[    7.989970] finit_module: fd=0, uargs=00000000c4594f52, flags=0
[   11.492886] finit_module: fd=13, uargs=00000000262da138, flags=0
[   11.639532] finit_module: fd=6, uargs=00000000262da138, flags=0
[   11.640048] finit_module: fd=6, uargs=00000000262da138, flags=0
[   11.640997] finit_module: fd=15, uargs=00000000262da138, flags=0
[   11.641049] finit_module: fd=6, uargs=00000000262da138, flags=0
[   11.775051] finit_module: fd=6, uargs=00000000262da138, flags=0
[   11.776806] finit_module: fd=6, uargs=00000000262da138, flags=0
