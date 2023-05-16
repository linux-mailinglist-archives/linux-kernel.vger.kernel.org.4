Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B75704327
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjEPBzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEPBzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:55:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7371046B4;
        Mon, 15 May 2023 18:55:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ab0c697c84so103306165ad.3;
        Mon, 15 May 2023 18:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684202106; x=1686794106;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxSehBADHNPhx1W9pJzpHY1/CLDnBeaup/WY8YXLQz0=;
        b=UnVB3Om+UEpNsJEXkhGqtIr7WPAHXTeSVomHQPVUUSdGWOHYkyz1HXvzU1pOlW3g/z
         hGkHIjP1kB5ylXrnRixtRImun9EDqnRvMfAtIxFwvw0Vz5EBJpny/rG3+lg0PXgocthH
         hiONJkgjuLgA7267qSjw0Y7ohHvHDCeJEHhFAXjn5D1vL1YLN4m02p7GZrQ74ksQ0uOZ
         /bR3W2qsSxvj6r0fKjaRitne/1ksSqaQO2mvDbVcYjov6NOMTUVaY+aL9P+kFxqIGZCp
         Zcrg+dst63B4ZSLX3SKGzYMqwu04Ym1gZ52qaSiPNLbeKBup6JFyX/vq33yW3Ms6cvfU
         auQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684202106; x=1686794106;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wxSehBADHNPhx1W9pJzpHY1/CLDnBeaup/WY8YXLQz0=;
        b=Fx5QskQt9BGSyTMRwkMRkTaKoSizKTQ5VbD7mUTIfQIpWg4HXZrDoj/K1hD9gWPJTZ
         uCUFNnlTLPljzZd8fVgXeCoAKJiUTbdroaJkHY8KfmdlLlDYfiCJejqLcWfOr3yXqu0d
         l3UJksWLow3Ey6mAfZ/g+b+QSCpBshmYpUUyfyFBI2kTEfFT/EFOW/tc0YE28q+PBB8p
         KJAJ41tn4xtOY1TtQfMEnZPnfSt13qR0jROgm2dLo1Xz50pdwB2czk8+rNYuuCTnmt8J
         pi5rVfPzB9TlzXQI3I5GfSHZD//pTi7OLuBnv/zzPNM6z8oc4aIIPwwtr6MUJQve6t09
         dP7w==
X-Gm-Message-State: AC+VfDyy8P9pW+FYczwZ2JE6WjLZIVe03iLtvSyapdSimjfW+ULMIBo1
        +1ZmeDmVUPRrdKRZoHIEdCM=
X-Google-Smtp-Source: ACHHUZ5iUJoeNqFdzwtKs2iHh/nsgoPBMUjDybE5RLp83g11bptUS/jtDfP+OEBlCELskbNhGZdnNg==
X-Received: by 2002:a17:903:247:b0:1ae:32db:d6c3 with SMTP id j7-20020a170903024700b001ae32dbd6c3mr1144834plh.41.1684202105848;
        Mon, 15 May 2023 18:55:05 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:3424:f8d7:c03b:2a7a])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b001a527761c31sm14234232plh.79.2023.05.15.18.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 18:55:04 -0700 (PDT)
Date:   Mon, 15 May 2023 18:55:03 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        syzbot <syzbot+78bac731178aabdb6307@syzkaller.appspotmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hao Luo <haoluo@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Network Development <netdev@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
Message-ID: <6462e2779d365_250b420850@john.notmuch>
In-Reply-To: <CAADnVQJ-afnNmXhUQspXZR3EgzKinPXVwJROYx7jHJ6tUOc54g@mail.gmail.com>
References: <00000000000048abb105fb5604c1@google.com>
 <CAADnVQJ-afnNmXhUQspXZR3EgzKinPXVwJROYx7jHJ6tUOc54g@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] kernel BUG in pskb_expand_head (2)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov wrote:
> John,
> 
> could you please check whether your pending sockmap patches
> address this issue as well or it's a new one?
> 

Will check although it looks like one we found earlier, spinning
new series here soon.
