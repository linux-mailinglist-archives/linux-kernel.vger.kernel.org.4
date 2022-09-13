Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021D55B6997
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiIMIbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiIMIbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:31:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1E32AA6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:31:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o2so16715955lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=o5fz4I+jeCHgXpS5/IEZbX8OYP0YH3mJV3lLyYIpEp0=;
        b=wYOEyJsHHCTSjLw1WzPnR5cuPD0FCdsqcvzomZVC+nUnpMmAXvermgIgD9XcG7gzC6
         U8++mH+Kffmc9iwBFATIOOg7SSib06LYpaSvnfcwPorVw2kLlMMo8pJg66jrxQLFX797
         Q3D/y0dUrIKEn0MnxAzbtCQMrKFjQ05fBkiRowggD65eIM6FL6RH4yVkW7vPW0cCElYn
         SHTDjPTC33dPWeirOCHZ/AVWdvhv/FSe00+vJRPpXguFuUdMFfGfwcAHCrzkbDRmFsDn
         Nrgc2IsLWyaZK9gO+TWdpFW42EVkf+SvdNZHxHBzkNtr8sBmhEp1MSytUsIQLR3pfKEP
         eLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=o5fz4I+jeCHgXpS5/IEZbX8OYP0YH3mJV3lLyYIpEp0=;
        b=vaPWz5xhsoJQVrajnwe9NgoEaRa09yR9Bs/AVPDORpql5FDeclY311MVcDSVXDJLiz
         eil5u1hnr9EXZH7erkrWqohg7u6dpg82JQ2pJpWH88vhcwlPaqBPMynbylMoCSsbuwJZ
         dkCAHwYlZGPqddz5KpjcFZoYJCFFt+G/uwOXR+dKzby6/rt5Ogea9im2uyFNoZ2eCII4
         b4Rzbrv2k03qzHG41IKROzYTZN6NzJYFqPQe+3hjBejfuN8r66PWXprZqoP6MKHDq6Wi
         3ktmnOuLR0AtpJAet28ZE0RVc4iVdY8+8qAu5iaFHQBzyK40EGeMmTwC3dkcOfY8Cz38
         mAYA==
X-Gm-Message-State: ACgBeo2iSpmLBs21B0k8mn0K9qOw2/L80wAean9vRNlSKkYSVTmectH+
        TK8t09jcXYgfiyNu8OvGJpvgd2fdoPjadZ0UMxfNzQ==
X-Google-Smtp-Source: AA6agR4r1OwLhUWB8B3wHfwYUrpgJnBaDB1YfIrSkWzMDJ63DigNSimKlxLxQAcyT5JszbpLOTKhO6AsTR3rPEHcz/c=
X-Received: by 2002:a05:6512:3f0f:b0:498:fad9:db0d with SMTP id
 y15-20020a0565123f0f00b00498fad9db0dmr6229391lfa.46.1663057902828; Tue, 13
 Sep 2022 01:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220909130309.25458-1-vincent.guittot@linaro.org>
 <20220909130309.25458-7-vincent.guittot@linaro.org> <Yx+wKhhk5niBZMNO@slm.duckdns.org>
In-Reply-To: <Yx+wKhhk5niBZMNO@slm.duckdns.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 13 Sep 2022 10:31:31 +0200
Message-ID: <CAKfTPtBFTbQC8S+Y1pWwWcXY-u4xH2WTpxmvisVFFP=zK5=xww@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] sched/fair: Add sched group latency support
To:     Tejun Heo <tj@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sept 2022 at 00:18, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Sep 09, 2022 at 03:03:07PM +0200, Vincent Guittot wrote:
> > +     {
> > +             .name = "latency",
> > +             .read_s64 = cpu_latency_read_s64,
> > +             .write_s64 = cpu_latency_write_s64,
> > +     },
>
> You're still using the nice value here, right? If so, can you please use the
> filename "latency.nice" so that it's consistent with "weight.nice"?

This cpu.latency is not a nice priority but the signed offset used by
the scheduler at wakeup. On previous version you raised concern about
having a nice value for cgroup so I removed it for cgroup and directly
exposed the latency offset with cpu.latency similarly to the weight
that is exposed with cpu.shares.

Vincent
>
> Thanks.
>
> --
> tejun
