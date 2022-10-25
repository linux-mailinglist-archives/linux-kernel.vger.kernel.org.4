Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD15360D23E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJYRHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiJYRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:07:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00633152015
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:07:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g62so8417565pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=napLP0njighkCcO4W1DZOY6rgUMs4xcUsx9lyU2OHdk=;
        b=gPOSE8m2CJTzYky/bqt3bvTv2GqxLf0g5LzYFNecRaGofPocb4j5dbAh/8jSFL4e/A
         aJoAGa7c2trrl3i19O3tj/5uDwjfXF6vplhXyO0+nUuSIY01QD0yBp3J+cQDxrK+Zgzo
         w//NsicbvHJrxIdq+dAP9smd2hZHaWyKmf1Ht6/Diga2rt3N3LgOSU4q4u5bir1jCZQB
         SYQn9KKKIMAVXyCmeQp0TAe02+PBOQkjpldxpW4D6Wn7LRkCgFOIBZcYoYkKbjPguy8B
         Q9h3Yg2e9Hbgatqg7PAG66+F3/V04tKE9v/oIf8MLPlNTYV5P7h8L957K6kQLRFswCGa
         1NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=napLP0njighkCcO4W1DZOY6rgUMs4xcUsx9lyU2OHdk=;
        b=j0GdowF1UBtw9GHwgwlgeqVIxe3Wk0uN2WK8nAEAZ3cUbtp3naAvjdtKdJFNfujaAG
         aowNE5+aqPcHDQ6O1sRdyrhs2BjGs4eJlRc0LItCXKYNsXxdGSN5988aeli7sSyYAyMX
         sXVCDKWkrihhMYRKlFeEhNvyaRv4m77cO9qzYe5Sn1DexyvuYF7iuywDEZRX6RhBWhZS
         Dpc7QPwLnsdRJe27/MkVPLD3IivTynUiCJffDbf10amntwjPa7wClRj9mSOKhHeb9HtY
         TMuAgxwxgzVApqIGx/eIz6bg24KAbOKlD126IaobqZ9k68+8NaGn3mJ1Lecz1EaJzA3g
         JUrA==
X-Gm-Message-State: ACrzQf2STu2PL5tPBRLnX+XGjqEztyysedMXdPgw8D5xYbulYUn14XRj
        AVmzKpzqicCT+OL45AeI6XRGGaW1jg4bAQ==
X-Google-Smtp-Source: AMsMyM6I6vLBD3d3/4wDmQWDD3rOE2C/HNRN5WzdWxYdwhclsUQhL1e+6B6e+wGDNL2Or2lbcChJcQ==
X-Received: by 2002:a63:b59:0:b0:434:2374:6d12 with SMTP id a25-20020a630b59000000b0043423746d12mr33575235pgl.311.1666717621393;
        Tue, 25 Oct 2022 10:07:01 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id jc20-20020a17090325d400b001830ed575c3sm1437993plb.117.2022.10.25.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 10:07:00 -0700 (PDT)
Date:   Tue, 25 Oct 2022 17:06:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Mi, Dapeng1" <dapeng1.mi@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>
Subject: Re: [PATCH] KVM: x86: disable halt polling when powersave governor
 is used
Message-ID: <Y1gXseyl0f3IUnDh@google.com>
References: <20220915073121.1038840-1-dapeng1.mi@intel.com>
 <Y0BnKIW+7sqJbTyY@google.com>
 <PH0PR11MB48240C29F1DEBC79EA933285CD5E9@PH0PR11MB4824.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB48240C29F1DEBC79EA933285CD5E9@PH0PR11MB4824.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022, Mi, Dapeng1 wrote:
> > > +				!strncmp(policy->governor->name,
> > "powersave",
> > 
> > KVM should not be comparing magic strings.  If the cpufreq subsystem can't get
> > policy->policy right, then that needs to be fixed.
> 
> Yeah, using magic strings looks a little bit strange, but this is what is
> cpufreq doing.  Currently cpufreq mechanism supports two kinds of drivers,
> one is the driver which has the built-in governor, like intel_pstate driver.
> For this kind of driver, the cpufreq governor is saved in the policy->policy
> field. The other is the traditional driver which is independent with cpufreq
> governor and the cpufreq governor type is saved in the governor->name field.
> For the second kind of cpufreq driver, the policy->policy field is
> meaningless and we have to read the governor name. 

That doesn't mean it's ok to bleed those internal details into KVM.  I would much
rather cpufreq provide a helper to get the effective policy, e.g.

  unsigned int cpufreq_cpu_get_policy(unsigned int cpu)
  {
	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
	unsigned int pol;

	if (!policy)
		return CPUFREQ_POLICY_UNKNOWN;

	pol = policy->policy
	if (pol == CPUFREQ_POLICY_UNKNOWN && policy->governor)
		pol = cpufreq_parse_policy(policy->governor->name);

	cpufreq_cpu_put(policy);
  }
