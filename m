Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC46617352
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKCAT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiKCAT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:19:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831909FEC;
        Wed,  2 Nov 2022 17:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C96FB82521;
        Thu,  3 Nov 2022 00:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43080C433C1;
        Thu,  3 Nov 2022 00:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667434792;
        bh=Tst9FZn+PSNvZMX9r7WTW29UtRFXetjshyspQF5HoVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbCp5Ez2LUzxaW6vzzzQG5CEC+aJfHviHZBhbml/Jr6xAa4IaGLlLO/KXub/ZUnk7
         D52q7DFLkrKw/pgLQqI7sB00OUfUiWLuHy5+Whve8McIREr4unOSxLOcrSLtohQ1PD
         Wda5XdSeeAznGV3U5S2KZTPNemCoGXtw8sw8+qak=
Date:   Thu, 3 Nov 2022 01:20:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
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
Message-ID: <Y2MJYEqnJONvH0fY@kroah.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
 <c1f86c53-1d9f-4faf-9313-de86d33e3739@app.fastmail.com>
 <7c59a115-36c5-c954-5610-ef5ef1dbb83e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c59a115-36c5-c954-5610-ef5ef1dbb83e@quicinc.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:44:51AM -0700, Elliot Berman wrote:
> 
> 
> On 11/2/2022 12:31 AM, Arnd Bergmann wrote:
> > On Wed, Oct 26, 2022, at 20:58, Elliot Berman wrote:
> > 
> > > +static const struct file_operations gh_vm_fops = {
> > > +	.unlocked_ioctl = gh_vm_ioctl,
> > > +	.release = gh_vm_release,
> > > +	.llseek = noop_llseek,
> > > +};
> > 
> > There should be a .compat_ioctl entry here, otherwise it is
> > impossible to use from 32-bit tasks. If all commands have
> > arguments passed through a pointer to a properly defined
> > structure, you can just set it to compat_ptr_ioctl.
> > 
> 
> Ack.
> 
> > > +static long gh_dev_ioctl_create_vm(unsigned long arg)
> > > +{
> > > +	struct gunyah_vm *ghvm;
> > > +	struct file *file;
> > > +	int fd, err;
> > > +
> > > +	/* arg reserved for future use. */
> > > +	if (arg)
> > > +		return -EINVAL;
> > 
> > Do you have something specific in mind here? If 'create'
> > is the only command you support, and it has no arguments,
> > it would be easier to do it implicitly during open() and
> > have each fd opened from /dev/gunyah represent a new VM.
> > 
> 
> I'd like the argument here to support different types of virtual machines. I
> want to leave open what "different types" can be in case something new comes
> up in the future, but immediately "different type" would correspond to a few
> different authentication mechanisms for virtual machines that Gunyah
> supports.

Please don't add code that does not actually do something now, as that
makes it impossible to review properly, _AND_ no one knows what is going
to happen in the future.  In the future, you can just add a new ioctl
and all is good, no need to break working userspace by suddenly looking
at the arg value and doing something with it.

thanks,

greg k-h
