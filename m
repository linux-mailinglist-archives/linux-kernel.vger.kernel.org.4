Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100B66D8620
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjDESic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDESia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:38:30 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F9E95
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:38:29 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-545cb3c9898so618882717b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680719908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3zjEgForbZ70qfWXncjeoyQRVRAqXzcE2S7W4io1h0=;
        b=GwTvYIfgRWMVM6BbY6jeZI7Cd8zlzAtBiDrzO5yNzRK9BXIjQApzmaNkJZ1I4usgi+
         Jgle5ewEKkSiRxMBqiJeqX6YmsVuXMI9nwO6csClhuSvkCX8IZkcb+W1mlC5Ji54F0W/
         IGEQn3Oq9aWBeHeQCsG/+UOu7AoeS3OazY3NPUH6vZQnG4dHPAb4ZSQXwDXzGOCXSMBp
         Twr8R+XxMG/nEU5uzxBUdHMPei8n/y8i24Zg+ggVNok7YHluaImh9/81xMxSAeodeELl
         ztksvG6DYTUL0MVVB0ER36GG0IKFBjeks0vhQZhfZsjEBKHZsNBAPtkc7hnTMH7U+Abs
         t2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680719908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3zjEgForbZ70qfWXncjeoyQRVRAqXzcE2S7W4io1h0=;
        b=Rw2szN/TcmSePVZ0OdTbi6tQwmgeRBMmsG/Jpx+M4XFRp68E4bER/I4YKBsLCCF6Bs
         nC9KpH3Lz+N1zhngicN5jeubvu0x4m9tMLKeO5ZlWailQX9qgAdFgPbyoRuTOfmoXXAX
         T8tsGKeLRzUIyBOHlTBVBFk/Bm/+rPDYdfmB7yh4OlVjOiiwJJ5egaX6Bb43X77Z74z0
         cCwhz59hwh4UiR5W3E1veXmsZPf/5KZa+jnHep0gfm+UOaMHiB92/fUGc3NHmXFfYGXf
         IVVoJsR5ZbJT+GtPnSWozhbXllKsHVJ8slMU3IRmM5hAn6bSxcRZu7RAYFmujosoCau0
         QXcw==
X-Gm-Message-State: AAQBX9eHGYHpzQnGGKR4UtcVzpXRgPC1WbYMz/sHajHdbnaNWsVtwxnD
        sPZyFpUMJTTBMRiRyarbFIlGN9UxhTfK2Vcamg2YtQ==
X-Google-Smtp-Source: AKy350bI21zKvv9ZUbOqROwGq8k9kUAXx8fhHJvPsBozXOwA15O9KVt6f0VVQrDA442i4P7asd4KTXg5esVTszMs4vk=
X-Received: by 2002:a81:eb03:0:b0:545:7164:49aa with SMTP id
 n3-20020a81eb03000000b00545716449aamr4086497ywm.1.1680719908459; Wed, 05 Apr
 2023 11:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230405163602.1939400-1-trix@redhat.com> <20230405164635.GA31303@cmpxchg.org>
In-Reply-To: <20230405164635.GA31303@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Apr 2023 11:38:16 -0700
Message-ID: <CAJuCfpF33qHhfxtUC1_A4DVAueUnMYG07QJr3cJouCCvxZF_PA@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: set varaiable psi_cgroups_enabled
 storage-class-specifier to static
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tom Rix <trix@redhat.com>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 9:46=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Wed, Apr 05, 2023 at 12:36:02PM -0400, Tom Rix wrote:
> > smatch reports
> > kernel/sched/psi.c:143:1: warning: symbol
> >   'psi_cgroups_enabled' was not declared. Should it be static?
> >
> > This variable is only used in one file so should be static.
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Suren Baghdasaryan <surenb@google.com>
