Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FD06977C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjBOIHi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Feb 2023 03:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjBOIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:07:36 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041053669D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:07:35 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id ch10so19843325qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx6raGPVkjLOh5DBbFhiid2XbozsdzVzlVKzi7He69I=;
        b=KsO0ehOj+ABHmIeTUMg/spvI3id4G/jkVp+U1VHxlb+2vFepKSo/2o5tCAN32d6JD2
         ptlAS/+WZ2q0XgsIIudepF+HIDN/5zIb99XaT1xHSfP/l5XQnC40UVj4CZEPRZjYgZPx
         7KdQkifB7AjnBiyRTWrGnLzkfxyY2RNNJl0ZSzsIdQjz7D++PHud1kztP+FqNs2EekU2
         Pcngb4kbHao9EQeWt6JeBJc9feBrIDUHX7fSvXa9CKHTO3cJ7//ZWCEZbXPBPIMucPbA
         hTHAt+5nProyo7xjN1XjIKbP3r7Yuu/4iRXx14yGu17n7VHfNtQeFfT64KdAExPwghhy
         XYmA==
X-Gm-Message-State: AO0yUKUzJIYJG3/rwbVlVFQRARauNTKetPnbvYkFSrcsaCE9JNmSy18i
        rNOV32hdVXVtXZRf1+A9ew3t98cz6cldPbLV
X-Google-Smtp-Source: AK7set80KUhYvnn7mPBFIMeZxLc5+K6SmYfWB1qQAr2ozhpDbDOP11mAVkwEyK5x21QLkmKkcigViw==
X-Received: by 2002:ac8:5e53:0:b0:3a6:8f7c:5936 with SMTP id i19-20020ac85e53000000b003a68f7c5936mr2143324qtx.25.1676448453923;
        Wed, 15 Feb 2023 00:07:33 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id q68-20020a378e47000000b0070383f1b6f1sm13544679qkd.31.2023.02.15.00.07.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 00:07:33 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-51ba4b1b9feso249110307b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:07:33 -0800 (PST)
X-Received: by 2002:a81:6a03:0:b0:52f:972:e6a1 with SMTP id
 f3-20020a816a03000000b0052f0972e6a1mr173556ywc.235.1676448452756; Wed, 15 Feb
 2023 00:07:32 -0800 (PST)
MIME-Version: 1.0
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
 <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at> <913fea79-09f9-b976-ff1a-cd833784abb6@quicinc.com>
In-Reply-To: <913fea79-09f9-b976-ff1a-cd833784abb6@quicinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Feb 2023 09:07:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
Message-ID: <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
Subject: Re: [PATCH V1] um: Fix compilation warnings
To:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc:     Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasarao,

On Wed, Feb 15, 2023 at 6:36 AM Srinivasarao Pathipati
<quic_c_spathi@quicinc.com> wrote:
> On 2/15/2023 3:27 AM, Richard Weinberger wrote:
> > ----- Ursprüngliche Mail -----
> >> Von: "Srinivasarao Pathipati" <quic_c_spathi@quicinc.com>
> >> static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
> >> {
> >> -    struct uml_pt_regs r;
> >> +    struct uml_pt_regs *r;
> >>      int save_errno = errno;
> >>
> >> -    r.is_user = 0;
> >> +    r = malloc(sizeof(struct uml_pt_regs));
> > I fear this is not correct since malloc() is not async-signal safe.
>
> Thanks Richard for quick response. Could you please suggest alternative
> function of malloc() with async-signal safe.
>
> if that is not possible Is there any other way to fix this warning? OR
> do we need to live with that warning?

Does this limit actually apply to this file, which calls into the host OS?

How come you even see this warning, as we have

    CFLAGS_signal.o += -Wframe-larger-than=4096

since commit 517f60206ee5d5f7 ("um: Increase stack frame size threshold
for signal.c") in v5.11?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
