Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24571728F3B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 07:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjFIFKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 01:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFIFKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 01:10:09 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6A1984
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 22:10:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b0314f057cso3549135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 22:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686287408; x=1688879408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F32J5EQyGM5sr7NBbMoJM1nRy1dBiIUJo1x8SMu+nBU=;
        b=zB5Ijip6uCx/v57hjO6khTEBIGPhpDdiKszzs1mSw9Z+GWcVEe58+58etMY6ln16St
         4Eq3e73HFeQ+3rYaAdjjC/9MImefcdJs4CNfAey3/VFj4on9qtIXvMoMv+1CJqsT8UJS
         +P/oDOLJf4v/uGNNJ890CtZC1Zhp4R2Zb+Ci2gAkBpViUtI14rhS+wKiyQcQobtL6Wfh
         l+g4WIMsWRhw2pjBGwkCTmPzO5LrxSHQweueUY90fh5oWRlM1yWGF9r+hm7brcSQ6JUV
         ZPpMUhiLG0IlbD1jTjWb3EG0jBzEIzvqMwoJvoaI+q49hijyTo9NWC0y5ZZOH5MXdZ+L
         8qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686287408; x=1688879408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F32J5EQyGM5sr7NBbMoJM1nRy1dBiIUJo1x8SMu+nBU=;
        b=Ve747hQm/uP6r17WDpQQdcRwLAgCIPYDdfcGdVxk6jO6OUcUm0krbeJ4HG9mgUsBxd
         cuAppaUqgzFW4G4PXnLWcPO25SHmtg6nOlw3QGH1QaFFkCA0XPLWYcr0dldEjibK0pwW
         M8p+UaFDd6ND/l1rFD3V1S3LsVBtXcJhbudaWmPyD/xAcUa8wGLLkZhj0OBpmrgh3N3D
         JbF1stI62frCT9ioGBiB8w7kVdTe2m+d/sRMEDVM2buXqSGYJE7MwQn1CUcSay5gzjSp
         FlbT91mWOHNK6fCEoIgGskh9TJN7utoDmS2LNO1OEfEsyDveswTho9cM1RARw1qQNblz
         NUtQ==
X-Gm-Message-State: AC+VfDzX8tq1ULSQywGSl2HGNmlq4L1VpzYxVEz5j5YKg4KJ9JHireVk
        TcFZZWQo6NoQiX91niNfQVgqqOmbh87omdoNlrw=
X-Google-Smtp-Source: ACHHUZ4UrPVCYTWiuYlc0WjJ4KaCUIbKd8nmtQqdMQWcs0QJhycoV1PmGIkULujef3qbIDzKtrEWgQ==
X-Received: by 2002:a17:902:b713:b0:1b1:bf4c:868a with SMTP id d19-20020a170902b71300b001b1bf4c868amr198802pls.42.1686287407868;
        Thu, 08 Jun 2023 22:10:07 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001ae8b4dc49bsm2279971plh.13.2023.06.08.22.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 22:10:07 -0700 (PDT)
Date:   Fri, 9 Jun 2023 10:40:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] OPP: Extend dev_pm_opp_data with OPP provider
 support
Message-ID: <20230609051005.fxuvp4ilcjvhhrkc@vireshk-i7>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-14-ulf.hansson@linaro.org>
 <20230608053446.ngoxh7zo7drnr32z@vireshk-i7>
 <CAPDyKFqUWhdmctKRpQoqwZ2nsx_P2FiWvLzfm_d39QdECWoytA@mail.gmail.com>
 <20230608104540.tykxtvwhoyogthw5@vireshk-i7>
 <CAPDyKFrbpm0W1Hdv+85MqMAC2-UbPOE6qp26L0UvVF0sSL2ayA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrbpm0W1Hdv+85MqMAC2-UbPOE6qp26L0UvVF0sSL2ayA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-06-23, 13:45, Ulf Hansson wrote:
> Okay, if I understand your point you want to avoid creating OPPs for
> each device, but rather coupling them with the genpd provider's OPP
> table. Right?

Not exactly :)

> Note that, there is no such thing as a "required opp" in the SCMI
> performance protocol case. A device is compatible to use all of the
> OPPs that its corresponding SCMI performance domain provides. Should
> we rename the required opp things in the OPP core to better reflect
> this too?

Not really :)

> That said, we still need to be able to add OPPs dynamically when not
> based on DT. The difference would be that we add the OPPs when
> initializing the genpd provider instead of when attaching the devices.
> In other words, we still need something along the lines of the new
> dev_pm_opp_add_dynamic() API that $subject series is introducing, I
> think.

That's fine.

> Moreover, to tie the consumer device's OPP table to their genpd
> provider's OPP table (call it required-opp or whatever), we need
> another OPP helper function that we can call from the genpd provider's
> ->attach_dev() callback. Similarly, we need to be able to remove this
> connection when genpd's ->detach_dev() callback is invoked. I will
> think of something here.

Something like set/link/config_required_opp()..

> Finally, I want to point out that there is work going on in parallel
> with this, that is adding performance state support for the ACPI PM
> domain. The ACPI PM domain, isn't a genpd provider but implements it's
> own PM domain. The important point is, that it will have its own
> variant of the dev_pm_genpd_set_performance_state() that we may need
> to call from the OPP library.

Okay.

Let me explain how structures are linked currently with help of below (badly
made) drawing. The 'level' fields are only set for Genpd's OPP entries and not
devices. The genpd OPP table normally has only this information, where it
presents all the possible level values, separate OPP for each of them.

Now the devices don't have `level` set in their OPP table, DT or in C
structures. All they have are links for required OPPs, which help us find the
required level or performance state for a particular genpd.

  +-----------------+                    +------------------+
  |  Device A       |                    | GENPD OPP Table  |
  +-----------------+  required-opps     +------------------+   required-opps
  |OPP1: freq: x1   +--------------------+ OPP1:            +--------------+
  +-----------------+                    |      level: 1    |              |
  |OPP2: freq: y1   +-----------+        +------------------+              |
  +-----------------+           |        | OPP2:            +---------+    |
  |OPP3: freq: z1   +--------+  +--------+      level: 2    |         |    |
  +-----------------+        |           +------------------+         |    |
                             |           | OPP3:            +--+      |    |
                             |           |      level: 3    |  |      |    |
                             |           +------------------+  |      |    |
  +-----------------+        |           | OPP4:            |  |      |    |
  |  Device B       |        +-----------+      level: 4    |  |      |    |
  +-----------------+                    +------------------+  |      |    |
  |OPP1: freq: x2   +------------------------------------------+      |    |
  +-----------------+                                                 |    |
  |OPP2: freq: y2   +-------------------------------------------------+    |
  +-----------------+                                                      |
  |OPP3: freq: z2   +------------------------------------------------------+
  +-----------------+


What I am asking you to do now is, create an OPP table for the Genpd first, with
OPPs for each possible level. Now the Genpd layer creates the OPP table for
Device A, where it won't fill the levels, but all other fields and then use a
new API to add required OPPs for the device's OPP, which will point into Genpd's
OPP entries. And with that the existing code will work fine without any other
modifications.

Does this help ?

--

viresh
