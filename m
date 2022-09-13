Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D405B7BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiIMT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIMT6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:58:30 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76167822B;
        Tue, 13 Sep 2022 12:58:21 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ml1so10116352qvb.1;
        Tue, 13 Sep 2022 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hB/8CHaP3epa66ZDI7eIxcYHinx9lai7E+SzdR8JK34=;
        b=DH5wOpdpiHaFFXY8TAT3JRecX64XiPNxiR/CcG1LrVu07Readvn0PWViKgBmDA60Pb
         UBITk9aWlYro2ikNI4WmLJPOCXwQOqtprdUB0CzoJZ72kknTQx9o/RitCRSffQDxQ5Q6
         VTZyKVoIHd28mrFZHIQl9dz1uLmu560sdtEcQWDtP1q9dt0hIGQCuqCTjE9fttuhjONt
         0HIT34gX8eS66xaVSIttBxYAN/YQSf5UtfsLj6aZ6r0xFgT3C7geS9uBf8xzXOro8Ch1
         QuB8O5yFa+P3URJ5XpTXammfwNsUv1UpGQMU/vjO4KV44uIZqk+ZBhqofvaHP1BLFOQP
         ilEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hB/8CHaP3epa66ZDI7eIxcYHinx9lai7E+SzdR8JK34=;
        b=lsGCDxEQmPS3bvGU1uYNwbVPxKKD4cCzXQitNCv83Z4hxM31dWH2JuVcNPq3jKetCo
         VaxxISkv0XiakRffnHQ0FIJe6o3lsQ7Gl+IGNoJlmAcd1I6yk9PFRhUuR2JQSWnGZ7Cx
         wye9WTEZcu6J6uPg6oR+Uwkch+yhwSIEDMUEkk79+75u8Wn3+ss/tnvOK8NHSofHMcJq
         G1OVzI+tCyZgwIKtqOZBPPw12G4qyQMBTB4Lca8ldOaadXlTFzGGReQ+WhNHF5hIee7v
         eusCLXx6vH2/XpM245Vz/hpIcSr8letmTh5Ybk9YiuNia9+VGxFIq7W6cuH9yMn9TqBE
         sxkA==
X-Gm-Message-State: ACgBeo1agUzYEYbEGSyuozDVO4qiGXFPyX5MF8wrs/uzC6jW64WDzDgR
        c+ajKkxtZLuUfQzWUmZ+TF0=
X-Google-Smtp-Source: AA6agR4VzptNv0IdYnihlFGaNyhbElSt3SCLpuN9uI3qoIO24r77G7BDUS/ieSa0RDNa+EBnGiO84g==
X-Received: by 2002:a0c:c98a:0:b0:4ac:9f4b:efed with SMTP id b10-20020a0cc98a000000b004ac9f4befedmr14045129qvk.35.1663099100395;
        Tue, 13 Sep 2022 12:58:20 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:19 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: [PATCH 07/21] lib/show_mem.c: display MovableOnly
Date:   Tue, 13 Sep 2022 12:54:54 -0700
Message-Id: <20220913195508.3511038-8-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for commit c78e93630d15 ("mm: do not walk all of
system memory during show_mem") indicates it "also corrects the
reporting of HighMem as HighMem/MovableOnly as ZONE_MOVABLE has
similar problems to HighMem with respect to lowmem/highmem
exhaustion."

Presuming the similar problems are with regard to the general
exclusion of kernel allocations from either zone, I believe it
makes sense to include all ZONE_MOVABLE memory even on systems
without HighMem.

To the extent that this was the intent of the original commit I
have included a "Fixes" tag, but it seems unnecessary to submit
to linux-stable.

Fixes: c78e93630d15 ("mm: do not walk all of system memory during show_mem")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 lib/show_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/show_mem.c b/lib/show_mem.c
index 1c26c14ffbb9..337c870a5e59 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -27,7 +27,7 @@ void show_mem(unsigned int filter, nodemask_t *nodemask)
 			total += zone->present_pages;
 			reserved += zone->present_pages - zone_managed_pages(zone);
 
-			if (is_highmem_idx(zoneid))
+			if (zoneid == ZONE_MOVABLE || is_highmem_idx(zoneid))
 				highmem += zone->present_pages;
 		}
 	}
-- 
2.25.1

