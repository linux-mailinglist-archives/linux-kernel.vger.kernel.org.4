Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68501661874
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 20:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjAHTMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 14:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:12:04 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFBB6145
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 11:12:03 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4b718cab0e4so87665707b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VshpOCuS+UE23TdIO1FCKgFBaQRs5UhY8qOX5hQq0Vk=;
        b=fJd7KDBaNWGJpWuACbh63+7ivXz4CUzo7tBKHOBX0aI5WfmcjbQqIrugwqkrWwYSlM
         8tlpuciwCBdTVhOiQDVjPJIOQlcVb2JGKkSNJ7cSHwNhd9CSa5QvCSWfBGO638bM9N6v
         AU9FeTmFJxw6YUAD+nrknyYqm8HE5M8I+98b67MB1nThhrcOHLataFR/1cwynUQQ3s++
         BxDYa8JGY/Dp/jGg4ro5aHqoHDU71yrTdYmYBtokZYIpFh4ynJtZ2KwbC0NkZ3a6Erdl
         Fti5m7PBl0c68TK466GUH1f9S7rPKBbcS61wS6ewAY5F3SsNduFmJLPbxZmhrzIeY+ty
         5jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VshpOCuS+UE23TdIO1FCKgFBaQRs5UhY8qOX5hQq0Vk=;
        b=dKsSb+e5zMq8FliaK8C5efiKeiIgPnxyZMZGrhW41wEstNCO8BIePbVwLOoQRnMNj2
         AQ6qYMUfgkMtpZlvN8p+AlOzKc273xqoBCGSO504Jx47FcczvmQ5LAn0Ui5qhnFtVBuu
         /TgD8wikq9K7CKdhnHDWJ1d94xTWMVhbeRBYvTLwUfnZFml8KWKn2UAo2hHp/EYdULPL
         jyt4NGQJLVF1ZHOp68I6Wi4LGsgVvN0fQ4RP1aRidx1jF8suU8KbrJHTtLbqvMnXOOeb
         0ZUPcilWKTsiUwrjLI1TQjNgJEfRpssZZNzjzJ14w2lLu0GvZMAWgNAKFb3EiSD5sHmx
         HQPQ==
X-Gm-Message-State: AFqh2krJGL+fcLVqQwbymWTXsevG/P+S7vVXlXjOJueR65eDEwiKXzXu
        P1ol0gcuoMHfe85iKVGQm5NAuhDMPxJFq9EqtMWHT0m4AGOvGL/xF4w=
X-Google-Smtp-Source: AMrXdXvBMqebyIRoA12dvwZvOSFfYukFthzmFP/Y1ARGVSIb7jwgZ9wL1ddob35YUT/M21nuVZcoMbtSpmz+Abm2+20=
X-Received: by 2002:a81:484f:0:b0:3ed:90d2:2ab8 with SMTP id
 v76-20020a81484f000000b003ed90d22ab8mr778931ywa.67.1673205123163; Sun, 08 Jan
 2023 11:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20230106143002.1434266-1-steve@sk2.org> <CAMuHMdWvOx+K+eQfpC-t2jfkVTQOa+SBorwi=LKmUdW7VPwjig@mail.gmail.com>
 <CANiq72nnyxq_JhCETL+v1zQuU=HHjsS66Lt=0bzQ6Xy6CPKN2Q@mail.gmail.com> <CAMuHMdUNze0mL=2VOLPj5kE3Lsa3B3bzN_WipC_v=CddNNSJfQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUNze0mL=2VOLPj5kE3Lsa3B3bzN_WipC_v=CddNNSJfQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 8 Jan 2023 20:11:52 +0100
Message-ID: <CANiq72=8T4=NhxLqeV0vgynRB0+gy9VnddZNTKXP75UfVPnc+Q@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: ht16k33: Use backlight helper
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Stephen Kitt <steve@sk2.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 8, 2023 at 7:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Oh, I sent it here because of
> https://lore.kernel.org/all/Y7qM+ZlG5gQiOW4K@ravnborg.org ?

Yeah, sorry. I mentioned it just in case, since Sam asked for Robin's
Ack in that thread, but I should have probably just Cc'd him here
(done!)...

Cheers,
Miguel
