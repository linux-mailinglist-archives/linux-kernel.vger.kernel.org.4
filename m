Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3FB6C7311
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCWW1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCWW1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:27:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D27241D0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:27:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x3so909275edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679610455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipH/7qh/XsDMwmrIBayEKIi9rym0oDV+8Lji6rbxIoY=;
        b=CtNNVXkjMp8SRuVu0Nc3kK2ZJTIfi0PcqyQwx6VTfz4pxVRtL/uPPUT2VcSukXX0/u
         Ci4kZQCAhC9Eon3ZNfg5As+Rgl/quI4HAC4pNxa7uH0aWcNQqsfTDSdcd1GXtR2emXTA
         vSZRdZbNTQZYnI32vSnnDtKpQmeIUEMiQiP8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679610455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipH/7qh/XsDMwmrIBayEKIi9rym0oDV+8Lji6rbxIoY=;
        b=hK9mO2UaLcqM2FwQlPicHwbL2RtDJ3SeNOFzmkeRkEIT6O+QD3a6YleGWoL0tAI4n2
         s6sVGuGiASwoMrcnyS4UQnyLl1ciWj1NmUpScpn7eCDt5wU7UlM9pzOw3pJ7vb6n/V3w
         Zk/MQ5o3p4Of/8gKaiTiBGJOjWFF7CRXHCK/fG+cvG/5WtTFTIRrEvmiiNHwT2NRZvgS
         gDIg5nQ1gHCuWRPpE9mqvtc+znnvA6dhs36T81fahLksGkipd5ho+K4eikF7QIVe0UT7
         UwEUFJLNSc7RKNMemjgiF2EYK2bJPkONnszm8s5DIzzA9apP+ANpzLBfpOIwWYrK9/uw
         Njmg==
X-Gm-Message-State: AAQBX9eQWjVDiGzrA7QVcAjdvoMTZS+44iMwettSsXVYmEjpF22ecIIc
        Em+EbMY20mF/e1JoH7i4GVYfdntoqTE3vV91/NUHvA==
X-Google-Smtp-Source: AKy350Zr2Z3FqwLVw6GtvCn6d5K4RLatJpFIlYY2wdJn28EMtxZ8+dWOhEkibeYwhUcMhZA3IOoaqQ==
X-Received: by 2002:aa7:d6c4:0:b0:4fa:e187:64d1 with SMTP id x4-20020aa7d6c4000000b004fae18764d1mr810311edr.38.1679610455580;
        Thu, 23 Mar 2023 15:27:35 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id i28-20020a50871c000000b004fd204d180dsm9727536edb.64.2023.03.23.15.27.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 15:27:35 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id h8so947062ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:27:34 -0700 (PDT)
X-Received: by 2002:a50:c343:0:b0:4fa:cef4:a27f with SMTP id
 q3-20020a50c343000000b004facef4a27fmr537410edb.2.1679610454511; Thu, 23 Mar
 2023 15:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230323184537.749868-1-agruenba@redhat.com> <CAHk-=whms=0Cvmk946a0Pebv1YLWiuYCjyVy6yNeBp55+R8sMw@mail.gmail.com>
 <CAHpGcMKO-C=+wPprBGnOLeA+6_PJhHatO3fANizXNAtG2kYRcA@mail.gmail.com>
In-Reply-To: <CAHpGcMKO-C=+wPprBGnOLeA+6_PJhHatO3fANizXNAtG2kYRcA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Mar 2023 15:27:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiadgd7wJZiRptyMrQ22gCbyOFGqybX9sp=4gqewnMszQ@mail.gmail.com>
Message-ID: <CAHk-=wiadgd7wJZiRptyMrQ22gCbyOFGqybX9sp=4gqewnMszQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix for v6.3-rc4
To:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 3:22=E2=80=AFPM Andreas Gr=C3=BCnbacher
<andreas.gruenbacher@gmail.com> wrote:
>
> I've pushed the tag out now; should I resend the pull request?

No, all good, I have the changes,

                Linus
