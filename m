Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A2F60320C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJRSLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJRSLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:11:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EB874365
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b12so21723733edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLk9zy0zXNxz51W/qZOGlz34Dfvx1m3EHjUzRbqLkUc=;
        b=cnOL00ZxpL2eR1fpnbcgRcD2qEPWYqApygWXQI/5C/ttv4yqAkPLNJyu4viRI2xIpE
         522AGEOxhtm226m2ZJH123YqtZCoNQb9gOU3PfWrLuipdlc7z81rGSxJV5H5/gtdFnUt
         gE/SoWwohWXa41E12xqtCczlA2vzUZhkhCL7YULnJmA+jQGv3RP6DF9Iwuis19vQWzcr
         iJ/seWUt35qtQH5stUC/nnm48hBPJx33rIvj2mT1vAUdKxUlFAhvaBeAO9sUBMYRomIF
         Wa3CiXXkQ4+jNTKxkS91jdIm/4thKjLsBzetiBYAAe0EUeJ6p1VW3oDHFmSQgPP6nMZb
         xovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLk9zy0zXNxz51W/qZOGlz34Dfvx1m3EHjUzRbqLkUc=;
        b=UUxOveipAVry7xDLYPMipgbEXt/5EwwHKlm+pWvuh+yOSy9IRxuHqRkVDBWEdHkGDo
         F8J+IJhZpvWwxL2RA2Y3ZUf1dsE+73z33GXNBvFOYAFdIiX4ej+/dHfC2b1nw5wC5MSm
         INhbntkk9UsB1RlpPTXDzYUl7okdl2qDmBLDOeegN2DbDavgW2ve3CSOenam+U3uKqxt
         E57OL3P7O7m5+QNG8tQ+ZytwDvXmoND03e3+4XStuWePZNBpevDJQnzJgYVqhL6p/Kgd
         k5qZsbnAtZgbVX2MNL9q1kl3CAZZwvp92DLdMoKGF5W03oFc7ljIoaJMAdQhHEBZ/gwV
         9NUg==
X-Gm-Message-State: ACrzQf07d+kWHsEd28Lhvi1LyoTud1m5Gj6nepq4TCs+aPnuANUzQ5hL
        iErP+GkOh4CYi1Sl7to8BeU=
X-Google-Smtp-Source: AMsMyM5oOTHLewDw93tTiPYxeZZtHzrQBJV2t3B+0mQMGf0y716r863fZhSTKXrmzLvPkvqGzpxQwA==
X-Received: by 2002:a05:6402:27c9:b0:45d:4539:b462 with SMTP id c9-20020a05640227c900b0045d4539b462mr3790716ede.226.1666116663867;
        Tue, 18 Oct 2022 11:11:03 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b007877ad05b32sm7739302ejf.208.2022.10.18.11.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:11:03 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 7/7] vmalloc: Add reviewers for vmalloc code
Date:   Tue, 18 Oct 2022 20:10:53 +0200
Message-Id: <20221018181053.434508-8-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018181053.434508-1-urezki@gmail.com>
References: <20221018181053.434508-1-urezki@gmail.com>
MIME-Version: 1.0
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

Add myself and Christoph Hellwig as reviewers for vmalloc.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 MAINTAINERS | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 568ad7c5eeb6..a6f4e11755e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13289,10 +13289,20 @@ F:	include/linux/memory_hotplug.h
 F:	include/linux/mm.h
 F:	include/linux/mmzone.h
 F:	include/linux/pagewalk.h
-F:	include/linux/vmalloc.h
 F:	mm/
 F:	tools/testing/selftests/vm/
 
+VMALLOC
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Uladzislau Rezki <urezki@gmail.com>
+R:	Christoph Hellwig <hch@infradead.org>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/vmalloc.c
+F:	include/linux/vmalloc.h
+
 MEMORY HOT(UN)PLUG
 M:	David Hildenbrand <david@redhat.com>
 M:	Oscar Salvador <osalvador@suse.de>
-- 
2.30.2

