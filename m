Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EF169958B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBPNSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBPNSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:18:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB6B6EAB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:18:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so5802669pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BasQDVUhurl87t0hpFhoxQNL2hqiCDlndiGLEWf2YIg=;
        b=e6GETn7l2vcxSJQ1UrJXmcgR+LftxMQ2UCF214QnLzEnMcKu4WmHh+XjuFpT7wPRdI
         iCN7fV0o0DQIHwj2S3qBKO9pPeCTRtNFAH+AkKOSZLj3zJSUPshR9ockkYnjSQ77h8Z7
         jK26OGe0mMXDJ7GZ4bTGOfXbwi09PtfAlVTq9KswUGStnKq6D+ezhLs3ZxjcledusDFF
         z0xldEXzhhodYU8oEtTCl63nlpjzATBmCYNfvo9vKcBDXVC/cSEDKmEoAPI4VsNRsIXN
         j8jCeN8kA+5SWYn//gcccLXZ0bfdCOGFDA58daksSy1l2V99BZ1J7SmpE8C9l9n73Y4k
         vtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BasQDVUhurl87t0hpFhoxQNL2hqiCDlndiGLEWf2YIg=;
        b=l+44XTPxZfHGQi6fbossAzxl2tQIqYZX818vNXHMEkSoUVqFInv+dczzoljznns1UA
         alDwWbVws9g+rRVQKvCG/3G0ZMSNq/3dOnqalk/vy4mq3P9SnZgbQQ02EnCr/edimcKL
         LJ2zzwE+UygdWZrE6GHrZmIcKJD3915d6r5R84bRYVSxPLXuG2jEwByBvxkWW/tSGAYJ
         YzcZmn+gE5pTHcuzThelQVXkXKt0UL03DsRCFTXd3NUtfMnCjB8xXxUMfWMQP120OWtO
         eEnneg2ryy7P/+U+leQwlJlRr8h+ODKo402xO6uDHa/i4cvhq76swgdg3YT4qHjrlc3U
         AAfg==
X-Gm-Message-State: AO0yUKWT3/DLVTlG1+DgylUxhZzuCKbrhj24adCitENvQwu1KyXMTFuX
        HPwpJl9b73mvG3O+IPV41gwBug==
X-Google-Smtp-Source: AK7set+IxZ2YhBW4Zz/crU+HiSF+PTucxIXFjy9VXhXjSMp1xKGCq6DYBy28/DhgNw1fbQdcwxKQtg==
X-Received: by 2002:a17:902:fa0e:b0:199:190c:3c15 with SMTP id la14-20020a170902fa0e00b00199190c3c15mr4990981plb.49.1676553499520;
        Thu, 16 Feb 2023 05:18:19 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001994e74c094sm1259307pls.275.2023.02.16.05.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:18:18 -0800 (PST)
Message-ID: <757f143b-0c5d-4dd9-f7a1-5450da3b86b5@bytedance.com>
Date:   Thu, 16 Feb 2023 21:18:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v6 0/4] sched/fair: Improve scan efficiency of SIS
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
 <01eb35f2-4a34-7fbc-da48-c9558dca7212@amd.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <01eb35f2-4a34-7fbc-da48-c9558dca7212@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek, thanks very much for your solid testings!

On 2/7/23 11:42 AM, K Prateek Nayak wrote:
> Hello Abel,
> 
> I've retested the patches with on the updated tip and the results
> are still promising.
> 
> tl;dr
> 
> o Hackbench sees improvements when the machine is overloaded.
> o tbench shows improvements when the machine is overloaded.
> o The unixbench regression seen previously seems to be unrelated
>    to the patch as the spawn test scores are vastly different
>    after a reboot/kexec for the same kernel.
> o Other benchmarks show slight improvements or are comparable to
>    the numbers on tip.

Cheers! Yet I still see some minor regressions in the report
below. As we discussed last time, reducing unnecessary updates
on the idle cpumask when LLC is overloaded should help.

Thanks & Best regards,
	Abel
