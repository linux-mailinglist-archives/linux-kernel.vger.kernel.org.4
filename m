Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5711C73778D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFTWml convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFTWmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:42:39 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C918E10F1;
        Tue, 20 Jun 2023 15:42:38 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-77e2f2ad553so186846539f.2;
        Tue, 20 Jun 2023 15:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687300958; x=1689892958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4H5CggCHHSoUjV0wAgcwF61+kh3EMGwOfr9WqhDgAN8=;
        b=jXJB3fMXET2zf6FgYvvZXi8Fa3/AHMg1TY17V3PFihX3EkuwSiLnnzl8ZW2uSVDCc9
         4wmpitQs9jFBP3bAfGIzDshWLl4CX1rMFTdlzXuwO6CG6/XsdCU2DVPjdmCq0gcszg7r
         3QYY01IRfz/3Bf+CKoDBFb38DWWfZTK2aLYKXaGN8Q6QmnOZhLimUdEV2VB9EyXfJr81
         YI4yqaljMpUUv6pyybGdkd9NmwzO83mjV30XJTjnW3SF3Nk116s0/7Rh8WfBul7L0RKL
         3sWAcmXB6Cd3JE3Wjk666IVPEDkEPo0QDlBquYimh1c09y3C7VsQKkvLmNxmejscB7Of
         5jSQ==
X-Gm-Message-State: AC+VfDwf+qO+L1jKwJG8U6EhjiU6wZ3eNEG84kW9uXUKozvJMUyPqQsB
        kmsVOneLGGBacrqOx+JAlNZya4jQf5cEXxTaRjE=
X-Google-Smtp-Source: ACHHUZ7NR3d1W0rG8kIMdNaawU+eMWi73gH5JrW5qsaJ96o9I8k0237Wfjudf9f5N0nkQ7bpp64Pggw3rnfudF+p02g=
X-Received: by 2002:a5e:c012:0:b0:77a:c741:b73d with SMTP id
 u18-20020a5ec012000000b0077ac741b73dmr14703953iol.3.1687300958019; Tue, 20
 Jun 2023 15:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230619082036.410-1-lidong@vivo.com> <CAM9d7chHMH-uJryUVBYZ6emrGLVH8Huc5frDz4YqG7TU29G-6A@mail.gmail.com>
 <CA+JHD93f_c8OJf4Kg68C_Xo=_rcO669G0QJ_mjL78upLmUwfoA@mail.gmail.com>
In-Reply-To: <CA+JHD93f_c8OJf4Kg68C_Xo=_rcO669G0QJ_mjL78upLmUwfoA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 15:42:26 -0700
Message-ID: <CAM9d7cj-t-jko=7mBb_dLrXFCC7s03W0Jz7jrO4nZkWZKeJAAA@mail.gmail.com>
Subject: Re: [PATCH] tools: Fix incorrect calculation of object size by sizeof
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Li Dong <lidong@vivo.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Jun 20, 2023 at 3:06 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Tue, Jun 20, 2023, 3:19 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Mon, Jun 19, 2023 at 1:21 AM Li Dong <lidong@vivo.com> wrote:
>> >
>> > What we need to calculate is the size of the object, not the size of the
>> > pointer.
>> >
>> > Signed-off-by: Li Dong <lidong@vivo.com>
>>
>> Since this problem was introduced in the current dev cycle and not in the
>> mainline yet, I think we can skip the Fixes tag.
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
>
> I think we should have it anyway, if not for the stable guys to pick it up, for documentation sake :-)

Ok, I'll add that.  Thanks for the reply while on your vacation. :)

Thanks,
Namhyung
