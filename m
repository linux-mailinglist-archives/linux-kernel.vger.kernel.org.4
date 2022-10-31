Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BFB613554
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiJaMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiJaMHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:07:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57730558F;
        Mon, 31 Oct 2022 05:07:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k22so10516451pfd.3;
        Mon, 31 Oct 2022 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ycr17+a55rcYsBYWxTRCsT0UwX9F6ZU7pqXcExPQpA=;
        b=e6AKxCHlIXguyd0DBGSrdtlsWiPuLJCk1tTKXNQXcbS8wLYhsnWI5wH2DXUjfgctnY
         s3Xw7aFQYHk1aWnhQDrpCclFlMXQPqNCQg1pxX/FyIeOZGqfGcwhEXXiYhGCUx8pQ7ai
         QKVFrteK2c50upMP2JwjizDLwBqOelJiuldIqHstFSyASX9MwJzaTox/cIKW6sENjkCA
         /t3mBSG9A9HM+hxfB6uSSNCXytzTbvdmXyK0Wvtn6xSRecvRHS8GGWVzg+1Qr+VS07VC
         o2mmqED/9YlCBpwEnqW9aKYuBEb+ooRiKPM4oluTnjTZFAMqHVkz5og2g4A6bgf3oanj
         UNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ycr17+a55rcYsBYWxTRCsT0UwX9F6ZU7pqXcExPQpA=;
        b=B/7xTeRPjmzJLB4CUrT9lkE6relRPEtSMUOLAb/l5sdUK6+jSxAwmyV3j/OIOIDcgs
         1LBjw5jhfphKxeBOTg02TbQzm+nePl0+e6wqVAM/U1Ul9ItKk5GPJcai/1TDqVQAAl4t
         vuhG28DuYccPPGeXTIEQzaRN1hEGS3r4nVzRMZ4ADd4ECuUs7DDiUOpBiRxZBO+VTMWb
         jWXhd1piDc1IVmI1XC2E0icIj1ERp0JemlidY5u1Qj/ooGw0NGPskdDNq85OCnpfZ0MW
         eEMplyiXHD0bgky7v9ploRE2KY3aL8+x/2ZYuknKgqhGhEp3/8E0WklHegoFqKd/n54u
         7I3g==
X-Gm-Message-State: ACrzQf3dYVS9xvBr0JR/6HjgrPd22QQAeCS+QQOeoIiUrxpem40EkKVt
        JBrc6STl5i7GSl4lT0VEk74DnQV5y8A=
X-Google-Smtp-Source: AMsMyM4OCqXbCf7YDIh96WINBqKgwpacyC98n48oqJJh7nspIBEC6uppEwjykQuzVx+u4na3LYt9AQ==
X-Received: by 2002:a63:8942:0:b0:46e:c02e:2eb5 with SMTP id v63-20020a638942000000b0046ec02e2eb5mr12434406pgd.141.1667218065126;
        Mon, 31 Oct 2022 05:07:45 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-106-251.tpgi.com.au. [193.116.106.251])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902e75100b0017e64da44c5sm1595134plf.203.2022.10.31.05.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 05:07:44 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-modules@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 0/2] powerpc module arch checks
Date:   Mon, 31 Oct 2022 22:07:31 +1000
Message-Id: <20221031120733.3956781-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
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

These slipped through the cracks. Picking them up again...

The story so far is that Jessica gave us the new scheme in patch 1,
now slightly rebased. Patch 2 implements the additional check
that powerpc wants which originally came from Michael, and has been
updated to the new approach.

This was previously attached to the ELFv2 build option for big-endian
kernels, but it can go ahead of that option.

Just checking everybody is still okay with the code and their SOBs,
and Luis if you would be okay for patch 1 to be merged via powerpc or
prefer to take it in the module tree (or maybe you object to the
code in the first place).

Thanks,
Nick

Nicholas Piggin (2):
  module: add module_elf_check_arch for module-specific checks
  powerpc/64: Add module check for ELF ABI version

 arch/powerpc/kernel/module.c | 17 +++++++++++++++++
 include/linux/moduleloader.h |  3 +++
 kernel/module/main.c         | 10 ++++++++++
 3 files changed, 30 insertions(+)

-- 
2.37.2

