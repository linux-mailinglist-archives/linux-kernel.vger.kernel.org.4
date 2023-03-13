Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C26B7260
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCMJTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjCMJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:19:38 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A688303CB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:19:37 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l13so12435359qtv.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678699176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93MKTJ9MDWn/ISNqBQPEJ2VlVirpHbQ1K4GLOntiehI=;
        b=rlEA0ETcSyUHcKQJobtYi1UQrzazm3+qY4VxhVcM1WZHWp6UoKzQ2Izab3CjCxA7+c
         WtlHpVASlkXH+YM9KwRl6+6grgGOTmCjBQq45rPLXKU+LTO9wtMPqBuFvO8VL4MY4k5I
         kgYBW5GLz4fdeAencuAeQYCZWBpo/7JShYmyOuSHBJMrVMSH0Atl0AFJkEbqmHn6pxa3
         n5bJd/8OrSRy6yZSH2z5Hf+lFw/RdudG/C1xDIqjKfYNdM2pa+4mfXHsHNP37UxXssbn
         w1vK35BDCu+8l9fiJLiOZGffC+gVqyAamrMpZMjtJgrhw70mbeeZt8VE+XzE2GItp1RV
         IsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678699176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93MKTJ9MDWn/ISNqBQPEJ2VlVirpHbQ1K4GLOntiehI=;
        b=VKeKbC2HEBDHfGMdNF3fblVJJcrnERukgEpNptUGU74Fje+u1gUqhyGi5HE86Bwht8
         6r9j7vXOjCyqwPebI12220Mbb0jYXyYLMGHTCR+uCBFkhR5FZb8bDJPGdB/bfNVwyzT7
         1vLTLcQ1S8UmLuyc7vnGbGnOrC5O+3b+LJNvGCh232v/dYV1L+ClwjLxiL0G9AvOFils
         4ftRbMIHk62ibZU5pDXXuk8mvusHPdjkacqzE0beyXoBmDFCoxDp9XnrNE2/egU3wJHg
         qK/BbOTr8D+0jHab9lqUcspASJRKMkOw1Qb8gBcPq1ztcYQGlPN/IVkOLpiOoikzU2UR
         zSxQ==
X-Gm-Message-State: AO0yUKUah6YW5S8qAO8xIzp1B5xwrCKyRXhSLJjwinOincC6rpUPt6zW
        ExVZvnQSXwmDvyCBOyO0N6Y9+bTx6gj4mSwAGXq45g==
X-Google-Smtp-Source: AK7set9VU11box7gOTFGJkfvp8eIs4eJi59Sw1fXt2hbhwVTZ4v59SG61KE4Kh/xDpZsPIzYtucHidOGr02cSM+MI8U=
X-Received: by 2002:a05:622a:4008:b0:3bf:c34b:d45a with SMTP id
 cf8-20020a05622a400800b003bfc34bd45amr3065615qtb.5.1678699176594; Mon, 13 Mar
 2023 02:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230126184157.27626-1-tony.luck@intel.com> <20230126184157.27626-8-tony.luck@intel.com>
 <CALPaoCgnOWLdEqKtonNeq+d_Fj0yr3Y7tgwwmAHmuhL5xBhqyg@mail.gmail.com> <ZAtpTl+um3nbCOz8@agluck-desk3.sc.intel.com>
In-Reply-To: <ZAtpTl+um3nbCOz8@agluck-desk3.sc.intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 13 Mar 2023 10:19:25 +0100
Message-ID: <CALPaoCiQMxgjusRzQMWhKJHtB2CYVOp3UaXpwPYYpO4VC+0KzQ@mail.gmail.com>
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

On Fri, Mar 10, 2023 at 6:30=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
> Tell me more about your CPU-less nodes. Your fix avoids a bad
> pointer reference (because cpumask_first() returns cpu >=3D nr_cpu_ids
> for an empty bitmask).
>
> But now I'm worried about whether I have the right values in the
> formula:
>
> nr_node_ids / bitmap_weight(node_caches, nr_node_ids);
>
> This fix avoids counting the L3 from a non-existent CPU, but still
> counts the node in the numerator.
>
> Is your CPU-less node a full (non-SNC) node? Like this:
>
> Socket 0 Socket 1
> +--------------------+ +--------------------+
> | . | | . |
> | SNC 0.0 . SNC 0.1 | | zero . zero |
> | . | | CPUs . CPUs |
> | . | | . |
> | . | | . |
> +--------------------+ +--------------------+
> | L3 Cache | | L3 Cache |
> +--------------------+ +--------------------+

In the case I saw, the nodes were AEP DIMMs, so all-memory nodes.

Browsing sysfs, they are listed in has_memory, but not
has_normal_memory or has_cpu.

I imagine CXL.mem would have similar issues.

-Peter
