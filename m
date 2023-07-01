Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66933744983
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGAOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGAOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:06:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E888E60
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 07:06:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f8735ac3e3so4695853e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688220372; x=1690812372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/GvNDtCln3mttOJGf/TOdwCpXEhlkTWnrJx4RvWdwM=;
        b=Ks+QnT+fLgC0REedKsq6ZYblXr0OPOIYcR3pxSB4RldP8BK+6Ao6RFi62cO4CzInVQ
         cF/wFA4tt56MB5ejw27Tcg5x4Em+0EPBcZnDPGRmOg4apbbLXi/SkJh07g3dPNTNntxD
         yOKhawX9C+aNnFdy9BZDAGfOUQYIyD977YCVbJyTMKJSN7Wb3R09OqeSICnsqt3nchhG
         IAi+sH/2Krg04SpnuF8Hc07yXhol7tRdinOv8BtxHfZBaBEODDY/yxCU8s6TWTM42t4r
         /T8vXz0THeG/90v7SEynhu9a8J9BfObVMP0CTm3N8rDFGFI519AGaZEeFyvCR7rYyAyh
         0VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688220372; x=1690812372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/GvNDtCln3mttOJGf/TOdwCpXEhlkTWnrJx4RvWdwM=;
        b=BJ5GHR5qFhTrySB18ZTwX+usQvep0DrisHbB/hhxRotwFs9PLSIGDBBvar5dD6StFL
         JaeRlkWjMH/zsnj/CBr1QSmP/OhGR60ZXbA8WNeVxjSHD3pl5AiV7yz/Quc7JtQ+uM6u
         Ba7AhSE2+lrqFdhlsZdDz5IvW/hiKiSGB6GfiOHOIlIcWQexLeG4mQwvDgCB8yA2DIMU
         gMVlxNOsDgwl7mOG68tX0+EcVYLWhO7Hq837IQLtcLnjx3CeO/LoCMcyWz/R0dd2wqrn
         dmR2/cKb6pZR0C6RdvFHWFLDzGrgItO0dfjaExWu69OoY9rZnQwcW8bmlUMnr/HAtxT+
         E9yg==
X-Gm-Message-State: ABy/qLZQW7FLZqjZwTuWnD7HuVSQU/UWfjt5gD67KfZfevrU9vt1HIcH
        DUZV9mSsoDjQaLhq3Z9LaiI=
X-Google-Smtp-Source: APBJJlFR96QDw3TIO2gO0LlFDT9R6vIjC9Z0ojQV9hS+B6DNsisw0F85A1+B+HGvx1G6ukQSMJileA==
X-Received: by 2002:a05:6512:34c9:b0:4fb:820a:f87f with SMTP id w9-20020a05651234c900b004fb820af87fmr3870098lfr.10.1688220372178;
        Sat, 01 Jul 2023 07:06:12 -0700 (PDT)
Received: from localhost.localdomain ([77.222.24.81])
        by smtp.gmail.com with ESMTPSA id q2-20020ac25a02000000b004f122a378d4sm3426174lfn.163.2023.07.01.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 07:06:11 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH 0/1] fs/jfs: fix KASAN double-free warnings after failed jfs_remount()
Date:   Sat,  1 Jul 2023 17:05:41 +0300
Message-Id: <20230701140542.2252-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20221201124628.603505-1-liushixin2@huawei.com>
References: <20221201124628.603505-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tested-by: Andrew Kanner <andrew.kanner@gmail.com>
for https://lore.kernel.org/all/20221201124628.603505-1-liushixin2@huawei.com/T/

The next change complements the patch from Liu Shixin (see above).
Two patches for fs/jfs/jfs_{imap,dmap}.c fix syzkaller issues:
Link: https://syzkaller.appspot.com/bug?extid=9f06ddd18bf059dff2ad
Link: https://syzkaller.appspot.com/bug?extid=6a93efb725385bc4b2e9
Link: https://syzkaller.appspot.com/bug?extid=90a11e6b1e810785c6ff
Link: https://syzkaller.appspot.com/bug?extid=47366a6b503c7edf6bbb
And Similar bugs from the other branches:
Link: https://syzkaller.appspot.com/bug?extid=cfff8c52c283dd09bf27
Link: https://syzkaller.appspot.com/bug?extid=e8f9034a130a66a2b351
Link: https://syzkaller.appspot.com/bug?extid=5c604c1cc148275ab8a6
Link: https://syzkaller.appspot.com/bug?extid=ea731a6641531af62f80
Link: https://syzkaller.appspot.com/bug?extid=b212249c28280daa4576

Andrew Kanner (1):
  fs/jfs: prevent double-free in dbUnmount() after failed jfs_remount()

 fs/jfs/jfs_dmap.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.39.3

