Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910916BD31E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCPPOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCPPOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:14:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A247418
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:14:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so1934083pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678979661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hipF8kv9btc+ofi69HcRjl9Ik6Nhwu9Uss+16//MXqk=;
        b=oYzM8mfqsog+QJRhec+BKT1ae38JEQWTABfr0aunbSbufycQbpAX77GixAo4mlG02a
         45Ax2iXM4BaAg0AxTbfA3lomJ+GKpTMAUWOKMhUJOcAcMZSovddcC0WcACaWrpBBhAz5
         47LkJ5DHckti+l5/4pFSBII35EmBlKHH3ak7prX1NUY/7oNkwwKbTB9xVkupcRNY+KId
         exvmcUc9nBg0rFZAJQ1HcgDp/BRZpfb80e/mh1lcpEF+N3Q6tU1omjJXdSX0PuyyQO4H
         qQCjcTC7Fc9WIqSUc5vvYgV2wyrocKvq6P7FP8PATz2pV4NlSpgBdCSRr66TE+UxjI/T
         dUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678979661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hipF8kv9btc+ofi69HcRjl9Ik6Nhwu9Uss+16//MXqk=;
        b=HDIhY9X/ok/SdwcE+z9A+VfnAdFVCITTyZXBZWkw2RIu2vhKes/UaMMKa2gEsyOA29
         iGgNx8ww1jNFCGv0sRy9JuVPHRkk1IlGA0wSbMFhE0GPv2hpqolGcth2RPL5TsQD/jk+
         j5qeLA2bxc78drqedjl6m2EkueC2pgT6xqYvBRHF4ijnCFKXGeENq+i0ii73rnxoVM8j
         0SUfHV6RBFSlrTTNDTLqggvQSm8+4/2QW1a+eRTQ4qqjzkiQMducFbKOMiciVLAbyKf6
         zQuAw0SmK00vkNlGLkGZfxw+Pcf7HmX+tanzgtXRQTJiQv6UyQVuLj6IiMH20ReK1XMi
         N0Lw==
X-Gm-Message-State: AO0yUKV7BpL3TQtyS47GrQzZdH3eIFJ4iLYMcpc0mgEazY5Dq5y6D7Ng
        OcBs/fyWi0Az7NqQ5J2NTuADig==
X-Google-Smtp-Source: AK7set+MWdri4mh3ohhBtzGkKy25cPA3xa0qhOawUt9CdCmWX/BF9DdxvoyfpfkQOUt1OsWmJAibtQ==
X-Received: by 2002:a17:902:e546:b0:1a0:6bd4:ea9a with SMTP id n6-20020a170902e54600b001a06bd4ea9amr4556577plf.16.1678979661080;
        Thu, 16 Mar 2023 08:14:21 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0019602274208sm5687274plg.186.2023.03.16.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:14:20 -0700 (PDT)
Date:   Thu, 16 Mar 2023 23:14:15 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 11/16] perf kvm: Use histograms list to replace cached
 list
Message-ID: <20230316151316.GA2813925@leoy-yangtze.lan>
References: <20230315145112.186603-1-leo.yan@linaro.org>
 <20230315145112.186603-12-leo.yan@linaro.org>
 <CAM9d7chSKPxMHzpKZ92xGZ+XmLpd2q2EJwMuszosXu_FO4_dgA@mail.gmail.com>
 <20230316090418.GA2665235@leoy-yangtze.lan>
 <ZBLrruagawAbxqoz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBLrruagawAbxqoz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 07:13:02AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Since I build tested this already and had the other fixes, I'm pushing
> this out to perf-tools-next (and perf/core for a while, for people not
> knowing about the new nbranch names) and you can continue from there,
> ok?

Sure, I will send a fixing patch.

Thanks,
Leo
