Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D596CD9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjC2NAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjC2M75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:59:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8974498
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:59:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn12so62930707edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680094786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmZWw1Ep+qquhnRKzmu+jGftzl94DDgORr61jq+naK8=;
        b=nkO6hiDv1iJqvhGKBRpNv1i5JBfCKPdLZVQDz72BYwSTtvrPpnvutGJTzO645v8tqk
         QeTAzqG5kltkZ+lpIMqyu2Njkuxi2vs4gWX3zGVEr25GSJnlSrZYtU8ISZH/mO1Nu2h4
         5Np2i6r6yCmSgCR74JLEJsYReMGYVbQ7oOrXbtqd/kbO1nlyGcw2uWuRwFfBlOm1+Y3X
         r2wyvdB46W87NpUiKjaVeMnIA47LUzI7e5Y637o+4TfKuyz4Lwz3Mg5jrmW7mO/JnbAK
         TG6pzJmM8mfZKhy4fl3w7RNLIvlwlm911JNNqiT0vDzQyPs+Lv44wtIy4QhPo/OHU01D
         hKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmZWw1Ep+qquhnRKzmu+jGftzl94DDgORr61jq+naK8=;
        b=VODMaFkKN9jkssQrRy7lyPuwLYMaOwtmBM2DResMWO2LqHSw6ot+w14xyUS2dtSOhT
         bL+pYjHyTo2035acksa1N7YCqLdqPUgP+TG3Izayxes3n7efIscDjXqeDVg2m6vZpvGE
         EhAcrwbEze9TrqCERq/4Yxq1A8fBzDx2/B9AIk0HI3sd22JJmZXLp6+jDWPGTNThFp4N
         7Wqtk5GXbqQScs7IcVfOuyHUoyAPd3VPFJDHnE72h8vw6Xyq3TGaBww6bgzrEmRY7buo
         UrLJ+BFPeOQhhq7bIVQcRKbw56OCvohky8TaNXt2ZIF6xJBWlu5pKwHkNNM27l3vYp1P
         KGdw==
X-Gm-Message-State: AAQBX9fOOHzfCmd43RgB1Q1+W+ysYFjGrs/8TvWU/H2m/zGh5SE2mtHy
        SkZEKP+jZIG4dbvGtSDtD7YzntEW9gk6Ee/VKZ1qCw==
X-Google-Smtp-Source: AKy350YGQYLr35jJEEsetegNJJ28R/aWaRzbJ+Zim/00PSY34FaZk8WzCuaYD4sHXjjpZQFg4uHflb6mayzUwxKpFqc=
X-Received: by 2002:a17:906:1185:b0:92b:ec37:e4b7 with SMTP id
 n5-20020a170906118500b0092bec37e4b7mr9654766eja.14.1680094786610; Wed, 29 Mar
 2023 05:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230329111422.3693-1-mike.leach@linaro.org> <20230329111422.3693-2-mike.leach@linaro.org>
 <ZCQx5HlPnxCIFaNQ@kernel.org> <ZCQyNnk/vfHZkSda@kernel.org>
In-Reply-To: <ZCQyNnk/vfHZkSda@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 29 Mar 2023 13:59:10 +0100
Message-ID: <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 at 13:42, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>
> Em Wed, Mar 29, 2023 at 09:41:08AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Wed, Mar 29, 2023 at 12:14:20PM +0100, Mike Leach escreveu:
> > > The information to associate Trace ID and CPU will be changing.
> > >
> > > Drivers will start outputting this as a hardware ID packet in the dat=
a
> > > file which if present will be used in preference to the AUXINFO value=
s.
> >
> >   CC      /tmp/build/perf-tools-next/util/symbol-elf.o
> >   LD      /tmp/build/perf-tools-next/util/cs-etm-decoder/perf-in.o
> > util/cs-etm.c: In function =E2=80=98cs_etm__process_auxtrace_info_full=
=E2=80=99:
> > util/cs-etm.c:2866:26: error: unused variable =E2=80=98inode=E2=80=99 [=
-Werror=3Dunused-variable]
> >  2866 |         struct int_node *inode;
> >       |                          ^~~~~
> > cc1: all warnings being treated as errors
> > make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.b=
uild:97: /tmp/build/perf-tools-next/util/cs-etm.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > gmake[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.=
build:140: util] Err
> >
> > Trying to fix...
>
> Seems simple, the variable isn't used at all, so I added:
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index f6ca07f68b251274..5fc9c288080b4526 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2863,7 +2863,6 @@ int cs_etm__process_auxtrace_info_full(union perf_e=
vent *event,
>  {
>         struct perf_record_auxtrace_info *auxtrace_info =3D &event->auxtr=
ace_info;
>         struct cs_etm_auxtrace *etm =3D NULL;
> -       struct int_node *inode;
>         struct perf_record_time_conv *tc =3D &session->time_conv;
>         int event_header_size =3D sizeof(struct perf_event_header);
>         int total_size =3D auxtrace_info->header.size;
>
>
>
> > > To prepare for this we provide a helper functions to do the individua=
l ID
> > > mapping, and one to extract the IDs from the completed metadata block=
s.
> > >
> > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > Reviewed-by: James Clark <james.clark@arm.com>
> > > Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >  tools/include/linux/coresight-pmu.h |  5 ++
> > >  tools/perf/util/cs-etm.c            | 91 +++++++++++++++++++--------=
--
> > >  tools/perf/util/cs-etm.h            | 14 ++++-
> > >  3 files changed, 77 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linu=
x/coresight-pmu.h
> > > index 6c2fd6cc5a98..db9c7c0abb6a 100644
> > > --- a/tools/include/linux/coresight-pmu.h
> > > +++ b/tools/include/linux/coresight-pmu.h
> > > @@ -7,9 +7,14 @@
> > >  #ifndef _LINUX_CORESIGHT_PMU_H
> > >  #define _LINUX_CORESIGHT_PMU_H
> > >
> > > +#include <linux/bits.h>
> > > +
> > >  #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> > >  #define CORESIGHT_ETM_PMU_SEED  0x10
> > >
> > > +/* CoreSight trace ID is currently the bottom 7 bits of the value */
> > > +#define CORESIGHT_TRACE_ID_VAL_MASK        GENMASK(6, 0)
> > > +
> > >  /*
> > >   * Below are the definition of bit offsets for perf option, and work=
s as
> > >   * arbitrary values for all ETM versions.
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index f65bac5ddbdb..f6ca07f68b25 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> > > @@ -196,6 +196,30 @@ int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *p=
id_fmt)
> > >     return 0;
> > >  }
> > >
> > > +static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
> > > +{
> > > +   struct int_node *inode;
> > > +
> > > +   /* Get an RB node for this CPU */
> > > +   inode =3D intlist__findnew(traceid_list, trace_chan_id);
> > > +
> > > +   /* Something went wrong, no need to continue */
> > > +   if (!inode)
> > > +           return -ENOMEM;
> > > +
> > > +   /*
> > > +    * The node for that CPU should not be taken.
> > > +    * Back out if that's the case.
> > > +    */
> > > +   if (inode->priv)
> > > +           return -EINVAL;
> > > +
> > > +   /* All good, associate the traceID with the metadata pointer */
> > > +   inode->priv =3D cpu_metadata;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >  void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *e=
tmq,
> > >                                           u8 trace_chan_id)
> > >  {
> > > @@ -2804,6 +2828,36 @@ static bool cs_etm__has_virtual_ts(u64 **metad=
ata, int num_cpu)
> > >     return true;
> > >  }
> > >
> > > +/* map trace ids to correct metadata block, from information in meta=
data */
> > > +static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadat=
a)
> > > +{
> > > +   u64 cs_etm_magic;
> > > +   u8 trace_chan_id;
> > > +   int i, err;
> > > +
> > > +   for (i =3D 0; i < num_cpu; i++) {
> > > +           cs_etm_magic =3D metadata[i][CS_ETM_MAGIC];
> > > +           switch (cs_etm_magic) {
> > > +           case __perf_cs_etmv3_magic:
> > > +                   trace_chan_id =3D (u8)((metadata[i][CS_ETM_ETMTRA=
CEIDR]) &
> > > +                                        CORESIGHT_TRACE_ID_VAL_MASK)=
;
> > > +                   break;
> > > +           case __perf_cs_etmv4_magic:
> > > +           case __perf_cs_ete_magic:
> > > +                   trace_chan_id =3D (u8)((metadata[i][CS_ETMV4_TRCT=
RACEIDR]) &
> > > +                                         CORESIGHT_TRACE_ID_VAL_MASK=
);
> > > +                   break;
> > > +           default:
> > > +                   /* unknown magic number */
> > > +                   return -EINVAL;
> > > +           }
> > > +           err =3D cs_etm__map_trace_id(trace_chan_id, metadata[i]);
> > > +           if (err)
> > > +                   return err;
> > > +   }
> > > +   return 0;
> > > +}
> > > +
> > >  int cs_etm__process_auxtrace_info_full(union perf_event *event,
> > >                                    struct perf_session *session)
> > >  {
> > > @@ -2814,7 +2868,7 @@ int cs_etm__process_auxtrace_info_full(union pe=
rf_event *event,
> > >     int event_header_size =3D sizeof(struct perf_event_header);
> > >     int total_size =3D auxtrace_info->header.size;
> > >     int priv_size =3D 0;
> > > -   int num_cpu, trcidr_idx;
> > > +   int num_cpu;
> > >     int err =3D 0;
> > >     int i, j;
> > >     u64 *ptr =3D NULL;
> > > @@ -2853,23 +2907,13 @@ int cs_etm__process_auxtrace_info_full(union =
perf_event *event,
> > >                             cs_etm__create_meta_blk(ptr, &i,
> > >                                                     CS_ETM_PRIV_MAX,
> > >                                                     CS_ETM_NR_TRC_PAR=
AMS_V0);
> > > -
> > > -                   /* The traceID is our handle */
> > > -                   trcidr_idx =3D CS_ETM_ETMTRACEIDR;
> > > -
> > >             } else if (ptr[i] =3D=3D __perf_cs_etmv4_magic) {
> > >                     metadata[j] =3D
> > >                             cs_etm__create_meta_blk(ptr, &i,
> > >                                                     CS_ETMV4_PRIV_MAX=
,
> > >                                                     CS_ETMV4_NR_TRC_P=
ARAMS_V0);
> > > -
> > > -                   /* The traceID is our handle */
> > > -                   trcidr_idx =3D CS_ETMV4_TRCTRACEIDR;
> > >             } else if (ptr[i] =3D=3D __perf_cs_ete_magic) {
> > >                     metadata[j] =3D cs_etm__create_meta_blk(ptr, &i, =
CS_ETE_PRIV_MAX, -1);
> > > -
> > > -                   /* ETE shares first part of metadata with ETMv4 *=
/
> > > -                   trcidr_idx =3D CS_ETMV4_TRCTRACEIDR;
> > >             } else {
> > >                     ui__error("CS ETM Trace: Unrecognised magic numbe=
r %#"PRIx64". File could be from a newer version of perf.\n",
> > >                               ptr[i]);
> > > @@ -2881,26 +2925,6 @@ int cs_etm__process_auxtrace_info_full(union p=
erf_event *event,
> > >                     err =3D -ENOMEM;
> > >                     goto err_free_metadata;
> > >             }
> > > -
> > > -           /* Get an RB node for this CPU */
> > > -           inode =3D intlist__findnew(traceid_list, metadata[j][trci=
dr_idx]);
> > > -
> > > -           /* Something went wrong, no need to continue */
> > > -           if (!inode) {
> > > -                   err =3D -ENOMEM;
> > > -                   goto err_free_metadata;
> > > -           }
> > > -
> > > -           /*
> > > -            * The node for that CPU should not be taken.
> > > -            * Back out if that's the case.
> > > -            */
> > > -           if (inode->priv) {
> > > -                   err =3D -EINVAL;
> > > -                   goto err_free_metadata;
> > > -           }
> > > -           /* All good, associate the traceID with the metadata poin=
ter */
> > > -           inode->priv =3D metadata[j];
> > >     }
> > >
> > >     /*
> > > @@ -2994,6 +3018,11 @@ int cs_etm__process_auxtrace_info_full(union p=
erf_event *event,
> > >     if (err)
> > >             goto err_delete_thread;
> > >
> > > +   /* before aux records are queued, need to map metadata to trace I=
Ds */
> > > +   err =3D cs_etm__map_trace_ids_metadata(num_cpu, metadata);
> > > +   if (err)
> > > +           goto err_delete_thread;
> > > +
> > >     err =3D cs_etm__queue_aux_records(session);
> > >     if (err)
> > >             goto err_delete_thread;
> > > diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> > > index 98a4f7113d2f..6d3078e042b4 100644
> > > --- a/tools/perf/util/cs-etm.h
> > > +++ b/tools/perf/util/cs-etm.h
> > > @@ -29,13 +29,17 @@ enum {
> > >  /*
> > >   * Update the version for new format.
> > >   *
> > > - * New version 1 format adds a param count to the per cpu metadata.
> > > + * Version 1: format adds a param count to the per cpu metadata.
> > >   * This allows easy adding of new metadata parameters.
> > >   * Requires that new params always added after current ones.
> > >   * Also allows client reader to handle file versions that are differ=
ent by
> > >   * checking the number of params in the file vs the number expected.
> > > + *
> > > + * Version 2: Drivers will use PERF_RECORD_AUX_OUTPUT_HW_ID to outpu=
t
> > > + * CoreSight Trace ID. ...TRACEIDR metadata will be set to unused ID=
.
> > >   */
> > > -#define CS_HEADER_CURRENT_VERSION 1
> > > +#define CS_HEADER_CURRENT_VERSION  2
> > > +#define CS_AUX_HW_ID_VERSION_MIN   2
> > >
> > >  /* Beginning of header common to both ETMv3 and V4 */
> > >  enum {
> > > @@ -97,6 +101,12 @@ enum {
> > >     CS_ETE_PRIV_MAX
> > >  };
> > >
> > > +/*
> > > + * Check for valid CoreSight trace ID. If an invalid value is presen=
t in the metadata,
> > > + * then IDs are present in the hardware ID packet in the data file.
> > > + */
> > > +#define CS_IS_VALID_TRACE_ID(id) ((id > 0) && (id < 0x70))
> > > +
> > >  /*
> > >   * ETMv3 exception encoding number:
> > >   * See Embedded Trace Macrocell specification (ARM IHI 0014Q)
> > > --
> > > 2.32.0
> > >
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo

Sorry - my error.

The same change is made in patch 3/3 of this set.

Looks like I didn't do a patch by patch build check when I was testing yest=
erday

Mike

--=20
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
