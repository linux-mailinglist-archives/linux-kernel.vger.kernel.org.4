Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB4702ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbjEOKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbjEOKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE7187;
        Mon, 15 May 2023 03:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 608CA611F3;
        Mon, 15 May 2023 10:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5E8C433D2;
        Mon, 15 May 2023 10:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684147734;
        bh=GMNZQGOM7OSk9SMRxPFbPrzw+HMjjcK+CNPMsFGAKCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mw/l9ln6He8vMUNGmGMX/QlUn71yBZBMFO4zTC8FhnL6zFl55lRO4lBeJsEk+tw0Q
         b6yz4tRVCy+a5PY3AzkSIiYjKfwPuH5amOAstRRsLxcpUy+ca4TeK8haLpKfyJEgv6
         /cu5yP54pKm5KfT2MLnqT/Y5t4Drn75/G6wRZq+Jg5zMW1Ns3lS1hYcRpYAszzndLn
         m10AhCLBvK+rGIFfMtU4AV5fhsO+okzW5Jd1Px6XtSS5kTKb4MJIuLAW0hvJDNXy3V
         yLJRB10r7EE8ftyGGmvr3Am6NcbmDMwBtwQzpthkUsXQJX10ttw6QKqfu3oCVLplsh
         9ySJDGvXw9XpA==
From:   Christian Brauner <brauner@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Fabian Frederick <fabf@skynet.be>,
        Nick Desaulniers <ndesaulniers@google.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Tim Gardner <tim.gardner@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Ron Economos <re@w6rz.net>,
        Nathan Chancellor <nathan@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] jffs2: reduce stack usage in jffs2_build_xattr_subsystem()
Date:   Mon, 15 May 2023 12:46:50 +0200
Message-Id: <20230515-sinnbild-boten-fa2d5510a52c@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230506045612.16616-1-ansuelsmth@gmail.com>
References: <20230506045612.16616-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=800; i=brauner@kernel.org; h=from:subject:message-id; bh=RW8BK9FlWjXjDRheFHaERdpy80bDkJQX/aatmJS8jy0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQk8U7Z+vRO/vOf6864nTnvkdIUFy3sOyklLylUcHXd8Wb7 x1cPd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkygGG/7mn8xYI3VxXGrjlzVm5jA e7ly3ye6dl9+Kky/+LeydxnY5l+GfYsPelreH3r7u37/zy0kbjgTTbEdUIPRXXdTtnMke/V+YEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

On Sat, 06 May 2023 06:56:12 +0200, Christian Marangi wrote:
> Use kcalloc() for allocation/flush of 128 pointers table to
> reduce stack usage.
> 
> Function now returns -ENOMEM or 0 on success.
> 
> stackusage
> Before:
> ./fs/jffs2/xattr.c:775  jffs2_build_xattr_subsystem     1208
> dynamic,bounded
> 
> [...]

I assume I was Cced to pick this up. I'm happy to do that. If this is
rather supposed to go through the jffs2 tree then please tell me so we
can drop it.

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] jffs2: reduce stack usage in jffs2_build_xattr_subsystem()
      https://git.kernel.org/vfs/vfs/c/493e7cebb906
