Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930D765C9CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjACW4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjACW43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:56:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED9E13F3C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 14:56:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n12so21515850pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 14:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZEylp7JTr0brPtSD6hZ7uhRxA273x3NUFuspWQs1m4=;
        b=TQLEOFTQTj+KZwAxUqt/0oEa6lmrEGxDhB7Ix4pS1zt89P2oBC64rmOEiHS6uZiO4j
         sh5NIX1QfjK0kwesYp2FlowNsq3BcncOVGxMpiZ14nwL5n6YzMRkkMJyvg6pfQnjICi8
         hEAWQgzWSkyGoproxanROSPL4+dIIPyp9US1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZEylp7JTr0brPtSD6hZ7uhRxA273x3NUFuspWQs1m4=;
        b=UWO3YSpsFTvSfoIkyXndOYLPat5xrnaQgClI5vlPGnrJmBIIjLamhixhR+6EcsoKta
         j4yI+Jyiv/SP3JHMqSZY9hMyaeuV/1VH2u/cEPIqwzBtZKel1PFqZw9cdGADP+BCzkEo
         U99yyQO3znu4hlDjzy2r+mL//Ztr8dA89ug4cTTiKtXrPkb5lrZKQxN+wAPU9zpPmcD4
         1g3jN6D9TSjtAMXoczEBQJTIvgJWcdhhkMQ4V7AhkUhiWiA3610FcJZuAdhVdcNSLg11
         DhQh+5AlFbg9MGLTecpypNvgU6w8ylbKwDNOVvZjStAow3wCFGhePurJgqAOa6IlTGa5
         4pOA==
X-Gm-Message-State: AFqh2kqQD+NBtJGIzkJdVxEBCKUcyXeR78R/Ss88DWHFgK5OQ8PRPhTf
        1sTOM6fgNYfZa5fBXv7nmpPWT/W7Hz6zEu79
X-Google-Smtp-Source: AMrXdXsRnDW5RBGhUE/v4Ks1QYwdD4bJZf07i4OvgY/i+WmOoJKAp1x/oTL19hP8w3LGc9DcpxXrYQ==
X-Received: by 2002:a17:902:d3c9:b0:190:eec0:9fe3 with SMTP id w9-20020a170902d3c900b00190eec09fe3mr53940916plb.48.1672786587555;
        Tue, 03 Jan 2023 14:56:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001891a17bd93sm2048391plg.43.2023.01.03.14.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 14:56:26 -0800 (PST)
Date:   Tue, 3 Jan 2023 14:56:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Julius Werner <jwerner@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>, coreboot@coreboot.org
Subject: Re: memcpy: detected field-spanning write (size 168) of single field
 "&device->entry" at drivers/firmware/google/coreboot_table.c:103 (size 8)
Message-ID: <202301031447.991A623A61@keescook>
References: <03ae2704-8c30-f9f0-215b-7cdf4ad35a9a@molgen.mpg.de>
 <CAODwPW8=1R53Dir+CFHu-NADygCZVqDjsg0q+xT-KheZHghxtw@mail.gmail.com>
 <CABXOdTcvBe5PzO6RrUDC-NcYpWYuabZkN1qXA=gSqbhPHLxqsw@mail.gmail.com>
 <Y7SCdrL+xZm5CSjy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7SCdrL+xZm5CSjy@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:31:02AM -0800, Brian Norris wrote:
> On Thu, Dec 29, 2022 at 12:28:14PM -0800, Guenter Roeck wrote:
> > On Thu, Dec 29, 2022 at 6:43 AM Julius Werner <jwerner@chromium.org> wrote:
> > >
> > > I can confirm that this warning is a false positive, at least. We're
> > > intentionally copying bytes from beyond the end of the header
> > > structure in this case.
> > >
> > > I don't know what kind of kernel system detects this stuff at runtime
> > > and how to silence it. Probably need to add a void pointer cast or
> > > something?
> > >
> > 
> > This is part of kernel hardening code. Kees Cook might know what to do about it.
> 
> One could probably throw in casts, like this example did:
> 
>   0d043351e5ba ext4: fix fortify warning in fs/ext4/fast_commit.c:1551
> 
> Or one could probably imitate this example, and insert an appropriate
> flexible array (possibly with yet another union?):
> 
>   b43088f30db1 s390/zcrypt: fix warning about field-spanning write

Hi!

Just catching up on this now that I'm back from break. This looks like
it might be easiest to split the copy up as done in some other places.
This'll need some small changes to the struct. For example, adding a
"data" flexible array member:

struct coreboot_table_entry {
	u32 tag;
	u32 size;
	u8  data[];
};

> 
> Side mostly-unrelated note: coreboot_table_populate() doesn't do any
> bounds checking that the individual entry copies don't overflow the
> table buffer size. We're _probably_ not that interested in recovering
> from a malicious (or even buggy) Coreboot, but it does seem like an area
> of improvement.

Right -- there's no bounds checking in this code that I could find.
Though, yes, the "attack surface" is pretty small in the sense that it's
parsing system resources. But adding sanity checking seems like it'd be
a nice addition, as you say. How about something like this:


diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 37f4d335a606..2a2cea79204b 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -29,6 +29,7 @@ struct coreboot_table_header {
 struct coreboot_table_entry {
 	u32 tag;
 	u32 size;
+	u8 data[];	/* Size here is: "size - (sizeof(u32) * 2)" */
 };
 
 /* Points to a CBMEM entry */
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 2652c396c423..f49f5a602b6b 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -93,6 +93,11 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 	for (i = 0; i < header->table_entries; i++) {
 		entry = ptr_entry;
 
+		if (entry->size < sizeof(*entry)) {
+			dev_warn(dev, "coreboot table entry too small!\n");
+			return -EINVAL;
+		}
+
 		device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
 		if (!device)
 			return -ENOMEM;
@@ -100,7 +105,9 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
-		memcpy(&device->entry, ptr_entry, entry->size);
+		device->entry = *ptr_entry;
+		memcpy(device->entry.data, ptr_entry->data,
+		       entry->size - sizeof(*entry));
 
 		switch (device->entry.tag) {
 		case LB_TAG_CBMEM_ENTRY:


-Kees

> Brian
> 
> > 
> > Guenter
> > 
> > > On Thu, Dec 29, 2022 at 11:46 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > > >
> > > > Dear Linux folks,
> > > >
> > > >
> > > > Running Linux v6.2-rc1+ on a motherboard using coreboot as firmware, the
> > > > warning below is shown.
> > > >
> > > > ```
> > > > [    1.630244] ------------[ cut here ]------------
> > > > [    1.630249] memcpy: detected field-spanning write (size 168) of
> > > > single field "&device->entry" at
> > > > drivers/firmware/google/coreboot_table.c:103 (size 8)
> > > > [    1.630299] WARNING: CPU: 1 PID: 150 at
> > > > drivers/firmware/google/coreboot_table.c:103
> > > > coreboot_table_probe+0x1ea/0x210 [coreboot_table]
> [...]

-- 
Kees Cook
