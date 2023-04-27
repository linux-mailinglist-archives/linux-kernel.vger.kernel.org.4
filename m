Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6DD6F07FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbjD0PNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbjD0PND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:13:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DB344A9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:13:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-506bf4cbecbso12812364a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682608378; x=1685200378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tnBlwR2KgjIrpyr1ey4GRZA/jG9gwGR13N6cjFqMs0=;
        b=bSrog62jbFIHegWWinV0uhRveHaKvrAVwwmy7btQ3UI2pm0bfvatEXm2BWcZIsKLsh
         hYvYoxRPmyMIgb65VXeGZgkiJVhqAekWarXezb/A10WfhGJcKUgNikI/kajpyvnJsIWH
         VDWqu1Y3wJikK71b9jaX7SdlJFKw0axUNoan4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682608378; x=1685200378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tnBlwR2KgjIrpyr1ey4GRZA/jG9gwGR13N6cjFqMs0=;
        b=FvKQwuPFyJIsNpxGNjDnlytb4nRDXU6/XUmrXYBZVHK0tjmCnnXEQPHRkI5zrnqPZR
         hpnoUXKqGNq8hekP+8kpEfGE44hLnVwz0lw0WZyQHfR0WalhLv1uQSNQHQzZZ6xzKlaj
         sKKW9MfFVvHI1VNyu5CjaV0SaKyTjwCmqPVtV9Yp+rS7LV6OpQeVyL6OucYkZWLRe+yJ
         rrpynVxwQUE2xWjUhMJW1ua3tnLxdri5pVx89xAuhvVdCObftVWtz5rVMA1DzXasU6Go
         1KyydnxskNdwTZ2PdD6uBtPkiX0aflaAHzXsWbyKvdQtsagW+nyqPktpkhx8iue7D2aK
         ULZA==
X-Gm-Message-State: AC+VfDyD8O2UDPsoDkA5Ru1SAA5PDaSVVOQnT5W2+m9L39PMaJICo4pE
        6ib/hYxNwX+1IW+L10+vyqEVmuOX8AxzES12rIevmQ==
X-Google-Smtp-Source: ACHHUZ6tC3bSJm7bICjG9MK3qQTa4rsmVT710a5J2mcWa07q5krfkmV5wtDhgZ/GZYZS9CwWR9kcPg==
X-Received: by 2002:a17:907:3e97:b0:94d:cebe:691 with SMTP id hs23-20020a1709073e9700b0094dcebe0691mr2159149ejc.69.1682608378370;
        Thu, 27 Apr 2023 08:12:58 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709063f8b00b0094fa3deff33sm9706688ejj.35.2023.04.27.08.12.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 08:12:57 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-506bf4cbecbso12812261a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:12:57 -0700 (PDT)
X-Received: by 2002:aa7:c946:0:b0:508:3b23:d84c with SMTP id
 h6-20020aa7c946000000b005083b23d84cmr1902412edt.1.1682608377021; Thu, 27 Apr
 2023 08:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230427140959.27655-1-vbabka@suse.cz> <2023042719-stratus-pavestone-505e@gregkh>
 <3cc6e10c-f054-a30a-bf87-966098ccb7bf@suse.cz>
In-Reply-To: <3cc6e10c-f054-a30a-bf87-966098ccb7bf@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 08:12:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdGzy6-3jzN6Kvtz1QxStTZBZPz1zy9i4gM9nbe5FGbA@mail.gmail.com>
Message-ID: <CAHk-=wgdGzy6-3jzN6Kvtz1QxStTZBZPz1zy9i4gM9nbe5FGbA@mail.gmail.com>
Subject: Re: [PATCH for v6.3 regression] mm/mremap: fix vm_pgoff in
 vma_merge() case 3
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Greg KH <greg@kroah.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, lstoakes@gmail.com,
        regressions@lists.linux.dev, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabian Vogt <fvogt@suse.com>, stable@vger.kernel.org
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

On Thu, Apr 27, 2023 at 7:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Sorry, I wasn't clear what I meant here. I didn't intend to bypass that
> stable rule that I'm aware of, just that it might be desirable to get thi=
s
> fix to Linus's tree faster so that stable tree can also take it soon.

Ack. It's in my tree as commit 7e7757876f25 right now (not pushed out
yet, will do the usual build tests and look around for other things
pending).

                 Linus
