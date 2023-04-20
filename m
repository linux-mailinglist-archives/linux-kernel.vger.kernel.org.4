Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC4F6E8AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjDTG6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDTG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49FE2D42;
        Wed, 19 Apr 2023 23:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BA4164557;
        Thu, 20 Apr 2023 06:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB7CC433D2;
        Thu, 20 Apr 2023 06:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681973884;
        bh=A+bLNsF6LzOed0PVhdtMwFsw4F1i3Dt8U4VT0TXawxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehlXKtdn2Z4AN0E9m9LxE/lKyDT2WCXAwbTAmg1gpXjbC6EFgpXTk5ydvz5mhxvor
         CERF7hAHIR0TdRq8gbrT9D8rZaAdzxmkrItm4DUlkRi5hiLzQxC0L7DqyJnqVHqO69
         GIurBMOjzCMO35RSw3wad7GV9FMgl1ZjMarAqriE=
Date:   Thu, 20 Apr 2023 08:58:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Trilok Soni <quic_tsoni@quicinc.com>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V22 2/3] misc: dcc: Add driver support for Data Capture
 and Compare unit(DCC)
Message-ID: <ZEDieaIsf7ptqvHq@kroah.com>
References: <cover.1681829664.git.quic_schowdhu@quicinc.com>
 <e4f41fa61d9dd66f68bbd7650c6fbf96810c3569.1681829664.git.quic_schowdhu@quicinc.com>
 <2023041833-alienate-trash-f4da@gregkh>
 <f1456dd7-5dcf-d91a-459c-65efca4a3444@quicinc.com>
 <50844899-b047-42fd-807a-db7136e5e590@app.fastmail.com>
 <44834c75-4db7-ec8a-9367-c6b83fa96b22@quicinc.com>
 <9808142e-d6e6-71bc-f362-09b878cb3b87@quicinc.com>
 <2024b144-42cf-1044-258c-2dc6c6af0d88@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024b144-42cf-1044-258c-2dc6c6af0d88@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 09:10:14AM -0700, Trilok Soni wrote:
> On 4/19/2023 9:08 AM, Trilok Soni wrote:
> > On 4/19/2023 3:20 AM, Souradeep Chowdhury wrote:
> > > 
> > > 
> > > On 4/19/2023 1:00 PM, Arnd Bergmann wrote:
> > > > On Wed, Apr 19, 2023, at 09:00, Souradeep Chowdhury wrote:
> > > > > On 4/18/2023 9:15 PM, Greg Kroah-Hartman wrote:
> > > > > > 
> > > > > > > The following is the justification of using debugfs
> > > > > > > interface over the
> > > > > > > other alternatives like sysfs/ioctls
> > > > > > > 
> > > > > > > i) As can be seen from the debugfs attribute
> > > > > > > descriptions, some of the
> > > > > > > debugfs attribute files here contains multiple
> > > > > > > arguments which needs to
> > > > > > > be accepted from the user. This goes against the
> > > > > > > design style of sysfs.
> > > > > > > 
> > > > > > > ii) The user input patterns have been made simple
> > > > > > > and convenient in this
> > > > > > > case with the use of debugfs interface as user
> > > > > > > doesn't need to shuffle
> > > > > > > between different files to execute one instruction as was the case on
> > > > > > > using other alternatives.
> > > > > > 
> > > > > > Why do you have debugfs and also a misc device?  How are they related?
> > > > > > Why both?  Why not just one?  What userspace tools are going to use
> > > > > > either of these interfaces and where are they published
> > > > > > to show how this
> > > > > > all was tested?
> > > > > 
> > > > > DCC has two fundamental steps of usage:-
> > > > > 
> > > > > 1.Configuring the register addresses on the dcc_sram which is done by
> > > > > user through the debugfs interface. For example:-
> > > > > 
> > > > > echo R 0x10c004 > /sys/kernel/debug/dcc/../3/config
> > > > > 
> > > > > Here we are configuring the register addresses for list 3, the 'R'
> > > > > indicates a read operation, so this register value will be read
> > > > > in case of a software trigger or kernel panic/watchdog bite and
> > > > > dumped into the dcc_sram.
> > > > 
> > > > Can you describe why the register location needs to be
> > > > runtime configurable? I would have expected this type of setting
> > > > to be part of the devicetree, which already describes other
> > > > parts that interact with sram devices.
> > > 
> > > Register addresses are made runtime configurable to give the user the
> > > option of going for a software trigger. So the user can debug issues
> > > during run-time as well. These register locations are arbitrary
> > > and is configured by the user for debugging purposes and is not
> > > related to the DCC hardware itself.
> > 
> > Please note that we don't want to recompile the devicetree for new
> > settings since these registers can be set by team of engineers who are
> > debugging system level issues with various IPs across the SOCs. You
> > don't want to recompile the images while reproducing the system hangs/IP
> > watchdogs etc;
> 
> ...and also these registers list is not fixed, it will vary based on the
> problem you are seeing and debugging on the SOC across the IPs.

Then all of this should be documented in the driver, and in the
changelog please.

thanks,

greg k-h
