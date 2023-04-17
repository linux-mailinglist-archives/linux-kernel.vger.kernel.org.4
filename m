Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695866E4184
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDQHms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDQHmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1508A4214;
        Mon, 17 Apr 2023 00:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A52F561F74;
        Mon, 17 Apr 2023 07:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4E0C433EF;
        Mon, 17 Apr 2023 07:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681717322;
        bh=Zg/jj40UpH5idr0dgDZO07sFlRLu/zjIZ7KPRZ04H04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzYZFKQ2N2q6qo3pF+kh4PI94d6zdvu+0z7pDbq0Hydmt2I8neVSH+83Dh8/Lvku2
         LAbYuoC0bZKzqqIp1FLSm2SPW4J5ccFo4W8TQQRA3F7EfakiWhCkqVwcJH0sXH0pcU
         xMn1IH4ov3v9hVa0beWgtuIvpJgB36I90SotUuOU=
Date:   Mon, 17 Apr 2023 09:41:57 +0200
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
Subject: Re: [PATCH V1 2/3] drivers: misc: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Message-ID: <ZDz4RcQ1sFpynxop@kroah.com>
References: <cover.1681480351.git.quic_schowdhu@quicinc.com>
 <b1a9cbbcfefe133cc9047a71a2acdaa74239df29.1681480351.git.quic_schowdhu@quicinc.com>
 <ZDo4jIIV7cfPD2qW@kroah.com>
 <f3196d7a-50f0-9bfb-71a6-47ddb9686039@quicinc.com>
 <ZDzkkNQP5eO2vcxA@kroah.com>
 <7c46fe45-70b4-1f20-5ab4-cd51917d04a8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c46fe45-70b4-1f20-5ab4-cd51917d04a8@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 12:26:23PM +0530, Souradeep Chowdhury wrote:
> On 4/17/2023 11:47 AM, Greg Kroah-Hartman wrote:
> > On Mon, Apr 17, 2023 at 11:31:46AM +0530, Souradeep Chowdhury wrote:
> > > On 4/15/2023 11:09 AM, Greg Kroah-Hartman wrote:
> > > > > +static void dcc_create_debug_dir(struct dcc_drvdata *drvdata)
> > > > > +{
> > > > > +	int i;
> > > > > +	char list_num[10];
> > > > > +	struct dentry *list;
> > > > > +	struct device *dev = drvdata->dev;
> > > > > +
> > > > > +	drvdata->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
> > > > 
> > > > You are creating a directory at the root of debugfs with just your
> > > > device name?  While that will work, that feels very odd.  Please use a
> > > > subdirectory.
> > > 
> > > This is as per the comment on v17 of the patch series on DCC
> > > 
> > > https://lore.kernel.org/linux-arm-kernel/6693993c-bd81-c974-a903-52a62bfec606@ieee.org/
> > > 
> > > "You never remove this dcc_dbg directory.  Why not?
> > > 
> > > And since you don't, dcc_dbg could just be a local
> > > variable here rather than being a global.  But it
> > > seems to me this is the root directory you want to
> > > remove when you're done."
> > 
> > But that's not the issue.  The issue is that you are putting into
> > /sys/kernel/debug/ a flat namespace of all of your devices.  Is that
> > really what you want?  If so, why do you think this will never conflict
> > with any other device in the system?
> 
> Since we are going by the dev_name here which also contains the address
> as per the example in the yaml binding, this will not conflict with other
> dev_names in the system.

That is not true at all.  dev_names are only unique per bus type.  There
is nothing preventing any other bus from using the same name for their
device as yours.

So please, for the sake of your own sanity, just create a directory and
dump all of your devices into it.  And for the sake of all of ours, as
making the root of debugfs full of random device names is a mess, don't
you think?  What would happen if all drivers did that?

> > > As per upstream discussions it was decided that debugfs will be a suitable
> > > interface for DCC. More on this in the following link:-
> > > 
> > > https://lore.kernel.org/linux-arm-kernel/20221228172825.r32vpphbdulaldvv@builder.lan/
> > 
> > debugfs is not a suitable interface for anything that is "real" as
> > that's not what it is there for.  Most systems disable debugfs entirely
> > (i.e. Android), or prevent any normal user from accessing it, so this
> > api you are creating will not be able to be used by anyone.
> > 
> > debugfs is for debugging, not for anything that the system functionality
> > relies on to work properly.
> 
> DCC is a debugging hardware which stores the values of the configured
> register address on a system crash on it's dedicated sram. These register
> addresses are configured by the user through the debugfs interface. Also on
> the platforms where debugfs is disabled there is an alternative of using
> bootconfig suggested to configure the register values during boot-time.
> There is an ongoing patch series for that as follows:-
> 
> https://lore.kernel.org/linux-arm-kernel/cover.1675054375.git.quic_schowdhu@quicinc.com/T/

But again, debugfs is not even mounted in most systems, so how are they
going to interact with your hardware?  Restricting it to debugfs feels
very odd to me, but hey, it's your code, I guess you don't want anyone
to use it :)

good luck!

greg k-h
