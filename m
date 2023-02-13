Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD24E69403F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBMJAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMJAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:00:01 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A926312F27;
        Mon, 13 Feb 2023 01:00:00 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k13so12880349plg.0;
        Mon, 13 Feb 2023 01:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wej9Hrr9YVNXu3teAuQFLMFoLkTxeSASEhn7aRIqa7U=;
        b=Y0DYL7Ubapofg+nO5tcqhEeIY9BNOxXgoX7zgmIzTFxmlOk6mdsmjk855/xjX9yyAp
         X8nmlZivBqDodVpWuwftpCSUUHi2H9S4YBpCl1aQ/pKEh1TlGCy4KJPOkbDc+p1V1OZS
         wJ3PwwFFm6uZT6q3GR+1Cbp4HLyyWpfKS377VqtXlMslowpBIDI2i+MRU/rWuutv9CCq
         ljLbYSJSuOgmMRHrIAKAfMfZzG2syewg2MOKSEciis0vCBnsJizZ+bsZLC5uXIhPkRH1
         LqWAru1j73I3qCTuRyCoJKmBw4GWWPLKbiprjQDfcY16ZqT5YJ/nJfMv/hpP8NL84fXX
         wbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wej9Hrr9YVNXu3teAuQFLMFoLkTxeSASEhn7aRIqa7U=;
        b=wA/KhE6BcqkyVLkJ4Ud1SOYq25tvxH9xY3OapTCffw6s0kcFAnSGrz+//mN3yU8/i8
         yvPHXnm/xmUzPA/GmWW/8ZwGxSlWUC4+Do4liDG6UwjH+Lt+RIxiOp2D6zyFBbJ2NW7T
         QkLwmWGtoQsIZTD97l1TIhtO51RWxKMsT/yACyUTrwPfQw/gXG9vur11SaR6X0gzqgXW
         VPmPDaBKsNcZF9/mi6nAixd4JIsdJDRMlDrEVQaGCnfBcBftxzegA9fv4z5FoHCI9ZiA
         GzZP6QrJm8M52ba9oitXrXaN8pwxAVP8iHdtvQzqndefyF49y+xnPALMTSMiSJxBcdgi
         gaVg==
X-Gm-Message-State: AO0yUKXlMpXLpZwbvkPK66U3k9uo2jGHxfGdtQXANSvHdd973xoi3/VN
        dIt/uD2tZrpt1Q5yzwr8fI+C+kyFD+M=
X-Google-Smtp-Source: AK7set8LiE+5F1EGzBvrLoycHNFT6v6S35SCchEhizXOEr2EQLN4u9urMCnfrGG1Q/XAXHht00lbaQ==
X-Received: by 2002:a17:902:d4d0:b0:19a:a516:ba2c with SMTP id o16-20020a170902d4d000b0019aa516ba2cmr1977788plg.0.1676278800124;
        Mon, 13 Feb 2023 01:00:00 -0800 (PST)
Received: from debian.me (subs02-180-214-232-87.three.co.id. [180.214.232.87])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902680900b0019337bf957dsm7630481plk.296.2023.02.13.00.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 00:59:59 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 34F29105492; Mon, 13 Feb 2023 15:59:55 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Rust for Linux Kernel <rust-for-linux@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= 
        <sergio.collado@gmail.com>, David Gow <davidgow@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Documentation: rust: Fix arch support table
Date:   Mon, 13 Feb 2023 15:59:20 +0700
Message-Id: <20230213085920.19726-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213152714.78b844f4@canb.auug.org.au>
References: <20230213152714.78b844f4@canb.auug.org.au>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=bagasdotme@gmail.com; h=from:subject; bh=2IF32IIw/YklMZSzQufE2cTuz0BNTTYTmxQTw5QfvfQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMkvfz9MrT3ztWvtVSdVQYE9cr9K4v70BX9hrWF5LnnxbrJ5 T0ZmRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbSP42R4YUS8/GFsvKny3+tEI/8rX y056rCqc7pWY/ufOw9/eqwLyvDX7F//xZ6d72ujLWzEv8a2P+e+8E6t+5bO+3TGa6mLHwvxwcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell reported htmldocs warning when merging uml tree:

Documentation/rust/arch-support.rst:20: WARNING: Blank line required after table.

Fix the arch support table by removing extraneous simple table marker.

Link: https://lore.kernel.org/linux-next/20230213152714.78b844f4@canb.auug.org.au/
Fixes: 0438aadfa69a34 ("rust: arch/um: Add support for CONFIG_RUST under x86_64 UML")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/rust/arch-support.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index a526ca1c688be6..ed7f4f5b3cf157 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -16,6 +16,6 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
 Architecture  Level of support  Constraints
 ============  ================  ==============================================
 ``x86``       Maintained        ``x86_64`` only.
-============  ================  ==============================================
 ``um``        Maintained        ``x86_64`` only.
 ============  ================  ==============================================
+

base-commit: 990627acb87c5f6d502fa71baf7b985b8a4bf248
-- 
An old man doll... just what I always wanted! - Clara

