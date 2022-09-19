Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99C75BCC15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiISMoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiISMnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:43:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D2E2F03B;
        Mon, 19 Sep 2022 05:43:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y5so3773522wrh.3;
        Mon, 19 Sep 2022 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=oXWgWaZsc822Q0ES3rj4eUwa/2EGT0461kz7ecX1tRE=;
        b=Edus4t6gzW0NKtAnKX9Z9Fbg0McLpg4JEkXwQBvm0W5Mom/ZtGI3S//hvLLeJhk6WI
         HJn+walUkx+0q2hxuGprZJeYrrCMd+1L2bR+sgOS+3SeY5bEH930rlP74ILCxlPSoNsy
         TNxQxJxfXDaoWXTzS/jBtjBZe1kKUmX+OSdJ97vf4Hl1PAsQkuMONfhRWsKVbHDl62qO
         wXS4PgJKDp5VyJWIRMHZASZuNLgOGPcs8cw2AWrKGjrwFM3YmDmlZh0XMD4zCfCE4EXc
         H7RLDI9dHeABgkoAsDo31ARgRkb4Eh5W/nEDlRCf1bnt1mVBmwz9r1MeYyzGOT2xurKy
         V8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oXWgWaZsc822Q0ES3rj4eUwa/2EGT0461kz7ecX1tRE=;
        b=NLChga3AzGOC0vd3a0L+RQGyAY+V/LItSmmerUegqcwd7CoEcgbXm4VcnUFEO6TXYb
         w/UMAag3HZRzR5Qgookt65VRIFJgG5ZKBaJ9uQHnygP9SaeG2ofIqXoFu1lmMlyijdEW
         IKmjONrq/4MiPTw3AMliQlS+Rxgi/h4gIsvrN1v8MLXkf7lz4xe8bhkIdzuk+KUkd2RT
         5ShvdIjDSv0SceHmUyO7f7ZzxjvyUQqt+otMYrOuoIiyEaxNJEX6V/HrBJz8AbFHt11a
         zS12aROZMlnd3C8/nC1W5HUd2UyLQVJIOtmETfNEOz7eT/P9GmGoXNgGBUt8gsTBZsnE
         P28g==
X-Gm-Message-State: ACrzQf0BA1GwbPvorsf2bBm9G1hriwco3lXlE9vq4kfTo5yNhhAvUwVp
        d20Z9sZ5nLOZh5T8BYmCpFQ=
X-Google-Smtp-Source: AMsMyM6dm9Y7MpEZZDT4IY9gaQPS/o6y+5OjHwyWUooII0Hg5HjhF6d0L8efsR2qgYW1/lOw1wuytw==
X-Received: by 2002:adf:d1cc:0:b0:22a:47d5:8a22 with SMTP id b12-20020adfd1cc000000b0022a47d58a22mr10490469wrd.481.1663591421435;
        Mon, 19 Sep 2022 05:43:41 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id c11-20020adffb0b000000b00228d52b935asm13905566wrr.71.2022.09.19.05.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:43:40 -0700 (PDT)
Date:   Mon, 19 Sep 2022 13:43:38 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220919 due to c0357a73fa4a ("arm64/sysreg:
 Align field names in ID_AA64DFR0_EL1 with architecture")
Message-ID: <Yyhj+gqfS6mdRnGv@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of arm64 allmodconfig have failed to build next-20220919
with the error:

drivers/perf/arm_spe_pmu.c: In function 'arm_spe_pmsevfr_res0':
drivers/perf/arm_spe_pmu.c:679:14: error: 'ID_AA64DFR0_PMSVER_8_2' undeclared (first use in this function); did you mean 'ID_AA64DFR0_EL1_PMSVer_IMP'?
  679 |         case ID_AA64DFR0_PMSVER_8_2:
      |              ^~~~~~~~~~~~~~~~~~~~~~
      |              ID_AA64DFR0_EL1_PMSVer_IMP
drivers/perf/arm_spe_pmu.c:679:14: note: each undeclared identifier is reported only once for each function it appears in
drivers/perf/arm_spe_pmu.c:681:14: error: 'ID_AA64DFR0_PMSVER_8_3' undeclared (first use in this function); did you mean 'ID_AA64DFR0_EL1_PMSVer_IMP'?
  681 |         case ID_AA64DFR0_PMSVER_8_3:
      |              ^~~~~~~~~~~~~~~~~~~~~~
      |              ID_AA64DFR0_EL1_PMSVer_IMP
drivers/perf/arm_spe_pmu.c: In function '__arm_spe_pmu_dev_probe':
drivers/perf/arm_spe_pmu.c:963:52: error: 'ID_AA64DFR0_PMSVER_SHIFT' undeclared (first use in this function); did you mean 'ID_AA64DFR0_EL1_PMSVer_SHIFT'?
  963 |                                                    ID_AA64DFR0_PMSVER_SHIFT);
      |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~
      |                                                    ID_AA64DFR0_EL1_PMSVer_SHIFT


git bisect pointed to c0357a73fa4a ("arm64/sysreg: Align field names in ID_AA64DFR0_EL1 with architecture").

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
