Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF66B69A99F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBQLDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBQLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:02:38 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9642A644E6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:02:29 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g16so1249207lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/plfQ38dzMrGO1JbheJ9rCmuE1cLMVk9gw7wSXm4Jqc=;
        b=b1x8b/jwmA9YOIRBgoOQyok9k8pouvrhm1zW5L0FTRJgx+tIK7LO0HIF+s3C/ln4Po
         VrmFB1cPNkVSAkWm9YVkoV5JvDum7g2l7Lq1tZEMvmXRChfaVOrbnmpg5Q3zwn0jmguJ
         5TO652PsdgW32LksChbowDOFodL6kp9mixIVoj7WO2ErnuGYAiblfGIRTtg89BpY3VRI
         rul5RtUiXlQ2JpEGKJ/1mcOvWcrJnkeKixOfEwlqihTR2gfPCAw8hsgOWxoG32Q852fw
         l01JuY1BE44VUErAENa1J51SGav4GCTVkkEfuOLyPcBkTai7J4r0k9XBoR/2MSEq+9gl
         Kp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/plfQ38dzMrGO1JbheJ9rCmuE1cLMVk9gw7wSXm4Jqc=;
        b=g5HyyI9yTG0Q7GJdl6fxIu2WRjUCaDVRargccufaekgGE/QNFc8M6zLgTStPwCUYc7
         B7c2mS96O2oq2TB8Jz75VwO1wsO7xqZNFNMbsGgEgjSIM95YDcHoWBStUqWLgXVbAk1D
         NUs9qJI9vIyIi9lY/INc5Z3uVXe5BhIJ6Lb+qkprL/sfsN9JO4I9mHKcQEzglxISFJkY
         hGHZcIbijIX/QWWMaPAwnAEoXEDANp0LF/KNCgHVVMI6EgR/Ljfo45K0KlnUqQgBRXN0
         fbW5bSbHJjYCVjgMuY/PVlqyWEW62cZw2f7EbRp1sCbmk+diF6pH8DHTG6RKeUnG0pKz
         RsmQ==
X-Gm-Message-State: AO0yUKXY0OyXy2ZiVPNW0/AD5syNY7BTCs7V6/1/DKBoO1Y7OR278Kzn
        PgkW/bOqPV8qMLLdworNXErH6Q==
X-Google-Smtp-Source: AK7set/2y7oM6jSdsEB9bbAcsNFt46R4u7C7/sbZGhjSO3xWVD8rkQc6w9MsM4qA6Cl9MgV3Ao8l8g==
X-Received: by 2002:a19:f611:0:b0:4b6:d28a:2558 with SMTP id x17-20020a19f611000000b004b6d28a2558mr2958542lfe.49.1676631747693;
        Fri, 17 Feb 2023 03:02:27 -0800 (PST)
Received: from google.com ([2a00:79e0:18:10:d02c:4bb8:fba9:c9a7])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651203c600b004cf6c56fdb5sm643926lfp.232.2023.02.17.03.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:02:26 -0800 (PST)
Date:   Fri, 17 Feb 2023 12:02:21 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf intel-pt: Synthesize cycle events
Message-ID: <Y+9evQVBRLrCLQKf@google.com>
References: <20220322082452.1429091-1-sesse@google.com>
 <YjpAYjdgHWwkid5N@kernel.org>
 <YjpFcLiCTjHZWzzA@google.com>
 <52d31321-66e1-f189-2ffc-7c93239eea74@intel.com>
 <Yj49LDY3S/ANeN0V@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj49LDY3S/ANeN0V@kernel.org>
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

On Fri, Mar 25, 2022 at 07:07:40PM -0300, Arnaldo Carvalho de Melo wrote:
>>> 
>>> There are two issues in play:
>>> 
>>>  1. PT event synth doesn't support reading inline information from DWARF
>>>     yet, and my patch to add it runs into some problems. This is not
>>>     relevant for this patch at all.
>>>  2. The results from v3 don't quite match the ones from v1, and neither
>>>     of us are entirely sure why. My personal feeling is that the one
>>>     from v1 are the wrong ones, but it's up to Adrian to say whether we
>>>     want to try to investigate deeply here.
>> V3 is good.  Please take that.
> Thanks, applied.

Hi,

I downloaded linux-6.1.12 now and built perf from that, and this patch
isn't included. Did it get somehow lost along the way?

/* Steinar */
