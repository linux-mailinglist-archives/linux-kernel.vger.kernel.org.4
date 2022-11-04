Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8A619013
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiKDFlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKDFl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:41:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3DA275CD;
        Thu,  3 Nov 2022 22:41:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso7308118pjc.0;
        Thu, 03 Nov 2022 22:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/BZyFt5dCsT73A04TLBbOghf3YLF5kXYNj3qEppPq5Y=;
        b=GOyEzehOcyRHUAlammU7EX9xRYhpA+YP4HPYMpKjovpagz8U6b8H/dV/9LC7A3Rv7z
         AuxQJcKBDJn/mP7obi/aEMAwYNI1Xn5pH1LkBZ6x0hJbVlZvpH1fYaDb1Kh9r9CaT8zu
         MSY+NsJdDzUYN+6VkC+KXowti8qjlc1G10BwbMY4GzVHlPf5JkPu3YLiYexmfJuf+d5F
         Sp3JNnhfIKQ1HdhKAT+8ipgGbQf4Of7LlL4lon0tktVxAmYuOOwY8gbnTLjBOmZ5A6zg
         booqWifuUzuyxxhwia00Sg8H0jof0+9oBzdsx8XaRXT7arCujN+pp9aO3zQjoawt7m6f
         fT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BZyFt5dCsT73A04TLBbOghf3YLF5kXYNj3qEppPq5Y=;
        b=Cqsfjpb/OXIOC9PWPvSuBs4uHwjLLVtPr8m/KHEpEAUrHGfDgin6l6ZFoRgXOB9Ff4
         TMHq/uWhrmGNCLpneqzhGJu4YMuXzrcHWuvkam1hkOKs4iekWzEOOb8jKO32Rx1MpzM1
         V3FQHB0K/K3McZ9NCLTvajtEnWOkJNOKd1et88uZZ62Dm57p+59sdtIhSD9sZDbH175+
         nDPR1z86lYNgW932CfmD0HerT/UojKpmCgFWp4lwuKTgQ3DdCYvHwNV0B7+Q7k5Yo64c
         E14EjiBYYgsR4Do+O7HEIfDlKVXs9Myk6SJHO4ehY3/mnurPpU+VgA6zzNQUItNhra1H
         uoUw==
X-Gm-Message-State: ACrzQf0A7MpVC9NyEjlc8k8EB1Rba+vx4JXI0TaW3vi7SvVWSOLsagE/
        64krewzoCDrUU2dYN6FdE3E=
X-Google-Smtp-Source: AMsMyM5ppXYAEctK4C52i9lpfUEFpfzLG/flwaMFtbqyr03aXVwRpcqL6NjtiSyJGTuT8RqckuL2aQ==
X-Received: by 2002:a17:902:b94c:b0:178:336f:13d6 with SMTP id h12-20020a170902b94c00b00178336f13d6mr34498524pls.64.1667540485964;
        Thu, 03 Nov 2022 22:41:25 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id q15-20020aa7960f000000b0056bdc3f5b29sm1684043pfg.186.2022.11.03.22.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 22:41:25 -0700 (PDT)
From:   TGSP <tgsp002@gmail.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        huanglei@kylinos.cn
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        TGSP <tgsp002@gmail.com>
Subject: [PATCH v2 0/2] Fixes to the hibernate_preallocate_memory()
Date:   Fri,  4 Nov 2022 13:41:17 +0800
Message-Id: <20221104054119.1946073-1-tgsp002@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- Optimize code to resolve compilation warnings;
- Add comments, add debug data, easy to view and modify.

v1:
hibernate_preallocate_memory() function is still quite obscure, can
anyone add a little more description?

It seems that the max_size calculation formula is wrong in the comment
part, correct it;

It is also found that when mem preallocate is not enough, it goes
directly down without checking.

xiongxin (2):
  PM: hibernate: fix spelling mistake for annotation
  PM: hibernate: add check of preallocate mem for image size pages

 kernel/power/snapshot.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.25.1

