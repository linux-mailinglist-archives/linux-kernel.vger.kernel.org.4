Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15B7366A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjFTIt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjFTItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE01510F2;
        Tue, 20 Jun 2023 01:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41A6161003;
        Tue, 20 Jun 2023 08:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C407C433C0;
        Tue, 20 Jun 2023 08:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687250980;
        bh=ucG/+ss/pgC/7tMCNrpUOJF6gSvhna+8dtVR7W1ctZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEOjgHqfZNWkYSLHPMwCDt4D4JO00O+4WUOtb5ofmnZ/T8WEi7zUFS5NYoqWAOXSn
         tKCmAKpqKYSh99q3jqJ+ae6X/z+5pXPOUALi+lkUWajeD69Grp0WptTE/UMJSDY1bf
         9PGTY1Fj4p7PVO2UvzBRLNZXEh0ZWbLO34he4Rmc=
Date:   Tue, 20 Jun 2023 10:49:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
Subject: Re: [PATCH v6 09/13] Add nodes for dsb edge control
Message-ID: <2023062000-jaws-extortion-f782@gregkh>
References: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
 <1687246361-23607-10-git-send-email-quic_taozha@quicinc.com>
 <2023062024-sincere-tripod-95dc@gregkh>
 <3aca4a55-0dc7-b34c-d2c0-111a96c33ec3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aca4a55-0dc7-b34c-d2c0-111a96c33ec3@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 04:31:59PM +0800, Tao Zhang wrote:
> 
> On 6/20/2023 3:37 PM, Greg Kroah-Hartman wrote:
> > On Tue, Jun 20, 2023 at 03:32:37PM +0800, Tao Zhang wrote:
> > > Add the nodes to set value for DSB edge control and DSB edge
> > > control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
> > > resgisters to configure edge control. DSB edge detection control
> > > 00: Rising edge detection
> > > 01: Falling edge detection
> > > 10: Rising and falling edge detection (toggle detection)
> > > And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
> > > configure mask. Eight 32 bit registers providing DSB interface
> > > edge detection mask control.
> > > 
> > > Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> > > ---
> > >   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  32 +++++
> > >   drivers/hwtracing/coresight/coresight-tpdm.c       | 143 ++++++++++++++++++++-
> > >   drivers/hwtracing/coresight/coresight-tpdm.h       |  22 ++++
> > >   3 files changed, 196 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> > > index 2a82cd0..34189e4a 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> > > +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> > > @@ -60,3 +60,35 @@ Description:
> > >   		Bit[3] : Set to 0 for low performance mode.
> > >   				 Set to 1 for high performance mode.
> > >   		Bit[4:8] : Select byte lane for high performance mode.
> > > +
> > > +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
> > > +Date:		March 2023
> > > +KernelVersion	6.5
> > > +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> > > +Description:
> > > +		Read/Write a set of the edge control registers of the DSB
> > > +		in TPDM.
> > > +
> > > +		Expected format is the following:
> > > +		<integer1> <integer2> <integer3>
> > sysfs is "one value", not 3.  Please never have to parse a sysfs file.
> 
> Do you mean sysfs file can only accept "one value"?

Yes.

> I see that more than one value are written to the sysfs file
> "trigout_attach".

Then someone missed that and it needs to be fixed.

> > > +static ssize_t dsb_edge_ctrl_show(struct device *dev,
> > > +				       struct device_attribute *attr,
> > > +				       char *buf)
> > > +{
> > > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > +	ssize_t size = 0;
> > > +	unsigned long bytes;
> > > +	int i;
> > > +
> > > +	spin_lock(&drvdata->spinlock);
> > > +	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
> > > +		bytes = sysfs_emit_at(buf, size,
> > > +				  "Index:0x%x Val:0x%x\n", i,
> > Again, no, one value, no "string" needed to parse anything.
> 
> I also see other sysfs files can be read more than one value in other
> drivers.

Again, they are broken, please send patches to fix them.

> Is this "one value" limitation the usage rule of Linux sysfs system?

Yes.

thanks,

greg k-h
