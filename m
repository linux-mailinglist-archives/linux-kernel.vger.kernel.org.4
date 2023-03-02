Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB58F6A7B57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjCBGWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCBGWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:22:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F002C64E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:22:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so1685713pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 22:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PA16CYwgLHtTJC6J+i3zkra58SYe5m6n4UeJlr0V+ck=;
        b=rHf5mvQjSbynBAHM66iSN5narRVS9ZYjGCYMNG4Prgrei9ItH8wA7/ajmoAID23LEc
         X+fnp5nFIWfqGVdxoKYvsMK/S7LbwmALDMUmjKazyPmexnW/+pr4oBgQB3IimfPChXJw
         wzg8RdKpX13YEs4xx0ghxbSH/5KZ8/wPDrOGiMqkrFfnBHh57HZGUNr2nxntV17z+THH
         lormf0i/tjI0xzlMQNuo8O6QZVeClGv06SlXC9N80PizZjTVOVBwOnHw4npI2PdWWRK1
         DHzQ55DAgfJM0j4Ppr1ZOUEYvjXTjg7zwHibT0/42Vbw1tvYbLMswOlak1s8m03wU56E
         I97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PA16CYwgLHtTJC6J+i3zkra58SYe5m6n4UeJlr0V+ck=;
        b=j5FMRVWD8qJGOsh/Z0A9O1hmJApJnPzl6JzpinCcYBmdmXf5xlo8REknEJjzXODicy
         XB/yxk5ceHdDYVVuwvjLFgKmwKItaXkPAMGeC3FgJSKCbCrukPGKoKZ8jBBKTgInAgJK
         5L1wquUt4QEdfnUQdwLN7Tnh4uWsoXSYMgPX04EGNU5AI7KkV7Hr/ufPrCFb2ajvvxLq
         aVvmYx888tzgIs3fMi7f5qeJ5GInAvoyquVifJr2dSzmAOxRRQf8UwKGl+BhiuhfamLf
         bKZNLPoKepZESSUvsDp40b9wRNkdcMiX+tUlxEykvVZYKNSGbburgwswmf5XOlU0bSpj
         3opQ==
X-Gm-Message-State: AO0yUKXbH0K7xgyrvYgHuUm/Jnwkk1s5O0h11IXZzTC7vb8OEwBX31tp
        8ceLNFNb2sJQem8ZAg34dRh4Vg==
X-Google-Smtp-Source: AK7set8JpOlRSw10uf53oa6shjrsMJafm929r7BWJOvH3HbE7aetRWx1gSeCjYurz/YVbMoeceHIcg==
X-Received: by 2002:a17:902:ecd2:b0:19c:d7a9:8be1 with SMTP id a18-20020a170902ecd200b0019cd7a98be1mr10865377plh.61.1677738120663;
        Wed, 01 Mar 2023 22:22:00 -0800 (PST)
Received: from leoy-huanghe ([156.146.45.203])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b0019cb6222698sm9437169plz.266.2023.03.01.22.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 22:22:00 -0800 (PST)
Date:   Thu, 2 Mar 2023 14:21:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/14] perf kvm: Add dimensions for KVM event
 statistics
Message-ID: <ZABAgcaBHhD22uHw@leoy-huanghe>
References: <20230228115125.144172-1-leo.yan@linaro.org>
 <20230228115125.144172-9-leo.yan@linaro.org>
 <CAM9d7cgEZ4ugAfef8hDKOr11xF7QP1w7-Ax3mnDr4XXmYr0DoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgEZ4ugAfef8hDKOr11xF7QP1w7-Ax3mnDr4XXmYr0DoQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Tue, Feb 28, 2023 at 03:34:28PM -0800, Namhyung Kim wrote:

[...]

> > +static struct kvm_dimension dim_event = {
> > +       .name           = "name",
> > +       .cmp            = empty_cmp,
> > +};
> 
> I guess you can name it as 'dim_name' to reduce the confusion.
> Also it can compare event names using strcmp() in case users
> want to see event names in alphabetical order.

I will rename as 'ev_name' or 'event_name'; and it's good point to
compare the name with string order.  Will do it.

[...]

> [SNIP]
> > +
> > +static int kvm_hists__init_output(struct perf_hpp_list *hpp_list, char *name)
> > +{
> > +       struct kvm_fmt *kvm_fmt = get_format(name);
> > +
> > +       if (!kvm_fmt) {
> > +               reset_dimensions();
> > +               return output_field_add(hpp_list, name);
> 
> Hmm.. do you plan to support these generic output fields too?
> I'm not sure you need reset_dimensions() here.

So far, we don't need to add any generic output field, I will remove
reset_dimensions() / output_field_add(), alternatively, in next spin I
will simply print an error info and return -EINVAL.

> > +       }
> > +
> > +       perf_hpp_list__column_register(hpp_list, &kvm_fmt->fmt);
> > +       return 0;
> > +}
> > +
> > +static int kvm_hists__init_sort(struct perf_hpp_list *hpp_list, char *name)
> > +{
> > +       struct kvm_fmt *kvm_fmt = get_format(name);
> > +
> > +       if (!kvm_fmt) {
> > +               reset_dimensions();
> > +               return sort_dimension__add(hpp_list, name, NULL, 0);
> 
> Ditto.

Will do the same change with the above statement.

[...]

> > +static int kvm_hpp_list__parse(struct perf_hpp_list *hpp_list,
> > +                              const char *output_, const char *sort_)
> > +{
> > +       char *output = output_ ? strdup(output_) : NULL;
> > +       char *sort = sort_ ? strdup(sort_) : NULL;
> > +       int ret;
> > +
> > +       ret = kvm_hpp_list__init(output, hpp_list, kvm_hists__init_output);
> > +       if (ret)
> > +               goto out;
> > +
> > +       ret = kvm_hpp_list__init(sort, hpp_list, kvm_hists__init_sort);
> > +       if (ret)
> > +               goto out;
> > +
> > +       /* Copy sort keys to output fields */
> > +       perf_hpp__setup_output_field(hpp_list);
> 
> I think you also need perf_hpp__append_sort_keys() as in
> setup_sorting() to have secondary sort keys in case the
> given sort key cannot determine the ordering.

Will do.

Thanks a lot for reviewing!

Leo
