Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79EC5C0525
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiIURMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiIURMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:12:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00939C21A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:12:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b75so6571495pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=ajBLBKaI44ECZqhF2xgXCf1ibf9L1UAIHak4RA/Lxtc=;
        b=QpgRvJU8sp/IsQeVADOrzTa8NqXxnsjCFtktvbnwZwIGxKmzKHp/Bw+9kLrcov7B6H
         7ckuYu5CclQbuROP5j6CRsgNzKHmqF1N5Mbn50BJJD2IsluHlelWvdQLxVRY4NThja6W
         g1Ue5gI+UBh/PtGNF8j3/ODJrTmQzApgMC3Rkl2uzS2CdY0VJFfGMqaEFef6kW3gn2rk
         Qc1F3/UCw+JzoHuusIE21N+wbU0H/KhCoW/ZA2ic6Vp8jJQ+SpYVQAwGIqhIRsacv2BI
         73DQWeEvr3CBY9WdBrB6EzNlEHcXROrpxzKT4TM7RRz3G9wuIrCbjHz2zN/luQGWroXe
         Q0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ajBLBKaI44ECZqhF2xgXCf1ibf9L1UAIHak4RA/Lxtc=;
        b=vYbO/MasU2czxfMBxJ0utr5ucpCM4gUH2TSgJmzyFWPn9XsRgURX8fy6KsT4rcLYqN
         9jfmjZXAz4H+xUTnC0jDg8vuTHmiLD/htF1ePV5UNisSyHLHV+3bYknz5mSzeT5T+yW4
         ts/TLV51qfX2YUn80AOe7NEW6bLxCVuSrylzRij+wrQjOTfFQbFYGx/s7ObwbqbuAfQB
         iRysiWaue/TwE6iGZ+CbwWx2a5ooZqp5snnOjH+5JdI/iyrXMHDWS+Xh76VyJp8x9at6
         /GkE8x3qgnc4ZCAR46NHUXSe9nkFkvh5Nc16Kce4zdE2tun366RlV73pLk16EH6R8/jo
         97IA==
X-Gm-Message-State: ACrzQf1w4i3hf8sPaM1PFutj+TYcjCM+X8FhvCiIztZRaws0N149+cFv
        +1BLnPPXWiAGBvqJJ6d04Q4=
X-Google-Smtp-Source: AMsMyM78LR2Ph+OVhhFxqi2HGibAjwj73HBOoFaBIUvH7bjWyjTICrlZI/EKwEP5QVUfx4GQKS6lIw==
X-Received: by 2002:a63:2546:0:b0:438:fe66:dc3 with SMTP id l67-20020a632546000000b00438fe660dc3mr26487803pgl.113.1663780334345;
        Wed, 21 Sep 2022 10:12:14 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p63-20020a625b42000000b0053e80618a23sm2467996pfb.34.2022.09.21.10.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 10:12:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Sep 2022 07:12:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
Message-ID: <YytF7MoZxeZ6tpCM@slm.duckdns.org>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org>
 <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
 <YyioI4iBFq8ib9JT@slm.duckdns.org>
 <20220921155521.qb3jb74nbjoenau6@airbuntu>
 <YytAa9a8DSyuJWhT@slm.duckdns.org>
 <CAKfTPtBCUu80dpGneyhsZneTtcqcm3DrVVoqv6rH60oX_vEz+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBCUu80dpGneyhsZneTtcqcm3DrVVoqv6rH60oX_vEz+Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 07:02:57PM +0200, Vincent Guittot wrote:
> > One option could be just using the same mapping as cpu.weight so that 100
> > maps to neutral, 10000 maps close to -20, 1 maps close to 19. It isn't great
> > that the value can't be interpreted in any intuitive way (e.g. a time
> > duration based interface would be a lot easier to grok even if it still is
> > best effort) but if that's what the per-task interface is gonna be, it'd be
> > best to keep cgroup interface in line.
> 
> I would prefer a signed range like the [-1000:1000] as the behavior is
> different for sensitive and non sensitive task unlike the cpu.weight
> which is reflect that a bigger value get more

How about just sticking with .nice?

-- 
tejun
