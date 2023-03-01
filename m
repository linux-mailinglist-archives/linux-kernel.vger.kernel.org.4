Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C165B6A71AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCAQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCAQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:59:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A2F1BD5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:59:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s26so56403381edw.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 08:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677689963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIHxNwLqqYjZNA0Dkndbth2++h3bYPGFCZQ+tmKXTvo=;
        b=ZU6+kQCIZd19Zee5RqQhXwjfPziTlCFZ/JgXfn913ClHjcZDWELPi+b5kNddVcBiyA
         gMRLbwwBKQyHiBFfUOaEhx2Nbbop+MoTkWXKU/0sEsbcAtEi72eskDBPIuo/IkzS7yVo
         NxlPuRvrzd7qth+cYhkw2Nhl4e4AlVnpEdFZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677689963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIHxNwLqqYjZNA0Dkndbth2++h3bYPGFCZQ+tmKXTvo=;
        b=wQ8MHnB7OBEg2Cc5Hr/CWtRsw+0t6ra0V4PNf1foU5mnt30qzYKOAdr2K6+lwwqhgm
         tCjKYGFOt/vUOwlZmjItEwWQJ9Iktc7l+ofFKraTj2fsdzH35RXc+Ehgd5+AbuvJe0GM
         9m7L1WZb3/WS8Y6X6vtqEdVz5fgQN7kAxNpP2x8ODLu42VXrTYIU+ROsPqct1U1WWuMV
         SbQsqUDpN7e4V3GbKsVHgQ6LdLqdwdzoXSwqNRoDwtGrTOYr9n2C2L5aTsu+LovuAeMz
         S+BSEFka0h3fwTLZ5Q1vQbCTvTNxsqL/zAwWpf1nGsQtXgVMmLday8U108/p+yMy3YZa
         qbrg==
X-Gm-Message-State: AO0yUKUT5aP2R3UrnqR3YoxG2yUhoblKsPPjzs4hoMn2zX0EA4lPo3ko
        QEwFYNanrcWeTq3KoSx8s4B4hnj5KmY/2VddIKgkmQ==
X-Google-Smtp-Source: AK7set/C+E9swbdzeX9GEecVLehochR1O8ZZwSjgPy1T/cRQI4xjXefraVyFwn66bXn/UJJHKaupLA==
X-Received: by 2002:a17:906:9b89:b0:88e:e498:109b with SMTP id dd9-20020a1709069b8900b0088ee498109bmr9050320ejc.5.1677689962832;
        Wed, 01 Mar 2023 08:59:22 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906530b00b008e93991c034sm5943761ejo.46.2023.03.01.08.59.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 08:59:22 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id i34so56512638eda.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 08:59:21 -0800 (PST)
X-Received: by 2002:a50:c34a:0:b0:4ae:f144:2c8e with SMTP id
 q10-20020a50c34a000000b004aef1442c8emr4332069edb.5.1677689961649; Wed, 01 Mar
 2023 08:59:21 -0800 (PST)
MIME-Version: 1.0
References: <Y/+A/K4/2A8iRj2m@thundercleese.milagro.dyndns.org>
In-Reply-To: <Y/+A/K4/2A8iRj2m@thundercleese.milagro.dyndns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2023 08:59:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdBXHWSj2X873om=iZ21CbeWw5P1qiX2GOKGzskdmZtg@mail.gmail.com>
Message-ID: <CAHk-=whdBXHWSj2X873om=iZ21CbeWw5P1qiX2GOKGzskdmZtg@mail.gmail.com>
Subject: Re: [GIT PULL] 9p patches for 6.3 merge window (part 1)
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 8:44=E2=80=AFAM Eric Van Hensbergen <ericvh@kernel.o=
rg> wrote:
>
> Its been about a decade since I've submitted a pull
> request, sorry if I messed anything up.

Well, I'd really have liked to see the commit not having been updated
last week, but other than that I only react to the fact that your
kernel.org email address in your pgp key seems to have your own name
misspelled. That looks a bit odd.

            Linus
