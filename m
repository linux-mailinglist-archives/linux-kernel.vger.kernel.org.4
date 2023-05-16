Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C40705568
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjEPRt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjEPRtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204EF7EC8;
        Tue, 16 May 2023 10:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 384F563D65;
        Tue, 16 May 2023 17:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996DBC433D2;
        Tue, 16 May 2023 17:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684259318;
        bh=Pgf56bYW73f9/E99kti45nI8VbWzcruRQcRKj+3m6GA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lZ2bEJE/36jKqZZ/J7KdydFvB/eLbG2VsL4XY6Z4yT3etLwlIBUBUCCjBRMTdUkBI
         xVjfJx6OQBAeco7zSrLIrbh8Xva21XPwUcVD2Aaqh2Wks1yyqOxoTSeCbAVvY3736K
         m/fdutcB4L11MF1jcnAMJ6g+IoNLqn1L6zRrSzUHcoJ1YeL/yGJ1FtoGLkFagrv4Bw
         sSzbdjfmMTNYsOK8kbt+eIfDkaBRpNRi+TH68uobDst7LHK6cxdbrkgKdGFczmR5r4
         jrChHi6xe2wEbYqx3P1eZkNeV01kcxW41aJyWL/CKoxwNXnVwSjkI6fEsE9Nba8Du1
         TlDeNz+ii2uXA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ac8091351eso151776401fa.2;
        Tue, 16 May 2023 10:48:38 -0700 (PDT)
X-Gm-Message-State: AC+VfDwW10nxfo4HT5ZIYbCos2yPBOgm+ZHyaAUwvf16wBaXfhO8rRXx
        elcJgK3sO6GXJsmX94+dPm4etpqvsCWlHm62hJY=
X-Google-Smtp-Source: ACHHUZ4PGGA3aqZ77YtFTBE6E+s4lVGoKOGPbvA2VbHBeMmVFIsr1Jrtq0J5gOTSxlvWKmrQmVrm6BhN+C5R1or3D94=
X-Received: by 2002:a2e:9050:0:b0:2ad:af50:6ecb with SMTP id
 n16-20020a2e9050000000b002adaf506ecbmr7455681ljg.14.1684259316682; Tue, 16
 May 2023 10:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007fa2d705fb29f046@google.com> <000000000000b2cbe305fbb2c9d9@google.com>
 <ZGHJsNY4P7yoCPDg@gondor.apana.org.au>
In-Reply-To: <ZGHJsNY4P7yoCPDg@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 May 2023 19:48:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH8B6dmt0LVVyyorAzrKmkD2uFZ-5r4w0kMTYKbhqSPMA@mail.gmail.com>
Message-ID: <CAMj1kXH8B6dmt0LVVyyorAzrKmkD2uFZ-5r4w0kMTYKbhqSPMA@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in __aria_aesni_avx_gfni_crypt_16way
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     syzbot <syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com>,
        Taehee Yoo <ap420073@gmail.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, davem@davemloft.net, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
crypto-aria-x86-fix
