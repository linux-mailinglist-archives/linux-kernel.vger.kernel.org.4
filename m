Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112C85C04BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiIUQxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiIUQwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:52:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F329B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:48:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 207so6498982pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=/liW1qFYl/y6UrXav3eM11mYudj72cQq74iqPa7PHOU=;
        b=nLZejgyw1SYn1NN5mIEXLlYJ5HgHbVVwHISf5mLxhwbIaKu5C2qZEqeUtEkIQUEoP0
         8gW+S2p9vzqOukem8SLt6TV+4x3IEJi9zZ3N90Vlx8gRPWJaOUbQUZriz3G0M263Np3E
         lplITQMPTgx0+++ZgTYNFRgkZ6cW68pEClUepwOzgoxSN4tuctYWRbAWJZNYTQVxMQQ8
         9LgFImM6nNfJy6Tn7rCFpjzp3A+iuaMsFoBzmji9I2Rkm/h70oV3bRt7XJITeDu8ouZY
         csWznXywohwEbZxdXQkzv+mVBNipdnNgD3QUENm3oLf43eOrlJE2bFbngKyRmBeRp1HP
         40iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/liW1qFYl/y6UrXav3eM11mYudj72cQq74iqPa7PHOU=;
        b=BeB/YRTOadvEfzbLVR8my/w4qHRHfnFiHHRlKbbj5OWciW7XhSvPXWpsxrA75T7T09
         iRVYlgxtplpqyVED5yv8MQkAr3cn+6I6WXpe+RxhryQAcNRFFYBHFvV0igcdX62b+wpc
         mu64zr18JJ9MIqg5Db4Q4l22ekMdfPh5Hg7jhNYmHF1arLOslBBKED61lRX6HCcIf9UE
         GAaf3DbJd/rnCE/hLAQEnjI29mV3QLZ/KP+7Q0WYZ6HWCAsIlStVUGeDGVFoaI96io2r
         NY5ARkRA49ysYI4PdM6MCi+tJqC+lGKi9sf4bx7V300lfrUDyiVpXUqZQozoDlT9zXMZ
         lBkg==
X-Gm-Message-State: ACrzQf0Je5Km/04Sh8Y4wYwYh5QZGidMc15xSOp+osbBtudRslcmt0OB
        HhHnkjJho+e9zHfBZRkXPcE=
X-Google-Smtp-Source: AMsMyM7HAQcUErQtj6estDMz+rxgEZ0Z94bVqdgFXZWdIJMkw4T7Fyv+SiwT7MArRDnzpgdHVRV/rQ==
X-Received: by 2002:a05:6a00:1d26:b0:54e:8c81:9f64 with SMTP id a38-20020a056a001d2600b0054e8c819f64mr17249134pfx.58.1663778925772;
        Wed, 21 Sep 2022 09:48:45 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 9-20020a621409000000b0053e6eae9668sm2417284pfu.2.2022.09.21.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 09:48:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Sep 2022 06:48:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
Message-ID: <YytAa9a8DSyuJWhT@slm.duckdns.org>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org>
 <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
 <YyioI4iBFq8ib9JT@slm.duckdns.org>
 <20220921155521.qb3jb74nbjoenau6@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921155521.qb3jb74nbjoenau6@airbuntu>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 21, 2022 at 05:07:38PM +0100, Qais Yousef wrote:
> Wouldn't cpu.latency.nice be enough? I think the latency_offset is
> implementation detail that userspace shouldn't be concerned about.

One option could be just using the same mapping as cpu.weight so that 100
maps to neutral, 10000 maps close to -20, 1 maps close to 19. It isn't great
that the value can't be interpreted in any intuitive way (e.g. a time
duration based interface would be a lot easier to grok even if it still is
best effort) but if that's what the per-task interface is gonna be, it'd be
best to keep cgroup interface in line.

As for whether a single value would fit the bill, it's again something which
should be answered for both task and cgroup based interface at the same
time. That said, my not-too-throught-through opinion is that a single value
for per-task / per-cgroup interface + system level knobs to fine tune how
that actually applies is likely enough and probably better than exposing
exposing a host of internal details to applications directly.

Thanks.

-- 
tejun
