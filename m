Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED390731ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbjFOOGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344716AbjFOOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0605B1BE8;
        Thu, 15 Jun 2023 07:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 963D4629A6;
        Thu, 15 Jun 2023 14:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F76C433C8;
        Thu, 15 Jun 2023 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686837996;
        bh=2HWxn6SgFtrNnxm9GSS8Rtq52vTNyCTVVqs90CZgSGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpR36luzMbFukaoYSxIo/2ySvXZ9EI94ww6JPoZMp9yWn31FB5/1Jc+/1VCbSY/ed
         xm7JCcRRg7tG5aCgWpZ765U8UWEq/1DZFZF0WW6EFcuYvS4QejYWGHzrK8LmHnV9g1
         JMqUL53yXK4Pw9ebkLssTsQF9JW28YovjMw72+0E=
Date:   Thu, 15 Jun 2023 16:06:33 +0200
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
Message-ID: <2023061548-subtly-cackle-8be2@gregkh>
References: <cover.1683265984.git.quic_schowdhu@quicinc.com>
 <2259ab0348282349e88905ea99bcb4aa815d941f.1683265984.git.quic_schowdhu@quicinc.com>
 <2023061542-reformed-unholy-10a3@gregkh>
 <cc9750f3-c85c-be7f-e63c-0fcf4eb160f0@quicinc.com>
 <2023061515-unbuckled-consonant-e207@gregkh>
 <5d9ab90f-4fc3-26c6-141e-e9388ac2f0cf@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9ab90f-4fc3-26c6-141e-e9388ac2f0cf@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 07:17:34PM +0530, Souradeep Chowdhury wrote:
> > > > > +static ssize_t ready_read(struct file *filp, char __user *userbuf,
> > > > > +			  size_t count, loff_t *ppos)
> > > > > +{
> > > > > +	int ret = 0;
> > > > > +	char *buf;
> > > > > +	struct dcc_drvdata *drvdata = filp->private_data;
> > > > > +
> > > > > +	mutex_lock(&drvdata->mutex);
> > > > > +
> > > > > +	if (!is_dcc_enabled(drvdata)) {
> > > > > +		ret = -EINVAL;
> > > > > +		goto out_unlock;
> > > > > +	}
> > > > > +
> > > > > +	if (!FIELD_GET(BIT(1), readl(drvdata->base + dcc_status(drvdata->mem_map_ver))))
> > > > > +		buf = "Y\n";
> > > > > +	else
> > > > > +		buf = "N\n";
> > > > > +out_unlock:
> > > > > +	mutex_unlock(&drvdata->mutex);
> > > > > +
> > > > > +	if (ret < 0)
> > > > > +		return -EINVAL;
> > > > > +	else
> > > > 
> > > > You do the "lock, get a value, unlock, do something with the value"
> > > > thing a bunch, but what prevents the value from changing after the lock
> > > > happens?  So why is the lock needed at all?
> > > 
> > > The lock is used to prevent concurrent accesses of the drv_data when
> > > scripts are being run from userspace.
> > 
> > How would that matter?  The state can change instantly after the lock is
> > given up, and then the returned value is now incorrect.  So no need for
> > a lock at all as you really aren't "protecting" anything, or am I
> > missing something else?
> 
> This lock is needed to protect the access to the global instance of drv_data
> structure instantiated at probe time within each individual callbacks of
> debugfs.

What exactly are you "protecting" here that could change in a way that
cause a problem?

You aren't returning a value that is ever guaranteed to be "correct"
except that it happened sometime in the past, it might be right anymore.

thanks,

greg k-h
