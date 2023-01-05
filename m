Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3EE65E951
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjAEKub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjAEKuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:50:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3A654713
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672915760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJ9c84ROsMvUG/uEafEzSGIJRM2/BeEphDcwehifZUo=;
        b=jIRSuD3q/dPh0GhqqhRvOB3qEMF+aAsSMeT8HIXNQqtqCT4yEdJUwwSNrgjQJHCwaPS6XS
        8rboO+criPR2UOLQFRsCRXo0lWHM7Y/WGakVTqADpixUgiLtwWuY4ha2fm1Hxnox+/NOKp
        JHmF/y6ZqSHNtEE41P8fV4o3J5+YlNs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-144-rHgjdanqMhGHOdwFjXmVSg-1; Thu, 05 Jan 2023 05:49:17 -0500
X-MC-Unique: rHgjdanqMhGHOdwFjXmVSg-1
Received: by mail-wm1-f71.google.com with SMTP id p34-20020a05600c1da200b003d990064285so822527wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJ9c84ROsMvUG/uEafEzSGIJRM2/BeEphDcwehifZUo=;
        b=ects5MQMIxbqgUW+OlMwh3qFTHbYUm6TbuzTd83rrybCadqqnL6zPuKqd8G3K8aeRB
         /hiSOTE4tO46/SRgyNM4W4HLeRT++aH9hDFXKwZ8CPgF+BnIndkh7mTAKRT//jDyTrMH
         y/A2kFaRg/4hqlk5qD0NGWoqbgnHmfuBzTdRKKFvS0bcOLYkF0STm05o+Lva98ogu0rK
         jW0qrnMMIWb1DuFnZzXExAxOuiFsZ6cvpvXAVkEdI4aHMsBuZTdnIt4lGFBEcm/qEpvX
         dSdH2eToEBL+qQnOMIgR2qsbPng6yiHYODD2KhEiRzokeluEmtm/HJLC37LCw5bom93A
         BdKQ==
X-Gm-Message-State: AFqh2kqQCS7OhprwKqBZMQPG/zAC55ncyTPczmnEyKywgn8/o/EGfkR7
        jhj/vrGltjIhbgD+f8/CSRBUDLY59qGeP1edaT8Tnt4J32WMsCTv4XDAGJxkL+hWWFIsuHGSnjl
        8SKFy8RMIr0dsdm1Prv6mZnfx
X-Received: by 2002:a05:600c:3545:b0:3d9:a145:9ab with SMTP id i5-20020a05600c354500b003d9a14509abmr16804873wmq.39.1672915756319;
        Thu, 05 Jan 2023 02:49:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXunU9aoZgc9bUddO6+pFojimtklUp5BcUknBHILu2mZQDKsC6kWWx+HI3qKdtPkRufBDWdriQ==
X-Received: by 2002:a05:600c:3545:b0:3d9:a145:9ab with SMTP id i5-20020a05600c354500b003d9a14509abmr16804853wmq.39.1672915756022;
        Thu, 05 Jan 2023 02:49:16 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-105-31.dyn.eolo.it. [146.241.105.31])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003b4ff30e566sm6510517wms.3.2023.01.05.02.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 02:49:15 -0800 (PST)
Message-ID: <bab8cb9e4916ed9f55c720883183812f4e1f717f.camel@redhat.com>
Subject: Re: [Patch net-next v7 06/13] net: ptp: add helper for one-step P2P
 clocks
From:   Paolo Abeni <pabeni@redhat.com>
To:     Arun Ramadoss <arun.ramadoss@microchip.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux@armlinux.org.uk, Tristram.Ha@microchip.com,
        richardcochran@gmail.com, ceggers@arri.de
Date:   Thu, 05 Jan 2023 11:49:13 +0100
In-Reply-To: <27e0335f6ed15722feff27c17428410982a02e3c.camel@redhat.com>
References: <20230104084316.4281-1-arun.ramadoss@microchip.com>
         <20230104084316.4281-7-arun.ramadoss@microchip.com>
         <27e0335f6ed15722feff27c17428410982a02e3c.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-05 at 11:09 +0100, Paolo Abeni wrote:
> Hi,
> 
> On Wed, 2023-01-04 at 14:13 +0530, Arun Ramadoss wrote:
> > From: Christian Eggers <ceggers@arri.de>
> > 
> > For P2P delay measurement, the ingress time stamp of the PDelay_Req is
> > required for the correction field of the PDelay_Resp. The application
> > echoes back the correction field of the PDelay_Req when sending the
> > PDelay_Resp.
> > 
> > Some hardware (like the ZHAW InES PTP time stamping IP core) subtracts
> > the ingress timestamp autonomously from the correction field, so that
> > the hardware only needs to add the egress timestamp on tx. Other
> > hardware (like the Microchip KSZ9563) reports the ingress time stamp via
> > an interrupt and requires that the software provides this time stamp via
> > tail-tag on tx.
> > 
> > In order to avoid introducing a further application interface for this,
> > the driver can simply emulate the behavior of the InES device and
> > subtract the ingress time stamp in software from the correction field.
> > 
> > On egress, the correction field can either be kept as it is (and the
> > time stamp field in the tail-tag is set to zero) or move the value from
> > the correction field back to the tail-tag.
> > 
> > Changing the correction field requires updating the UDP checksum (if UDP
> > is used as transport).
> > 
> > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > Co-developed-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> > Signed-off-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> > ---
> > v1 -> v2
> > - Fixed compilation issue when PTP_CLASSIFY not selected in menuconfig
> > as reported by kernel test robot <lkp@intel.com>
> > ---
> >  include/linux/ptp_classify.h | 71 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> > 
> > diff --git a/include/linux/ptp_classify.h b/include/linux/ptp_classify.h
> > index 2b6ea36ad162..6e5869c2504c 100644
> > --- a/include/linux/ptp_classify.h
> > +++ b/include/linux/ptp_classify.h
> > @@ -10,8 +10,12 @@
> >  #ifndef _PTP_CLASSIFY_H_
> >  #define _PTP_CLASSIFY_H_
> >  
> > +#include <asm/unaligned.h>
> >  #include <linux/ip.h>
> > +#include <linux/ktime.h>
> >  #include <linux/skbuff.h>
> > +#include <linux/udp.h>
> > +#include <net/checksum.h>
> >  
> >  #define PTP_CLASS_NONE  0x00 /* not a PTP event message */
> >  #define PTP_CLASS_V1    0x01 /* protocol version 1 */
> > @@ -129,6 +133,67 @@ static inline u8 ptp_get_msgtype(const struct ptp_header *hdr,
> >  	return msgtype;
> >  }
> >  
> > +/**
> > + * ptp_check_diff8 - Computes new checksum (when altering a 64-bit field)
> > + * @old: old field value
> > + * @new: new field value
> > + * @oldsum: previous checksum
> > + *
> > + * This function can be used to calculate a new checksum when only a single
> > + * field is changed. Similar as ip_vs_check_diff*() in ip_vs.h.
> > + *
> > + * Return: Updated checksum
> > + */
> > +static inline __wsum ptp_check_diff8(__be64 old, __be64 new, __wsum oldsum)
> > +{
> > +	__be64 diff[2] = { ~old, new };
> > +
> > +	return csum_partial(diff, sizeof(diff), oldsum);
> > +}
> > +
> > +/**
> > + * ptp_header_update_correction - Update PTP header's correction field
> > + * @skb: packet buffer
> > + * @type: type of the packet (see ptp_classify_raw())
> > + * @hdr: ptp header
> > + * @correction: new correction value
> > + *
> > + * This updates the correction field of a PTP header and updates the UDP
> > + * checksum (if UDP is used as transport). It is needed for hardware capable of
> > + * one-step P2P that does not already modify the correction field of Pdelay_Req
> > + * event messages on ingress.
> > + */
> > +static inline
> > +void ptp_header_update_correction(struct sk_buff *skb, unsigned int type,
> > +				  struct ptp_header *hdr, s64 correction)
> > +{
> > +	__be64 correction_old;
> > +	struct udphdr *uhdr;
> > +
> > +	/* previous correction value is required for checksum update. */
> > +	memcpy(&correction_old,  &hdr->correction, sizeof(correction_old));
> > +
> > +	/* write new correction value */
> > +	put_unaligned_be64((u64)correction, &hdr->correction);
> > +
> > +	switch (type & PTP_CLASS_PMASK) {
> > +	case PTP_CLASS_IPV4:
> > +	case PTP_CLASS_IPV6:
> > +		/* locate udp header */
> > +		uhdr = (struct udphdr *)((char *)hdr - sizeof(struct udphdr));
> > +		break;
> > +	default:
> > +		return;
> > +	}
> > +
> > +	/* update checksum */
> > +	uhdr->check = csum_fold(ptp_check_diff8(correction_old,
> > +						hdr->correction,
> > +						~csum_unfold(uhdr->check)));
> > +	if (!uhdr->check)
> > +		uhdr->check = CSUM_MANGLED_0;
> 
> AFAICS the above works under the assumption that skb->ip_summed !=
> CHECKSUM_COMPLETE, and such assumption is true for the existing DSA
> devices.
> 
> Still the new helper is a generic one, so perhaps it should take care
> of CHECKSUM_COMPLETE, too? Or at least add a big fat warning in the
> helper documentation and/or a warn_on_once(CHECKSUM_COMPLETE).

I see this helper is used later even in the tx path, so even packet
with ip_summed == CHECKSUM_PARTIAL could reach here and should be
accomodated accordingly.

Thanks,

Paolo


