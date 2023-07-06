Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C697493EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjGFCyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGFCyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1DB1BC5;
        Wed,  5 Jul 2023 19:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6CFD61461;
        Thu,  6 Jul 2023 02:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B43C433C8;
        Thu,  6 Jul 2023 02:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688612053;
        bh=HenXvbXh+FMHOsANhghfX7JZNcwVNRAhL9A7ZADg4CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fd/V7FTEXBp1VYm62AoFVVui6Jv9BmsU8Mpp1Sl/o5TIVF4hN2kDBG3LIsMlsqHJB
         5XZR2Lf/Mc5TKC13GUPSUFDcz1KH1B+LOyHyJmMiy/5Dum1fn+g18Wg6YAmfS/fYmY
         pBOPjwLHzHDywF8A92FTjlfCue1bWfPI7YGlI+JW18CP+42bhDWF/v7I5TnkKqViLj
         8e8CYESNdiSZTvML2GSBKeK6CAS986YYHNEm6VJXNnN7curGU4YIDbWRpO3Pnxm8ye
         BCcskMdJHDvaV3JzlEHAu3M+ibg9Mqeid80tV/N3uSmpWMTH+CyoMfuOqjme+KM+lj
         KWuEoy7OgLF8Q==
Date:   Wed, 5 Jul 2023 19:57:54 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: Re: [PATCH V8 3/3] rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL
 support
Message-ID: <qobozhguxj5hc5oo3s7iesvznqohi2trf5os2wlpdx737opics@fkq72gprbtfd>
References: <1687361648-27688-1-git-send-email-quic_sarannya@quicinc.com>
 <1687361648-27688-4-git-send-email-quic_sarannya@quicinc.com>
 <d0e5a6bf-e89f-bcf0-7009-94edfbcf2a83@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e5a6bf-e89f-bcf0-7009-94edfbcf2a83@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:11:03AM +0200, Arnaud POULIQUEN wrote:
> On 6/21/23 17:34, Sarannya S wrote:
[..]
> > diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
[..]
> > +	switch (cmd) {
> > +	case RPMSG_GET_OUTGOING_FLOWCONTROL:
> > +		eptdev->remote_flow_updated = false;
> > +		ret = put_user(eptdev->remote_flow_restricted, (int __user *)arg);
> > +		break;
> > +	case RPMSG_SET_INCOMING_FLOWCONTROL:
> > +		set = !!arg;
> > +		ret = rpmsg_set_flow_control(eptdev->ept, set, eptdev->chinfo.dst);
> > +		break;
> > +	case RPMSG_DESTROY_EPT_IOCTL:
> > +		/* Don't allow to destroy a default endpoint. */
> > +		if (eptdev->default_ept) {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		ret = rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> >  
> > -	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
> > +	return ret;
> >  }
> >  
> >  static const struct file_operations rpmsg_eptdev_fops = {
> > diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> > index 1637e68..b0a6c17 100644
> > --- a/include/uapi/linux/rpmsg.h
> > +++ b/include/uapi/linux/rpmsg.h
> > @@ -43,4 +43,14 @@ struct rpmsg_endpoint_info {
> >   */
> >  #define RPMSG_RELEASE_DEV_IOCTL	_IOW(0xb5, 0x4, struct rpmsg_endpoint_info)
> >  
> > +/**
> > + * Set the flow control for the remote rpmsg char device.

We improved the wording elsewhere in the patch, to make the description
of what the interface controls/exposes. This would benefit from the same
attention.

And this says "Set" while the ioctl says "GET".

> > + */
> > +#define RPMSG_GET_OUTGOING_FLOWCONTROL _IOW(0xb5, 0x5, struct rpmsg_endpoint_info)
> > +
> > +/**
> > + * Set the flow control for the local rpmsg char device.
> > + */
> > +#define RPMSG_SET_INCOMING_FLOWCONTROL _IOW(0xb5, 0x6, struct rpmsg_endpoint_info)
> 
> 
> Perhaps I missed something, but you use "rpmsg_endpoint_info" as argument.
> In rpmsg_eptdev_ioctl the argument is treated as a boolean.
> Seems to me that something is wrong here.
> 

This is indeed an int in the implementation above.

Regards,
Bjorn

> regards,
> Arnaud
> 
> > +
> >  #endif
