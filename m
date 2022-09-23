Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12455E79D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiIWLmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiIWLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:42:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA6B139430;
        Fri, 23 Sep 2022 04:42:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g3so19955693wrq.13;
        Fri, 23 Sep 2022 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=qInd8OshU6iSqvY25zhNaMe3YYc1iLfJiCD+P5Z80PY=;
        b=NknAA532T2w2I12EWWoVE0IuVNlt0YadBipCxkk3Ope2yQ0W6Wyyu2LuIncxTuFOkk
         Li/n9zJVTkGncwR/zWPt3uN2Q5y1oNUJ14gWD376d8XTHA5P2zMlGdmfQ0cBHSpztyxP
         VUXKcUvNdXO35E38CaxmdLeDjFpqYrkPpUodZ/1IJk5fBfB4oeSiZwiQOKsZoRmWrKTh
         Z6v3KWfpbGMeYAX9LeDQlETM9a/KZ5M3A9R8ZQfa6wTLAEFUtnVP71IzUDT8FIKQgYOF
         h18vIDou369nrWST5DRrb7CiapqsDMT6McMXnsK8A+qTmxjftsdTiJeAHX2I+li5vkRH
         qS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qInd8OshU6iSqvY25zhNaMe3YYc1iLfJiCD+P5Z80PY=;
        b=v6m7o4uK0rxYO7jiM6iyjZkC6CjtJMYHGS+2HQnj88o1yRESK6qyP94xT2/+RhgKZj
         Q1l+wlHMDEFyElv02JwXcJnRpG64eN28Ans0Oiqy1218D/rbtAGpeXUmKbX+bgAOfECo
         36MmOTo/jUk4SKLZL5d4nv4RIK0iqx1WsZklj+HSMqoI2125TPXx602nQTZJbWYVZiOH
         6PLwSrltZmH2UOwb+1CFbYgEld4ADQA5SJ8Zh23ULVbYfB42QJsgKdp919YT4gemiE7X
         TpXxqRXf5hOb4NaM5oV+SlSNwVXIMGWUNqggbDet5tLIiauge7AOfPqTFhgsdMKxql4s
         gF/w==
X-Gm-Message-State: ACrzQf2k/2O6lV0t72S7gWpzKRf25ENO1XaAq3beQnupSb80moVwue87
        kUSzWC4DkiY0fHKL01nCtS4=
X-Google-Smtp-Source: AMsMyM42pwRjd6ykyQSHUhJseiAJeHfZDyk7MCvtj7lm3nQnnqHmG83zdL5DA+11iBZmFzt0kCkgXA==
X-Received: by 2002:adf:f00b:0:b0:22a:906d:358d with SMTP id j11-20020adff00b000000b0022a906d358dmr5033191wro.464.1663933359634;
        Fri, 23 Sep 2022 04:42:39 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id p21-20020a1c5455000000b003b27f644488sm2231717wmi.29.2022.09.23.04.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 04:42:39 -0700 (PDT)
Date:   Fri, 23 Sep 2022 12:42:37 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     James Clark <james.clark@arm.com>, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220923 due to cbb0c02caf4b ("perf: arm64:
 Add SVE vector granule register to user regs")
Message-ID: <Yy2braL3vc0SYDGl@debian>
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

A native build of next-20220923 on arm64 host has failed with the error:

./usr/include/asm/perf_regs.h:42:26: error: C++ style comments are not allowed in ISO C90
   42 |  PERF_REG_ARM64_VG = 46, // SVE Vector Granule
      |                          ^
./usr/include/asm/perf_regs.h:42:26: note: (this will be reported only once per input file)

I have not bisected but I think it will be from cbb0c02caf4b ("perf: arm64: Add SVE vector granule register to user regs").

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
