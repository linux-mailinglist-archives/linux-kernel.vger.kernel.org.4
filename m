Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D86647701
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLHULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLHULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:11:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7017171266
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:11:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o5so3038663wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtbOrMo6wdNtyC/UhfcUZ9MIo03/XSa++ujJjTCLb48=;
        b=JClcizhBWdIQUrnb+z7ZgDV8D5KRedOoIS1+bJ/Sa0k/D1sxMBItJf1fc/d4cuIt4v
         J463B1dPxXnleFugUk+3E++AVrRUU7oBf4xT7a1E4mqdgRYZmr/lzsrEvpSIVlUNENwi
         odOgaI8+FxRekXupCVBQ0J4G4Lkc4UWRyPRufoJhnojYP97ZdMyi11cvgqvHdYCmOcUL
         SZGr9aen5/GyUaFsechv+dGGyiqTv4Bwllcb2xEPRvNcW+Sl4EJalaK6tbGRKnVike0W
         X5yQfwvWQpigjRfC/i5KdNW32twsqMlWwa2Y/oCYguW8AoUvkQj9dC4mVuQA9SvP4xhs
         BpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtbOrMo6wdNtyC/UhfcUZ9MIo03/XSa++ujJjTCLb48=;
        b=jNVvgWpHMjC4IyW1pBx5h8jTOpnWwtMAihi0VeDEWT5tAvwvnp3Q9WUbn+GgRX5IjF
         paaIE1wYwUdHV8XvsV1gv4PBQUMHTc7YGcjxZslDTNkUFzJkq7tBT6yHvbmcWuSeBe5S
         DgPtDQyH7mxwjyvhZVD7RuR23u9SI6FQpmLRS/e/7q3Qbbio+sT2xkrcKI4ls5u1bt/q
         YSIL1Zqc/BzGa3txuukfl4jEj8ZZfeIL+E4Ce+YKECXuueUfjS43WWyGJjWXneOnL27Z
         zwXm0dVl6SBada135j7F6ElBCeoCQ3VU5HaXXXufHxvxvsxTk2cSwgMIIMuSmZrLURJJ
         Kbmg==
X-Gm-Message-State: ANoB5plkokAikkoF66bhtkz3RBqudmBdBpxLZswHVUzWCws0E+dWL+Pa
        A5xKKmNYV6tAZJzKCj7aj2AgslxVHzyn2MSyOvE=
X-Google-Smtp-Source: AA0mqf5Ac07J1dF2CBKqxEKulovREAc1KkD2Iet1HJgDc824s9ZWUjFXXpgNRjf8TbuPTQIdMAjA7g==
X-Received: by 2002:a05:6000:1d84:b0:236:3686:797 with SMTP id bk4-20020a0560001d8400b0023636860797mr2168962wrb.65.1670530305011;
        Thu, 08 Dec 2022 12:11:45 -0800 (PST)
Received: from debian ([37.19.195.134])
        by smtp.gmail.com with ESMTPSA id bs21-20020a056000071500b002428c4fb16asm2805773wrb.10.2022.12.08.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:11:44 -0800 (PST)
Date:   Thu, 8 Dec 2022 15:11:41 -0500
From:   Petar Gligoric <petar.gligor@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Re: [PATCH v2 0/3] perf: introduce perf based task analyzer
Message-ID: <Y5JE/ci+1nN9RrJQ@debian>
References: <20221206154406.41941-1-petar.gligor@gmail.com>
 <CAM9d7cizPC3p0-Z1oYsDPofwNfZHyKYiJR5JXEcS31Q=mgzcLg@mail.gmail.com>
 <Y4/AfA2OYtlTkKwo@debian>
 <CAM9d7chLZVDg_-tnUh_qFYzchnpis-e7HYNDVM_OPjj_QXMeKQ@mail.gmail.com>
 <Y5HVdS3mlDruNyrl@debian>
 <CAM9d7ciX9ULwSy5G3cFZi7mMXrt_A52hwwk7L1m-oV_0P07_vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciX9ULwSy5G3cFZi7mMXrt_A52hwwk7L1m-oV_0P07_vw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Dec 08, 2022 at 11:10:58AM -0800, Namhyung Kim wrote:
> 
> Then I have no problem with python.  Please take a look at the
> scripts/python/bin directory to provide shortcuts for record/report.
> 
> Thanks,
> Namhyung
> 
> 

Great that we could resolve it! Regarding wrapper: I thought I added
them or did you mean something else?

.../scripts/python/bin/tasks-analyzer-record |  2 +
.../scripts/python/bin/tasks-analyzer-report |  3 +

Best Regards,
Petar

