Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3536A42A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjB0Nax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjB0Naw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:30:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D81F933
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:30:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x34so6152213pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrlqkyNhx5Y9J/eloABTQEhuK4mEKVoWLJBJOEPVQu0=;
        b=mQU8pset9BooU3jzDqbQhgS4BYtT04chvJX646MRug8Def2PUH67YE9LLRZZjtxvoD
         6FnUwhoGoLGiTYUCCMEkd4JmJBsE+LslYcsK7xUe9t8MtYKAXHdUpk4CGxlIZbM1m3Dt
         FZMeMU4UGstobcZBN3TJQ5d1hZzZtR/F0d6dqDPEFNCD6AwGN+ZCJjVQxKqFBCQWoCFp
         j7M/xxiCgLQ+jcbD6kZqPpt0r9oZ+frd5oyfSIXHHB6/64KPvTb9wupL49KOCSsKlydB
         xaEI7pz/vT6EFDi4smuf+uxt5hOvVs9VYsLzdqFePVEtRmDd3kDS09OLeV7TRdLrj/2F
         YS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrlqkyNhx5Y9J/eloABTQEhuK4mEKVoWLJBJOEPVQu0=;
        b=c+UYCAXSks/zV1X40ndVrQZ03uuoX4U6ycpWl1l1KdECVqztx+JAyHK113NRaEVOJ8
         wwp35UgLMqfES2Gkr0RlFT4Xt25jhRFobr/OzLYjIPAJ06dcZcVAPcYNw0n34WrCkJzG
         8+bVAk8q9YPdrALWTirsaCVQKfwi1tRQmFNqpBbB2ZwB4mB7StrClkJZYV0B7Xex96p+
         5YJMm4tZcocAzwBFwFhLFjcSlaILda6+VNJr6uMXPjKYynRQVyCykDNlNK/nqBBzgWw+
         cmeHQdT6NrRK9J01zC7WF/jWv0WTZkI47+nL4rXf9mPy1uo/5wLQQmtfY/Nck9MjP8tk
         bI0A==
X-Gm-Message-State: AO0yUKW4qVaFGCSx9h97+hHY/3Qk9U/tRUeA21dkVpyv/2ObTPPEPEuO
        bBUSoMk20RVB40P8iPwyn730QWw9oAGMSvTEPCWrIg==
X-Google-Smtp-Source: AK7set+y9/1kpprFY1OXKEHgrB85hu8mL9Xs/CkAgyUFKPWIL513Klt7JDZqMu91zLA0aFlMVuNpZvdkd6ZWQ9+Xmps=
X-Received: by 2002:a17:902:ab07:b0:19a:7e41:5a2c with SMTP id
 ik7-20020a170902ab0700b0019a7e415a2cmr6144088plb.2.1677504649857; Mon, 27 Feb
 2023 05:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20230126184157.27626-1-tony.luck@intel.com> <20230126184157.27626-8-tony.luck@intel.com>
In-Reply-To: <20230126184157.27626-8-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 27 Feb 2023 14:30:38 +0100
Message-ID: <CALPaoCgnOWLdEqKtonNeq+d_Fj0yr3Y7tgwwmAHmuhL5xBhqyg@mail.gmail.com>
Subject: Re: [PATCH 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is enabled
 and initialize.
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Thu, Jan 26, 2023 at 7:42=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
> +static __init int find_snc_ways(void)
> +{
> +       unsigned long *node_caches;
> +       int cpu, node, ret;
> +
> +       node_caches =3D kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_=
caches), GFP_KERNEL);
> +       if (!node_caches)
> +               return 1;
> +
> +       cpus_read_lock();
> +       for_each_node(node) {

Someone tried this patch on a machine with a CPU-less node...

We need to check for this:

+               if (cpumask_empty(cpumask_of_node(node)))
+                       continue;

> +               cpu =3D cpumask_first(cpumask_of_node(node));
> +               set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> +       }
> +       cpus_read_unlock();

Thanks!
-Peter
