Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83FC6D4C03
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjDCPfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjDCPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:35:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83559271E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:35:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso30942549pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680536119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32740/cMAYm8/THAakLpza6FUQDhvi2xnglpmtIgpUI=;
        b=kZSDskwVVVzdtMyx7OA2mZB85IWG3DBMQDw/p2e37xpuOpfuJGOSpD8LEYzXicYhsy
         hlJHkAuWIWaarfXIZ6aI/v+pxFUEeVIr4btwWhtr1S7aZIFM8IUKJb+YZM/NqdYHzBY2
         h9PCEegjuw17hSj0GGN89lhEUeF05TsUdFDw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32740/cMAYm8/THAakLpza6FUQDhvi2xnglpmtIgpUI=;
        b=M5gvxCLqxV11E2RNaC/HcENPy2pzwJ2rBtyoDqsVXQRhfteQNOKxPgvtuyKQViSlEe
         JA9gYlCTJ4Uu1T/hYZZLZo8UbTlw7Yt7+JWxYS9xqR97LYIM4SCfVgi25QmSSR6l8Vf9
         8lszjApGJ9be8Y0XduXsT5rhhsQHwEPxPuDCDcfDmSoKGYuhf1aKhptJxQOqqcv2VCJP
         Wv9NsYKkVQLu2D4JQW/lTfbMm4CQyGNACIwHSEOtZWLHhnmGwfNoV/bSbHIRpC/od5BW
         QULd+KMTk7ANE4fz7OTVFdLiC5C+cxCS+7lb4rBu7CswHidLUsn8eVOnPwzNnBhuPZEK
         tGyw==
X-Gm-Message-State: AAQBX9cuLNKu5SxPOe1fiqilYcIB0zzaU/cwD9cBeifyLRkprEjGC6bg
        sS2BI+j9CvEvIcyr9r6TuRMg2Jpr9z2L1lc8NK0=
X-Google-Smtp-Source: AKy350ZR63Age5Yvph0l6UG8u9mxJJIcxx26SXtGVBmg22929If3riPjWFhrLmsNRVIdRly4+xVkgA==
X-Received: by 2002:a17:903:234f:b0:1a1:f0ce:bb51 with SMTP id c15-20020a170903234f00b001a1f0cebb51mr41946635plh.5.1680536119561;
        Mon, 03 Apr 2023 08:35:19 -0700 (PDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com. [209.85.210.171])
        by smtp.gmail.com with ESMTPSA id n12-20020a6563cc000000b004fcda0e59c3sm287073pgv.69.2023.04.03.08.35.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:35:18 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id l14so19430458pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:35:18 -0700 (PDT)
X-Received: by 2002:a63:a102:0:b0:513:97bc:5757 with SMTP id
 b2-20020a63a102000000b0051397bc5757mr4528550pgf.4.1680536118030; Mon, 03 Apr
 2023 08:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
 <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org> <CAGRrVHx4S0VxMQ-76i3sQQNLUBKbHr_wJdLhJ8F9D6R=UoCLAA@mail.gmail.com>
In-Reply-To: <CAGRrVHx4S0VxMQ-76i3sQQNLUBKbHr_wJdLhJ8F9D6R=UoCLAA@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 3 Apr 2023 17:35:06 +0200
X-Gmail-Original-Message-ID: <CANiDSCv5eKGgQ3f6jstoo9X0Je3T63waVrPH3nth4-280+rcdw@mail.gmail.com>
Message-ID: <CANiDSCv5eKGgQ3f6jstoo9X0Je3T63waVrPH3nth4-280+rcdw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
To:     Ross Zwisler <zwisler@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ross

On Fri, 31 Mar 2023 at 21:14, Ross Zwisler <zwisler@kernel.org> wrote:
>
> On Thu, Mar 30, 2023 at 3:45=E2=80=AFAM Ricardo Ribalda <ribalda@chromium=
.org> wrote:
> > Make sure that the .text section is not divided in multiple overlapping
> > sections. This is not supported by kexec_file.
>
> How does this interact with patch #1 from this series, which IIUC
> allows us to handle the case where the .text section is split between
> .text and .text.hot?  Do we still need that patch, but only for
> non-x86 platforms?  Or do we need both, and this patch will need to be
> replicated for other arches?

Patch 1/2 is a must. Patch 2/2 is a nice_to_have and would be great to
have a similar patch for every arch... but I do not feel confident
enough to send it for every arch :)

If we have linker scripts for all the arches do we need 1/2?
I think so, because the user might want to load a kernel <6.4 built
with clang > 16.

Regards!


--=20
Ricardo Ribalda
