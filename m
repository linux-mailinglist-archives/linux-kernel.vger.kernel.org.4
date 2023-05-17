Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7708D705D11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjEQCVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjEQCV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:21:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6BA171E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:21:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so220670276.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684290085; x=1686882085;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icy+EhZ3UBgzX+LkBKZmwy9I7D5yLVOL3MyBuUnW0II=;
        b=kU3u/jVPNbJOPkDSOv1M9xE9gA7eqoTFhSdZQD4qt7SNgcYJYLu77i/2peyYkaoM+E
         1CklaeTAYSmTwv8Km5dGKi7C0WCfutgqDI2sGNHRkPp+sdYNdJ963Ikhl8N6lfTWY03r
         Jc0A1tNgoUDHR5FiwBDbsHV8XCGmQ1kAqZSfPSuC5DautA1wUknPrMKD4FBEPRXJM1cI
         zDV47+hqam9u7nttpZOONvGIAgOZpyS9w/3N1M0W8GoFsxZc0Tu51VmRu5U30nbsUdLv
         KRfdPlHe57ebRvFOgibo1B8s53lcdE03PGn3ebRw8zfKd/8XLAR3q4VID38yQeldPd39
         cHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684290085; x=1686882085;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=icy+EhZ3UBgzX+LkBKZmwy9I7D5yLVOL3MyBuUnW0II=;
        b=Q8iFC7Wn+liBu/RpKPShQUgrIsbC2BiPVqKQJ4ow151j0pZ2Pyn2rOccHXiFGrvBCJ
         pEDhrlL4R+n/qi885dix8svSDM0nDb5I3bTrd+usVawrwYIRgDPdN9UeHaRVJjhBBGHs
         1VZqthVsY00X8Mp4w28l8/SyQ2Ysl/NGIoHuL0QwHQgSB/HzxUqI1KKVDm7BVFntyqyI
         hp4F+ai4umGdi+9dIBma+oKRsxhcM2Djt1t/ELhKDazz5JbfGBA9lsVQ7XLkkfUjkupv
         ATatYWCKatBo3KEscrJuwBUXafcMamFHiPf4O4NnzXz1EBtFfgi/VYFOVaYQ6DYcQyhH
         Xc1A==
X-Gm-Message-State: AC+VfDwVEBvmyRt1+NqG5V9q1BQXHbmZ3LIKGCXWf2q9Zc01X61Av/GQ
        E77G+DuJEoCNBcrrfLCy2DUCUcc=
X-Google-Smtp-Source: ACHHUZ6HltqTMi815u6+g2acsl5ZG5UZd+Y+2Rbyffv/trwosDfbc8rLxY0NJ38GbW8keQ8pFoFL1ds=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:b3a7:7c59:b96b:adaa])
 (user=pcc job=sendgmr) by 2002:a5b:309:0:b0:ba6:a54d:1cae with SMTP id
 j9-20020a5b0309000000b00ba6a54d1caemr8869621ybp.0.1684290085477; Tue, 16 May
 2023 19:21:25 -0700 (PDT)
Date:   Tue, 16 May 2023 19:21:11 -0700
In-Reply-To: <20230517022115.3033604-1-pcc@google.com>
Message-Id: <20230517022115.3033604-2-pcc@google.com>
Mime-Version: 1.0
References: <20230517022115.3033604-1-pcc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v3 1/3] mm: Call arch_swap_restore() from do_swap_page()
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        "=?UTF-8?q?Qun-wei=20Lin=20=28=E6=9E=97=E7=BE=A4=E5=B4=B4=29?=" 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "=?UTF-8?q?Chinwen=20Chang=20=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?=" 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "=?UTF-8?q?Kuan-Ying=20Lee=20=28=E6=9D=8E=E5=86=A0=E7=A9=8E=29?=" 
        <Kuan-Ying.Lee@mediatek.com>,
        "=?UTF-8?q?Casper=20Li=20=28=E6=9D=8E=E4=B8=AD=E6=A6=AE=29?=" 
        <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") moved
the call to swap_free() before the call to set_pte_at(), which meant that
the MTE tags could end up being freed before set_pte_at() had a chance
to restore them. Fix it by adding a call to the arch_swap_restore() hook
before the call to swap_free().

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f841049b8c61=
020c510678965
Cc: <stable@vger.kernel.org> # 6.1
Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
Reported-by: Qun-wei Lin (=E6=9E=97=E7=BE=A4=E5=B4=B4) <Qun-wei.Lin@mediate=
k.com>
Closes: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d43=
4.camel@mediatek.com/
---
v2:
- Call arch_swap_restore() directly instead of via arch_do_swap_page()

 mm/memory.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index f69fbc251198..fc25764016b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3932,6 +3932,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		}
 	}
=20
+	/*
+	 * Some architectures may have to restore extra metadata to the page
+	 * when reading from swap. This metadata may be indexed by swap entry
+	 * so this must be called before swap_free().
+	 */
+	arch_swap_restore(entry, folio);
+
 	/*
 	 * Remove the swap entry and conditionally try to free up the swapcache.
 	 * We're already holding a reference on the page but haven't mapped it
--=20
2.40.1.606.ga4b1b128d6-goog

