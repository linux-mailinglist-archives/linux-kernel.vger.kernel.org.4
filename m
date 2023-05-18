Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21AA7084A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjERPIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjERPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:08:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6749EE53;
        Thu, 18 May 2023 08:07:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D78DD60A52;
        Thu, 18 May 2023 15:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EA7C433D2;
        Thu, 18 May 2023 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684422438;
        bh=f3/XO3tDI8cfHGYDZ0syLZXznG3gRLsg5/8oiovlAlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b65lab1T8wpBHsy2Y2smM1BJXot5gzW8RwUxtLcHJyIfcPxEysEJI+woubyBe90gs
         +XiCFESETIjIRwBeWGduHLQSG1nrx085/0mLgSYGcWjDrrAySFMKCDa7AlRxpboSVq
         gfH3CS9NSm6DGntlsY/qqcFNPfd4OiX65b14GW4Rb7LmQ3aUsdvPuzXLVqbSZWuuZr
         IRtsm4M9qWx9sQqQGoY/0e9plL3+1ndFC1xDDzTGULk0mVhdJdyxdSKN3OlOGnMPv9
         cTxFBr1O4pEw6Cdb8XImH+RJ7YrXjGJpH9WXIi7dyBFMsRLGv4UDWBwZnQSB2ogW4y
         biwzmuuk0yEyg==
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pid: Replace struct pid 1-element array with flex-array
Date:   Thu, 18 May 2023 17:07:09 +0200
Message-Id: <20230518-jemand-ehrte-80f8b538ca03@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517225838.never.965-kees@kernel.org>
References: <20230517225838.never.965-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=brauner@kernel.org; h=from:subject:message-id; bh=f3/XO3tDI8cfHGYDZ0syLZXznG3gRLsg5/8oiovlAlw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSk2UuULTvN+XNF2oQSr7aEYzY9bm0XHnYe4+Tye++5zmyn ndHKjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcf83IsCf40+eqLNN7t5y72fU/+1 azxSY8+cmelWG46peyTc4VA4b/KVyL91a/ermM+4cOY5eF9Pzzj9QU7TVPpph5HNq5RK6EEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 15:58:42 -0700, Kees Cook wrote:
> For pid namespaces, struct pid uses a dynamically sized array member,
> "numbers". This was implemented using the ancient 1-element fake flexible
> array, which has been deprecated for decades. Replace it with a C99
> flexible array, refactor the array size calculations to use struct_size(),
> and address elements via indexes. Note that the static initializer (which
> defines a single element) works as-is, and requires no special handling.
> 
> [...]

Applied to the kernel.fork branch of the brauner/linux.git tree.
Patches in the kernel.fork branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
branch: kernel.fork

[1/1] pid: Replace struct pid 1-element array with flex-array
      https://git.kernel.org/brauner/linux/c/ad0ff58dc959
