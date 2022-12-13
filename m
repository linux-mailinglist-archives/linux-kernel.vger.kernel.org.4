Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C488064AFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiLMG0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiLMG0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:26:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE1512AE5;
        Mon, 12 Dec 2022 22:26:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 708BE612BE;
        Tue, 13 Dec 2022 06:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32054C433EF;
        Tue, 13 Dec 2022 06:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670912793;
        bh=ScIS6FleJhQOBgS5pmaN3XxScy/r9zsYFW//Fv9sO7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1YmFeEPYg2d8bSEnHi4tvfWvFBtGi9yxTezJ9VMw+LFT+00h8ewJjAPNU2xabz2Z2
         Qj+K0dCQ5MFn+F6o4513CxxGWERgGc8oIxdabPsuf0trRh+D889Xd2sTznk9IRo+1b
         HYlHDug38huJ10h5I6isichYqQX33UAJQQ8hdkwY=
Date:   Tue, 13 Dec 2022 07:26:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 10/20] gunyah: rsc_mgr: Add resource manager RPC core
Message-ID: <Y5gbFhVpuDoZ2ZmY@kroah.com>
References: <20221121140009.2353512-1-quic_eberman@quicinc.com>
 <20221121140009.2353512-11-quic_eberman@quicinc.com>
 <Y3uYRvrCZNnbDiY5@kroah.com>
 <425a8fe9-24b6-26c7-9150-0d3fb76430be@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425a8fe9-24b6-26c7-9150-0d3fb76430be@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 03:46:53PM -0800, Elliot Berman wrote:
> 
> 
> On 11/21/2022 7:24 AM, Greg Kroah-Hartman wrote:
> > On Mon, Nov 21, 2022 at 05:59:59AM -0800, Elliot Berman wrote:
> > > +struct gh_rm_rpc {
> > > +	struct device *dev;
> > > +	struct gunyah_resource tx_ghrsc, rx_ghrsc;
> > > +	struct gh_msgq msgq;
> > > +	struct mbox_client msgq_client;
> > > +	struct gh_rm_connection *active_rx_connection;
> > > +	int last_tx_ret;
> > > +
> > > +	struct idr call_idr;
> > > +	struct mutex call_idr_lock;
> > > +
> > > +	struct mutex send_lock;
> > > +
> > > +	struct work_struct recv_work;
> > > +};
> > 
> > What handles the reference counting for this object?  Shouldn't this be
> > a real 'struct device' and just have a pointer to the parent?  Otherwise
> > how do you know when to free this?
> > 
> 
> Reference counting is not needed on the gh_rm_rpc object because its only
> client (the VM manager) is torn down before the gh_rm_rpc.

So again, who controls the lifecycle of it?  Where is the reference
count for the structure as it is pointing to reference counted memory?

thanks,

greg k-h
