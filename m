Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B91C641A9F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 04:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiLDDgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 22:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiLDDgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 22:36:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1491ADAC
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 19:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E5QQSoeIX5YB36fGmBD3W6b+AEdc0b114wsH8QULJUI=; b=Hzb7IjQGjdW8tPmAesIUoX4UO4
        BnJy7j4FVIKRvUujH4qh9pxd4BwVe1Hwlwq2ul69A5cwsiT2qOGIIPm2k7MJLPLGQaMhfnpgNAttP
        4VhkFYkfLcJ5O45p1k1en7/KqLtQzHoh0qUzI4AX7OZIvpXuhzoDPRSsTZnqVVQC1+IvzMKahkXK6
        Ryl76zZRCsGK6ChYnxFrbw844tYMvWJ8DQvjpYFw52vAoLchf21klncOqDpnU05fkRr3oLxpJGP+6
        Q0XIXqa8PW4huyN1r8UD0MnUbtWvyRwhMXXW71X4BmJstekMRVCH1bhmVJMP4PvVAkLyTDY5BDjSS
        gBWTHbdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p1fnv-008qje-0D;
        Sun, 04 Dec 2022 03:36:35 +0000
Date:   Sun, 4 Dec 2022 03:36:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zopolis0 <creatorsmithmdt@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: PATCH [1/2] gamecube/wii: graphic quantization registers driver
 (GQR)
Message-ID: <Y4wVwz6kC3ThL2Jg@ZenIV>
References: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 02:06:06PM +1100, Zopolis0 wrote:

> +static u32 gqr_values[8];
> +static struct ctl_table_header *gqr_table_header;
> +
> +#define SPR_GQR0 912
> +#define SPR_GQR1 913
> +#define SPR_GQR2 914
> +#define SPR_GQR3 915
> +#define SPR_GQR4 916
> +#define SPR_GQR5 917
> +#define SPR_GQR6 918
> +#define SPR_GQR7 919
> +
> +#define MFSPR_CASE(i) case (i): (*((u32 *)table->data) = mfspr(SPR_GQR##i))
> +#define MTSPR_CASE(i) case (i): mtspr(SPR_GQR##i, *((u32 *)table->data))
> +
> +static int proc_dogqr(ctl_table *table, int write, struct file *file,
> +       void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> + int r;
> +
> + if (!write) { /* if they are reading, update the variable */
> + switch (table->data - (void *)gqr_values) {

That looks very fishy.  First of all, you clearly have table->data set
(by DECLARE_GQR below) to gqr_values + <interger from 0 to 7>.  Trivial
C quiz: what would the value of
	(void *)(gqr_values + 7) - (void *)gqr_values
be, if gqr_values is declared as an array of unsigned int?

	IOW, the values in that switch are wrong.  If anything,
you want (u32 *)table->data - gqr_values.  What's more, SPR_GQR<n>
is simply 912 + n, innit?  So all the crap with switches and ##
is pointless - that thing should simply be

	unsigned reg = (u32 *)table->data - gqr_values;
	
	if (WARN_ON_ONCE(reg > 7))
		return -EINVAL;

	if (!write)
		gqr_values[reg] = mfspr(SPR_GQR0 + reg);

	r = proc_dointvec(table, write, buffer, lenp, ppos);

	if (!r && write) /* if they are writing, update the reg */
		mtspr(SPR_GQR0 + reg, gqr_values[reg]);

	return r;
