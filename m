Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFA6727C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjFHKQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbjFHKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2F2700;
        Thu,  8 Jun 2023 03:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF626133B;
        Thu,  8 Jun 2023 10:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C817BC433EF;
        Thu,  8 Jun 2023 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686219383;
        bh=3RIXBkhz0gFNRjIrzHIO1ESCsLgw9gEjUuc5wQ6OvR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awAv8PdrGGVQPX8fPgjx1N+quYzCmaOB9MOpQLVosxcVFnut/sNWMDMtY5Kp5Ke58
         l0t9JDYXXV+9Rgnpxf80ylEIBZ9hozGRzyDHO2HUQAUdh4PQ8nPjyi2jD4itZDLffk
         cfucNcy6Dk0tEWPb22EUFWdjciCY9R1AxI+cSH4Q=
Date:   Thu, 8 Jun 2023 12:16:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        ekangupt@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v1 0/2] Privileged process support on remote
 subsystem
Message-ID: <2023060857-renewed-bonehead-5b36@gregkh>
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
 <2023060722-zap-fiftieth-4323@gregkh>
 <a665978d-f1e7-380e-f5f2-cf1270fa7961@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a665978d-f1e7-380e-f5f2-cf1270fa7961@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:23:06PM +0530, Ekansh Gupta wrote:
> 
> 
> On 6/8/2023 12:17 AM, Greg KH wrote:
> > On Wed, Jun 07, 2023 at 10:00:05PM +0530, Ekansh Gupta wrote:
> > > Add support to run remote user process as privileged on remote
> > > subsystem. The privileged user process can be given prioritized
> > > access to remote processor resources. This is achieved in kernel
> > > based on the group ID of the process. The kernel will have a
> > > pre-defined fastrpc group ID and if the process's group ID matches
> > > with it, then the process is treated as a privileged process. This
> > > information is sent to the remote processor during PD initialization
> > > and the PD is treated as a privileged PD.
> > > 
> > > Ekansh Gupta (2):
> > >    dt-bindings: misc: fastrpc: add fastrpc group IDs property
> > >    misc: fastrpc: detect privileged processes based on group ID
> > > 
> > >   .../devicetree/bindings/misc/qcom,fastrpc.yaml     |   6 +
> > >   drivers/misc/fastrpc.c                             | 124 +++++++++++++++++++++
> > >   2 files changed, 130 insertions(+)
> > > 
> > > -- 
> > > 2.7.4
> > > 
> > 
> > Why is this a RESEND?
> > 
> I missed sending the patches to some necessary people and lists. Hence,
> resent the patch series.

Please always say so when doing a resend as I think the documentation
asks you to, right?

thanks,

greg k-h
