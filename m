Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3985867349A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjASJke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjASJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:40:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC5E67788
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674121174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/ChhZxDJZuEORf8farkuxzgJiMR/obZmOs0mGamXtg=;
        b=gX0eoiS3/REr7dhY8TRxZ1v3hW7n3IOdgW3RVCpNj+m7prn1DHAw70oZJzqejUpKvdx+fq
        /N9PYgovQ0sO4b5L0GABQSToHYxthAniriYx4J+Y+im6XhiZHKdgp5+l1VhoBKoTFn5oc2
        3yN4hiZeEz//6J5CYVrNGNcb87MgGQo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-3KY_KAP1MYKtB5rp4mfBkw-1; Thu, 19 Jan 2023 04:39:33 -0500
X-MC-Unique: 3KY_KAP1MYKtB5rp4mfBkw-1
Received: by mail-pj1-f69.google.com with SMTP id 31-20020a17090a0fa200b00226e43409c2so672765pjz.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/ChhZxDJZuEORf8farkuxzgJiMR/obZmOs0mGamXtg=;
        b=K2r70Nq8Z/5WarZSM/iG8L830kvIad5MTJwHiYloeEh/rwd1Ec5tdjdh52alX63Vuy
         MlqOwFduBxlEFI+90DfzSe1/4Z911LhbUzQJ68tPMjwfu1kBSE2ScnJScduJo4R0ywCV
         6sXhyqIM8c8128Tw0bKrJJUv18Aj+dsjiTie1WAMug3A8MO3LipOntRWhqxee/4Rh3tc
         dR5ZJaGib9XIkpcXLCwhpLb0iPMjMXaWIn9r13tGmNiOnQxYgszjIh/xQ5B7maZU9Ndr
         pHbJsTlmGlBvpxRibe6GsQ8DQc3qpES/uTAlAKA4ABniloSlvnLOmzAxKqGqpgn6rhlA
         Nh5w==
X-Gm-Message-State: AFqh2krwww1pjn6TlV3f7xwqtc/xMkFvNdoMs3QudxlFPb0laPDCcf/P
        o4dDS8FgOp8PPWP0SClH5Nxk91edrfdE+xReMtwTSsBuAEGV89VUO4e2U1Ghe31/R7oYDrQI7z4
        SHYErzUI6mk4ImKXskFEgYtAuOXpr0K36njWSR3vu
X-Received: by 2002:a17:902:7fc2:b0:193:1c8f:1840 with SMTP id t2-20020a1709027fc200b001931c8f1840mr910010plb.45.1674121172059;
        Thu, 19 Jan 2023 01:39:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXspRmFPMIcgKeh99fbH2SIAKrEAw490iJb/gxDbOUZm7zM5B9QAclLluPcX2iXs0Axru9c5FrksZgsFQtOUUg8=
X-Received: by 2002:a17:902:7fc2:b0:193:1c8f:1840 with SMTP id
 t2-20020a1709027fc200b001931c8f1840mr910002plb.45.1674121171857; Thu, 19 Jan
 2023 01:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20230117181533.2350335-1-neelx@redhat.com> <2bdeb975-6d45-67bb-3017-f19df62fe7af@intel.com>
 <CACjP9X-hKf8g2UqitV8_G7WQW7u6Js5EsCNutsAMA4WD7YYSwA@mail.gmail.com>
 <42e74619-f2d0-1079-28b1-61e9e17ae953@intel.com> <CACjP9X8SHZAd_+HSLJCxYxSRQuRmq3r48id13r17n2ehrec2YQ@mail.gmail.com>
 <820cf397-a99e-44d4-cf9e-3ad6876e4d06@intel.com>
In-Reply-To: <820cf397-a99e-44d4-cf9e-3ad6876e4d06@intel.com>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Thu, 19 Jan 2023 10:38:55 +0100
Message-ID: <CACjP9X_v9AFVNRgz2a-qJce+ZqR0TzRzyd4gPFufESoRXmCdJQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] ice/ptp: fix the PTP worker retrying
 indefinitely if the link went down
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "Kolacinski, Karol" <karol.kolacinski@intel.com>,
        Siddaraju <siddaraju.dh@intel.com>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:22 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> On 1/18/2023 2:11 PM, Daniel Vacek wrote:
> > On Wed, Jan 18, 2023 at 9:59 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> >> On 1/18/2023 7:14 AM, Daniel Vacek wrote:
> >> 1) request tx timestamp
> >> 2) timestamp occurs
> >> 3) link goes down while processing
> >
> > I was thinking this is the case we got reported. But then again, I'm
> > not really experienced in this field.
> >
>
> I think it might be, or at least something similar to this.
>
> I think that can be fixed with the link check you added. I think we
> actually have a copy of the current link status in the ice_ptp or
> ice_ptp_tx structure which could be used instead of having to check back
> to the other structure.

If you're talking about ptp_port->link_up that one is always false no
matter the actual NIC link status. First I wanted to use it but
checking all the 8 devices available in the dump data it just does not
match the net_dev->state or the port_info->phy.link_info.link_info

crash> net_device.name,state 0xff48df6f0c553000
  name = "ens1f1",
  state = 0x7,    // DOWN
crash> ice_port_info.phy.link_info.link_info 0xff48df6f05dca018
  phy.link_info.link_info = 0xc0,    // DOWN
crash> ice_ptp_port.port_num,link_up 0xff48df6f05dd44e0
  port_num = 0x1
  link_up = 0x0,    // False

crash> net_device.name,state 0xff48df6f25e3f000
  name = "ens1f0",
  state = 0x3,    // UP
crash> ice_port_info.phy.link_info.link_info 0xff48df6f070a3018
  phy.link_info.link_info = 0xe1,    // UP
crash> ice_ptp_port.port_num,link_up 0xff48df6f063184e0
  port_num = 0x0
  link_up = 0x0,    // False

crash> ice_ptp_port.port_num,link_up 0xff48df6f25b844e0
  port_num = 0x2
  link_up = 0x0,    // False even this device is UP
crash> ice_ptp_port.port_num,link_up 0xff48df6f140384e0
  port_num = 0x3
  link_up = 0x0,    // False even this device is UP
crash> ice_ptp_port.port_num,link_up 0xff48df6f055044e0
  port_num = 0x0
  link_up = 0x0,    // False even this device is UP
crash> ice_ptp_port.port_num,link_up 0xff48df6f251cc4e0
  port_num = 0x1
  link_up = 0x0,
crash> ice_ptp_port.port_num,link_up 0xff48df6f33a9c4e0
  port_num = 0x2
  link_up = 0x0,
crash> ice_ptp_port.port_num,link_up 0xff48df6f3bb7c4e0
  port_num = 0x3
  link_up = 0x0,

In other words, the ice_ptp_port.link_up is always false and cannot be
used. That's why I had to fall back to
hw->port_info->phy.link_info.link_info

--nX

> I'm just hoping not to re-introduce bugs related to the hardware
> interrupt counter that we had which results in preventing all future
> timestamp interrupts.
>
> > --nX
> >
> >> 1) link down
> >> 2) request tx timestamp rejected
> >>
> >> Thanks!
> >>
> >> -Jake
> >
>

