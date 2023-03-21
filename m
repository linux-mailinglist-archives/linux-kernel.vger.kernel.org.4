Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103E46C3840
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCURdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCURdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:33:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D40B410BA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:33:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso2207513pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679420015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=43gGm0gFCb+OT/ygQ1NSu5KGxbhCaTb5SwZlaHqE5aU=;
        b=vZLff5TdeSywcB/JeqmlzLnZaz4j9FMxlQUiIKZT0eaHBPBItXoeGATS6If328RWYI
         KW9DnyvnDKeU83HJX+hNTrcmtd0cHxVnr05SgxicHY1cFgR5chXH3dd8VQFk2AMARtfe
         2H5GB+H8JqNlir6d+7C53cSQJpoKWfd9/haOgVPaWIcHs9Gx4HZdDL2x8jpqQP9F2hYP
         DM5hDvsuS2v6uICk8jvpIF4q61KiHBJkSg1ah+47EOeJ76556O1+MIztbOi4rWEBAFeJ
         HACoiYUPaS7d/TOTqGKdzJMhcGd92QnMEmymW7cf0fplkgHWM2XU2SPxqeQrn4GH/Jhk
         GlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679420015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43gGm0gFCb+OT/ygQ1NSu5KGxbhCaTb5SwZlaHqE5aU=;
        b=XypRiJpGjxu3BdNzKCFmK9ywkj/zbaU+VPJ03CdCDn5G2rERYAIKms3VXp/Pn00MzY
         C/VCon0MF7Xz7geRWP1/Y0tDtPyypcYROCdndbaUJug7bRmalQkHmLyT4+sC9eQhKu6k
         +QFA5Bdowbw8aLSVmJTBFMyGhW+McUK+XY4iSAyc/PYaLrDZIkdPquxefj+2sncThLCq
         R3fnzjruHNZeN0e/CdwrXPp+EPPWozSO4lY6e8F5Sj69fA6m/hWuhRW4XEPtpPeTqsmX
         7x/fT4OmzwB+FEvhsmrpZqOZG/tPGNKNEWho39kZSQqJl+mFNHYDEzyEYQ4VCbQ3UnIZ
         Sfag==
X-Gm-Message-State: AO0yUKWrDsZA8cqUrJou7OZuf+DtqlDmn04e6xYOnuDxDVdfkmIeS90M
        /zTl4QtDNhyl1wudVlvEVy6aov/A8oWMM5P5cdJH3w==
X-Google-Smtp-Source: AK7set/N2pTt9LX0Tn50/zFTZrLH08vE+jWgdy18Q+yIwLIGtERzRewywnhZLToEnPKhLGjG/8jH95lsXFUBq9DHR2w=
X-Received: by 2002:a17:90b:24d:b0:23f:14c9:a606 with SMTP id
 fz13-20020a17090b024d00b0023f14c9a606mr204574pjb.6.1679420015136; Tue, 21 Mar
 2023 10:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230310160610.742382-1-james.clark@arm.com> <20230310160610.742382-4-james.clark@arm.com>
 <2992c337-e9e6-6023-8882-bbf8d87994a5@arm.com>
In-Reply-To: <2992c337-e9e6-6023-8882-bbf8d87994a5@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 21 Mar 2023 17:33:19 +0000
Message-ID: <CAJ9a7Vg62_nv8vM3M-6=q_XgQiQ1i47a4B7Pn90s+-Z_djgBRA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] coresight: Rename nr_outports to nr_outconns
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 at 17:18, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 10/03/2023 16:06, James Clark wrote:
> > Rename to avoid confusion between port number and the index in the
> > connection array. The port number is already stored in the connection,
> > and in a later commit the connection array will be appended to, so
> > the length of it will no longer reflect the number of ports.
> >
> > No functional changes.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-core.c  | 32 ++++++++---------
> >   .../hwtracing/coresight/coresight-platform.c  | 34 +++++++++----------
> >   .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
> >   include/linux/coresight.h                     | 10 +++---
> >   4 files changed, 39 insertions(+), 39 deletions(-)
> >
>
> ...
>
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 322d7273e122..cdf0d1def778 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -102,13 +102,13 @@ union coresight_dev_subtype {
> >    * struct coresight_platform_data - data harvested from the firmware
> >    * specification.
> >    *
> > - * @nr_inport:       Number of elements for the input connections.
> > - * @nr_outport:      Number of elements for the output connections.
> > - * @conns:   Sparse array of nr_outport connections from this component.
> > + * @nr_inconns: Number of elements for the input connections.
> > + * @nr_outconns: Number of elements for the output connections.
> > + * @conns:   Sparse array of nr_outconns connections from this component.
>
> s/conns/out_conns/
>
> Otherwise looks good to me.
>
> Suzuki
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
