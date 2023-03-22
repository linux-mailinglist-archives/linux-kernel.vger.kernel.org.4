Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8E36C4577
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCVI5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCVI5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:57:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C95F5D740
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:57:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id le6so18615268plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20210112.gappssmtp.com; s=20210112; t=1679475451;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Juje1TVQx9Ir6TCrjjYr/9fB6NcAn5fIZLLXlfSDEo=;
        b=oNQzP0dukP/A7MuNRdlbB7Kqk3Z1UH2gZqPOxBqV5zwD0alq000MNUTJ2tu/wlqNAb
         /sl+veH6npPUS+889YV+ZzJIAHNtu//H1xFA7WsX8Pj66Sf0Lhd+7zQujOzIBNlZGO/M
         4C4ipK5jHh1F6Qjpv8rH+WH3d/JhawU3CI9bAkWA1q8Px1JpVt+YhxX1Nzh5A9RqckL1
         +LU4E0gjJzmVyLG9S/mTHX6SOFNSjPPupOSmwMrgKe52dZB2hpADmN/wUtjjYy/JOK7A
         aHEMnxgU55bTIM2EzXWAbZKbUuAWeVceYKDVGm5D0VB80h6+HYyrqntlA1pSywrLIkes
         3KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679475451;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Juje1TVQx9Ir6TCrjjYr/9fB6NcAn5fIZLLXlfSDEo=;
        b=nyGmJv/L1DB64/cwxQC3E3HCwPW5yMEQSBmF9XGvWdqiK3aUJpsgy7NufaSvl8EPhT
         MfjmsJGJ62EvUIn5nyDe6uLOyrVM9VdzBlEImmpx2qcA0Ie5/O1vhtMS6iyrm1EjwwbR
         CvUFzleKgewVUxz4PJe+7HQIiM0rBdOXWOvIMFhM4JLWi1GeGnbEc/3ql1VjJvsCjnen
         ueVvnZSBF+8zaFn32DjdgY5WJIp2EpM+56Z/FLHDkQEbhI2x2hBeB95QDv0obNnAhqjf
         oJy4vYy9EJiQagz38MLDk7sEI8Y89+DFSdOzGwu91IzunX7CWjNMj0SplRRVs2yu4MOs
         dgCg==
X-Gm-Message-State: AO0yUKXmd5OQT+eiiXlANC+OI+qHHFJguaAyRG+bhZhCzeRQ4Wd30z4q
        vPI0iMm8B976zPD57hhowhrBJjrJlVrZlbt2plLw4g==
X-Google-Smtp-Source: AK7set8dI/0YZUWwik1LXJ9k+RGWdA5H1O9HkHJA/yPcJ9IgPwsEWVg+Ga1cCZ90yAwECJuOKN1oqw==
X-Received: by 2002:a17:903:430f:b0:19e:ecaf:c4b4 with SMTP id jz15-20020a170903430f00b0019eecafc4b4mr1970578plb.4.1679475451445;
        Wed, 22 Mar 2023 01:57:31 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id g5-20020a170902c38500b0019cbec6c17bsm10080147plg.190.2023.03.22.01.57.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:57:31 -0700 (PDT)
Message-ID: <6f3eb04dbe89d2b9f239600dd2c575227f3c0afc.camel@areca.com.tw>
Subject: [PATCH 0/5] scsi: arcmsr: fix reading buffer empty length error
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 Mar 2023 00:57:29 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patched were made over mkp's 6.4/scsi-staging

This series comtain some fixes.
- deprecated arcmsr_pci_unmap_dma()
- fixed ADAPTER_TYPE_B 64bits dma compatibility issue
- fixed reading buffer empty length error
- added driver proc_name
- updated driver's version to v1.50.00.13-20230206
---

