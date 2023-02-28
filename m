Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE386A54D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjB1Iwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjB1IwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:52:03 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACEE1555D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:51:55 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u5so6250490plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DT1kTlRkpOvzUrpehXB4L+ZBQg4AVY3DSAFM0E9WnMo=;
        b=JgVXOKueiGhuI8TWecNTKpDvXL45OziMa/uV+4scmyPZZZHsPXMImaLR2QlF3tGVW1
         VOvweFMRl8VkRRA7FhV7wVu/9nfcrKV/zoy4gL8N3RicHA3RxVmz+NHfZSjaJDw7aPW1
         cRRNDFHj0LUnEExQL1+a+goEStRj0avc/2c5h3efHIhHL0O2Co6Ym4pWjkmYD4hDolEX
         +Qxpt3Z6FXtRYsVyPV+fUP4g/7G1QapigSOOZPXe2N8YgXzDgf/GBByMUU05Ubx6UMoQ
         uP9Z1GAFrnqPHphdnH5+HKVCMUrUeRZbEwXg4hTaSx/z6XtYbWLWYUOXAJE/keX6Tze8
         b8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DT1kTlRkpOvzUrpehXB4L+ZBQg4AVY3DSAFM0E9WnMo=;
        b=ICVAllaBWL7uynto+mGmzneitFs9sTYYgL8e/K32o6bA9p7wKpE32Iri1n/dkCXYrX
         otuvuxr30R/NDrc0RETrR71umoqWh2aSaeVWg349qULC3nar9cZhEQ2r0eQQ4GE8HMRu
         kb54tXEozCjz0iXsykEfv6dGyu+UnKuBKj1Qr0nb+kKO4KsFNl9BUDLVK9VMwcMGbm3l
         LoLYRjquJ0qhNUXo3Lydmz1kl+cCsRSi+S0TTa9iVtPNRukitEyiH8NfNz2JMglLap/l
         dkeoGM1pnazncdDMhkmDYmnnmWiZn2/+F0sn5BW0wcjK9BSigMXngEyNsNm+I4PKzsRA
         cwTA==
X-Gm-Message-State: AO0yUKXOVIK89uFWncZ9QfTkV5cZwc4qxNys29SbZT4w7zeOTJvq79HG
        m/Rnh0X2N6YsD7I2kY7f8nxlgSp1CwIeshWTEg0=
X-Google-Smtp-Source: AK7set//aJ/+ZilVjgBJf2ou2e2xLsStkIHj5RNIfSCb2QhTI7EWTtk1ZRIopm0fLLfY7J6iReY3VQ==
X-Received: by 2002:a05:6a21:32a5:b0:cc:9b29:f61d with SMTP id yt37-20020a056a2132a500b000cc9b29f61dmr3189697pzb.6.1677574314396;
        Tue, 28 Feb 2023 00:51:54 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id j8-20020a636e08000000b004fc1e4751d5sm5187185pgc.35.2023.02.28.00.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:51:54 -0800 (PST)
Date:   Tue, 28 Feb 2023 16:51:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] perf kvm: Support histograms and TUI mode
Message-ID: <Y/3ApYi3GLCVGEZr@leoy-yangtze.lan>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
 <Y/0jPa9xu371PtRS@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/0jPa9xu371PtRS@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, Feb 27, 2023 at 06:40:13PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > And I verified the '--stdio' mode and confirmed it has the same result
> > with before applying this series.
> 
> Can you provide precise instructions for all the steps involved? from
> 'perf kvm record', I'm trying here with a simple 'perf kvm record' and
> then starting vm and having trouble.

Below are steps for verification this patch set.

In a terminal, I launch a KVM virtual machine with qemu command; I
downloaded an Ubuntu iso file [1] ahead and used it as the file system
image (or you could use any distro's iso file as file system image):

  $ qemu-system-x86_64 -M pc -enable-kvm -cpu host -m 4096 -hda ubuntu-22.04-desktop-amd64.iso

Then in another terminal, I can use below commands to capture KVM trace
data and report the result:

  # cd linux/tools/perf
  # ./perf kvm stat record
  # ./perf kvm stat report          => Output in TUI mode
  # ./perf kvm stat report --stdio  => Output in stdio mode

Note, I have sent out the patch set v2 to fix a potential building
failure in patch 13.  Please work on the new patch set [2].

Thanks,
Leo

[1] https://releases.ubuntu.com/22.04/ubuntu-22.04.2-desktop-amd64.iso
[2] https://lore.kernel.org/lkml/20230228084147.106167-1-leo.yan@linaro.org/
