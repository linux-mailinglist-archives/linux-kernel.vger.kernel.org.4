Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFD64AE93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiLMEMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiLMEMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:12:48 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90497398
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:12:39 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id i20so4352272qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbX66ZXwXxKVKyE5+d5TwpxRmxyoArAKr+H2f8obyNQ=;
        b=Yvg8jYxnKKGYYS96lK+qTy6828mLCsBGBUhO4kv2uFz3BXfleQ4F6ocBPx95r1oHrm
         J/qcF4SsXvzDHpPAvk0L9m0uq9vTL4nhZXb1qniyQ2oHPbsIOpxjou/VxekGSDIM3I17
         3DWgDzJ83YlECtx5BRGdI5fKmsx3bUV+0NO2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbX66ZXwXxKVKyE5+d5TwpxRmxyoArAKr+H2f8obyNQ=;
        b=GpnpG9OYwhpMVRTqkCx8CFayA+Rjo22DtkmtwAHUq2YvUOBmTo98GzltTYLPolUbal
         tozG0hzCyMCLWl22Jfv6x0IYYtHpDm1ulacX9jvElOzjvm0nrl6bTQErTpc/bSzWeIQs
         iM9JvT8fViITUrguYw69WPOU3VQW/CIMJjgdWV0Y59Jcssfham0W/3LIlpUYrnZrB9LS
         KJ3zj4X7RcyIDw7FiL1lNX3uuE7Wx0t8piC+nVf/+KI2/4JGuec6ssqd93Wb2gl0Ggk/
         4lrnuKJ7Drlycgf1IHISAEBqbqtx5XJLG0d0MBqahc/TSzNBVThLGPU5aUMajZv0/IdJ
         9WyQ==
X-Gm-Message-State: ANoB5pnwzDinhfzyMPi9KarWgYUll4ffCuWR9+9DajGLNLIyln2JKjO6
        CyWkLbInx+vr+3rRJQA1swupkEFmkYt0+VGT
X-Google-Smtp-Source: AA0mqf7dM8rHNO+DfEKNz1y8vaXZ+Hg+lXqtvgu3k2kION7oUXGediFo0uwGdnqhmFLbWnptJvCOuA==
X-Received: by 2002:ac8:4e44:0:b0:3a5:1be0:d879 with SMTP id e4-20020ac84e44000000b003a51be0d879mr35155645qtw.51.1670904758005;
        Mon, 12 Dec 2022 20:12:38 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id o2-20020a05622a008200b0039cc0fbdb61sm3187169qtw.53.2022.12.12.20.12.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 20:12:34 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id pj1so3653998qkn.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:12:34 -0800 (PST)
X-Received: by 2002:a37:8883:0:b0:6fb:628a:1aea with SMTP id
 k125-20020a378883000000b006fb628a1aeamr84330860qkd.697.1670904754152; Mon, 12
 Dec 2022 20:12:34 -0800 (PST)
MIME-Version: 1.0
References: <Y5TB6E77vbpRMhIk@debian> <Y5bRuDiEwUAK1si1@debian>
In-Reply-To: <Y5bRuDiEwUAK1si1@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 20:12:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg44HkHGo-j5HEChEJYqW0-=vu7=i0euGBPT4asc1xBaQ@mail.gmail.com>
Message-ID: <CAHk-=wg44HkHGo-j5HEChEJYqW0-=vu7=i0euGBPT4asc1xBaQ@mail.gmail.com>
Subject: Re: [GIT PULL] erofs updates for 6.2-rc1 (fscache part inclusive)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Hou Tao <houtao1@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Jia Zhu <zhujia.zj@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 11:01 PM Gao Xiang <xiang@kernel.org> wrote:
>
> Comparing with the latest -next on the last Thursday, there was one-liner
> addition  commit 927e5010ff5b ("erofs: use kmap_local_page()
> only for erofs_bread()") as below:
[...]
> Because there is no -next version on Monday, if you would like to
> take all commits in -next you could take
>   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1-alt

No worries. That one-liner isn't a problem, and you sent the pull
request to me early, so I'm perfectly happy with your original request
and have pulled it.

Thanks for being careful,

                 Linus
