Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFCF5B9DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIOPC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiIOPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:02:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881A585FDF;
        Thu, 15 Sep 2022 08:02:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so8289039pjo.2;
        Thu, 15 Sep 2022 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=l6l3XBbZgS3tr14q2oBrffwPSTwXxpqq1iQ9lWl+dBc=;
        b=HsAHqRgqy1RewASaznRyALx4trsvMmIIut1OHoWxdjUTvIjUYJEphcLh/mZoI22u6O
         ugUlFIw3Uraa5Ol8BoPF6YZa2GOjCUf3tn0g8A1hlpkxzTU7uLDYR73FsNtMZpLu6d1C
         86wC35pO/fO1Zw3XHh3ptIebXp7RtmwZlMsguUMFiVMyYv0IuQ9+hsdJ6gXxiQxDJDR0
         IpfOthZRvxXQTaItQfHsCxY6Hw29xsA/6HDEF6PiixNlodI1epsiDPZ9f2Xhy/iK/jX6
         PjrSvlmAQj/LopCXD8ta13AXPiex9DgE7EuBiLxwf4TFNI8NetqKG0/DPc7oeAO2gWjw
         /APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=l6l3XBbZgS3tr14q2oBrffwPSTwXxpqq1iQ9lWl+dBc=;
        b=OAWlzYRKjBTIZZXljtC4X7g9XDMu4uTlUNMsVhDG9FzlvDqMCBRkFqSCsamjWKmSaY
         vx3OqmUyC5apNemQSU93OgCjfhjn/29NWdsE6EyY/mO86OOuG1DXXkgABU54VKC68acr
         EwSgha/MDhv6nMFWx2GsYc8NePhhM0A83/VJX/ybYoCQN5u0BQ+myEgcd6hFBJnknCYu
         AMcqye81It4Z2Terp1XvjL7xSA78FlerooOZtyAzoQC862273PW7nSnHOO88PZIYUS3T
         5AS/JeOb9p/cPU1csLDypOrwD0wVXDYXIN7012bCbv47/0sXBrObgVzMjJE+gHzibeVU
         VbjQ==
X-Gm-Message-State: ACrzQf2ajW8ZX7TGSbQTgEwyAGuoHXjdi3HqbUebeuSk/w7GZ1X7HDQB
        OjvXMcz+s5mjK7LEfrz+Wc0=
X-Google-Smtp-Source: AMsMyM4JAZklEkyspJhHNnognMb3Z3VWzT0BsDSrF0OY6mGEK8ZoObRi+EInlWw6HdfE9T0X+E03mw==
X-Received: by 2002:a17:902:f08c:b0:178:25ab:aaef with SMTP id p12-20020a170902f08c00b0017825abaaefmr192171pla.57.1663254143838;
        Thu, 15 Sep 2022 08:02:23 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id np13-20020a17090b4c4d00b001df264610c4sm4254849pjb.0.2022.09.15.08.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 08:02:23 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH v3] docs: x86: replace do_IRQ int the entry_64.rst with common_interrupt()
Date:   Thu, 15 Sep 2022 23:01:55 +0800
Message-Id: <20220915150155.9908-1-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_IRQ has been replaced by common_interrupt in commit
fa5e5c409213 ("x86/entry: Use idtentry for interrupts").

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 Documentation/x86/entry_64.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
index e433e08f7018..0afdce3c06f4 100644
--- a/Documentation/x86/entry_64.rst
+++ b/Documentation/x86/entry_64.rst
@@ -33,8 +33,8 @@ Some of these entries are:
  - interrupt: An array of entries.  Every IDT vector that doesn't
    explicitly point somewhere else gets set to the corresponding
    value in interrupts.  These point to a whole array of
-   magically-generated functions that make their way to do_IRQ with
-   the interrupt number as a parameter.
+   magically-generated functions that make their way to common_interrupt()
+   with the interrupt number as a parameter.
 
  - APIC interrupts: Various special-purpose interrupts for things
    like TLB shootdown.
-- 
2.17.1

