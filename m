Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153BD6F5091
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjECHEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjECHEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA64E269D;
        Wed,  3 May 2023 00:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A8160AF8;
        Wed,  3 May 2023 07:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA42C433EF;
        Wed,  3 May 2023 07:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683097482;
        bh=M0BKie22cDJLEmh+DW1hFkVbxx3BKs6v3GQgOxwOC1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=akIxmMM83ZB7scSmRZabtnBDF9G9XAKAY+Apri/LWfcfuxEo7vOzWAjEdK6J49uqy
         4NQpck+EzQRCVS5oBNJzbFCUkmOGhaLuR+3JxZHzabUu5RPbIMMA4Jk9ar+O2SlULV
         Yy3nelM0+CZr4sAlUkbo0ugEc1qdsKMWvQGrkIgpojwEIRxsZqt8QGvw6GoDixE/fP
         Kd0G8XunzTC47/LiWrcWmcP3eUiM8jqK5/wfo/0s+ASN//phlEGvWQHWuF7AHnadyL
         26PupfT3VPijmSYy65DCZNMDvsi8rPSj5+lOc3MqhI8I8Y+TEmHHGlSBflyv6Z9czG
         EhywdUTYAeYhA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pu6Xf-0007Og-E0; Wed, 03 May 2023 09:04:47 +0200
Date:   Wed, 3 May 2023 09:04:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: fix debugfs registration
Message-ID: <ZFIHj9OAJkRvSscs@hovoldconsulting.com>
References: <20230424124852.12625-1-johan+linaro@kernel.org>
 <20230424124852.12625-2-johan+linaro@kernel.org>
 <CABBYNZLBQjWVb=z8mffi4RmeKS-+RDLV+XF8bR2MiJ-ZOaFVHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLBQjWVb=z8mffi4RmeKS-+RDLV+XF8bR2MiJ-ZOaFVHA@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 04:37:51PM -0700, Luiz Augusto von Dentz wrote:
> Hi Johan,
> 
> On Mon, Apr 24, 2023 at 5:50 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Since commit ec6cef9cd98d ("Bluetooth: Fix SMP channel registration for
> > unconfigured controllers") the debugfs interface for unconfigured
> > controllers will be created when the controller is configured.
> >
> > There is however currently nothing preventing a controller from being
> > configured multiple time (e.g. setting the device address using btmgmt)
> > which results in failed attempts to register the already registered
> > debugfs entries:
> >
> >         debugfs: File 'features' in directory 'hci0' already present!
> >         debugfs: File 'manufacturer' in directory 'hci0' already present!
> >         debugfs: File 'hci_version' in directory 'hci0' already present!
> >         ...
> >         debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!
> >
> > Add a controller flag to avoid trying to register the debugfs interface
> > more than once.
> >
> > Fixes: ec6cef9cd98d ("Bluetooth: Fix SMP channel registration for unconfigured controllers")
> > Cc: stable@vger.kernel.org      # 4.0
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---

> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 632be1267288..a8785126df75 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -4501,6 +4501,9 @@ static int hci_init_sync(struct hci_dev *hdev)
> >             !hci_dev_test_flag(hdev, HCI_CONFIG))
> >                 return 0;
> >
> > +       if (hci_dev_test_and_set_flag(hdev, HCI_DEBUGFS_CREATED))
> > +               return 0;
> 
> Can't we just use HCI_SETUP like we do with in create_basic:
> 
>     if (hci_dev_test_flag(hdev, HCI_SETUP))
>         hci_debugfs_create_basic(hdev);
> 
> Actually we might as well move these checks directly inside the
> hci_debugfs function to make sure these only take effect during the
> setup/first init.

The problem is that commit ec6cef9cd98d ("Bluetooth: Fix SMP channel
registration for unconfigured controllers") started deferring creation
of most parts of the debugfs interface until the controller is
configured (e.g. as some information is not available until then).

Moving everything back to setup-time would effectively revert that.

Perhaps the interface can be changed in some way so that everything is
again registered at setup-time (e.g. with placeholder values instead of
conditionally created attributes), but that would at least not be
something that we could backport.

> >         hci_debugfs_create_common(hdev);
> >
> >         if (lmp_bredr_capable(hdev))

Johan
