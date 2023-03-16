Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582A86BD2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCPOwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjCPOw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD45A6776
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678978304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tw7bSBZTDd8cVyjfcwvHc6Vcof/hpUltsviHy1kMWEE=;
        b=cD1PFyUh/RfovpSLEQajzHcLJKi3YkoVr5C8SXoq8nyNLrFKWz+KyRjs0mF8Nec2EmfcpY
        0rgAeZh9njgPzVU8fDU9uXEJfwyQ8yh4KY6LaCe+AOnIZ3CMwU+sWRGByp+OC3wahNzwdV
        mUevsTs+0utoQ9MnGnJ7ul0iTCEMTjA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-bp4oQmO6PI-k9jdrV0gJEA-1; Thu, 16 Mar 2023 10:51:35 -0400
X-MC-Unique: bp4oQmO6PI-k9jdrV0gJEA-1
Received: by mail-ed1-f70.google.com with SMTP id fi8-20020a056402550800b004a26cc7f6cbso3429349edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678978294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tw7bSBZTDd8cVyjfcwvHc6Vcof/hpUltsviHy1kMWEE=;
        b=rPkx1b1O7Hrv6MV5fJYsr4/Rys/0eGn5KvrVjpbkfrEdUfKtk8aM2mmcZCo1SkcJz7
         nXxpH9Dw0aW+aeCO/0YMDePhb93RdbhFdiQAViL3+W+Iyyi/OOxErqLhokvxeDt8hpq6
         HY1CgPfNOZAjOm13YMBoyUOVA6tthQ8beWVxDi+KU/acl+F1mqJhTYQI/a3BmLyva0Al
         flTgIBegWeq3RcU3/12+Sm6ddXCyRz90qteNaQydBdyHjMPx+E7+BHfDM7KJs+YhRKJG
         sw70+xgjqyaZNH89+yC1QpasqXpgFMR/1mS7KxX9RxLr4NQ+r41Etp7hgXu9+F5K5Y+H
         jHmw==
X-Gm-Message-State: AO0yUKU4DXSmNGMoUZRAI8Yqfzu044RUHVFOrfL/oI7RP1i2Xmp7KC8n
        wW+d8+/eFru3BIKJQuiKlYCW/8IjgQV9Ykoc8Kf6G9CxinyrRt7S5FyL1GMZBbnOz+rf12CNYYj
        mglvt9PFJ7Im8bGSFcPYU2KRk
X-Received: by 2002:aa7:c054:0:b0:4fd:2290:976d with SMTP id k20-20020aa7c054000000b004fd2290976dmr6470157edo.37.1678978294720;
        Thu, 16 Mar 2023 07:51:34 -0700 (PDT)
X-Google-Smtp-Source: AK7set+mrk3Nm9NsulO9ENFABZHkvrVnMLNqkm9qS0VvveoRKRDSsvz7a3U/ks0RHgBltwlRZzuygg==
X-Received: by 2002:aa7:c054:0:b0:4fd:2290:976d with SMTP id k20-20020aa7c054000000b004fd2290976dmr6470138edo.37.1678978294414;
        Thu, 16 Mar 2023 07:51:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t14-20020a508d4e000000b004fc01b0aa55sm3971676edt.4.2023.03.16.07.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 07:51:33 -0700 (PDT)
Message-ID: <2d8d484d-55d6-446e-10af-49be3f2f0f7c@redhat.com>
Date:   Thu, 16 Mar 2023 15:51:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 00/11] Intel pmc_core: Enable telemetry
Content-Language: en-US, nl
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20230315183405.2465630-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230315183405.2465630-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 3/15/23 19:33, David E. Box wrote:
> On Intel SoCs, registers for the Power Management Controller are available
> in the PCI BAR of the SSRAM device, 0000:14.2. On Meteor Lake, these
> registers are structured in Intel PMT Telemetry regions which could be
> handled by the pmt_telemetry driver. This series adds APIs to the
> intel_vsec and pmt_telemetry drivers so that pmc_core driver can both
> create the telemetry instance from the SSRAM device and register for a
> handle to read the telemetry which contains the low power mode requirements
> for the S0ix states supported by Meteor Lake. The series also adds some
> fixes.

Thank you for the series. I notice that none of these patches have a Reviewed-by nor a Tested-by from some other Intel developers.

It really helps if you can get someone other Intel kernel people to review and test your patches and then add their tags before posting a large(ish) series like this upstream.

Regards,

Hans





> 
> David E. Box (6):
>   platform/x86/intel/vsec: Explicitly enable capabilities
>   platform/x86/intel/vsec: Add base address field
>   platform/x86/intel/pmt: Add INTEL_PMT module namespace
>   platform/x86/intel/pmt: telemetry: Add telemetry read functions
>   platform/x86/intel/pmt/telemetry: Add driver version
>   platform/x86/intel/pmc: Add Intel PMT support for MTL PMC
> 
> Gayatri Kammela (1):
>   platform/x86/intel/vsec: Add intel_vsec_register
> 
> Rajvi Jingar (1):
>   platform/x86/intel/pmc: Alder Lake slp_s0_residency fix
> 
> Xi Pardee (3):
>   platform/x86:intel/pmc: Combine core_init and core_configure function
>   platform/x86:intel/pmc: Move get_low_power_modes function
>   platform/x86/intel/pmc/mtl: get LPM information using Intel PMT
> 
>  drivers/platform/x86/intel/pmc/Kconfig     |   1 +
>  drivers/platform/x86/intel/pmc/adl.c       |  17 +-
>  drivers/platform/x86/intel/pmc/cnp.c       |  17 +-
>  drivers/platform/x86/intel/pmc/core.c      |  71 +++++---
>  drivers/platform/x86/intel/pmc/core.h      |  24 +--
>  drivers/platform/x86/intel/pmc/icl.c       |  11 +-
>  drivers/platform/x86/intel/pmc/mtl.c       | 187 ++++++++++++++++++-
>  drivers/platform/x86/intel/pmc/spt.c       |  11 +-
>  drivers/platform/x86/intel/pmc/tgl.c       |  17 +-
>  drivers/platform/x86/intel/pmt/class.c     |  48 +++--
>  drivers/platform/x86/intel/pmt/class.h     |  35 ++--
>  drivers/platform/x86/intel/pmt/crashlog.c  |   3 +-
>  drivers/platform/x86/intel/pmt/telemetry.c | 199 ++++++++++++++++++++-
>  drivers/platform/x86/intel/pmt/telemetry.h | 120 +++++++++++++
>  drivers/platform/x86/intel/vsec.c          | 131 ++++++--------
>  drivers/platform/x86/intel/vsec.h          |  64 ++++++-
>  16 files changed, 790 insertions(+), 166 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h
> 
> 
> base-commit: 02c464b73645404654359ad21f368a13735e2850

