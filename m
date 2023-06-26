Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B747373D8B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjFZHm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjFZHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:42:56 -0400
Received: from out0-203.mail.aliyun.com (out0-203.mail.aliyun.com [140.205.0.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD1B2;
        Mon, 26 Jun 2023 00:42:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.Te0ogFC_1687765365;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.Te0ogFC_1687765365)
          by smtp.aliyun-inc.com;
          Mon, 26 Jun 2023 15:42:46 +0800
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Qingsong Chen" <changxian.cqs@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        <rust-for-linux@vger.kernel.org>
Subject: [PATCH 0/1] Fix redefine const_name in `vtable` macro
Date:   Mon, 26 Jun 2023 15:42:41 +0800
Message-Id: <20230626074242.3945398-1-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When using the `vtable` macro, I may find a problem.
If we define same function name in a trait (using `#[cfg]`),
the `vtable` macro will redefine `gen_const_name` for it, for
example:
```rust
    #[vtable]
    pub trait Foo {
        #[cfg(CONFIG_X)]
        fn bar();

        #[cfg(not(CONFIG_X))]
        fn bar(x: usize);
    }
```
This will define `HAS_BAR` twice. So I try to fix this by
using `HashSet`.

Qingsong Chen (1):
  rust: macros: fix redefine const_name in `vtable`

 rust/macros/vtable.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.40.1

