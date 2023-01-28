Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340CF67F5AB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjA1Hf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjA1HfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:35:18 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64C442ED
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:35:06 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a184so4682067pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fW3AKP8yfyWbCYFiOCYBE5dJ7hHsJnAodp2LEYJn4Vw=;
        b=lHUTyxAC2Z3dGytbZtYbsBvl9Q5AHPnBmnzbboaEFGefm4vt5wGKbo8IDMBRwnkwjX
         Ql1ETUQ1aAgJupasOnE7VG5MGTBA8KaY29TJCitbwbP4jwDIJUiwWV0g1ZTsp40MpP0H
         9rhslHBELGOL/aoi/KnnFBO3YMdv37Q2QI1IUf5fqUXzuofrQYDHKS/CzCF0LYMo8vWZ
         tI3U3CHiJUet3zdcgLjaYB6K6iRuYx1mdMWg/KjwTVgvs/5FZ+7NZ1N9VMrUHHfFraSv
         0/NrRubz/yg0bCdQlPsFqsDCLMrNxCp5Zt7Oe7IUCEPgognUuDqvxYtqGGjHQ7wNb/FP
         Gv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fW3AKP8yfyWbCYFiOCYBE5dJ7hHsJnAodp2LEYJn4Vw=;
        b=10/jWhnngVUUS9pb08+4Whn6W0zr9eT6Ah+CD9tW8AvmFW4ZUEsdmtldXXGlQK4MKB
         16QJXKwL38i88ebmMA4/IvaQFCpwUnFmCtNfvDhhQeRo2LYccpyy1k8qRPxPUN2Brg9L
         klAD67mnbPyotfkemQ+nMcXffkjC91DKWYvL3z2LjaFE4odLyCLN8UgoGSHJHo2w2upL
         9N4SutARDi5zBxHn4vts5YaJlA8FxS4tKSrbjdXwkq79EeKoVGpAO8PRR4KYKRiNXxCs
         BD1K5CmbPmVnBEP3lEwWDuCFnMsPlqWvXMZKa0qugx2gM7YAS/5m/ctKryb88HVituNl
         7+iA==
X-Gm-Message-State: AFqh2kqv0DGswABrcPFt0MncpnY5UkEI19MQGUtrR26aiJ69HE+zKd6A
        ULPXNnqkjVCE7I+4WiAYHetCEUfrWOKvqOFBrkgfog==
X-Google-Smtp-Source: AMrXdXspOko3i9eZbZNNXtK2nv+QW2nyoLWAfoc3slj/hBD5cnlQZhCg4zVode064EjF8sgDDn9uFZGn/bWDqO4Z2F4=
X-Received: by 2002:a63:2153:0:b0:479:45df:425e with SMTP id
 s19-20020a632153000000b0047945df425emr4464587pgm.116.1674891305496; Fri, 27
 Jan 2023 23:35:05 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-9-saravanak@google.com>
 <Y9OcqGTocu8ZlFqy@smile.fi.intel.com>
In-Reply-To: <Y9OcqGTocu8ZlFqy@smile.fi.intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Jan 2023 23:34:28 -0800
Message-ID: <CAGETcx-PiV12pKnVuKyvNcjYbHA=YFJG1QUa-o-G1cL3iMHgcA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] driver core: fw_devlink: Make cycle detection
 more robust
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 1:43 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 26, 2023 at 04:11:35PM -0800, Saravana Kannan wrote:
> > fw_devlink could only detect a single and simple cycle because it relied
> > mainly on device link cycle detection code that only checked for cycles
> > between devices. The expectation was that the firmware wouldn't have
> > complicated cycles and multiple cycles between devices. That expectation
> > has been proven to be wrong.
> >
> > For example, fw_devlink could handle:
> >
> > +-+        +-+
> > |A+------> |B+
> > +-+        +++
> >  ^          |
> >  |          |
> >  +----------+
> >
> > But it couldn't handle even something as "simple" as:
> >
> >  +---------------------+
> >  |                     |
> >  v                     |
> > +-+        +-+        +++
> > |A+------> |B+------> |C|
> > +-+        +++        +-+
> >  ^          |
> >  |          |
> >  +----------+
> >
> > But firmware has even more complicated cycles like:
> >
> >     +---------------------+
> >     |                     |
> >     v                     |
> >    +-+       +---+       +++
> > +--+A+------>| B +-----> |C|<--+
> > |  +-+       ++--+       +++   |
> > |   ^         | ^         |    |
> > |   |         | |         |    |
> > |   +---------+ +---------+    |
> > |                              |
> > +------------------------------+
> >
> > And this is without including parent child dependencies or nodes in the
> > cycle that are just firmware nodes that'll never have a struct device
> > created for them.
> >
> > The proper way to treat these devices it to not force any probe ordering
> > between them, while still enforce dependencies between node in the
> > cycles (A, B and C) and their consumers.
> >
> > So this patch goes all out and just deals with all types of cycles. It
> > does this by:
> >
> > 1. Following dependencies across device links, parent-child and fwnode
> >    links.
> > 2. When it find cycles, it mark the device links and fwnode links as
> >    such instead of just deleting them or making the indistinguishable
> >    from proxy SYNC_STATE_ONLY device links.
> >
> > This way, when new nodes get added, we can immediately find and mark any
> > new cycles whether the new node is a device or firmware node.
>
> ...
>
> > + * Check if @sup_handle or any of its ancestors or suppliers direct/indirectly
> > + * depend on @con.  This function can detect multiple cyles between @sup_handle
>
> A single space is enough.
>
> > + * and @con. When such dependency cycles are found, convert all device links
> > + * created solely by fw_devlink into SYNC_STATE_ONLY device links.  Also, mark
>
> Ditto.
>
> > + * all fwnode links in the cycle with FWLINK_FLAG_CYCLE so that when they are
> > + * converted into a device link in the future, they are created as
> > + * SYNC_STATE_ONLY device links.  This is the equivalent of doing
>
> Ditto.

Lol, you are the king of nit picks :) I don't know how you even notice
these :) I don't like the double spacing either, but as Geert pointed
out, vim inserts them when I use it to auto word-wrap comment blocks.
I'll try to address them as I find them, but I'm not going to send out
revisions of patches just for double spaces.

>
> > + * fw_devlink=permissive just between the devices in the cycle. We need to do
> > + * this because, at this point, fw_devlink can't tell which of these
> > + * dependencies is not a real dependency.
> > + *
> > + * Return true if one or more cycles were found. Otherwise, return false.
>
> Return:

I'm following the rest of the function docs in this file.

>
> (you may run `kernel-doc -v ...` to see all warnings)

Hmmm I ran it on the patch file and it didn't give me anything useful.
Running it on the whole file is just a lot of lines to dig through.

>
> ...
>
> > +static bool __fw_devlink_relax_cycles(struct device *con,
> > +                              struct fwnode_handle *sup_handle)
> > +{
> > +     struct fwnode_link *link;
> > +     struct device_link *dev_link;
>
> > +     struct device *sup_dev = NULL, *par_dev = NULL;
>
> You can put it the first line since it's long enough.

Wait, is that a style guideline to have the longer lines first?

> But why do you need sup_dev assignment?

Defensive programming I suppose. I can see this function being
refactored in the future where a goto out; is inserted before sup_dev
is assigned. And then the put_device(sup_dev) at "out" will end up
operating on some junk value and causing memory corruption.

>
> > +     bool ret = false;
> > +
> > +     if (!sup_handle)
> > +             return false;
> > +
> > +     /*
> > +      * We aren't trying to find all cycles. Just a cycle between con and
> > +      * sup_handle.
> > +      */
> > +     if (sup_handle->flags & FWNODE_FLAG_VISITED)
> > +             return false;
> > +
> > +     sup_handle->flags |= FWNODE_FLAG_VISITED;
>
> > +     sup_dev = get_dev_from_fwnode(sup_handle);
> > +
>
> I would put it closer to the condition:
>
> > +     /* Termination condition. */
> > +     if (sup_dev == con) {
>
>         /* Get supplier device and check for termination condition */
>         sup_dev = get_dev_from_fwnode(sup_handle);
>         if (sup_dev == con) {

I put it the way it is because sup_dev is used for more than just
checking for termination condition.

>
> > +             ret = true;
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * If sup_dev is bound to a driver and @con hasn't started binding to
> > +      * a driver, @sup_dev can't be a consumer of @con.  So, no need to
>
> sup_dev or @sup_dev? What's the difference? Should you spell one of them
> in full?

Probably copy-pasta from a function doc. I'll make it sup_dev.

>
> > +      * check further.
> > +      */
> > +     if (sup_dev && sup_dev->links.status ==  DL_DEV_DRIVER_BOUND &&
>
> As in the comment above, the single space is enough.
>
> > +         con->links.status == DL_DEV_NO_DRIVER) {
> > +             ret = false;
> > +             goto out;
> > +     }
> > +
> > +     list_for_each_entry(link, &sup_handle->suppliers, c_hook) {
> > +             if (__fw_devlink_relax_cycles(con, link->supplier)) {
> > +                     __fwnode_link_cycle(link);
> > +                     ret = true;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * Give priority to device parent over fwnode parent to account for any
> > +      * quirks in how fwnodes are converted to devices.
> > +      */
>
> > +     if (sup_dev) {
> > +             par_dev = sup_dev->parent;
> > +             get_device(par_dev);
> > +     } else {
> > +             par_dev = fwnode_get_next_parent_dev(sup_handle);
> > +     }
>
>         if (sup_dev)
>                 par_dev = get_device(sup_dev->parent);
>         else
>                 par_dev = fwnode_get_next_parent_dev(sup_handle);

Ack, thanks. Makes it nicer.

>
> > +     if (par_dev)
> > +             ret |= __fw_devlink_relax_cycles(con, par_dev->fwnode);
>
> Instead I would rather do a similar pattern of the ret assignment as elsewhere
> in the function.
>
>         if (par_dev && __fw_devlink_relax_cycles(con, par_dev->fwnode))
>                 ret = true;

Ack. Good suggestion!

>
> > +     if (!sup_dev)
> > +             goto out;
> > +
> > +     list_for_each_entry(dev_link, &sup_dev->links.suppliers, c_node) {
> > +             /*
> > +              * Ignore a SYNC_STATE_ONLY flag only if it wasn't marked as a
> > +              * such due to a cycle.
> > +              */
> > +             if (device_link_flag_is_sync_state_only(dev_link->flags) &&
> > +                 !(dev_link->flags & DL_FLAG_CYCLE))
> > +                     continue;
> > +
> > +             if (__fw_devlink_relax_cycles(con,
> > +                                           dev_link->supplier->fwnode)) {
>
> Keep it on one line.

It'll make it > 80. Is this some recent change about allowing > 80
cols? I'm leaving it as is for now.


> > +                     fw_devlink_relax_link(dev_link);
> > +                     dev_link->flags |= DL_FLAG_CYCLE;
> > +                     ret = true;
> > +             }
> > +     }
> > +
> > +out:
> > +     sup_handle->flags &= ~FWNODE_FLAG_VISITED;
> > +     put_device(sup_dev);
> > +     put_device(par_dev);
> > +     return ret;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
