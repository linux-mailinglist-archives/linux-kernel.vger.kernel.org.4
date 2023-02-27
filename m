Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E506A470A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjB0QcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjB0QcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:32:07 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4E522DDE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:32:04 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-172afa7bee2so7946850fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ykAX5woDC3mRymPiVbbo2VDyZOKxKj2NLBbdN7+oOMM=;
        b=UOMDtGg/ynZ88DEpE4VpZTUV/FqnKD2fz36KU1mFrdJcOjwJ11QbKCwi8XskEylpD6
         JL0Tmsi64RQPL6ycJ8QDaTA38JZ9v6TV7nYLxGyPrLIis+q0tF3xkrKDQpMfuvH9V/j5
         VPLG/Zg0GPTzNUFKdyhRDHMygvqPqsQGeGG3pUX3wVF3jr40EqKekxaLFi/JWqxZPSvN
         YeFEoYbW8YyCaGCh54Sq2IjApJCBHWa85rxtYPi6hlscN3sI/zsEov007TfsEG6/qcIP
         yBm4j3qVKc2QzlB/GJwstBiBpZVq2eVxwL/8Zt3pBpRRnck4nuPSKTlLn1sZ0Z1tUZrg
         2m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykAX5woDC3mRymPiVbbo2VDyZOKxKj2NLBbdN7+oOMM=;
        b=UIRu0+I/8gTZwXnomxnKcavf8Ap9u8X7UtHZbCvlnHzg1nOc5K9A/9stdi/54x9mSo
         7/5wMRema38YV5kSkyH9BI/U9p9/cshoVDOSiTsC4PrDmYwdneuovQxAm/hyhbY//dOk
         D4Kmfus2Dlb7YpRdsEtBwzpEfJNf6NPs7tc75u521hQQCSTfbgh1RO5zPHLfXE5jU0Tq
         uv1Khn6uJehLxqj3iaPfuoucCTbJJfCvAsaPTrZixY+QYPxu3BArcTnmqCFeHz2LmhvW
         OKGd7wAbjh/l8gxaRd4Wdfed097JdbAA5wsDKP2RFO8hyZ9rNV53p5kGRACCFAcUrJf8
         iLIQ==
X-Gm-Message-State: AO0yUKVHz8/A3XRr34sw4a8uos9RbIXE1uF5OGNeRtc6oajez8kospy0
        86lATFSjsrbLGh6EmIdXoGw=
X-Google-Smtp-Source: AK7set8JrmQPXI/+U9esCHo92SVr2hSyJywv45zSD2QlNF5cOT/7jtM6w7j7MSiA3lYY8GEvpc/57Q==
X-Received: by 2002:a05:6871:29c:b0:172:6cfc:6ff4 with SMTP id i28-20020a056871029c00b001726cfc6ff4mr11441076oae.41.1677515523473;
        Mon, 27 Feb 2023 08:32:03 -0800 (PST)
Received: from ArchLinux ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id q190-20020a3743c7000000b00742a23cada8sm2895394qka.131.2023.02.27.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:32:03 -0800 (PST)
References: <20230227075346.69658-1-schspa@gmail.com>
 <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.7.5; emacs 28.2
From:   Schspa Shi <schspa@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, cocci@inria.fr, mcgrof@kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        buytenh@wantstofly.org, johannes.berg@intel.com,
        gregkh@linuxfoundation.org, tomba@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch
Subject: Re: [RFC PATCH] cocci: cpi: add complete api check script
Date:   Tue, 28 Feb 2023 00:10:35 +0800
In-reply-to: <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
Message-ID: <m2ttz75ati.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Feb 27, 2023 at 03:53:47PM +0800, Schspa Shi wrote:
>> When DECLARE_COMPLETION_ONSTACK was used, the user must to ensure the other
>> process won't reference the completion variable on stack. For a
>> killable/interruptiable version, we need extra code(add locks/use xchg) to
>> ensure this.
>> 
>> This patch provide a SmPL script to detect bad
>> DECLARE_COMPLETION_ONSTACK(_MAP) API usage, but far from perfect.
>
> Documentation/process/submitting-patches.rst:instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>
> But also, wth is SmPL, the actual thing included is a coccinelle script.
>
Thanks for reminding.

>> This is a common problem, and a lot of drivers have simpler problem. The
>> fellowing is a list of problems find by this SmPL patch, due to the complex
>> use of wait_for_complete* API, there will still be some false negatives and
>> false positives. This RFC patch is mainly used to discuss improvement

There are still many defects in this script that are commented here.

>> methods. If we introduce the wait_for_complete*_onstack API, it will be
>> easier to modify these problems, and the patch rules of SmPL will be very
>> easy. In the process of trying to write SmPL scripts, I strongly recommend
>> introducing two onstack APIs to complete this operation.
>> 
>> file:/Users/schspa/work/src/linux/drivers/infiniband/ulp/srpt/ib_srpt.c::2962 was suspected to return a variable on stack
>
> What's with this retarded file path? Are you running on Windows or
> something daft like that?
>
> Please, make them relative to srctree.

It's the raw output from this coccinelle script running from macOS. So,
I did not remove the prefix from the file path.

>
>> file:/Users/schspa/work/src/linux/drivers/misc/tifm_7xx1.c::268 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/firmware/arm_scmi/driver.c::1001 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::595 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::491 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::538 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::645 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::3175 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2360 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2314 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2634 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1804 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1758 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::2034 was suspected to return a variable on stack
>
> These don't seem buggy, they take the whole DSI out -- which lives on
> stack too.
>

This RFC patch is only used to illustrate the complexity of this
detection. As rewritten in the comments, this coccinelle script is
already somewhat complicated, but it still cannot avoid false positives
and false negatives. For code writing like dsi, I think it is difficult
to cover it with coccinelle script. So I want to introduce the onstack
version of the API, so that the checking work will be much easier. It is
also much easier to read the source code. When you see such APIs when
reviewing the code, you can easily know that there are detailed
exception mirroring considerations here, instead of carefully reviewing
whether there are some implicit conditions to ensure that there are no
problems.

>> file:/Users/schspa/work/src/linux/drivers/net/wireless/marvell/mwl8k.c::2259 was suspected to return a variable on stack
>
> Heh, they seem to have the right idea but a buggy implementation.
>
>> file:/Users/schspa/work/src/linux/drivers/net/wireless/mediatek/mt7601u/mcu.c::317 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/net/wireless/ti/wlcore/main.c::6674 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/net/wwan/t7xx/t7xx_state_monitor.c::416 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::647 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::653 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/soc/qcom/rpmh.c::269 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/aic94xx/aic94xx_tmf.c::339 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_ctl.c::242 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1811 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2266 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1603 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2073 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1807 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1328 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/ibmvscsi/ibmvfc.c::2466 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::844 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::2334 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c::2297 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/lpfc/lpfc_nvmet.c::2119 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/ipr.c::5153 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/scsi_error.c::1157 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_main.c::1215 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c::996 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c::867 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/isci/task.c::317 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::1844 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2310 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2086 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2579 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::6752 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::4074 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/thunderbolt/ctl.c::604 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i2c/busses/i2c-hisi.c::206 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/s390/cio/vfio_ccw_drv.c::71 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/slimbus/messaging.c::154 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::894 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::932 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ctrl.c::377 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/usb/core/devio.c::1142 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/usb/core/hcd.c::2229 was suspected to return a variable on stack
>
> These do usb_kill_urb() in the fail case. IIUC this avoids the UaF
> problem this script is trying to finger, no?
>

This is a similar usage to DSI, with some implied conditions

>> file:/Users/schspa/work/src/linux/drivers/spi/spi-hisi-sfc-v3xx.c::337 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/bluetooth/hci_bcm4377.c::955 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c::336 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c::278 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::360 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::312 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::238 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/ata/libata-core.c::1558 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::285 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::233 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::262 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/lib/kunit/try-catch.c::76 was suspected to return a variable on stack
>> file:/Users/schspa/work/src/linux/sound/aoa/soundbus/i2sbus/pcm.c::264 was suspected to return a variable on stack
>> 
>> To fix this, we can add introducing two new API for this.
>> 
>> +
>> +void complete_on_stack(struct completion **x)
>> +{
>> +       struct completion *comp = xchg(*x, NULL);
>> +
>> +       if (comp)
>> +               complete(comp);
>> +}
>> +EXPORT_SYMBOL(complete_on_stack);
>> +
>> +int __sched wait_for_completion_state_on_stack(struct completion **x,
>> +                                       unsigned int state)
>> +{
>> +       struct completion *comp = *x;
>> +       int retval;
>> +
>> +       retval = wait_for_completion_state(comp, state);
>> +       if (retval) {
>> +               if (xchg(*x, NULL))
>> +                       return retval;
>> +
>> +               /*
>> +                * complete_on_stack will call complete shortly.
>> +                */
>> +               wait_for_completion(comp);
>> +       }
>> +
>> +       return retval;
>> +}
>> +EXPORT_SYMBOL(wait_for_completion_state_on_stack);
>
> So going by the 3 random samples above, only 1 would use this pattern.
>
> Does that mean you 'forgot' to audit all these results before proposing
> a fix?
>

I checked the output here, and there are instances of incorrect error
alerts in this output already pointed out in the previous comments.

> What does that mean for this script?
>

This RFC PATCH is intended to be used to discuss whether to add a new
API to simplify this detection and repair work.

>> Link: https://lore.kernel.org/all/20221115140233.21981-1-schspa@gmail.com/T/#mf6a41a7009bb47af1b15adf2b7b355e495f609c4
>> Link: https://lore.kernel.org/all/7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp/
>> 
>> CC: Julia Lawall <Julia.Lawall@inria.fr>
>> CC: Nicolas Palix <nicolas.palix@imag.fr>
>> CC: Matthias Brugger <matthias.bgg@gmail.com>
>> CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> CC: Ingo Molnar <mingo@redhat.com>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Juri Lelli <juri.lelli@redhat.com>
>> CC: Vincent Guittot <vincent.guittot@linaro.org>
>> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> CC: Steven Rostedt <rostedt@goodmis.org>
>> CC: Ben Segall <bsegall@google.com>
>> CC: Mel Gorman <mgorman@suse.de>
>> CC: Daniel Bristot de Oliveira <bristot@redhat.com>
>> CC: Valentin Schneider <vschneid@redhat.com>
>> 
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>  scripts/coccinelle/api/complete.cocci | 160 ++++++++++++++++++++++++++
>>  1 file changed, 160 insertions(+)
>>  create mode 100644 scripts/coccinelle/api/complete.cocci
>> 
>> diff --git a/scripts/coccinelle/api/complete.cocci b/scripts/coccinelle/api/complete.cocci
>> new file mode 100644
>> index 000000000000..d4cf32187180
>> --- /dev/null
>> +++ b/scripts/coccinelle/api/complete.cocci
>> @@ -0,0 +1,160 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +///
>> +//  Copyright: (C) 2023 Schspa Shi.
>> +//  Confidence: High
>
> I'm thinking that 'high' is somewhat premature, 2 out of 3 false
> positive rate does not inspire confidence.
>
OK, this definition is not appropriate.

>> +virtual report
>> +
>> +@r1 exists@
>> +declarer name DECLARE_COMPLETION_ONSTACK;
>> +declarer name DECLARE_COMPLETION_ONSTACK_MAP;
>> +position p;
>> +identifier done;
>> +identifier func;
>> +@@
>> +
>> +func(...) {
>> +...
>> +(
>> +DECLARE_COMPLETION_ONSTACK(done@p);
>> +|
>> +DECLARE_COMPLETION_ONSTACK_MAP(done@p, ...);
>> +)
>> +...
>> +}
>> +
>> +@locked exists@
>> +identifier func=r1.func;
>> +identifier done=r1.done;
>> +position p1,p;
>> +@@
>> +
>> +func(...) {
>> +...
>> +(
>> +mutex_lock@p1
>> +|
>> +mutex_trylock@p1
>> +)
>> + (...)
>> +...  when != mutex_unlock(...)
>> +done@p
>> +...
>> +}
>> +
>> +
>> +@elocked exists@
>> +identifier func=r1.func;
>> +identifier done=r1.done;
>> +position p1,p;
>> +expression e;
>> +@@
>> +
>> +func(...) {
>> +...
>> +e = &done;
>> +...
>> +(
>> +mutex_lock@p1
>> +|
>> +mutex_trylock@p1
>> +)
>> + (...)
>> +...  when != mutex_unlock(...)
>> +e@p
>> +...
>> +}
>> +
>> +
>> +@has_wait_for_completion exists@
>> +position p;
>> +identifier done;
>> +identifier func=r1.func;
>> +identifier fb = { wait_for_completion, wait_for_completion_io};
>> +expression e;
>> +@@
>> +
>> +func(...) {
>> +...
>> +(
>> +...
>> +fb(&done@p);
>> +...
>> +|
>> +e = &done;
>> +...
>> +fb(e@p);
>> +)
>> +...
>> +}
>> +
>> +@has_while_wait exists@
>> +position p;
>> +identifier done, ret;
>> +identifier func=r1.func;
>> +identifier fb =~ "wait_for_completion.*";
>> +expression e;
>> +@@
>> +
>> +func(...) {
>> +...
>> +while (...) {
>> +	...
>> +	ret = fb(&done@p, e);
>> +	...
>> +}
>> +...
>> +}
>> +
>> +@has_while_wait2 exists@
>> +position p;
>> +identifier done;
>> +identifier func=r1.func;
>> +expression fb =~ "wait_for_completion.*";
>> +@@
>> +
>> +func(...) {
>> +...
>> +while (fb(&done@p, ...) == 0) {
>> +	...
>> +}
>> +...
>> +}
>> +
>> +
>> +@r2 depends on (!has_wait_for_completion && !has_while_wait && !has_while_wait2) exists@
>> +declarer name DECLARE_COMPLETION_ONSTACK;
>> +position p!={locked.p, elocked.p};
>> +identifier done=r1.done;
>> +identifier func=r1.func;
>> +expression e;
>> +@@
>> +
>> +func(...) {
>> +...
>> +(
>> +wait_for_completion_interruptible(&done@p)
>> +|
>> +wait_for_completion_killable(&done@p)
>> +|
>> +wait_for_completion_timeout(&done@p, ...)
>> +|
>> +wait_for_completion_io_timeout(&done@p, ...)
>> +|
>> +wait_for_completion_interruptible_timeout(&done@p, ...)
>> +|
>> +wait_for_completion_killable_timeout(&done@p, ...)
>> +|
>> +try_wait_for_completion(&done@p)
>> +|
>> +wait_for_completion_timeout(e@p, ...)
>> +)
>> +...
>> +}
>> +
>> +
>> +@script:python depends on report@
>> +fp << r2.p;
>> +@@
>> +
>> +print('file:{:s}::{:s} was suspected to return a variable on stack'.format(fp[0].file, fp[0].line))
>> +
>> -- 
>> 2.37.3
>> 


-- 
BRs
Schspa Shi
