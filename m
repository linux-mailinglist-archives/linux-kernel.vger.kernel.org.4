Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1E62EB90
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiKRCBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKRCBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:01:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA85786CD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:01:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E9CEB82264
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78411C433D7;
        Fri, 18 Nov 2022 02:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668736868;
        bh=NI+ThJ1IGK19Iit3qvb9g0K7eh5Yy44Q4BXLgtbQeKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbrDxSzQhO7W1h02c2ggEyLF+JxyQbFDT0W2ocUShnVz78k5LqU8MaD9ELJsvCHh0
         lX8Pldh0AuhNDjKkDLwcD1D8GRmDhVGFwuXpc10BRwpEQXNc6nWMM7UmphgzcqYouu
         jKQt2GMPjFEeZ87lOYNIGV5Ldfx0uEUYfBCJ3VoNRZyzQevvbSKGRMBbgYTxyVDtBu
         hHsE86pRMGX8XBrcAiS8CK7qKUYRdv16NwIfAEmpnjEJZG/jKvoKCnkIQFAPswGwj9
         4FSlbUn/vJo2hg/yBtsiMBz0G1NTL+GSPi5VF3UmgDgqvU8N3bCJre6WBqfNz7qp97
         8uZGtdvFxHL8A==
Date:   Fri, 18 Nov 2022 10:01:05 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     dtor@chromium.org, jwerner@chromium.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 1/1] platform/chrome: Poke kb_wake_angle attribute
 visibility when needed
Message-ID: <Y3bnYT6TXGXhkh/T@google.com>
References: <20210804213139.4139492-1-gwendal@chromium.org>
 <20210804213139.4139492-2-gwendal@chromium.org>
 <CAPUE2usQX_uQewpCYOs3SRUo7vDDMfg=n7idNvCgThDHMqTf7w@mail.gmail.com>
 <CAPUE2uuj1qde16QWHb=0+yMW3ERhXzV7ehGcViWCfij7ADeyWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUE2uuj1qde16QWHb=0+yMW3ERhXzV7ehGcViWCfij7ADeyWg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:23:38AM -0800, Gwendal Grignou wrote:
> [+chrome-platform@lists.linux.dev]

Please also Cc to the mailing list if the patch gets chance to have
next version.

> On Mon, Nov 14, 2022 at 8:10 PM Gwendal Grignou <gwendal@chromium.org> wrote:
[...]
> > > Expose the attribute group to alter to close a potiential race between
> > > cros-ec-sensorhub and cros-ec-sysfs (that creates the attribute group
> > > on behalf of the class driver).

I failed to realize the potential race.  Could you explain it a bit?

> > > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > > index 02599687770c5..c6dca260bbd5d 100644
> > > --- a/include/linux/platform_data/cros_ec_proto.h
> > > +++ b/include/linux/platform_data/cros_ec_proto.h
> > > @@ -191,6 +191,7 @@ struct cros_ec_platform {
> > >  /**
> > >   * struct cros_ec_dev - ChromeOS EC device entry point.
> > >   * @class_dev: Device structure used in sysfs.
> > > + * @groups: sysfs attributes groups for this EC.

The field name has extra "s".
