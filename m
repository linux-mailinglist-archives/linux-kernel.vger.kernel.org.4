Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1D714827
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjE2KpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjE2KpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:45:16 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D66DE;
        Mon, 29 May 2023 03:45:14 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565cfe4ece7so25019197b3.2;
        Mon, 29 May 2023 03:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357113; x=1687949113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjEDNzZxOop2VOG3TlruQByMALTvalbpgRkYicVySh8=;
        b=kO2I3xZBL5Fe6W44U6h5s0RTzUX1eBWFPWgeyLaB+aRoskBhW8J6xFuenfgi/xR6Wh
         IZRcy/wR/Zus7O3ZAFUC3RVR7HAr4Z3gzYddvxPIHRaxis8PczdXexDsOzSNucW1AIRp
         /3EXL3LfTJKYlHuuqeECSSOTiXyzytVrKZda+frNZ+aiXehejLzWaTlZyBMWCTdVQKOh
         p9+ACmhXzwYD/jXNtnBaaDnk+NV9rGfzojXroEzvf69Bao7ikkBVaSDJ5GdNbHSq1YKU
         D+LokY4GFBGAAmsFvdnP9eOuys0mkxoVRfOqLI2GmGtGeSd/DurcgCqC+JhBjSxOMyJO
         ZEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357113; x=1687949113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjEDNzZxOop2VOG3TlruQByMALTvalbpgRkYicVySh8=;
        b=ZVdWA7rJ+IqlQrcBP/OTzOpfjHKj6Ib2pRXPDhqygUpFzlgIN24OjFWrAILKBMgs6O
         YFyOzLeFN4jR+Yw5GgSlK/mLiA0qHrK99DKxnqjqBV2+oXqX8kPTCJNZr1D+JNPQMBo2
         nY5PiEDIhJkCmDWECJRXu/4m8BXaRG4fEiU/UzPwQpV1QepdbTKHHUXyAR1pnIhOAoVJ
         YO7Y8b3o20kzTT9b1KRRGL/DzeAVWtLV45X48duqaMxg1PU6HM2X88sUV+kjaBj+DJoI
         TZ4g8XPr5B4vK8RB2u3OUC9+BjHB0lOc2q8Zv5P195HmtLF5CmDQkv1BljQXFbAnig7w
         CD/w==
X-Gm-Message-State: AC+VfDycMiHlrnbYko553HT7s/MsY9DW755N8ZPHwL5WCU86XaDiDgq6
        7JDn5y4IoicuhCvhBh4sOTMF2YyabQAKA0dL1oE=
X-Google-Smtp-Source: ACHHUZ5QdR94nzDQt83x8V/WkILpLluqVkaeIbNyyg/QzdVwVfLHlHihL7XEiUJURDL+vQFPJVUBPDwPjEnUpzLbjCY=
X-Received: by 2002:a0d:df42:0:b0:565:9387:9c61 with SMTP id
 i63-20020a0ddf42000000b0056593879c61mr12169606ywe.7.1685357113318; Mon, 29
 May 2023 03:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcas5p4.samsung.com>
 <20230529052821.58175-1-maninder1.s@samsung.com>
In-Reply-To: <20230529052821.58175-1-maninder1.s@samsung.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 29 May 2023 12:45:02 +0200
Message-ID: <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array size
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     bcain@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, keescook@chromium.org,
        nathanl@linux.ibm.com, ustavoars@kernel.org, alex.gaynor@gmail.com,
        gary@garyguo.net, ojeda@kernel.org, pmladek@suse.com,
        wedsonaf@google.com, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Onkarnath <onkarnath.1@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 7:44=E2=80=AFAM Maninder Singh <maninder1.s@samsung=
.com> wrote:
>
> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
> writes on index "KSYM_NAME_LEN - 1".
>
> Thus array size should be KSYM_NAME_LEN.
>
> for powerpc and hexagon it was defined as "128" directly.
> and commit '61968dbc2d5d' changed define value to 512,
> So both were missed to update with new size.
>
> Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to =
512")
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Thanks for this!

There is no `From:` at the top. Since I cannot locate the patch in
Lore, did you mean to put both of you as authors perhaps? In that
case, please use a `Co-developed-by` as needed.

Perhaps it is a good idea to submit each arch independently, too.

The changes themselves look fine on a quick inspection, though the
`xmon.c` one is a global buffer (and there is another equally-sized
buffer in `xmon.c` with a hard-coded `128` constant that would be nice
to clarify).

Cheers,
Miguel
