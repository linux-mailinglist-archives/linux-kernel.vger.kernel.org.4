Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221CC731932
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbjFOMui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbjFOMug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D40A2126;
        Thu, 15 Jun 2023 05:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA23625F0;
        Thu, 15 Jun 2023 12:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA46C433C8;
        Thu, 15 Jun 2023 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686833434;
        bh=9C0lIysBzhK2NDkLZ8zuWOZP34c6lCF4sNn1JWvzNkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yh4oUiVoqClwbgiExl0clwXIAhBdc+EGfyc1pP8k5YyWihS/NjiHOyXPKOW1APa+0
         jO7L1bcu4ev6Hr9gPCVFxpMPK0L2ECM7+HUo1gVyMTWF669az9mbhAE+ACBvJochTz
         zhZVopAKEqBqa96MZ0tFFhKfstjFskNC9/t1nZQU=
Date:   Thu, 15 Jun 2023 14:50:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V23 2/3] misc: dcc: Add driver support for Data Capture
 and Compare unit(DCC)
Message-ID: <2023061515-unbuckled-consonant-e207@gregkh>
References: <cover.1683265984.git.quic_schowdhu@quicinc.com>
 <2259ab0348282349e88905ea99bcb4aa815d941f.1683265984.git.quic_schowdhu@quicinc.com>
 <2023061542-reformed-unholy-10a3@gregkh>
 <cc9750f3-c85c-be7f-e63c-0fcf4eb160f0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9750f3-c85c-be7f-e63c-0fcf4eb160f0@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:13:53PM +0530, Souradeep Chowdhury wrote:
> 
> 
> On 6/15/2023 4:03 PM, Greg Kroah-Hartman wrote:
> > On Thu, May 04, 2023 at 11:36:22PM -0700, Souradeep Chowdhury wrote:
> > > +/**
> > > + * struct dcc_config_entry - configuration information related to each dcc instruction
> > > + * @base:                    Base address of the register to be configured in dcc
> > 
> > Why is this a u32 and not a bigger size?
> 
> Currently only 32 bit register addresses are supported for DCC
> configuration.
> 
> > 
> > > + * @offset:                  Offset to the base address to be configured in dcc
> > > + * @len:                     Length of the address in words to be configured in dcc
> > 
> > What is a "word" here, 16 bits?
> 
> Each word is 4 bytes(32 bits)

See, I guess wrong, you should say what this is :)

> > > + * @loop_cnt:                The number of times to loop on the register address in case
> > > +				of loop instructions
> > > + * @write_val:               The value to be written on the register address in case of
> > > +				write instructions
> > > + * @mask:                    Mask corresponding to the value to be written in case of
> > > +				write instructions
> > > + * @apb_bus:                 Type of bus to be used for the instruction, can be either
> > > +				'apb' or 'ahb'
> > 
> > How can a bool be either "apb" or "ahb"?
> 
> 1 stands for apb and 0 for ahb. Will update the same here.

Why not have an enum?  Will there ever be another "bus"?

> > > +static ssize_t ready_read(struct file *filp, char __user *userbuf,
> > > +			  size_t count, loff_t *ppos)
> > > +{
> > > +	int ret = 0;
> > > +	char *buf;
> > > +	struct dcc_drvdata *drvdata = filp->private_data;
> > > +
> > > +	mutex_lock(&drvdata->mutex);
> > > +
> > > +	if (!is_dcc_enabled(drvdata)) {
> > > +		ret = -EINVAL;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	if (!FIELD_GET(BIT(1), readl(drvdata->base + dcc_status(drvdata->mem_map_ver))))
> > > +		buf = "Y\n";
> > > +	else
> > > +		buf = "N\n";
> > > +out_unlock:
> > > +	mutex_unlock(&drvdata->mutex);
> > > +
> > > +	if (ret < 0)
> > > +		return -EINVAL;
> > > +	else
> > 
> > You do the "lock, get a value, unlock, do something with the value"
> > thing a bunch, but what prevents the value from changing after the lock
> > happens?  So why is the lock needed at all?
> 
> The lock is used to prevent concurrent accesses of the drv_data when
> scripts are being run from userspace.

How would that matter?  The state can change instantly after the lock is
given up, and then the returned value is now incorrect.  So no need for
a lock at all as you really aren't "protecting" anything, or am I
missing something else?

thanks,

greg k-h
