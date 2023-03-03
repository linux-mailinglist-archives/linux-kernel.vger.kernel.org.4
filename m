Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4BA6AA106
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCCVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjCCVWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:22:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF2C5FEAB;
        Fri,  3 Mar 2023 13:22:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DD64618E8;
        Fri,  3 Mar 2023 21:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDA1C433D2;
        Fri,  3 Mar 2023 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677878539;
        bh=gJXGjh0DckWXjiaLEYJJpfg+bNVZ1df2iQhk0M2idtc=;
        h=From:To:Cc:Subject:Date:From;
        b=kBJpYQOsJhvwyGlUGsycf0ueGdMXeZypXvmTxYLkxxRUrQ/x65744wGBRYb3nRgzQ
         IBMj7vsymxz1sMzw4FgsxeFfVZF90qh4h3dLNENguZI/Nj9rnB9XQJ9IahIVhR8xdg
         ItELEBUVIYut9NCzVoPz+qFRQrr69DG/SR8hLoD/6m2MvZy7jTHBDKvl8JJtsaaz/e
         or0oc7ycAoE6Ykr7n6aFC3vwAoUHBp5+8Sc9uVZ2GP9mV+HfGHhqAfbqh2VxRILwb7
         W4OuQJVCGRDdDKYQbS9u76yL1DkNxLWw4IQnwGe4HfQHHTNhZYHqH6YlPQN6opJCCa
         LO4GNxWBW4pSg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust fixes for 6.3-rc1
Date:   Fri,  3 Mar 2023 22:21:05 +0100
Message-Id: <20230303212105.78945-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this build error fix for Rust: there was a change during
the merge window to a C header parsed by the Rust bindings generator,
introducing a type that it does not handle well. The fix tells
the generator to treat the type as opaque (for now).

It has been only a day on linux-next, but it is straightforward and
it would be nice to have in v6.3-rc1.

I have other fixes planned for this cycle, but I will let those sit
in linux-next for a while and send them after v6.3-rc1.

No conflicts expected. No changes to the C side.

Cheers,
Miguel

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

  Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux tags/rust-fixes-6.3-rc1

for you to fetch changes up to 3098cb655e7c9ea1c2919e61234f63ebaab6bb21:

  rust: bindgen: Add `alt_instr` as opaque type (2023-03-02 22:44:15 +0100)

----------------------------------------------------------------
Rust fixes for 6.3-rc1

A single build error fix: there was a change during the merge window
to a C header parsed by the Rust bindings generator, introducing a
type that it does not handle well. The fix tells the generator to
treat the type as opaque (for now).

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      rust: bindgen: Add `alt_instr` as opaque type

 rust/bindgen_parameters | 1 +
 1 file changed, 1 insertion(+)
