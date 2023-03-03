Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1F96A9949
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjCCOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjCCOR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:17:58 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DAD173C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:17:51 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d12so1000939ioe.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677853071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0B3hgicuXjM7bBAtA4QLzoXhHV0rOr+vQWIDTCOLWjA=;
        b=hgyhk2HWKgqowHC66Krk1Q03UB2/iQ4vrpQKUut4wjBz15Z4kolYIXRJGyjLR0TgDC
         X7Y5mygfZygXjpKsCTtXlgQKVQE5UjI5w4YVFG5PR3UeA0bcJmIyDfwcKuUP78YUBvFE
         rod8sdeuET4pFpUrQHHYLVC5bnd4w/h75aVphjm1ar+CWnCDenKrUzj8/QWyGDB0/v/B
         ttO0k/ot76Ybx7zjiHs5+xjQds1+mv2MtQLayQ7bIv4TQ0V/tfUJT/mD6MnjdOsb/Xp1
         JYihCA8SPPBbtvGWqnWcTPQLxVCPWeYoUTybbzehF4gnfmOtBSgGTMBB689L7tGaFvGD
         PbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677853071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0B3hgicuXjM7bBAtA4QLzoXhHV0rOr+vQWIDTCOLWjA=;
        b=7ffhLWjye8yx5nBIaTCm4vVc5Y3PvKkbvQlnOdNQ3vrVc3+HpkHKBsMRm5+xtfUxZs
         G1fcnNv7nFc7/UgK+fzawY01Ll+qVfL0D2qEYGJ6UIpW7D3nFOC+2Ip4nS0qa68S4ISq
         SbY4ojbTYBjKbG6gSwWvy9inDJH6yTM0u+mbBLOaH7KrykFTZIs8XBpiT1w/7GpaoPdi
         F3/QA7BbvnuHJevyY+Fd1/+3z+8TffP0p13DehvbntDB+MOPPicH5bsDeFzY/XDq+6vw
         rBpR90slpke9WQ2pIjBp99Tks8tVSPl9omMMVtfy/NLaUZiRKQDgEsArzw7zpMo8PpBX
         +APw==
X-Gm-Message-State: AO0yUKU7wFA9juBrL11MMs6f11FALw52zCeaR64x3vwDgyCHr6Kog/ST
        mMj4KKuNHK2O8ddjYx4R060GLvIqRJ7gZguHoAawgw==
X-Google-Smtp-Source: AK7set+/9ix6iBDvkcAa7MkLZxETywJmcFLhsCC5D3Hn50zH5SEnjXSEBW/PPsP2I4yK8XyKECNfTh3bZqLsW16onO4=
X-Received: by 2002:a02:9624:0:b0:3c8:c0dc:2d65 with SMTP id
 c33-20020a029624000000b003c8c0dc2d65mr645859jai.5.1677853071249; Fri, 03 Mar
 2023 06:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20230303141433.3422671-1-glider@google.com> <20230303141433.3422671-3-glider@google.com>
In-Reply-To: <20230303141433.3422671-3-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 3 Mar 2023 15:17:14 +0100
Message-ID: <CAG_fn=V4ePYQ4oYb6GXs7mOFtcuW_9HJo7BK02WK0-OvF4snxA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86: kmsan: use C versions of memset16/memset32/memset64
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com,
        kasan-dev@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of the patch. Sorry for the inconvenience.
