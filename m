Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841195EE967
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbiI1Wdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiI1Wdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:33:49 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB25F8FB5;
        Wed, 28 Sep 2022 15:33:47 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id gb14so251359qtb.3;
        Wed, 28 Sep 2022 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hB/8CHaP3epa66ZDI7eIxcYHinx9lai7E+SzdR8JK34=;
        b=WAksJPCtovML0PXfuV6MvtFhaquK0tq65BQzPSMUX0EZb3CqP+duiDKDvHl3Sit7m7
         7aOY0PEle5W8Mi2h7QigBTY8Lg9rVOpp48AzS1DIJ4l7/+09QqhqnWAx1czOCbInzF8d
         x0YJ/P2gInkW3C6VhvjtTXDTumcsev/S/pTT+ignxMH0mOrEue1fBAf5GE5WDzaQFzF0
         RdlNkUbc/JOrJS4Z1j8l16rMuCAMgQ8Ox/Jf5BztPHKu7DNY6R4apLKF8tfNNMjx27+d
         3I23mrMNzl+yyZHs1Odm+efLgckSB2i6WXUlZx+oBQ50hBKajiK77oTPrOY+jVboWfch
         SIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hB/8CHaP3epa66ZDI7eIxcYHinx9lai7E+SzdR8JK34=;
        b=aDgEHy+Jf4S6sR3f3OL/08/fNC64gysr9hvggS1AbxsTcZicEe4mNclM7gxacoTKK1
         auuVC1ruPv5ldI4y6uARbAcBLlEtdzypTskLnJzAmmn7s6ahUX+8enoTyYNjMLXMoBOh
         35m01KCpWNYK0ImigPcklKF1lHTnfwm8c8ycDSgfuRAIJ9qNxrY1eaaEqGtxHFWniqLn
         Co8k0sIxlS6/R20yh7Wj5y9GasjmNqUm2nhGhUJMd0TF4ZVlgExzJfSe+cMjwwjheef4
         my5r3ZNhORSJcNbv+G7r4ialFXCg61bM6o/k4miPFBlPCYikiH7OksD/8INkavZj+dH9
         qH7A==
X-Gm-Message-State: ACrzQf0atN9mhQn2d5Qk/ZyXTKkZxwMVGBW9pe/yrilFZ5xq911tqHJJ
        nZjR3j8y92SXYW8o+ed1+HI=
X-Google-Smtp-Source: AMsMyM5iPvaKGQ+lU/wA15lUDKduPyVp0Psny3VAxI8TVl+GMPXgPk02cHgarNIBuaXdamZhkM7iCg==
X-Received: by 2002:ac8:7f93:0:b0:35b:bbdd:5699 with SMTP id z19-20020ac87f93000000b0035bbbdd5699mr78529qtj.46.1664404427112;
        Wed, 28 Sep 2022 15:33:47 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j188-20020a37b9c5000000b006bb83c2be40sm3963481qkf.59.2022.09.28.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:33:46 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v2 1/9] lib/show_mem.c: display MovableOnly
Date:   Wed, 28 Sep 2022 15:32:53 -0700
Message-Id: <20220928223301.375229-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928223301.375229-1-opendmb@gmail.com>
References: <20220928223301.375229-1-opendmb@gmail.com>
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

