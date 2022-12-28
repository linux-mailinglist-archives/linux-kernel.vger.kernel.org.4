Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D73658547
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiL1R2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiL1R2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:28:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00A61658C;
        Wed, 28 Dec 2022 09:28:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D2C36158D;
        Wed, 28 Dec 2022 17:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ADCC433D2;
        Wed, 28 Dec 2022 17:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672248508;
        bh=Dibxouqu84SBg/J/yTbFauKUYfl32fPLgSeV3dyv87M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKUt7VZwbGsaph7PITSfybymzqitYVro09zdOLMCKweCHJswdPLN8+DWtM5OaADkI
         Y5l4AjmP5JAsT5O+Un3k0kQTEabwFunEg87S3l/whHsadqK/3BLQRavztcIKMBpoT2
         ASdFFeIKZlOEV6+gEoAmRpHQYaL6NmaJOTFzbL/kDdO1raB4+l92tz1MWcMcp/sbmv
         hlXLsuGHg5KS2oOhXgKbdzW7XTPh+TtnHGuJHKq9UNXWHveZRkVicVKEv5VyhiL91o
         KOQCXczg5VyfRxJ7YP2k4/36749ogmfcs8U4EGhVDUJs3fv5s4RHcKDdNJrfbF3Z+Q
         7VMYnCXL7W2zA==
Date:   Wed, 28 Dec 2022 11:28:25 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
Subject: Re: [PATCH V21 2/7] soc: qcom: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Message-ID: <20221228172825.r32vpphbdulaldvv@builder.lan>
References: <cover.1672148732.git.quic_schowdhu@quicinc.com>
 <644b4f66a358492a8a6738454035c3b120092fe7.1672148732.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644b4f66a358492a8a6738454035c3b120092fe7.1672148732.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 08:52:46PM +0530, Souradeep Chowdhury wrote:
> The DCC is a DMA Engine designed to capture and store data
> during system crash or software triggers. The DCC operates
> based on user inputs via the debugfs interface. The user gives
> addresses as inputs and these addresses are stored in the
> dcc sram. In case of a system crash or a manual software
> trigger by the user through the debugfs interface,
> the dcc captures and stores the values at these addresses.
> This patch contains the driver which has all the methods
> pertaining to the debugfs interface, auxiliary functions to
> support all the four fundamental operations of dcc namely
> read, write, read/modify/write and loop. The probe method
> here instantiates all the resources necessary for dcc to
> operate mainly the dedicated dcc sram where it stores the
> values. The DCC driver can be used for debugging purposes
> without going for a reboot since it can perform software
> triggers as well based on user inputs.
> 
> Also add the documentation for debugfs entries which explains
> the functionalities of each debugfs file that has been created
> for dcc.
> 
> The following is the justification of using debugfs interface
> over the other alternatives like sysfs/ioctls
> 
> i) As can be seen from the debugfs attribute descriptions,
> some of the debugfs attribute files here contains multiple
> arguments which needs to be accepted from the user. This goes
> against the design style of sysfs.
> 
> ii) The user input patterns have been made simple and convenient
> in this case with the use of debugfs interface as user doesn't
> need to shuffle between different files to execute one instruction
> as was the case on using other alternatives.
> 

I would have preferred to get some more input from users of the debugfs
interface, but it's after all not ABI. So let's get this merged and
if people has concerns/objections/suggestions we'll improve it as
necessary.

Thanks for pushing this Souradeep!

> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Reviewed-by: Alex Elder <elder@linaro.org>

Thanks Alex.

Regards,
Bjorn
