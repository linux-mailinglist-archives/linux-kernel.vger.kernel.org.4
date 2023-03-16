Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5D6BCB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCPJvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCPJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7035B5ADEE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678960216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=huowlZPUW6H0KxMkpbfx9CP3sZ4JPlEUrwvUVboQxVY=;
        b=V86xFdeYoMaN5s0OkSm1RYXc/RTTy19SrDpGfua3eTPyqr4dMZqPX/VHUQU+1cIt2XPRRJ
        GZcH4hQCYgenx7otnhuoYmQb63OY+PuBQy4K++GGrC9cejpl6hfqobO4TYTxEUMLPI/KX3
        wK4mTa0ItzDm19LZPXm6Ztcok0KEd5M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-iez7HG_8OpO1PqI9Qntd9Q-1; Thu, 16 Mar 2023 05:50:15 -0400
X-MC-Unique: iez7HG_8OpO1PqI9Qntd9Q-1
Received: by mail-ed1-f71.google.com with SMTP id fi8-20020a056402550800b004a26cc7f6cbso2261619edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678960214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huowlZPUW6H0KxMkpbfx9CP3sZ4JPlEUrwvUVboQxVY=;
        b=md31wR18vZv6ftsLsspbhfyZCj+a9skdvqjcroutybZpeF3w50r+Bubh2h0oTAVIbS
         wNk2q2L1lbKCPaMuEdbx/7N0RigibH2RNbDXEDZLLV4xIJFPrayTKQxLQdtxUCrSIQqm
         nCb+ChDbo8FIQ46JFR29Fef1KJ1sQoARyiWicoxY3tDtT/kIRDVNcO2DVkb7iCauPDxt
         A18Wx0To/rBIpYmfksIF70pdiPVD6Qdzo/hFnTopmTV6ITs6sknUSZj7nGdn0Wk/s0W+
         E9d0INPlLVM+78+hvbnntETLKyS4wj05XwNVF5v1+gdJgXWV62Pm+/6I+maM29q02RRx
         RlKg==
X-Gm-Message-State: AO0yUKWTrOIWzaBW4oMQhb3xBsi6gymKGro9yRIA4elVLs6tFmGM/ggZ
        qmNAhH2lBYzH7+9zdHpogsGBGVikIuwbokAroQ8yFbsyIypS1e+zTQWoVVk7Y7n75RWvdny8lvg
        kkgygo+Eg74RHDS4ofZNFEJry
X-Received: by 2002:a17:907:1690:b0:878:481c:c49b with SMTP id hc16-20020a170907169000b00878481cc49bmr13813185ejc.1.1678960214280;
        Thu, 16 Mar 2023 02:50:14 -0700 (PDT)
X-Google-Smtp-Source: AK7set942yrVQ/Wj8al0sXYB+EAScOmstJzvOpb3F2mvsPMw1ODTqzHzTDJWX8nNO14vzK8gKsbNHA==
X-Received: by 2002:a17:907:1690:b0:878:481c:c49b with SMTP id hc16-20020a170907169000b00878481cc49bmr13813155ejc.1.1678960213985;
        Thu, 16 Mar 2023 02:50:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lm15-20020a170906980f00b0093034e71b94sm750503ejb.65.2023.03.16.02.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 02:50:13 -0700 (PDT)
Message-ID: <076097bc-1e7e-72d9-efa9-79d6a94d3f0a@redhat.com>
Date:   Thu, 16 Mar 2023 10:50:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 4/8] platform/x86/intel/ifs: Introduce Array Scan test
 to IFS
Content-Language: en-US, nl
To:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-5-jithu.joseph@intel.com>
 <7f82f241-39ee-15e0-1ae7-e98e50730c95@redhat.com>
 <275d2f04-782f-2c9d-187a-7a510bf34f41@redhat.com>
 <SJ1PR11MB60831C996C2EC462262948CDFCB99@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <363aa89e-de06-6fc4-e396-d8cc311017b9@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <363aa89e-de06-6fc4-e396-d8cc311017b9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/15/23 20:29, Joseph, Jithu wrote:
> 
> 
> On 3/13/2023 10:21 AM, Luck, Tony wrote:
> 
>>
>>
>> I'm not sure this is better than splitting the tests into different directories.
>>
> 
> To provide a bit more context to Tony's response - 
> There are similarities between tests (one of the test inputs is cpu number , which is 
> common among different tests , so are the test outputs described via status / details attributes)
> and some differences too (distinct to each test are the test patterns, some tests needs to
> load test patterns appropriate for that test type and some does not)
> 
> Current approach of keeping each test's attributes in its own directory (intel_ifs_n)
> allows the driver to account for the differences naturally, for e.g load test file
> suited for a specific test. (I.e if the load is issued from intel_ifs_<n> , the driver
> will load test patterns from /lib/firmware/intel/ifs/ifs_<n>/ff-mm-ss-xx.<type_n>).
> If load is not applicable for a test type , test directory doesn’t show load and image_version attributes). 
> 
> As Tony mentioned, similar effect might be achieved using distinct load / run (and image_version)
> files for each test type, but the current approach of organizing files per test feels a little
> bit more intuitive. 
> 
> Grouping attributes per test was the original design intent , when the first test was introduced,
> as indicated by the existing ABI doc (Documentation/ABI/testing/sysfs-platform-intel-ifs),
> wherein attributes are described under /sys/devices/virtual/misc/intel_ifs_<N>/ …

Ok I see, lets go with 1 intel_ifs device per test-type then.

If I understood things correctly esp. also with the /lib/firmware path then the <N> in intel_ifs_<N> basically specifies the test-type, correct ?

If I have that correct please add this to the ABI documentation in the form of a list with

intel_ifs_<N> <-> test-type

mappings. And also add documentation to each attribute for which test-types the attribute is valid (this can be "all" for e.g. status, to avoid churn when adding more test types).

> Hans, Shall I revise the series incorporating the rest of your comments ?

Yes please.

Regards,

Hans


