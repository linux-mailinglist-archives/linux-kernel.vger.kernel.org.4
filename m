Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED0E6BEBBA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCQOus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCQOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10585474D3;
        Fri, 17 Mar 2023 07:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6F19609FF;
        Fri, 17 Mar 2023 14:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45A4C433D2;
        Fri, 17 Mar 2023 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679064644;
        bh=GT28tLmtkIV7FEf1iW5WPFPzdPPVpoWi4Qnl8xxtFnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N57XavNYH1LP6ZoEhNaKI4l7RSjQoPlB6DyGV8SYIa/x1PDZU+jgd5Fa/wK0MyH5h
         dzrE/WSSGpNOgNE0nMXZkKGu0sjz0q78bKvxXWAygeh/ghV0KgtSdvfqAbkQNX8vcD
         Z2tLCfA1BBRT/5GohlWDALSYj/kSbx6+c8HBgQus=
Date:   Fri, 17 Mar 2023 15:50:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 02/36] ACPI: LPIT: move to use bus_get_dev_root()
Message-ID: <ZBR+PdQ4MIdivUeC@kroah.com>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-2-gregkh@linuxfoundation.org>
 <CAJZ5v0goaS5O1_Hds2DnWsw_G-Dg4fU9NEY0=chyn5ECTcBmDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0goaS5O1_Hds2DnWsw_G-Dg4fU9NEY0=chyn5ECTcBmDw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:43:22PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 13, 2023 at 7:29 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Direct access to the struct bus_type dev_root pointer is going away soon
> > so replace that with a call to bus_get_dev_root() instead, which is what
> > it is there for.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Note, this is a patch that is a prepatory cleanup as part of a larger
> > series of patches that is working on resolving some old driver core
> > design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> > its own, but I'd prefer if I could take it through my driver-core tree
> > so that the driver core changes can be taken through there for 6.4-rc1.
> >
> >  drivers/acpi/acpi_lpit.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> > index 3843d2576d3f..73b5c4800150 100644
> > --- a/drivers/acpi/acpi_lpit.c
> > +++ b/drivers/acpi/acpi_lpit.c
> > @@ -98,6 +98,8 @@ EXPORT_SYMBOL_GPL(lpit_read_residency_count_address);
> >  static void lpit_update_residency(struct lpit_residency_info *info,
> >                                  struct acpi_lpit_native *lpit_native)
> >  {
> > +       struct device *dev_root = bus_get_dev_root(&cpu_subsys);
> > +
> 
> This can return here right away if dev_root is NULL, because it will
> not do anything useful in that case anyway.

Thanks for the review of these, I'll redo some of them and send out a
v2 of them next week.

greg k-h
