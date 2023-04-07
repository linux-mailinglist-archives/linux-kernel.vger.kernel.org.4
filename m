Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666806DB42E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDGT1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDGT1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0730DBB98
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o11so40758555ple.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyby/EazxIHU080H4IjdTfHbXYv3ut7QI/UHzeQm/pk=;
        b=J0oQIAcvJHQmNqjl+kzQKyzPrvC17RrlUPVkWtcyilcpofI3iWccvIsy1FWzpsd3Ce
         1QCSb08qko1aBpAWce/V41Fs4NGzufTLEc8nf2sd9lnX5LXXKOixq3cKr5Xx59xQC4PL
         aRXEexQ6aX/UVxWtKcwLYDjLscto/MVfKav/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xyby/EazxIHU080H4IjdTfHbXYv3ut7QI/UHzeQm/pk=;
        b=ilDfI/UFVsaAOxx0B8dbNWE6u9wdSvaRKpW3RkDpqvInXlDtswSGAe+9Ks+jkHkkKv
         aqutgnBbDfnQT7cqyhOBy/SyRcqlsLb0arcdJYVL0/5My9FrAMBWpsb7YdY1wiQrlS/l
         ulCMfFJa58EDzHrRvP9rLDTLMW4dNNUwHU7i/3vb6WLsIULE/m9de2cIHQdlbQFfV+cF
         6s7OWbWQF63UsJmoxY8928hk3JBuqiDixOgWOnlz1Hcny3SwoFa9FZRjzBn1+R/OINgt
         uoWOfyIeqkfUIwNVy3b1MYjfDY+hiCJSesp8gavl5ObCtS7wsz92PCcFTovr79Idz3aD
         WV/g==
X-Gm-Message-State: AAQBX9foAq+2d5CftEB+XNfOoY64gdGTojzq6/38DlZUBplB6Yz4efQu
        Id7X1EahEWvx4BH9yYC/SampUA==
X-Google-Smtp-Source: AKy350aLm9SwIK12GcJxlpjFMU2sjdHdDXQlxrXhsOE/FGZrsXrlTu2xYXP0bSl4E3vFFvFlM+tIYw==
X-Received: by 2002:a17:903:22d0:b0:19a:7217:32a9 with SMTP id y16-20020a17090322d000b0019a721732a9mr3607916plg.26.1680895640475;
        Fri, 07 Apr 2023 12:27:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iy18-20020a170903131200b0019e60c645b1sm3251818plb.305.2023.04.07.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:27:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Andy Shevchenko" <andy@kernel.org>,
        "Cezary Rojewski" <cezary.rojewski@intel.com>,
        "Puyou Lu" <puyou.lu@gmail.com>, "Mark Brown" <broonie@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "David Gow" <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Alexander Potapenko" <glider@google.com>,
        "Zhaoyang Huang" <zhaoyang.huang@unisoc.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Liam Howlett" <liam.howlett@oracle.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Yury Norov" <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Sander Vanheule" <sander@svanheule.net>,
        "Eric Biggers" <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Daniel Latypov" <dlatypov@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v2 01/10] kunit: tool: Enable CONFIG_FORTIFY_SOURCE under UML
Date:   Fri,  7 Apr 2023 12:27:07 -0700
Message-Id: <20230407192717.636137-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191904.gonna.522-kees@kernel.org>
References: <20230407191904.gonna.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; h=from:subject; bh=jhb9iocAv4NeEPNMASy77h08PjA+GBj0a1PxPk1ekXM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6Tf4DfnuEbF/92pn95HJXNG0utK73GQacwi+o+ knpv6+aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBukwAKCRCJcvTf3G3AJm7zEA CBADePyPGdPcFChk93D6qSpqsV5C/AypwKmWlOgxjmalDZ0Ui+lcVeKab4Sblq73Wc4/gXo2ODgUMR xSGUd509Gr44zaB2slorlcXT8oVgp5p7FwaBwCb6YcOWyjFs2Dg9vSxvvaY+V6vZ4IeT+Kq5Fwb6hN cb7+liB/BbS0EEoAefqwVVTTYPn8tGQY0srxskJgejh/UwdYxutTizydw6qRgoO6AUxjdZabnHvVce +AVi9mmWzzwonDy5CvTOO4UlJ3/nNCt9WFCH1uuqSR2jNIdLjcw6eRn3GGCoJs1Fhu82CbHZ/po7m/ q7Grb+HX1BsJgXhh5pM4GNTpgTlykR/c4vCpr+hMNXHjkXqbYx2Vsx4wTLl5qKjU7ob9JLKV25dTOI LNwBv/n/RGM+LbthEgfdL6KpHQiBIEUZDNy/9FDGxpXoyx5mDs5x83vadC+MWP+IVSE7USdi3W5hzw viO8QD5I+E8YyrrB+BR+4wngCVAbMUDZ1CwJZdgSyNx3ls3goI9Vn8m9WuYz0JIuNF3GOHjSRj7m28 fdJAddrJvnt0NCSEfzuXqMUhR4ALlWfmd3lujiJekI14B/g9lJKw56pl109ixcrZcVtmjmHBUbU3q8 xrgqRnk3DKO9D9d2Q40cdw/yWrZhZ747tgv3pLLY8ibSF+YxPWvobWp9dEPg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ba38961a069b ("um: Enable FORTIFY_SOURCE"), it's possible
to run the FORTIFY tests under UML. Enable CONFIG_FORTIFY_SOURCE when
running with --altests to gain additional coverage, and by default under
UML.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/kunit/configs/all_tests.config | 2 ++
 tools/testing/kunit/configs/arch_uml.config  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index f990cbb73250..0393940c706a 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -9,6 +9,8 @@ CONFIG_KUNIT=y
 CONFIG_KUNIT_EXAMPLE_TEST=y
 CONFIG_KUNIT_ALL_TESTS=y
 
+CONFIG_FORTIFY_SOURCE=y
+
 CONFIG_IIO=y
 
 CONFIG_EXT4_FS=y
diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
index e824ce43b05a..54ad8972681a 100644
--- a/tools/testing/kunit/configs/arch_uml.config
+++ b/tools/testing/kunit/configs/arch_uml.config
@@ -3,3 +3,6 @@
 # Enable virtio/pci, as a lot of tests require it.
 CONFIG_VIRTIO_UML=y
 CONFIG_UML_PCI_OVER_VIRTIO=y
+
+# Enable FORTIFY_SOURCE for wider checking.
+CONFIG_FORTIFY_SOURCE=y
-- 
2.34.1

