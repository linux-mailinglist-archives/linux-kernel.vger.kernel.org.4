Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E0473A94B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFVUDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVUDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:03:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D5919B;
        Thu, 22 Jun 2023 13:03:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b54f5aac48so36121385ad.2;
        Thu, 22 Jun 2023 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687464198; x=1690056198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3177D2gAzh/TeV5rsITAvPzX0EvWliaupFIrZiwcQgU=;
        b=U2QO1iZnkEYG5tFjxVYjbsRptW+ljrGwOC1E9dEXLMEoO1wvmjbm2z6kcRevY6JGV7
         M1XC3yURdVxtbe37bW7pV8R1ABkXwWjWWvyWs0ur9zmXE07Nze0UOwLiWVj1rcjHGlMf
         pwAHFE1hyJWUnFvX3WdpegD5xcppKv3afR72/qFrJXKzNowNFJmZd3sfIQVPSzjP6+Wr
         YioNRpvN14dTSZen6cI0nfz1KSoOv7YC4zSGEOc2dTqc3l0RsBRWifCZzDmCaa6ioCxh
         1V3SQQxdUUE5x/wnM9y/q9pgEsBw0Vxp87oUc8NliTG1bP0rNI0iANVmkiSARHf3l4Qw
         0ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687464198; x=1690056198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3177D2gAzh/TeV5rsITAvPzX0EvWliaupFIrZiwcQgU=;
        b=CzYf9YUu3MwOzfbk1AV/LeaB4qdlMIkolRDdxr+4K7/IGP+4UvU+F3KzcUhoZkPOfz
         dLSW/xMz0JPi7NZVtJPyL+N0/PRg4jMyYbzXId23WMpKV2wzyJqCPaWLeXjL5hlj7CpO
         /OzkrNG3fPX6ixuU+7gPQskvGg9IIyIxoCKwsIcIRbMZKmCpIejn03aeXjkEUl8hRd96
         A4mSV/y6k6FB570bf4Bpo2ObKh3AvSk5C/Vz9Y3/KTHVnR8fUE+tP/vsp7oR/L3T4orr
         BU7Mq25l4c+B6Cb52hdmBGO1d6pufw0tHV344c6GVbRjEB2o1Z6Eh91OgTGpZFh3C0E4
         SveQ==
X-Gm-Message-State: AC+VfDyXNp7HEYxiCUU2V1uSjPx9UE8bu38GIJEYgmvZe76+P2NbwbJO
        /hTBSVKQ/YxsXjDn3i7TAqI=
X-Google-Smtp-Source: ACHHUZ6crq2VsaP9wDkpkR+RTiTCArAxscpqktlsgquWXOY01GQ9oDt/9KlKLECD8we2CNW/R2Sgog==
X-Received: by 2002:a17:903:442:b0:1b1:d39e:28bb with SMTP id iw2-20020a170903044200b001b1d39e28bbmr14380110plb.34.1687464198196;
        Thu, 22 Jun 2023 13:03:18 -0700 (PDT)
Received: from yoga ([2400:1f00:13:f188:5597:fb56:d39:775f])
        by smtp.gmail.com with ESMTPSA id m14-20020a170902db0e00b001b045c9abd2sm5746924plx.143.2023.06.22.13.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:03:17 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Fri, 23 Jun 2023 01:33:10 +0530
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] Add support for Firefox's gecko profile format
Message-ID: <ZJSo/uzJNyfcflNY@yoga>
References: <cover.1687375189.git.anupnewsmail@gmail.com>
 <a44290cc-5954-8d5a-f84c-9e5a68732ea4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44290cc-5954-8d5a-f84c-9e5a68732ea4@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 07:43:13AM +0300, Adrian Hunter wrote:
> On 21/06/23 22:35, Anup Sharma wrote:
> > This patch series adds support for Firefox's gecko profile format.
> > The format is documented here [1]
> > 
> > The series adds a new python script that can be used to convert the 
> > perf script to gecko profile format. To use this script, use the
> > following commands: 
> > 
> > perf record 
> > perf script -F +pid > perf_data.txt
> > python3 firefox-gecko-converter.py > gecko_profile.json
> 
> Why not use the perf script python interface?

Hi Adrian,
Thank you for your suggestion. I am working on it and will try to implement 
it in the next version.

> https://perf.wiki.kernel.org/index.php/Latest_Manual_Page_of_perf-script-python.1
> 
> > 
> > Also dont forget to change the chown of the output file to the user[2].
> > 
> > [1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
> > [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1823421
> > 
> > Anup Sharma (9):
> >   scripts: python: Add check for correct perf script format
> >   scripts: python: implement add sample function and return it
> >   scripts: python: Introduce thread sample processing in
> >     convertPerfScriptProfile
> >   scripts: python: Implement parsing of input data in
> >     convertPerfScriptProfile
> >   scripts: python: implement function for thread creation
> >   scripts: python: implement get or create stack function
> >   scripts: python: implement get or create frame function
> >   scripts: python: Finalize convertPerfScriptProfile and return profile
> >     data
> >   scripts: python: Add temporary main function for testing purposes
> > 
> >  .../scripts/python/firefox-gecko-converter.py | 249 ++++++++++++++++++
> >  1 file changed, 249 insertions(+)
> >  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py
> > 
> 
