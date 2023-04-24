Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708C36ED45F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjDXS2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjDXS2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:28:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033316185
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:28:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5050497df77so7338036a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682360908; x=1684952908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0mJ70ipVZnf7pj55zQXoZhkDTwynyWYN66a++oKqLY=;
        b=J2oSDHI1aUyogyAr+4YuAISDnCKirGCUOj48r688k/SaUyo21gnxzXzf7vgYTSIY/R
         JIgXIIhPK6lmeFaUZPF1lJG9MxSUU1hIjlcLefZON1VXUT8b1fUc2AhEjn89Dpt5aI6K
         mmX36SRr9TKZSXX585f7CFKOIy8oXThkCa7ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682360908; x=1684952908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0mJ70ipVZnf7pj55zQXoZhkDTwynyWYN66a++oKqLY=;
        b=AQ6w8nLIYlV7k4Wnuj6ARpU1YfaNeCayW8gK2LKPhJwDzQWr3bpA/YfJ0P170TtgAA
         WTCWMXEVPfNFf/Q6Xz3HVS+XLmi9fZJrZ6mC2SxQLnuyiG1l71nqKSqlu4om0btpW4vt
         PgKdVvnM/jJBOpAz4sKmY3qBkJ0ob45r+4xam7UhpvCbJj8+9dggpva29QeZIbCyyPrH
         pujHRVK4AHYLvxSAeT2koiFGLCV9xEFAjpvLMzN7EuMZalbnHpFpsQXgG6p59/ogTZtZ
         blG40kO50zioopNxrdh++IRlm/OYH3K7waTGuKkgsZN6esEzI5iOTfSUcgsHTbOG7lfx
         8yXw==
X-Gm-Message-State: AAQBX9dt1Er5iEErlo9yOrhbl0/W3Qic+TjlikPf5FRpOmPgISGLxvEF
        251rh9kKkpLe9XhfMb+6Omi63cgtLFeDJhJXj0f7aAZQ
X-Google-Smtp-Source: AKy350b2f0n1K77mYMErGWBBHJjcuX6GS3xMuuTjn/bq+QFC+Iayxi5Oqa0nBcHwr+WQE6gvWV/FZA==
X-Received: by 2002:a05:6402:719:b0:506:b228:7b08 with SMTP id w25-20020a056402071900b00506b2287b08mr12926200edx.17.1682360908239;
        Mon, 24 Apr 2023 11:28:28 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id e17-20020aa7d7d1000000b00508480633bdsm4957317eds.74.2023.04.24.11.28.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 11:28:27 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so7321405a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:28:27 -0700 (PDT)
X-Received: by 2002:aa7:d985:0:b0:501:cf67:97f3 with SMTP id
 u5-20020aa7d985000000b00501cf6797f3mr12297483eds.25.1682360906714; Mon, 24
 Apr 2023 11:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQmV7=+eP0Rh6f+grz6=wigoHKuX5zZuMYVazsV8HVaVw@mail.gmail.com>
In-Reply-To: <CAHC9VhQmV7=+eP0Rh6f+grz6=wigoHKuX5zZuMYVazsV8HVaVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 11:28:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wji9GerfEOQ=9O6OOULFmpHneLPdvYtv+HM2ZK+tB3FDw@mail.gmail.com>
Message-ID: <CAHk-=wji9GerfEOQ=9O6OOULFmpHneLPdvYtv+HM2ZK+tB3FDw@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.4
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 4:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Due to some personal logistics challenges over the next few days I'm
> sending the LSM pull request for Linux v6.4 a bit early.  Here is a
> quick summary of the changes:

Well, you only had the summary, not where to pull from or what the
resulting diffstat and shortlog would be.

Normally I'd ask for a proper new pull request, but  since you
explicitly mention the logistics challenges, I looked around.

And it was obvious enough what the thing you wanted me to pull was:
you always use the same naming format for the tags etc, and the end
result matches what you described in the summary.

So I've pulled your 'lsm-pr-20230420' tag, but in general I really do
want to see that mentioned explicitly along with the diffstat etc
noise from 'git request-pull'.

Thanks,
               Linus
