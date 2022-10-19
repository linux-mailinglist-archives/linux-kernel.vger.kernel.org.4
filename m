Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958FE60388B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJSDS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJSDSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:18:52 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C3E8AB5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:18:52 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-12c8312131fso19183658fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAeyZnwzzfhGFESECQVoU1J4Mcn3Vns5Z1CRpRFhKJ0=;
        b=K33RaYRgNppDWt/10xzhwd1v4B26clXQn+9iNAMke6fpUUlY+ZvG3M7UC9+DN5ZlMN
         zBoltdhn9vtmhEj1dWpB6mpxm2ExFrfqcH/0BHF4Yr/69k/Pp11/7iJmvbbwHvAId5cC
         RZ8PAN4fWaorWkQHvNJFZi5E8lr1HVCpFyp2yPiF4ZY1RsDGlBhpu38Foor+F+GaOpii
         izUeSQbPHKsKUW6zAQbAm06q2ZcINLwY+Rqc3EeIlzfdtgTDzhkFNsTt2ML/RWZODdfI
         +OCDuso4CR3Z2o1VoOOzQnHO3pyrfXz1+XQ75mTALt2W+1tA5NFpA8fih1YTfXXdxO3M
         okyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAeyZnwzzfhGFESECQVoU1J4Mcn3Vns5Z1CRpRFhKJ0=;
        b=VhCEu4YAxoYdsqEa5aB1PzjmGeHypEF938Rf403HrrkJ+FkYOH601G0eXLLE46skXx
         nRUDvhh2idRPHmcUmVcdUbk9qDuRIhJdiLI9rTMRPrgkwQallqgJ1QCSxRW1SYvguks2
         pWKztVCO67piuiXWrsTj25gARbrK/erh9XWjIfKjBbQxBLqJuioft8kyfa2VYotNRXrV
         hee5t2k5+45ebpjXyqFTINIjfeKPbsYzK7HZE8EyLSxPOR5EL/nTf3oGkfxBLmKQRwHZ
         R5hT1iIbZsL162aWD7Vn8w2yirzvsqFpKCR1dIjDcD3CExPyhrdm/ugj10rwue3HK+xK
         Nf6g==
X-Gm-Message-State: ACrzQf1plpMg4N/ru5swUb42sUr2toHP4k/1JS4Ov1vY6meMiJvIoz4R
        4NtsW4l92+e/mElyzt5dOkgyCQ==
X-Google-Smtp-Source: AMsMyM7OMl9zIUyR6LciyHrft8KITcPb5cfldifc8PFJicTj4YSK5oMyxRs0eC5+B+Rb5hQAFPGsRA==
X-Received: by 2002:a05:6870:a553:b0:11e:5231:4eec with SMTP id p19-20020a056870a55300b0011e52314eecmr3613843oal.143.1666149529319;
        Tue, 18 Oct 2022 20:18:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w192-20020acaadc9000000b00353f41440dasm6184323oie.56.2022.10.18.20.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 20:18:49 -0700 (PDT)
Date:   Tue, 18 Oct 2022 20:18:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: /proc/pid/smaps_rollup: fix maple tree search
Message-ID: <3011bee7-182-97a2-1083-d5f5b688e54b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/pid/smaps_rollup showed 0 kB for everything: now find first vma.

Fixes: c4c84f06285e ("fs/proc/task_mmu: stop using linked list and highest_vm_end")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 fs/proc/task_mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 6.1-rc1/fs/proc/task_mmu.c
+++ linux/fs/proc/task_mmu.c
@@ -902,7 +902,7 @@ static int show_smaps_rollup(struct seq_
 		goto out_put_mm;
 
 	hold_task_mempolicy(priv);
-	vma = mas_find(&mas, 0);
+	vma = mas_find(&mas, ULONG_MAX);
 
 	if (unlikely(!vma))
 		goto empty_set;
