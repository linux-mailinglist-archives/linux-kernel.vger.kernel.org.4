Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C2E747858
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGDSib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjGDSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:38:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58A310DA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 11:38:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992b27e1c55so678480766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688495907; x=1691087907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2tbOa3HOuqGGgU4rs5MkZrWcvHhQ5c0R0nrmNFDBEYQ=;
        b=CuJmiTGpQLrfPguYpOYJGGWVpXx2Lbrw35v1dmEVrC2Ys3MnrKprS+rJWiRVVJ19M1
         tDd0AnXjf9w/rBEcnXa0fqL6hfQtzLeHe7F5rE9flxe4YRh35bRQ8YjC+6GhgLvK8m7K
         KCaJ3zyH0w0rJq5nkjhsu4psa2e6O7JhboEsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688495907; x=1691087907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tbOa3HOuqGGgU4rs5MkZrWcvHhQ5c0R0nrmNFDBEYQ=;
        b=XtOXNVA8XqhsN/dvFmU2ilvlU64+rB6p3bDxKJUpX8ST5rkEDia1DAtADxknvI8ZAI
         zhZJZ78ba1IIksON8Kf25yY6XKXTOOQtUxZsAjtgWrrRfE2urmD5mYAcGQUrnKVySzTp
         zHKdtickha02+wJ39Ku4SIGgooYW7e+eWzVApIpPQp9KzSTRjGIhvUwtZIolNmmW7Dns
         kzBDIB1IyKUEQ4D9mDXoZfrrQjPE79FmleBayOWwhnr9VBKBKkk6pq71RjFwhjvGYiK2
         WojC0k5txKdOEqpmdfjjtgVBAoehbGgPPZkA1/lpkTUlwXpkHAQvP6KECljoLV7zbtQd
         qekA==
X-Gm-Message-State: ABy/qLaKllpbnZeWxRnsf7GH+RipUJG06yvGJ8tc7z2EgG/p9OG9fgeL
        3q75GRqZ8zys2jH0U8Varot4A6dexPpVUNEV1FmJyQ==
X-Google-Smtp-Source: APBJJlEdIEPYfTPiQs4a8R+FRlDV70mAC2oVLjdhNubwRvXwFIBEVpMdZFocctPiY88lTh8xK5rOPw==
X-Received: by 2002:a17:906:c7d5:b0:992:acf7:bc16 with SMTP id dc21-20020a170906c7d500b00992acf7bc16mr9758479ejb.23.1688495906886;
        Tue, 04 Jul 2023 11:38:26 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id jt24-20020a170906dfd800b00988b8ff849csm13472332ejc.108.2023.07.04.11.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 11:38:26 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51d804c7d14so6674853a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 11:38:26 -0700 (PDT)
X-Received: by 2002:aa7:c997:0:b0:51e:ec0:fd84 with SMTP id
 c23-20020aa7c997000000b0051e0ec0fd84mr4865749edt.40.1688495906091; Tue, 04
 Jul 2023 11:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230704092309.22669-1-vegard.nossum@oracle.com>
 <20230704100852.23452-1-vegard.nossum@oracle.com> <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
 <4650691f-a025-0a93-33ec-a99ff0ede157@oracle.com>
In-Reply-To: <4650691f-a025-0a93-33ec-a99ff0ede157@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 11:38:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXPYCgXXMpXxK7BGhRY3DzPk9M=t0Njshr06GsuqeXEQ@mail.gmail.com>
Message-ID: <CAHk-=whXPYCgXXMpXxK7BGhRY3DzPk9M=t0Njshr06GsuqeXEQ@mail.gmail.com>
Subject: Re: [PATCH] module: always complete idempotent loads
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 11:29, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> It's likely you already changed this with the f_mode changes I commented
> on, so maybe it's no longer a problem, though.

Yes I did. Let me just push out the stuff I have pending, including
that fixed-up commit.

[ Short time passes ]

Done.

                Linus
