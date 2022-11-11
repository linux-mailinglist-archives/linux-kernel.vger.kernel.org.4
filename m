Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22486253CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiKKG26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiKKG2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:28:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56B283B9D;
        Thu, 10 Nov 2022 22:24:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 345F8B823E5;
        Fri, 11 Nov 2022 06:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5470FC433D6;
        Fri, 11 Nov 2022 06:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668147857;
        bh=pkd1UMY1+PxMpOoIYB08XNTmO7gcxgR+oayIFFqp0eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wuMutlAr/0jdY13rBGAh2TLEPAoo+1XsSFmcYgyZZmYPCwPnBDAczgVT/ULWnLQB4
         GtVwSaV8WnLBQeecqAVjrhuW33xPOOpvstBv91P+bWXfwawRiwdn0rFD4tUKwLFc/S
         sdmbqIq9QgnyqFOkVb7yjmD9qi7hXuQy5EtkPzJk=
Date:   Fri, 11 Nov 2022 07:24:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Message-ID: <Y23qjcMmerVuKFdj@kroah.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
 <Y2H8oh7AvYDiMqKs@kroah.com>
 <722b05a1-4bf5-0837-baea-b1d0a9cc1e43@quicinc.com>
 <Y2MKWOihjAPxfl6v@kroah.com>
 <96238455-73b6-bead-0fdb-55ca68e5bf0b@quicinc.com>
 <9dd597d9-a3f3-48f2-8416-b5b097a230d5@app.fastmail.com>
 <980db147-794e-ecd9-9626-64ff81109bab@quicinc.com>
 <95a9f253-984a-14e0-7e01-f168452576c4@quicinc.com>
 <543d95f8-be31-7553-4700-5dc04872e8ea@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543d95f8-be31-7553-4700-5dc04872e8ea@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:03:10PM -0800, Elliot Berman wrote:
> > Agree, tools can be updated and that is the easy part as we grow the s/w
> > stack around Gunyah in userspace, like we already do w/ CrosVM (Virtual
> > Machine Manager) and QEMU will be next followed by rust-vmm. All of them
> > can be done without Gunyah ioctls relying anything on the KVM ioctls.
> > Elliot has also explained very well that we don't to go to KVM
> > maintainers for any of our additions and we also don't want them to come
> > to us, since there is no interoperability testing. It is best that both
> > Hypervisors and their Linux interfaces evolve independently.
> 
> Are above explanations reasonable to not re-use KVM ioctl numbers?

Try getting close at least, where possible please.  As your ioctl
numbers didn't even start at 0, it's a bit odd...

thanks,

greg k-h
