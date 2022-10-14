Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1520E5FE9AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJNHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJNHgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:36:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4548F3B470;
        Fri, 14 Oct 2022 00:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3C7EBCE24DF;
        Fri, 14 Oct 2022 07:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C7BC433B5;
        Fri, 14 Oct 2022 07:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665732975;
        bh=RGmNY+AV7OpkSWdyidcLOuMN9jGj4/KAd9M6dyX22ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xp/rvLqUc3qFfbrf1PYk1U34jZ4VzWNsf/8TuqdFFKZUdpapUeMLfiHE6+W/3EkoB
         BUWAkHa4mylMD+k8GNG/Nqx6pCvsJgdzGdhdyV3b9UTaMO9YNxg7bSir/0xYplfPYe
         NJyxbxCvDBIDt6NozQTy6LG14mKChX24VS6vJvuo=
Date:   Fri, 14 Oct 2022 09:36:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
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
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/13] virt: gunyah: Identify hypervisor version
Message-ID: <Y0kRmjjDQPFjPNp8@kroah.com>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-7-quic_eberman@quicinc.com>
 <Y0UJgcc0+AEbHTIM@kroah.com>
 <2f313bf8-b366-e094-b5b6-c601458f5cfa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f313bf8-b366-e094-b5b6-c601458f5cfa@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 04:00:10PM -0700, Elliot Berman wrote:
> On 10/10/2022 11:13 PM, Greg Kroah-Hartman wrote:
> > On Mon, Oct 10, 2022 at 05:08:33PM -0700, Elliot Berman wrote:
> > 
> > EXPORT_SYMBOL_GPL()?  I have to ask.
> 
> typo only :)
> 
> > 
> > But why is it exported at all?  No one is using it in this patch.
> > 
> It's used later in the series by the message queue driver. The idea here now
> is that gunyah.ko is capable of identifying Gunyah and other drivers can
> check if they are individually compatible with the reported version of
> Gunyah.

Then export it when you use it.  If we had taken just half of the
series, then this would be an export that no one used, which is not ok.

thanks,

greg k-h
