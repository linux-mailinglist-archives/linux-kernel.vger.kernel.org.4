Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC66573F717
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjF0I2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjF0I2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:28:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C3DE3;
        Tue, 27 Jun 2023 01:28:00 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76714d3c3a7so5317885a.3;
        Tue, 27 Jun 2023 01:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687854480; x=1690446480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrwwoxT0vSSJ9p34+9givCP8glsNGf9a7yRQU2/DFxE=;
        b=fKSytZi+loEhvTuPYHydy0FHz00uu54DITqA9mMOFr0Db+q/bOeGziJrNgKvUoB4pz
         vMRIEjkQ0de7l9PqwpSwsVNsLgVEeVme4swO3G/bSmJz4ZWz48bS2glP6SeJO0hZemfz
         YJykKQk6doPa+Nf4tteKZD8PvAA10acQPa1IUisqRZdq7uuS5nYNke/fj8JcBoN624hv
         Qdd0h8lHl1nsxUbsydrC9fbrXa1oN+jfpubH+vmPKM5vZYwF4173XSvSJUYeddR+4/uc
         /DVTWEML7NGtm6+pU8gNh0IEFuGDdyYxJgSBcxkII7nP7wvStFd4LHV/THaMUmjxAxMd
         WEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854480; x=1690446480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrwwoxT0vSSJ9p34+9givCP8glsNGf9a7yRQU2/DFxE=;
        b=OStuWMrLhA3Enop6t0RRbkN6ZWaoAfHHBExE//bcCvfaRy+ySjo0KST4isY+uSd7AZ
         wlTkuK0tfy56S0ZsWzuBox4eGc/mTexIBY3YftXbMlya98irqRRytScbia18Og0v577h
         orbwv7PFycX2nn2YsOVALfOUitptyWd0Z3bbIpbjyfF4d/5ckAT7wsvNK+Rtuy2Lrw9X
         vps3W5u67nWRNcMZJrJyeaASc7rqzNzhGVrlsjdPwe/uw3eKr/RCfRFFJRyMyZn5G5lb
         J/fVIZ1Uow1fhpeS/05nKDQKzwfBcoEdMJbbzyr2gJDSaPBfNQZemDIjr4Wpx0C1megs
         qsWg==
X-Gm-Message-State: AC+VfDyHNkbdwD2RvDN78nVu8G7bH4w0iP4HY90oOyNEr/oOcbBl/hlb
        g54Uvy6SU0GG6t0D9+xhXGA=
X-Google-Smtp-Source: ACHHUZ7w/W7ZClDH00v6Jt4+/t/W237umaNnhLowGJokoSm26UZwzMXp7bQqXWSdBkkctyRld/2VNg==
X-Received: by 2002:a05:620a:394c:b0:75d:209e:58c4 with SMTP id qs12-20020a05620a394c00b0075d209e58c4mr39459994qkn.10.1687854479994;
        Tue, 27 Jun 2023 01:27:59 -0700 (PDT)
Received: from hackyzh-VMware-Virtual-Platform.localdomain ([117.163.240.206])
        by smtp.gmail.com with ESMTPSA id lf14-20020a17090b484e00b0026094c23d0asm5658150pjb.17.2023.06.27.01.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:27:59 -0700 (PDT)
From:   yqsun1997@gmail.com
To:     mchehab@kernel.org
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 499671216@qq.com,
        yqsun1997 <yqsun1997@gmail.com>
Subject: [PATCH] OOB read and write in mdp_prepare_buffer
Date:   Tue, 27 Jun 2023 16:27:31 +0800
Message-Id: <20230627082731.1769620-1-yqsun1997@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yqsun1997 <yqsun1997@gmail.com>

Because format in struct img_image_buffer max index is IMG_MAX_PLANES ==3,
The num_planes max index is 8.so will be OOB like in mdp_prepare_buffer.

static void mdp_prepare_buffer(struct img_image_buffer *b,
                               struct mdp_frame *frame, struct vb2_buffer *vb)
{
        struct v4l2_pix_format_mplane *pix_mp = &frame->format.fmt.pix_mp;
        unsigned int i;

        b->format.colorformat = frame->mdp_fmt->mdp_color;
        b->format.ycbcr_prof = frame->ycbcr_prof;
        for (i = 0; i < pix_mp->num_planes; ++i) {
                u32 stride = mdp_fmt_get_stride(frame->mdp_fmt,
                        pix_mp->plane_fmt[i].bytesperline, i);

                b->format.plane_fmt[i].stride = stride;  //oob
                ......

Signed-off-by: yqsun1997 <yqsun1997@gmail.com>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
index ae0396806..e2e991a34 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
@@ -11,7 +11,7 @@
 
 #define IMG_MAX_HW_INPUTS	3
 #define IMG_MAX_HW_OUTPUTS	4
-#define IMG_MAX_PLANES		3
+#define IMG_MAX_PLANES		8
 #define IMG_MAX_COMPONENTS	20
 
 struct img_crop {
-- 
2.39.2

