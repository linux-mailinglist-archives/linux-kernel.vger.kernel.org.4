Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA163F211
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiLANwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiLANwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:52:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A1D9801F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:52:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so1622215wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOrylymYjcUxwPoIjc41bfSu8k4HBK0lJeu4zajRIls=;
        b=k9Diy66l17Fnxfg7aQNLZ1KX8aTf/tpKeM0E49LxuGb0Bi1Zqhpn4atF7GN7zu7nn9
         HWzEtYDAwaqGI1uglPAT/UZ5gAY9pRxFt72l/ADMFuctBM++Wrp4/KfuPpmmYOegSB73
         iXIR7ZwIPfwgVCIpc6Q7/c3tQl3ngtczrOJoRGE5441R7KxrH7zEtfmyNtlV9o9X0mc2
         6QPkPJNnQNKAok6WWNRZPvdViEo/X2BvpEAiVxcxQqC3IbXZy+xAnU9CdYhBg2p1caSk
         +Zz5Sgnfs5PB6n18WycCx2+U/Wnu20UgVbrKCDgEvdshzhwrTlZ52dlEMHxsYqPKwiyu
         vhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOrylymYjcUxwPoIjc41bfSu8k4HBK0lJeu4zajRIls=;
        b=6Rux0KSG+ONuG/PCLVc7e3GHDfTIslVqBFMJHoiEnkfwnpJsm+PlK+LJuN3uuxDg/r
         A3CUwAP9YRUo5FwL7oKfauIg05bxVpExPfWZ1qu6PZU8oStENgONegY3BLADX6PgSsID
         NAuKG1woY8qW6vldasNUlkN1tpDg57F8FdpbkVPH8QgWPGQvlN2Nr3VT77pAlIOdMXoy
         x7K54QNEjn8sB5t2WYWUGlviqBAki5bO8xYnaVfs5fEf3Tf+dJbkK7u5VU4APwyqyu7K
         ohpYO3PV/xrUlFnJKvKG5Yr2GIy0gVyIQVfKRd87hhjN+DNqbxiPqWFhvEMvfxtLWaHz
         o1qw==
X-Gm-Message-State: ANoB5pmuKtSgk1ooOxxyRi9DhyVj9ox0rXINSq+5W+zfh3/WReSl+2a4
        zYkQTFJINWtrw/V/hWs8JCM3iWW4LgI+GQ==
X-Google-Smtp-Source: AA0mqf76JQEnN0ISZaDcT2aZuKhMzGd114XgVhZ/taHM0DIN/Tzeik0zg5UpwWoF23zTi5ZJ1VssHw==
X-Received: by 2002:a7b:ce09:0:b0:3d0:6b76:4e67 with SMTP id m9-20020a7bce09000000b003d06b764e67mr8141476wmc.147.1669902739370;
        Thu, 01 Dec 2022 05:52:19 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-gre-1-201-46.w90-112.abo.wanadoo.fr. [90.112.163.46])
        by smtp.gmail.com with ESMTPSA id n12-20020a1c720c000000b003c64c186206sm5194538wmc.16.2022.12.01.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:52:19 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/1] riscv: Fix P4D_SHIFT definition for 3-level page table mode
Date:   Thu,  1 Dec 2022 14:51:27 +0100
Message-Id: <20221201135128.1482189-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc linux-mm since I'm struggling to know how bad is this issue and
if this should be picked for 6.1-rc8 or not.

I tested this fix on an Ubuntu kernel in sv39 mode without any issue
but the version without the fix seems to work fine too, either this is
not a real issue or I don't exercise the right thing to make it visible.

Any help appreciated!

Alexandre Ghiti (1):
  riscv: Fix P4D_SHIFT definition for 3-level page table mode

 arch/riscv/include/asm/pgtable-64.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.37.2

