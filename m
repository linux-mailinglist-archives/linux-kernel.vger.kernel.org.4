Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D903E6C8C55
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCYIME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYIMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:12:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45712841;
        Sat, 25 Mar 2023 01:12:01 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 20so3951665lju.0;
        Sat, 25 Mar 2023 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679731918;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+NlJ/oPig1GP7X1e2c7GDto79ZOIHWgulBZ822qNni0=;
        b=MAds8lO/SQafNzkzu9ERbPN00+9EVMg0nVXQHSKzx5xVWQRzNxVtddouKOyGkU5kpo
         ahAUApjRyB4tG4GifLdRUnQ6xNGdrZAkkTG9TU8AEfXRnjKq/7+1Np0T7F+UKpoYg8vl
         Hl7f97ZfuWXxy7ro+uE17qnhYq8vxvbCEnTwLlbX9P3EDE/bbvjrkGAF/Ax7ze77Yi68
         NiwV7EHhDwW/oJvfN5RJ0xZwInUZAPA2au5kQIxP4BrXZmxjun9GCm9vq2Ta75em70iC
         s0Hda8iINwzZ7a2G8zetIGAqfiUQsA69Ebc3nE/Z4AvxM8uUzX8TWWsqfo21WVIHUlWq
         NHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679731918;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NlJ/oPig1GP7X1e2c7GDto79ZOIHWgulBZ822qNni0=;
        b=TZvF/CrNls1GmYuBa4VpNwgtIG5+GgpFq5QE1oyA3R96blMpVxUW4DlOTjuQimbTV5
         8jvCsIjVQURPhtc0jiEdsCO7iL7fmFlKkOFfi+xPD/D2OxhcJ+nuK5JfHLZHLIKGD/ST
         1k7LU5nhpjjZtrsC40woyT9MX/Bg9ufIlu4uiwQP9O0BGgDCT3EUYRa8scb+ltrY9czh
         cuetMGex+Tn/UrvemDOphKM9zGV3taL2tWJBwBKgG0WayiyRzZOtjaw1i68b6NuRnG4A
         YvaObax67Etjse3O/hUblEQCsj+2jS1nV5TJ2HzQBFrpz8DJTw1c/jvp/+z41J7llh7b
         9INw==
X-Gm-Message-State: AAQBX9fY3hYFDxPWfK3Yxjua7G49HRTdM/z5Qmq4z2jXQSNGnwB6n90G
        CCxy/7spzyIXZJs9t+slNRo=
X-Google-Smtp-Source: AKy350bznPlxqT/a26p+A5M3mnHqnoezsghoLnhAEYwchx0tAr4G/87IgOsFxXs0YJA3U6iXy8jEYg==
X-Received: by 2002:a2e:86d5:0:b0:29f:e144:6c6a with SMTP id n21-20020a2e86d5000000b0029fe1446c6amr1490057ljj.23.1679731918514;
        Sat, 25 Mar 2023 01:11:58 -0700 (PDT)
Received: from localhost ([188.119.65.94])
        by smtp.gmail.com with ESMTPSA id m18-20020a195212000000b004e95f53adc7sm3720859lfb.27.2023.03.25.01.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Mar 2023 01:11:57 -0700 (PDT)
From:   Dan Li <ashimida.1990@gmail.com>
To:     gcc-patches@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [RFC/RFT,V2 0/3] Add compiler support for Kernel Control Flow Integrity
Date:   Sat, 25 Mar 2023 01:11:14 -0700
Message-Id: <20230325081117.93245-1-ashimida.1990@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219055431.22596-1-ashimida.1990@gmail.com>
References: <20221219055431.22596-1-ashimida.1990@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is mainly used to support the control flow
integrity protection of the linux kernel [1], which is similar to
-fsanitize=kcfi in clang 16.0 [2,3].

Any suggestion please let me know :).

Thanks, Dan.

[1] https://lore.kernel.org/all/20220908215504.3686827-1-samitolvanen@google.com/
[2] https://clang.llvm.org/docs/ControlFlowIntegrity.html
[3] https://reviews.llvm.org/D119296

Signed-off-by: Dan Li <ashimida.1990@gmail.com>

---
Dan Li (3):
  [PR102768] flag-types.h (enum sanitize_code): Extend sanitize_code to
    64 bits to support more features
  [PR102768] Support CFI: Add basic support for Kernel Control Flow
    Integrity
  [PR102768] aarch64: Add support for Kernel Control Flow Integrity

 gcc/asan.h                    |   4 +-
 gcc/c-family/c-attribs.cc     |  10 +-
 gcc/c-family/c-common.h       |   2 +-
 gcc/c/c-parser.cc             |   4 +-
 gcc/cfgexpand.cc              |  26 ++++++
 gcc/cgraphunit.cc             |  34 +++++++
 gcc/combine.cc                |   1 +
 gcc/common.opt                |   4 +-
 gcc/config/aarch64/aarch64.cc | 166 ++++++++++++++++++++++++++++++++++
 gcc/cp/typeck.cc              |   2 +-
 gcc/doc/invoke.texi           |  36 ++++++++
 gcc/doc/tm.texi               |  27 ++++++
 gcc/doc/tm.texi.in            |   8 ++
 gcc/dwarf2asm.cc              |   2 +-
 gcc/emit-rtl.cc               |   1 +
 gcc/emit-rtl.h                |   4 +
 gcc/final.cc                  |  24 ++++-
 gcc/flag-types.h              |  67 +++++++-------
 gcc/gimple.cc                 |  11 +++
 gcc/gimple.h                  |   5 +-
 gcc/opt-suggestions.cc        |   2 +-
 gcc/opts.cc                   |  26 +++---
 gcc/opts.h                    |   8 +-
 gcc/output.h                  |   3 +
 gcc/reg-notes.def             |   1 +
 gcc/target.def                |  38 ++++++++
 gcc/toplev.cc                 |   4 +
 gcc/tree-cfg.cc               |   2 +-
 gcc/tree.cc                   | 144 +++++++++++++++++++++++++++++
 gcc/tree.h                    |   1 +
 gcc/varasm.cc                 |  26 ++++++
 31 files changed, 627 insertions(+), 66 deletions(-)

-- 
2.17.1

