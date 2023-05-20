Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7EB70A5B0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjETFbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjETFbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3AE1B7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684560615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XzCEspLGlKA254CwGe35oONfGtSOvg7zfEOdpWW9psA=;
        b=gxlrjznh8a5Ksia6vy/ycC1tZgqKGIdLecDRkZgDtFiaihlSorcGoo2re5UWIAF8bu5lBl
        DgfN4wxQX/hC15it5tatUHbCUmxdCgirKUQjZBH7ltMEFwL7qIaAtdkTl0ndu8KLIWIAL5
        rqz88/7FrirH1dtwhXujCQdJZ3zhNB4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-T9J5ppVKM_Sy9LPGeFnuyw-1; Sat, 20 May 2023 01:30:14 -0400
X-MC-Unique: T9J5ppVKM_Sy9LPGeFnuyw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5551fb18a74so62709eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684560613; x=1687152613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzCEspLGlKA254CwGe35oONfGtSOvg7zfEOdpWW9psA=;
        b=AT+DzecBh1kwZDTyJECzDWKmz5VVQgbh8+l+k6Z36RdEOVwkuk30VWHzgPNx6v85PX
         Broot8tQUg8Qz9U4m5RfZPISUt9uARXcKKfymvG37EdbDbyo/1Rj20432ZHxiBj2PjCY
         bl0sWb0h9NsUJ7A4eyMdqMOJoePjUYNmj9N27HdSzKdcdbRHSxicpSQvIfryy+UwYXHa
         dlrS2TCjiWFRhikuV5gNqSECohPn99x/qpbhxJzeSdYEmWNk+qUVz9n341g9pfo0VXjZ
         nl/euDUWMh8UrGxZJknAU+MJYDg6roeN8O2x2S3yzfnKdrS3qElY+EzHmgy6HKw0S5JB
         OO5A==
X-Gm-Message-State: AC+VfDyx4TJQ3z0oDnNpP3HfApUHC1ht/judHmZVpMEMADd2w6uudR9h
        504X/EqBTfmpXGkK1DIP/gbFcmbGL9TNdU0cGm/JGtaH4lsXtxU0DQn2FFICfYwF7NzSeoghlCS
        yHEgA3SUcCOaaqFzyI2XUnw7sXQjor1FAs7Q=
X-Received: by 2002:a4a:2a56:0:b0:550:ab9f:ae6c with SMTP id x22-20020a4a2a56000000b00550ab9fae6cmr1939164oox.7.1684560613395;
        Fri, 19 May 2023 22:30:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZWo8MuQDw+aQtJyA+TVBUa/z/h7TANbcVuEGzhRhIWm7wgNVaPiBGm+XdzbHOJcW9FAjxTQ==
X-Received: by 2002:a4a:2a56:0:b0:550:ab9f:ae6c with SMTP id x22-20020a4a2a56000000b00550ab9fae6cmr1939150oox.7.1684560613112;
        Fri, 19 May 2023 22:30:13 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
        by smtp.gmail.com with ESMTPSA id j14-20020a4ad6ce000000b005524555de56sm365494oot.36.2023.05.19.22.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 22:30:12 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to call_single_data_t
Date:   Sat, 20 May 2023 02:29:55 -0300
Message-Id: <20230520052957.798486-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFCv1:
- request->csd moved to the middle of the struct, without size impact
- type change happens in a different patch (thanks Jens Axboe!)
- Improved the third patch to also update the .h file.

Leonardo Bras (3):
  blk-mq: Move csd inside struct request so it's 32-byte aligned
  blk-mq: Change request->csd type to call_single_data_t
  smp: Change signatures to use call_single_data_t

 include/linux/blk-mq.h | 10 +++++-----
 include/linux/smp.h    |  2 +-
 kernel/smp.c           |  4 ++--
 kernel/up.c            |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.40.1

