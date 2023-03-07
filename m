Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A79D6AFA60
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 00:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCGXbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 18:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCGXbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 18:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E236A8E8C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 15:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678231807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6PI1+iCyE6roSMv9xD9czxTetp5xB/wELaV59zECsA=;
        b=UeqgWKznONFz3xjSZ5pOv1pxSYLnUK39MAPTNWsi4Z4GmB65ys1rndX1/pd8LJVE8MBVkj
        5B3PuLBZ/dpvfO/TZjz1ymgWVhLrqJzf0mBr1yB8ToGGWmyyFhrH4DOISWAm0Z/L0Y9vu0
        siLtUifLVgo7luvCZemQ+mWQ7n9sfZM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-lU7-W_GIO5O9uOFB5pdLAQ-1; Tue, 07 Mar 2023 18:30:06 -0500
X-MC-Unique: lU7-W_GIO5O9uOFB5pdLAQ-1
Received: by mail-ed1-f70.google.com with SMTP id da22-20020a056402177600b004c60694083eso20955230edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 15:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678231804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6PI1+iCyE6roSMv9xD9czxTetp5xB/wELaV59zECsA=;
        b=eESDxybU4yN8EpI8XKR+SGonFfBrALWyNeG6HIZV4AezKAv8RTpBXJTSb/aWyuLRTB
         MNZBUi68y4oaxBimYdsfylGOEq4fMIslp72IB2+OtOQSErQ5nj6k8gDWvtrbHuIa9khm
         sf1Fia9Cvp5ZZXYFqaz6t5LpiLsTEdb1epbvdGYTHkOBmsLAKfLQ0OZU6WvERfmO4WgI
         aKpW+mM3VO3ZfOU/+zmDf3cyGGzIECYr/MhvNsCLnxgVCZ9dXWsnl1LqMY2f4M5R6fgY
         f4psw6Nr0hiv2pxZ01tgGY4/6BEXQmd5Lc7ukQirnaRD6pcP3HMVutH4pjlJmpk/7gEV
         qBSQ==
X-Gm-Message-State: AO0yUKWuh9aaRpn1xT13OQj66pWJbImYL9ZNBPHbR0zXqga933OuxDNt
        jhw6l0MlORPbTxts9+jY6g3jMJt0+0U/GCegrWNWDksWmp3DSiJSq2NT/6GkNSFmpkGKl8BLYu5
        LRwf9mUVbuX60RVAbVkTUtYuNOjmcKS0p3oPMyqJgaTPBqaYzpgQ=
X-Received: by 2002:a17:906:338e:b0:895:58be:963 with SMTP id v14-20020a170906338e00b0089558be0963mr8232070eja.3.1678231804500;
        Tue, 07 Mar 2023 15:30:04 -0800 (PST)
X-Google-Smtp-Source: AK7set9coWPUtSLheaorma3dgyMbSg7MoTxqNt3KtKyykwtN6bNRkYrNVGPELngFdSk7U65m5Hc5Z4Cg9GtbJewyOo8=
X-Received: by 2002:a17:906:338e:b0:895:58be:963 with SMTP id
 v14-20020a170906338e00b0089558be0963mr8232062eja.3.1678231804260; Tue, 07 Mar
 2023 15:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20230306191824.4115839-1-harshit.m.mogalapalli@oracle.com> <ZAb5BlS+OgFfJM6t@corigine.com>
In-Reply-To: <ZAb5BlS+OgFfJM6t@corigine.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 7 Mar 2023 18:29:52 -0500
Message-ID: <CAK-6q+gH-GzRNArVzrkdmrZ20qzGwAXRwhuc8XP0tpdDg3tvXw@mail.gmail.com>
Subject: Re: [PATCH next] ca8210: Fix unsigned mac_len comparison with zero in ca8210_skb_tx()
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Dan Carpenter <error27@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Harry Morris <harrymorris12@gmail.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 7, 2023 at 3:44=E2=80=AFAM Simon Horman <simon.horman@corigine.=
com> wrote:
>
> On Mon, Mar 06, 2023 at 11:18:24AM -0800, Harshit Mogalapalli wrote:
> > mac_len is of type unsigned, which can never be less than zero.
> >
> >       mac_len =3D ieee802154_hdr_peek_addrs(skb, &header);
> >       if (mac_len < 0)
> >               return mac_len;
> >
> > Change this to type int as ieee802154_hdr_peek_addrs() can return negat=
ive
> > integers, this is found by static analysis with smatch.
> >
> > Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device drive=
r")
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>
> I discussed this briefly with Harshit offline.
>
> The commit referenced above tag does add the call to
> ieee802154_hdr_peek_addrs(), an there is a sign miss match between
> the return value and the variable.
>
> The code to check the mac_len was added more recently, by the following
> commit. However the fixes tag is probably fine as-is, because it's fixing
> error handling of a call made in that commit.
>
> 6c993779ea1d ("ca8210: fix mac_len negative array access")
>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>

sure, thanks for catching this.

- Alex

