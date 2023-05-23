Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB070CFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjEWAv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjEWAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:51:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6E4C3F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:44:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb7aaa605so5322208276.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684802597; x=1687394597;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msTm3oYdeXIT0hSlyDwQQkvc5wY+Q8yhko13bmJatr8=;
        b=GVCKc+6rFVLitBZRgjiG8Xp6MHuRDVhZtsHNX/VKvhjNUXI2g+oF9FkWUEYw2KzSxD
         jp4IhTdFiglLXHuJvOecRUNblTjQqoij5ls5a85sMq/WccA2cWXYiEuTGZE2QPc25z1P
         I8fzTiWeaDqvG0LuwqBGkTuunNP3dF5yHaQZQWU03AGRfLddIWVSlV0GDW2IfHKUwGIa
         kJWuZ1I6IkldXrYkOwPS0n6CmraBvOXwhnVIajQXxhcVGPXShTLQ3KiXtaS4Kg9Pbdet
         qc17JRlFojhHHmnUA1aiDUv9PQDzUO/0c5Sa9DD8d5/h5mOmX7eaqslAsS0IaFcRV2+j
         ohtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684802597; x=1687394597;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=msTm3oYdeXIT0hSlyDwQQkvc5wY+Q8yhko13bmJatr8=;
        b=QIb8BqVmpvSIr7HnVXogYInd6JS3on4Oeoi0x3fMuBOJNG6pWo3xmj0xcuTy4TBlKT
         pLoohja6XEYuVcHzL5CGysbgqm6iy0vKZ7jeUFfUC3/u+M0szgwhVTJM47rP4MckNlbh
         MI+IYM1SsgsXlMt4HuDA3La0dh33hr0iBr3ofdwKpkm8u/+O9Kb2fKO1Gw4daBhP2i2F
         VPKpgbDFkVpWR9oByWM0FQi3oTWtYtBDjeyehSYqG32OqxZmcYKhlBmaNylngrMaPkHp
         nlqx4OhbeFqOWnk26YNBCWNka73mOxPqErCo1gKP7gxrfyXRfFw3HwWtRwryxA5L8Q2T
         aQvg==
X-Gm-Message-State: AC+VfDyYU1+IIGipQf+kyhS2/1ayvuNknJrxZw6afo6kNs4lzWlyPRwE
        6E+xfJQmj61VVMcFvCmbPvesywY=
X-Google-Smtp-Source: ACHHUZ6kHjMTCHPdYe9Jo2a981mU1PnCLbxJJT05Im440Cs+gDDAq2rqaJTbIgDZ3JZeNb3/fmzcm8U=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:3d33:90fe:6f02:afdd])
 (user=pcc job=sendgmr) by 2002:a25:10d4:0:b0:ba8:181b:2558 with SMTP id
 203-20020a2510d4000000b00ba8181b2558mr7332911ybq.4.1684802597761; Mon, 22 May
 2023 17:43:17 -0700 (PDT)
Date:   Mon, 22 May 2023 17:43:08 -0700
In-Reply-To: <20230523004312.1807357-1-pcc@google.com>
Message-Id: <20230523004312.1807357-2-pcc@google.com>
Mime-Version: 1.0
References: <20230523004312.1807357-1-pcc@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v4 1/3] mm: Call arch_swap_restore() from do_swap_page()
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
Closes: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d43=
4.camel@mediatek.com/
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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
2.40.1.698.g37aff9b760-goog

