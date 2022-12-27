Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D655656D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiL0RDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiL0RDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:03:04 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD52FA1A5;
        Tue, 27 Dec 2022 09:03:02 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id k2so6507100qkk.7;
        Tue, 27 Dec 2022 09:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaq8xsHgqDM4KzPNZJEuqDvWcHT3+RJu15b87slvlnw=;
        b=xwF5WcQTMapFYpSA7vTCWmRfL1xHxRXl9OGhhVMxBttTE/Jt4HJmxHVQp+zw1TniQd
         HDeq7LK2ns0Qj4ZCiesOa1mq4nz2wv+4GgzdXiavtU35WGRURjNp/QV4wsuLhu7jPKwO
         4WjwIIFOS6U3LB1lHvXKqkBCV3+NOYqk1CfMjvQCn+XC5mQILaB589QqQ3lzUf5CaBJD
         odMWHFs4ehCB7jHiQZ8Q+qsfpa3l/rj1QE+/rZQMdOTL0mRpx7ZJxpxN9tzWbY5x8KpL
         YsBMKrTr7r5COadlmCC79A9onyM024hwYxZcpDsWzm4TK82h3kEU2c28W+sNxw/pZK9V
         odmw==
X-Gm-Message-State: AFqh2ko6gG2ObqUY/KYBXW7OdYwOoN9Xl8caeKRjaajcKbLoQPPkWxRw
        r+WxwDc46BHRUhRy33ksfHRIBDRclA+Fwi4sl5lZa4KS
X-Google-Smtp-Source: AMrXdXtgWKHedIB8HjH0UJXYaNYWAORKsS22xlGN2s7fcT7EZilgqGMuSWNHdyDtBGIEptTw1ysUlkxzpSpoOxnasfo=
X-Received: by 2002:a05:620a:5235:b0:6ff:8f5a:1d37 with SMTP id
 dc53-20020a05620a523500b006ff8f5a1d37mr1132510qkb.501.1672160581776; Tue, 27
 Dec 2022 09:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20221221155203.11347-1-ptyadav@amazon.de> <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
 <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
 <2ed9702b67832e3e33ef352808124980206c1e95.camel@linux.intel.com>
 <8e2cc66f7dadcfb04099aac7c4eef0b02075c91b.camel@linux.intel.com>
 <mafs07cycdfh4.fsf_-_@amazon.de> <33dd969d9bdb1eb93f8f2a2167efeb535455cf74.camel@linux.intel.com>
In-Reply-To: <33dd969d9bdb1eb93f8f2a2167efeb535455cf74.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Dec 2022 18:02:50 +0100
Message-ID: <CAJZ5v0hFOA97FAq=CwGXgXTkC8aS_vyHjXuaFUppXktrG62H6w@mail.gmail.com>
Subject: Re: [PATCH 0/2] intel_pstate: fix turbo not being used after a
 processor is rebooted
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Pratyush Yadav <ptyadav@amazon.de>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 5:40 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2022-12-27 at 16:38 +0100, Pratyush Yadav wrote:
> > Hi Srinivas,
> >
> > On Sat, Dec 24 2022, srinivas pandruvada wrote:
> >
> > > On Fri, 2022-12-23 at 10:10 -0800, srinivas pandruvada wrote:
> > > > Hi Pratyush,
> > > >
> > > > On Thu, 2022-12-22 at 11:39 +0100, Pratyush Yadav wrote:
> > > > >
> > > > > Hi Srinivas,
> > > > >
> > > > > On Wed, Dec 21 2022, srinivas pandruvada wrote:
> > > > > > On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav wrote:
> > > > > > > When a processor is brought offline and online again, it is
> > > > > > > unable to
> > > > > > > use Turbo mode because the _PSS table does not contain the
> > > > > > > whole
> > > > > > > turbo
> > > > > > > frequency range, but only +1 MHz above the max non-turbo
> > > > > > > frequency.
> > > > > > > This
> > > > > > > causes problems when ACPI processor driver tries to set
> > > > > > > frequency
> > > > > > > constraints. See patch 2 for more details.
> > > > > > >
> > > > I can reproduce on a Broadwell server platform. But not on a
> > > > client
> > > > system with acpi_ppc usage.
> > > >
> > > > Need to check what change broke this.
> > >
> > > When PPC limits enforcement changed to PM QOS, this broke.
> > > Previously
> > > acpi_processor_get_platform_limit() was not enforcing any limits.
> > > It
> > > was just setting variable. So any update done after
> > > acpi_register_performance_state() call to pr->performance-
> > > > states[ppc].core_frequency, was effective.
> > >
> > > We don't really need to call
> > >         ret = freq_qos_update_request(&pr->perflib_req,
> > >                         pr->performance->states[ppc].core_frequency
> > > *
> > > 1000);
> > >
> > > if the PPC is not changed. When PPC is changed, this gets called
> > > again,
> > > so then we can call the above function to update cpufreq limit.
> > >
> > > The below change fixed for me.
> >
> > Right.
> I think, this is the only change you require to fix this. In addition
> set pr->performance_platform_limit = 0 in
> acpi_processor_unregister_performance().

Not really, because if the limit is set to a lower frequency and then
reset to _PSS[0], it needs to be set back to "no limit".

I'll send a patch for that in a while.
