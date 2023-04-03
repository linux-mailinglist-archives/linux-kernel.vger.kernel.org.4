Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CF56D3EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjDCIbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjDCIbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:31:15 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15FF49C2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:31:13 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id k12so1723493qvo.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680510673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQ0DRg2iKfm5iL+YlhoQY3E/L2p8vxrwzgcX6elJoOY=;
        b=ROR5l8dvyTWoMCO0cc7BmYFaq/2ylHHx0ZpzjX8+1fQXCNWVKpll74qwB/GYHFuhKc
         6oM77oDDgI6cRb7RFbgFWUDihVasuxz5T9m1kYgVJ1oCDo+MncEw6TBcFnMHs6xNmI17
         qEzXWZY07aPrwAMKtIzk8BFN7T/hFI3vSoZ6xEeWynJidDVdDbvO6G7SpYm0dZfBS2SH
         RqrDYAhpY5iAVliQhgA9c9SnGcchPGZumwHGTj+x/tpbnhYbkZhjYTO4lMWwEGw3LscG
         G2i0aQmFWqssTp4gk/UnPFp5+4alvzMymT4xLuWwKdoa4yvi6QxwqnmwAbubHKBI+2on
         /SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680510673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQ0DRg2iKfm5iL+YlhoQY3E/L2p8vxrwzgcX6elJoOY=;
        b=b+TLXywADO4UmhkZ+On2Id6TBndWJPY4hAXjR/HIrj+4Qjued+fMwHohhsnaUZzfFA
         A8g6dmAJpCEBpnQ+RusMvYO2KyYtglgnJbhSoKLSlO55zYva1xbNAGVVebO4bCThCegy
         Fo63QFGfUk6dgK10o/erGFZbtLzwbOqP2zR54fSvtn5itDi0UYLQJZuanzR8Tg37NChD
         emb0TjFXbuoqPWWgRbJyYx2fW9go01Mnyg1T53J875RW/npSA9JvDjB/Pkcj+VcvJhtl
         25jKDu0+C/y+WUEPCDsUSwCQPotRenxLhhecEvBkloKGCr+xmcO+mDdS537yQNyhdi1L
         6nPQ==
X-Gm-Message-State: AAQBX9cA66Nm+vY1Zi56Z0Ep0lk1BeO6LiSjTEI2UuCH70tZrutTIY3x
        smHK0zVHbjP/a5XYBPhC3tjGlnntnFLUdrnsVvgZ/MaODAhv0L2S35jU/A==
X-Google-Smtp-Source: AKy350aSOduAGL8S6XLBrtGq+FcLxHEaGPlm3BOindsWMG/sF4glPJ9xsWf1dsiiZ5MxLb0u+chBHnmy71Hmxsv5iWk=
X-Received: by 2002:a05:6214:a53:b0:5a5:bce5:ec52 with SMTP id
 ee19-20020a0562140a5300b005a5bce5ec52mr6926174qvb.9.1680510672842; Mon, 03
 Apr 2023 01:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230327122527.3913496-1-peternewman@google.com> <ZCp/HX4YQLyOp0TE@FVFF77S0Q05N>
In-Reply-To: <ZCp/HX4YQLyOp0TE@FVFF77S0Q05N>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 3 Apr 2023 10:31:02 +0200
Message-ID: <CALPaoCjVnBnXpinpxBvZFrdqRd2OKuvpHaqjdCYJGOjFxVUMzA@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: pmuv3: dynamically map PERF_COUNT_HW_BRANCH_INSTRUCTIONS
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        will@kernel.org, catalin.marinas@arm.com, eranian@google.com
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

On Mon, Apr 3, 2023 at 9:24=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Mon, Mar 27, 2023 at 02:25:27PM +0200, Peter Newman wrote:
> > Based-on: https://lore.kernel.org/all/YvunKCJHSXKz%2FkZB@FVFF77S0Q05N
> > Based-on-patch-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Peter Newman <peternewman@google.com>
>
> Thanks for reworking the patch; the patch itself and commit message look =
good
> to me.
>
> I'd like to keep my S-o-b here for the code itself; could we please make =
the
> tags:
>
>   Co-Developed-by: Stephane Eranian <eranian@google.com>
>   Signed-off-by: Stephane Eranian <eranian@google.com>
>   Co-Developed-by: Mark Rutland <mark.rutland@arm.com>
>   Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>   Co-Developed-by: Peter Newman <peternewman@google.com>
>   Signed-off-by: Peter Newman <peternewman@google.com>
>   Link: https://lore.kernel.org/all/YvunKCJHSXKz%2FkZB@FVFF77S0Q05N
>
> That follow the conventions documented in:
>
>   https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Yes, of course. I'll send an update shortly.

Thanks!
-Peter
