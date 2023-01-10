Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9D664DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjAJVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjAJVHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:07:08 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ED15C1E8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:07:06 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id n190so9776215vsc.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xm2CW4tIjxoBvS14BEQOj7+gnLosvMQqQyKZce400tI=;
        b=YZYNPcwFyd25oLnvboDFJKyEgBckGaR25y7amKytobrvtsAzHz1yTXMHcXLt1rC6ow
         aS1g7AIXL8ZWjhdSXvFxtXVkYKNbeVS9c/SjF1XtvjKE2/zC2SfTaQ+jUUFuR3U1ZeHi
         XQPkD2ZWUd+qh4K7hEhTQ8Ecl6kK0SKpXqAzMmv2CGdAANHmPVd6jSopglpsgW8mjZJc
         gY0qXCeQgaicmm3O0xvrfyMgygQyOlysfY7V5Ocx9KgSbBlIksKWJh2o2IqzgUlgpUBc
         /Pop/1ByL0d2KPtVBxfNSCmn7LPa5z7d7SJ8UoNJe7RoLg3vuiPbUEPFGjQ2XcRTYkUa
         xD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xm2CW4tIjxoBvS14BEQOj7+gnLosvMQqQyKZce400tI=;
        b=jeT6Un+TCMOrTKTOtnkItBq/UP9D90HqeoOU8TRYZ6EYdoS2stsgIkHXL0w19I8vAP
         HSt/bwIwm947ovYQUDLlUOJCq/0feSz7jsc15cA56kb8VMfH5rvFOm6SJCbxkjVEqJuI
         i2ks8TKweIUUhfQaFnPsC4lc7tJI02sZDzxcY2M7H4qI2xr6zRmB89UxMihFmf78wiz/
         JR7v2EKkcqY6iR3DxMjhRcmCdSqT7Jd9AGL93rHxscQInOCRdV58Wcx3w5B/cz3fyGXM
         PP3KzY2rIKoAYCeJRvfCVi4+XAAF40tybKjAQbGt3HZ0VFVQcIW49JqBphjlYsHvgVyt
         kYaA==
X-Gm-Message-State: AFqh2koATsCDp8uVleIRwxmXAVOFGly6fRCot2eg8hVNLyQS6bMveKGO
        XCBcsqrarX2qh4ltzxCZCBEWNFhoD1b146MpOu2u
X-Google-Smtp-Source: AMrXdXs5jx2KR+X+1wnfMJ1ahIlorbzhqCBh4Dph346OlCXidDA29fbpvKkVpsjONv5naL/XZon6YCLoZT3po3F6leo=
X-Received: by 2002:a67:e413:0:b0:3d0:a46c:744d with SMTP id
 d19-20020a67e413000000b003d0a46c744dmr1320170vsf.19.1673384825662; Tue, 10
 Jan 2023 13:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20230109234312.2870846-1-yabinc@google.com> <a7edcb0a-5f12-f6ab-8897-479fefe54c2f@arm.com>
 <CAJ9a7Vj=e6rSbD9ONKDY1vyuxms161f-vp0Y4mxkQgpm1oz6uA@mail.gmail.com> <3eae7596-2ad8-1574-22d1-696184a3fa30@arm.com>
In-Reply-To: <3eae7596-2ad8-1574-22d1-696184a3fa30@arm.com>
From:   Yabin Cui <yabinc@google.com>
Date:   Tue, 10 Jan 2023 13:06:52 -0800
Message-ID: <CALJ9ZPMaAQu4Pug-m-h6KM40pOofhpE1EkddBKz37WyBQGzEEA@mail.gmail.com>
Subject: Re: [PATCH] coresight: tmc-etr: Don't enable ETR when it's not ready
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have a reproducer for this or some more info?
> For example is it a regression or has it always been there? And on which
> platform.

It happens on Pixel 6 and 7. We collect ETM data periodically from some
internal dogfood devices. The problem has happened several times on
dogfood devices. But I am still trying to reproduce it locally.

We use the scatter-gather mode of ETR, and allocate a 4M buffer. In userspace,
we use simpleperf in Android to collect system wide ETM data. What is special
is, simpleperf disables and reenables perf events every 100ms to flush ETM
data to perf aux buffer.

Pixel 6 and 7 have hardware monitoring AXI traffic. The hardware finds ETR is
trying to read from or write to a low invalid address (like 0x2E0000). The
problem always happens right after the "tmc_etr: timeout while waiting for TMC
to be Ready" message. And in almost all cases, I can find a "timeout while
waiting for completion of Manual Flush" message from the previous session.

One log history is below:
[11484.610008][    C0] coresight tmc_etr0: timeout while waiting for
completion of Manual Flush
[11484.610177][    C0] coresight tmc_etr0: timeout while waiting for
TMC to be Ready
[11484.615367][    C0] coresight tmc_etr0: timeout while waiting for
completion of Manual Flush
[11484.615534][    C0] coresight tmc_etr0: timeout while waiting for
TMC to be Ready
[12089.486044][    C0] coresight tmc_etr0: timeout while waiting for
TMC to be Ready
AXI error report reading from invalid address

Another log history is below:
[76709.382650][    C5] coresight tmc_etf1: timeout while waiting for
TMC to be Ready
[76709.382852][    C7] coresight tmc_etr0: timeout while waiting for
completion of Manual Flush
[76709.382995][    C7] coresight tmc_etr0: timeout while waiting for
TMC to be Ready
[76709.384510][    C7] coresight tmc_etr0: timeout while waiting for
completion of Manual Flush
[76709.384649][    C7] coresight tmc_etr0: timeout while waiting for
TMC to be Ready
[76709.384838][    C0] coresight tmc_etr0: timeout while waiting for
TMC to be Ready
AIX error report writing to invalid address

It seems if the previous manual flush doesn't finish gracefully, ETR may not be
ready for the next enable (even after 10min as in the first log). And if we
continue to enable ETR, an invalid AXI IO may happen.

Thanks,
Yabin

On Tue, Jan 10, 2023 at 10:04 AM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> On 10/01/2023 17:48, Mike Leach wrote:
> > Hi,
> >
> > On Tue, 10 Jan 2023 at 09:30, James Clark <james.clark@arm.com> wrote:
> >>
> >>
> >>
> >> On 09/01/2023 23:43, Yabin Cui wrote:
> >>> Otherwise, it may cause error in AXI bus and result in a kernel panic.
> >>
> >> Hi Yabin,
> >>
> >> Thanks for the fix. Do you have a reproducer for this or some more info?
> >> For example is it a regression or has it always been there? And on which
> >> platform.
> >>
> >> Thanks
> >> James
> >>
> >>>
> >>> Signed-off-by: Yabin Cui <yabinc@google.com>
> >>> ---
> >>>   .../hwtracing/coresight/coresight-tmc-core.c   |  4 +++-
> >>>   .../hwtracing/coresight/coresight-tmc-etr.c    | 18 +++++++++++++++---
> >>>   drivers/hwtracing/coresight/coresight-tmc.h    |  2 +-
> >>>   3 files changed, 19 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> >>> index 07abf28ad725..c106d142e632 100644
> >>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> >>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> >>> @@ -31,7 +31,7 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
> >>>   DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
> >>>   DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
> >>>
> >>> -void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
> >>> +int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
> >>>   {
> >>>        struct coresight_device *csdev = drvdata->csdev;
> >>>        struct csdev_access *csa = &csdev->access;
> >>> @@ -40,7 +40,9 @@ void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
> >>>        if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
> >>>                dev_err(&csdev->dev,
> >>>                        "timeout while waiting for TMC to be Ready\n");
> >>> +             return -EBUSY;
> >>>        }
> >>> +     return 0;
> >>>   }
> >>>
> >>>   void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
> >>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> >>> index 867ad8bb9b0c..2da99dd41ed6 100644
> >>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> >>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> >>> @@ -983,15 +983,21 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
> >>>        etr_buf->ops->sync(etr_buf, rrp, rwp);
> >>>   }
> >>>
> >>> -static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
> >>> +static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
> >>>   {
> >>>        u32 axictl, sts;
> >>>        struct etr_buf *etr_buf = drvdata->etr_buf;
> >>> +     int rc = 0;
> >>>
> >>>        CS_UNLOCK(drvdata->base);
> >>>
> >>>        /* Wait for TMCSReady bit to be set */
> >>> -     tmc_wait_for_tmcready(drvdata);
> >>> +     rc = tmc_wait_for_tmcready(drvdata);
> >>> +     if (rc) {
> >>> +             dev_err(&drvdata->csdev->dev, "not ready ETR isn't enabled\n");
> >>> +             CS_LOCK(drvdata->base);
> >>> +             return rc;
> >>> +     }
> >>>
> >>>        writel_relaxed(etr_buf->size / 4, drvdata->base + TMC_RSZ);
> >>>        writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
> >>> @@ -1032,6 +1038,7 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
> >>>        tmc_enable_hw(drvdata);
> >>>
> >>>        CS_LOCK(drvdata->base);
> >>> +     return rc;
> >>>   }
> >>>
> >>>   static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
> >>> @@ -1060,7 +1067,12 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
> >>>        rc = coresight_claim_device(drvdata->csdev);
> >>>        if (!rc) {
> >>>                drvdata->etr_buf = etr_buf;
> >>> -             __tmc_etr_enable_hw(drvdata);
> >>> +             rc = __tmc_etr_enable_hw(drvdata);
> >>> +             if (rc) {
> >>> +                     drvdata->etr_buf = NULL;
> >>> +                     coresight_disclaim_device(drvdata->csdev);
> >>> +                     tmc_etr_disable_catu(drvdata);
> >>> +             }
> >>>        }
> >>>
> >>>        return rc;
> >>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> >>> index 66959557cf39..01c0382a29c0 100644
> >>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> >>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> >>> @@ -255,7 +255,7 @@ struct tmc_sg_table {
> >>>   };
> >>>
> >>>   /* Generic functions */
> >>> -void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
> >>> +int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
> >>>   void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
> >>>   void tmc_enable_hw(struct tmc_drvdata *drvdata);
> >>>   void tmc_disable_hw(struct tmc_drvdata *drvdata);
> >
> > There is no point in waiting for a timeout, and then carrying on even
> > when it is exceeded. As such this patch seems reasonable.
> > We should also apply the same principle to the ETF and ETB devices
> > which use the same tmc_wait_for_tmcready() function.
>
> +1
>
> I am fine with pushing this change, as it is doing the right thing.
>
> >
> > However - the concern is that this appears to be happening on starting
> > the ETR - there should be no outstanding AXI operations that cause the
> > system to not be ready - as we will either be using this the first
> > time after reset, or we should have successfully stopped and flushed
> > the ETR from the previous operation. This warrants further
> > investigation - should we be extending the timeout - which is already
> > at a rather generous 100uS, and do we also need to check the MemErr
> > bit in the status register?
>
> It would be good to dump the value of TMC_STATUS to see what is going
> on.
>
> >
> > As James says, we need details of when and how the problem occurs  -
> > as far as I know it has not been seen on any systems we currently use
> > (though could have been missed given the current code)
>
> +1
>
> Kind regards
> Suzuki
>
>
> >
> > Regards
> >
> > Mike
> >
> >
> > --
> > Mike Leach
> > Principal Engineer, ARM Ltd.
> > Manchester Design Centre. UK
>
