Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4426CD247
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjC2Grj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2Grh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:47:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF41171E;
        Tue, 28 Mar 2023 23:47:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so10420043wmq.2;
        Tue, 28 Mar 2023 23:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680072455; x=1682664455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pURmXf3C+6Lyr1DANg1dRUTcG9qspuh+UUXNLgHMyY=;
        b=O8NqltXduGOxRNz+LaWXlzkJ1kyynfND+dv2J1WaTH3Si1cuxiN/6zSTW6Z3D2uISG
         Oe0s+LB/0mJakjhoMzVFMJVrIYlLWXMZHTkNXSRt7/I6aCDPUw1JGz5oECUtPZWOEyur
         OkT0NIkPVvhkSZXShkJmJhaqMrcoaYbtpqROvKTjoiaAt7tWTmgnkV23T5rPRe9S3Df+
         3ihvte78Y5seeJG7xYfNzylKFxxy1xQI2/SVLopN71bdxLkjFyMH8UC493hg6/tBWOJy
         1kqE3+o5b8hqxJ2QbB8skfrHAZFtSIyaaTqbBU0a/bID5kQqNqmnWl6S8o36bo0XpKsk
         q6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680072455; x=1682664455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pURmXf3C+6Lyr1DANg1dRUTcG9qspuh+UUXNLgHMyY=;
        b=kDlPJWKt1TnIGry2pWv0FlXAZ65cax3h6gzGoYfz6okqg0UBJl93/B5ESPZKGSc+1U
         NAZ+fIkCS74eSLMdaT5194DX3neswZR3AyZmqayogD6VHg7lpD/g/gZqp/C5Q5At+JNg
         LbAUs71SYOQvc5WZCd20d72n1vHnISujTKwE0c7wFpgC3fuP+nb4FlzyX97Q0aj0BcPI
         DfI7VrzClwuKMY7ObuecUi9RN6DQOt/aMe5aJKjP7tdhfkfyoPBxsgwpH6HJt6S9G/9O
         hF/uifZnS6nyXusZHogkHTwkZ47FvCPMlGRBn28Qjl8SkIepRZAwWbs3EO2b9bverxUF
         QHYA==
X-Gm-Message-State: AAQBX9d/OtVmbtSYlG8ayMmxH0gTH1JQ+oZUfW6V7bHuSRaTR1eeKLjc
        OEq3lBQFBYsVFJEesmQPahgbQZRwagzuiXVP3J4=
X-Google-Smtp-Source: AKy350bk3XHcs6A9wYZKuPQ9k6HB9557pzP7/8JGuFp75kPa+vMziFEou+IoeYCn14ICEJE3ZjZQmDZXJrs5FaSOSzI=
X-Received: by 2002:a7b:ce84:0:b0:3ef:6fee:803a with SMTP id
 q4-20020a7bce84000000b003ef6fee803amr6100502wmj.35.1680072454878; Tue, 28 Mar
 2023 23:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230313085911.61359-1-yangyicong@huawei.com> <DM6PR11MB4107255E167D98A000DC49FBDC849@DM6PR11MB4107.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB4107255E167D98A000DC49FBDC849@DM6PR11MB4107.namprd11.prod.outlook.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 28 Mar 2023 23:47:23 -0700
Message-ID: <CAM9d7cgeLdBoniAz64YrzSYKw2Y4ivy5DhEzReEzhm41M-nvSQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Support per-cluster aggregation
To:     "Chen, Tim C" <tim.c.chen@intel.com>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
        "shenyang39@huawei.com" <shenyang39@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Mar 24, 2023 at 11:09=E2=80=AFAM Chen, Tim C <tim.c.chen@intel.com>=
 wrote:
>
> >
> >From: Yicong Yang <yangyicong@hisilicon.com>
> >
> >Some platforms have 'cluster' topology and CPUs in the cluster will shar=
e
> >resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2 cache (for=
 Intel
> >Jacobsville). Currently parsing and building cluster topology have been
> >supported since [1].
> >
> >perf stat has already supported aggregation for other topologies like di=
e or
> >socket, etc. It'll be useful to aggregate per-cluster to find problems l=
ike L3T
> >bandwidth contention or imbalance.
> >
> >This patch adds support for "--per-cluster" option for per-cluster aggre=
gation.
> >Also update the docs and related test. The output will be like:
> >
> >[root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5
> >
> > Performance counter stats for 'system wide':
> >
> >S56-D0-CLS158    4      1,321,521,570      LLC-load
> >S56-D0-CLS594    4        794,211,453      LLC-load
> >S56-D0-CLS1030    4             41,623      LLC-load
> >S56-D0-CLS1466    4             41,646      LLC-load
> >S56-D0-CLS1902    4             16,863      LLC-load
> >S56-D0-CLS2338    4             15,721      LLC-load
> >S56-D0-CLS2774    4             22,671      LLC-load
> >[...]
>
> Overall it looks good.  You can add my reviewed-by.
>
> I wonder if we could enhance the help message
> in perf stat to tell user to refer to
> /sys/devices/system/cpu/cpuX/topology/*_id
> to map relevant ids back to overall cpu topology.
>
> For example the above example, cluster S56-D0-CLS158  has
> really heavy load. It took me  a while
> going through the code to figure out how to find
> the info that maps cluster id to cpu.

Maybe we could enhance the cpu filter to accept something
like -C S56-D0-CLS158.

I also wonder what if it runs on an old kernel which doesn't
have the cluster_id file.

Thanks,
Namhyung
