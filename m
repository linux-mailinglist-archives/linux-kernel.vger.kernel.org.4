Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F05171FC1F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjFBIck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjFBIci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370FA19A;
        Fri,  2 Jun 2023 01:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FED761217;
        Fri,  2 Jun 2023 08:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0291C433D2;
        Fri,  2 Jun 2023 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685694754;
        bh=O7TqdfyAtIN/OKXfWWIpEUScYv0G8D6pOkXTITBOizU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDDDowdlhWAnoUdB2/pDoQMI+SUZ8LQYLHhVh3NXqgCIsxH1BhkHGGQ6rBAsCYCPq
         XdH13ylXGv3eYVnMDRVZHIMMMaiD/poC88theBcvLyJyRdjewdQUUYTEoxSxQuF0v6
         +bvILaER6ZvTtBoZXxXhjy7un1+IVAn79i9QleBZ35nU0Y+VHiKTcy1sqbnTR4w+zJ
         0NXRDGNSEuEvtmIMq/bGye/3cppYA69pjTIYCOoTPfojIVbYJl5avokiy0dG2AOSvs
         r1vhqOiedfWW66O0WcgG0L1lZbPvmkZE227IbdqaxNZ7wLsYtIbaK1DzJftLmodb7h
         CZA5rKYJAkM9w==
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        jfs-discussion@lists.sourceforge.net,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>
Subject: Re: [PATCH] jfs: Use unsigned variable for length calculations
Date:   Fri,  2 Jun 2023 10:32:20 +0200
Message-Id: <20230602-unnahbar-halbmarathon-22e48883e051@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230204183355.never.877-kees@kernel.org>
References: <20230204183355.never.877-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=brauner@kernel.org; h=from:subject:message-id; bh=O7TqdfyAtIN/OKXfWWIpEUScYv0G8D6pOkXTITBOizU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRUrjhol/uaefLb1w8TLdJfZ7M42EQUeQh4NcZMN0qZceDs lqp5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxZGT473RKqTKhR2uiukm0sEX2pL crY7dYGP9LXOc7eXmpdtH7OIZ/alW5LJc3L73861LYFaNGNgUtsUfsaQ5GzlaqnS0q7OWMAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Feb 2023 10:33:56 -0800, Kees Cook wrote:
> To avoid confusing the compiler about possible negative sizes, switch
> "ssize" which can never be negative from int to u32.  Seen with GCC 13:
> 
> ../fs/jfs/namei.c: In function 'jfs_symlink': ../include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between offset 0 and size [-2147483648, -1]
> [-Warray-bounds=]
>    57 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ...
> ../fs/jfs/namei.c:950:17: note: in expansion of macro 'memcpy'
>   950 |                 memcpy(ip->i_link, name, ssize);
>       |                 ^~~~~~
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] jfs: Use unsigned variable for length calculations
      https://git.kernel.org/vfs/vfs/c/2d6e1895d440
