Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA3F653580
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiLURp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiLURpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:45:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AA323E9C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:44:59 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bf43so24580084lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmUb1QKe4F1LbUqf8OCHo3aefKMY5b7fvAAbpd6Jpw0=;
        b=dE1TQ/p/b1Dr8RhHyq0jYkg3zkOqncrovjp/8HxZtG3m9L7xzBnGW7eg9+NiOPxCv7
         o8GA7JTAQ3Vn6w0FQUY5e3NkrDgc7qbxjxWWQUV3oiorJYI0Gt0Ms85PHZJhUjfkhuIS
         RpGrZXO3SurjzdbAeWU6KVDK+A8OABNJkryL/ZPT4NQx8UnUXhdDyqqqaIspzxUFhg2x
         EogouuIw6eLlCUgt+Z/iNWQMx9wedxXK0I0VYCKeovMB9pwPTxrcyVkghouEQxNhLDqx
         kGjPFTQm61Ow8eqdUoE9iEAv6GH6+8MbX5RMTdXN15kdXRrc0kRLcdG+Q3KmQmPODr5z
         aVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmUb1QKe4F1LbUqf8OCHo3aefKMY5b7fvAAbpd6Jpw0=;
        b=nGuf3G5+ZP5SvcTOzshnXXqTzof58jlaC6zfTL2HQ99Iq38wFlXfuxeEa6GNgQKHVw
         tnR56o/eq3pIWgJRwgan5rMZGgAbLTS9R1bp2WKu4ru1blUbAffwro7ihssQYbMqUMQi
         HWLl1WN1yq8Lgo8ZglwkJPLVHKo2OLMBpECYq8hdwS22usSmjLK+KiGM+X7DqNTtAmD2
         fpeeRHzLQ/6nAKFvwGpNyMcwoXut/Pv2JcvoUF+ZD3efjBehkyN3g/PPP0psLwTfvXCt
         Q74Kr7Jsh6NH75b8If9YHvxbB1a2GD1EJ94QBbIxNvW5LVIGIeaOu3AVSgORBYT0tgdg
         OuOA==
X-Gm-Message-State: AFqh2kozhI3SZP1kKXRFKU63YAmFIfdHLijS2pYitNeQF0t1pPo4eF5U
        3LKhDeupMRyy0fUumRMpzPk=
X-Google-Smtp-Source: AMrXdXsVbYEx6UkqBYvVQrCBZN5fgFg8xukjZRZ5a0hZXacy6agCjFEwscMh58q9djlzMN1Aj40Jzg==
X-Received: by 2002:a05:6512:3b20:b0:4a4:68b7:f863 with SMTP id f32-20020a0565123b2000b004a468b7f863mr1426959lfv.7.1671644697682;
        Wed, 21 Dec 2022 09:44:57 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r18-20020ac252b2000000b004a91d1b3070sm1904915lfm.308.2022.12.21.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 09:44:57 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 3/3] mm: vmalloc: Replace BUG_ON() by WARN_ON_ONCE()
Date:   Wed, 21 Dec 2022 18:44:54 +0100
Message-Id: <20221221174454.1085130-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221221174454.1085130-1-urezki@gmail.com>
References: <20221221174454.1085130-1-urezki@gmail.com>
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

Currently a vm_unmap_ram() functions triggers a BUG() if an area
is not found. Replace it by the WARN_ON_ONCE() error message and
keep machine alive instead of stopping it.

The worst case is a memory leaking.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 17e688cc7357..221d8950e13c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2252,7 +2252,9 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	}
 
 	va = find_unlink_vmap_area(addr);
-	BUG_ON(!va);
+	if (WARN_ON_ONCE(!va))
+		return;
+
 	debug_check_no_locks_freed((void *)va->va_start,
 				    (va->va_end - va->va_start));
 	free_unmap_vmap_area(va);
-- 
2.30.2

