Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68105B6528
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiIMBnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIMBnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:43:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8146DB0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:43:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso9870254pjm.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uMQxC4XnWQGdaQBPEGIZBPNsJecw6so3J5h+1Fai3ks=;
        b=YjssLJx6G4+PiPct4xK2j4ANPn8pj9lsfmoxzttZjxxY3ZoJr/AXi4bZhtU/DVnydp
         gcFTJq38fj6+XHBAnjnVP73T50I1FBWXhJda9GD2EoSzfv8HMmx7so4ohVi744EBiFqK
         I2I0IhIW09v/Onf+NT5EgtCPn+4UzKg0cYqaEdleGqhhYIcfMYv9UFwHh9ezhD4C31iv
         b4j9eX5iqhReVkZiKg+CL1w7VsF2oYvgmDPn2+fJ9bqvEY6a8Ff2XXEzHuMVIdRG5San
         XJqA8g6y/fhtAcyuSuZnx4oB7O5dlu7zFwEzba4sAMSQz1o7aaWcM5x5hF0ULQYCmpZ6
         90yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uMQxC4XnWQGdaQBPEGIZBPNsJecw6so3J5h+1Fai3ks=;
        b=iSyPX7YmJTsCM1xe3Qt+G23Zx3RNDyksptamCaokm9Q/4dAAPvHhVnIM1pV+V2gLXn
         4u9D3f1dJM1tP6is4Wc32WZ9bDQ4azuIXNrRD+0hCwhG7CprsW2WgzR3/rnuAYHeY2Gg
         3X5I6yf/6vBHRKf6VuDsZXfWnAnD2JapVeLKw5pwO30vlPbfQoriwttq9nvN0dAEp0J6
         f8JTE1PK0SMObM/dCmIDnDPHysRNBKx+cldencw5u4PsXeXxf3MFXNQBJTf0o2yZeoBJ
         RbaoEpf5aNUW+7eY+1q1M4aDYN37Kgy66XHPFvlTZ9Ayu9I9dYN6fvL5pf7dHvXmEZ0d
         +I4Q==
X-Gm-Message-State: ACgBeo0sp+CfY082EFlMTYAhp6GRap7NpKoTrePQJ+4wOzb6n8s6Ll/V
        jzW0ttsPZu29BKjLFuic1f6wkA==
X-Google-Smtp-Source: AA6agR7mVYa43GyZuyICIpciot8SN89+kRGZ1KjtDkzgD58VeH3OR7XUXEmtBwRJJm1W1zarxLuYfA==
X-Received: by 2002:a17:902:d40c:b0:178:4439:69f9 with SMTP id b12-20020a170902d40c00b00178443969f9mr2117859ple.118.1663033409457;
        Mon, 12 Sep 2022 18:43:29 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id pg2-20020a17090b1e0200b001fd7fe7d369sm5885452pjb.54.2022.09.12.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 18:43:29 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me
Cc:     kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, fmdefrancesco@gmail.com,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 0/1] nvmet-tcp: Fix NULL pointer dereference during release
Date:   Tue, 13 Sep 2022 09:42:52 +0800
Message-Id: <20220913014253.931724-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sagi
I notice that this series "nvmet-tcp: Don't map pages which can't come from HIGHMEM"
has no reply for two weeks. Is it possible to fix this critical issue firstly?
Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>

v3 -> v4:
- free CMD buffers only nvmet_tcp_need_data_in().

v2 -> v3:
- Keep original function name as nvmet_tcp_uninit_data_in_cmds()
- Add new function nvmet_tcp_free_cmd_data_in_buffers() to free CMD buffers
- Rework against http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-6.0
- Move nvmet_tcp_free_cmd_data_in_buffers() after cancel_work_sync(&queue->io_work).
  Hi @Sagi, if you still prefer to clear the commands that are still waiting for
  data from the wire, please let me know.

v1 -> v2:
- Separate nvmet_tcp_uninit_data_in_cmds() into nvmet_tcp_uninit_req()
  & nvmet_tcp_uninit_data_in_cmds()(free buffers only).

v1:
- Move nvmet_tcp_uninit_data_in_cmds() after nvmet_sq_destroy()

zhenwei pi (1):
  nvmet-tcp: Fix NULL pointer dereference during release

 drivers/nvme/target/tcp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.20.1

