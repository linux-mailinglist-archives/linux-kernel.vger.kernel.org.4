Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B30636764
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbiKWRjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbiKWRjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:39:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9715A8FF9C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:39:08 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e11so17595980wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBbCqsvEtt7KcugR7dnR//LPLGg791OqMuilfbsHMq8=;
        b=LfZLUeC55V2LhChnueGr1rbfHkquuf9jzJkH3uVMjuCZz98dTepMZq1QzLonH03xKg
         /AHzZ58ERxejSksjrKlSJRqM1JVew09umBvXKetZ8fdlrSDXzfH3U+Aymwy0VmqNluR0
         xifnLLXdIh5HFeQ+zbMUsCaYdB6caOjNNOvnG9Cp8FOqm0kLvB16QM0zUtSvPWeJheuW
         hkW4NAFOuomj2Et+OGV6jv++z6qJywxpR5S3N/2EPKl2bVK0Oci07UPAkc7phGk8MfhT
         Eyynp6tkUElg8eWTj7Pz0bKXuqB3TUj6Hk6hFjmxgpU86qsSQBWibw6aIsWrpZaQ/2dK
         swcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBbCqsvEtt7KcugR7dnR//LPLGg791OqMuilfbsHMq8=;
        b=3D7H6Qahhn8Cp3s68esqUuDqk2H+V2pScy/lHDEgCOv4IJ1AXu8iqpegCoScjnCRpc
         M9+85sMRPB28S+HBvrhl0eoTmbE9/quWB/MDKHB3P0fGVK/z66XtvetPWzYf0vlQc5sZ
         PIMgJPIcah1cbJOBKYj7LW6+iSSFCoTwiYnYCYUNN6ITPqN30waLIK2s+Nynp3BVu7Bq
         LFnT/cUWfozZYh8LCQpWqIXRDGVVj5lhg9Yo88xpfPINZ5ySmX3/3nNPO80zYjVTu2KW
         Ixdj6yUr1hQsem1eYiKUIpsF/3jnrNYhrTYOGSPdPGeriCygw+sV0h2u6i9ClbpRVw3b
         ri5g==
X-Gm-Message-State: ANoB5pkS0F54RCjUoipA797r5Nnt9fm2IRhlbHI9ZXC7WVxc22A6farx
        oxO6NAyZmhkNSc5gyHEdLP7oz5ttDP9Wsw==
X-Google-Smtp-Source: AA0mqf4+yuJToqATfc3o7OV5ctry2RiwELc2lWbtaDufsynR58YIu4rk7/VIpeQjQGEBaqbQdoGA+w==
X-Received: by 2002:a05:6000:510:b0:22e:3ca6:d4ab with SMTP id a16-20020a056000051000b0022e3ca6d4abmr18793779wrf.658.1669225146829;
        Wed, 23 Nov 2022 09:39:06 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v10-20020adfe28a000000b0023647841c5bsm17464636wri.60.2022.11.23.09.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:39:06 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Safonov <dima@arista.com>, Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org
Subject: [PATCH v6 0/5] net/tcp: Dynamically disable TCP-MD5 static key
Date:   Wed, 23 Nov 2022 17:38:54 +0000
Message-Id: <20221123173859.473629-1-dima@arista.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v5:
- Corrected comment for static_key_fast_inc_not_negative() (Peter)
- Renamed static_key_fast_inc_not_negative() =>
  static_key_fast_inc_not_disabled() (as suggested by Peter)
- static_key_fast_inc_not_disabled() is exported and declared in the
  patch 1 that defines it, rather than in patch 3 that uses it (Peter)

Changes from v4:
- Used rcu_dereference_protected() for tp->md5sig_info in
  tcp_md5_do_add() and tcp_md5_key_copy() fail paths to make sure
  there won't be false-positives from sparse (Jakub)
- Added Acked-by: Jakub Kicinski

Changes from v3:
- Used atomic_try_cmpxchg() as suggested by Peter Zijlstra
- Renamed static_key_fast_inc() => static_key_fast_inc_not_negative()
  (addressing Peter Zijlstra's review)
- Based on linux-tip/master
- tcp_md5_key_copy() now does net_warn_ratelimited()
  (addressing Peter Zijlstra's review)
  tcp_md5_do_add() does not as it returns -EUSERS from setsockopt()
  syscall back to the userspace
- Corrected WARN_ON_ONCE(!static_key_fast_inc(key))
  (Spotted by Jason Baron)
- Moved declaration of static_key_fast_inc_not_negative() and its
  EXPORT_SYMBOL_GPL() to the patch 3 that uses it,
  "net/tcp: Disable TCP-MD5 static key on tcp_md5sig_info destruction"
  (addressing Peter Zijlstra's review)
- Added patch 4 that destroys the newly created request socket
  if md5 info allocation or static_key increment was unsuccessful.
  Instead of proceeding to add a socket without TCP-MD5 keys.
- Added patch 5 that separates helper tcp_time_wait_init()
  and converts BUG_ON() to WARN_ON_ONCE().

Changes from v2:
- Prevent key->enabled from turning negative by overflow from
  static_key_slow_inc() or static_key_fast_inc()
  (addressing Peter Zijlstra's review)
- Added checks if static_branch_inc() and static_key_fast_int()
  were successful to TCP-MD5 code.

Changes from v1:
- Add static_key_fast_inc() helper rather than open-coded atomic_inc()
  (as suggested by Eric Dumazet)

Version 5:
https://lore.kernel.org/all/20221122185534.308643-1-dima@arista.com/T/#u
Version 4:
https://lore.kernel.org/all/20221115211905.1685426-1-dima@arista.com/T/#u
Version 3:
https://lore.kernel.org/all/20221111212320.1386566-1-dima@arista.com/T/#u
Version 2: 
https://lore.kernel.org/all/20221103212524.865762-1-dima@arista.com/T/#u
Version 1: 
https://lore.kernel.org/all/20221102211350.625011-1-dima@arista.com/T/#u

The static key introduced by commit 6015c71e656b ("tcp: md5: add
tcp_md5_needed jump label") is a fast-path optimization aimed at
avoiding a cache line miss.
Once an MD5 key is introduced in the system the static key is enabled
and never disabled. Address this by disabling the static key when
the last tcp_md5sig_info in system is destroyed.

Previously it was submitted as a part of TCP-AO patches set [1].
Now in attempt to split 36 patches submission, I send this independently.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Francesco Ruggeri <fruggeri@arista.com>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

[1]: https://lore.kernel.org/all/20221027204347.529913-1-dima@arista.com/T/#u

Thanks,
            Dmitry

Dmitry Safonov (5):
  jump_label: Prevent key->enabled int overflow
  net/tcp: Separate tcp_md5sig_info allocation into
    tcp_md5sig_info_add()
  net/tcp: Disable TCP-MD5 static key on tcp_md5sig_info destruction
  net/tcp: Do cleanup on tcp_md5_key_copy() failure
  net/tcp: Separate initialization of twsk

 include/linux/jump_label.h | 21 +++++++--
 include/net/tcp.h          | 10 ++--
 kernel/jump_label.c        | 56 +++++++++++++++++-----
 net/ipv4/tcp.c             |  5 +-
 net/ipv4/tcp_ipv4.c        | 96 +++++++++++++++++++++++++++++---------
 net/ipv4/tcp_minisocks.c   | 61 +++++++++++++++---------
 net/ipv4/tcp_output.c      |  4 +-
 net/ipv6/tcp_ipv6.c        | 21 ++++-----
 8 files changed, 194 insertions(+), 80 deletions(-)


base-commit: 736b6d81d93cf61a0601af90bd552103ef997b3f
-- 
2.38.1

