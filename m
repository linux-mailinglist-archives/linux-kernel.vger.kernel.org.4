Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EB45FA349
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJJSSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJJSSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:18:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963076D56D;
        Mon, 10 Oct 2022 11:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24A4BB8105C;
        Mon, 10 Oct 2022 18:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25BCC433C1;
        Mon, 10 Oct 2022 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665425911;
        bh=FsaNCIokmh4G9yeY3yvNAYmujF1JxvQEpziOw+09JTk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e9FT2NwvMQa3PKxHhmRlPWCgD+BGusGqo9uBsWvCIgwzeEhOaIfV9LOQNBl+zHxCa
         qCbS9WfwHxRxLITzwaJWx7HOYc+QgqWrSnDSx4A59sk2dkKsQg/iStrr/ZyDVdjzAB
         0Nu4Mopx9UbphsW087KX0U8UKcs+u7Z6kiC7CkhC85ozuhtw5lxQjAIlOwcgENqz1Y
         WrRj6yHpWZ7LrlykRqwLAmSnauYSlIfW+nogizqI+RMVXbDRwhXNgmvJ801oRYnrM8
         sEV/hAY5xh/pjMqmF6vw94CaiY3LmLE/p3rUT/Mu5dPUXpTuFo3BFbHZstODFDn1gW
         r/+SQIQCm8CCA==
Received: by mail-ed1-f46.google.com with SMTP id r14so2689948edc.7;
        Mon, 10 Oct 2022 11:18:31 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Uz3JyW2orAu9HmV0riEaKZr6IkJ1Mxap7HwRc4KNv0nKKyus9
        jFYaxTcEazcXIyOMfRL1Z5uI4iCduxgp65EWSg0=
X-Google-Smtp-Source: AMsMyM4DoVn+ZscFaodr4r1FEfn3P9tYC/3iZctoYq1PmuN+331RxxvkaPDV1787aIK0eIrackWNsaePocFONBVoAGU=
X-Received: by 2002:aa7:da03:0:b0:458:e117:28d8 with SMTP id
 r3-20020aa7da03000000b00458e11728d8mr19253934eds.387.1665425909893; Mon, 10
 Oct 2022 11:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221006220840.275-1-jonathan.derrick@linux.dev>
 <20221006220840.275-4-jonathan.derrick@linux.dev> <CAPhsuW6Ur8ic_u3nj9-TSpZ96jWqBa3GLEnw207sN8eJECYwZg@mail.gmail.com>
 <226b8745-6406-070a-6b08-a265b57a7242@linux.dev>
In-Reply-To: <226b8745-6406-070a-6b08-a265b57a7242@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Mon, 10 Oct 2022 11:18:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Sxr3b=aZye_drJL+sqcwkQceQ-CEZMNjCwV-bquvZ9A@mail.gmail.com>
Message-ID: <CAPhsuW4Sxr3b=aZye_drJL+sqcwkQceQ-CEZMNjCwV-bquvZ9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] md/bitmap: Add chunk-count-based bitmap flushing
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 11:58 AM Jonathan Derrick
<jonathan.derrick@linux.dev> wrote:
>
>
>
> On 10/7/2022 11:50 AM, Song Liu wrote:
> > On Thu, Oct 6, 2022 at 3:09 PM Jonathan Derrick
> > <jonathan.derrick@linux.dev> wrote:
> >
> > [...]
> >
> >> diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
> >> index cfd7395de8fd..e0aeedbdde17 100644
> >> --- a/drivers/md/md-bitmap.h
> >> +++ b/drivers/md/md-bitmap.h
> >> @@ -11,10 +11,12 @@
> >>  /* version 4 insists the bitmap is in little-endian order
> >>   * with version 3, it is host-endian which is non-portable
> >>   * Version 5 is currently set only for clustered devices
> >> ++ * Version 6 supports the flush-chunks threshold
> >>   */
> >>  #define BITMAP_MAJOR_HI 4
> >>  #define BITMAP_MAJOR_CLUSTERED 5
> >>  #define        BITMAP_MAJOR_HOSTENDIAN 3
> >> +#define BITMAP_MAJOR_CHUNKFLUSH 6
> >>
> >>  /*
> >>   * in-memory bitmap:
> >> @@ -135,7 +137,8 @@ typedef struct bitmap_super_s {
> >>                                   * reserved for the bitmap. */
> >>         __le32 nodes;        /* 68 the maximum number of nodes in cluster. */
> >>         __u8 cluster_name[64]; /* 72 cluster name to which this md belongs */
> >> -       __u8  pad[256 - 136]; /* set to zero */
> >> +       __le32 daemon_flush_chunks; /* 136 dirty chunks between flushes */
> >> +       __u8  pad[256 - 140]; /* set to zero */
> >>  } bitmap_super_t;
> >
> > Do we really need this to be persistent? How about we configure it at run
> > time via a sysfs file?
> >
> > Also, please share more data on the performance benefit of the set.
> >
> > Thanks,
> > Song
> >
> Hi Song,
>
> Patch 1/2 changes default behavior, which patch 2/2 tries to address.

Have you tried to evaluate the impact on the accuracy of the bitmap?
Specifically, if we power off the system during writes, do we see data
or parity mismatch that is not covered by the bitmap?

> I can change it to be configurable via sysfs instead.
> Should there be a default?

If there is any impact on bitmap accuracy. I think the default should
work identical as before the set. IOW, we should not delay the bitmap
update.

Thanks,
Song

>
>
> Here are my observations via biosnoop and RAID1, 4M chunksize, 238436 chunks, bitmap=internal
> fio --name=test --direct=1 --filename=/dev/md0 --rw=randwrite --runtime=60
>  --percentile_list=1.0:25.0:50.0:75.0:90.0:95.0:99.0:99.9:99.99:99..999999:100.0
>
>
> Default, bitmap updates happened concurrently with I/O:
>    bw (  KiB/s): min=18690, max=30618, per=99.94%, avg=23822.07, stdev=2522.73, samples=119
>    iops        : min= 4672, max= 7654, avg=5955.20, stdev=630.71, samples=119
>
> TIME(s)     COMM           PID     DISK      T SECTOR     BYTES  LAT(ms)
> 38.090366   md0_raid1      4800    nvme6n1   W 40         4096      0.01
> 38.090423   md0_raid1      4800    nvme3n1   W 40         4096      0.07
> 38.090442   md0_raid1      4800    nvme3n1   W 1016633184 4096      0.01
> 38.090439   md0_raid1      4800    nvme6n1   W 1016633184 4096      0.01
> 38.090479   md0_raid1      4800    nvme6n1   W 56         4096      0.01
> 38.090493   md0_raid1      4800    nvme6n1   W 1449894256 4096      0.01
> 38.090477   md0_raid1      4800    nvme3n1   W 56         4096      0.01
> 38.090496   md0_raid1      4800    nvme3n1   W 1449894256 4096      0.01
> 38.090530   md0_raid1      4800    nvme3n1   W 16         4096      0.01
> 38.090555   md0_raid1      4800    nvme3n1   W 110493568  4096      0.01
> 38.090538   md0_raid1      4800    nvme6n1   W 16         4096      0.01
> 38.090551   md0_raid1      4800    nvme6n1   W 110493568  4096      0.01
> 38.090596   md0_raid1      4800    nvme6n1   W 56         4096      0.01
> 38.090647   md0_raid1      4800    nvme3n1   W 56         4096      0.06
> 38.090666   md0_raid1      4800    nvme3n1   W 1455846976 4096      0.01
> 38.090663   md0_raid1      4800    nvme6n1   W 1455846976 4096      0.01
> 38.090707   md0_raid1      4800    nvme6n1   W 64         4096      0.01
> 38.090699   md0_raid1      4800    nvme3n1   W 64         4096      0.01
> 38.090723   md0_raid1      4800    nvme3n1   W 1665013728 4096      0.01
> 38.090720   md0_raid1      4800    nvme6n1   W 1665013728 4096      0.01
> 38.090764   md0_raid1      4800    nvme6n1   W 64         4096      0.01
> 38.090812   md0_raid1      4800    nvme3n1   W 64         4096      0.06
> 38.090832   md0_raid1      4800    nvme3n1   W 1637994296 4096      0.01
> 38.090828   md0_raid1      4800    nvme6n1   W 1637994296 4096      0.01
>
>
>
>
> With patch 1/2, bitmaps only update on the 'delay' parameter (default 5s):
>    bw (  KiB/s): min=135712, max=230938, per=100.00%, avg=209308.56, stdev=29254.31, samples=119
>    iops        : min=33928, max=57734, avg=52326.78, stdev=7313.57, samples=119
>
> TIME(s)     COMM           PID     DISK      T SECTOR     BYTES  LAT(ms)
> 16.292235   md0_raid1      4841    nvme6n1   W 297367432  4096      0.01
> 16.292258   md0_raid1      4841    nvme6n1   W 16         4096      0.01
> 16.292266   md0_raid1      4841    nvme6n1   W 24         4096      0.01
> 16.292277   md0_raid1      4841    nvme6n1   W 32         4096      0.01
> 16.292259   md0_raid1      4841    nvme3n1   W 16         4096      0.01
> 16.292280   md0_raid1      4841    nvme3n1   W 32         4096      0.01
> 16.292305   md0_raid1      4841    nvme3n1   W 56         4096      0.01
> 16.292286   md0_raid1      4841    nvme6n1   W 40         4096      0.01
> 16.292295   md0_raid1      4841    nvme6n1   W 48         4096      0.01
> 16.292326   md0_raid1      4841    nvme3n1   W 72         1536      0.01
> 16.292323   md0_raid1      4841    nvme6n1   W 64         4096      0.02
> 16.292326   md0_raid1      4841    nvme6n1   W 56         4096      0.03
> 16.292334   md0_raid1      4841    nvme6n1   W 72         1536      0.02
> 16.300697   md0_raid1      4841    nvme3n1   W 1297533744 4096      0.01
> 16.300702   md0_raid1      4841    nvme6n1   W 1297533744 4096      0.01
> 16.300803   md0_raid1      4841    nvme6n1   W 1649080856 4096      0.01
> 16.300798   md0_raid1      4841    nvme3n1   W 1649080856 4096      0.01
> 16.300823   md0_raid1      4841    nvme3n1   W 1539317792 4096      0.01
> 16.300845   md0_raid1      4841    nvme3n1   W 1634570232 4096      0.01
> 16.300867   md0_raid1      4841    nvme3n1   W 579232208  4096      0.01
> 16.300889   md0_raid1      4841    nvme3n1   W 1818140424 4096      0.01
> 16.300922   md0_raid1      4841    nvme3n1   W 412971920  4096      0.02
> ...
> 21.293225   md0_raid1      4841    nvme3n1   W 1279122360 4096      0.01
> 21.293242   md0_raid1      4841    nvme3n1   W 40326272   4096      0.01
> 21.293223   md0_raid1      4841    nvme6n1   W 1279122360 4096      0.01
> 21.293243   md0_raid1      4841    nvme6n1   W 40326272   4096      0.01
> 21.293261   md0_raid1      4841    nvme6n1   W 16         4096      0.01
> 21.293266   md0_raid1      4841    nvme6n1   W 24         4096      0.01
> 21.293271   md0_raid1      4841    nvme6n1   W 32         4096      0.01
> 21.293275   md0_raid1      4841    nvme3n1   W 32         4096      0.01
> 21.293292   md0_raid1      4841    nvme3n1   W 48         4096      0.01
> 21.293296   md0_raid1      4841    nvme3n1   W 56         4096      0.01
> 21.293309   md0_raid1      4841    nvme3n1   W 72         1536      0.01
> 21.293266   md0_raid1      4841    nvme3n1   W 24         4096      0.01
> 21.293326   md0_raid1      4841    nvme6n1   W 48         4096      0.05
> 21.293328   md0_raid1      4841    nvme6n1   W 40         4096      0.06
> 21.293331   md0_raid1      4841    nvme6n1   W 72         1536      0.03
> 21.293333   md0_raid1      4841    nvme6n1   W 64         4096      0.04
> 21.293334   md0_raid1      4841    nvme6n1   W 56         4096      0.05
> 21.298526   md0_raid1      4841    nvme3n1   W 681973000  4096      0.01
>
>
>
>
> Good, but with the granularity of N seconds, it might be too infrequent.
> Here is chunk-flush=512 (2GB threshold in 4MB chunk size):
>    bw (  KiB/s): min=92692, max=134904, per=100.00%, avg=125127.43, stdev=6758.51, samples=119
>    iops        : min=23173, max=33726, avg=31281.55, stdev=1689.63, samples=119
>
> TIME(s)     COMM           PID     DISK      T SECTOR     BYTES  LAT(ms)
> 13.193339   md0_raid1      5972    nvme6n1   W 16         4096      0.01
> 13.193344   md0_raid1      5972    nvme6n1   W 32         4096      0.01
> 13.193346   md0_raid1      5972    nvme6n1   W 24         4096      0.01
> 13.193350   md0_raid1      5972    nvme6n1   W 40         4096      0.01
> 13.193356   md0_raid1      5972    nvme6n1   W 48         4096      0.01
> 13.193361   md0_raid1      5972    nvme6n1   W 64         4096      0.01
> 13.193363   md0_raid1      5972    nvme6n1   W 56         4096      0.01
> 13.193555   md0_raid1      5972    nvme6n1   W 72         1536      0.20
> 13.193289   md0_raid1      5972    nvme3n1   W 1912285848 4096      0.01
> 13.193306   md0_raid1      5972    nvme3n1   W 836455896  4096      0.01
> 13.193323   md0_raid1      5972    nvme3n1   W 233728136  4096      0.01
> 13.193339   md0_raid1      5972    nvme3n1   W 16         4096      0.01
> 13.193344   md0_raid1      5972    nvme3n1   W 24         4096      0.01
> 13.193362   md0_raid1      5972    nvme3n1   W 48         4096      0.01
> 13.193365   md0_raid1      5972    nvme3n1   W 64         4096      0.01
> 13.193366   md0_raid1      5972    nvme3n1   W 56         4096      0.01
> 13.193574   md0_raid1      5972    nvme3n1   W 72         1536      0.21
> 13.196759   md0_raid1      5972    nvme3n1   W 89571592   4096      0.01
> 13.196810   md0_raid1      5972    nvme6n1   W 89571592   4096      0.06
> 13.196913   md0_raid1      5972    nvme6n1   W 16         4096      0.01
> 13.196910   md0_raid1      5972    nvme3n1   W 16         4096      0.01
> 13.199444   md0_raid1      5972    nvme3n1   W 64         4096      0.01
> 13.199447   md0_raid1      5972    nvme3n1   W 137126232  4096      0.01
> 13.199515   md0_raid1      5972    nvme6n1   W 137126232  4096      0.08
> 13.199519   md0_raid1      5972    nvme6n1   W 64         4096      0.08
> 13.199617   md0_raid1      5972    nvme6n1   W 1216062808 4096      0.01
> ... (508 ios later)
> 13.208764   md0_raid1      5972    nvme6n1   W 16         4096      0.01
> 13.208768   md0_raid1      5972    nvme6n1   W 32         4096      0.01
> 13.208770   md0_raid1      5972    nvme6n1   W 24         4096      0.01
> 13.208775   md0_raid1      5972    nvme6n1   W 40         4096      0.01
> 13.208781   md0_raid1      5972    nvme6n1   W 48         4096      0.01
> 13.208786   md0_raid1      5972    nvme6n1   W 56         4096      0.01
> 13.208790   md0_raid1      5972    nvme6n1   W 64         4096      0.01
> 13.208729   md0_raid1      5972    nvme3n1   W 1607847808 4096      0.01
> 13.208747   md0_raid1      5972    nvme3n1   W 371214368  4096      0.01
> 13.208770   md0_raid1      5972    nvme3n1   W 32         4096      0.01
> 13.208789   md0_raid1      5972    nvme3n1   W 64         4096      0.01
> 13.208952   md0_raid1      5972    nvme6n1   W 72         1536      0.17
> 13.209079   md0_raid1      5972    nvme3n1   W 72         1536      0.29
> 13.212216   md0_raid1      5972    nvme3n1   W 1146106480 4096      0.01
> 13.212269   md0_raid1      5972    nvme6n1   W 1146106480 4096      0.06
> 13.212368   md0_raid1      5972    nvme6n1   W 16         4096      0.01
> 13.212365   md0_raid1      5972    nvme3n1   W 16         4096      0.01
>
>
> Without 1/2: 6k iops
> With 1/2: 52k iops
> With 2/2 params as above: 31k iops
>
> The count calculation could use some improvement to close the iops gap to delay-based flushing
>
> >>
> >>  /* notes:
> >> diff --git a/drivers/md/md.h b/drivers/md/md.h
> >> index b4e2d8b87b61..d25574e46283 100644
> >> --- a/drivers/md/md.h
> >> +++ b/drivers/md/md.h
> >> @@ -497,6 +497,7 @@ struct mddev {
> >>                 struct mutex            mutex;
> >>                 unsigned long           chunksize;
> >>                 unsigned long           daemon_sleep; /* how many jiffies between updates? */
> >> +               unsigned int            daemon_flush_chunks; /* how many dirty chunks between updates */
> >>                 unsigned long           max_write_behind; /* write-behind mode */
> >>                 int                     external;
> >>                 int                     nodes; /* Maximum number of nodes in the cluster */
> >> --
> >> 2.31.1
> >>
