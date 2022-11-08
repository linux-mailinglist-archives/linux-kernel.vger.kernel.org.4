Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7862185F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKHPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiKHPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:34:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1868358BD1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:34:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C741AB81B3A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A06C433D7;
        Tue,  8 Nov 2022 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667921658;
        bh=QULdRw93pmvMhegOa4ePuSQURnFlXlrdf9tEjj03QEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLDabxVgpbNTSTwEWB3ZHvOVjlO8SaGNBAcpiztSlSLwy7uH3nCw2udS/4Wus2EI3
         553gkZ9ijOdEjlDteLyE+agQjchnFbdCpsTrsV6IOTd84rRivdmZHcKiYSd76/6Mse
         33yNLzFtCtTN/aOWcjNQQAyfEqc/qi2w0iDOw5wU=
Date:   Tue, 8 Nov 2022 16:34:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging/wlan-ng query: convert to flexible array member
Message-ID: <Y2p29zc/TeX8OFWU@kroah.com>
References: <Y2px+zOGjkpGh6qC@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2px+zOGjkpGh6qC@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 08:42:59PM +0530, Deepak R Varma wrote:
> Hello,
> 
> First, my apologies for the long email.
> I am requesting guidance on how to approach resolving the zero element flexible
> VLO struct implementation in this driver in file drivers/staging/waln-ng/hfa384x.f
> 
> The struct hfa384x_pdrec contains nested structs with zero element arrays.  These
> zero element structs are part of a union 'data' inside the struct container. This
> union 'data' is the last element of this container. Please see the code snip below:
> 
> <snip>
> 
> 	1068 struct hfa384x_pdrec {
> 	   1         __le16 len;             /* in words */
> 	   2         __le16 code;
> 	   3         union pdr {
> 	   4                 struct hfa384x_pdr_pcb_partnum pcb_partnum;
> 	  11                 struct hfa384x_pdr_nicid nicid;
> 	  12                 struct hfa384x_pdr_refdac_measurements refdac_measurements;
> 	  13                 struct hfa384x_pdr_vgdac_measurements vgdac_measurements;
> 	  14                 struct hfa384x_pdr_level_comp_measurements level_compc_measurements;
> 	  15                 struct hfa384x_pdr_mac_address mac_address;
> 	  39         } data;
> 	  40 } __packed;
> 
> </snip>
> 
> The three structures in question are declared as follows in the same file:
> 
> <snip>
> 	962  struct hfa384x_pdr_refdac_measurements {
> 	   1         u16 value[0];
> 	   2 } __packed;
> 	   3
> 	   4 struct hfa384x_pdr_vgdac_measurements {
> 	   5         u16 value[0];
> 	   6 } __packed;
> 	   7
> 	   8 struct hfa384x_pdr_level_comp_measurements {
> 	   9         u16 value[0];
> 	  10 } __packed;
> </snip>
> 
> As per the C99 specifications, the flexible array struct should have at least
> one member other than the true flexible array member. So converting these from
> [0] to [] is not feasible in the current form.
> 
> I did not find these struct variables being used for memory allocation in the
> code directly. My find may be short since the implementation appears to get very
> complex as I tried to get deeper.
> 
> Can you please suggest how should I approach correcting the zero element flex
> array implementation here? Can these structs be removed if they are unused?

Are you sure they are unused?

They look like structures that are read from the memory of a device,
right?  Try removing the structures from the union and see what happens
:)

thanks,

greg k-h
