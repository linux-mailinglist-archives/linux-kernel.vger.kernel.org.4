Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1705E9BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiIZIHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiIZIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:07:07 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6521E3E;
        Mon, 26 Sep 2022 01:05:33 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so3247169wms.3;
        Mon, 26 Sep 2022 01:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=P1Mpxj6IEYIvMHzYEzmI74M/4VNUKksFgyVJ3+3UxaQ=;
        b=x81WeQhLmTufP0ol7OLwAq4Jc2Yy6OtffD30Lq5KEpu9fZNixPrOI3LOa69+L5gbn7
         +Gfqgq7pXyUMYBE06Qg8dlyiwFFWbmXIEVkS2U+mBeJwWUA0iYUKiEqfusaqfXmu0zmn
         tYHd+H3Fem5vrAEznHb/ct3iuif6O1UEzKf8kIFEHsU/UNafAxoYW+eDMPOmsP/IsfDS
         Fgt4QK5KX9uzRpo7nvOZTk09PYNG4++qHs6oYg2OJ3VI2GNTjBxM30cs2qLz0MxPx5JD
         snSy/xI93ESWpGedoIRvIDEeIPXQ33+2cf2vWhqoNwGjthfBJgePQxoDJKo1YXRRQG2J
         s3Fw==
X-Gm-Message-State: ACrzQf0iZAA8HnqsDyq/z8ckPvHlPVWbJuoTsVcplX/h873X5S0wQvTI
        ZpO0cM4ZlHAWRcc80ghDtVdYQ8f5POE=
X-Google-Smtp-Source: AMsMyM6dyW2X+h6o8RJFgmLvjLUL6aI8WuE6TJ6Bxrs8xm4ambjtA3pUODmWiWUyAj1V7cU0ty49MA==
X-Received: by 2002:a05:600c:3483:b0:3b4:99f4:1191 with SMTP id a3-20020a05600c348300b003b499f41191mr13715762wmq.147.1664179532186;
        Mon, 26 Sep 2022 01:05:32 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c27d200b003b4868eb6bbsm12212696wmb.23.2022.09.26.01.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:05:31 -0700 (PDT)
Message-ID: <a87d481e-adb7-b4e3-518b-2c4276d906e7@kernel.org>
Date:   Mon, 26 Sep 2022 10:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 3/3] perf lock: Print the number of lost entries for
 BPF
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <songliubraving@fb.com>,
        Blake Jones <blakejones@google.com>
References: <20220802191004.347740-1-namhyung@kernel.org>
 <20220802191004.347740-3-namhyung@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220802191004.347740-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02. 08. 22, 21:10, Namhyung Kim wrote:
> Like the normal perf lock contention output, it'd print the number of
> lost entries for BPF if exists or -v option is passed.  Currently it
> uses BROKEN_CONTENDED stat for the lost count (due to full stack maps).
...
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
...
> @@ -73,6 +73,9 @@ int enabled;
>   int has_cpu;
>   int has_task;
>   
> +/* error stat */
> +unsigned long lost;

I don't know how all this is generated into lock_contention.skel.h. But 
I believe this patch breaks perf build on 32bit:
> [  375s] In file included from util/bpf_lock_contention.c:13:
> [  375s] util/bpf_skel/lock_contention.skel.h: In function 'lock_contention_bpf__assert':
> [  375s] util/bpf_skel/lock_contention.skel.h:537:9: error: static assertion failed: "unexpected size of \'lost\'"
> [  375s]   537 |         _Static_assert(sizeof(s->bss->lost) == 8, "unexpected size of 'lost'");
> [  375s]       |         ^~~~~~~~~~~~~~

Should the above (and below too) be __u64?

> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -113,6 +113,7 @@ struct lock_contention {
>   	struct machine *machine;
>   	struct hlist_head *result;
>   	unsigned long map_nr_entries;
> +	unsigned long lost;

thanks,
-- 
js
suse labs

