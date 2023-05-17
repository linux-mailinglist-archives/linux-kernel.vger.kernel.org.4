Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444B2706868
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjEQMmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjEQMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:42:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDF8211C;
        Wed, 17 May 2023 05:42:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-64384274895so497006b3a.2;
        Wed, 17 May 2023 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684327328; x=1686919328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdNngZhsKhcXNCAWoCajdyQW0IMTNw0nIYVCN7bYTSU=;
        b=TZQUdKyniQjbEM8cAFb8uyX9CbMNswaIhc51dp0m7XKiPT0Fl6Ik+avjN9tUPoadEF
         pKenfSIxInRPBretbCTpojzxlaup7EVmiolpppd5MZW3ttsp9X47uAWwW0AIOM6Ki/rn
         Q8IUtZmPrZhQqHP0G4oQOzzvsJNPs6EcjQ/Gz/YQNfk71Vpcj2vM9zALZ/Q+wK8wBpN2
         qs3iAlS2fQLJc1UN+epgWSe1ZTC5e4MMyfxQi72GgOuBos2Ms30olwuQKr3W7CCma5Cq
         J3LifgTvfn4LvOS8E6C+UMUqR/2Vk4oDGL3YDOf/oez/PchSDzXvG3a5yF5addp15beQ
         Hdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684327328; x=1686919328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdNngZhsKhcXNCAWoCajdyQW0IMTNw0nIYVCN7bYTSU=;
        b=SuvKh076tr6KJC0nv5UcN1ovzwB7ELaSSk7zYcXIbeOzBqKCaV+D1Yq46ZblGm8RaN
         6BvzTArStJ1Rf/YiF1ofB845Dn2sg2Zkg0xie7w8TzM+6kbHC+rIl/SGPRNk67lNiPCf
         4eX3gW27G0mNP/ZH5+E1qcjKMa/lbu4uiZOOzbRcKVp/h4/tLrg4GxUqJaNhADn4SLwC
         CxjcDpNFmyoi19XBuf1BnyIHUGHDFQ6JtGbHUlTb6TKwBW/im7twE4mVRfXyQ7h5cYvd
         BR5D04vfws72G0OC4KTKAdI3TIdZCHAJIpUViBbCP0aL4e5TD4TpmIG2v4g9LQRyUtsl
         Tv3w==
X-Gm-Message-State: AC+VfDxZ6P1w/uy6Q9uclbgibAlFUr2ggbpeVFy0L78Kg02PTbHj96su
        h7VgdXEQeABdcsMtXf4qZxk=
X-Google-Smtp-Source: ACHHUZ4mtDHCwO90lxd6Y56Dyd9JXU+4HwycijJE4OYjx9N5xrIGd+1awQd5cyd0ZV03gPOism++qA==
X-Received: by 2002:aa7:88d0:0:b0:646:663a:9d60 with SMTP id k16-20020aa788d0000000b00646663a9d60mr994827pff.10.1684327327983;
        Wed, 17 May 2023 05:42:07 -0700 (PDT)
Received: from localhost.localdomain ([81.70.217.19])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b0064aea45b040sm9244224pfn.168.2023.05.17.05.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:42:07 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     kuba@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next 0/3] net: tcp: add support of window shrink
Date:   Wed, 17 May 2023 20:41:58 +0800
Message-Id: <20230517124201.441634-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

For now, skb will be dropped when no memory, which makes client keep
retrans util timeout and it's not friendly to the users.

Therefore, now we force to receive one packet on current socket when
the protocol memory is out of the limitation. Then, this socket will
stay in 'no mem' status, util protocol memory is available.

When a socket is in 'no mem' status, it's receive window will become
0, which means window shrink happens. For the sender, it need to
cover this case, and we turn it into zero-window probe status.

In the origin logic, 0 probe is triggered only when there is no any
data in the retrans queue and the receive window can't hold the data
of the 1th packet in the send queue.

Now, let's change it and trigger the 0 probe in such cases:

- if the retrans queue has data and the 1th packet in it is not within
  the receive window, which is for window shrink case, as the shrinked
  window may can't cover the data in retrans queue.
- no data in the retrans queue and the 1th packet in the send queue is
  out of the end of the receive window

And the sysctl 'tcp_wnd_shrink' is also introduced. In order to keep
safe, we disable this feature by default.

*** BLURB HERE ***

Menglong Dong (3):
  net: tcp: add sysctl for controling tcp window shrink
  net: tcp: send zero-window when no memory
  net: tcp: handle window shrink properly

 include/net/sock.h         |  1 +
 include/net/tcp.h          | 22 ++++++++++++++++
 net/ipv4/sysctl_net_ipv4.c |  9 +++++++
 net/ipv4/tcp.c             |  3 +++
 net/ipv4/tcp_input.c       | 53 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_output.c      | 10 +++++--
 net/ipv4/tcp_timer.c       |  4 +--
 7 files changed, 97 insertions(+), 5 deletions(-)

-- 
2.40.1

