Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B7F644220
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiLFL2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiLFL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:28:25 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2063826572;
        Tue,  6 Dec 2022 03:28:25 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id z17so7175404qki.11;
        Tue, 06 Dec 2022 03:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeeEJH9IRZK8HHT54nLXyLNMrjxjZafXXUbNp3o5qoE=;
        b=cqmgPFJr2aQ+Lg/icUwWMNZCSMK5YoiaiyuoFcMjpBGQaJ/kb7hNFWN6OruD6vToeZ
         cYg/8szxnrQ5n1fMxI8VPdCc+9NWgm/V8rGjkv6w9TqRTs0AXlUMis298KTVN8wprtd7
         shw/GRcmSlp2N/fhRlXw7DEzYQi7A0e5zm1sR+V7tSfK1A7FwP29PhYUnK2bZhi5uLpc
         EtQ00zZ0WB5x17InkGJEwxqXU8vWHkLX2GWodc6SYF2re03+CTM5YcgjjATQvLlW/Gq+
         kNy+H3+BBMy0tG4iqkJJuoKmFtzcYkTwGDosFnXz1JHG8uzHPaW7IXXmP0IjMMt85wBJ
         zyhg==
X-Gm-Message-State: ANoB5plHOWZvdRFQSi3tE+vL325guIyknR945OKvx4yuelCkKgnBa/MK
        2LyCJVrcmdf6eKdGEZcw/qjD9pUs4Sy5RmYGwrM=
X-Google-Smtp-Source: AA0mqf5leT1oNTUOXgYn90wCf5uc7sgn9Vsiq5hLjDDBWCPENAK++ChQRiifj2q3jegBPFmbkW80Sv6H7zfHrbBj6ac=
X-Received: by 2002:a37:b901:0:b0:6ec:2b04:5099 with SMTP id
 j1-20020a37b901000000b006ec2b045099mr63446879qkf.501.1670326104231; Tue, 06
 Dec 2022 03:28:24 -0800 (PST)
MIME-Version: 1.0
References: <202212061615227896127@zte.com.cn> <20221206084558.kv7y4mmkuccrojgg@vireshk-i7>
In-Reply-To: <20221206084558.kv7y4mmkuccrojgg@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Dec 2022 12:28:12 +0100
Message-ID: <CAJZ5v0gzMnjdyWpD4h7TsChwckUiKM_2z86TnUSjm_XLT3ENZw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: stats: Convert to use sysfs_emit_at() API
To:     Viresh Kumar <viresh.kumar@linaro.org>, ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 9:46 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 06-12-22, 16:15, ye.xingchen@zte.com.cn wrote:
> > From: ye xingchen <ye.xingchen@zte.com.cn>
> >
> > Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> > should only use sysfs_emit() or sysfs_emit_at() when formatting the
> > value to be returned to user space.
> >
> > Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> > ---
> >  drivers/cpufreq/cpufreq_stats.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index 1570d6f3e75d..55c7ffd37d1c 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -128,25 +128,23 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> >       ssize_t len = 0;
> >       int i, j, count;
> >
> > -     len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
> > -     len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
> > +     len += sysfs_emit_at(buf, len, "   From  :    To\n");
> > +     len += sysfs_emit_at(buf, len, "         : ");
> >       for (i = 0; i < stats->state_num; i++) {
> >               if (len >= PAGE_SIZE)
> >                       break;
> > -             len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
> > -                             stats->freq_table[i]);
> > +             len += sysfs_emit_at(buf, len, "%9u ", stats->freq_table[i]);
> >       }
> >       if (len >= PAGE_SIZE)
> >               return PAGE_SIZE;
> >
> > -     len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> > +     len += sysfs_emit_at(buf, len, "\n");
> >
> >       for (i = 0; i < stats->state_num; i++) {
> >               if (len >= PAGE_SIZE)
> >                       break;
> >
> > -             len += scnprintf(buf + len, PAGE_SIZE - len, "%9u: ",
> > -                             stats->freq_table[i]);
> > +             len += sysfs_emit_at(buf, len, "%9u: ", stats->freq_table[i]);
> >
> >               for (j = 0; j < stats->state_num; j++) {
> >                       if (len >= PAGE_SIZE)
> > @@ -157,11 +155,11 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> >                       else
> >                               count = stats->trans_table[i * stats->max_state + j];
> >
> > -                     len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ", count);
> > +                     len += sysfs_emit_at(buf, len, "%9u ", count);
> >               }
> >               if (len >= PAGE_SIZE)
> >                       break;
> > -             len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> > +             len += sysfs_emit_at(buf, len, "\n");
> >       }
> >
> >       if (len >= PAGE_SIZE) {
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --

Applied as 6.2 material, thanks!
