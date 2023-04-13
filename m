Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E996E134C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjDMRQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjDMRQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:16:09 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2097D9C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:16:08 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id h198so22699514ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681406167; x=1683998167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=01u2RSetmwdr6j5URpo3R1w4ezs7Fk00UyijVasf6GU=;
        b=oZLJ+jTrUqDJjU+ptRIzgR8blRolbPS4dtnpbHYrU1FG2egztMNAZLdnTS7zeAf7BK
         oGAMbZheRCsTGNViFHoJxhvvQHuQ99+bmlOuzRG/COVIzezThUM9E5HGbDWddD/vVdjX
         DuYiTVfHhKTuRKgTDwCf6sXsSbNl5LjVQ3o81BW1bj3vJI86F1c4LMHL2qotX8Sr4G6e
         kyaYiZ5Q9uEFz+vuPMXjbTDZfm3pHS+fPeFwdZn7kBxw8vIQnmzhstx47zJsjFw7QUmg
         ul3pKxhxxJAJpBTKPs93NCcl3YiBzlLP8NjMij8JTALuowp8rmFe+tIcsj+fmNhYqdD/
         d6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681406167; x=1683998167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01u2RSetmwdr6j5URpo3R1w4ezs7Fk00UyijVasf6GU=;
        b=U5Ds+UPcTtUDyZkciu6aVpeVi8Mjz9EWLvxHMYee/LcAWucevApurIlEg1W6pxQEaA
         3ZDJjvFiFrzlgps1S8tj9m2Gjo6bqNgprzIwZqr+5jEfR7SKz08+j+dup5lByVpq0am2
         cH4fBiGe31UJ111pwpy0t7jSKFmnMMzZ24YxSPQeJvLicVB9WEMBsOSGVYow8DUy2y+E
         v24LD6EB6QjBPv9BJioKUGHWsTtjC3A+kQhfCC4xh3PiItaTTLg3L00PWuArg8uEPiwG
         ZUn7+zjqsU5xi7BbslGOLe9M6w/00LK954pbdMwJayNmgPqkjzJnfa/ExMg6kaRRO7j9
         7YHg==
X-Gm-Message-State: AAQBX9eQMFmQ712MNZgAtpUTg/5B2KxL7TTWyfrPWHS0qV+87cimfBmP
        ea4xT9F/ccpXzx9T42ag2oRSVh6ru9u3Lm39Ww==
X-Google-Smtp-Source: AKy350bN9z/h6v597xP8mdXeV5hOF4vvOZNQzjaLMemAL7d9EG5xx/SK8iopAqO8uh1rjXkGdKSY9DVJwvbA4pcgrIs=
X-Received: by 2002:a25:748e:0:b0:b6c:2d28:b3e7 with SMTP id
 p136-20020a25748e000000b00b6c2d28b3e7mr1851661ybc.9.1681406167525; Thu, 13
 Apr 2023 10:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvZ=Y1psyd0nmfzm6GhqMKvq5V_NQCWb_X02nasp1CpfcQ@mail.gmail.com>
 <87r0spcuvi.fsf@intel.com> <CALjTZvao=N7wxyj_DpqzWUhdJwEsWSKUo3ddi-3ubgMp8BXi_Q@mail.gmail.com>
 <CALjTZvaf1cwcZc9O8g24SnZXsoQaWB97UVQW=g6M0coaudLr6w@mail.gmail.com>
 <2495408f-a644-4e56-aaca-e6915cbda179@paulmck-laptop> <CALjTZva=JHsckrBeHgJcd-_TDMgYgmZGcXavJ=GhPr7VQCOF5g@mail.gmail.com>
 <1384f15b-228f-4a6b-8ac3-d0437db8bc1c@paulmck-laptop>
In-Reply-To: <1384f15b-228f-4a6b-8ac3-d0437db8bc1c@paulmck-laptop>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 13 Apr 2023 18:15:56 +0100
Message-ID: <CALjTZvZUmrkrnPb0=pqT8C-KsQ64bFKBdzpuaV0_O0-m2xEV7g@mail.gmail.com>
Subject: Re: [BUG?] INFO: rcu_sched detected expedited stalls on CPUs/tasks: {
 0-.... } 3 jiffies s: 309 root: 0x1/.
To:     paulmck@kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul,

On Thu, 13 Apr 2023 at 17:21, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Been there, done that!
>
> And actually, it is kind of reassuring that the Linux kernel avoids
> tens-of-milliseocnds latency blows in the common case on your system.

Especially since we're talking about a HZ=100 non-preemptive kernel. :)

Rui
