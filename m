Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D49872392D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjFFHjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjFFHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:39:47 -0400
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EB3106
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:39:44 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qb2Ry67wKzMpnwc;
        Tue,  6 Jun 2023 09:39:42 +0200 (CEST)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qb2Rx40x2zMpnPq;
        Tue,  6 Jun 2023 09:39:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1686037182;
        bh=onTta4zxo0KV8FXnJJ+OInrN8UxvhAaHFZ59RIsmfNQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GQai/YRhFBXDORxGP9qJQq+pkLNrelXG8jSLYrAykI1G8djZXzHNAQEjVMw7x2EGv
         TJFhvjQUORXr/QZSCBdXkIdXBS1FzoP02XnPvYn9ProLlCKy934elHSAGsBzAyH3JK
         r8hci6yT+sayaMvs/fgtZwo/byIW3c+txCh43B+0=
Message-ID: <86217436-e3aa-00b6-ec0e-947ac249db3a@digikod.net>
Date:   Tue, 6 Jun 2023 09:39:39 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: linux-next: build failure after merge of the landlock tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230606130236.4d339a46@canb.auug.org.au>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230606130236.4d339a46@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I only checked this branch with a previous kernel version. It is now 
fixed and pushed.

Thanks,
  Mickaël


On 06/06/2023 05:02, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the landlock tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> security/landlock/net.c:165:51: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__lsm_ro_after_init'
>    165 | static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>        |                                                   ^~~~~~~~~~~~~~~~~~~
> security/landlock/net.c: In function 'landlock_add_net_hooks':
> security/landlock/net.c:172:28: error: 'landlock_hooks' undeclared (first use in this function)
>    172 |         security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
>        |                            ^~~~~~~~~~~~~~
> security/landlock/net.c:172:28: note: each undeclared identifier is reported only once for each function it appears in
> In file included from include/linux/container_of.h:5,
>                   from include/linux/kernel.h:21,
>                   from include/linux/uio.h:8,
>                   from include/linux/socket.h:8,
>                   from include/uapi/linux/in.h:25,
>                   from include/linux/in.h:19,
>                   from security/landlock/net.c:9:
> include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
>     16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>        |                                                   ^
> include/linux/compiler.h:231:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>    231 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>        |                                 ^~~~~~~~~~~~~~~~~
> include/linux/kernel.h:56:59: note: in expansion of macro '__must_be_array'
>     56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>        |                                                           ^~~~~~~~~~~~~~~
> security/landlock/net.c:172:44: note: in expansion of macro 'ARRAY_SIZE'
>    172 |         security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
>        |                                            ^~~~~~~~~~
> security/landlock/net.c: At top level:
> security/landlock/net.c:157:12: warning: 'hook_socket_connect' defined but not used [-Wunused-function]
>    157 | static int hook_socket_connect(struct socket *const sock,
>        |            ^~~~~~~~~~~~~~~~~~~
> security/landlock/net.c:150:12: warning: 'hook_socket_bind' defined but not used [-Wunused-function]
>    150 | static int hook_socket_bind(struct socket *const sock,
>        |            ^~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>    6d0bfdb25ce6 ("landlock: Add network rules and TCP hooks support")
> 
> I have use the landlock tree from next-20230605 for today.
> 
