Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4724069EB13
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjBUXPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjBUXPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:15:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB25A311F3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:15:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s26so23471902edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GwmMRkor2ICDU/OK7QN1tiyRmzvZfLkymfVZOFR0Txw=;
        b=On8KMYCHBj7beUSOs4dQTtqFd/Fca9WgkVURKorBOGYVnhfD6hPKLkY6qp5oH7/qQN
         aB5hboA7zlLK6rE0UKyZEj/fEZX6e/WjRpkK5TJwK8OckIXjDcI4qk47gXQADMcTYBqz
         I+M7RQJ8AwVKOxx/Gb5cEZrJluRPBAlUhZXhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwmMRkor2ICDU/OK7QN1tiyRmzvZfLkymfVZOFR0Txw=;
        b=y4bHYArZ7V4LjSWz9043MdMaMvoMctCbGnKj2Ye15oYNY6RroOgEWfvPaTsmZt92Um
         6jDa3lPe3Ft0VRa2XpwO73orlo3zAkiTMGqigaFVMVKrQeY+h/uZtTofvcrrdNPK1OHA
         4hh47V90b46oA+Ru2HczsUZGvMu3ORsHX2Saar0q7gyAccxFW4nYZTMYoZlqI5N5lWGG
         ZeJnsmCA+bERthE4XFRHnbj/D7aFlluaOfoAJK+unW9lKjO/HJznfuMW2VPyqcmk6976
         RsNOps/zwymwrTTDvggM6VU5YZaE6eEpLxFJcRolB6wiOKYnw5mrdu2OnW5kshYCprpv
         qXKA==
X-Gm-Message-State: AO0yUKU39ivmR0fMSfWOazF7NihK7v0EbRYsZo97uq4ISHXJlOlgYD0D
        BsHtiPphhG4Le587dXrkOIPUwL4RxlB/gXlCsAA=
X-Google-Smtp-Source: AK7set9yXcDw/DdgVZPTgVu7RnP2zHlDqvJ3ZLNS1x2dqrOyRDEH1JVNLQG1WZsQPUgTrFCw44E/BQ==
X-Received: by 2002:a17:906:c1cf:b0:8b1:3ba8:3f4d with SMTP id bw15-20020a170906c1cf00b008b13ba83f4dmr12400746ejb.70.1677021327036;
        Tue, 21 Feb 2023 15:15:27 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id lx25-20020a170906af1900b008d68d018153sm2784760ejb.23.2023.02.21.15.15.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 15:15:26 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id s26so23471728edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:15:26 -0800 (PST)
X-Received: by 2002:a50:f694:0:b0:4ad:6d57:4e16 with SMTP id
 d20-20020a50f694000000b004ad6d574e16mr2955162edn.5.1677021326111; Tue, 21 Feb
 2023 15:15:26 -0800 (PST)
MIME-Version: 1.0
References: <Y/NhOcWmhpYRPnK0@osiris>
In-Reply-To: <Y/NhOcWmhpYRPnK0@osiris>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Feb 2023 15:15:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wimQi=gL-Pd7kMd-ruwjLUCK82e3wJ7sisvT3cfHrx-JQ@mail.gmail.com>
Message-ID: <CAHk-=wimQi=gL-Pd7kMd-ruwjLUCK82e3wJ7sisvT3cfHrx-JQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 updates for 6.3 merge window
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Feb 20, 2023 at 4:02 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Also the shortstat when merging will look slightly different to the one
> generated with 'git request-pull' below, since I merged our fixes branch
> twice to avoid merge conflicts.

Please don't do that unless the merge conflicts are really nasty - and
when you do, please *explain* it.

Looking at those two merges, I

 (a) see no sign of complex conflicts (the conflict diff is completely
empty for both of them)

 (b) see zero explanation for why the merge exists at all

Please consider merges to be real commits (they are!) and needing all
the same commit messages explaining them that normal commits have
(they do!).

In fact, exactly because merges don't have any obvious code in them,
they probably need *more* of an explanation than a commit where the
diff might be in itself somewhat self-documenting.

               Linus
