Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82016629BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjAIPTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbjAIPSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:18:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78226E34;
        Mon,  9 Jan 2023 07:18:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14C9E6118B;
        Mon,  9 Jan 2023 15:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DF5C433EF;
        Mon,  9 Jan 2023 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673277501;
        bh=DmyreDlHArodCGsufBIpSI6aaNNSnNxkS4N5Bedx534=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUPq8AUND2CUfjPFiGOdOPro3tV1Vf2y7VUWm/uNW8B/gXY949Tc6cMbh1MoQsGx6
         BWIDhrHN297V2QOnVZHEeCmPIB3by4/K69slOM7cyhKpT9y34QfJWu3FINCrvUCL7B
         B57jGIYhmgl9qSICopZ83ikq28x+CuixrVEImgso4BUznpJLn5MlX0s09F+JYm9yp3
         B1qgEcMXe6BR11soaqCL/yenoOBqUT2mYLgCJVqYhWXQFPYWRhEt5NtvuCdHGtoTo+
         xj14kROg4L0lACPFdtHgZkLFRWe17wYJ8xuGx4mIzcsLYlB0dV3g3bDZjUEI9IhcWA
         SIjgSwj6x5VKw==
Date:   Mon, 9 Jan 2023 09:18:18 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alex Elder <elder@ieee.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
Subject: Re: [PATCH V1 0/1] soc: qcom: dcc: Add QAD, Cti-trigger and
 Bootconfig support for Data Capture and Compare(DCC)
Message-ID: <20230109151818.hxpi2nleb53ibv7w@builder.lan>
References: <cover.1673270769.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673270769.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:32:25PM +0530, Souradeep Chowdhury wrote:
> This patch adds the Bootconfig, QAD and CTI-Trigger support for DCC.
> 

As with the other patch, please move your motivation into the commit
message of the patch.

That said, this seems to be 3 different topics, and hence should be
three different patches.

> 1.Bootconfig
> 
> Bootconfig parser has been added to DCC driver so that the register addresses
> can be configured during boot-time. This is used to debug crashes that can happen
> during boot-time. The expected format of a bootconfig is as follows:-
> 
> dcc_config {
> 	link_list_0 {
> 		qcom-curr-link-list = <The list number to configure>
> 		qcom-link-list =  <Address as same format as dcc separated by '_'>,
> 	}
> }
> 
> Example:
> 
> dcc_config {
> 	link_list_0 {

The name of the node does not seem to have any significance; this could
be nice to mention. I also think it would set a good precedence if you
used the number of the qcom-curr-link-list in the node name, rather than
just an iterator...

> 		qcom-curr-link-list = 6
> 		qcom-link-list = R_0x1781005c_1_apb,
> 				 R_0x1782005c_1_apb
> 	}
> 	link_list_1 {
> 		qcom-curr-link-list = 5
> 		qcom-link-list = R_0x1784005c_1_apb
> 	}
> }
> 
> 2.QAD
> 
> QAD can be enabled as a part of debugfs file under each individual list folder.
> QAD is used to specify the access control for DCC configurations, on enabling
> it the access control to dcc configuration space is restricted.
> 

Who is locked out from this restricted access? Please mention why this
is a good thing.

> 3.CTI-trigger
> 
> CTI trigger is used to enable the Cross trigger interface for DCC. On enabling
> CTI trigger the dcc software trigger can be done by writing to CTI trig-out.
> Also the hwtrigger debugfs file is created which needs to be disabled for enabling
> CTI-trigger.
> 

Please mention why hwtrigger needs to be disabled, and why does it need
to be disabled?

> Changes in V1
> 
> *Fixed the W=1 warnings in V0 of the patch

Please follow the standard practice of giving your first version of a
patch version 1.

Thanks,
Bjorn

> 
> Souradeep Chowdhury (1):
>   soc: qcom: dcc: Add QAD, Ctitrigger and Bootconfig support for DCC
> 
>  Documentation/ABI/testing/debugfs-driver-dcc |  24 +++
>  drivers/soc/qcom/dcc.c                       | 284 ++++++++++++++++++++++++++-
>  2 files changed, 304 insertions(+), 4 deletions(-)
> 
> --
> 2.7.4
> 
