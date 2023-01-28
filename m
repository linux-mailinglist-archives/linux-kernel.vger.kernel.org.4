Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1674A67F578
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjA1HXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjA1HXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:23:52 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732C184B52;
        Fri, 27 Jan 2023 23:23:51 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id s4so5498303qvo.3;
        Fri, 27 Jan 2023 23:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RqIuOAJfWaI450W/eJA3tDavvJhghC8zj9Uru84Ultk=;
        b=HwRKDpSsFMLBT/V0/RXO3OHMiokgbfdIKxgGJo7RVlWZ/JbBTWqFETvZaKS+5z4a5D
         XSepLviTEMd6q42mspHg+LSgLXxjLfUrNeNkHWn13nfS3UjXQrE7vryimN0aYaSdyaAO
         E7iFBrmmZigbTc6wLC1Esx2oAd1FipW1wXYeLnrgQ7t4ng86StVjHt0kqYQzKNDBWPpK
         ByRVvdIRWW3ZqFjhxuM7PLjY+7l9btPCkEHKB4HewBAJ4/E7U/DKiqaEyBBcxmkPvj1P
         suV6F7VurOU5LJUp9ZJ/tAoKEbYq8/UT3vbhCP7VElXOsMCDyaB/fLlXa4ymtMj1H+jQ
         X+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqIuOAJfWaI450W/eJA3tDavvJhghC8zj9Uru84Ultk=;
        b=tRVCK80oJpZBYGSriA85x8ZazMtm2SV0mze4nVM+3GxBs76Hk1jgtQfvC79USN2YAg
         mwFPkg7oONgcJ/xK24U+p9C0J8Q+Cw3WxBce4ksT1WpMWOsO/quPs7t7U3L318e4oyQX
         sdot9HmUmSxfKh5mF25NE9yC1Ja9sAJ3cQiYad/1t2YSJrB6Q/66VpB+bvtvMi+FSai2
         kSVWRHLJjiqv87MH/8Nqy+i8sBDSCfLtdRsaNWckDCW+3Lm7EtMZp3NTbqkzETzppPYB
         LqK6FahvCIKYC4397cZ5JcI8Ru5isN4a2hEvOCWlF1LG5wDhdD+ppDPjcOOptPyjmtIo
         AX7Q==
X-Gm-Message-State: AO0yUKWqLumgBO1DUFR6+QeR7dF33Gv+5WoyvFxjomuXhBOvrSYGrqpv
        lFV5kR51U0fBXQTKwXVlFPo=
X-Google-Smtp-Source: AK7set+Am6Q5hW4Tu69Ot5/9Ko0s7FcOhN7hBMGyieLfb1J/xTfgPlHRatR6vTyi2tFlCc7zPz4hCw==
X-Received: by 2002:a0c:80eb:0:b0:538:861f:cfdd with SMTP id 98-20020a0c80eb000000b00538861fcfddmr7217331qvb.43.1674890630578;
        Fri, 27 Jan 2023 23:23:50 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 137-20020a37088f000000b0071aacb2c76asm1282180qki.132.2023.01.27.23.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 23:23:49 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 67D9027C0054;
        Sat, 28 Jan 2023 02:23:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 28 Jan 2023 02:23:49 -0500
X-ME-Sender: <xms:hM3UY7fbgbjSKkd3AgzhrVY44tcpG4Wjo6kLPpz1v0bVR2Vsel1qEQ>
    <xme:hM3UYxMTW8FG_R0RVzvRW9EfrBYyWg_ABNoyhQBul7llQNPG65qkgLrvIxT83jKau
    bqcz3EAfeC8rfZayQ>
X-ME-Received: <xmr:hM3UY0iJzi0PqZwd9jlOArsV5NBOEept5R5SEhKRZK-L3KUZPsnWzQjVZVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehieegfeeiudeuhfejteeftdeijefhfeeggfevkedttdefteffhfetveek
    teetveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdiiuhhlihhptghhrghtrdgtoh
    hmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgr
    ihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:hM3UY8-PilMvqrVH0OvVS3tyBe3ojnR1EB2Ca2uPEx_iLe9oMznLSA>
    <xmx:hM3UY3v5SmCF1kFh26kXlkdOG5RQiCHOfY3QA1ZQpYA6k42whRkr4Q>
    <xmx:hM3UY7FXW4Rs8oVZtS0ZfC1U3y9IFxWsLUm3AXdi3xqnVPO_sqFWkg>
    <xmx:hM3UYw-IS4U6nNlPvhyH3c12EvWdkyqzP3TglsbXDX2J-TX-BhlivQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jan 2023 02:23:48 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: MAINTAINERS: Add the zulip link
Date:   Fri, 27 Jan 2023 23:22:49 -0800
Message-Id: <20230128072258.3384037-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zulip organization "rust-for-linux" has been created since about 2 years
ago[1], and proven to be a great place for Rust related discussion,
therefore add the information in MAINTAINERS file so that newcomers have
more options to find guide and help.

[1]: https://lore.kernel.org/rust-for-linux/CANiq72=xVaMQkgCA9rspjV8bhWDGqAn4x78B0_4U1WBJYj1PiA@mail.gmail.com/

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
v1 -> v2:

	* 	As suggested by Greg KH, add commit message.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd..30161207f365 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18219,6 +18219,7 @@ R:	Boqun Feng <boqun.feng@gmail.com>
 R:	Gary Guo <gary@garyguo.net>
 R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
 L:	rust-for-linux@vger.kernel.org
+C:	zulip://rust-for-linux.zulipchat.com
 S:	Supported
 W:	https://github.com/Rust-for-Linux/linux
 B:	https://github.com/Rust-for-Linux/linux/issues
-- 
2.39.1

