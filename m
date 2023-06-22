Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D1873A2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjFVO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFVO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:26:01 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7913519AF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:26:00 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so135721cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687443959; x=1690035959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OvkU8UisH4BuGnYm+XG1wAvh/7S0gay7JPC/9n8Vw4=;
        b=495aCHMsXONb/7fk1o4BWI0cJufNsm6mSfC0X0UydCS7YJ40z6x4y1oFq4O73WAv2/
         PivI1PeQ6BvsG/OHG81s7Coc0vWWsZr4x9AW4lveNrWCBzR+RRC5J2jR0/ROhvTLskKh
         d+MoXFylY8oe3cij7GSXwnTQ4A2DOtWO/enmlxXIjyKsMk+WrfJc0WRZXJ7FdgDR07uF
         dLVCYV44b8onYroGILw3bTZhQCw/clwNlOfOPr4Kn3V9n5q4bxbblymddZeRTMr4ae0l
         RorrcI45qpKerreWFVfU9QZV5V9Q0VeSXBEjGzOWH+wRAK4dNdmZFBYCWeaVqvBDS58+
         Oc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687443959; x=1690035959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OvkU8UisH4BuGnYm+XG1wAvh/7S0gay7JPC/9n8Vw4=;
        b=bZ+5ewq7+XlMHm8NXu8+lviGirGkfy77yUlrnSMwYvrkmNdGEWQWDipTqi/tvKOWok
         e87gYLleyB6gm0KaHpk5tlCnLhK0V7fiw2BpQi9xt9H30WSbDaye/1G/mewj4D3+qucV
         7leI84pVw5y5wpp4jNBCwfNIlUHpT2XAHJiqQdm/CO8P0Le6rmTUz/I65Utk2W0gRQtI
         Ko6N9RuBGGmbImOkwXwLtZdXC5UEljAx+H2l5JLDgMjxtU8oTPuwW0wI8dwy0pfYhpQT
         9G4hLBXK4Og4mVoCqgstgqdycqJl2fMr/K++h4Pjwl2/9sYhTOA/Gcj9cjDi8ThcsYfo
         RbNw==
X-Gm-Message-State: AC+VfDwwVF6OQFOmUnchzIbWpIJBQeTIZ8PBlCDQjTC/npG8G1jZGV4W
        A1ejFUjJPf0zY0r7AXzjolgo3tniN/PV8afB36Aduw==
X-Google-Smtp-Source: ACHHUZ7uUs4bnPr21LwAzMF128NWxNRIN5dXaoxu+IPGm/xXmIMIi2Rhx50YN8/p1xyv+58+Bcl5JwW0NuXrO0euY4E=
X-Received: by 2002:ac8:5954:0:b0:3ef:3083:a437 with SMTP id
 20-20020ac85954000000b003ef3083a437mr448649qtz.18.1687443959520; Thu, 22 Jun
 2023 07:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230621174006.42533-1-tony.luck@intel.com> <20230621174006.42533-8-tony.luck@intel.com>
In-Reply-To: <20230621174006.42533-8-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 22 Jun 2023 16:25:48 +0200
Message-ID: <CALPaoCgF04M0Jc-c4VmbKkRSFo677SBGoPHzNCSeQ4S6Bqb60w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Wed, Jun 21, 2023 at 7:40=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> There isn't a simple hardware enumeration to indicate to software that
> a system is running with Sub-NUMA Cluster enabled.
>
> Compare the number of NUMA nodes with the number of L3 caches to calculat=
e
> the number of Sub-NUMA nodes per L3 cache.
>
> When Sub-NUMA cluster mode is enabled in BIOS setup the RMID counters
> are distributed equally between the SNC nodes within each socket.
>
> E.g. if there are 400 RMID counters, and the system is configured with
> two SNC nodes per socket, then RMID counter 0..199 are used on SNC node
> 0 on the socket, and RMID counter 200..399 on SNC node 1.
>
> A model specific MSR (0xca0) can change the configuration of the RMIDs
> when SNC mode is enabled.
>
> The MSR controls the interpretation of the RMID field in the
> IA32_PQR_ASSOC MSR so that the appropriate hardware counters
> within the SNC node are updated.
>
> Also initialize a per-cpu RMID offset value. Use this
> to calculate the value to write to the IA32_QM_EVTSEL MSR when
> reading RMID event values.
>
> N.B. this works well for well-behaved NUMA applications that access
> memory predominantly from the local memory node. For applications that
> access memory across multiple nodes it may be necessary for the user
> to read counters for all SNC nodes on a socket and add the values to
> get the actual LLC occupancy or memory bandwidth. Perhaps this isn't
> all that different from applications that span across multiple sockets
> in a legacy system.

Unfortunately I'm not getting as good of results with the new series.
The main difference seems to be updating the 0xca0 MSR instead of
applying the offset to PQR_ASSOC.

In my test case of generating bandwidth on 20 random CPUs in 20 random
RMIDs, I'm only getting correct counts from CPUs in node 0. Node 1
CPUs are showing counts which are too small, and nodes 2 and 3 are
seeing no bandwidth at all:

(expected bandwidth is around 30 GB, value in first parenthesis is L3 cache=
 id)

cpu: 134 (0), rmid: 30 (g29):   0 -> 30640791552 (30640791552)
cpu: 138 (0), rmid: 103 (g101): 0 -> 28196962304 (28196962304)

cpu: 35 (0), rmid: 211 (g209):  0 -> 3039232 (3039232)
cpu: 55 (0), rmid: 113 (g111):  0 -> 4874240 (4874240)
cpu: 41 (0), rmid: 83 (g81):    0 -> 2637824 (2637824)
cpu: 42 (0), rmid: 218 (g216):  0 -> 2408448 (2408448)
cpu: 161 (0), rmid: 8 (g7):     0 -> 7856128 (7856128)

cpu: 86 (1), rmid: 171 (g169):  0 -> 0 (0)
cpu: 86 (1), rmid: 121 (g119):  0 -> 0 (0)
cpu: 212 (1), rmid: 163 (g161): 0 -> 0 (0)
cpu: 180 (1), rmid: 129 (g127): 0 -> 0 (0)
cpu: 205 (1), rmid: 186 (g184): 0 -> 0 (0)
cpu: 194 (1), rmid: 160 (g158): 0 -> 0 (0)
cpu: 186 (1), rmid: 196 (g194): 0 -> 0 (0)
cpu: 106 (1), rmid: 93 (g91):   0 -> 0 (0)
cpu: 84 (1), rmid: 168 (g166):  0 -> 0 (0)
cpu: 197 (1), rmid: 104 (g102): 0 -> 0 (0)
cpu: 64 (1), rmid: 103 (g101):  0 -> 0 (0)
cpu: 71 (1), rmid: 81 (g79):    0 -> 0 (0)
cpu: 60 (1), rmid: 221 (g219):  0 -> 0 (0)

Here's the output of `cat /sys/devices/system/node/node*/cpulist` on
this machine for reference:

0-27,112-139
28-55,140-167
56-83,168-195
84-111,196-223

-Peter
