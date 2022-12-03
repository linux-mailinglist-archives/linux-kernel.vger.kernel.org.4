Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76716413E4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 04:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLCDFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 22:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiLCDFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 22:05:43 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84239F7A09
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:05:42 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z14so2665331pfr.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 19:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=MlD/Jt4lEh7hCsdG4GrZC5S+VkhD7NzUj5refRzoYlM=;
        b=izvAm0VDDUI8l/g0FySHjcna49MAYiOl2i2nsHUCSKpwH56Ir0FhArtL4lxajgpkXU
         q1iMarjU2+4l78dL0ag6d1NvQOqww04i5UnypzOB7uiJNMdv6ZNzb7EMxtmw5MZyE7FS
         bThPfxkT785nXJba2CClXZ8fuV2fw9cigmtlu8HPoTnQiyjsAVLVsY+Z6ZgI5QpnZlNS
         ohghGfzoUn9u90kZ6rVg/9evUP6bC3tPDT6pLi+TdYbrAm2TFz5GcZZc1u/bdGibPp/B
         2n2b2AfXkggu33bWgZZ5liaNgIt/NwMzjqmw4UnUUdoXbVq6av/nJ7otAE/nEGEaYUqj
         79LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlD/Jt4lEh7hCsdG4GrZC5S+VkhD7NzUj5refRzoYlM=;
        b=NEJaHO30m4VfC4VGujx338Tz1JcDm3708XNTm1BMosEkKHDey1duuh+BtY0EqKT1MZ
         H3FeZq62NxNEyVUxORrXbgQyQ8jcpZ6Y6YKrcJddl0WEmszlnK0OsQvcIwVk6cdWx7XY
         KgfZ0WXYAJ9u0unixBtwUmZgxc3QVak2fBxUTNYNIj3JxwiWo06OfrdX7xSPYZNWUFk2
         /qty2ktc+1tvS7YL+e465Kk7jjOqO9tZlEx9nFH1ll1Dps0KWDe7srCHKGCBi/r0sYQH
         +isZH8acrNAkuZjOutZQSwFiw0gAz4WKQdkek5JmQ3WJ1XnV2CKzsjXzIjYKU5Mt5mxp
         KE2Q==
X-Gm-Message-State: ANoB5plkEgAPpKjXhpkWKkD3VvqymJvOMq88FO9Rhk12X9eGcmj1b/cY
        l1Xu4Zt9z3NXDddO6yX2Wwy/7So7P+Qpa+/2
X-Google-Smtp-Source: AA0mqf64+QPycPCkazRrryQxpdG0UWxw0OahAJX32vqLElr+emlYUBPO7ldr1//HTp+r6hNM6u2ung==
X-Received: by 2002:a63:d34e:0:b0:477:650a:705c with SMTP id u14-20020a63d34e000000b00477650a705cmr46384100pgi.588.1670036741697;
        Fri, 02 Dec 2022 19:05:41 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q24-20020aa78438000000b00576984617b1sm287450pfn.60.2022.12.02.19.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:41 -0800 (PST)
Subject: [PATCH 0/5] mm: Stop alaising VM_FAULT_HINDEX_MASK in arch code
Date:   Fri,  2 Dec 2022 19:03:51 -0800
Message-Id: <20221203030356.3917-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
           linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing
<https://lore.kernel.org/r/20221029084715.3669204-1-tongtiangen@huawei.com>
I noticed that the arch-specific VM_FAULT flags used by arm and s390
alias with VM_FAULT_HINDEX_MASK.  I'm not sure if it's possible to
manifest this as a bug, but it certainly seems fragile.

The RISC-V patch is on top of the linked patch above, which isn't in any
proper tree yet.  Everything else should apply to 6.1-rc1, but I'm in no
particular rush to get that cleanup in so rush on my end for 6.2.  That
said I figured it would be easier to send along this now, just in case
someone who knows the MM code better thinks it can manifest as a bug.

