Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4DE5FAE91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJKIkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJKIkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:40:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813A4C629;
        Tue, 11 Oct 2022 01:40:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f23so12583688plr.6;
        Tue, 11 Oct 2022 01:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=stD9RetreA6pMH+h5I7/aCirn6VqDL5duR4zBb4PDuU=;
        b=gLxZrUtsS/AJ3LkHGuuw1XWpmk1r9cM0/Z6lImO3WPV+dSTjEgH/dCAK7kVffOhB8n
         L+J1l2CQX908ATwS9pHCVRBddQI1QKvZiHsf5g7mlDPc9U0GSCZTA5X/viGg5Xak/TKv
         Bmp009OneeNAwj1bec6kFL/1d0vV1CZgDPwYLvZb6bmyJNi7B4fYAWRlWjDvyqqzY/Rb
         ToPQDoLf3pogzIKHZk64131CibRGIQLKUchypMSU0rNXZa9nZvVYbRLPTU6AaKBUa0ge
         reCQbayKWa/YNC9t4q2M06L/k8Ra4DB/7zfwV/qTenhd8vTfynMzMX4178o6bRgb6WKY
         SPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stD9RetreA6pMH+h5I7/aCirn6VqDL5duR4zBb4PDuU=;
        b=vmQxCqEv+AZyok0WjL02HCNk+aOawD9xgWRAcvnMyI6tcdzkmuZoDO1g+fvhygQvUS
         6Oa1dM46eoC6E5hjLR3AA9SKZzTEpMo7f+SXBRpVO/0Phn5ESWLP/Jaf+vpAd5JibG+6
         6h3vip5MjznTR0/tkwzMNNUkzF6YP/vrwp5gJiBPbA/8k/bMVOIUl22wajn+zTZZzrcG
         p4+btXQ/BDQj7KDNIdJhN3Go3zGmr6GFinDo9zm0kD4hqpnNYVrNQCrGf/UECt4GgeCt
         q+/kYkd2jrReSxVCNz0cU9e/Rv9bq8cPuvv2VFrXjQLIRfzfYrUgpzWb68PkvSJltX+4
         6kPw==
X-Gm-Message-State: ACrzQf2QjQEVcBCmKGyZJuFUi9Cs9ydc0DI1MfoYN9yAqqF+Kl5ZukFo
        WjdnwE4R7UDITPCo+sjIqjaqXdZcJ3e4Kf6NYvo=
X-Google-Smtp-Source: AMsMyM6g1HZaYMcm+/efklZexQujvE7zaamnKJB9hHvEyDGF6nyu7k7gzF5xJUIwOCYyq4f4lDmew/s6r8BtTuedGXI=
X-Received: by 2002:a17:902:9a49:b0:17a:6662:9334 with SMTP id
 x9-20020a1709029a4900b0017a66629334mr22529280plv.63.1665477630463; Tue, 11
 Oct 2022 01:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221011063043.11074-1-wenchao.chen666@gmail.com> <beae901e-0fcd-c4ae-8a6e-a1a4357078da@intel.com>
In-Reply-To: <beae901e-0fcd-c4ae-8a6e-a1a4357078da@intel.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Tue, 11 Oct 2022 16:40:19 +0800
Message-ID: <CA+Da2qwe96J_EyJCG04UX5GBEsoU0mckWktPyTrZARk-XHAo0w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix minimum clock limit
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 2:45 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 11/10/22 09:30, Wenchao Chen wrote:
> > From: Wenchao Chen <wenchao.chen@unisoc.com>
> >
> > The minimum clock supported by SPRD Host is 100000.
>
> Commit messages are better if they say why a change
> is being made.
>
> This begs the question, was there a problem with 400 kHz?
> Are there cases that benefit from this change?
> Should it have a fixes tag,cc stable?
>

Code show as below:
static struct sdhci_ops sdhci_sprd_ops = {
...
.get_min_clock = sdhci_sprd_get_min_clock,
...
};

int sdhci_setup_host(struct sdhci_host *host)
{
...
if (host->ops->get_min_clock)
mmc->f_min = host->ops->get_min_clock(host);
...
}

static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
void mmc_rescan(struct work_struct *work)
{
...
for (i = 0; i < ARRAY_SIZE(freqs); i++) {
unsigned int freq = freqs[i];
if (freq > host->f_max) {
if (i + 1 < ARRAY_SIZE(freqs))
continue;
freq = host->f_max;
}
if (!mmc_rescan_try_freq(host, max(freq, host->f_min)))
break;
if (freqs[i] <= host->f_min) // If you start at 100K, you will try
400K, 300K, 200K, 100K.
break;
}
...
}

Our controller supports 100K. During the test, it was found that mmc_rescan
failed to scan the card at 400K, and did not try 300K, 200K, and 100K. After
modifying the minimum clock limit to 100K, the card scan was successful.

> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> >  drivers/mmc/host/sdhci-sprd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index 46c55ab4884c..b92a408f138d 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -309,7 +309,7 @@ static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
> >
> >  static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
> >  {
> > -     return 400000;
> > +     return 100000;
> >  }
> >
> >  static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,
>
