Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D8863BD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiK2Jp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK2Jp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:45:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF07220F43;
        Tue, 29 Nov 2022 01:45:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p16so10437202wmc.3;
        Tue, 29 Nov 2022 01:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEjMM0ABy7i3UMzUbAY0TsEEBbd6pZsT6MyfoMMngkU=;
        b=YAZRv4bIBDi32Cyw324lJeX2UbEFkrfXrwdj7G95NwVVnmS/rnzfdVNW0MHlYFf8Nn
         dY7aKmYp58nNAmBJBtap0o3UGHp9x9JQZ2VcDWdt/SeDlVzKCj0TR5/DS6YJdX3WEPlv
         jreok8gX/NaShpnra/vVvwzDk51GXz1iZyWTXWLbGQqpwaHxWbViTpDmvsfHZDqh8w8V
         tvcfsCfRfskvjFvIG0iIL0r+6axjYsoHHbt+KOR+cwqL2jhEnj+lW9fF9ra7XvEjvrF8
         zcVdIPXBIGtzXIz4h/npMthncN93Y00T/7q/sXjB1AnqxctvkhNO2CKmgSU/inzPpTkq
         Xa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEjMM0ABy7i3UMzUbAY0TsEEBbd6pZsT6MyfoMMngkU=;
        b=u0iC6GRU+K8MZWvP7B7R3Y7pmrL75+VTPsgR2OGStKEllrCRvW/xubD4/adw9yDMIT
         rj9DEUwcnPg1RmCvViNt/e4oej/oYSVN3y/MY3xkn/i4xn2u2g0taRMWIftcN48Wg0XD
         fp4vNmQfsUoS+49qQ6vidmxfGXr03n2BJJIAJDSJGPXwdu8mLJxDfLKItEkn4EqGXSS0
         OjJhf7rhosi0lxc9067hRiLvL7Fl+oXQmgeVdLFFOStLoGvL6T6jvtg1U6Zo5zS+9xT5
         dAOaMQ4z+Ib4DADnm3/dBC5xcdGQ8UUjgAICp87U8PK7JEcfwZxWydZL4vvHt2idnDgZ
         zayw==
X-Gm-Message-State: ANoB5pmyxPIponCR38wEw1AFI8eWxdPWiv+JHcurxb7DjFIJrPH0LvMK
        GaAysNLUAYKFOaRye23A4JI=
X-Google-Smtp-Source: AA0mqf74WU9oWeewGoUGebW6w6di75az0boe0BRU2S83sfwwQ6Bm8rIbf+dPvFJp+HYZc5n0mwJBlQ==
X-Received: by 2002:a05:600c:3507:b0:3cf:8e62:f907 with SMTP id h7-20020a05600c350700b003cf8e62f907mr31984552wmq.7.1669715124533;
        Tue, 29 Nov 2022 01:45:24 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d4587000000b0022ae0965a8asm13003997wrq.24.2022.11.29.01.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 01:45:23 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:45:16 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] misc: fastrpc: fix error code in fastrpc_req_mmap()
Message-ID: <Y4XUrMETCl1O6t0A@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "err" variable shadows an earlier global variable so this code
returns success instead of a negative error code.

Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/misc/fastrpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c9902a1dcf5d..876f0f146b16 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1894,7 +1894,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	/* Add memory to static PD pool, protection thru hypervisor */
 	if (req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
 		struct qcom_scm_vmperm perm;
-		int err = 0;
 
 		perm.vmid = QCOM_SCM_VMID_HLOS;
 		perm.perm = QCOM_SCM_PERM_RWX;
-- 
2.35.1

