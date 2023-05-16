Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB9704376
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjEPCf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjEPCfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:35:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57531FE1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:35:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7e3fc659so30154502276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684204523; x=1686796523;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNa4l1F+5QMrqUAe4k1x2vD+9zG0bZzdq9LlZrfkoEE=;
        b=5CElQQQJT/aTXqmIkBL5nk8ZqROWxHVeiTpJhgNNP6gAWJxiEdiM9NRKcz3h9LcW3E
         6iQOSor97QYs0lfZ6derwYy+EoBPTPG0wrSAhW6MB+C8I2ulfFpVq0xWstKnv/gCOSI3
         sTayVf/EDsxUwV0fRpbyEQMKAl72VTxZxebOOXGkY9Zo/GRaXgJzrZb8R3DJyyI3TILH
         gbJgCWXVuSYD5aavaLo40em5VxUV5CUuQmcRhtfE7LKpENGuSe0F4bGretjtH/Hk+Er8
         ZzXcJDrPpAVybe+zFrgxXOsiLxl2HMfrPhFvpy1NLp3M2k09zHnGgLcbjVvYkYgEHIGy
         lFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684204523; x=1686796523;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BNa4l1F+5QMrqUAe4k1x2vD+9zG0bZzdq9LlZrfkoEE=;
        b=Ipoo87Gjd0ZwrUFeVDuaxwo7rhuuvg6bKM0wczurUTNGFOSe2fJlMC5+WiE10VRfcz
         N+uIpUkrelYe7pyrjqdg8N9RvOnYIWfxwVFL8NUnKK3nqT04rlTtJn4hIBdX+m8WArW4
         j2s+FpQX9py4uf958NeAF0e9Cq9usgtbPmH9HC9nENBQNiYH8DbqrW016+8dmWmKWwKy
         gP3peibcoLhT6IaR4ag7sG3wldm6fNCOu/u+5vGOaUbKApbIzggjScjl7RGz4JwQmRE9
         rCg3iwBSyzW2TRxIbXH+FmyjXVg3cp9ADPgFA8QymHiVPq8pLkgm+Ifvz4tX4wxwpRQb
         0ByQ==
X-Gm-Message-State: AC+VfDwFA8HgfjMYp3CeKUWNY4mAgeKqHab10w85WPznTucL7sEr4OwN
        nB4EYdTUQQvBI5qBebjTYLUZ500=
X-Google-Smtp-Source: ACHHUZ5++OLyfAEF8T2icYgWUbhVixyck2Y9LW7OB4tG8eRNkSZySF8iIX6XNzPK6UHQZ30i8umUU5Y=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:c825:9c0b:b4be:8ee4])
 (user=pcc job=sendgmr) by 2002:a25:d8cd:0:b0:b9a:703d:e650 with SMTP id
 p196-20020a25d8cd000000b00b9a703de650mr15802130ybg.7.1684204522988; Mon, 15
 May 2023 19:35:22 -0700 (PDT)
Date:   Mon, 15 May 2023 19:35:12 -0700
In-Reply-To: <20230516023514.2643054-1-pcc@google.com>
Message-Id: <20230516023514.2643054-2-pcc@google.com>
Mime-Version: 1.0
References: <20230516023514.2643054-1-pcc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v2 1/2] mm: Call arch_swap_restore() from do_swap_page()
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
Link: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.=
camel@mediatek.com/
---
v2:
- Call arch_swap_restore() directly instead of via arch_do_swap_page()

 mm/memory.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 01a23ad48a04..a2d9e6952d31 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3914,6 +3914,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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

