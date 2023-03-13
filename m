Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78E6B85DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCMXHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCMXHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:07:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A9810254;
        Mon, 13 Mar 2023 16:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45CCB6154C;
        Mon, 13 Mar 2023 23:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9CBC433EF;
        Mon, 13 Mar 2023 23:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678748835;
        bh=JlkQRxZUbcfwnQ9VdkB1aYg4+loILNLrAAOVONzCXAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PN5KhCdkOBYJxn9HQVR3vakp+DP+XyeR6paoTO3aMo0XnRgNQBGKszzEiLYJgzwvo
         UsPR8F8NTxcBO2VxSyDYghNFEfZJDs57Jl/oeWuwOHgpYUWN665UOZWAxz/+ZAjJFS
         3hA8LL6GFkxf7d6lEQeBI/UplY1fBlHzqxvdPHBSt0+7BzCh9OZN9ILPCERC1GXFb4
         MQKjNJVJ2lh49gts+vqAMuTKSX4lUb3HHQ0JTUP4vyBI9rT/HpNLbkRR8RwB09L8cm
         zoAvrVCpfL3HEaD+WolrJe90zyRFK0eZoBoNfB55WFzr5XKv9jMXwUZoAtjYxk5TRf
         GWLBvfhzmPbTw==
Date:   Tue, 14 Mar 2023 00:07:12 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Todd Brandt <todd.e.brandt@intel.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, todd.e.brandt@linux.intel.com,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        jikos@kernel.org, p.jungkamp@gmx.net
Subject: Re: [PATCH v2] Fix buffer overrun in HID-SENSOR name string
Message-ID: <20230313230712.6xboy3w5ocrvj3vn@intel.intel>
References: <20230313220653.3996-1-todd.e.brandt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313220653.3996-1-todd.e.brandt@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todd,

On Mon, Mar 13, 2023 at 03:06:53PM -0700, Todd Brandt wrote:
> On some platforms there are some platform devices created with
> invalid names. For example: "HID-SENSOR-INT-020b?.39.auto" instead
> of "HID-SENSOR-INT-020b.39.auto"
> 
> This string include some invalid characters, hence it will fail to
> properly load the driver which will handle this custom sensor. Also
> it is a problem for some user space tools, which parse the device
> names from ftrace and dmesg.
> 
> This is because the string, real_usage, is not NULL terminated and
> printed with %s to form device name.
> 
> To address this, we initialize the real_usage string with 0s.
> 
> Philipp Jungkamp created this fix, I'm simply submitting it. I've
> verified it fixes bugzilla issue 217169
> 
> Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217169
> Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>

Why is not Philip in the SoB list?

Anyway the original patch made it to stable, so:

Fixes: 98c062e82451 ("HID: hid-sensor-custom: Allow more custom iio sensors")
Cc: stable@vger.kernel.org

and with those you can add:

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi
