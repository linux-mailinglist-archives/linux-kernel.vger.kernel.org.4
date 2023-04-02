Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7EB6D35BE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 08:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDBGJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 02:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDBGJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 02:09:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE9ECC38
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 23:09:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y15so34061851lfa.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 23:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680415784;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lsXTEp7FbhggkMUlDS7NN/d5tz27dwG9u3dRAsKzoXU=;
        b=fUkTIHSWsNjyD1Rmc5J2CGoBBiyeu3kNglkFdw5dzmRLNKIRDjih/MIhyUqoJEbzIY
         dszodUjoZiGW3mMThvrP0X6rmMzqW0vVgcyShhgnjK/dNyXy4+1JmrDbkt4pdyY1zzvy
         Gn4n9UXwq7ww2aCBciqrjzmb0KHKxAs7ShOi1ymelb8ty/jgrZwKfVzuMU/mpJPu1R7H
         Wmsh2PE4S5EMRguEzJ6A1l+tc1Jmsr2vHqEQPNlHKa79c7qU1FRdQUsPWeQ/RJ8p6sOl
         eCfK6bmUnGfCrvRM81vd75WmwyvPwRBbHXUccNp0PGr6Kgi/1gF6hAy5OGfr6vUcdo4J
         r/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680415784;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsXTEp7FbhggkMUlDS7NN/d5tz27dwG9u3dRAsKzoXU=;
        b=sSRJcj7g261VLgn81WKB6GG6bn90x4ZySkDX7BVYyhkmFq3Ss8xj9VYKFetV9Z1Ozo
         PBCUj4qXtp6tD4l7Oh+Wcz1oGWxiVlJSmV1kQ17ST1o72QkCvcug2Y1L/aIyH7LQslqk
         WwWGJ71Xnq1RJFHt8yP45El8sRL4Gjz0ystSfaA2BaTasm92X6f7CSIpoBJtEicxXUtu
         l832B+7/K76DYgn824z6nhEgEzBFhjv5t1zPt8L+qtcniVI+QoA3YvNQk7RoVEsdzIuR
         6M6rE2+luCrpI73HjtQk4jG3oCtpgcmS2GaIDA6tl03c8KciumPw65JaXf2ukwKCGfTQ
         QYlw==
X-Gm-Message-State: AAQBX9dgcaSFgRbTfyY0x32NelLsqGYPSxdDtBMxFXW4Z5Pxx7Ju8/WK
        cOjrxPiaT3LlG7HwaOZ+anKeqGyK9mzKgvZ9/LveUw==
X-Google-Smtp-Source: AKy350abb6pNFqf927JIl8e8JKn/AD9RagEWkKzvRHjgEA89b0HVj4z8VqqcP9WVzCEziRrFe+hIYzS9MtLoRq5MI2M=
X-Received: by 2002:ac2:5d6d:0:b0:4eb:f3d:94b3 with SMTP id
 h13-20020ac25d6d000000b004eb0f3d94b3mr7079231lft.6.1680415784478; Sat, 01 Apr
 2023 23:09:44 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 2 Apr 2023 08:09:32 +0200
Message-ID: <CACT4Y+a4nfXCdmwcS2GqiqScP5b-y4kdi9TC6pUHHHO13VJSHw@mail.gmail.com>
Subject: INFO: task hung in tcindex_partial_destroy_work
To:     syzbot+e3c2598c1486366a941b@syzkaller.appspotmail.com
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://syzkaller.appspot.com/bug?id=d30e0944e156e2c50663c9ce7fee299d5c23ddd7
#syz fix: net/sched: Retire tcindex classifier
