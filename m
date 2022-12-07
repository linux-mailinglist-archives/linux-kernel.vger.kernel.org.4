Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC41645CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiLGObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLGOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:30:56 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809D2C1;
        Wed,  7 Dec 2022 06:30:55 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id i12so12736951qvs.2;
        Wed, 07 Dec 2022 06:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfJ7juuz7Ryq2gBRSh+TE4rPx2k8D+cEUA0AQUke7aI=;
        b=bwDXUKF93BGLJZD0Kh9NZR5Mcp2A/Cq3D18+Cgo6uaU5bNns9UjDQufqQqoxWb9xH+
         lWEI+Vx8mCibQUD2iadYdO2YMk6hwgUqEOMAE5aG8CObn6YBYz1b+ENS1TjT6aUt5wRo
         EkeEFDKaFLVozchxhLl1raUjYhxwGDClDHmuer5q40+hJ3Un+zOIXST+nUaxg8wHu8cB
         RaivLQCrPBqo1LMroU6Tiwsu+p8GLzm9mLTFrVJkB9uluQGKvI+YrTr2jgeIVM2OjN7B
         979IHNfEly1blj52crhV5+CHkpGPBIMUzGZF9MC8M8Xu4pKN/w6NzwNfPbnpF+kT1xMj
         04Ig==
X-Gm-Message-State: ANoB5pmdnA9My1oyuwZlJEnNUxj9doCdKlGyopWdAC9sGa4uvB7W08nm
        LftaU6ToMA5bL0H2tgqkM2qwRyBg7D7Jsx7m2Oo=
X-Google-Smtp-Source: AA0mqf5CH1LldVknMmPiAOl4Y7lZZGFneSb+fPnltCoLIy1BXWcECiva/yE+Hq/5Uitog6jsJsGSWxjKez12MfjcKuU=
X-Received: by 2002:a05:6214:2b90:b0:4c7:27cf:dfca with SMTP id
 kr16-20020a0562142b9000b004c727cfdfcamr26090351qvb.3.1670423454756; Wed, 07
 Dec 2022 06:30:54 -0800 (PST)
MIME-Version: 1.0
References: <20221207112219.2652411-1-linmq006@gmail.com> <Y5CFVHL0xTeWbKfU@paasikivi.fi.intel.com>
In-Reply-To: <Y5CFVHL0xTeWbKfU@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 15:30:43 +0100
Message-ID: <CAJZ5v0hWhY5ZG+jYR8BfxTfwgwYKkOP33K4+Qc7FJeMheQQcEA@mail.gmail.com>
Subject: Re: [PATCH] device property: Fix documentation for fwnode_get_next_parent()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 1:21 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Wed, Dec 07, 2022 at 03:22:18PM +0400, Miaoqian Lin wrote:
> > Use fwnode_handle_put() on the node pointer to release the refcount.
> > Change fwnode_handle_node() to fwnode_handle_put().
> >
> > Fixes: 233872585de1 ("device property: Add fwnode_get_next_parent()")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>
> Thanks!
>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

So I'm assuming that Greg will pick up this one or please let me know otherwise.

> > ---
> >  drivers/base/property.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 2a5a37fcd998..daa1e379762b 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -601,7 +601,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
> >   * node's parents.
> >   *
> >   * Returns a node pointer with refcount incremented, use
> > - * fwnode_handle_node() on it when done.
> > + * fwnode_handle_put() on it when done.
> >   */
> >  struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
> >  {
>
> --
