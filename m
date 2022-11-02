Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9C616F74
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKBVOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKBVOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:14:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391ADBC2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:13:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h9so139360wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns47bvu92RN1o/ST22gXYBYxxkJNfGwoF1/G0Fam6ZU=;
        b=P/jap1+f1RnlBrKQ5nOOYo+gEz7RfjfVWA1cqgzorpmFJzBkbPumvPweSEymhIETKV
         Wr3DgX9ti2aUAs4JLvBwgXbbVhjsXBMTpnrvOt9B9DRLpvOwjp0uQ4HS8IWTzzviU6ka
         j+gVSFVhzAWBfXi9HaH6Ph/QnU9VU6wvJrpEXH0871rASpyoMbtjBP/YNr+g5hyFaUtV
         lpCO9x1jo70oyWcOirhNbtJEEBqKUmdP3dt3/jmk+LgWRzLoh/eyj2Sz1vuVqBaLeJk9
         EQ9LLt2eR/amdapxof8dOj4AzsKE1oyBn7vLS9iVGYAsd5KK6Fa/YRU6G9zwto8SjStt
         SGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ns47bvu92RN1o/ST22gXYBYxxkJNfGwoF1/G0Fam6ZU=;
        b=cSq3znmG7LWvHlHxfodqosryneqBjTViuJYH2ZF3/vw3UlYtgxqiPgUINkH1MHKIez
         Ec9gKjaTavvn2lhlrUKAfJVcxrRjqeUs5tMM3XMqxnycKPIfcfkqLHbBir6Kv/Itdk2O
         DGpkJG3QOAr6YG85NIuC7eX5JK8kD0vDKJ1Jy6UHFKflv52BYoBb1ocnn2UBmvmBV6U+
         hgYqPNQv3WlchPdwUNhjHx6MZDR8Hwl6NgH+0DzJMDrxnaf+CAPcYvNT8g2515E+Kc3y
         OO4CjnGzzzRhGVC5vT1PzH6cqeokjwWiRSueABPftIGz+JvImnIQafOhn7Uwm+oHQDo1
         abKA==
X-Gm-Message-State: ACrzQf3gCvQNHAP6q8vnVZVj23hQrNvGMGInmYJ/0O025OJB9rSeVYdt
        k8TK4c1Z3rSZEB8ELk1QFyR0J8UoKWK6rw==
X-Google-Smtp-Source: AMsMyM7ztfbtC4swakuetRFq6TocNcEe3huQmympPzaW2QCSFJcHJAaDgWSWPc1z2/XBuVIU79BjoA==
X-Received: by 2002:adf:cc92:0:b0:236:77f0:ef5f with SMTP id p18-20020adfcc92000000b0023677f0ef5fmr16813625wrj.198.1667423637443;
        Wed, 02 Nov 2022 14:13:57 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id cc6-20020a5d5c06000000b002364835caacsm14179851wrb.112.2022.11.02.14.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:13:56 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        Bob Gilligan <gilligan@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Subject: [PATCH 0/2] net/tcp: Dynamically disable TCP-MD5 static key
Date:   Wed,  2 Nov 2022 21:13:48 +0000
Message-Id: <20221102211350.625011-1-dima@arista.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static key introduced by commit 6015c71e656b ("tcp: md5: add
tcp_md5_needed jump label") is a fast-path optimization aimed at
avoiding a cache line miss.
Once an MD5 key is introduced in the system the static key is enabled
and never disabled. Address this by disabling the static key when
the last tcp_md5sig_info in system is destroyed.

Previously it was submitted as a part of TCP-AO patches set [1].
Now in attempt to split 36 patches submission, I send this independently.

Cc: Bob Gilligan <gilligan@arista.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Francesco Ruggeri <fruggeri@arista.com>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

[1]: https://lore.kernel.org/all/20221027204347.529913-1-dima@arista.com/T/#u

Thanks,
            Dmitry

Dmitry Safonov (2):
  net/tcp: Separate tcp_md5sig_info allocation into
    tcp_md5sig_info_add()
  net/tcp: Disable TCP-MD5 static key on tcp_md5sig_info destruction

 include/net/tcp.h        | 10 ++++--
 net/ipv4/tcp.c           |  5 +--
 net/ipv4/tcp_ipv4.c      | 74 +++++++++++++++++++++++++++++++---------
 net/ipv4/tcp_minisocks.c |  9 +++--
 net/ipv4/tcp_output.c    |  4 +--
 net/ipv6/tcp_ipv6.c      | 10 +++---
 6 files changed, 78 insertions(+), 34 deletions(-)


base-commit: 8f71a2b3f435f29b787537d1abedaa7d8ebe6647
-- 
2.38.1

