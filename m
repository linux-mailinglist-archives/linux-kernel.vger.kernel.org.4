Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775D8733654
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbjFPQoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjFPQoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:44:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D4A2D60
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:44:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-985fd30ef48so139875166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686933856; x=1689525856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlH6N4BeYWriIEzthku3f2s3TDY9tC006RTYxc81VbY=;
        b=fa3BWs6hKNUceKlPZqUdlR7I0P8QqsjOK+i/OFiac3mNZt2dxOUZOlmKSlTu5aYQsu
         EzcPzwmjqRXYlldsO6MYgpShNO/BNpVmFtcDWgrx+222WJXuhfVdfY01vmnfurSTrF84
         aFBqgk9j26KobSdQc17w8JcODnqZlcPFSePtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933856; x=1689525856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlH6N4BeYWriIEzthku3f2s3TDY9tC006RTYxc81VbY=;
        b=G3xyYsDL0Yk88X4BFjVFXSOuxtEJ5BYZ6YCO/ECuLsl/vVU9DjfSPNxLsSvBHvFVEi
         +2wgf/Z7I/nyeLJeN0k4UqBL9/nWtwFRg5fd6F2UU7QCxrPMQyQXNlFXLFS+cvPbRglx
         rbfHV7n3lsGgX/0YH3f6/1cS+rYOsniBWBJpFs7UKS8n8SU5dFc84i5mNCrDsmmCkW5Q
         v7MTsJWLCMwS/JToAA8cOpI5yFqXnd5bUWVbrudCIl6DQTLdekkhq1Omh/xmh7bNl0gq
         fUiWQcFAKZS/WaByTQcEzpAfwwqdBPN02WwYwjBJPdqE0KSXyxfDrsnrOfnGALcykOMv
         CZww==
X-Gm-Message-State: AC+VfDx+xzP+ReLcNfveVAG+oZT81TOS/ULf8XdvMNtgZ4z7NEcN18sO
        l2M/sa062O1rXYdTY5ZIYlOO1mbfKC1Bz2t4TNUC2Zbp
X-Google-Smtp-Source: ACHHUZ4nxeKrhIzmaI8R8cnQ5gnmjjhqx7B33pXZv+B7iXIA0d8YjSYi33GkkZHyNy/jZ+x1JmJiGg==
X-Received: by 2002:a17:907:9703:b0:95e:ce3b:a471 with SMTP id jg3-20020a170907970300b0095ece3ba471mr2787515ejc.55.1686933855925;
        Fri, 16 Jun 2023 09:44:15 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id w4-20020a17090652c400b009783791b1a1sm262211ejn.121.2023.06.16.09.44.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:44:15 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so9619a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:44:15 -0700 (PDT)
X-Received: by 2002:a50:bac3:0:b0:506:b280:4993 with SMTP id
 x61-20020a50bac3000000b00506b2804993mr233742ede.2.1686933854748; Fri, 16 Jun
 2023 09:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230616150618.6073-1-pmladek@suse.com> <20230616150618.6073-2-pmladek@suse.com>
In-Reply-To: <20230616150618.6073-2-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Jun 2023 09:44:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUWnjCAjZKb5wYcGhC=T8+hoUr+1junoH5ognge1aZHg@mail.gmail.com>
Message-ID: <CAD=FV=XUWnjCAjZKb5wYcGhC=T8+hoUr+1junoH5ognge1aZHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] watchdog/hardlockup: Sort hardlockup detector
 related config values a logical way
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 16, 2023 at 8:06=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> There are four possible variants of hardlockup detectors:
>
>   + buddy: available when SMP is set.
>
>   + perf: available when HAVE_HARDLOCKUP_DETECTOR_PERF is set.
>
>   + arch-specific: available when HAVE_HARDLOCKUP_DETECTOR_ARCH is set.
>
>   + sparc64 special variant: available when HAVE_NMI_WATCHDOG is set
>         and HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.
>
> Only one hardlockup detector can be compiled in. The selection is done
> using quite complex dependencies between several CONFIG variables.
> The following patches will try to make it more straightforward.
>
> As a first step, reorder the definitions of the various CONFIG variables.
> The logical order is:
>
>    1. HAVE_* variables define available variants. They are typically
>       defined in the arch/ config files.
>
>    2. HARDLOCKUP_DETECTOR y/n variable defines whether the hardlockup
>       detector is enabled at all.
>
>    3. HARDLOCKUP_DETECTOR_PREFER_BUDDY y/n variable defines whether
>       the buddy detector should be preferred over the perf one.
>       Note that the arch specific variants are always preferred when
>       available.
>
>    4. HARDLOCKUP_DETECTOR_PERF/BUDDY variables define whether the given
>       detector is enabled in the end.
>
>    5. HAVE_HARDLOCKUP_DETECTOR_NON_ARCH and HARDLOCKUP_DETECTOR_NON_ARCH
>       are temporary variables that are going to be removed in
>       a followup patch.
>
> This is a preparation step for further cleanup. It will change the logic
> without shuffling the definitions.
>
> This change temporary breaks the C-like ordering where the variables are
> declared or defined before they are used. It is not really needed for
> Kconfig. Also the following patches will rework the logic so that
> the ordering will be C-like in the end.
>
> The patch just shuffles the definitions. It should not change the existin=
g
> behavior.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/Kconfig.debug | 112 +++++++++++++++++++++++-----------------------
>  1 file changed, 56 insertions(+), 56 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
