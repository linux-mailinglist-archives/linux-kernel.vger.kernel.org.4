Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D3561735D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiKCAYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKCAYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE0E60D5;
        Wed,  2 Nov 2022 17:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5820661CE1;
        Thu,  3 Nov 2022 00:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185E0C433D7;
        Thu,  3 Nov 2022 00:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667435040;
        bh=UexGygkWb0bGtw2UM0ZjgXrlEJjm3frSfcJCq0INPNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjKbU6IhfMUx+o1ufnCQAmcEuO5CEdisP9B5Qkx4RXE5Cpyvm0UtFX6rrU+zIMTgD
         sYg5NLJ72WjViycClrYCyl1jT/tMeTeokobqPMoRU6JVQnZWcAvIkUBRW9/pUwow1Q
         4LSOIqHHuf9KsAMtE+ZS/kKA5zZXWUsdn+TTAP/4=
Date:   Thu, 3 Nov 2022 01:24:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     mec@shout.net, Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Message-ID: <Y2MKWOihjAPxfl6v@kroah.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
 <Y2H8oh7AvYDiMqKs@kroah.com>
 <722b05a1-4bf5-0837-baea-b1d0a9cc1e43@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722b05a1-4bf5-0837-baea-b1d0a9cc1e43@quicinc.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:45:12AM -0700, Elliot Berman wrote:
> +Michael
> 
> On 11/1/2022 10:14 PM, Greg Kroah-Hartman wrote:
> > On Wed, Oct 26, 2022 at 11:58:38AM -0700, Elliot Berman wrote:
> > > +#define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x40) /* Returns a Gunyah VM fd */
> > 
> > Why 0x40?  Why not just use the same KVM ioctl numbers and names as you
> > are doing the same thing as them, right?
> 
> We've designed so that there are a few ioctls that will feel similar to KVM
> ioctls since we know this design has been successful, but we don't intend to
> support KVM ioctls 1:1. Gunyah has different semantics for many of the
> name-identical ioctls. It seems odd to mix some re-used KVM ioctls with
> novel Gunyah ioctls?

Even if you don't support it 1:1, at least for the ones that are the
same thing, pick the same numbers as that's a nicer thing to do, right?

> > Normally your first ioctl is "0x01", not "0x40", so this feels really
> > odd.
> > 
> 
> Documentation/userspace-api/ioctl/iocl-number.rst advises to pick an unused
> block. We picked ioctl code 'G' and unused sequence numbers under that code.
> I'm ok to move the block around.

How do you know you picked an unused block?  It wasn't obvious where you
got these values from at all, and unfortunatly, no one really ever
updates that documentation file.  Luckily it never really matters.

thanks,

greg k-h
