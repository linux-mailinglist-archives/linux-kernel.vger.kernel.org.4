Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A6F6CABCE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjC0RZq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 13:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0RZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:25:44 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453335BC;
        Mon, 27 Mar 2023 10:25:43 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id r11so39287560edd.5;
        Mon, 27 Mar 2023 10:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OVLlopepnUHjlsBsGHfIJFC5O1WltNhIUmleYbqMCA=;
        b=iBJKQdiC6gABfGdAvqk6R/Cot2YBNx8vNr/cKK8HFbzSrw8ViBRB+jDOOa5CUUAjXP
         VhhOzPKoN70qbClsJfdQe8IaCqcedRnrwqlgzfHuPy8gnHsYVNEW5+pRKCh2pVIMUDAd
         PdkTlcrbl5H1ZnC7vEwS65VgWtvy53wb0a/MEFbAa+2pVewmkEtYG1DreV45Hkd7JYv2
         XJac+L5ls4vm4GYsWnslXy5I9/3DY1sgZunj9BfMR48wy3IcRVspXrJL9pvViKe1ncVN
         bX8RK7+/kDKU9ghauEXfKBCRh/BoFGxEVjtb9/DIi0kCKNGtc3pnaBis4iqDLgYOFvCw
         Rk5A==
X-Gm-Message-State: AAQBX9dRpzR1w/ptsEmq3tFmxlq8Jaboykw7bZ8hRMcTxJlticGuGo2o
        pv2mu5M42VntSIga2omYLqUmPdpQUPWmVdb71z0=
X-Google-Smtp-Source: AKy350YeZuhs9hlWqY4Ok2hmaM4JzbG/reuovlmjCSpSqp4H4rf81r4Qtd+Ui4Waz4mo8UMFl4gQXV+x1MKEtqvYo54=
X-Received: by 2002:a50:d6d6:0:b0:4fb:c8e3:1adb with SMTP id
 l22-20020a50d6d6000000b004fbc8e31adbmr6050643edj.3.1679937941987; Mon, 27 Mar
 2023 10:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230316013307.322402-1-luoxueqin@kylinos.cn>
In-Reply-To: <20230316013307.322402-1-luoxueqin@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 19:25:30 +0200
Message-ID: <CAJZ5v0jUHtt9_px6tNfv77nAMYE=pd67r9sAV=+RwVZFyqwC=w@mail.gmail.com>
Subject: Re: [PATCH v2] PM: tools: add "CPU killed" messages to fix an error
 in suspend flow
To:     Xueqin Luo <luoxueqin@kylinos.cn>
Cc:     rafael@kernel.org, todd.e.brandt@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiongxin@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 2:33 AM Xueqin Luo <luoxueqin@kylinos.cn> wrote:
>
> On the arm64 platform, the core log of cpu offline is as follows:
>
> [  100.431501] CPU1: shutdown
> [  100.454820] psci: CPU1 killed (polled 20 ms)
> [  100.459266] CPU2: shutdown
> [  100.482575] psci: CPU2 killed (polled 20 ms)
> [  100.486057] CPU3: shutdown
> [  100.513974] psci: CPU3 killed (polled 28 ms)
> [  100.518068] CPU4: shutdown
> [  100.541481] psci: CPU4 killed (polled 24 ms)
>
> And this goal of this patch is to prevent sleepgraph from mistakenly
> treating the "CPU up" message as part of the suspend flow (because it
> should be regarded as part of the resume flow).
>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>
> v2: update changelog
>
>  tools/power/pm-graph/sleepgraph.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
> index 82c09cd25cc2..d816970b0a3d 100755
> --- a/tools/power/pm-graph/sleepgraph.py
> +++ b/tools/power/pm-graph/sleepgraph.py
> @@ -4132,9 +4132,12 @@ def parseKernelLog(data):
>                         elif(re.match('Enabling non-boot CPUs .*', msg)):
>                                 # start of first cpu resume
>                                 cpu_start = ktime
> -                       elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)):
> +                       elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)) \
> +                               or re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)):
>                                 # end of a cpu suspend, start of the next
>                                 m = re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)
> +                               if(not m):
> +                                       m = re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)
>                                 cpu = 'CPU'+m.group('cpu')
>                                 if(cpu not in actions):
>                                         actions[cpu] = []
> --

Applied as 6.4 material with some edits in the subject and changelog.

Thanks!
