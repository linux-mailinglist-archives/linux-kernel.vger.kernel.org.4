Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA86267FD52
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 08:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjA2HJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 02:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjA2HJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 02:09:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBD22A12;
        Sat, 28 Jan 2023 23:09:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB1760C49;
        Sun, 29 Jan 2023 07:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCEDC433D2;
        Sun, 29 Jan 2023 07:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674976189;
        bh=5QzWA80JnAMHP8PX2TMVNUHFE4JYQUNbxY2QalPX/4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhzlM/PXVF3UGJ8Gzuu6E/mwYY6fuDkK7gh6hj+7cnJUYwy65c8kVUrOxYUdB0R4/
         jEQuUO6poSKB7P3QP3myRBJEg0gNKAUCmXILtzf5TOnl0yWPBWQPVlO/sZc4XuQxmF
         RngB74fzeURIwYGOagNvLrAuw+DDA5Ht9VXJ85Wo=
Date:   Sun, 29 Jan 2023 08:09:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Furong <furong.zhou@linux.intel.com>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
        broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH v2 07/22] ASoC: Add SOC USB APIs for adding an USB
 backend
Message-ID: <Y9YbumlV9qh+k68h@kroah.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-8-quic_wcheng@quicinc.com>
 <Y9UiiMbJFjkzyEol@kroah.com>
 <7c1d80b6-5db3-9955-0a67-908455bd77fa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c1d80b6-5db3-9955-0a67-908455bd77fa@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 02:54:43PM +0800, Zhou Furong wrote:
> 
> 
> > > +void *snd_soc_usb_get_priv_data(struct device *usbdev)
> > > +{
> > > +	struct snd_soc_usb *ctx;
> > > +
> > > +	if (!usbdev)
> > > +		return NULL;
> > 
> > How could usbdev ever be NULL?
> The method is exported to public, valid check should be reasonable
> as someone may call it by mistake

We do not protect the kernel from itself like this, no need to check
things that should never happen.  If the caller gets it wrong, their
code will break :)

thanks,

greg k-h
