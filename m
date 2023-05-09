Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71986FD272
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjEIWQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEIWQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:16:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4013A88
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:16:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30789a4c537so2548806f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 15:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1683670575; x=1686262575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hu65y9LQ0JYUL/b/I+3CE2Q5EL9XofrXHd9owDz27hI=;
        b=hBZrbLhMlpy/7oSVs0lTprrVy94U7upvFqODG929/y5dhCt9nV1hGalb0dMN0Bw0ER
         5DNOkwvSwT/9VKbM3+BNzR/TQk0etBwApXWwMlfJQB2sTqYOvpUFz9QSmWOgUudK9pvQ
         iEeIg4PuDTD83+ivdSQdwUf70PgfCfdoaFvcIcuEmyymE7/0yFkC8z3DT+/NWKxI0FU3
         x71z6oOvpTQQCc67HK51hOoKfaAjUcQDv9UXIbZ2QxmUmMjW54OydoPA2Koacp6atRiD
         B/avJ/CyKq22ldsN/3ZjA1hTQ+NkZYbXZSQttzNV6zHKe6pWl+YJ+cr9xwLEdACkltMN
         MOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683670575; x=1686262575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hu65y9LQ0JYUL/b/I+3CE2Q5EL9XofrXHd9owDz27hI=;
        b=edMF0St/ABdX1K1z1BguBpK0fLZ8NqMmSoxzW9TKOKnwGcR9zdLI8Td6+wDYLkGhUu
         hhfrACjoe7MSgVZ0XJt/hOBlDKMsozhrwq2dF+LU5GaNJSmoGGxTC1PP2YPJMu3FwdXX
         bF60EBcc5zaJtliPW1T3EykiVlvOEyF7pQyuG2a+qQSrmXUzaXC/T4GufYeC6IaYQRBs
         PJYNHFvhddrGagIwPtm8bfhFD5w4lfCkxndM2wanwkX/SRatt/8D//0eNo6D6RdBZ0MG
         n12Dm0gOXE0EMOCIBObqDOXKkxXQyA+Eeg9uPofhHagcYSo8sxROGBk63JZOQtIGIP3o
         VzRA==
X-Gm-Message-State: AC+VfDwMBZRILGFDm7kM2ECt+WhbCOwEKtHxJ/FKOULl2dFAbRNmRUVZ
        Dr22eLfY/NHN06TF1nAqCdPMIgKfilrsLYmoUgk=
X-Google-Smtp-Source: ACHHUZ79BTqG7tWfhK7o9CNI8lUq9aMIXawO83vQQ1z7O/72MkWFXZxOplN99ejMbyp9axkegONteQ==
X-Received: by 2002:adf:f54c:0:b0:307:a24f:c15e with SMTP id j12-20020adff54c000000b00307a24fc15emr3059912wrp.39.1683670575497;
        Tue, 09 May 2023 15:16:15 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b003f42d3111b8sm2052888wmj.30.2023.05.09.15.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 15:16:14 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Dmitry Safonov <dima@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Subject: [PATCH 0/5] net/tcp-md5: Verify segments on TIME_WAIT sockets
Date:   Tue,  9 May 2023 23:16:03 +0100
Message-Id: <20230509221608.2569333-1-dima@arista.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Started as a refactoring of tcp_v{4,6}_send_reset(), in order to prepare
it for TCP-AO signing for RST segments. As you can see the previous
TCP-AO-v5 [1] version of those functions, they get too big and nasty.
Patches 1 and 2 seem more-or-less straight-forward to me.

But then another thing that I wanted to fix for TCP-AO-version6 was
accepting of unsigned or incorrectly signed segments on twsk, which is
against RFC5925 (7.2) that requires checking the signature. So, I decided
to give it a shot and fix twsk for TCP-MD5 as well.
That seems more questionable, that's why I'm sending patch 3 as RFC.

And the last part, patches 4 and 5 are paranoid checks made to minimize
cases when inbound segment's signature and RST/ACK reply aren't consistent.
This is direct result of RFC2385 that lacks key rotation mechanism.
Probably, patches 4 and 5 are a bit too much, sending them for review
anyway in case such paranoia makes sense.

Thanks,
          Dmitry

Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Leonard Crestez <cdleonard@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

[1]: https://lore.kernel.org/all/20230403213420.1576559-9-dima@arista.com/T/#u

Dmitry Safonov (5):
  net/tcp: Separate TCP-MD5 signing from tcp_v{4,6}_send_reset()
  net/tcp: Use tcp_v6_md5_hash_skb() instead of .calc_md5_hash()
  [RFC] net/tcp-md5: Verify inbound segments on twsk
  [RFC] net/tcp-md5: Don't send RST if key (dis)appeared
  [RFC] net/tcp-md5: Don't send ACK if key (dis)appears

 include/net/tcp.h   |  18 +++-
 net/ipv4/tcp.c      |   9 +-
 net/ipv4/tcp_ipv4.c | 196 +++++++++++++++++++++++++-------------------
 net/ipv6/tcp_ipv6.c | 130 +++++++++++++++++------------
 4 files changed, 207 insertions(+), 146 deletions(-)


base-commit: ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab
-- 
2.40.0

