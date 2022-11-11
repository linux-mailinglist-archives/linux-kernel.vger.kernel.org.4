Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255A5625587
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiKKImb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiKKIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:42:27 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41B7C8E9;
        Fri, 11 Nov 2022 00:42:26 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 140so2879772pfz.6;
        Fri, 11 Nov 2022 00:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6txTBfedUg47A+1SaRTB83c1B6flmoZ3lT0pRxr6Rg=;
        b=KACvd+ObSftiPnKEo0vZd2XEFkWsCd6GAtWOyAS9KEZjkuMyH3rfn0o+QKnBVHCwtJ
         h2Yn10CrD4in1vbPFh+ByTYMAop38ANjC7GQ/EHkw9yjZXIOZK0+hk5hrWNqGbxjtF9A
         JWtK7ihib3/jvdlW8I0d2wVWQP3v4uwzrKRUY15eduSFJXS32//BgqaNHsXILZnZ9Fy4
         58CU0eMBXpjJn/0ETNXLDHsNLyhmr5iI1dKFZC7N1onj5XmIQp+kXIkOhUuBRbx157Ra
         XLywL4q31iKRaiWsTFDi485zJeQWTUSAtmYjqYGL2Ito6wPQcnrD1zN0+PwrBVACvSlr
         e3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6txTBfedUg47A+1SaRTB83c1B6flmoZ3lT0pRxr6Rg=;
        b=g6NfEJT6l+kMJXxzaIkob46BrAYeXgrh1XThQBOCjXM/a91iMVXgZbTRlpjOuhclYf
         hzGSfgTCvbyO4Aj0r6SfOfexMqmpWh08xVYv0WPto0ikGtGFeobyhxrM6JTvfhUUizSS
         zguVXOwDqsT6mRBt9aSUJCusr5k1nFrqNx3i64Bk+YfRjhOb+i2SNo/WY9/oEsIbqzZt
         DV9uA1ExFi77pRF2a4uTCUPNC9q5QparFKGtdeqopyzH3d93dQde7RbE+0pg+VxBcYXf
         lmN4BptSDhUdhOSki+1BlhOdeDFbJr4oHHU3VSu4hwLEWXzgpbiCrhOApv1oN1qVAV7E
         mRRA==
X-Gm-Message-State: ANoB5pnWpMrxuTDb8TnzH7ZPq8tmbY8eiFjY6BAA9sk1h809b/v44CH9
        0hWThTZRhKBB1squu9xlNcJp7PxJiyfDuw==
X-Google-Smtp-Source: AA0mqf7QnaktnhdZSNb/U7ZuRCYdiuwIKrrMVuo8uoRg1qJGsrXDA6izuMn+9t125FdwbsWc80/xEw==
X-Received: by 2002:a62:174b:0:b0:56d:3de3:c525 with SMTP id 72-20020a62174b000000b0056d3de3c525mr1669410pfx.41.1668156145849;
        Fri, 11 Nov 2022 00:42:25 -0800 (PST)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b00186f81a074fsm1088731pls.290.2022.11.11.00.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 00:42:25 -0800 (PST)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Subject: [PATCH 0/1] mmc: Reduce tuning log output
Date:   Fri, 11 Nov 2022 16:42:13 +0800
Message-Id: <20221111084214.14822-1-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

During the HS200 Tuning process, a lot of "mmc0: Got data interrupt 0x00200000
even though no data operation was in progress." logs were printed.
From the cmd in the log, it is CMD21.
[    4.547365][    C0] mmc0: Got data interrupt 0x00200000 even though no data operation was in progress.
[    4.564088][    C0] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    4.571213][    C0] mmc0: sdhci: Sys addr:  0x00000001 | Version:  0x00000004
[    4.578339][    C0] mmc0: sdhci: Blk size:  0x00000080 | Blk cnt:  0x00000000
[    4.585466][    C0] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
[    4.592595][    C0] mmc0: sdhci: Present:   0x01f000f0 | Host ctl: 0x00000030
[    4.599723][    C0] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
[    4.606849][    C0] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
[    4.613978][    C0] mmc0: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
[    4.621106][    C0] mmc0: sdhci: Int enab:  0x037f000b | Sig enab: 0x037f000b
[    4.628233][    C0] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[    4.635360][    C0] mmc0: sdhci: Caps:      0x1e6d0080 | Caps_1:   0x08000007
[    4.642489][    C0] mmc0: sdhci: Cmd:       0x0000153a | Max curr: 0x000003fc
[    4.649616][    C0] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000900
[    4.656743][    C0] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[    4.663881][    C0] mmc0: sdhci: Host ctl2: 0x00003005
[    4.669002][    C0] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000f0200200
[    4.811901][    C0] mmc0: sdhci: ============================================

.......

[    4.819456][    C0] mmc0: Got data interrupt 0x00200000 even though no data operation was in progress.
[    4.835111][    C0] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    4.835116][    C0] mmc0: sdhci: Sys addr:  0x00000001 | Version:  0x00000004
[    4.870574][    C0] mmc0: sdhci: Blk size:  0x00000080 | Blk cnt:  0x00000000
[    4.870580][    C0] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
[    4.920122][    C0] mmc0: sdhci: Present:   0x01f000f0 | Host ctl: 0x00000030
[    4.927249][    C0] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
[    4.934377][    C0] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
[    4.941506][    C0] mmc0: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
[    4.948631][    C0] mmc0: sdhci: Int enab:  0x037f000b | Sig enab: 0x037f000b
[    4.955759][    C0] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[    4.962887][    C0] mmc0: sdhci: Caps:      0x1e6d0080 | Caps_1:   0x08000007
[    4.970014][    C0] mmc0: sdhci: Cmd:       0x0000153a | Max curr: 0x000003fc
[    4.977143][    C0] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000900
[    4.984270][    C0] mmc0: sdhci: Resp[2]:   0x000ls00900 | Resp[3]:  0x00000000
[    4.991398][    C0] mmc0: sdhci: Host ctl2: 0x00003005
[    4.996526][    C0] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000f0200200
[    4.811901][    C0] mmc0: sdhci: ============================================

Wenchao Chen (1):
  mmc: sdhci: Fixed too many logs being printed during tuning

 drivers/mmc/host/sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.17.1

