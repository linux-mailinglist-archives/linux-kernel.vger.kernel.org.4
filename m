Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D7262DFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbiKQPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbiKQPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:21:29 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ECF490B9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:19:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so490596pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=54/qpLgKvMYRxZZN8WRThBEEYZ9T1CEvYfUVPrQm8ww=;
        b=iMSmmJd/PxvPh5Sz4Mhlv1D7h60/wqpXa0IlfaaP18ffK5JF15qrDhUVUrU0mPM8j5
         +yh01SuAl11IdhGv9HRnwbEbasiIbUwNJEroOSBoHC0PSRXsMxFlfF8m0vO27W0kb1Pm
         KpWAdkZ8OeO3IpRpd7GTMe3WaNU7LXQu8BNCDaNhWSHry1EDfm4x45qAKDcZTJ20US1O
         HaNzNoB5jQwXfuuGssFqSarSg2xv7H8v2ew9s7NTFe7wL3tI+gGTER+rUYg94g+fS9ez
         W2tfqJxdHRLZU8/vA1csfuG18K2GHHfSzgBem4hC01N5DJZYllLM7dekVdhJHFeniQQy
         KmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54/qpLgKvMYRxZZN8WRThBEEYZ9T1CEvYfUVPrQm8ww=;
        b=ObfcJ7EY69MCqTIsNDu4c+L7ptjGwxkuINJ1DUwod3zQiwtJGhjOGxS+QYJlgWrj4M
         9uW7PHQknvUTkfSR/LRKnXWjphbmRmEnvwe4E/WaNAsJSXha6sA2TDHkl1Ep7n25x9jI
         6D4ZPLAEweaqiZu32JzaKaI8seH3H5300keuWrk28iXshcHGtflHC8atG5cxpYns6Ufl
         sMwrjEkQsP9hkbqW3l1I+cmzhwY7nk7a8UcUrYYZEAvhXIl6CKuEKTBUMwJG1+R5wbrs
         2m2njzYZTGI2W9iY3Js9k6fppkXGOEMCDYupwk0Wik+Sw6SK1b7auWca8VaIEBe2DMPz
         XdpQ==
X-Gm-Message-State: ANoB5plI9nvCFZJWvdeSpcrv3Gt94xSHcuFEYZV55taPJHhX2VGQATR+
        ekrV46XJML8UwyQ0sLaWtzHFYQ==
X-Google-Smtp-Source: AA0mqf4wrBLIgo7T2s4WuThT5jIfJYx8a5rV1w04DyLTsZXzfk7fRoTfBUBdt+cr0oVtZWuIShH4JQ==
X-Received: by 2002:a17:902:cf05:b0:186:de22:7968 with SMTP id i5-20020a170902cf0500b00186de227968mr3286934plg.3.1668698366550;
        Thu, 17 Nov 2022 07:19:26 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b4-20020a62cf04000000b005668b26ade0sm1242098pfg.136.2022.11.17.07.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:19:25 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:19:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 2/2] KVM: arm64: selftests: Disable single-step without
 relying on ucall()
Message-ID: <Y3ZQ+fCobB4DOc+S@google.com>
References: <20221117002350.2178351-1-seanjc@google.com>
 <20221117002350.2178351-3-seanjc@google.com>
 <Y3WF8YlvFm8NGYHd@google.com>
 <Y3WMeovid9z1qOjD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3WMeovid9z1qOjD@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022, Sean Christopherson wrote:
> On Thu, Nov 17, 2022, Oliver Upton wrote:
> > On Thu, Nov 17, 2022 at 12:23:50AM +0000, Sean Christopherson wrote:
> > > Automatically disable single-step when the guest reaches the end of the
> > > verified section instead of using an explicit ucall() to ask userspace to
> > > disable single-step.  An upcoming change to implement a pool-based scheme
> > > for ucall() will add an atomic operation (bit test and set) in the guest
> > > ucall code, and if the compiler generate "old school" atomics, e.g.
> > 
> > Off topic, but I didn't ask when we were discussing this issue. What is
> > the atomic used for in the pool-based ucall implementation?
> 
> To avoid having to plumb an "id" into the guest, vCPUs grab a ucall entry from
> the pool on a first-come first-serve basis, and then release the entry when the
> ucall is complete.  The current implementation is a bitmap, e.g. every possible
> entry has a bit in the map, and vCPUs do an atomic bit-test-and-set to claim an
> entry.
> 
> Ugh.  And there's a bug.  Of course I notice it after sending the pull request.
> Depsite being defined in atomic.h, and despite clear_bit() being atomic in the
> kernel, tools' clear_bit() isn't actually atomic.  Grr.
> 
> Doesn't cause problems because there are so few multi-vCPU selftests, but that
> needs to be fixed.  Best thing would be to fix clear_bit() itself.

Ha!  And I bet when clear_bit() is fixed, this test will start failing again
because the ucall() to activate single-step needs to release the entry _after_
exiting to the host, i.e. single-step will be enabled across the atomic region
again.
