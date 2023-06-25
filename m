Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C14673D35D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjFYTms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFYTmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:42:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752D413E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 12:42:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51cb40f13f6so2742624a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687722164; x=1690314164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6cNRKgxmHmTtoVESwsJ0zJcOrt2AZ+Czjavf35PMjh0=;
        b=LASWqnqijmia8IiwkeaGkOf9wIhvEuPHCwHgo8pDQLFlt5ftGPb9Cz044xsDZfNUiR
         +XdK/zqgiZBS+A8GPwQRZLU7U0cgM4ZznNj4yMuItxXtHqc0AYqeqkhcboIAdKiq4oop
         nt8zAckoUENbViq5+hdZRweDisjKbBWBbfT+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687722164; x=1690314164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cNRKgxmHmTtoVESwsJ0zJcOrt2AZ+Czjavf35PMjh0=;
        b=lmWU/LBKWYzFnYVRHAZelXSbJoaZN4XVC83TprdtXKPlLIhQAp9LDfODJDiy4sWxbn
         WoMntUbm5lr/qD/b1qvDDv25iUPNndeaU8MTwNbdB0rjZkkKEpbGDmhvEFEGnD9rNp5a
         ATW1LoVsMPsUbN3MO54Dse9bw3Blqpm5bFQthwd47DLaFBGOEPguIxsBCRF9IZYaO/z6
         DtNNXIKEPiHGvlnHIxfk0angyKdAkzTUq53ziXzbhljjOzjiig3DEJnGowyt+Pvl3H3S
         BURjlf00YBah+pqOKXGJRMQLnIF4vJy1O7pdDUB5NycUEvLFpEoBcLSfCDTTFSmrto08
         oobg==
X-Gm-Message-State: AC+VfDwVlV5UTx348EhhzUEixMDTpsl3njjSuuiLRMh+9muXF6T45eI/
        YQUI9tb41q0q6XcEu+aPCzMyi+dskZOGxvRCfrLxF0sh
X-Google-Smtp-Source: ACHHUZ4gQHKUyTBBvH617y/bmp2LrABaMr9o6NZda6nPWy0WIF6WvPBHbTZoR+eCIBFLTqS6VSNYXw==
X-Received: by 2002:a17:907:97cf:b0:989:74a:3a03 with SMTP id js15-20020a17090797cf00b00989074a3a03mr15419000ejc.6.1687722163612;
        Sun, 25 Jun 2023 12:42:43 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id bu5-20020a170906a14500b0096f6a131b9fsm2408326ejb.23.2023.06.25.12.42.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 12:42:42 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51cb40f13f6so2742587a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 12:42:41 -0700 (PDT)
X-Received: by 2002:aa7:d758:0:b0:51b:e9d2:f17d with SMTP id
 a24-20020aa7d758000000b0051be9d2f17dmr7071359eds.27.1687722161610; Sun, 25
 Jun 2023 12:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230607053135.2087354-1-stevensd@google.com> <f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com>
 <CAD=HUj4vVbyHiT7vPmRorS+v9t2+N46ak=Xrew2cFf5+utC=tQ@mail.gmail.com>
 <8ef3ee-ba41-8e9e-4453-73736ff27783@google.com> <df5819aa-c79-6b10-4ce1-a45af118c0f3@google.com>
In-Reply-To: <df5819aa-c79-6b10-4ce1-a45af118c0f3@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Jun 2023 12:42:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8b6joppjpYW=pi2r2LJgKHQKDwB9NkDmbsQAzWgf4AA@mail.gmail.com>
Message-ID: <CAHk-=wj8b6joppjpYW=pi2r2LJgKHQKDwB9NkDmbsQAzWgf4AA@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: fix regression in collapse_file()
To:     Hugh Dickins <hughd@google.com>
Cc:     David Stevens <stevensd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2023 at 12:06, Hugh Dickins <hughd@google.com> wrote:
>
> Linus, I'm rushing this directly to you, but not really expecting you
> to put it in at this stage, unless you're very comfortable with it,
> or perhaps it catches Matthew's eye and gets a quick Ack from him.

Yeah, the fix and explanation sound fine to me, but the maple tree
code confuses me enough and has been subtle enough (as exemplified by
this bug and many others) that there's no way I'll apply this just
before the final 6.4 without some "Ack, that's obviously correct" from
Willy or Liam or somebody.

Willy?

                    Linus
