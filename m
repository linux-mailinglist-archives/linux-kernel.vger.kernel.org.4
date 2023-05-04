Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF116F70D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEDRZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDRZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:25:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE864220
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:25:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9659e9bbff5so134690966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683221149; x=1685813149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcRi0OT1PHOb52J7+pfe7c0giAH6vTm1G5lOY/4eLy8=;
        b=CZUeay9KmIpxmvT92te1g7tEn9Xl5R6m+Vvl9GmmyRtdEK1Owtwl8HtvfLnN0pC020
         NiXyIpB0BlsYjgdv5U5Bf2/VpqY5u2n1Yu/bzHP0btBkoV2zd5r0dQrYjALm2BLtVrf4
         IjB/LsxIM2IdJ1grCg0purYszkhGnDKRI/VPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683221149; x=1685813149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcRi0OT1PHOb52J7+pfe7c0giAH6vTm1G5lOY/4eLy8=;
        b=ZSJ9nhr4K05sj+ESxbGI0QPZd1DraqrgjsBPvpApnBlx/g4l13cmQR9Q3YvBXvE+Hd
         qjQJBw298T8mmc0bnjzB+6c/MhUkBAi//CYcI/lkghEMgGCtHSNJekDp8VOnFElKSjBl
         qImwpykNhXBtroUZH3t74vnizT4KgJx0sYOcrcJ0M04a7nhLGVX4/GQt4ZBtAN0d4KGu
         42MsF5f/wb7OEgQ2jRI4ieyjACQ256eMdkKJAhrcKeK3Zk+lEA01qpiZa9LNxb13LCUx
         A/UmS+eV7ACW7le31SAF8ErAazXQ5I25AeM//82QVUNvn74MBeTX6afCJES3PoYb5pG0
         BHjg==
X-Gm-Message-State: AC+VfDyjj3NSF8cr73c6cBCRuPUo8cJk/8sFZtGWr79rcqbCdws9mbWm
        0G2XSSF4APmMmd7eCeLOBKBPL90vicv5WFHj0JUyBCe9
X-Google-Smtp-Source: ACHHUZ6FbAlpmrDso7i7FHaSgoC9JVUY0CpT1MZccEcKaEaOPdmtQucb1xhcdAfdVInEJ2y5qIProQ==
X-Received: by 2002:a17:906:6a10:b0:8a5:8620:575 with SMTP id qw16-20020a1709066a1000b008a586200575mr6914382ejc.3.1683221149030;
        Thu, 04 May 2023 10:25:49 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id se20-20020a170907a39400b0095ef737dbd7sm11662542ejc.93.2023.05.04.10.25.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:25:48 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso134066966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:25:48 -0700 (PDT)
X-Received: by 2002:a17:907:984:b0:94f:9acc:65c9 with SMTP id
 bf4-20020a170907098400b0094f9acc65c9mr6254599ejc.66.1683221148020; Thu, 04
 May 2023 10:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230503211801.897735-1-acme@kernel.org> <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com> <ZFOSUab5XEJD0kxj@kernel.org>
In-Reply-To: <ZFOSUab5XEJD0kxj@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 May 2023 10:25:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
Message-ID: <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 4:09=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>>
> Does building runqslower works for you in this same environment where
> building perf failed?

I don't know, and I don't care. I've never used that thing, and I'm
not going to.

And it's irrelevant. Two wrongs do not make a right.

I'm going to ignore perf tools pulls going forward if this is the kind
of argument for garbage that you use.

Because a billion flies *can* be wrong.

           Linus
