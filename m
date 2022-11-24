Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30066370AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKXC4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKXC4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:56:49 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68703C8CA1;
        Wed, 23 Nov 2022 18:56:48 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id p12so224289qvu.5;
        Wed, 23 Nov 2022 18:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dI1MZvZaLiip1FFejTpEVVfZhR5T2i7rmYdZdskI5es=;
        b=oYoQiOuVQ0gpcQdhJ3u28N9sp8IFfK7CK/z+otstKcii5bZXTbe11zLBBcydM95MWR
         jYsr+EjuJV+7c7ax31pfbajTA64dFwNJXOK0USwIfdxXti85Aa7A7MgLm9z95E5sw6Zl
         GfOQCt4d+8DJZRyWf2w4JbW8uUebuXU07vimdsdLIeWIm1gWl0F1dOotjj0/AqDccsp4
         yywRp5TsHzqNPjQs8VpbT1999TsQXrs7mmz5RbGpKp38e49sdEX54Nq+iY07qC69jP9j
         W/pjiVk1EfyOFaOT52Oj7QzIzE6cMRpfXfpmzjCEbHc6dhE/zU2ifzn38WLf5+uZh/7J
         3XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dI1MZvZaLiip1FFejTpEVVfZhR5T2i7rmYdZdskI5es=;
        b=eLjHWj2q49vzq2fBq0XD1qlKWHgph/6HeZzwfOUanl+HfaWSEO+FLMiDhlUqiH2MFD
         XuFbQFZQpLoHouMYk5InRsd1L1er2vJteBXeRtWExy7UGRbBAFfuhXKqrevNczeY68rR
         J5xBKyG+nmLASEgUTZhJ3pqk1KSfHSy/aw3aDM1wS/tQaaT8nW2aIP+SGvw6QTVOEW/z
         54kgrMHRUm+UvviiG94MiT4aQfGlJgTXc8icAR8c/po+dKxQtqccox24TMeY0Iyfrv2B
         L19tdAFwkoWYE8eHy6wc7jYlxIydfN0tSQtZWvXVCLBQhvTjSYeZmGtTSnLW6OtLAtZV
         LHPw==
X-Gm-Message-State: ANoB5pmpR7VQwu7sg8XxB7OTI4/cxEvpEILctKZmji86rwVEVxfM57i5
        sgfPnMtGP/vFfL4GnRRZnkY5YHNN99cGSQ7eA/dZVVu7F1avCg==
X-Google-Smtp-Source: AA0mqf4c0TpD7QVDCcuTskoOoVy5YGvqtUoUqVj0BfCQPXEQb2xxIcg8HNaOhby4C2AFtnha0fVSCrCEyKjpbKD2Olc=
X-Received: by 2002:ad4:50ac:0:b0:4bb:ce03:5714 with SMTP id
 d12-20020ad450ac000000b004bbce035714mr17761676qvq.30.1669258607544; Wed, 23
 Nov 2022 18:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20221118054725.80414-1-michael@allwinnertech.com>
 <CA+Da2qxP2gvUc2=n5xW7_YEcgevGpDhqbcVFWVbF0c6DqXDXHA@mail.gmail.com> <23c0a4ae-d714-cfb1-aeb5-68b66b5bf0ee@allwinnertech.com>
In-Reply-To: <23c0a4ae-d714-cfb1-aeb5-68b66b5bf0ee@allwinnertech.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Thu, 24 Nov 2022 10:56:36 +0800
Message-ID: <CA+Da2qwXLapwUDX+GrFkNQE9so2Tj=ymY1YS396J_N_c+9EHYw@mail.gmail.com>
Subject: Re: [PATCH] mmc:mmc-hsq:use fifo to dispatch mmc_request
To:     Michael Wu <michael@allwinnertech.com>
Cc:     ulf.hansson@linaro.org, wenchao.chen@unisoc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 2:19 PM Michael Wu <michael@allwinnertech.com> wrote:
>
> On 11/18/2022 7:43 PM, Wenchao Chen wrote:
> > On Fri, Nov 18, 2022 at 1:52 PM Michael Wu <michael@allwinnertech.com> wrote:
> >>
> >> Current next_tag selection will cause a large delay in some requests and
> >> destroy the scheduling results of the block scheduling layer. Because the
> >> issued mrq tags cannot ensure that each time is sequential, especially when
> >> the IO load is heavy. In the fio performance test, we found that 4k random
> >> read data was sent to mmc_hsq to start calling request_atomic It takes
> >> nearly 200ms to process the request, while mmc_hsq has processed thousands
> >> of other requests. So we use fifo here to ensure the first in, first out
> >> feature of the request and avoid adding additional delay to the request.
> >>
> >
> > Hi Michael
> > Is the test device an eMMC?
> > Could you share the fio test command if you want?
> > Can you provide more logs?
> >
> Hi Wenchao,
> Yes, the tested device is emmc.
> The test command we used is `./fio -name=Rand_Read_IOPS_Test
> -group_reporting -rw=random -bs=4K -numjobs=8 -directory=/data/data
> -size=1G -io_size=64M -nrfiles=1 -direct=1 -thread && rm
> /data/Rand_Read_IOPS_Test *`,  which replaces the io performance random
> read performance test of androidbench, and the file size is set to 1G, 8
> thread test configuration. Where /data uses f2fs and /data/data is a
> file encrypted path.
>
> After enabling the hsq configuration, we can clearly see from below fio
> test log that the minimum value of random reading is 3175 iops and the
> maximum value is 8554iops, and the maximum delay of io completion is
> about 200ms.
> ```
>      clat percentiles (usec):
>       |  1.00th=[   498],  5.00th=[   865], 10.00th=[   963], 20.00th=[
>   1045],
>       | 30.00th=[  1090], 40.00th=[  1139], 50.00th=[  1172], 60.00th=[
>   1221],
>       | 70.00th=[  1254], 80.00th=[  1319], 90.00th=[  1401], 95.00th=[
>   1614],
>       | 99.00th=[  2769], 99.50th=[  3589], 99.90th=[ 31589], 99.95th=[
> 66323],
>       | 99.99th=[200279]
>     bw (  KiB/s): min=12705, max=34225, per=100.00%, avg=23931.79,
> stdev=497.40, samples=345
>     iops        : min= 3175, max= 8554, avg=5981.67, stdev=124.38,
> samples=345
> ```
>
>
> ```
>      clat percentiles (usec):
>       |  1.00th=[  799],  5.00th=[  938], 10.00th=[  963], 20.00th=[  979],
>       | 30.00th=[  996], 40.00th=[ 1004], 50.00th=[ 1020], 60.00th=[ 1045],
>       | 70.00th=[ 1074], 80.00th=[ 1106], 90.00th=[ 1172], 95.00th=[ 1237],
>       | 99.00th=[ 1450], 99.50th=[ 1516], 99.90th=[ 1762], 99.95th=[ 2180],
>       | 99.99th=[ 9503]
>     bw (  KiB/s): min=29200, max=30944, per=100.00%, avg=30178.91,
> stdev=53.45, samples=272
>     iops        : min= 7300, max= 7736, avg=7544.62, stdev=13.38,
> samples=272
> ```
> When NOT enabling hsq, the minimum value of random reading is 7300 iops
> and the maximum value is 7736 iops, and the maximum delay of io is only
> 9 ms. Finally, we added debug to the mmc driver. The reason for locating
> the 200ms delay of hsq is due to the next tag selection of hsq.
>

Thank you very much for your Log. This patch can reduce latency, but I
have some questions:
1. FIO -rw does not have random, but it does have randread. Do you use
randread? In addition, "IO_SIZE=64M" means only 64M data is tested?
Refer to FIO:
https://fio.readthedocs.io/en/latest/fio_doc.html?highlight=io_size#cmdoption-arg-io-size
2. The style of "tag_tail" should remain the same as that of
"next_tag". Would "tail_tag" be better?
3. It is better to provide a comparison of sequential read, sequential
write and random write.

> ---
> Michael Wu
