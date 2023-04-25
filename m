Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330486EE3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjDYOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjDYOUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:20:09 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D20714F61
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:20:05 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-32ad0eb84ffso15042965ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682432403; x=1685024403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4HG8lg/OG1ovZC1iXgiDy5NkPoWvsd+DP5aQJEJUcA=;
        b=O/yFgzZ+TimXH0TNtdRcVxEng1cKXDdMiizP1hvu0WMAxiQXkd+5sXrC8LyEh0FYtC
         tVQXv8fhZW8h8gWllWx6hawMmR2KRmsnjDILD0+M5plN17720JeJCYw+OihjXdIdxTyS
         r/EL2M7dcLPthEUPp2amJTPaLLEA00L5tfwyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682432403; x=1685024403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4HG8lg/OG1ovZC1iXgiDy5NkPoWvsd+DP5aQJEJUcA=;
        b=Yguhquto1T3GIwdaXgx93hRJBcjaDUd4S3+K0ySydgEHWqUg8+A4bZmCuUAp6X78r4
         delVIfrGp5vaVN/0W4BWZZnFCStRzXKI7uHVMsp9ZhlnUMwjIcFIEnT4Yc3QbANlCud7
         u28SRW2bxR1AcJ3WDVoo64kJ5M5jxCseCt2Pq3+zYTcNVhtC2ibzB9esdHHrAgtyTmms
         J966gtQVZwgA2BcPlKjLlcYjrLPDsQYsMSBsVVbcpZMy0i62SJOgCAuI76stdMf1yua7
         K4Uo46VGrJpRRTU7TTB1vwpwIxAtJ6WvXoN5ndfZLsyOx04ZjCYdc2/R7u5BlDulC7PW
         aekA==
X-Gm-Message-State: AAQBX9dmVojouKBVYbjLrcJV2wL9Z6I+eGArkcsvo2iErqnC1bKCGHcN
        a7E9iYo4Adma+buwdGrwl1lnIPKOxYueybzPZD0=
X-Google-Smtp-Source: AKy350b1agw1s9V8wGMhVqCp8zxXDTXypWFH+plHPN2as4qRMnycoL6ctvopUy5FcC89SJrfEXE7JQ==
X-Received: by 2002:a92:c60c:0:b0:32d:56e1:1f18 with SMTP id p12-20020a92c60c000000b0032d56e11f18mr7441277ilm.30.1682432403376;
        Tue, 25 Apr 2023 07:20:03 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id t38-20020a05663834a600b00411b6a4ab7esm2152465jal.93.2023.04.25.07.20.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 07:20:01 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-316d901b2ecso82695ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:20:01 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d17:b0:32a:db6c:d51d with SMTP id
 i23-20020a056e021d1700b0032adb6cd51dmr331586ila.12.1682432400610; Tue, 25 Apr
 2023 07:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230422051858.1696-1-hdanton@sina.com> <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
 <20230425010917.1984-1-hdanton@sina.com>
In-Reply-To: <20230425010917.1984-1-hdanton@sina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Apr 2023 07:19:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
Message-ID: <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 24, 2023 at 6:09=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On 24 Apr 2023 09:56:58 -0700 Douglas Anderson <dianders@chromium.org>
> > On Fri, Apr 21, 2023 at 10:19=3DE2=3D80=3DAFPM Hillf Danton <hdanton@si=
na.com> wrote:
> > > If kcompactd is waken
> > > up by kswapd, waiting for slow IO is the right thing to do.
> >
> > I don't have enough intuition here, so I'm happy to take others'
> > advice here. I guess my thought was that kcompactd is explicitly not
> > using the full "sync" and instead choosing the "sync light". To me
> > that means we shouldn't block for _too_ long.
>
> Take a look at another case of lock wait [1].
>
> [1] https://lore.kernel.org/lkml/CAHk-=3DwgyL9OujQ72er7oXt_VsMeno4bMKCTyd=
BT1WSaagZ_5CA@mail.gmail.com/

So is this an explicit NAK on this approach, then? It still feels
worthwhile to me given the current kcompactd design where there is a
single thread that's in charge of going through and cleaning up all of
memory. Any single pags isn't _that_ important for kcompactd to deal
with and it's nice not to block the whole task's ability to make
progress. kcompactd is already very much designed in this model (which
is why SYNC_LIGHT exists in the first place) and that's why my patch
series was relatively simple/short. That being said, if people really
don't think I should pursue this then I won't send another version and
we can drop it.

-Doug
