Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830BC646050
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiLGRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:35:22 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC445B869
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:35:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bx10so29168910wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHXYK1/3tzOhQsGRwpt3x3TUmp6tmlA5LqS9xLShKD4=;
        b=KhcbmJgdXL8XjDRNH4wpe35yPewMbwxm9StA8DrY8r4AxwuzF/qEyGUm3rNCUK0U1B
         MnjqgA7FXnJlToSi+9jS2R2TdU0/aL+n+0GcZuvjMdmKJohXnyrgg/j0yGWO2Q5sNmd5
         hBfeZkmDaemqx9Uj6JQbc/N3Xh04WWZtI7oP2IVeyNZZBnn/dXcR2Yrz9l6LfONIpc0d
         jkdzvrzjiQTbGaa+AiH+i9IuUor0aOq4r+Vvqhk0fzCeh8ny5DnF73Djj1lpQJyvOlU1
         CHxCtNjQ67a5oirxIwN28QZUknejMfcS5HVnlTdQQqZOef2Dh/BehDQ4NqkJled52LyM
         qHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHXYK1/3tzOhQsGRwpt3x3TUmp6tmlA5LqS9xLShKD4=;
        b=dL1aVPW64SQJO6jIJEPx7S0/kSX5K0E1u49qPN19dlfqBzAgk8cd0YlXmoHdXUwIJZ
         /bAV45pnrbMsSUTp1VGW341TYXWq2ynGjWN7eG+aV/jSglM0VEsSQACV4WiotiCd6D8w
         Zl7vE6Gm04KGtmhQi758PhZYJefJBSZSFnFUBaoJfqYmu0NXpHM3FV5YOhEhZuHS1psx
         QAUrqNa1vuCNkVuDhr9omk0zQ3oqrPneu4qojn0Na/H3bKb2a57Kwekxl2xRq+Y5m8dQ
         kQwMlAzBlvQbnBA19grVgDqxI3rCtLmh9w/I1TRPbSCOZMja6g5yRMtMP1LWDlRdrjzs
         wF2w==
X-Gm-Message-State: ANoB5pmvLfx3RC/BmsG1Lhpx8vRcZJ8Os2z2DYeKVZxwOIKV59TxVuCx
        IpfJOpqs8g5cg7j734bSqSxo6oDHF0AE096/hzuJoA+iBf2SHhTt
X-Google-Smtp-Source: AA0mqf4Ja+gGEZgME+kNtYmtBpivlkvNodc38vquNa5doehZAU30iAaq8a+e3giFkPHCmQt5Lk7lcl2qO947WI4RmXI=
X-Received: by 2002:a5d:6f0a:0:b0:242:87f3:1de9 with SMTP id
 ay10-20020a5d6f0a000000b0024287f31de9mr1139832wrb.40.1670434517742; Wed, 07
 Dec 2022 09:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20221207053007.336806-1-sandipan.das@amd.com> <20221207053007.336806-5-sandipan.das@amd.com>
 <CAP-5=fUS37Xqi1x2ZDj48saFu-g5dCvwqg8Vm0DF1V0vuq4tXw@mail.gmail.com> <6675c596-eeb4-3347-ec85-2bd67b970973@amd.com>
In-Reply-To: <6675c596-eeb4-3347-ec85-2bd67b970973@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Dec 2022 09:35:05 -0800
Message-ID: <CAP-5=fUTo=fGdLzT0CoQwFw7ULQdegjLevy4_sJf-KG2rkOehA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf vendor events amd: Add Zen 4 metrics
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        jhladky@redhat.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 10:58 PM Sandipan Das <sandipan.das@amd.com> wrote:
>
> On 12/7/2022 11:35 AM, Ian Rogers wrote:
> > On Tue, Dec 6, 2022 at 9:32 PM Sandipan Das <sandipan.das@amd.com> wrot=
e:
> >>
> >> Add metrics taken from Section 2.1.15.2 "Performance Measurement" in
> >> the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
> >> Revision B1 processors.
> >>
> >> The recommended metrics are sourced from Table 27 "Guidance for Common
> >> Performance Statistics with Complex Event Selects".
> >>
> >> The pipeline utilization metrics are sourced from Table 28 "Guidance
> >> for Pipeline Utilization Analysis Statistics". These are new to Zen 4
> >> processors and useful for finding performance bottlenecks by analyzing
> >> activity at different stages of the pipeline. Metric groups have been
> >> added for Level 1 and Level 2 analysis.
> >>
> >> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >> ---
> >>  .../pmu-events/arch/x86/amdzen4/pipeline.json |  98 +++++
> >>  .../arch/x86/amdzen4/recommended.json         | 334 +++++++++++++++++=
+
> >>  2 files changed, 432 insertions(+)
> >>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.js=
on
> >>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended=
.json
> >>
> <snip>
> >> +  {
> >> +    "MetricName": "dram_read_data_bytes_for_local_processor",
> >
> > nit: Is "bytes" redundant in the name here? It may even be confusing
> > given the units.
> >
>
> Agreed. I can replace "bytes" with "mbytes" or "megabytes" for these band=
width metrics.
>
> - Sandipan

Perhaps just drop it from the name :-) So,
dram_read_data_for_local_processor, etc.

Thanks,
Ian

> >> +    "BriefDescription": "DRAM read data bytes for local processor.",
> >> +    "MetricExpr": "local_processor_read_data_beats_cs0 + local_proces=
sor_read_data_beats_cs1 + local_processor_read_data_beats_cs2 + local_proce=
ssor_read_data_beats_cs3 + local_processor_read_data_beats_cs4 + local_proc=
essor_read_data_beats_cs5 + local_processor_read_data_beats_cs6 + local_pro=
cessor_read_data_beats_cs7 + local_processor_read_data_beats_cs8 + local_pr=
ocessor_read_data_beats_cs9 + local_processor_read_data_beats_cs10 + local_=
processor_read_data_beats_cs11",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "dram_write_data_bytes_for_local_processor",
> >> +    "BriefDescription": "DRAM write data bytes for local processor.",
> >> +    "MetricExpr": "local_processor_write_data_beats_cs0 + local_proce=
ssor_write_data_beats_cs1 + local_processor_write_data_beats_cs2 + local_pr=
ocessor_write_data_beats_cs3 + local_processor_write_data_beats_cs4 + local=
_processor_write_data_beats_cs5 + local_processor_write_data_beats_cs6 + lo=
cal_processor_write_data_beats_cs7 + local_processor_write_data_beats_cs8 +=
 local_processor_write_data_beats_cs9 + local_processor_write_data_beats_cs=
10 + local_processor_write_data_beats_cs11",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "dram_read_data_bytes_for_remote_processor",
> >> +    "BriefDescription": "DRAM read data bytes for remote processor.",
> >> +    "MetricExpr": "remote_processor_read_data_beats_cs0 + remote_proc=
essor_read_data_beats_cs1 + remote_processor_read_data_beats_cs2 + remote_p=
rocessor_read_data_beats_cs3 + remote_processor_read_data_beats_cs4 + remot=
e_processor_read_data_beats_cs5 + remote_processor_read_data_beats_cs6 + re=
mote_processor_read_data_beats_cs7 + remote_processor_read_data_beats_cs8 +=
 remote_processor_read_data_beats_cs9 + remote_processor_read_data_beats_cs=
10 + remote_processor_read_data_beats_cs11",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "dram_write_data_bytes_for_remote_processor",
> >> +    "BriefDescription": "DRAM write data bytes for remote processor."=
,
> >> +    "MetricExpr": "remote_processor_write_data_beats_cs0 + remote_pro=
cessor_write_data_beats_cs1 + remote_processor_write_data_beats_cs2 + remot=
e_processor_write_data_beats_cs3 + remote_processor_write_data_beats_cs4 + =
remote_processor_write_data_beats_cs5 + remote_processor_write_data_beats_c=
s6 + remote_processor_write_data_beats_cs7 + remote_processor_write_data_be=
ats_cs8 + remote_processor_write_data_beats_cs9 + remote_processor_write_da=
ta_beats_cs10 + remote_processor_write_data_beats_cs11",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "local_socket_upstream_dma_read_data_bytes",
> >> +    "BriefDescription": "Local socket upstream DMA read data bytes.",
> >> +    "MetricExpr": "local_socket_upstream_read_beats_iom0 + local_sock=
et_upstream_read_beats_iom1 + local_socket_upstream_read_beats_iom2 + local=
_socket_upstream_read_beats_iom3",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "local_socket_upstream_dma_write_data_bytes",
> >> +    "BriefDescription": "Local socket upstream DMA write data bytes."=
,
> >> +    "MetricExpr": "local_socket_upstream_write_beats_iom0 + local_soc=
ket_upstream_write_beats_iom1 + local_socket_upstream_write_beats_iom2 + lo=
cal_socket_upstream_write_beats_iom3",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "remote_socket_upstream_dma_read_data_bytes",
> >> +    "BriefDescription": "Remote socket upstream DMA read data bytes."=
,
> >> +    "MetricExpr": "remote_socket_upstream_read_beats_iom0 + remote_so=
cket_upstream_read_beats_iom1 + remote_socket_upstream_read_beats_iom2 + re=
mote_socket_upstream_read_beats_iom3",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "remote_socket_upstream_dma_write_data_bytes",
> >> +    "BriefDescription": "Remote socket upstream DMA write data bytes.=
",
> >> +    "MetricExpr": "remote_socket_upstream_write_beats_iom0 + remote_s=
ocket_upstream_write_beats_iom1 + remote_socket_upstream_write_beats_iom2 +=
 remote_socket_upstream_write_beats_iom3",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "local_socket_inbound_data_bytes_to_cpu",
> >> +    "BriefDescription": "Local socket inbound data bytes to the CPU (=
e.g. read data).",
> >> +    "MetricExpr": "local_socket_inf0_inbound_data_beats_ccm0 + local_=
socket_inf1_inbound_data_beats_ccm0 + local_socket_inf0_inbound_data_beats_=
ccm1 + local_socket_inf1_inbound_data_beats_ccm1 + local_socket_inf0_inboun=
d_data_beats_ccm2 + local_socket_inf1_inbound_data_beats_ccm2 + local_socke=
t_inf0_inbound_data_beats_ccm3 + local_socket_inf1_inbound_data_beats_ccm3 =
+ local_socket_inf0_inbound_data_beats_ccm4 + local_socket_inf1_inbound_dat=
a_beats_ccm4 + local_socket_inf0_inbound_data_beats_ccm5 + local_socket_inf=
1_inbound_data_beats_ccm5 + local_socket_inf0_inbound_data_beats_ccm6 + loc=
al_socket_inf1_inbound_data_beats_ccm6 + local_socket_inf0_inbound_data_bea=
ts_ccm7 + local_socket_inf1_inbound_data_beats_ccm7",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "3.0517578125e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "local_socket_outbound_data_bytes_from_cpu",
> >> +    "BriefDescription": "Local socket outbound data bytes from the CP=
U (e.g. write data).",
> >> +    "MetricExpr": "local_socket_inf0_outbound_data_beats_ccm0 + local=
_socket_inf1_outbound_data_beats_ccm0 + local_socket_inf0_outbound_data_bea=
ts_ccm1 + local_socket_inf1_outbound_data_beats_ccm1 + local_socket_inf0_ou=
tbound_data_beats_ccm2 + local_socket_inf1_outbound_data_beats_ccm2 + local=
_socket_inf0_outbound_data_beats_ccm3 + local_socket_inf1_outbound_data_bea=
ts_ccm3 + local_socket_inf0_outbound_data_beats_ccm4 + local_socket_inf1_ou=
tbound_data_beats_ccm4 + local_socket_inf0_outbound_data_beats_ccm5 + local=
_socket_inf1_outbound_data_beats_ccm5 + local_socket_inf0_outbound_data_bea=
ts_ccm6 + local_socket_inf1_outbound_data_beats_ccm6 + local_socket_inf0_ou=
tbound_data_beats_ccm7 + local_socket_inf1_outbound_data_beats_ccm7",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "remote_socket_inbound_data_bytes_to_cpu",
> >> +    "BriefDescription": "Remote socket inbound data bytes to the CPU =
(e.g. read data).",
> >> +    "MetricExpr": "remote_socket_inf0_inbound_data_beats_ccm0 + remot=
e_socket_inf1_inbound_data_beats_ccm0 + remote_socket_inf0_inbound_data_bea=
ts_ccm1 + remote_socket_inf1_inbound_data_beats_ccm1 + remote_socket_inf0_i=
nbound_data_beats_ccm2 + remote_socket_inf1_inbound_data_beats_ccm2 + remot=
e_socket_inf0_inbound_data_beats_ccm3 + remote_socket_inf1_inbound_data_bea=
ts_ccm3 + remote_socket_inf0_inbound_data_beats_ccm4 + remote_socket_inf1_i=
nbound_data_beats_ccm4 + remote_socket_inf0_inbound_data_beats_ccm5 + remot=
e_socket_inf1_inbound_data_beats_ccm5 + remote_socket_inf0_inbound_data_bea=
ts_ccm6 + remote_socket_inf1_inbound_data_beats_ccm6 + remote_socket_inf0_i=
nbound_data_beats_ccm7 + remote_socket_inf1_inbound_data_beats_ccm7",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "3.0517578125e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "remote_socket_outbound_data_bytes_from_cpu",
> >> +    "BriefDescription": "Remote socket outbound data bytes from the C=
PU (e.g. write data).",
> >> +    "MetricExpr": "remote_socket_inf0_outbound_data_beats_ccm0 + remo=
te_socket_inf1_outbound_data_beats_ccm0 + remote_socket_inf0_outbound_data_=
beats_ccm1 + remote_socket_inf1_outbound_data_beats_ccm1 + remote_socket_in=
f0_outbound_data_beats_ccm2 + remote_socket_inf1_outbound_data_beats_ccm2 +=
 remote_socket_inf0_outbound_data_beats_ccm3 + remote_socket_inf1_outbound_=
data_beats_ccm3 + remote_socket_inf0_outbound_data_beats_ccm4 + remote_sock=
et_inf1_outbound_data_beats_ccm4 + remote_socket_inf0_outbound_data_beats_c=
cm5 + remote_socket_inf1_outbound_data_beats_ccm5 + remote_socket_inf0_outb=
ound_data_beats_ccm6 + remote_socket_inf1_outbound_data_beats_ccm6 + remote=
_socket_inf0_outbound_data_beats_ccm7 + remote_socket_inf1_outbound_data_be=
ats_ccm7",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  },
> >> +  {
> >> +    "MetricName": "local_socket_outbound_data_bytes_from_all_links",
> >> +    "BriefDescription": "Outbound data bytes from all links (local so=
cket).",
> >> +    "MetricExpr": "local_socket_outbound_data_beats_link0 + local_soc=
ket_outbound_data_beats_link1 + local_socket_outbound_data_beats_link2 + lo=
cal_socket_outbound_data_beats_link3 + local_socket_outbound_data_beats_lin=
k4 + local_socket_outbound_data_beats_link5 + local_socket_outbound_data_be=
ats_link6 + local_socket_outbound_data_beats_link7",
> >> +    "MetricGroup": "data_fabric",
> >> +    "PerPkg": "1",
> >> +    "ScaleUnit": "6.103515625e-5MiB"
> >> +  }
> >> +]
> >> --
> >> 2.34.1
> >>
>
