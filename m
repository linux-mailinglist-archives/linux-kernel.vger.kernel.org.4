Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C0E6DA59A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjDFWMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjDFWM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:12:29 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB4AD12
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:12:28 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x8so29242585qvr.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680819146; x=1683411146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fW4p3CWRy3YFnZGik37i4u5NW3rO+Fa7QgtRSx1BTMg=;
        b=iZpgUkNa0YIj8jKueQGxpuVCmhoCMUdJC4OdH80mhlTPYJWq7xHUCoJ9BB02EOYPQW
         uXo4FMUxNc/t0hoTuLCVOqnYHmshsYkTZLftVPsnpZP6XuxYSJ/sE/rJYHSAuA+HRzNz
         sl1Ta2N5rM3tX+5tE5xiO1m8lD1ORtX4xIjwbcpXO4WTTE37cGHxbGYw38Tuo/V7SVfd
         dgxN5wgHk9h8sTY2y7oFaFCbGUOYQwjAKinkPiUOFg0o7jDvF7MB6ToBoEnRlk7ezbYR
         WVCTPFAH2pF5D/Eofpyrx3pTbPXDjwDZOmRKi0wi7HhNcsqeUm7ltu75RvaCqTjAPaeQ
         Fdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819146; x=1683411146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fW4p3CWRy3YFnZGik37i4u5NW3rO+Fa7QgtRSx1BTMg=;
        b=pxqS1Vd5XvSS59FqkylG8/eJzO1TODWPVlPaGklpeY3E2kCza+EDe6Dh4H1Rs9+BzX
         mMSibNnE8359Cul71wqmkECK/IkAwI0UnY+wixQxeU3aJCT+YkSdRViYMbUzt6DCOBwg
         cLm8TnEp1gbtipN/dfjRVrSgWxn+0YXNWduBxczwTG4T+lw2ohC2qNS5oJhGfc56SNfw
         Zoz9KDM70pnoa1IALRetgtITZJl+ienjxxkedlhxSvujhM/boLxJNKWY+L0OyVc6pf2V
         nd+Yz6vmODKwKBUuFNpmruL/7QKoRJ4CoF4ttcxFSGoojS1scBud3IOklMGlXBfHWoCH
         KrcA==
X-Gm-Message-State: AAQBX9c47p4zuO7z8CTeSKRhc4rmDo36yHFkSkjwvnZT489VT3TJbZf1
        VfLc6A+fGRrMFlYhqJSSEOPEJBDWCjEEqg==
X-Google-Smtp-Source: AKy350YbsX+Zgln54c6e8EtJrcPr/tLMcDbMtlA9jS+EHJv813dJ4uwSMlEM08BCSVXqVXEpUH3cXQ==
X-Received: by 2002:ad4:4eaf:0:b0:5b0:67f3:d91b with SMTP id ed15-20020ad44eaf000000b005b067f3d91bmr1210895qvb.35.1680819146637;
        Thu, 06 Apr 2023 15:12:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ks15-20020a056214310f00b005dd8b9345e2sm816353qvb.122.2023.04.06.15.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:12:25 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH RESEND 0/3] scripts/gdb: timerlist fixes
Date:   Thu,  6 Apr 2023 15:12:14 -0700
Message-Id: <20230406221217.1585486-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Since you have been collecting my patches touching scripts/gdb,
(re)sending those fixes from Amjad that restore a functional
"lx-timerlist" scripts.

Thanks!

Amjad Ouled-Ameur (3):
  scripts/gdb: timerlist: use range instead of xrange
  scripts/gdb: timerlist: fix rb_node access
  scripts/gdb: timerlist: convert int chunks to str

 scripts/gdb/linux/timerlist.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.34.1

