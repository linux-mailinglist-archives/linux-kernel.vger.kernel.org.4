Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC36D54B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjDCW04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDCW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:26:54 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148811981
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:26:53 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l18so22923065oic.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680560812;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0H2b5vX2W/ngAUblsPfiPWQyDis8PRiu2qy0w7GKjAo=;
        b=B1g/0uQTCTqs9ZraWmAEMrJHp/JAt/OZ3+aLfmFSWMo3K/0HUXX2W+ia8WLDF6BVtx
         tRK2RiBgMcVwf1ZrEAF5vv2ta+Rrvc1V7qhdxvogZbcggAXOYq5Hmcj4hyjQSK1c+AEO
         rnD4v14CjHKJIE842B7Lbs3gIHvrQrO32RhfhrG8B5kTiwUWgENtUj00B889IjyxCusY
         tsyhaqNA/iUqdVwahS1LHc3qbQoVDHxQYBB7w3B3ycLPaazQ8grgNwXExycT9werv0yH
         bjKD0qM3r3w0pUZhYZzWgzx9oS2oMFzPyQG0F7oh709ktOvC/+TpPkhPDt57r66top/K
         0ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680560812;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0H2b5vX2W/ngAUblsPfiPWQyDis8PRiu2qy0w7GKjAo=;
        b=aM1UTD3dIMghRifmuz/SHYWChJNTK+qfkaqFYFRVIzRMDaJ1bnJ/TYIjCZIyYd0Upy
         kGFkVZIMZ8SOZtLQUgt+j9LEk4wPJBxJIy35TM3kYWQu9P/5ktZgiLlUd2ko2d3q9Z0i
         loJPTA3onoAG7fvkXvjRnv47GL6bXH/SCa9EX8n+Vqf71vPdW/M0RyvtPhHpAW4d17wb
         VNzf3oGkW2u+stccfNJW30+GyJRwZNUO8kUQ5BCbcdyUaz3U37Ep5n7u/EDM1RSntKkw
         KwE/oNDH8Q6h8XzFcZB5uzvgzyBZE720pcsy6qDowSS6fHtfZeVcSMJCO7/BcovyDL4y
         7mLQ==
X-Gm-Message-State: AAQBX9dj2jj13QVOj5oY4LS0tI67vhdCh3HBTl4HeukaJiOcndcPtxCw
        HizqA+D58w1crrpq387h0xgHyYKzh1/j/I6z/YhI2w==
X-Google-Smtp-Source: AKy350bYaoGraa1SOq4wyQyvp1GFGKkEVbd8IIKT2vXjlfeg7SEc1yWs1UYnVB4yQi2id6pdz4bDYPu+ce5hzCAbMZ0=
X-Received: by 2002:aca:f14:0:b0:38b:40bf:4a12 with SMTP id
 20-20020aca0f14000000b0038b40bf4a12mr257327oip.1.1680560812137; Mon, 03 Apr
 2023 15:26:52 -0700 (PDT)
MIME-Version: 1.0
From:   Dylan Hatch <dylanbhatch@google.com>
Date:   Mon, 3 Apr 2023 15:26:41 -0700
Message-ID: <CADBMgpxQ+oM_TrtKRiREcZoZSk=AfenV_bqOk_Vt-Ov5FPHMvw@mail.gmail.com>
Subject: RE: [RFC PATCH v3 00/22] arm64: livepatch: Use ORC for dynamic frame
 pointer validation
To:     misono.tomohiro@fujitsu.com
Cc:     broonie@kernel.org, catalin.marinas@arm.com,
        chenzhongjin@huawei.com, jamorris@linux.microsoft.com,
        jpoimboe@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        madvenka@linux.microsoft.com, mark.rutland@arm.com,
        nobuta.keiya@fujitsu.com, peterz@infradead.org, pmladek@suse.com,
        sjitindarsingh@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Then, I noticed that invoke_syscall generates instructions to add random offset
> in sp when RANDOMIZE_KSTACK_OFFSET=y, which is true in the above case.

I'm also seeing this behavior when compiling with
RANDOMIZE_KSTACK_OFFSET=y. I wonder if a special hint type
could/should be added to allow for skipping the reliability check for
stack frames with this randomized offset? Forgive me if this is a
naive suggestion.

Thanks,
Dylan
