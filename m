Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC49617F0C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiKCONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiKCONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:13:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4650517886
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:12:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o4so2969711wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DW6qOLggUDgASb5BXWgCGBn6wiJ6RjTplDMM4RvHv1c=;
        b=szGfA5+M7RAuJB1RtigO8OXQnPyhSSGas+YyiakeOYmPUpGUE0ADMCc2/g+DMiQggO
         0awI303q89XBifILuOCdf9y2/b6mq6D6HrBD58ZICMYPRUkHL3/Iuct87QptioaXQiUb
         8Bnt2+VIzshGlCDK3bwtpaht99yOc9iPNZi4fgtel3xBl9UAwO5yHoN1WMH5ATwSsb44
         VO2EVWWE56QgaA+IQECwMT1S3tWfVRFdItFfj2HEkaR4JKShBPy+yIhnKzPpnq7zKjH/
         vZCHDjKzarQ8jX6IQNG2aUcsbMLiQ+YOKtRC4Cf9bfQjQlvCDoz57weFZRHwHOpnqpsp
         hkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DW6qOLggUDgASb5BXWgCGBn6wiJ6RjTplDMM4RvHv1c=;
        b=U6pqekN2yhIKwK3JRepRZ0MPgqpcGWyk6l2cmSfys93eFnXK/NDcnt8cjfAPcxueLA
         cIUAtW6n279/d4a8orSk0dajfN4uBscXTH3+pyV2C6nHO2xG64XrTYeM3XsVSaWiYSMl
         DOgEmFSdnmZFfw8Px1jbCcpP6Ja9+JE4YDypm/6ZHvRioOOiEUpdFzyU8FLlqdj95pTP
         HTXjsCvWN10coJD5uHR/UTEHpYHl8B28Cc5sQp0vg2BuvJeWUebunmqotC8jBgpHKsTo
         cNqvLifJNT3JS6PQiqb6MeiM1sq/5+lnqR76sNsb1CkZdYcWLhILrGIYme+W1mK+cmcv
         ZRBg==
X-Gm-Message-State: ACrzQf0PrgwbbqhX3zoJn0bJ5WhPRGlUOSOg9zcUieVc6rVI2mTfOcTK
        oQURzEGY5ofNajT06ArtoMdF5BQmGos2i4cKq7Sc2g==
X-Google-Smtp-Source: AMsMyM5IngcZNcehorWq6IuX0vGpEwpnOakPgOR/8mDTynUw7/vFc41S411CVdIbzMmXMYIVD5Xcmk+c/RbP4ad4h/0=
X-Received: by 2002:adf:db4d:0:b0:236:699b:be5e with SMTP id
 f13-20020adfdb4d000000b00236699bbe5emr18209276wrj.147.1667484777461; Thu, 03
 Nov 2022 07:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221027004050.4192111-1-albertccwang@google.com>
 <20221027004050.4192111-3-albertccwang@google.com> <Y1oj7TlC93oOKyB7@kroah.com>
In-Reply-To: <Y1oj7TlC93oOKyB7@kroah.com>
From:   Albert Wang <albertccwang@google.com>
Date:   Thu, 3 Nov 2022 22:12:45 +0800
Message-ID: <CANqn-rjNKJasYe4LxMcSNANCOVkGaiQ8=nwaMTjvBkyts=uG8w@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: xhci-plat: add xhci_plat_priv_overwrite
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Understood, will fix and re-upload v2 patch set.

Thanks,
Albert

Albert Wang | Pixel USB Software  | albertccwang@google.com | +886-918-695-245


On Thu, Oct 27, 2022 at 2:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 27, 2022 at 08:40:49AM +0800, Albert Wang wrote:
> > From: Howard Yen <howardyen@google.com>
> >
> > Add an overwrite to platform specific callback for setting up the
> > xhci_offload_ops, allow vendor to store the xhci_offload_ops and
> > overwrite them when xhci_plat_probe invoked.
> >
> > Signed-off-by: Howard Yen <howardyen@google.com>
> > Link: https://lore.kernel.org/r/20210119101044.1637023-1-howardyen@google.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@google.com>
>
> Again, no, I do NOT sign off on this submission.
>
> Also, you did not sign off on it, yet you forwarded it on.  That's not
> allowed either, and makes this whole series not even able to be
> accepted, if it were a valid set of changes :(
>
> Please fix.
>
> thanks,
>
> greg k-h
