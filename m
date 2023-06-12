Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA07D72B8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjFLHmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjFLHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D97B10E3;
        Mon, 12 Jun 2023 00:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3735661FC8;
        Mon, 12 Jun 2023 07:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC41AC4339E;
        Mon, 12 Jun 2023 07:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686555554;
        bh=MVdRnRhrlhbl8xnpIjlqH8jg3Cbp1KqmCllhJz17e9Y=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=oWe83oGypAiCr3xshi2DRx5t/wqAqJGeq5EIwW7fyalcGhH6i4uhCW9btAKHfd0c5
         FjUD3KhyZsTest07qQw2V82ssuyDiF6IoBRSl3N3fLvJER8OUDdAAaFXlx5Yghhj/i
         GfXVQsFzYgLJL9PCEvgzjDdaaSpshu75CDvH1ryQ5jLk+AVdY4c44G0DkYhZzuAjsa
         4Tsk/nQZ5R9jURjsHG6o2EhDUhgcWfqf3xvmMl+/yDXvDl2c4nutYuvoPOJ0C4KmIi
         7n2qaQXW6RW96YsmU8PgydLRLrAJSIsMtggAkTPk+bHIViHTbk2jMFyfOaXlp9sT6z
         1KoaiHM564LVg==
Date:   Mon, 12 Jun 2023 09:39:10 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sensor-hub: Allow multi-function sensor devices
In-Reply-To: <51dfdee66713e470d9a925ac5a8f8ae1da644462.camel@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2306120938360.5716@cbobk.fhfr.pm>
References: <20230528092427.42332-1-daniel.thompson@linaro.org>  <nycvar.YFH.7.76.2306091742090.5716@cbobk.fhfr.pm> <51dfdee66713e470d9a925ac5a8f8ae1da644462.camel@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2023, srinivas pandruvada wrote:

> > > The Lenovo Yoga C630 has a combined keyboard and accelerometer that 
> > > interfaces via i2c-hid. Currently this laptop either has a working 
> > > keyboard (if CONFIG_HID_SENSOR_HUB is disabled) or a working 
> > > accelerometer. only works on kernels. Put another way, most distro 
> > > kernels enable CONFIG_HID_SENSOR_HUB and therefore cannot work on 
> > > this device since the keyboard doesn't work!
> > > 
> > > Fix this by providing a richer connect mask during the probe. With 
> > > this change both keyboard and screen orientation sensors work 
> > > correctly.
> > > 
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > 
> > Srinivas, are you aware of any multi-function device that this patch 
> > might break?
> I tried two systems, one with ISH and another with external hub. Didn't 
> break anything. I don't have 5+ years old systems, to confirm if it will 
> break something on older systems with external hub.

Thanks a lot. Can I take the above as an equivalent of

	Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

? :)

-- 
Jiri Kosina
SUSE Labs

