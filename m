Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399876C96F2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjCZQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZQty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:49:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A42D4EE3;
        Sun, 26 Mar 2023 09:49:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w9so26592557edc.3;
        Sun, 26 Mar 2023 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679849391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOOh5ylGciS8r1LLveU70ssf4eo4Db6eqihZ0xNvHJg=;
        b=W/cw9lVyy0aMeqCqFFfIwehE7BTu1FoS62XMLn2p4e8aY2PKc1X3eWqZzNNo/gKewP
         APZ8kNlFiCZyWKFmA0wYXWMzVbfEVqhWb+i7M6cca+BHuD9rO8PUKvgZddPTV7v9GIMd
         2XdJuK23yKxY0kz3F/NERPDPg8INB8JOaQspchwsoro70MPKQb4JbOAQ2a+NlN96wAqn
         7b5rMLdikbYqWlQTcZ5I7hncR601fNVNa7mXrW5mzR8W5dGSGxvzKZVz+8tZt1uw/vMW
         +JDXB6hCJ4oOyGsiOgNXoBB5Nnt5vSZDTWBoJSnGKPnlZZuB3TGZ0ZETSAkeWkpPM44E
         cb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679849391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOOh5ylGciS8r1LLveU70ssf4eo4Db6eqihZ0xNvHJg=;
        b=BdSkUmQR0dI2RupsAOTxFgwoZIXwq7xhOLJGYtAF2WOJkImndsFrKaVJda4nvVI8lu
         XcZNPnnKZVz9gQkzPQVK/D6ywleTv1ekHEH5KfqOedM4wOGnIXQeIqFUuaBy3hG+ktSC
         eIYxi3ifZ+vQnB8ZGm66m16cTFI8V5EW389fLlXITWGPLReq4T/UxSxFsIBNKCjTs9+b
         Wzj+orPLviXh5I5bvNL8sVlItwnUnmXGHkBm/bsa4/bBhJKBkhtcS0Kc5bDQovgLQbB+
         j08Hnh30TTxBQ7LTfSXxfsIWUCnATuY44GgODwwPIOJTyCOklPOy5ZDdABureJHKkr7T
         c8eA==
X-Gm-Message-State: AAQBX9dVZt/qCHh2c8p2nT8Rj2ld8PiwJgd1obG5MVfJf79SaSRGlVO3
        GltaUx09PyRMp8pUL/+nNdmug3vFmg==
X-Google-Smtp-Source: AKy350Z6e0CtkGaZeWaXyTCYFN66D7725LjXhWRs8pkJY3KffSrFQUtpR3/YBoVbG+vuEGFEdwv62Q==
X-Received: by 2002:aa7:d885:0:b0:4fd:2155:74ef with SMTP id u5-20020aa7d885000000b004fd215574efmr9437605edq.19.1679849391532;
        Sun, 26 Mar 2023 09:49:51 -0700 (PDT)
Received: from p183 ([46.53.253.224])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906924500b0092be625d981sm13165557ejx.91.2023.03.26.09.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 09:49:51 -0700 (PDT)
Date:   Sun, 26 Mar 2023 19:49:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] ELF: document some de-facto PT_* ABI quirks
Message-ID: <c4233c97-306c-4db8-9667-34fc31ec4aed@p183>
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
 <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out rules about PT_INTERP, PT_GNU_STACK and PT_GNU_PROPERTY
program headers are slightly different.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	v2: integrate into documentation build system

 Documentation/ELF/ELF.rst   |   32 ++++++++++++++++++++++++++++++++
 Documentation/ELF/index.rst |   10 ++++++++++
 Documentation/index.rst     |    1 +
 3 files changed, 43 insertions(+)

new file mode 100644
--- /dev/null
+++ b/Documentation/ELF/ELF.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+Linux-specific ELF idiosyncrasies
+=================================
+
+Definitions
+===========
+
+"First" program header is the one with the smallest offset in the file:
+e_phoff. "Last" program header is the one with the biggest offset:
+e_phoff + (e_phnum - 1) * sizeof(Elf_Phdr).
+
+PT_INTERP
+=========
+
+First PT_INTERP program header is used to locate the filename of ELF
+interpreter. Other PT_INTERP headers are ignored (since Linux 2.4.11).
+
+PT_GNU_STACK
+============
+
+Last PT_GNU_STACK program header defines userspace stack executability
+(since Linux 2.6.6). Other PT_GNU_STACK headers are ignored.
+
+PT_GNU_PROPERTY
+===============
+
+ELF interpreter's last PT_GNU_PROPERTY program header is used (since
+Linux 5.8). If interpreter doesn't have one, then the last PT_GNU_PROPERTY
+program header of an executable is used. Other PT_GNU_PROPERTY headers
+are ignored.
new file mode 100644
--- /dev/null
+++ b/Documentation/ELF/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===
+ELF
+===
+
+.. toctree::
+   :maxdepth: 1
+
+   ELF
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -113,6 +113,7 @@ to ReStructured Text format, or are simply too old.
    :maxdepth: 1
 
    staging/index
+   ELF/index
 
 
 Translations
