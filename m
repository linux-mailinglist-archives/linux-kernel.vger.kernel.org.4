Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA26773BC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjFWQEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjFWQEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:04:21 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57522270B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:04:19 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6300f6ab032so7632756d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1687536258; x=1690128258;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkCU27YeWYPr1I8vi2zgnQGLek516NQOwJppe/zcLRQ=;
        b=adyk15Rey22YW24kQvynUdQZpNYqgF7LlhsDAWedX+3rCdpjtOLZ8DFTsDSozH2N35
         typD0VRNKPBMXizi1O93czEa68cFdaLH4Qnu6bfhx+xDr5BpOvdxqXSfQVHzjHpCrN7b
         5DIu1BGKHJiA0WF1DumHBLLRu3XV8yuMZBSdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687536258; x=1690128258;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkCU27YeWYPr1I8vi2zgnQGLek516NQOwJppe/zcLRQ=;
        b=SAxZVOX4S5Q3e1kSBjEfOFDXnft1+fXv/d1oAxCED6hgWkS0cdrNeqvYJWlZj+23qm
         vaUC7LmLPWiaqTKBMGPjgEgOm4Qa9JbBDtpshCbzLS/l+4KQMtkWt4FMvFdObzxXSRRN
         BYkIaypktfOPdM5aHuD2VxGnS/2l+TloSkGHbuUVK01p12wQfZUxOAFTPoFaqwzEPCiG
         o6+xF8nWx9Xhv5gfQYciih5V/8RRnhJENMP1K3IcqT2bxjCpPrsW7qkLgvgH4PILU5Cr
         OEa67o1SXULyJexcQ3UYtBLWrjXygu+hVC3XlMDepOWtJXZkQCClFwtUz5wDO0/z2ug5
         OVeQ==
X-Gm-Message-State: AC+VfDw6te6xBtAndPRYn+x+HPoTlsdh+nhYRCRim2h5PkWZVuoiiL/K
        GPH7ltSwB22gh+9/XgMQdmpFSQ==
X-Google-Smtp-Source: ACHHUZ54R98ZBjwGvQadwUU6bIFsyMXtmyOo/WfF0ahv3XFa+m6/YpMz+OenWDUllWtc8BgqaqEIwg==
X-Received: by 2002:ad4:5b81:0:b0:626:94f:6044 with SMTP id 1-20020ad45b81000000b00626094f6044mr25988971qvp.2.1687536258328;
        Fri, 23 Jun 2023 09:04:18 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id z14-20020a0cda8e000000b006255bcfca88sm5192184qvj.7.2023.06.23.09.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 09:04:17 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 23 Jun 2023 12:04:13 -0400 (EDT)
To:     Ian Rogers <irogers@google.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Subject: Re: [PATCH v2 07/12] perf vendor events intel: Update icelake to
 1.19
In-Reply-To: <20230623151016.4193660-8-irogers@google.com>
Message-ID: <ac3b4a0c-7984-8b15-a7ed-9c0428bdb027@maine.edu>
References: <20230623151016.4193660-1-irogers@google.com> <20230623151016.4193660-8-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023, Ian Rogers wrote:

> Updates were released in:
> https://github.com/intel/perfmon/commit/f3d841189f8964bc240c86301f4c849845630b5b
> A number of events are deprecated and event descriptions updated. Adds
> events ICACHE_DATA.STALLS, ICACHE_TAG.STALLS and DECODE.LCP.

why are the events marked as deprecated rather than just being removed?

Vince Weaver
vincent.weaver@maine.edu
