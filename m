Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DAF6C3540
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCUPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjCUPM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:12:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A902D4D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:12:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so16260609pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679411542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=khclnqREh0a54MjQ3ZopmU+htfHsWsbqIVUpZuPHZpQ=;
        b=BsoqHjpUm3lbDOEdEJSn4JOGCegeIJvrC/OFu7v1Jx76iSMyGusnWWtc/PUt6+kp/i
         QUWijX1QsRORYC0MQQ1t1a5KHYeRIQcynPJLuumCDlzn+Nbi4ZtI1rSBMXtwrSr2DczA
         bReO8w7Cbq++KUjN7NG6+e0r9lB9KLtG1lgJxgwoQM/qzcR1COCbXhXVF8Fgswtm2Tiz
         Uhcw6UhlPXcUPt6j9yg9YMe37csezAR+AsoVw8H+1xlVZXWBJp3iDw9qmjyJwJp1uRwn
         bMoWoicDk1LlVHLbPu7VuHOIOHAtujDNb4tyCU101aPGoI3eebBs8e3BQ9KXRbBypdi6
         EqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khclnqREh0a54MjQ3ZopmU+htfHsWsbqIVUpZuPHZpQ=;
        b=uTqdho1C7aybjkwNE7kusGUMOsOdmVoEJ2P9oYBHU10rOiIn/l5cThVtVLIcY+JVid
         k7L13XQfea3Op/d8aZqLna6vkZDMH6G/iSUJ2THkEDaWbICjmnAkanoW7+ySzN7Warva
         sr6O4xLANJsaRDaqJ2/cs3WGzKW70puqUdfiB1STn66Pe4/uHg1j31/79zEBVb46P/PX
         g2siTF2lYqbwlS94RYF843YCP3WY1VBjxM+tKu3aY5aD1jHGE+sftaR9HQznfcm15IHu
         g5v9zHPKl1+k3pCEu4yiOgA1ovCkhp3cdRdHWCSAmxzfDSPj7TQk3bXmCnsHMkcfKYwK
         jvJg==
X-Gm-Message-State: AO0yUKWDPC6ozPPsODT+NYURUqr1OtXEzfRFecNMssJIfgRTEe5XB2OR
        SPC6vZSMpYohTAytLdO29LaQTpxNMMBW9Ovs9SHguQ==
X-Google-Smtp-Source: AK7set91Q8TgJyyucgldMfUV885KvDB80V715jA5zxPoXnWNH3yPER5zTf3vboEtEzrpUPfwJGmhLJemWy886Qp2h64=
X-Received: by 2002:a17:90a:5507:b0:23f:c69:96e2 with SMTP id
 b7-20020a17090a550700b0023f0c6996e2mr52000pji.6.1679411542081; Tue, 21 Mar
 2023 08:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230310160610.742382-1-james.clark@arm.com>
In-Reply-To: <20230310160610.742382-1-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 21 Mar 2023 15:12:10 +0000
Message-ID: <CAJ9a7VhA0b_o_aYJisfey0XK7FadNfxkUapTQc3nE611RiyVRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] coresight: Fix CTI module refcount leak by making
 it a helper device
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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

Hi James

On Fri, 10 Mar 2023 at 16:06, James Clark <james.clark@arm.com> wrote:
>
> Changes since v1:
>
>  * Don't dereference handle in tmc_etr_get_buffer() when not in perf mode.
>  * Fix some W=1 warnings
>  * Add a commit to rename child/output in terms of local/remote
>
> -------------------
>
> Currently there is a refcount leak in CTI when using system wide mode
> or tracing multithreaded applications. See the last commit for a
> reproducer. This prevents the module from being unloaded.
>
> Historically there have been a few issues and fixes attempted around
> here which have resulted in some extra logic and a member to keep
> track of CTI being enabled 'struct coresight_device->ect_enabled'.
> The fix in commit 665c157e0204 ("coresight: cti: Fix hang in
> cti_disable_hw()") was also related to CTI having its own
> enable/disable path which came later than other devices.
>
> If we make CTI a helper device and enable helper devices adjacent to
> the path we get very similar enable/disable behavior to now, but with
> more reuse of the existing reference counting logic in the coresight
> core code. This also affects CATU which can have a little bit of
> its hard coded enable/disable code removed.
>
> Enabling CATU on the generic path does require that input connections
> are tracked so that it can get its associated ETR buffer.
>
> Applies to coresight/next (669c4614236a7) but also requires the
> realloc_array patch here [1].
>
> Also available in full here [2].
>
> [1]: https://lore.kernel.org/linux-arm-kernel/20230306152723.3090195-1-james.clark@arm.com/
> [2]: https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-cs-cti-module-refcount-fix-v2
>
> James Clark (9):
>   coresight: Use enum type for cs_mode wherever possible
>   coresight: Change name of pdata->conns
>   coresight: Rename nr_outports to nr_outconns
>   coresight: Rename connection members to allow for input connections
>   coresight: Dynamically add connections
>   coresight: Store in-connections as well as out-connections
>   coresight: Refactor out buffer allocation function for ETR
>   coresight: Enable and disable helper devices adjacent to the path
>   coresight: Fix CTI module refcount leak by making it a helper device
>
>  drivers/hwtracing/coresight/coresight-catu.c  |  34 +-
>  drivers/hwtracing/coresight/coresight-core.c  | 312 +++++++++++-------
>  .../hwtracing/coresight/coresight-cti-core.c  |  56 ++--
>  .../hwtracing/coresight/coresight-cti-sysfs.c |   4 +-
>  drivers/hwtracing/coresight/coresight-cti.h   |   4 +-
>  drivers/hwtracing/coresight/coresight-etb10.c |   3 +-
>  .../coresight/coresight-etm3x-core.c          |   6 +-
>  .../coresight/coresight-etm4x-core.c          |   6 +-
>  .../hwtracing/coresight/coresight-platform.c  | 178 +++++++---
>  drivers/hwtracing/coresight/coresight-priv.h  |   9 +-
>  drivers/hwtracing/coresight/coresight-stm.c   |   6 +-
>  drivers/hwtracing/coresight/coresight-sysfs.c |   9 +-
>  .../hwtracing/coresight/coresight-tmc-etf.c   |   2 +-
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  89 ++---
>  drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
>  drivers/hwtracing/coresight/coresight-tpdm.c  |   4 +-
>  drivers/hwtracing/coresight/coresight-tpiu.c  |   3 +-
>  drivers/hwtracing/coresight/coresight-trbe.c  |   3 +-
>  drivers/hwtracing/coresight/ultrasoc-smb.c    |   3 +-
>  drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
>  include/linux/coresight.h                     | 109 +++---
>  21 files changed, 530 insertions(+), 314 deletions(-)
>
> --
> 2.34.1
>

Looking at this overall - given that the only use of the in_conn is to
reference the connecting device from the helper,

i.e. coresight-catu.c:405:           tmp = csdev->pdata->in_conns[i].remote_dev;

would it not be simpler to :

a)
in coresight_connection add a field:

  struct coresight_device *origin_dev;

which mimics the origin / target model we already have in coresight_sysfs_link
then

b) the in_conns could simply be references to out_conn object from
origin_dev, rather than a complete coresight_connection  with reversed
values, thus simplifying the in_conns handling code, and removing the
unused reversed feilds in the current in_conn object.

e.g. tmp = csdev->pdata->in_conns[i]->origin_dev

The remainder of the code would remain much the same, just adjusted
for in_conns as refs rather than independent conn objects

Regards


Mike

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
