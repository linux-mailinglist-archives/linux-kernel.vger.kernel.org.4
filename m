Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931A75B7958
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiIMSXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiIMSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:23:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606587C320
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:40:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i19so8718252pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=o5PWbmNOeEGIQA34Mc+RdGi8IaLq6zXehKC7DBp1ZZo=;
        b=PXXb8zpQ7EdqcRUSZmN3DIDiGBiSSlYkh5LAhUBS648NQE7Lqj+RxdmP1vt8bkYcHw
         BPhXXNH9/Xk0+2QXXQ3IW19iv41SSHhm3YkDn8Zcv9LcDiLLtPBj8lnlCcSMEwMv4QBk
         xirSWNxoQ+tpngsfk0dcn7djckjC+RtiC7v+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o5PWbmNOeEGIQA34Mc+RdGi8IaLq6zXehKC7DBp1ZZo=;
        b=BW7A3pEzdM5raUlOM1Axtf27Uz3OvXTil7Yqt6Mc/X+UaeItB6lUIAHyV6SZA/P0T7
         7zjjdQBLK+3d2zQ29PePkc+SutNg9ZfbNRD6K5LALo7CKaGfbENoag90xzk+dVbwdpzy
         9yQvzor5U5FSioqulcdV9IQvBDGikqo6Q4+O/Csaw+xRx18fDDenzvStIDxd9bUB4yxY
         QU50JfgnjvJ1G9WtjKZ0ugmsS6ofrLyWSohw9pSWKnWoyQGKzsDmCqKTT9bfqjIqxKng
         FEQMqF0wIRo+D+oCevp61k1o0R/mbhMFjUK51qJjLTcCzrnu1rXFbQgjupgV8k2b0srf
         Fxfg==
X-Gm-Message-State: ACgBeo24bpKip7xJ40x3nuQbxo/KcnQJ7Tf1sATnYckCzO1kJaOEKojO
        UUjQDt4W/sMFz+MNBHjE3eNCdw==
X-Google-Smtp-Source: AA6agR5lgFpH4x/E2JcDHDsgMT/X7aMjaaM5CRsusBna/QIz+O5/oLXYJdmrQx7I/CSbWiGC+VdH3w==
X-Received: by 2002:a63:4f4f:0:b0:434:b9db:b9f with SMTP id p15-20020a634f4f000000b00434b9db0b9fmr29423342pgl.438.1663090823499;
        Tue, 13 Sep 2022 10:40:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h23-20020a63c017000000b00434d9ba7817sm8042776pgg.30.2022.09.13.10.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 10:40:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     avagin@google.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Revert "fs/exec: allow to unshare a time namespace on vfork+exec"
Date:   Tue, 13 Sep 2022 10:40:02 -0700
Message-Id: <166309079807.1930124.8643254685134544071.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913102551.1121611-1-avagin@google.com>
References: <20220913102551.1121611-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 03:25:49 -0700, Andrei Vagin wrote:
> This reverts commits:
> 133e2d3e81de ("fs/exec: allow to unshare a time namespace on vfork+exec")
> 6342140db660 ("selftests/timens: add a test for vfork+exit")
> 
> Alexey pointed out a few undesirable side effects of the reverted change.
> First, it doesn't take into account that CLONE_VFORK can be used with
> CLONE_THREAD. Second, a child process doesn't enter a target time name-space,
> if its parent dies before the child calls exec. It happens because the parent
> clears vfork_done.
> 
> [...]

Applied to for-linus/execve, thanks!

[1/2] Revert "selftests/timens: add a test for vfork+exit"
      https://git.kernel.org/kees/c/2b1e8921fc35
[2/2] Revert "fs/exec: allow to unshare a time namespace on vfork+exec"
      https://git.kernel.org/kees/c/33a2d6bc3480

-- 
Kees Cook

