Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0769D73152C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbjFOK01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjFOK0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83E4AC;
        Thu, 15 Jun 2023 03:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75CA56271C;
        Thu, 15 Jun 2023 10:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5319AC433C0;
        Thu, 15 Jun 2023 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686824782;
        bh=NhX6m1SdvRw+UqUo1U1eqTCYevt1vpqaST53x9uBSls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/u83yjctgrxMANubX7pyAWGVHpS3ZdXFc1e0TlBjqvO3OvuUb30Qb+X9U4GXZ9Ge
         UhvecZIC0CdioW2YvP+nflZkHm7gFfO6WejPEg/VCyzs/ijrPQj3sGDwCltWRv70VI
         4SYe+6lJgbezQkN+rGW+nVgQ1X/z41q9g1N/eELg=
Date:   Thu, 15 Jun 2023 12:26:20 +0200
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
Subject: Re: [PATCH V23 0/3] misc: Add driver support for Data Capture and
 Compare unit(DCC)
Message-ID: <2023061504-equator-superbowl-78b5@gregkh>
References: <cover.1683265984.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683265984.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 11:36:20PM -0700, Souradeep Chowdhury wrote:
> DCC(Data Capture and Compare) is a DMA engine designed for debugging purposes.
> In case of a system crash or manual software triggers by the user the DCC hardware
> stores the value at the register addresses which can be used for debugging purposes.
> The DCC driver provides the user with debugfs interface to configure the register
> addresses. The options that the DCC hardware provides include reading from registers,
> writing to registers, first reading and then writing to registers and looping
> through the values of the same register.
> 
> In certain cases a register write needs to be executed for accessing the rest of the
> registers, also the user might want to record the changing values of a register with
> time for which he has the option to use the loop feature.
> 
> The options mentioned above are exposed to the user by debugfs files once the driver
> is probed. The details and usage of this debugfs files are documented in
> Documentation/ABI/testing/debugfs-driver-dcc.
> 
> As an example let us consider a couple of debug scenarios where DCC has been proved to be
> effective for debugging purposes:-
> 
> i)TimeStamp Related Issue
> 
> On SC7180, there was a coresight timestamp issue where it would occasionally be all 0
> instead of proper timestamp values.
> 
> Proper timestamp:
> Idx:3373; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x13004d8f5b7aa; CC=0x9e
> 
> Zero timestamp:
> Idx:3387; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x0; CC=0xa2
> 
> Now this is a non-fatal issue and doesn't need a system reset, but still needs
> to be rootcaused and fixed for those who do care about coresight etm traces.
> Since this is a timestamp issue, we would be looking for any timestamp related
> clocks and such.
> 
> We get all the clk register details from IP documentation and configure it
> via DCC config_read debugfs node. Before that we set the current linked list.
> 
> /* Program the linked list with the addresses */
> echo R 0x10c004 > /sys/kernel/debug/qcom-dcc/../3/config
> echo R 0x10c008 > /sys/kernel/debug/qcom-dcc/../3/config
> echo R 0x10c00c > /sys/kernel/debug/qcom-dcc/../3/config
> echo R 0x10c010 > /sys/kernel/debug/qcom-dcc/../3/config
> ..... and so on for other timestamp related clk registers
> 
> /* Other way of specifying is in "addr len" pair, in below case it
> specifies to capture 4 words starting 0x10C004 */
> 
> echo R 0x10C004 4 > /sys/kernel/debug/qcom-dcc/../3/config_read
> 
> /* Enable DCC */
> echo 1 > /sys/kernel/debug/qcom-dcc/../3/enable
> 
> /* Run the timestamp test for working case */
> 
> /* Send SW trigger */
> echo 1 > /sys/kernel/debug/qcom-dcc/../trigger
> 
> /* Read SRAM */
> cat /dev/dcc_sram > dcc_sram1.bin
> 
> /* Run the timestamp test for non-working case */
> 
> /* Send SW trigger */
> echo 1 > /sys/kernel/debug/qcom-dcc/../trigger
> 
> /* Read SRAM */
> cat /dev/dcc_sram > dcc_sram2.bin
> 
> Get the parser from [1] and checkout the latest branch.
> 
> /* Parse the SRAM bin */
> python dcc_parser.py -s dcc_sram1.bin --v2 -o output/
> python dcc_parser.py -s dcc_sram2.bin --v2 -o output/
> 
> Sample parsed output of dcc_sram1.bin:
> 
> <hwioDump version="1">
>          <timestamp>03/14/21</timestamp>
>              <generator>Linux DCC Parser</generator>
>                  <chip name="None" version="None">
>                  <register address="0x0010c004" value="0x80000000" />
>                  <register address="0x0010c008" value="0x00000008" />
>                  <register address="0x0010c00c" value="0x80004220" />
>                  <register address="0x0010c010" value="0x80000000" />
>              </chip>
>      <next_ll_offset>next_ll_offset : 0x1c </next_ll_offset>
> </hwioDump>
> 
> ii)NOC register errors
> 
> A particular class of registers called NOC which are functional registers was reporting
> errors while logging the values.To trace these errors the DCC has been used effectively.
> The steps followed were similar to the ones mentioned above.
> In addition to NOC registers a few other dependent registers were configured in DCC to
> monitor it's values during a crash. A look at the dependent register values revealed that
> the crash was happening due to a secured access to one of these dependent registers.
> All these debugging activity and finding the root cause was achieved using DCC.
> 
> DCC parser is available at the following open source location
> 
> https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/tools/-/tree/opensource-tools.lnx.1.0.r176-rel/dcc_parser
> 
> Souradeep Chowdhury (3):
>   dt-bindings: misc: qcom,dcc: Add the dtschema
>   misc: dcc: Add driver support for Data Capture and Compare unit(DCC)
>   MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
>     support
> 
>  Documentation/ABI/testing/debugfs-driver-dcc  |   10 +-
>  .../devicetree/bindings/misc/qcom,dcc.yaml    |   44 +
>  MAINTAINERS                                   |    8 +
>  drivers/misc/Kconfig                          |    9 +
>  drivers/misc/Makefile                         |    1 +
>  drivers/misc/qcom-dcc.c                       | 1325 +++++++++++++++++
>  6 files changed, 1392 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,dcc.yaml
>  create mode 100644 drivers/misc/qcom-dcc.c
> 
> -- 
> 2.17.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
